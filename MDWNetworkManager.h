//
//  MDWNetworkManager.h
//  AFNetDemo
//
//  Created by Merna on 4/15/17.
//  Copyright © 2017 Merna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import "ServiceUrls.h"
#import "SpeakerDTO.h"
#import "SessionDTO.h"
#import "ExhibitorDTO.h"
#import "AttendeeDTO.h"

@interface MDWNetworkManager : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate,
                                            NSURLSessionDownloadDelegate, NSURLSessionDelegate>

+(void) fetchSpeakersData:(NSMutableArray*) mydata :(UITableView*) myTable;
+(void) fetchAllSessionsData:(NSMutableArray*) mydata :(UITableView*) myTable;
+(void) fetchExhibitorsData:(NSMutableArray*) mydata :(UITableView*) myTable;

//---------- merna -----------

+(void) fetchAttendeeData;
+(void) fetchImageWithURL: (NSString*)imageURL UIImageView:(UIImageView*) image;

//---------- end merna -----------

//---------- marko -----------

//---------- end marko -----------

@end
