//
//  CPActiveAction.m
//  CaffeinePlugin
//
//  Created by Rick Fillion on 11-10-26.
//  Copyright (c) 2011 Oomph. All rights reserved.
//

#import "CPActiveAction.h"
#import <ScriptingBridge/ScriptingBridge.h>
#import "Caffeine.h"
#import "CPActiveActionOptionSheetController.h"

#define CPApplicationName @"Caffeine"
#define CPApplicationBundleIdentifier @"com.lightheadsw.Caffeine"

@interface CPActiveAction (Private)

- (BOOL)isCaffeineActive;
- (void)setCaffeineActive:(BOOL)active;

@end


@implementation CPActiveAction


- (void)dealloc
{
	[oldActive release];
	[super dealloc];
}

+ (NSString *)actionID
{
    return @"ActiveAction";
}

+ (NSString *)title
{
    return @"Control Caffeine...";
}

+ (BOOL) invisible
{
	NSString *path = [[NSWorkspace sharedWorkspace] fullPathForApplication:CPApplicationName];
	if (!path)
		return YES;
	return NO;
}

- (NSString *)title
{
	NSNumber *active = [[self options] valueForKey:@"active"];
    return [NSString stringWithFormat:@"Turn Caffeine %@", [active boolValue] ? @"On" : @"Off"];
}

+ (NSImage *)icon
{
	NSString *path = [[NSWorkspace sharedWorkspace] fullPathForApplication:CPApplicationName];
	return [[NSWorkspace sharedWorkspace] iconForFile:path];
}

- (Class)optionSheetControllerClass
{
    return [CPActiveActionOptionSheetController class];
}

- (void)performActionWithContext:(SKActionContext *)actionContext
{
	[oldActive release];
	oldActive = [[NSNumber numberWithBool:[self isCaffeineActive]] retain];
	
	NSNumber *active = [[self options] valueForKey:@"active"];
	[self setCaffeineActive:[active boolValue]];
}

- (void) cleanupActionWithContext:(SKActionContext *)actionContext
{
	if (oldActive)
	{
		[self setCaffeineActive: [oldActive boolValue]];
		[oldActive release];
		oldActive = nil;
	}
}

- (NSDictionary *)optionDefaults
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:[self isCaffeineActive]], @"active",
            nil];
}


#pragma mark -
#pragma mark Private

- (BOOL)isCaffeineActive
{
	return NO; // Apparently the scripting for this is broken.
	CaffeineApplication *application = (CaffeineApplication*)[SBApplication applicationWithBundleIdentifier:CPApplicationBundleIdentifier];
	return [application active];
}
- (void)setCaffeineActive:(BOOL)active
{
	NSDictionary *errorInfo = nil;
	NSString *turnOnScript = @"tell application \"Caffeine\" to turn on";
	NSString *turnOffScript = @"tell application \"Caffeine\" to turn off";
	
	NSAppleScript *applescript = [[[NSAppleScript alloc] initWithSource: active ? turnOnScript : turnOffScript] autorelease];
	[applescript executeAndReturnError: &errorInfo];
	
	return;
	// Apparently scripting for this is broken.
	CaffeineApplication *application = (CaffeineApplication*)[SBApplication applicationWithBundleIdentifier:CPApplicationBundleIdentifier];
	if (active)
		[application turnOnFor: 0];
	else
		[application turnOff];
}

@end
