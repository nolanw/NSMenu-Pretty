//
//  NSMenu+Pretty.h
//
//  Created by Nolan Waite on 12-01-18.
//  Public domain
//

#import <AppKit/AppKit.h>
#import "NSMenuItem+Pretty.h"

// Nicer-looking menus in code.
@interface NSMenu (Pretty)

// Create a new menu with a series of parsed menu items and/or submenus.
// Menu items that aren't a separator must be followed by a selector (or NULL).
// Submenus' titles are used for their respective items' titles.
// Preceed a menu item with PRETTY_ALTERNATE to make it an alternate.
+ (NSMenu *)nw_menuWithTitle:(NSString *)title items:(id)firstArg, ...
    NS_REQUIRES_NIL_TERMINATION;

// See NSMenuItem (Pretty)
// 
// Returns nil if parsing fails.
- (NSMenuItem *)nw_addMenuItemWithString:(NSString *)string;
- (NSMenuItem *)nw_addMenuItemWithString:(NSString *)string action:(SEL)action;
- (NSMenuItem *)nw_addMenuItemWithString:(NSString *)string
                                  action:(SEL)action
                             isAlternate:(BOOL)isAlternate;

// Create a new menu item by parsing the given string, then adds a new 
// submenu to it.
//
// Returns the newly-created submenu, or nil if parsing fails.
- (NSMenu *)nw_addSubmenuWithString:(NSString *)string;

// Add a menu as a submenu in an item with the same title.
- (void)nw_addSubmenu:(NSMenu *)menu;

extern NSString * const PRETTY_ALTERNATE;

@end
