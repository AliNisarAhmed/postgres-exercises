const { randomBytes } = require("crypto");
const format = require("pg-format");
const { default: migrate } = require("node-pg-migrate");
const pool = require("../pool.js");

const DEFAULT_OPTS = {
  host: "localhost",
  port: 5432,
  database: "socialnetwork-test",
  user: "postgres",
  password: "abc123",
};

class Context {
  constructor(roleName) {
    this.roleName = roleName;
  }

  static async build() {
    // Randomly generating a role name to connect to PG as

    const roleName = "a" + randomBytes(4).toString("hex");

    // Connect to PG as usual

    await pool.connect({
      host: "localhost",
      port: 5432,
      database: "socialnetwork-test",
      user: "postgres",
      password: "abc123",
    });

    // Create a new role

    await pool.query(
      format("CREATE ROLE %I WITH LOGIN PASSWORD %L;", roleName, roleName)
    );

    // Create a schema with the same name

    await pool.query(
      format("CREATE SCHEMA %I AUTHORIZATION %I", roleName, roleName)
    );
    //
    // Disconnect entirely from PG

    await pool.close();

    // Run migrations inside of the new schema

    await migrate({
      schema: roleName,
      direction: "up",
      log: () => {},
      noLock: true, // dont lock up the database when running migrations
      dir: "migrations",
      databaseUrl: {
        host: "localhost",
        port: 5432,
        database: "socialnetwork-test",
        user: roleName,
        password: roleName,
      },
    });

    // Connect to PG as the newly created Role
    await pool.connect({
      host: "localhost",
      port: 5432,
      database: "socialnetwork-test",
      user: roleName,
      password: roleName,
    });

    return new Context(roleName);
  }

  async close() {
    await pool.close();

    await pool.connect(DEFAULT_OPTS);

    await pool.query(format("DROP SCHEMA %I CASCADE;", this.roleName));

    await pool.query(format("DROP ROLE %I;", this.roleName));

    await pool.close();
  }

  async reset() {
    return pool.query(`DELETE FROM users`);
  }
}

module.exports = Context;
