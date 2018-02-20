//
//  EZCCX.xm
//  EZCCX
//
//  Created by Juan Carlos Perez <carlos@jcarlosperez.me> on 02/19/2018.
//  Copyright © 2018 CP Digital Darkroom <tweaks@cpdigitaldarkroom.support>. All rights reserved.
//

#import "EZCCX.h"

static BOOL requestsUpSwipe = NO;

%hook SBReachabilityManager

-(void)_handleReachabilityActivated {
	if(!requestsUpSwipe) {
		[[NSClassFromString(@"SBControlCenterController") sharedInstance] presentAnimated:YES];
		return;
	}
	%orig;
}

-(void)homeGesturePerformedForBarSwipeAffordanceView:(id)arg1 {
	%orig;
	if(requestsUpSwipe) {
		[[NSClassFromString(@"SBControlCenterController") sharedInstance] presentAnimated:YES];
	}
}

%end

static void reloadSetting(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {

	requestsUpSwipe = [(id)CFPreferencesCopyAppValue((CFStringRef)@"RequestsSwipeUp", CFSTR("com.cpdigitaldarkroom.ezccx")) boolValue];
}

%ctor {

	if ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, reloadSetting, CFSTR("com.cpdigitaldarkroom.ezccx.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        reloadSetting(nil, nil, nil, nil, nil);
  	}
}
