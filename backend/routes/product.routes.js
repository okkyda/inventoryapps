const productsController = require("../controllers/products.controller");
const express = require("express");
const router = express.Router();

// Create a new Product
router.post("/make", productsController.create); // Menggunakan "/" bukan "/products"

// Retrieve all Products
router.get("/all", productsController.findAll);

// Retrieve a single Product with id
router.get("/find/:id", productsController.findOne);

// Update a Product with id
router.put("/update/:id", productsController.update);

// Delete a Product with id
router.delete("/delete/:id", productsController.delete);

module.exports = router;
