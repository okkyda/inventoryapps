const categoryController = require("../controllers/category.controller");
const express = require("express");
const router = express.Router();

// Create 
router.post("/categories", categoryController.create);

// Retrieve all 
router.get("/all", categoryController.findAll);

// Retrieve a single Category with id
router.get("/find/:id", categoryController.findOne);

// Update a Category with id
router.put("/update/:id", categoryController.update);

// // Delete a Category with id
router.delete("/delete/:id", categoryController.delete);

module.exports = router;