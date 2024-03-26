{
    print("nomeCampo;tipo");
function printFieldInfo(obj, path) {
    for (var key in obj) {
        var fullPath = (path ? path + "." : "") + key;
        var fieldType = typeof obj[key];

        print(fullPath + ";" + fieldType);

        if (fieldType === "object") {
            printFieldInfo(obj[key], fullPath);
        }
    }
}

var collection = db.getCollection('students');
var document = collection.findOne();

printFieldInfo(document, "");
}