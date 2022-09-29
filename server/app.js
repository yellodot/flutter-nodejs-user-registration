const express = require("express");
const sqlite3 = require("sqlite3").verbose();
const cors = require("cors");
const app = express();
const port = process.env.PORT || 3000;
app.use(express.json());
app.use(cors());
app.use(
  express.urlencoded({
    extended: true,
  })
);

// connect to database
const db = new sqlite3.Database(
  "./assurlydb.db",
  sqlite3.OPEN_READWRITE,
  (err) => {
    if (err) {
      console.error(err.message);
    }
    console.log("Connected to the database.");
  }
);

// create table
// sql = `CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, birthdate DATETIME, created_at DATETIME DEFAULT CURRENT_TIMESTAMP)`;
// db.run(sql);
// drop table
// sql = `DROP TABLE users`;

// send data to client
app.get("/api/users", (req, res) => {
  sql = `SELECT * FROM users`;
  try {
    db.all(sql, (err, rows) => {
      if (err) {
        res.status(400).json({ error: err.message });
        return;
      }
      if (rows.length === 0)
        return res.status(404).json({ error: "No users found" });
      res.status(200).json(rows);
    });
  } catch (error) {
    console.log(error);
  }
});

app.post("/api/users", (req, res) => {
  try {
    const user = {
      firstname: req.body.firstname,
      lastname: req.body.lastname,
      birthdate: req.body.birthdate,
    };
    sql = `INSERT INTO users (firstname, lastname, birthdate) VALUES (?, ?, ?)`;
    db.run(
      sql,
      [user.firstname, user.lastname, user.birthdate],
      function (err) {
        if (err) {
          return console.log(err.message);
        }
        res.status(201).json({ message: "User added successfully" });
        console.log(`A user was successfully created`);
      }
    );
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

app.listen(port, () => {
  console.log(`Express app listening on port ${port}!`);
});
