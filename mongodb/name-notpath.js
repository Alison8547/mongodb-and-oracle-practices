var collection = db.getCollection('students');
var document = collection.findOne();

for (var key in document) {
    
    print("Campo: " + key + ", Tipo: " + typeof document[key]);
}

