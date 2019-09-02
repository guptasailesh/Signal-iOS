//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

#import "OWSDisappearingMessagesConfiguration.h"
#import <SignalCoreKit/NSDate+OWS.h>
#import <SignalCoreKit/NSString+OWS.h>
#import <SignalServiceKit/SignalServiceKit-Swift.h>

NS_ASSUME_NONNULL_BEGIN

@implementation OWSDisappearingMessagesConfiguration

- (instancetype)initDefaultWithThreadId:(NSString *)threadId
{
    return [self initWithThreadId:threadId
                          enabled:NO
                  durationSeconds:OWSDisappearingMessagesConfigurationDefaultExpirationDuration];
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];

    return self;
}

- (instancetype)initWithThreadId:(NSString *)threadId enabled:(BOOL)isEnabled durationSeconds:(uint32_t)seconds
{
    self = [super initWithUniqueId:threadId];
    if (!self) {
        return self;
    }

    _enabled = isEnabled;
    _durationSeconds = seconds;

    return self;
}

// --- CODE GENERATION MARKER

// This snippet is generated by /Scripts/sds_codegen/sds_generate.py. Do not manually edit it, instead run
// `sds_codegen.sh`.

// clang-format off

- (instancetype)initWithUniqueId:(NSString *)uniqueId
                 durationSeconds:(unsigned int)durationSeconds
                         enabled:(BOOL)enabled
{
    self = [super initWithUniqueId:uniqueId];

    if (!self) {
        return self;
    }

    _durationSeconds = durationSeconds;
    _enabled = enabled;

    return self;
}

// clang-format on

// --- CODE GENERATION MARKER

+ (instancetype)fetchOrBuildDefaultWithThreadId:(NSString *)threadId transaction:(SDSAnyReadTransaction *)transaction
{
    OWSDisappearingMessagesConfiguration *savedConfiguration =
        [self anyFetchWithUniqueId:threadId transaction:transaction];
    if (savedConfiguration) {
        return savedConfiguration;
    } else {
        return [[self alloc] initDefaultWithThreadId:threadId];
    }
}

+ (NSArray<NSNumber *> *)validDurationsSeconds
{
    return @[
        @(5 * kSecondInterval),
        @(10 * kSecondInterval),
        @(30 * kSecondInterval),
        @(1 * kMinuteInterval),
        @(5 * kMinuteInterval),
        @(30 * kMinuteInterval),
        @(1 * kHourInterval),
        @(6 * kHourInterval),
        @(12 * kHourInterval),
        @(24 * kHourInterval),
        @(1 * kWeekInterval)
    ];
}

+ (uint32_t)maxDurationSeconds
{
    static uint32_t max;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        max = [[self.validDurationsSeconds valueForKeyPath:@"@max.intValue"] unsignedIntValue];

        // It's safe to update this assert if we add a larger duration
        OWSAssertDebug(max == 1 * kWeekInterval);
    });

    return max;
}

- (NSUInteger)durationIndex
{
    return [[self.class validDurationsSeconds] indexOfObject:@(self.durationSeconds)];
}

- (NSString *)durationString
{
    return [NSString formatDurationSeconds:self.durationSeconds useShortFormat:NO];
}

#pragma mark - Dirty Tracking

+ (OWSDisappearingMessagesConfiguration *)disappearingMessagesConfigurationForThreadId:(NSString *)threadId
                                                                           transaction:
                                                                               (SDSAnyReadTransaction *)transaction
{
    OWSAssertDebug(threadId.length > 0);
    OWSAssertDebug(transaction != nil);

    return [OWSDisappearingMessagesConfiguration fetchOrBuildDefaultWithThreadId:threadId transaction:transaction];
}

- (BOOL)hasChangedWithTransaction:(SDSAnyReadTransaction *)transaction
{
    OWSDisappearingMessagesConfiguration *oldConfiguration =
        [OWSDisappearingMessagesConfiguration fetchOrBuildDefaultWithThreadId:self.uniqueId transaction:transaction];
    return ![self.dictionaryValue isEqual:[oldConfiguration dictionaryValue]];
}

@end

NS_ASSUME_NONNULL_END
