//
//  ColorSchemeHeader.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef ColorSchemeHeader_h
#define ColorSchemeHeader_h

#define SSC(x, y) static NSString *const x = y;

SSC(Color_Background, @"Background")
SSC(Color_StartButton, @"StartButton")
SSC(Color_AlternativeButton, @"AlternativeButton")
SSC(Color_AlternativeButtonWrong, @"AlternativeButtonWrong")
SSC(Color_AlternativeButtonCorrect, @"AlternativeButtonCorrect")
SSC(Color_NextTaskButton, @"NextTaskButton")
SSC(Color_RestartButton, @"RestartButton")
SSC(Color_SkipButtonTitle, @"SkipButtonTitle")
SSC(Color_White, @"White")
SSC(Color_Black, @"Black")
SSC(Color_Gray, @"Gray")
SSC(Color_ButtonBorder, @"ButtonBorder")

#endif /* ColorSchemeHeader_h */
