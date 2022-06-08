const parser = require('./gramatica/gramatica');
const fs = require("fs");

try {
    const entrada = fs.readFileSync("src/entrada.txt");
    parser.parse(entrada.toString());

    //aqui analisis semantico
    
    



} catch (error) {
    console.log(error);
    
}