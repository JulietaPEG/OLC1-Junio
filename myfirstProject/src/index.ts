const parser = require('./gramatica/gramatica');
const fs = require("fs");

try {
    const entrada = fs.readFileSync("src/entrada.txt");
    const ast= parser.parse(entrada.toString());
    
    //aqui analisis semantico

    for (const elemento  of ast) {
        try {
            
            elemento.executar()
        } catch (error) {
            console.log(error);
            
        }
    }
    
    



} catch (error) {
    console.log(error);
    
}