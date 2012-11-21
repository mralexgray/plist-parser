//
//  PSColorLogging.h
//  PS
//
//  Created by Miles Alden on 8/8/12.
//
//

//#define XCODE_COLORS "XcodeColors"

// How to apply color formatting to your log statements:
//
// To set the foreground color:
// Insert the ESCAPE_SEQ into your string, followed by "fg124,12,255;" where r=124, g=12, b=255.
//
// To set the background color:
// Insert the ESCAPE_SEQ into your string, followed by "bg12,24,36;" where r=12, g=24, b=36.
//
// To reset the foreground color (to default value):
// Insert the ESCAPE_SEQ into your string, followed by "fg;"
//
// To reset the background color (to default value):
// Insert the ESCAPE_SEQ into your string, followed by "bg;"
//;
// To reset the foreground and background color (to default values) in one operation:
// Insert the ESCAPE_SEQ into your string, followed by ";"
//
//
// Feel free to copy the define statements below into your code.
// <COPY ME>

#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["

//#if TARGET_OS_IPHONE
//#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_IOS
//#else
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_MAC
//#endif

//NSLog(XCODE_COLORS_ESCAPE @"fg0,0,255;" @"Blue text" XCODE_COLORS_RESET);

#define BLACK           @"fg0,0,0;"
#define BLUE            @"fg0,0,255;"
#define LIGHT_GREEN     @"fg92,170,109;"
#define LIGHT_PURPLE    @"fg209,57,168;"
#define LIGHT_BLUE      @"fg108,160,196;"
#define OCEAN_BLUE      @"fg145,164,255;"
#define RED             @"fg255,0,0;"
#define GRAY            @"fg157,157,157;"
#define GRAY_BLUE       @"fg135,134,173;"
#define BURGUNDY        @"fg98,30,73;"
#define ORANGE          @"fg255,127,0;"
#define TEAL            @"fg0,150,168;"
#define FUSCIA          @"fg255,0,255;"
#define BROWN           @"fg153,102,51;"
#define MOSS            @"fg0,128,64;"
#define IRON            @"fg76,76,76;"
#define CAYANNE         @"fg128,0,0;"
#define CANTALOUPE      @"fg255,204,102;"
#define LAVENDER        @"fg204,102,255;"



#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

// </COPY ME>
