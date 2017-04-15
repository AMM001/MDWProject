//
//  SpeakerDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMString.h"
@interface SpeakerDTO : RLMObject

@property int id;
@property NSString * firstName;
@property NSString * middleName;
@property NSString * lastName;
@property NSString * imageURL;
@property NSData * image;
@property NSString * companyName;
@property NSString * title;
@property BOOL gender ;
@property NSString * biography;
@property RLMArray <RLMString *><RLMString> *mobiles;
@property RLMArray <RLMString *><RLMString> *phones;

- (instancetype)initWithSpeakerId:(int)id firstName:(NSString*)fName middleName:(NSString*)mName lastName:(NSString*)lName imageURL:(NSString*)imgURL companyName:(NSString*)companyName title:(NSString*)title biography:(NSString*)biography;
@end
RLM_ARRAY_TYPE(SpeakerDTO)
