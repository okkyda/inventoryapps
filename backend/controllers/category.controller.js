const categoriesServices = require("../services/category.services.js");
const upload = require("../middlewares/upload.js");
const mongoose = require('mongoose');

// Create and Save a new Category
exports.create = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const url = req.protocol + "://" + req.get("host");
            const path = req.file ? url + "/" + req.file.path.replace(/\\/g, "/") : "";

            const model = {
                cateNumber: req.body.cateNumber,
                cateName: req.body.cateName,
            };

            categoriesServices.createCategory(model, (error, results) => {
                if (error) {
                    return next(error);
                }
                res.status(200).send({
                    message: "Success",
                    data: results,
                });
            });
        }
    });
};

// Retrieve all Categories from the database.
exports.findAll = (req, res, next) => {
    const model = {
        cateName: req.query.cateName,
    };

    categoriesServices.getCategories(model, (error, results) => {
        if (error) {
            return next(error);
        }
        res.status(200).send({
            message: "Success",
            data: results,
        });
    });
};

// Find a single Category with an id
exports.findOne = (req, res, next) => {
    const model = {
        cateId: req.params.id, // Changed from productId to cateId
    };

    categoriesServices.getCateById(model, (error, result) => {
        if (error) {
            return next(error);
        }
        if (!result) {
            return res.status(404).send({
                message: "Category not found",
            });
        }
        res.status(200).send({
            message: "Success",
            data: result,
        });
    });
};

// Update a Category by the id in the request
exports.update = (req, res, next) => {
    if (!mongoose.Types.ObjectId.isValid(req.params.id)) {
        return res.status(400).send({
            message: "Invalid ID format"
        });
    }

    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const url = req.protocol + "://" + req.get("host");
            const path = req.file ? url + "/" + req.file.path.replace(/\\/g, "/") : "";

            const model = {
                cateId: req.params.id,
                cateNumber: req.body.cateNumber,
                cateName: req.body.cateName,
            };

            categoriesServices.updateCategory(model, (error, results) => {
                if (error) {
                    return next(error);
                }
                if (!results) {
                    return res.status(404).send({
                        message: "Category not found",
                    });
                }
                res.status(200).send({
                    message: "Success",
                    data: results,
                });
            });
        }
    });
};

// Delete a Category with the specified id in the request
exports.delete = (req, res, next) => {
    const model = {
        cateId: req.params.id, // Changed from productId to cateId
    };

    categoriesServices.deleteCategory(model, (error, result) => {
        if (error) {
            return next(error);
        }
        if (!result) {
            return res.status(404).send({
                message: "Category not found",
            });
        }
        res.status(200).send({
            message: "Success",
            data: result,
        });
    });
};
