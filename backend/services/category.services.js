const { category } = require("../models/category.model");

async function createCategory(params, callback) {
    if (!params.cateName) {
        return callback({
            message: "Category Name Required",
        }, "");
    }

    const categoryModel = new category(params);
    try {
        const savedCategory = await categoryModel.save();
        callback(null, savedCategory);
    } catch (error) {
        callback(error);
    }
}

async function getCategories(params, callback) {
    const cateName = params.cateName;
    const condition = cateName
        ? { cateName: { $regex: new RegExp(cateName, "i") } }
        : {};

    try {
        const categories = await category.find(condition);
        callback(null, categories);
    } catch (error) {
        callback(error);
    }
}

async function getCateById(params, callback) {
    const cateId = params.cateId;

    try {
        const foundCategory = await category.findById(cateId);
        if (!foundCategory) {
            callback(`Not found Category with id ${cateId}.`);
        } else {
            callback(null, foundCategory);
        }
    } catch (error) {
        callback(error);
    }
}

async function updateCategory(params, callback) {
    const cateId = params.cateId;

    try {
        const updatedCategory = await category.findByIdAndUpdate(
            cateId,
            params,
            { useFindAndModify: false, new: true }
        );
        if (!updatedCategory) {
            callback(`Cannot update Category with id=${cateId}. Maybe Category was not found!`);
        } else {
            callback(null, updatedCategory);
        }
    } catch (error) {
        callback(error);
    }
}

async function deleteCategory(params, callback) {
    const cateId = params.cateId;

    try {
        const deletedCategory = await category.findByIdAndDelete(cateId);
        if (!deletedCategory) {
            callback(`Category with id=${cateId} has already been deleted or not found.`);
        } else {
            callback(null, { message: `Category with id=${cateId} has been successfully deleted.` });
        }
    } catch (error) {
        callback(error);
    }
}

module.exports = {
    createCategory,
    getCategories,
    getCateById,
    updateCategory,
    deleteCategory
};
