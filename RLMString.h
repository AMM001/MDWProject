//
//  RLMString.h
//  testRelam
//
//  Created by marko on 4/15/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>

@interface RLMString : RLMObject
@property NSString * string;
@end
RLM_ARRAY_TYPE(RLMString)
