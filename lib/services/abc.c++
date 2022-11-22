    #include<iostream.h>
    #include<conio.h>
    #include<string.h>
    #include<stdio.h>
    #include<stdlib.h>
    void swap1(char **string1_prt,char **string2_prt)
    {
        char *temp = *string1_prt;
        *string1_prt = *string2_prt;
        *string2_prt = temp;
    }
    void main()
    { 
        char *string1 = "Lakshay"; 
        char *string2 = "Garg";
        swap1(&string1,&string2);
        cout<<"String 1 is "<<string1<<endl;
        cout<<"String 1 is "<<string2<<endl;
    }