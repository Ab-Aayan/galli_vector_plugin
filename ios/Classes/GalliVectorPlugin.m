#import "GalliVectorPlugin.h"
#import <galli_vector_plugin/galli_vector_plugin-Swift.h>

@implementation GalliVectorPlugin 
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMapboxGlFlutterPlugin registerWithRegistrar:registrar];
}
@end
