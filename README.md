# FlexBisonLab

A beginner-friendly, hands-on project exploring **lexical analysis**, **parsing**, and basic expression evaluation using **Flex**, **GNU Bison**, and **C**.

## Version 1 — Addition calculator

This first version recognizes nonnegative integer literals and the `+` operator, parses expressions such as `20 + 5 + 10`, and prints their sum.

```text
Enter an expression: Result: 35
```

> Version 1 accepts **one expression per run**, ending at end-of-file (EOF). It does not yet support subtraction, multiplication, variables, or semicolons. Use integer values small enough to fit in C's `int` type.

## How it works

```text
Source input ("20 + 5")
          |
          v
Flex lexer (lexer.l) -> NUMBER(20), '+', NUMBER(5)
          |
          v
Bison parser (parser.y) -> grammar + semantic actions
          |
          v
Result: 25
```

- **`lexer.l`** defines regular expressions that recognize numbers and the plus sign. The lexer converts numeric text using `atoi(yytext)`, stores the integer in `yylval`, and returns the `NUMBER` token.
- **`parser.y`** declares tokens and grammar rules. The semantic action `$$ = $1 + $3;` combines two expression values.
- **`parser.tab.h`**, **`parser.tab.c`**, and **`lex.yy.c`** are generated during the build, so they are not committed.

The C program calls **`yyparse()`**, and the parser calls **`yylex()`** when it needs another token.

## Requirements

- Flex
- GNU Bison
- A C compiler (such as Clang or GCC)

On macOS with Homebrew:

```bash
brew install flex bison
export PATH="$(brew --prefix flex)/bin:$(brew --prefix bison)/bin:$PATH"
```

## Build and run

From the repository directory:

```bash
bison -d parser.y
flex lexer.l
clang parser.tab.c lex.yy.c -o calculator
```

Run a single expression:

```bash
echo "20 + 5 + 10" | ./calculator
```

Expected output:

```text
Enter an expression: Result: 35
```

Or run `./calculator`, enter an expression, then signal EOF (Ctrl+D on macOS/Linux). Invalid input is rejected by the parser with a syntax error.

## What I'm learning

- Recognizing tokens using regular expressions and `yytext`
- Returning token types and values with `yylex()` and `yylval`
- Writing grammar rules in Bison
- Using `$1`, `$3`, and `$$` in semantic actions
- Generating and compiling C source from Flex and Bison

## Possible next steps

- Subtraction, multiplication, division, and parentheses
- Operator precedence and associativity
- Better error handling
- Abstract syntax trees (ASTs)

This is an educational learning project, not a full compiler.
