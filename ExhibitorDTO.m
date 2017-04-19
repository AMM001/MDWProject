//
//  ExhibitorDTO.m
//  testRelam
//
//  Created by marko on 4/14/17.
//  Copyright © 2017 marko. All rights reserved.
//

#import "ExhibitorDTO.h"

@implementation ExhibitorDTO

+(NSString *)primaryKey{
    return @"id";
}
- (instancetype)initWithCompanyName:(NSString*)name CompanyAddress:(NSString*)address ImageURL:(NSString*)imgURL Email:(NSString*)email CountryName:(NSString*)country CityName:(NSString*)city CompanyAbout:(NSString*)about ContactName:(NSString*)contactName ContactTitle:(NSString*)contactTitle companyURl:(NSString*)companyURL
{
    self = [super init];
    if (self) {
        _companyName = name;
        _companyAddress = address;
        _imageURL = imgURL;
        _email = email;
        _countryName = country;
        _cityName = city;
        _companyAbout = about;
        _contactName = contactName;
        _contactTitle = contactTitle;
        _companyUrl = companyURL;
    }
    return self;
}

@end
