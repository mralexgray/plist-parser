//
//  main.m
//  Plister
//
//  Created by Miles Alden on 11/16/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import <Cocoa/Cocoa.h>


unsigned long splitInt(unsigned long input) {
	
	char ret[100] = { "\x0" };
    int retSize = sizeof(ret) / sizeof(char);
    int inputLength = 0;
    
	while (input > 0) {
        char cat[20];
        sprintf(cat, "%ld", input % 10);
        input = input / 10;
        inputLength++;
		strncat(ret, cat, sizeof(ret) - strlen(ret)-2);
	}
    

    int count = inputLength-1;
    char temp[100] = { "\x0" };
    for ( int i = 0; i < inputLength; i++ ) {
        
        temp[i] = ret[count];
        count--;
    }
    
	printf("%s", temp);
	
	return input;
}


int main(int argc, char *argv[])
{
//    splitInt(10023);
//    return 0;
    return NSApplicationMain(argc, (const char **)argv);
}
