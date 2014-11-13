//
//  globals.m
//  Flavour v0.6
//
//  Created by Demian Schkolnik on 11/12/14.
//  Copyright (c) 2014 Schkolnik. All rights reserved.
//

#import "globals.h"

@implementation globals

+(NSString*) getIp
{
    return @"http://186.107.98.151:8001";
}

+(NSString*) getChefsIp
{
    return [[self getIp] stringByAppendingString:@"/data/chefs?comuna=las%20condes"];
}

+(NSString *) getIPMenusForChef:(NSString*)chefId
{
    return [[self getIp] stringByAppendingString:
            [NSString stringWithFormat:@"/data/menus?chefId=%@", chefId]];
}

+(NSString *) getIPDatesForChef:(NSString*)chefId
{
    return [[self getIp] stringByAppendingString:
            [NSString stringWithFormat:@"/data/dates?chefId=%@", chefId]];
}

+(NSString *) getIPImagesForUrl:(NSString*)localUrl
{
    return [[self getIp] stringByAppendingString:
            [@"/media" stringByAppendingString:localUrl]];
}

+(NSString *) getPostOrderIP
{
    return [[self getIp] stringByAppendingString:@"/reserva/"];
}
            
@end
