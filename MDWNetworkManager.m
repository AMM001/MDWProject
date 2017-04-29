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
static DBHandler * myDb;
+(void)initialize{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    myDb = [DBHandler getDB];
}

+(void) fetchSpeakersData: (NSMutableArray*) mydata :(UITableView*) myTable{

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls allSpeakersRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
            RLMResults *results = [SpeakerDTO allObjects];
            
            if([results count] == 0){
                
                NSLog(@"alert %@",@"alert ............. <hi><hi>");
                
            }else{
                
                for (RLMObject *object in results) {
                    [mydata addObject:object];
                }
                
                [myTable reloadData];
               
            }

            
        } else {
            //NSLog(@"response <> %@ %@", response, responseObject);
            
            NSMutableArray *arrayOfSpeakers = [responseObject objectForKey:@"result"];
            
            for (int i=1; i<[arrayOfSpeakers count]; i++) {
                
                NSMutableDictionary *speakerDict = [arrayOfSpeakers objectAtIndex:i];
                
                SpeakerDTO *speaker = [[SpeakerDTO alloc] initWithSpeakerId:[[speakerDict objectForKey:@"id"] intValue]
                                                                  firstName:[speakerDict objectForKey:@"firstName"]
                                                                  middleName:[speakerDict objectForKey:@"middleName"]
                                                                  lastName:[speakerDict objectForKey:@"lastName"]
                                                                  imageURL:[speakerDict objectForKey:@"imageURL"]
                                                                  companyName:[speakerDict objectForKey:@"companyName"]
                                                                  title:[speakerDict objectForKey:@"title"]
                                                                  biography:[speakerDict objectForKey:@"biography"]];
                
                
                
                [myDb addOrUpdateSpeaker:speaker];
                [mydata addObject:speaker];
                
            }
            
            [myTable reloadData];
        }
    }];
    
    [dataTask resume];

}

+(void) fetchAllSessionsData: (NSMutableArray*) mydata :(id<ViewsProtocol>) controller{
    
    [mydata removeAllObjects];
    [controller showProgressbar];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls allSessionsRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            
            [controller dismissProgressbar];
            RLMResults *results = [AgendaDTO allObjects];
            
            if([results count] == 0){
                
                NSLog(@"alert %@",@"alert ............. <hi><hi>");
                [controller showAlertWithMessage:@"please check connection !"];
            }else{
                
                for (AgendaDTO *object in results) {
                    [mydata addObjectsFromArray:object.sessions];
                }
                
                //[myTable reloadData];
                [controller refreshView];
                
            }
            
        } else {
            
            NSMutableArray * agendaList = [NSMutableArray new];
            
            NSDictionary * result = [responseObject objectForKey:@"result"];
            NSArray * agendas = [result objectForKey:@"agendas"];
            
            
            NSNumber* date;
            NSArray* sessionsForDay;
            AgendaDTO* agendaObj;
            int counter = 0;
            // get all sessions for 3 days
            for(NSDictionary* day in agendas){
                
                agendaObj = [AgendaDTO new];
                date = [day objectForKey:@"date"];
                sessionsForDay = [day objectForKey:@"sessions"];
                
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
                    SessionDTO* sessionDTO = [[SessionDTO alloc] initWithId:[[session objectForKey:@"id"] intValue] Date:[date longValue]
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
                    [agendaObj.sessions addObject:sessionDTO];
                    
                }
                //-------------
                [agendaObj setDate:[date longValue]];
                [agendaList addObject:agendaObj];
                
                
                ////////////////////////
                counter++;
                FillteringAgendaDTO * fillter = [FillteringAgendaDTO new];
                fillter.id=counter;
                fillter.date=[date longValue];
                [myDb addOrUpdateFillter:fillter];
                ////////////////////////
                
                
                
                [myDb addOrUpdateAgenda:agendaObj];
                NSLog(@"%@<><><>",agendaObj);
                
            }
            
            //            [myTable reloadData];
            [controller refreshView];
            [controller dismissProgressbar];
        }
        
    }];
    
    [dataTask resume];
}

+(void) fetchExhibitorsData:(NSMutableArray*) mydata :(UITableView*) myTable{

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls exhibitorsRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            
            NSLog(@"Error: %@", error);
            
            RLMResults *results = [ExhibitorDTO allObjects];
            
            if([results count] == 0){
                
                NSLog(@"alert %@",@"alert ............. <hi><hi>");
                
            }else{
                
                for (RLMObject *object in results) {
                    [mydata addObject:object];
                }
                
                [myTable reloadData];
                
            }
            
        } else {
            
            NSArray * exhibitors = [responseObject objectForKey:@"result"];
            
            for (NSDictionary * exhibitor in exhibitors) {

                ExhibitorDTO * exhibitorDTO = [[ExhibitorDTO alloc] initWithId:[[exhibitor objectForKey:@"id"] intValue] CompanyName:[exhibitor objectForKey:@"companyName"] CompanyAddress:[exhibitor objectForKey:@"companyAddress"]  ImageURL:[exhibitor objectForKey:@"imageURL"]  Email:[exhibitor objectForKey:@"email"]  CountryName:[exhibitor objectForKey:@"countryName"]  CityName:[exhibitor objectForKey:@"cityName"]  CompanyAbout:[exhibitor objectForKey:@"companyAbout"]  ContactName:[exhibitor objectForKey:@"contactName"]  ContactTitle:[exhibitor objectForKey:@"contactTitle"]  companyURl:[exhibitor objectForKey:@"companyUrl"] ];
               
                [myDb addOrUpdateExhibitor:exhibitorDTO];
                [mydata addObject:exhibitorDTO];
            }
            
            [myTable reloadData];
        }
        
    }];
    
  [dataTask resume];

}
//---------- merna -----------

+(void) fetchAttendeeDataWithEmail:(NSString*)email Password:(NSString*)password Controller:(id) controller{
    LoginViewController * loginController = (LoginViewController *) controller;
    
    [loginController.indicator startAnimating];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls LoginRequestWithEmail:email Password:password] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSString * alertMessage;
        
        if (error) {
            
            [loginController.indicator stopAnimating];
            NSLog(@"Error: %@", error.description);
            alertMessage = @"please check connection !";
            [loginController failToLoginWith:alertMessage];
            
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
                // ... get phone ...
                NSMutableArray *mobiles = [NSMutableArray alloc];
                
                if ([[result objectForKey:@"mobiles"] count] > 0) {
                    [mobiles addObject:[result objectForKey:@"mobiles"][0]];
                }
                
                [attendeeDTO setMobiles: mobiles];
                //.................
                
                // save  attendee object using NSUserDefaults
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:attendeeDTO];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:data forKey:@"attendeeObject"];
                
                [loginController.indicator stopAnimating];
                [loginController navigateToMainController];
                
                
            }else{
                
                [loginController.indicator stopAnimating];
                alertMessage = @"please enter correct username and password";
                [loginController failToLoginWith:alertMessage];
            }
            
        }
        
        
    }];
    
    [dataTask resume];
    
}


+(void) fetchImageWithURL: (NSString*)imageURL UIImageView:(UIImageView*) imageView setForObject:(id)myObject{
    
    imageView.image=[UIImage imageNamed:@"speaker.png"];
    
    NSString * cutURL = [imageURL stringByReplacingOccurrencesOfString:@"www." withString:@""];
    
   // NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *sharedManager = [AFHTTPSessionManager manager];
    sharedManager.responseSerializer  = [[AFImageResponseSerializer alloc] init];
    [sharedManager GET:cutURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        UIImage* image = (UIImage*) responseObject;
        imageView.image = image;
        
        NSData *imageToBeSaved = UIImageJPEGRepresentation(image, 0.7);
        
        if ([myObject isKindOfClass:[ExhibitorDTO class]]) {
            ExhibitorDTO * ex = myObject;
            [myDb UpdateExhibitor:ex withImage:imageToBeSaved];
        }
        else if([myObject isKindOfClass:[SpeakerDTO class]]){
            SpeakerDTO  * sp = myObject;
            [myDb UpdateSpeaker:sp withImage:imageToBeSaved];
        }
        else if([myObject isKindOfClass:[AttendeeDTO class]]){
            AttendeeDTO * att = myObject;
            att.imageData = imageToBeSaved;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:att forKey:@"attendeeObject"];
        }
        
        //Caching the image in the database
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+(void) registerSessionWithID: (long) sessionID enforce:(NSString*)enforce status:(int)status{
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls requestRegisterToSessionWithID:sessionID enforce:enforce status:status] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        if (error) {
            NSLog(@"Error : %@", error);
            
        }else{
            
            if([[responseObject objectForKey:@"status"] isEqualToString:@"view.success"]){
                NSDictionary *result = [responseObject objectForKey:@"result"];
                
                //if oldSession != 0 then the user is already registered in another session at the same time
                
                if ([[result objectForKey:@"oldSessionId"] intValue] == 0) {
                    
                    // update status in DB and star view
                    //[[result objectForKey:@"status"] intValue]
                    
                }else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"You are already registered in another session at the same time" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *replaceAction = [UIAlertAction actionWithTitle:@"Replace" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {
                        
                         NSLog(@"enforce request<><>");
                         // new request with enforce = true ;
                        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[ServiceUrls requestRegisterToSessionWithID:sessionID enforce:@"true" status:status] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                            
                            if (error) {
                                NSLog(@"Error : %@", error);
                                
                            }else{
                                
                                if([[responseObject objectForKey:@"status"] isEqualToString:@"view.success"]){
                                    
                                    NSDictionary *result = [responseObject objectForKey:@"result"];
                            
                                        // update status in DB and star view
                                        //[[result objectForKey:@"status"] intValue]
                                        
                                    }
                            }
                        
                        }];
                        
                    }];
                    
                    UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleDefault handler:nil];
                    
                    [alert addAction:replaceAction];
                    [alert addAction:ignoreAction];
 
                }
            }
        }
    
    }];
    
   [dataTask resume];
    
}

//---------- end merna -----------

//---------- marko -----------

//---------- end marko -----------


@end
