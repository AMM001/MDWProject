//
//  SpeakerDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "SpeakerDTO.h"

@implementation SpeakerDTO


+(NSString *)primaryKey{
    return @"id";
}


- (instancetype)initWithSpeakerId:(int)id firstName:(NSString*)fName middleName:(NSString*)mName lastName:(NSString*)lName imageURL:(NSString*)imgURL companyName:(NSString*)companyName title:(NSString*)title biography:(NSString*)biography
{
    self = [super init];
    if (self) {
        _id = id;
        _firstName = fName;
        _middleName = mName;
        _lastName = lName;
        _imageURL = imgURL;
        _companyName = companyName;
        _title = title;
        _biography = biography;
    }
    return self;
}
@end
