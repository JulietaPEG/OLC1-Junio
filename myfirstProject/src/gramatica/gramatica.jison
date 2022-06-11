%{

    //codigo en JS
    //importaciones y declaraciones
    const {Declaracion} = require('../instrucciones/declaracion');
    const {Literal} = require('../expresiones/literal')
    const {Type} = require('../symbols/type');
    const {Arithmetic} = require('../expresiones/aritmeticas');
    const {ArithmeticOption} = require('../expresiones/aritmeticOption');

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
"+" return '+' 
"-" return '-' 
"*" return '*' 
"/" return '/' 



[a-zA-ZñÑ][a-zA-Z0-9_ñÑ]*	return 'id';


<<EOF>>		            return 'EOF'

.   { 
        console.log("error lexico :"+yytext)
        //push para array errores
    }

/lex 

%left '*' '/'
%left '+' '-'

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

DECLARACION : TIPO_DECLARACION 'id' ':' TIPODATO_DECLARACION '=' E ';' 
            {
                $$= new Declaracion($2,$4,$6,@1.first_line, @1.first_column );
            }
            ;


E: E '+' E  {$$= new Arithmetic($1,$3,ArithmeticOption.MAS, @1.first_line, @1.first_column);}
|  E '-' E  {$$= new Arithmetic($1,$3,ArithmeticOption.MENOS, @1.first_line, @1.first_column);}  
|  E '*' E  {$$= new Arithmetic($1,$3,ArithmeticOption.MULTIPLICACION, @1.first_line, @1.first_column);}
|  E '/' E  {$$= new Arithmetic($1,$3,ArithmeticOption.DIV, @1.first_line, @1.first_column);}
|  F    {$$=$1;}
;

F: expreR_numero   {$$=new Literal($1,Type.NUMBER , @1.first_line, @1.first_column)}
    |expreR_bool   {$$=new Literal($1,Type.BOOLEAN, @1.first_line, @1.first_column)}
    |expreR_cadena {$$=new Literal($1,Type.STRING , @1.first_line, @1.first_column)}
;


