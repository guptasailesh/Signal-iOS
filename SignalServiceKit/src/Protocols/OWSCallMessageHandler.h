//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@class SSKProtoCallMessageAnswer;
@class SSKProtoCallMessageBusy;
@class SSKProtoCallMessageHangup;
@class SSKProtoCallMessageIceUpdate;
@class SSKProtoCallMessageOffer;
@class SignalServiceAddress;

@protocol OWSCallMessageHandler <NSObject>

- (void)receivedOffer:(SSKProtoCallMessageOffer *)offer
           fromCaller:(SignalServiceAddress *)caller
         sourceDevice:(uint32_t)device
      sentAtTimestamp:(uint64_t)sentAtTimestamp
     fromLegacyDevice:(BOOL)fromLegacyDevice NS_SWIFT_NAME(receivedOffer(_:from:sourceDevice:sentAtTimestamp:fromLegacyDevice:));

- (void)receivedAnswer:(SSKProtoCallMessageAnswer *)answer
            fromCaller:(SignalServiceAddress *)caller
          sourceDevice:(uint32_t)device
      fromLegacyDevice:(BOOL)fromLegacyDevice NS_SWIFT_NAME(receivedAnswer(_:from:sourceDevice:fromLegacyDevice:));

- (void)receivedIceUpdate:(NSArray<SSKProtoCallMessageIceUpdate *> *)iceUpdate
               fromCaller:(SignalServiceAddress *)caller
             sourceDevice:(uint32_t)device NS_SWIFT_NAME(receivedIceUpdate(_:from:sourceDevice:));

- (void)receivedHangup:(SSKProtoCallMessageHangup *)hangup
            fromCaller:(SignalServiceAddress *)caller
          sourceDevice:(uint32_t)device NS_SWIFT_NAME(receivedHangup(_:from:sourceDevice:));

- (void)receivedBusy:(SSKProtoCallMessageBusy *)busy
          fromCaller:(SignalServiceAddress *)caller
        sourceDevice:(uint32_t)device NS_SWIFT_NAME(receivedBusy(_:from:sourceDevice:));

@end

NS_ASSUME_NONNULL_END
