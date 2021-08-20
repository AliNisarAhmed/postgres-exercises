const pool = require("../pool.js");
const toCamelCase = require("./utils/to-camel-case.js");

async function find() {
  const result = await pool.query(`
    SELECT * FROM users;
    `);

  return toCamelCase(result.rows);
}

async function findById(id) {
  const { rows } = await pool.query(`
    SELECT * FROM users WHERE id = ${id}
    `);

  return toCamelCase(rows)[0];
}

module.exports = { find, findById };
