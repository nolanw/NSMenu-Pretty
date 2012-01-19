//
//  NSMenu+Pretty.m
//
//  Created by Nolan Waite on 12-01-18.
//  Public domain
//

#import "NSMenu+Pretty.h"
#import "NSMenuItem+Pretty.h"

@implementation NSMenu (Pretty)

+ (NSMenu *)nw_menuWithTitle:(NSString *)title items:(id)firstArg, ...
{
    NSMenu *menu = [[NSMenu alloc] initWithTitle:title];
    va_list args;
    va_start(args, firstArg);
    for (id arg = firstArg; arg != nil; arg = va_arg(args, id))
    {
        if ([arg isKindOfClass:[NSString class]])
        {
            if (IsPrettySeparator(arg))
                [menu nw_addMenuItemWithString:arg];
            else
                [menu nw_addMenuItemWithString:arg action:va_arg(args, SEL)];
        }
        else if ([arg isKindOfClass:[NSMenu class]])
            [menu nw_addSubmenu:arg];
        else
        {
            [NSException raise:NSInvalidArgumentException
                        format:@"I only take strings and menus."];
        }
    }
    va_end(args);
    return menu;
}

- (NSMenuItem *)nw_addMenuItemWithString:(NSString *)string
{
    return [self nw_addMenuItemWithString:string action:NULL];
}

- (NSMenuItem *)nw_addMenuItemWithString:(NSString *)string action:(SEL)action
{
    NSMenuItem *menuItem = [NSMenuItem nw_menuItemWithString:string
                                                      action:action];
    if (menuItem)
        [self addItem:menuItem];
    return menuItem;
}

- (NSMenu *)nw_addSubmenuWithString:(NSString *)string
{
    NSMenuItem *submenuHolder = [self nw_addMenuItemWithString:string];
    if (!submenuHolder)
        return nil;
    submenuHolder.submenu = [[NSMenu alloc] initWithTitle:submenuHolder.title];
    return submenuHolder.submenu;
}

- (void)nw_addSubmenu:(NSMenu *)menu
{
    [self nw_addMenuItemWithString:menu.title].submenu = menu;
}

@end
