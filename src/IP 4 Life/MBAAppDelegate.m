#import "MBAAppDelegate.h"

@implementation MBAAppDelegate

- (void)awakeFromNib {
    _responseData = [NSMutableData new];
  _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  
//  NSImage *menuIcon       = [NSImage imageNamed:@"Menu Icon"];
//  NSImage *highlightIcon  = [NSImage imageNamed:@"Menu Icon"]; // Yes, we're using the exact same image asset.
//  [highlightIcon setTemplate:YES]; // Allows the correct highlighting of the icon when the menu is clicked.
  
//  [[self statusItem] setImage:menuIcon];
//  [[self statusItem] setAlternateImage:highlightIcon];
  [[self statusItem] setMenu:[self menu]];
  [[self statusItem] setHighlightMode:YES];
    [self refreshIp];
}

- (IBAction)menuAction:(id)sender {
  NSLog(@"menuAction:");
}

- (IBAction)refreshAction:(NSMenuItem *)sender {
//    [[self ipAddressItem] setTitle:[NSString stringWithFormat:@"%@", [NSDate now]]];
    [self refreshIp];
}

- (void)refreshIp {
//    NSImage *menuIcon       = [NSImage imageNamed:@"Menu Icon"];
//    [[self statusItem] setImage:menuIcon];
    [[self statusItem] setTitle:@"???.???.??.???"];
    NSURL *url = [NSURL URLWithString:@"https://ip4.life/auto"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setHTTPMethod:@"GET"];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
    [[self ipAddressItem] setTitle:@"got response"];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [_responseData appendData:data];
    [[self ipAddressItem] setTitle:@"got data"];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
  
  NSString* responseString = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
//  NSLog(@"the html from google was %@", responseString);
    [[self statusItem] setTitle:responseString];
    [[self ipAddressItem] setHidden:true];
//    [[self statusItem] setImage:nil];
//    [[self ipAddressItem] setTitle:[NSString stringWithFormat:@"checked %@", [NSDate now]]];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  NSLog(@"something very bad happened here");
    [[self ipAddressItem] setTitle:[NSString stringWithFormat:@"%@", error]];
    [[self ipAddressItem] setHidden:false];
}



- (IBAction)show:(id)sender {
    
}

@end
