import { Singleton } from "./patron_singleton/singleton";
import { Environment } from "./symbols/enviroment";

const singleton=Singleton.getInstance()
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
            singleton.add_errores(error)
            
        }
    }

    console.log("Termine de recorrer el ast :) ahora mostrare lo que tiene el singleton consola")
    console.log("Consola del usuario:-----------------------------");
    
    console.log(singleton.get_consola());


    //limpie
    
    
    
    



} catch (error) {
    //console.log(error);
    
}