const pool = require("../pool.js");
const toCamelCase = require("./utils/to-camel-case.js");

async function find() {
  const result = await pool.query(`
    SELECT * FROM users;
    `);

  return toCamelCase(result.rows);
}

async function findById(id) {
  const { rows } = await pool.query(
    `
    SELECT * FROM users WHERE id = $1
    `,
    [id]
  );

  return toCamelCase(rows)[0];
}

async function insert(username, bio) {
  const { rows } = await pool.query(
    `INSERT INTO users (username, bio) VALUES ($1, $2) RETURNING *`,
    [username, bio]
  );

  return toCamelCase(rows)[0];
}

async function update(id, username, bio) {
  const { rows } = await pool.query(
    `UPDATE users SET username = $1, bio = $2 WHERE id = $3 RETURNING *`,
    [username, bio, id]
  );

  return toCamelCase(rows)[0];
}

async function deleteById(id) {
  const { rows } = await pool.query(
    `DELETE FROM users WHERE id = $1 RETURNING *`,
    [id]
  );

  return toCamelCase(rows)[0];
}

async function count() {
  const { rows } = await pool.query(`SELECT COUNT(*) FROM users;`);

  return Number(rows[0].count);
}

module.exports = { find, findById, insert, update, deleteById, count };
