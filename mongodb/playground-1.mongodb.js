/* global use, db */
// MongoDB Playground
// To disable this template go to Settings | MongoDB | Use Default Template For Playground.
// Make sure you are connected to enable completions and to be able to run a playground.
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.
// The result of the last command run in a playground is shown on the results panel.
// By default the first 20 documents will be returned with a cursor.
// Use 'console.log()' to print to the debug output.
// For more documentation on playgrounds please refer to
// https://www.mongodb.com/docs/mongodb-vscode/playgrounds/

// Select the database to use.
use('escola');
db.getCollection('alunos').find({})

use('escola');
db.getCollection('alunos').find({ idade: { $gt: 23}})


// find por nome e ignorando o _id:0 ignorar 0 e não ignorar 1
use('escola');
db.getCollection('alunos').find({"nome": "Bruno"},{"_id":0})

// find por nome que contem Sil o [i] para ignorar sensitive
use('escola');
db.getCollection('alunos').find({"nome": /Sil/i})

use('escola');
db.getCollection('alunos').find({ "nome": "José Santos"})

use('escola');
db.getCollection('alunos').find({ idade: { $gt: 22}})

use('escola');
db.getCollection('alunos').insertOne({
    "nome": "José Santos",
    "idade": 43,
    "media": 4.5
})

use('escola');
db.getCollection('alunos').insertMany([
    {
    "nome": "Chris Silva",
    "idade": 22,
    "media": 6.5 },
    {
    "nome": "Diana",
    "idade": 23,
    "media": 8.4
    }
])

use('escola');
db.getCollection('alunos').insertOne({
    "nome": "Gabriel",
    "idade": 23,
    "media": 9.5,
    "endereco": {
      "rua": "Rua boa viagem",
      "numero" : "442",
      "cidade" : "Recife"      
    }
})

use('escola');
db.getCollection('alunos').find({"nome": "Jennifer"})

// find campo dentro do objeto
use('escola');
db.getCollection('alunos').find({"endereco.numero": "234"})

use('escola');
db.getCollection('alunos').find({"endereco.cidade": "Recife"})

// operador logico and. onde media gte = maior igual que 6.5
// lte menor igual que 8.0
use('escola');
db.getCollection('alunos').find({ $and: [ 
{
    media: {$gte: 6.5}    
},
{ 
    media: { $lte: 8.0}
}
]})
// $eq: = equal
use('escola');
db.getCollection('alunos').find({ idade: { $eq: 25}})