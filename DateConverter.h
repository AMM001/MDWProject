//
//  DateConverter.h
//  MDW
//
//  Created by marko on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateConverter : NSObject
+(NSString *)stringFromDate: (NSTimeInterval) timeInterval;
+(NSString *)dayStringFromDate: (NSTimeInterval) timeInterval;
+(NSString *)dateStringFromDate: (NSTimeInterval) timeInterval;
@end
