//
//  CPPlugin.m
//  CaffeinePlugin
//
//  Created by Rick Fillion on 11-10-26.
//  Copyright (c) 2011 Oomph. All rights reserved.
//

#import "CPPlugin.h"
#import "CPActiveAction.h"

@implementation CPPlugin

- (NSArray *)actions
{
    return [NSArray arrayWithObjects:
            [CPActiveAction class],
            nil];
}


@end
