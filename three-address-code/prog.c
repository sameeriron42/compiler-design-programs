#include<stdio.h>
#include<stdlib.h>
#include<string.h>

struct expr{
    char data[10],temp[7];
};

int main(){
    FILE *fp;
    struct expr s[30];
    char temp_no[7],temp[7]="t";
    int i = 0,current_expr_no=1,max_expr_no=0;
    fp = fopen("input.txt","r");
    while(fscanf(fp,"%s",s[max_expr_no].data)!=EOF)    
        max_expr_no++;

    //set temp expr with numbering
    snprintf(temp_no,7,"%d",current_expr_no);
    strcat(temp,temp_no);
    strcpy(s[current_expr_no].temp,temp);
    //reset strings
    strcpy(temp_no,"");
    strcpy(temp,"t");

    if(strcmp(s[3].data,"+")==0 || !strcmp(s[3].data,"-"))
        printf("%s=%s%s%s\n",s[current_expr_no].temp,s[2].data,s[3].data,s[4].data);
    
    current_expr_no++;
    for(i=4;i<max_expr_no-2;i+=2)
    {
        //set temp expr with numbering
        snprintf(temp_no,7,"%d",current_expr_no);
        strcat(temp,temp_no);
        strcpy(s[current_expr_no].temp,temp);
        //reset strings
        strcpy(temp_no,"");
        strcpy(temp,"t");        

        if(strcmp(s[i+1].data,"+")==0 || !strcmp(s[i+1].data,"-"))
            printf("%s=%s%s%s\n",s[current_expr_no].temp,s[current_expr_no-1].temp,s[i+1].data,s[i+2].data);
    }

    
    printf("%s=%s\n",s[0].data,s[current_expr_no-1].temp);
    return 0;
}