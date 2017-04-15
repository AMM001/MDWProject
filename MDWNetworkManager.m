//
//  MDWNetworkManager.m
//  AFNetDemo
//
//  Created by Merna on 4/15/17.
//  Copyright © 2017 Merna. All rights reserved.
//

#import "MDWNetworkManager.h"


@implementation MDWNetworkManager

static AFURLSessionManager *manager = nil;

+(void)initialize{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

}

+(void) fetchSpeakersData: (NSMutableArray*) mydata :(UITableView*) myTable{

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls allSpeakersRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            //NSLog(@"response <> %@ %@", response, responseObject);
            
            NSMutableArray *arrayOfSpeakers = [responseObject objectForKey:@"result"];
            
            for (int i=1; i<[arrayOfSpeakers count]; i++) {
                
                NSMutableDictionary *speakerDict = [arrayOfSpeakers objectAtIndex:i];
                
                SpeakerDTO *speaker = [SpeakerDTO new];
                
                [speaker setFirstName:[speakerDict objectForKey:@"firstName"]];
                [speaker setImageURL:[speakerDict objectForKey:@"imageURL"]];
                [speaker setTitle:[speakerDict objectForKey:@"title"]];
                
                
                [mydata addObject:speaker];
                
            }
            
            [myTable reloadData];
        }
    }];
    
    [dataTask resume];

}

+(void) fetchAllSessionsData: (NSMutableArray*) mydata :(UITableView*) myTable{
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls allSessionsRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            //NSMutableArray * sessions = [NSMutableArray new];
            
            NSDictionary * result = [responseObject objectForKey:@"result"];
            NSArray * agendas = [result objectForKey:@"agendas"];
            
            // get all sessions for 3 days
            for(NSDictionary* day in agendas){
                NSNumber* date = [day objectForKey:@"date"];
                NSArray* sessionsForDay = [day objectForKey:@"sessions"];
                
                // get sessions list in one day
                for(NSDictionary* session in sessionsForDay){
                    
                    NSArray* speakersList = [session objectForKey:@"speakers"];
                    // not nil
                    //get session speakers
                    NSMutableArray * sessionSpeakers;
                    
                    if(![speakersList isKindOfClass:[NSNull class]]){
                        for(NSDictionary* speaker in speakersList){
                            NSNumber* speakerID = [speaker objectForKey:@"id"];
                            SpeakerDTO* speakerDTO =[[SpeakerDTO alloc] initWithSpeakerId:[speakerID intValue]
                                                                            firstName:[speaker objectForKey:@"firstName"]
                                                                            middleName:[speaker objectForKey:@"middleName"]
                                                                            lastName:[speaker objectForKey:@"lastName"]
                                                                            imageURL:[speaker objectForKey:@"imageURL"]
                                                                            companyName:[speaker objectForKey:@"companyName"]
                                                                            title:[speaker objectForKey:@"title"]
                                                                            biography:[speaker objectForKey:@"biography"]];
                            // add speaker ..
                            [sessionSpeakers addObject:speakerDTO];
                        }
                    }
                    
                   //data el session
                    SessionDTO* sessionDTO = [[SessionDTO alloc] initWithDate:[date longValue]
                                                                name:[session objectForKey:@"name"]
                                                                location:[session objectForKey:@"location"]
                                                                sessionDescription:[session objectForKey:@"description"]
                                                                status:[[session objectForKey:@"status"] intValue]
                                                                sessionType:[session objectForKey:@"sessionType"]
                                                                liked:[session objectForKey:@"liked"]
                                                                speakers:sessionSpeakers
                                                                startDate:[[session objectForKey:@"startDate"] longValue]
                                                                endDate:[[session objectForKey:@"endDate"] longValue]];

                    [mydata addObject:sessionDTO];
                }
                //-------------
                
                
            }

            [myTable reloadData];
        }
    
    }];
    
    [dataTask resume];
}








@end
