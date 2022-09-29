const express = require("express");
const db = require("./db-config.js");
const cors = require("cors");
const app = express();
const port = process.env.PORT || 3000;
const router = require("./routes/users.routes.js");
app.use(express.json());
app.use(cors());
app.use(
  express.urlencoded({
    extended: true,
  })
);

app.use("/api", router);

// create table
sql = `CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, birthdate DATETIME, created_at DATETIME DEFAULT CURRENT_TIMESTAMP)`;
db.run(sql);

// sql = `DROP TABLE IF EXISTS users`;
// db.run(sql);


app.listen(port, () => {
  console.log(`Express app listening on port ${port}!`);
});
