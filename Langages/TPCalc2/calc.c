/* Implementation of a calculator in infix notation */

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "lexer.h"
#include "list.h"

/* look a-head */
static token current;
static int att; /* attribute of current */

/* parsing of token */
void parse_token(token expected) {
        if (current != expected) {
                printf("ERROR: expected token ");
                display(expected, -1);
                printf(" but found ");
                display(current, att);
                printf("\n");
                exit(1);
        }
        if (current != END) {
                current = next(&att);
        }
}

/* A COMPLETER */

// declaration de cette fonction avant parse_exp0() car parse_exp0() l'utilise
void parse_exp2(list l, int* n);

void parse_exp0(list l, int* n){
        switch (current) {
        case INT:
                parse_token(INT);
                *n = att;
                break;
        case VAR:
                parse_token(VAR);
                *n = pick(l, att);
                break;
        case MINUS:
                parse_token(MINUS);
                *n = 0 - att;
                break;
        case OPAR:
                parse_token(OPAR);
                parse_exp2(l, n);
                parse_token(CPAR);
                break;
        default:
                unexpected(current, att, "exp0");
        }
}

void parse_exp1_X(list l, int* n1, int* n){
        int n2 = 0;
        switch (current) {
        case PLUS:
        case MINUS:
        case QUEST:
        case CPAR:
                *n = *n1;
                break;
        case MULT:
                parse_token(MULT);
                parse_exp0(l, &n2);
                int n1_fois_n2 = *n1 * n2;
                parse_exp1_X(l, &n1_fois_n2, n);
                break;
        case DIV:
                parse_token(DIV);
                parse_exp0(l, &n2);
                int n1_divise_n2 = *n1 / n2;
                parse_exp1_X(l, &n1_divise_n2, n);
                break;
        default:
                unexpected(current, att, "exp1_X");
        }
}

void parse_exp1(list l, int* n){
        int n1 = 0;
        parse_exp0(l, &n1);
        parse_exp1_X(l, &n1, n);
}

void parse_exp2_X(list l, int* n1, int* n){
        int n2 = 0;
        switch (current) {
        case QUEST:
        case CPAR:
                *n = *n1;
                break;
        case PLUS:
                parse_token(PLUS);
                parse_exp1(l, &n2);
                int n1_plus_n2 = *n1 + n2;
                parse_exp2_X(l, &n1_plus_n2, n);
                break;
        case MINUS:
                parse_token(MINUS);
                parse_exp1(l, &n2);
                int n1_moins_n2 = *n1 - n2;
                parse_exp2_X(l, &n1_moins_n2, n);
                break;
        default:
                unexpected(current, att, "exp2_X");
        }
}

void parse_exp2(list l, int* n){
        int n1 = 0;
        parse_exp1(l, &n1);
        parse_exp2_X(l, &n1, n);
}

void parse_input_X(list l){
        int n = 0;
        switch (current) {
        case END:
                break;
        case INT:
        case VAR:
        case OPAR:
        case MINUS:
                parse_exp2(l, &n);
                parse_token(QUEST);
                append(l, n);
                parse_input_X(l);
                break;
        default:
                unexpected(current, att, "input_X");
        }
}

void parse_input(){
        parse_input_X(empty());
}

int main() {
        printf("// Mini-calculator.\n//\n") ;
        printf("// Enter below a sequence of integer computations (using infix notation).\n");
        printf("// Each computation must end with '?'.\n") ;
        printf("// Type Ctrl-D to quit.\n") ;
        /* A FAIRE */
        printf("calc.c: VERSION FOURNIE A COMPLETER !\n");
        current = next(&att); /* init de current */
        parse_input();
        /* Ligne suivante à garder, pour vérifier qu'on sort proprement */
        printf("// End of Input: Bye !\n") ;
        return 0;
}
