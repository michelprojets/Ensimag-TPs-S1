/* Implementation of "lexer.h" */

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "lexer.h"

/* NB: allocation below requires that END is the last token
   TAKE CARE to synchronize token_name with token type of lexer.h
*/
static const char* token_name[END+1] = {
        "<INT>",
        "#",
        "?",
        "+",
        "-",
        "*",
        "/",
        "(",
        ")",
        "<END>"
};

void display(token t, int v) {
        printf("%s", token_name[t]);
        switch (t) {
        case INT:case VAR:
                if (v >= 0) {
                        printf("%d",v);
                } else {
                        printf("...\n");
                }
        default:
                break;
        }
}

void unexpected(token t, int v, const char *mesg) {
        printf("ERROR: unexpected token ");
        display(t, v);
        if (mesg[0] != 0) {
                printf(" in %s", mesg);
        }
        printf("\n");
        exit(1);
}


static int isDigit(char c) {
        return '0' <= c && c <= '9';
}

static int digit(char c) {
        assert(isDigit(c));
        return c - '0';
}

static char current;

static void update_current() {
        current = fgetc(stdin);
}

static void parse_int(int *v) {
        int res;
        if (! isDigit(current)) {
                printf("LEXICAL ERROR: unexpected character '%c'\n", current);
                exit(1);
        }
        res = digit(current);
        update_current();
        /* A COMPLETER et CORRIGER: LECTURE DU +LONG ENTIER POSSIBLE ! */
        while(isDigit(current)){
                res = 10*(res) + digit(current);
                update_current();
        }
        *v = res;
}

/* Boolean variable indicating whether "current" has been initialized or not.
   NB: this variable is only used in "next".
 */
static int init = 0;

token next(int *v) {
        if (! init) {
                /* A CORRIGER: enlever ligne ci-dessous */
                update_current();
                init = 1;
        }
        for ( ; ; ) {
                switch (current) {
                case ' ': case '\t': case '\n':
                        update_current();
                        break;
                /* A COMPLETER: AUTRES TOKENS */
                case '?':
                        update_current();
                        return QUEST;
                case '+':
                        update_current();
                        return PLUS;
                case '-':
                        update_current();
                        return MINUS;
                case '*':
                        update_current();
                        return MULT;
                case '/':
                        update_current();
                        return DIV;
                case '(':
                        update_current();
                        return OPAR;
                case ')':
                        update_current();
                        return CPAR;
                case EOF:
                        update_current();
                        return END;
                case '#':
                        update_current();
                        parse_int(v);
                        return VAR;
                default:
                        parse_int(v);
                        return INT;
                }
        }
}
