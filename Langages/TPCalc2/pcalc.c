/* Implementation of a calculator in prefix notation */

#include <stdio.h>
#include "lexer.h"
#include "list.h"

void parse_exp(list l, int *v) {
        token current = next(v);
        int v1;
        int v2;
        switch (current) {
        case INT:
                break;
        /* A COMPLETER: AUTRES CAS */
        case VAR:
                *v = pick(l, *v);
                break;
        case PLUS:
                parse_exp(l, v);
                v1 = *v;
                parse_exp(l, v);
                v2 = *v;
                *v = v1 + v2;
                break;
        case MINUS:
                parse_exp(l, v);
                v1 = *v;
                parse_exp(l, v);
                v2 = *v;
                *v = v1 - v2;
                break;
        case MULT:
                parse_exp(l, v);
                v1 = *v;
                parse_exp(l, v);
                v2 = *v;
                *v = v1 * v2;
                break;
        case DIV:
                parse_exp(l, v);
                v1 = *v;
                parse_exp(l, v);
                v2 = *v;
                *v = v1 / v2;
                break;
        default:
                unexpected(current, *v, "exp");
        }
}

void parse_input(list l) {
        int v;
        token current = next(&v);
        /* A CORRIGER: on reconnaît juste une expression (sans '?' devant) */
        if (current == END){
                return;
        }
        else if (current == QUEST){
                parse_exp(l, &v);
                append(l, v); // L'affichage est fait dans "append" (cf. commentaires dans "list.h")
                parse_input(l);
        }
        else {
                unexpected(current, v, "input");
        }
}

int main() {
        printf("// Mini-calculator.\n//\n") ;
        printf("// Enter below a sequence of integer computations (using prefix notation).\n");
        printf("// Each computation must start with '?'.\n") ;
        printf("// Type Ctrl-D to quit.\n") ;
        parse_input(empty());
        /* Ligne suivante à garder, pour vérifier qu'on sort proprement */
        printf("// End of Input: Bye !\n") ;
        return 0;
}
