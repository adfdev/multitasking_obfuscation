#import "MultitaskingObfuscationPlugin.h"
#if __has_include(<multitasking_obfuscation/multitasking_obfuscation-Swift.h>)
#import <multitasking_obfuscation/multitasking_obfuscation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "multitasking_obfuscation-Swift.h"
#endif

@implementation MultitaskingObfuscationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMultitaskingObfuscationPlugin registerWithRegistrar:registrar];
}
@end
