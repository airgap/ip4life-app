#import <Cocoa/Cocoa.h>

@interface MBAAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readwrite, retain) IBOutlet NSMenu *menu;
@property (readwrite, retain) IBOutlet NSStatusItem *statusItem;
@property (readwrite, retain) IBOutlet NSMenuItem *ipAddressItem;
@property (nonatomic, retain) NSMutableData* responseData;

- (IBAction)menuAction:(id)sender;

- (IBAction)show:(id)sender;
- (IBAction)refreshAction:(NSMenuItem *)sender;

@end
