const pg = require("pg");

const pool = new pg.Pool({
  host: "localhost",
  post: 5432,
  database: "socialnetwork",
  user: "postgres",
  password: "abc123",
});

pool
  .query(
    `
  UPDATE posts 
  SET loc = POINT(lng, lat) 
  WHERE loc IS NULL
`
  )
  .then(() => {
    console.log("Update completed");
    pool.end();
  })
  .catch((err) => console.log(err));
