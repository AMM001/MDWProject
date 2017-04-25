//
//  ExhibitorDTO.h
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMString.h"
@interface ExhibitorDTO : RLMObject
@property int id;
@property NSString * email;
@property NSString * countryName;
@property NSString * cityName;
@property RLMArray <RLMString *><RLMString> *mobiles;
@property RLMArray <RLMString *><RLMString> *phones;
@property NSString * companyName;
@property NSString * companyAbout;
@property NSString * imageURL;
@property NSData * imageData;
@property NSString * fax;
@property NSString * contactName;
@property NSString * contactTitle;
@property NSString * companyUrl;
@property NSString * companyAddress;

- (instancetype)initWithCompanyName:(NSString*)name CompanyAddress:(NSString*)address ImageURL:(NSString*)imgURL Email:(NSString*)email CountryName:(NSString*)country CityName:(NSString*)city CompanyAbout:(NSString*)about ContactName:(NSString*)contactName ContactTitle:(NSString*)contactTitle companyURl:(NSString*)companyURL;

@end
