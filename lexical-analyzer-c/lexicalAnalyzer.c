#include<string.h>
#include<stdio.h>
#include<ctype.h>
#include<stdbool.h>

bool isDelimiter(char ch)
{
    if (ch == ' ' || ch == ',' || ch == ';' || ch == '>' || ch == '\n'
        || ch == '<' || ch == '(' || ch == ')' || ch == '{' || ch == '}')
        return (true);

    return (false);
}
bool isKeyword(char* str)
{
	if (!strcmp(str, "return") || !strcmp(str, "printf")
		|| !strcmp(str, "void") || !strcmp(str, "static"))
		return (true);
	return (false);
}
bool validIdentifier(char* str)
{
	if(!isalpha(str[0]))
		return false;
	return true;
}

void main(){
	FILE *fp;
	fp = fopen("sample.c","r");
	if(fp == NULL)
	{
		printf("error while opening the file\n");
		exit(0);
	}

	char ch;
	char buffer[15];
	int j = 0;
	while((ch=fgetc(fp))!=EOF)
	{
		
		if(isalnum(ch) || ch == '#')
			buffer[j++] = ch;
		else if(isDelimiter(ch))
		{	if(j==0)
				printf("Delimiter : %c\n",ch);
			else
			{	
				buffer[j] = '\0';
				j=0;

				if(buffer[0]=='#')
					printf("%s is pre-processor\n",buffer +1);
				else{
					if(isKeyword(buffer))
						printf("%s is keyword\n",buffer);
					else if(validIdentifier)
						printf("%s is identifier\n",buffer);
				}
			}
		}
	}
}