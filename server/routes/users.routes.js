const router = require("express").Router();
const db = require("../db-config.js");


// GET all users
router.get("/users", (req, res) => {
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


// CREATE a new user
router.post("/users", (req, res) => {
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

module.exports = router;
