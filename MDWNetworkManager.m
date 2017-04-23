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

+(void) fetchExhibitorsData:(NSMutableArray*) mydata :(UITableView*) myTable{

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls exhibitorsRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            NSLog(@"Error: %@", error);
            
        } else {
            
            NSArray * result = [responseObject objectForKey:@"result"];
            
            for (NSDictionary * exhibitor in result) {
                
                ExhibitorDTO * exhibitorDTO = [[ExhibitorDTO alloc] initWithCompanyName:[exhibitor objectForKey:@"companyName"] CompanyAddress:[exhibitor objectForKey:@"companyAddress"]  ImageURL:[exhibitor objectForKey:@"imageURL"]  Email:[exhibitor objectForKey:@"email"]  CountryName:[exhibitor objectForKey:@"countryName"]  CityName:[exhibitor objectForKey:@"cityName"]  CompanyAbout:[exhibitor objectForKey:@"companyAbout"]  ContactName:[exhibitor objectForKey:@"contactName"]  ContactTitle:[exhibitor objectForKey:@"contactTitle"]  companyURl:[exhibitor objectForKey:@"companyUrl"] ];
                
                [mydata addObject:exhibitorDTO];
            }

        }
        
        [myTable reloadData];
        //-- 
    }];
    
  [dataTask resume];

}
//---------- merna -----------

+(void) fetchAttendeeData{
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls LoginRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        
        if (error) {
            
            NSLog(@"Error: %@", error);
            
        } else {
        
            
            if([[responseObject objectForKey:@"status"] isEqualToString:@"view.success"]){
                
                NSDictionary * result = [responseObject objectForKey:@"result"];
                AttendeeDTO * attendeeDTO = [[AttendeeDTO alloc] initWithCode:[result objectForKey:@"code"]
                                                                     imageURL:[result objectForKey:@"imageURL"]
                                                                     birthDate:[[result objectForKey:@"birthdate"] longValue ]
                                                                     email:[result objectForKey:@"email"]
                                                                     firstName:[result objectForKey:@"firstName"]
                                                                     middleName:[result objectForKey:@"middleName"]
                                                                     lastName:[result objectForKey:@"lastName"]
                                                                     countryName:[result objectForKey:@"countryName"]
                                                                     cityName:[result objectForKey:@"cityName"]
                                                                     companyName:[result objectForKey:@"companyName"]
                                                                     titleJob:[result objectForKey:@"title"]
                                                                     gender:[result objectForKey:@"gender"]];
                
                
                // save  attendee object using NSUserDefaults
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:attendeeDTO];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:data forKey:@"attendeeObject"];

            }
        
        }
        
        
    }];
    
    [dataTask resume];
    
}

+(void) fetchImageWithURL: (NSURL*)imageURL UIImageView:(UIImageView*) imageView{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        printf("\n**************************\n");
        NSLog(@"File downloaded to: %@\n", filePath);
        printf("\n**************************\n");
        NSLog(@"error %@\n", error);
        printf("\n**************************\n");
        NSLog(@"response %@\n",response);
        
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL: filePath]];
        imageView.image = image;
      
        
    }];
    [downloadTask resume];


}

//---------- end merna -----------

//---------- marko -----------

//---------- end marko -----------


@end
