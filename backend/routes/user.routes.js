const userControlller = require("../controllers/user.controller");

const express = require("express");
const router = express.Router();

router.post("/register",userControlller.register);
router.post('/login',userControlller.login);
router.get('/user-profile',userControlller.userProfile);

module.exports = router;

