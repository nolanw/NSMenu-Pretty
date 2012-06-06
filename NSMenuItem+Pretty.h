//
//  NSMenuItem+Pretty.h
//
//  Created by Nolan Waite on 12-01-18.
//  Public domain
//

#import <AppKit/AppKit.h>

// Nicer-looking menu items in code.
@interface NSMenuItem (Pretty)

// Parse a string into a menu item with a title and optional key equivalent.
//
// Examples:
//
//   [NSMenuItem nw_menuItemWithString:@"Preferences…  ⌘,"];
//   [NSMenuItem nw_menuItemWithString:@"Hide Others  ⌥⌘H"];
//   (note two spaces separating title from key equivalent);
//   [NSMenuItem nw_menuItemWithString:@"----------------"];
//
// Returns nil if parsing fails.
+ (NSMenuItem *)nw_menuItemWithString:(NSString *)string;

// Same as above with an action too.
+ (NSMenuItem *)nw_menuItemWithString:(NSString *)string action:(SEL)action;

// Same as above but may be an alternate menu item.
+ (NSMenuItem *)nw_menuItemWithString:(NSString *)string
                               action:(SEL)action
                          isAlternate:(BOOL)isAlternate;

// Returns YES if the menu item string should parse as a separator.
extern BOOL IsPrettySeparator(NSString *item);

@end
