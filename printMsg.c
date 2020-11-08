#include "stdio.h"
#include "stm32f4xx.h"
#include "string.h"
void printMsg1(const int a,const int b,const int c,const int d)
{
	 char Msg[100];
	 char *ptr;
	 if(c == 0 && d == 0)
	 {
	 if(b == 0)
		 sprintf(Msg,"\n Logic Function : AND \n");
	if(b == 1)
		 sprintf(Msg,"\n Logic Function : OR \n");
	if(b == 2)
		 sprintf(Msg,"\n Logic Function : NOT \n");
	if(b == 3)
		 sprintf(Msg,"\n Logic Function : NAND \n");
	if(b == 4)
		 sprintf(Msg,"\n Logic Function : NOR \n");
	ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 
	sprintf(Msg," X0   X1   X2    Y \n");
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
 }
	 
 sprintf(Msg, " %c",'1');
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 
	 sprintf(Msg, "    %d", c);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
	 
	 sprintf(Msg, "    %d", d);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
 
	 sprintf(Msg, "     %d\n", a);
	 ptr = Msg ;
   while(*ptr != '\0')
	 {
      ITM_SendChar(*ptr);
      ++ptr;
   }
}
