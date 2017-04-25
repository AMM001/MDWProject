//
//  DateConverter.m
//  MDW
//
//  Created by marko on 4/25/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "DateConverter.h"

@implementation DateConverter
+(NSString *)stringFromDate: (NSTimeInterval) timeInterval{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"hh:mm a"];
    
    return [formatter stringFromDate:date];
}

+(NSString *)dayStringFromDate: (NSTimeInterval) timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd"];
    
    return [formatter stringFromDate:date];
}

+(NSString *)dateStringFromDate: (NSTimeInterval) timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"EEE, dd MMM"];
    
    return [formatter stringFromDate:date];
}

@end


//NSString * date = [NSString stringWithFormat:@"%@ - %@",
//                   [DateConverter stringFromDate:session.startDate],
//                   [DateConverter stringFromDate:session.endDate]];
//[t3 setText:date];
