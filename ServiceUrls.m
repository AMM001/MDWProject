//
//  ServiceUrls.m
//  AFNetDemo
//
//  Created by Merna on 4/15/17.
//  Copyright © 2017 Merna. All rights reserved.
//

#import "ServiceUrls.h"

@implementation ServiceUrls


static NSString * loginedUserEmail;


+(NSURLRequest *)allSpeakersRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobiledeveloperweekend.net/service/getSpeakers?userName=%@",loginedUserEmail]]];
}

+(NSURLRequest *)allSessionsRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobiledeveloperweekend.net/service/getSessions?userName=%@",loginedUserEmail]]];
}
+(NSURLRequest *)exhibitorsRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobiledeveloperweekend.net/service/getExhibitors?userName=%@",loginedUserEmail]]];
}


//---------- merna -----------

+(NSURLRequest*)LoginRequestWithEmail:(NSString*)email Password:(NSString*)password{
    
    loginedUserEmail = email;
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobiledeveloperweekend.net/service/login?userName=%@&password=%@", email, password]]];
}
+(NSURLRequest *)requestRegisterToSessionWithID: (long) sessionID enforce:(NSString*)enforce status:(int)status{
    
  return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://mobiledeveloperweekend.net/service/registerSession?userName=%@&sessionId=%ld&enforce=%@&status=%d", loginedUserEmail, sessionID, enforce, status]]];
}
+(void) setUserEmail:(NSString*)email{
    loginedUserEmail = email;
}
//---------- end merna -----------

//---------- marko -----------

//---------- end marko -----------

@end
