//
//  NSMenuItem+Pretty.m
//
//  Created by Nolan Waite on 12-01-18.
//  Public domain
//

#import "NSMenuItem+Pretty.h"

@implementation NSMenuItem (Pretty)

+ (NSMenuItem *)nw_menuItemWithString:(NSString *)string
{
    return [self nw_menuItemWithString:string action:NULL];
}

static NSUInteger ModifierMaskForKeyboardSymbols(NSString *symbols);

static NSString * const Symbols = @"⌘⌥⇧^";

static const NSUInteger KeyMasks[] =
{
    NSCommandKeyMask,
    NSAlternateKeyMask,
    NSShiftKeyMask,
    NSControlKeyMask,
};

BOOL IsPrettySeparator(NSString *item)
{
    return [item hasPrefix:@"---"];
}

+ (NSMenuItem *)nw_menuItemWithString:(NSString *)string action:(SEL)action
{
    return [self nw_menuItemWithString:string action:action isAlternate:NO];
}

+ (NSMenuItem *)nw_menuItemWithString:(NSString *)string
                               action:(SEL)action
                          isAlternate:(BOOL)isAlternate
{
    if (IsPrettySeparator(string))
        return [NSMenuItem separatorItem];
    
    NSArray *itemParts = [string componentsSeparatedByString:@"  "];
    if ([itemParts count] == 0)
        itemParts = [NSArray arrayWithObject:string];
    NSMenuItem *item = [NSMenuItem new];
    item.title = [itemParts objectAtIndex:0];
    item.action = action;
    [item setAlternate:isAlternate];
    if (itemParts.count == 1)
        return item;
    
    NSString *hotkey = [itemParts objectAtIndex:1];
    item.keyEquivalentModifierMask = ModifierMaskForKeyboardSymbols(hotkey);
    static NSCharacterSet *symbolSet = nil;
    if (!symbolSet)
        symbolSet = [NSCharacterSet characterSetWithCharactersInString:Symbols];
    item.keyEquivalent = [hotkey stringByTrimmingCharactersInSet:symbolSet];
    item.keyEquivalent = [item.keyEquivalent lowercaseString];
    return item;
}

static NSUInteger ModifierMaskForKeyboardSymbols(NSString *symbols)
{
    NSUInteger modifierMask = 0;
    for (NSUInteger i = 0; i < symbols.length; i++)
    {
        NSString *symbol = [symbols substringWithRange:NSMakeRange(i, 1)];
        NSRange symbolRange = [Symbols rangeOfString:symbol];
        if (symbolRange.length > 0)
            modifierMask |= KeyMasks[symbolRange.location];
    }
    return modifierMask;
}

@end
