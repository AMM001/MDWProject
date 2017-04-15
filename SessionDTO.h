//
//  SessionDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>
#import "SpeakerDTO.h"

@interface SessionDTO : RLMObject
@property int id;
@property long date;
@property NSString *sessionType;
@property NSString *name;
@property NSString *sessionDescription;
@property long startDate;
@property long endDate;
@property NSString *location;
@property BOOL liked;
@property int status;
@property RLMArray<SpeakerDTO *><SpeakerDTO> *speakers;

-(instancetype)initWithDate:(long)date name:(NSString*)name location:(NSString*)location sessionDescription:(NSString*)desc status:(int)status sessionType:(NSString*)SessionType liked:(BOOL)liked speakers:(NSArray*)speakers startDate:(long)startDate endDate:(long)enddate;

//@property List<String> sessionTags;

@end

RLM_ARRAY_TYPE(SessionDTO)
