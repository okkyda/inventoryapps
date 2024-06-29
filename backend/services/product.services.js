const { product } = require("../models/products.model");

async function createProduct(params, callback) {
    if (!params.productName) {
        return callback({
            message: "Product Name Required",
        }, "");
    }

    const productModel = new product(params);
    productModel
        .save()
        .then((response) => {
            return callback(null, response);
        })
        .catch((error) => {
            return callback(error);
        });
}

async function getProducts(params, callback) {
    const productName = params.productName;
    var condition = productName
        ? { productName: { $regex: new RegExp(productName), $options: "i" } }
        : {};

    product
        .find(condition)
        .then((response) => {
            return callback(null, response);
        })
        .catch((error) => {
            return callback(error);
        });
}

async function getProductById(params, callback) {
    const productId = params.productId;

    product
        .findById(productId)
        .then((response) => {
            if (!response) {
                return callback(`Not found Product with id ${productId}.`);
            }
            callback(null, response);
        })
        .catch((error) => {
            return callback(error);
        });
}

async function updateProduct(params, callback) {
    const productId = params.productId;

    product
        .findByIdAndUpdate(productId, params, { new: true, useFindAndModify: false })
        .then((response) => {
            if (!response) {
                return callback(`Cannot update Product with id=${productId}. Maybe Product was not found!`);
            }
            callback(null, response);
        })
        .catch((error) => {
            return callback(error);
        });
}

async function deleteProduct(params, callback) {
    const productId = params.productId;

    product
        .findByIdAndDelete(productId)
        .then((response) => {
            if (!response) {
                return callback(`Product with id=${productId} has already been deleted or not found.`);
            }
            callback(null, { message: `Product with id=${productId} has been successfully deleted.` });
        })
        .catch((error) => {
            return callback(error);
        });
}

module.exports = {
    createProduct,
    getProducts,
    getProductById,
    updateProduct,
    deleteProduct
};
