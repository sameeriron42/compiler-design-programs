#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct expr 
{
    char data[10];
};


int main(){
    FILE *fp;
    fp = fopen("input.txt","r");
    struct expr s[30];
    int max_expr_no = 0;
    while(fscanf(fp,"%s",s[max_expr_no].data)!=EOF)
        max_expr_no++;

    for(int i=0;i<max_expr_no;i++)
    {
        if(strcmp(s[i].data,"=")==0)
        {
            printf("LDA\t%s\n",s[i+1].data);

            if(strcmp(s[i+2].data,"+")==0)
                printf("ADD\t%s\n",s[i+3].data);
            else if(strcmp(s[i+2].data,"-")==0)
                printf("SUB\t%s\n",s[i+3].data);

            printf("STA\t%s\n",s[i-1].data);            

        }
    }
    fclose(fp);
}