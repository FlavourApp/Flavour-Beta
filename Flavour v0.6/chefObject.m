//
//  chefObject.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/10/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "chefObject.h"
#import "globals.h"

@implementation chefObject

-(id)initWithDictionary:(NSDictionary *)dict

    {
    self = [super init];
    if (self) {
        NSDictionary *fields = [dict objectForKey:@"fields"];
        
        self.name = [fields objectForKey:@"name"];
        NSLog(@"name:%@",self.name);
        self.lastName = [fields objectForKey:@"lastname"];
        NSLog(@"lastname:%@",self.lastName);
        self.fullName = [NSString stringWithString:[[self.name stringByAppendingString:@" "] stringByAppendingString:self.lastName]];
        NSLog(@"fullname:%@",self.fullName);
        
        self.pictureUrl = [self getRealUrl:[fields objectForKey:@"picture"]];
        
        self.bio = [fields objectForKey:@"description"];
        self.longBio = [fields objectForKey:@"bio"];
        self.email = [fields objectForKey:@"email"];
        self.phone = [fields objectForKey:@"phone"];
        
        self.pk = [dict objectForKey:@"pk"];
        
        
    }
    return self;
}

-(NSString *)getRealUrl:(NSString *)localUrl
{
    NSString * localUrlFixed = [localUrl substringFromIndex:1];
    return [globals getIPImagesForUrl:localUrlFixed];
}

@end
