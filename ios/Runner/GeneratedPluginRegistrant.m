//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <contacts_service/ContactsServicePlugin.h>
#import <fluttertoast/FluttertoastPlugin.h>
#import <sms_maintained/SmsPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [ContactsServicePlugin registerWithRegistrar:[registry registrarForPlugin:@"ContactsServicePlugin"]];
  [FluttertoastPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluttertoastPlugin"]];
  [SmsPlugin registerWithRegistrar:[registry registrarForPlugin:@"SmsPlugin"]];
}

@end
