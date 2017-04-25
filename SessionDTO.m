//
//  SessionDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SessionDTO.h"

@implementation SessionDTO
- (instancetype)initWithId:(int)id Date:(long)date name:(NSString*)name location:(NSString*)location sessionDescription:(NSString*)desc status:(int)status sessionType:(NSString*)SessionType liked:(BOOL)liked speakers:(NSArray*)speakers startDate:(long)startDate endDate:(long)enddate
{
    self = [super init];
    if (self) {
        _id = id;
        _date = date;
        _name = name;
        _location = location;
        _sessionDescription = desc;
        _status = status;
        _sessionType = SessionType;
        _liked = liked;
//        _speakers = speakers;
        _startDate = startDate;
        _endDate = enddate;
    }
    return self;
}
+(NSString *)primaryKey{
    return @"id";
}

@end
