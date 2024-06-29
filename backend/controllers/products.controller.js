const productsServices = require("../services/product.services.js");
const upload = require("../middlewares/upload.js");

// Create and Save a new Product
exports.create = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const url = req.protocol + "://" + req.get("host");
            const path = req.file ? url + "/" + req.file.path.replace(/\\/g, "/") : "";

            var model = {
                productName: req.body.productName,
                productDescription: req.body.productDescription,
                productQty: req.body.productQty,
                productCateId: req.body.productCateId,
                productUrl: req.body.productUrl,
            };

            productsServices.createProduct(model, (error, results) => {
                if (error) {
                    return next(error);
                }
                return res.status(200).send({
                    message: "Success",
                    data: results,
                });
            });
        }
    });
};

// Retrieve all Products from the database.
exports.findAll = (req, res, next) => {
    const model = {
        productName: req.query.productName,
    };

    productsServices.getProducts(model, (error, results) => {
        if (error) {
            return next(error);
        }
        res.status(200).send({
            message: "Success",
            data: results,
        });
    });
};

// Find a single Product with an id
exports.findOne = (req, res, next) => {
    var model = {
        productId: req.params.id,
    };

    productsServices.getProductById(model, (error, results) => {
        if (error) {
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    });
};

// Update a Product by the id in the request
exports.update = (req, res, next) => {
    upload(req, res, function (err) {
        if (err) {
            next(err);
        } else {
            const url = req.protocol + "://" + req.get("host");
            const path = req.file ? url + "/" + req.file.path.replace(/\\/g, "/") : "";

            var model = {
                productId: req.params.id,
                productName: req.body.productName,
                productDescription: req.body.productDescription,
                productQty: req.body.productQty,
                productCateId: req.body.productCateId,
                productUrl: req.body.productUrl,
            };

            productsServices.updateProduct(model, (error, results) => {
                if (error) {
                    return next(error);
                }
                return res.status(200).send({
                    message: "Success",
                    data: results,
                });
            });
        }
    });
};

// Delete a Product with the specified id in the request
exports.delete = (req, res, next) => {
    var model = {
        productId: req.params.id,
    };

    productsServices.deleteProduct(model, (error, results) => {
        if (error) {
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    });
};
