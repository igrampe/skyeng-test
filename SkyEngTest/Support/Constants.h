//
//  Constants.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#pragma mark - HOST

#define HOST @"dictionary.skyeng.ru"
#define HOST_URL @"http://"HOST@"/"

#pragma mark - API

#define API_PATH HOST_URL@"api/"
#define API_URL API_PATH@"v1/"

#pragma mark -- API Methods

#define API_WORD_TASKS API_URL@"wordtasks"

#endif /* Constants_h */
