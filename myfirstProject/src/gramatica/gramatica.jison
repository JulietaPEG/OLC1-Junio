%{

    //codigo en JS
    //importaciones y declaraciones
    const {Declaracion} = require('../instrucciones/declaracion')

    var array_erroresLexicos;

%}

%lex
%options case-insensitive

number [0-9]+
cadena "\"" [^\"]* "\""
bool    "true"|"false"    

%%





\s+                   /* skip whitespace */
"//".*                // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] // comentario multiple líneas




//expresiones regulare
{number}    return 'expreR_numero'
{cadena}    return 'expreR_cadena'
{bool}      return 'expreR_bool'




//palabras reservadas

"var"   return 'pr_var'
"let"   return 'pr_let'
"const" return 'pr_const'

"numero" return 'pr_numero'
"string" return 'pr_string'
"bool" return 'pr_bool'


//simbolos

";" return ';' 
"=" return '='
":" return ':' 



[a-zA-ZñÑ][a-zA-Z0-9_ñÑ]*	return 'id';


<<EOF>>		            return 'EOF'

.   { 
        console.log("error lexico :"+yytext)
        //push para array errores
    }

/lex 


%start INIT


%%

 
 
 

INIT: INSTRUCCIONES    EOF {return $1} ;


INSTRUCCIONES :   INSTRUCCIONES INSTRUCCION { $1.push($2); $$=$1;}
              |   INSTRUCCION               { $$ = [$1] }
              ;


INSTRUCCION : DECLARACION   { $$=$1;} ;

TIPO_DECLARACION: 'pr_const' |'pr_let' | 'pr_var' ; 
TIPODATO_DECLARACION  :  'pr_numero' {$$=$1;}  
                       | 'pr_bool'   {$$=$1;}
                       | 'pr_string' {$$=$1;}
                       ; 

DECLARACION : TIPO_DECLARACION 'id' ':' TIPODATO_DECLARACION ';' 
            {
                $$= new Declaracion($2,$4,null,@1.first_line, @1.first_column );
            }
            ;



