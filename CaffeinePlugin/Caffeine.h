/*
 * Caffeine.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class CaffeineApplication, CaffeineWindow, CaffeineApplication;

enum CaffeineSaveOptions {
	CaffeineSaveOptionsYes = 'yes ' /* Save the file. */,
	CaffeineSaveOptionsNo = 'no  ' /* Do not save the file. */,
	CaffeineSaveOptionsAsk = 'ask ' /* Ask the user whether or not to save the file. */
};
typedef enum CaffeineSaveOptions CaffeineSaveOptions;

enum CaffeinePrintingErrorHandling {
	CaffeinePrintingErrorHandlingStandard = 'lwst' /* Standard PostScript error handling */,
	CaffeinePrintingErrorHandlingDetailed = 'lwdt' /* print a detailed report of PostScript errors */
};
typedef enum CaffeinePrintingErrorHandling CaffeinePrintingErrorHandling;



/*
 * Standard Suite
 */

// The application's top-level scripting object.
@interface CaffeineApplication : SBApplication

- (SBElementArray *) windows;

@property (copy, readonly) NSString *name;  // The name of the application.
@property (readonly) BOOL frontmost;  // Is this the frontmost (active) application?
@property (copy, readonly) NSString *version;  // The version of the application.

- (void) turnOnFor:(NSInteger)for_;  // Activate Caffeine
- (void) turnOff;  // Deactivate Caffeine

@end

// A window.
@interface CaffeineWindow : SBObject

@property (copy, readonly) NSString *name;  // The full title of the window.
- (NSInteger) id;  // The unique identifier of the window.
@property NSInteger index;  // The index of the window, ordered front to back.
@property NSRect bounds;  // The bounding rectangle of the window.
@property (readonly) BOOL closeable;  // Whether the window has a close box.
@property (readonly) BOOL minimizable;  // Whether the window can be minimized.
@property BOOL minimized;  // Whether the window is currently minimized.
@property (readonly) BOOL resizable;  // Whether the window can be resized.
@property BOOL visible;  // Whether the window is currently visible.
@property (readonly) BOOL zoomable;  // Whether the window can be zoomed.
@property BOOL zoomed;  // Whether the window is currently zoomed.


@end



/*
 * Caffeine Suite
 */

// The Papaya application.
@interface CaffeineApplication (CaffeineSuite)

@property (readonly) BOOL active;  // Is Caffeine active?

@end

