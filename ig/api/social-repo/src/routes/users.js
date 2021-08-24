const express = require("express");
const UserRepo = require("../repos/user-repo.js");
const toCamelCase = require("../repos/utils/to-camel-case.js");

const router = express.Router();

router.get("/users", async (req, res) => {
  const users = await UserRepo.find();

  res.send(users);
});

router.get("/users/:id", async (req, res) => {
  const { id } = req.params;

  const user = await UserRepo.findById(id); 

  if (user) {
    return res.send(user);
  } else {
    return res.sendStatus(404);
  }
});

router.post("/users", async (req, res) => {
  const { username, bio } = req.body;

  const user = await UserRepo.insert(username, bio);

  if (user) {
    res.send(user);
  }

  res.sendStatus(404);

});

router.put("/users", async (req, res) => {
  const { id } = req.params;
  const { username, bio } = req.body; 

  const user = await UserRepo.update(id, username, bio);

  res.send(user);
});

router.delete("/users/:id", async (req, res) => {
  const { id } = req.params; 

  const user = await UserRepo.deleteById(id);

  if (user) {
    return res.send(user);
  }

  res.sendStatus(404);
});

module.exports = router;
