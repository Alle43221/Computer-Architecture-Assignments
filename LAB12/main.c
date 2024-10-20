#include <stdio.h>

void concat(char[], char[], char[]);

char sir1[10], sir2[10], sir3[10], sir4[30];

int main() {
    scanf("%s", sir1);
    scanf("%s", sir2);
    scanf("%s", sir3);
    concat(sir1, sir2, sir3);
    printf("%s", sir4);
    return 0;
}
