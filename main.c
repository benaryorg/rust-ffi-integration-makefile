#include <stdio.h>

extern char *foo(void);
extern char bar(void);

int main(void)
{
	char *x = foo();
	printf("%s: %d\n",x,bar());
	return 0;
}

