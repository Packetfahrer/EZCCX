//
//  EZCCX.h
//  EZCCX
//
//  Created by Juan Carlos Perez <carlos@jcarlosperez.me> on 02/19/2018.
//  Copyright © 2018 CP Digital Darkroom <tweaks@cpdigitaldarkroom.support>. All rights reserved.
//

#define kPrefDomain "com.cpdigitaldarkroom.ezccx"

@interface SBControlCenterController : NSObject

+(id)sharedInstance;

- (void)presentAnimated:(BOOL)arg1;

@end

@interface SBReachabilityManager : NSObject

-(void)deactivateReachabilityModeForObserver:(id)arg1;

@end
