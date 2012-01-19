NSMenu+Pretty
==========

*Nicer-looking menus in code.*

Example
----------

A fully functional main menu, in case you lose MainMenu.nib. (Works great in `-applicationDidFinishLoading:`.)

```objective-c
NSApplication *app = [NSApplication sharedApplication];
app.servicesMenu = [NSMenu nw_menuWithTitle:@"Services" items:nil];
app.mainMenu = [NSMenu nw_menuWithTitle:@"MainMenu" items:
    [NSMenu nw_menuWithTitle:@"Shiny" items:
        @"About Shiny",       @selector(orderFrontStandardAboutPanel:),
        @"----------------",
        @"Preferences…  ⌘,",  NULL,
        @"----------------",
        app.servicesMenu,
        @"----------------",
        @"Hide Shiny  ⌘H",    @selector(hide:),
        @"Hide Others  ⌥⌘H",  @selector(hideOtherApplications:),
        @"Show All",          @selector(unhideAllApplications:),
        @"----------------",
        @"Quit Shiny  ⌘Q",    @selector(terminate:),
    nil],
nil];
app.windowsMenu = [NSMenu nw_menuWithTitle:@"Window" items:
    @"Minimize  ⌘M",        @selector(performMiniaturize:),
    @"Zoom",                @selector(performZoom:),
    @"------------------",
    @"Bring All to Front",  @selector(arrangeFront:),
nil];
[app.mainMenu nw_addSubmenu:app.windowsMenu];
```
