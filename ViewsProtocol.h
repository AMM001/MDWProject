//
//  ViewsProtocol.h
//  MDW
//
//  Created by Merna on 4/26/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewsProtocol <NSObject>

- (void) showAlertWithMessage:(NSString*)message;
- (void) showProgressbar;
- (void) dismissProgressbar;
- (void) refreshView;

@end
