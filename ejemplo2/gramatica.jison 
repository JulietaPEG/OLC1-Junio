%lex

%%


","                 {
                        console.log("reconoci token <coma> con lexema: "+yytext);
                        return 'coma';
                    }
[ \r\t]+            {}
\n                  {}

[a-z][a-zA-Z]*              {
                        console.log("reconoci token <palabra> con lexema: "+yytext)
                        return 'palabra';
                    }  

<<EOF>>             return 'EOF'; 

.                   { 
                        console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); 
                    }
/lex


%start INI

%%

INI : BLOQUE EOF ;


BLOQUE: palabra coma BLOQUE
        | palabra
;


