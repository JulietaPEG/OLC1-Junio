import { Environment } from "./symbols/enviroment";

const parser = require('./gramatica/gramatica');
const fs = require("fs");

try {
    const entrada = fs.readFileSync("src/entrada.txt");
    const ast= parser.parse(entrada.toString());
    const env_padre = new Environment(null);
    //aqui analisis semantico
    //console.log(ast);    

    for (const elemento  of ast) {
        try {
            
            elemento.executar(env_padre)
        } catch (error) {
            //console.log(error);
            
        }
    }
    
    



} catch (error) {
    //console.log(error);
    
}