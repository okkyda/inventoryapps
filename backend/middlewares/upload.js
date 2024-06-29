const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
    destiantion:function(req,file,cb){
        cb(null, "/uploads");
        
    },

    filename:function(req,file,cb){
        cb(null,Date.now() + "-" + file.originalname);


    }
});

const filefilter = (req,file,callback) =>{
    const validExts = [".png", ".jpg", ".jpeg"];

    if(!validExts.includes(Path.extname(file.originalname))) {

        return callback (new Error("Masukan File dengan jenis ini .png, .jpg dan .jpeg "));

    }

    const fileSize = parseInt(req.headers["content-length"]);
        if(fileSize>1048576) {
            return callback(new Error("File Terlalu Besar"))
        }

        callback(null,true)
    
};

let upload = multer({
    storage:storage,
    filefilter: filefilter,
    fileSize:1048576, //10 mb 


});

module.exports = upload.single("Foto")