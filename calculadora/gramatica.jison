
%{
	var flag=0;
    //este es un comentario
%}



%lex
numero  [0-9]+   


%%

//simbolos o palabras reservadas


{numero}            {
                        console.log("el lexema encontrado es :"+ yytext)                        
                        return 'numero'
                    }
"+"                 {
                        console.log("reconoci simbolo con lexema: "+yytext);
                        return '+';
                    }
"-"                 {
                        console.log("reconoci simbolo con lexema: "+yytext);
                        return 'simboloResta';
                    }
"*"                 {
                        console.log("reconoci simbolo con lexema: "+yytext);
                        return '*';
                    }
"/"                 {
                        console.log("reconoci simbolo con lexema: "+yytext);
                        return '/';
                    }

[ \r\t]+            {}
\n                  {}

<<EOF>>             return 'EOF'; 

.                   { 
                        console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + (yylloc.first_column+1)); 
                    }


/lex


%left '+' '-'
%left '*' '/'

%start INIT


%%

INIT 
    :   E  EOF { console.log("termine de analizar,el resultado es ",$1);   }
    ;

E
	: E '-' E  {$$=Number($1) - Number($3);}
    | E '+' E  {$$=Number($1) + Number($3);}
    | E '/' E  {$$=Number($1) / Number($3);}
    | E '*' E  {$$=Number($1) * Number($3);}
    | numero   {$$=$1;}
;


