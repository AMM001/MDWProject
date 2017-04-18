//
//  ServiceUrls.m
//  AFNetDemo
//
//  Created by Merna on 4/15/17.
//  Copyright © 2017 Merna. All rights reserved.
//

#import "ServiceUrls.h"

@implementation ServiceUrls

NSString * const speakersURL = @"http://www.mobiledeveloperweekend.net/MDW/service/getSpeakers?userName=eng.medhat.cs.h@gmail.com";

NSString * const sessionsURL = @"http://www.mobiledeveloperweekend.net/MDW/service/getSessions?userName=eng.medhat.cs.h@gmail.com";

NSString * const exhibitorsURL = @"http://www.mobiledeveloperweekend.net/MDW/service/getExhibitors?userName=eng.medhat.cs.h@gmail.com&sessionId=4482&enforce=false&status=0";


+(NSURLRequest *)allSpeakersRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:speakersURL]];
}

+(NSURLRequest *)allSessionsRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:sessionsURL]];
}

//---------- merna -----------

//---------- end merna -----------

//---------- marko -----------

//---------- end marko -----------

@end
