import { Instruccion } from "../abstract/instruccion";

class Declaracion extends Instruccion {
    constructor(
        public nombre: string,
        public tipo: string,
        line: number, 
        column : number
    ) {
        super(line,column);
    }

    public executar() {
        //codigo analisis semantico
        
    }
}