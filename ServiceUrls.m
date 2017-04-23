//
//  ServiceUrls.m
//  AFNetDemo
//
//  Created by Merna on 4/15/17.
//  Copyright © 2017 Merna. All rights reserved.
//

#import "ServiceUrls.h"

@implementation ServiceUrls

NSString * speakersURL = @"http://www.mobiledeveloperweekend.net/MDW/service/getSpeakers?userName=eng.medhat.cs.h@gmail.com";

NSString * sessionsURL = @"http://www.mobiledeveloperweekend.net/MDW/service/getSessions?userName=eng.medhat.cs.h@gmail.com";

NSString * exhibitorsURL = @"http://www.mobiledeveloperweekend.net/MDW/service/getExhibitors?userName=eng.medhat.cs.h@gmail.com&sessionId=4482&enforce=false&status=0";

NSString * loginURL = @"http://www.mobiledeveloperweekend.net/MDW/service/login?userName=eng.medhat.cs.h@gmail.com&password=medhat123";




+(NSURLRequest *)allSpeakersRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:speakersURL]];
}

+(NSURLRequest *)allSessionsRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:sessionsURL]];
}
+(NSURLRequest *)exhibitorsRequest{
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:exhibitorsURL]];
}


//---------- merna -----------

+(NSURLRequest*)LoginRequest{
    return [NSURLRequest requestWithURL:[NSURL URLWithString:loginURL]];
}

//---------- end merna -----------

//---------- marko -----------

//---------- end marko -----------

@end
