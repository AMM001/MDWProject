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
#import "AgendaDTO.h"
#import "DBHandler.h"
#import "LoginViewController.h"
#import "ViewsProtocol.h"

@interface MDWNetworkManager : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate,
                                            NSURLSessionDownloadDelegate, NSURLSessionDelegate>

+(void) fetchSpeakersData:(NSMutableArray*) mydata :(UITableView*) myTable;
+(void) fetchAllSessionsData:(NSMutableArray*) mydata :(id<ViewsProtocol>) controller;
+(void) fetchExhibitorsData:(NSMutableArray*) mydata :(UITableView*) myTable;

//---------- merna -----------

+(void) fetchAttendeeDataWithEmail:(NSString*)email Password:(NSString*)password Controller:(id) controller;

+(void) fetchImageWithURL: (NSString*)imageURL UIImageView:(UIImageView*) image setForObject:(id)myObject;

+(void) registerSessionWithID: (NSInteger) sessionID enforce:(NSString*)enforce status:(int)status;
//---------- end merna -----------

//---------- marko -----------

//---------- end marko -----------

@end
