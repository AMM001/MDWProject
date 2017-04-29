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
+(NSURLRequest*) exhibitorsRequest;

//---------- merna -----------
+(NSURLRequest*)LoginRequestWithEmail:(NSString*)email Password:(NSString*)password;
+(NSURLRequest *)requestRegisterToSessionWithID: (long) sessionID enforce:(NSString*)enforce status:(int)status;
//---------- end merna -----------
+(void) setUserEmail:(NSString*)email;
//---------- marko -----------

//---------- end marko -----------

@end
