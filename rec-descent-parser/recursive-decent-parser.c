/*
Recursive Decent Parser for the following grammar
A 🡪 aBe | cBd | C
B 🡪 bB | έ
C 🡪 f
*/

#include<stdio.h>

char *cursor;

int A()
{
    if(*cursor=='a')
    {
        cursor++;
        if(B())
        {
            if(*cursor=='e')
            {
                cursor++;
                return 1;
            }
            return 0;
        }
        return 0;
    }
    else if(*cursor == 'c')
    {
        cursor++;
        if(B())
        {
            if(*cursor == 'd')
            {
                cursor++;
                return 1;
            }
            return 0;
        }
        return 0;
    }
    else
        return C();
}

int B(){
    if(*cursor == 'b')
    {
        cursor++;
        if(B())
        {
            return 1;
        }
        return 0;
    }
    else
        return 1;
}

int C()
{
    if(*cursor == 'f')
        return 1;
    return 0;
}

int main()
{
    char string[64];
    printf("Enter the input string: ");
    fgets(string,64,stdin);
    printf("the string is %s\n",string);
    cursor = string;
    if(A()==1 || *cursor=='\0')
    {
        printf("Successfully parsed the input string\n");
    }
    else
        printf("Failed to parse the input string\n");
}
