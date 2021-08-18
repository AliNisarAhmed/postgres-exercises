const express = require("express");
const pg = require("pg");

const pool = new pg.Pool({
  host: "localhost",
  post: 5432,
  database: "socialnetwork",
  user: "postgres",
  password: "abc123",
});

const app = express();

app.use(express.urlencoded({ extended: true }));

app.get("/posts", async (req, res) => {
  const { rows } = await pool.query(`
    SELECT * FROM public.posts;
    `);

  console.log("rows: ", rows);

  res.send(`
    <table>
      <thead>
        <tr>
          <th>id</th>
          <th>lng</th>
          <th>lng</th>
        </tr> 
      </thead>
      <tbody>
        ${rows
          .map((row) => {
            return `
            <tr>
              <td>${row.id}</td>
              <td>${row.loc.x}</td>
              <td>${row.loc.y}</td>
            </tr>
          `;
          })
          .join("")}
      </tbody>
    </table>
    <form method="POST">
      <h3>Create Post</h3>
      <div>
        <label>Lng</label>
        <input name="lng" />
      </div>
      <div>
        <label>Lat</label>
        <input name="lat" />
      </div>
      <button type="submit">Create</button>
    </form>
    `);
});

app.post("/posts", async (req, res) => {
  const { lng, lat } = req.body;

  await pool.query("INSERT INTO posts (loc) VALUES ($1)", [`(${lng},${lat})`]);

  res.redirect("/posts");
});

app.listen(3005, () => console.log("Listening on 3005"));
