const sqlite3 = require("sqlite3").verbose();

// connect to database
const db = new sqlite3.Database(
  "./assurlydb.db",
  sqlite3.OPEN_READWRITE,
  (err) => {
    if (err) {
      console.error(err.message);
    }
    console.log("Connected to the sqlite database.");
  }
);

module.exports = db;
