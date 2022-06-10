import { Instruccion } from "../abstract/instruccion";

export class Declaracion extends Instruccion {
    constructor(
        public nombre: string,
        public tipo: string,
        public expresion : any,
        line: number, 
        column : number
    ) {
        super(line,column);
    }

    public executar() {
        //codigo analisis semantico
        console.log("Declarando nueva variable: "+ this.nombre);
        
        
    }
}