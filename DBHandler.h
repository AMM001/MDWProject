//
//  DBHandler.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgendaDTO.h"
#import "SessionDTO.h"
#import "SpeakerDTO.h"
#import "ExhibitorDTO.h"
#import "FillteringAgendaDTO.h"
@interface DBHandler : NSObject
- (id) init __attribute__((unavailable("Must Use Factory Method getDB")));

+(instancetype) getDB;
- (void)addOrUpdateAgenda: (AgendaDTO *) agenda;
- (void)addOrUpdateFillter: (FillteringAgendaDTO *) fillter;
-(void)addOrUpdateSession: (SessionDTO *) session;
-(void) addOrUpdateSpeaker: (SpeakerDTO *) speaker;
-(void)UpdateSpeaker:(SpeakerDTO *)speaker withImage:(NSData*)img;
-(void) addOrUpdateExhibitor: (ExhibitorDTO *) exhibitor;
//-(AgendaDTO *) getAgendaByDate: (long) date;
-(AgendaDTO *) getAgendaByDayNumber: (int) day;
-(SpeakerDTO *) getSpeakerById: (int) id;
-(SessionDTO *) getSessionById: (int) id;
-(ExhibitorDTO *) getExhibitorById: (int) id;
-(void)UpdateExhibitor:(ExhibitorDTO *)exhibitor withImage:(NSData*)img;
-(void) dropDatabase;
@end
