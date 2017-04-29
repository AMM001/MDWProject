//
//  DBHandler.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "DBHandler.h"
#import <Realm/Realm.h>

@implementation DBHandler
static DBHandler *dbHandler;

static RLMRealm *realm;

+(void)initialize{
    realm = [RLMRealm defaultRealm];
}

+(instancetype) getDB{
    if (dbHandler == nil) {
        dbHandler = [DBHandler new];
    }
    return dbHandler;
}

-(void)addOrUpdateAgenda:(AgendaDTO *)agenda{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:agenda];
    }];

}
- (void)addOrUpdateFillter: (FillteringAgendaDTO *) fillter{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:fillter];
    }];
}

-(void)addOrUpdateSession:(SessionDTO *)session{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:session];
    }];

}
-(void) updateSession:(SessionDTO*)session Status:(int)status{
    NSError *error;
    [realm beginWriteTransaction];
    session.status = status;
    [realm addOrUpdateObject:session];
    [realm commitWriteTransaction:&error];
    if (error != nil) {
        NSLog(@"Merna%@", [error description]);
    }
}

-(void)addOrUpdateSpeaker:(SpeakerDTO *)speaker{
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm addOrUpdateObject:speaker];
//    }];
    NSError *error;
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:speaker];
    [realm commitWriteTransaction:&error];
    if (error != nil) {
        NSLog(@"Merna%@", [error description]);
    }

}
-(void)UpdateSpeaker:(SpeakerDTO *)speaker withImage:(NSData*)img{
    NSError *error;
    [realm beginWriteTransaction];
    speaker.imageData = img;
    [realm addOrUpdateObject:speaker];
    [realm commitWriteTransaction:&error];
    if (error != nil) {
        NSLog(@"Merna%@", [error description]);
    }
}

-(void)UpdateExhibitor:(ExhibitorDTO *)exhibitor withImage:(NSData*)img{
    NSError *error;
    [realm beginWriteTransaction];
    exhibitor.imageData = img;
    [realm addOrUpdateObject:exhibitor];
    [realm commitWriteTransaction:&error];
    if (error != nil) {
        NSLog(@"Merna%@", [error description]);
    }
}


-(void)addOrUpdateExhibitor:(ExhibitorDTO *)exhibitor{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:exhibitor];
    }];

}

//-(AgendaDTO *)getAgendaByDate: (long) date{
//    NSString *query = [NSString stringWithFormat:@"%@%ld", @"date == ", date];
//    AgendaDTO* agenda = [[AgendaDTO objectsWhere:query] firstObject];
//
//    return agenda;
//}

-(AgendaDTO *) getAgendaByDayNumber: (int) day{
    
    NSString *query1 = [NSString stringWithFormat:@"%@%d", @"id == ", day];
    FillteringAgendaDTO* fillteredDate = [[FillteringAgendaDTO objectsWhere:query1] firstObject];
    
    
    NSString *query2 = [NSString stringWithFormat:@"%@%ld", @"date == ", fillteredDate.date];
    AgendaDTO* agenda = [[AgendaDTO objectsWhere:query2] firstObject];
    
    return agenda;
}

-(SpeakerDTO *)getSpeakerById:(int)id{
        NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", id];
    SpeakerDTO *speaker = [[SpeakerDTO objectsWhere:query]firstObject];
    return speaker;
}

-(SessionDTO *)getSessionById:(int)id{
            NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", id];
    SessionDTO* session = [[SessionDTO objectsWhere:query] firstObject];
    return session;
}

-(ExhibitorDTO *)getExhibitorById:(int)id{
            NSString *query = [NSString stringWithFormat:@"%@%d", @"id == ", id];
    ExhibitorDTO *exhibitor = [[ExhibitorDTO objectsWhere:query] firstObject];
    return exhibitor;
}

-(void)dropDatabase{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
