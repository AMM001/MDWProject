//
//  ServiceUrls.h
//  AFNetDemo
//
//  Created by Merna on 4/15/17.
//  Copyright © 2017 Merna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceUrls : NSObject

+(NSURLRequest*) allSpeakersRequest;
+(NSURLRequest*) allSessionsRequest;

@end
