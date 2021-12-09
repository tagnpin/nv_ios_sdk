//
//  notifyvisitors.h
//  notifyvisitors
//
//  Created by Siddharth Gupta on 22/01/16.
//  Copyright © 2016 notifyvisitors. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^NotificationListData)(NSMutableArray* _Nullable);
typedef void(^nvGetCount)(NSInteger);
typedef void(^NotificationClickResponseData)(NSMutableDictionary* _Nullable);
typedef void(^nv_UID)(NSString *_Nullable);
//extern  NSString * _Nonnull  NVInAppViewController1;

@protocol notifyvisitorsDelegate <NSObject>

@optional
-(void)NotifyvisitorsChatBotActionCallbackWithUserInfo:(NSDictionary*_Nullable)userInfo;

-(void)NotifyvisitorsGetEventResponseWithUserInfo:(NSDictionary*_Nullable)userInfo;
@end

@interface NVCenterStyleConfig : NSObject

@property (strong, nonatomic, nullable)UIColor *unselectedTabTextColor;

@property (strong, nonatomic, nullable)UIColor *selectedTabTextColor;

@property (strong, nonatomic, nullable)UIColor *selectedTabBgColor;
@property (strong, nonatomic, nullable)UIColor *unselectedTabBgColor;

@property (nonatomic)NSInteger selectedTabIndex;
@property (strong, nonatomic, nullable)UIFont *tabTextfont;
//@property (strong, nonatomic, nullable)UIFont *tabBadgeCountfont;
@property (strong, nonatomic, nullable)UIColor *tabBadgeCountBorderColor;
@property (strong, nonatomic, nullable)UIColor *tabBadgeCountFillColor;
@property (strong, nonatomic, nullable)UIColor *tabBadgeCountTextColor;
@property (nonatomic)BOOL shouldTabBadgeShine;

+(instancetype _Nullable )sharedInstance;

-(void)setFirstTabWithTabLable:(NSString *_Nonnull)tabLabel TagDisplayName:(NSString *_Nonnull)tabDisplayName;

-(void)setSecondTabWithTabLable:(NSString *_Nonnull)tabLabel TagDisplayName:(NSString *_Nonnull)tabDisplayName;

-(void)setThirdTabWithTabLable:(NSString *_Nonnull)tabLabel TagDisplayName:(NSString *_Nonnull)tabDisplayName;

@end




#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
@interface notifyvisitors : NSObject <UNUserNotificationCenterDelegate>

//# << iOS 10 Push notification delegate and service extension methods

+(void)LoadAttachmentWithRequest:(UNNotificationRequest *_Nullable)request bestAttemptContent:(UNMutableNotificationContent *_Nullable)bestAttemptContent withContentHandler:(nullable void (^)(UNNotificationContent * _Nonnull))contentHandler API_AVAILABLE(ios(10.0));
+(void)willPresentNotification:(UNNotification *_Nullable)notification withCompletionHandler:(void (^_Nullable)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0));
+(void)didReceiveNotificationResponse:(UNNotificationResponse *_Nullable)response API_AVAILABLE(ios(10.0));
+(void)PushNotificationActionDataFromResponse:(UNNotificationResponse *_Nullable)response AutoRedirectOtherApps:(BOOL)autoRedirect clickResponseData:(NotificationClickResponseData _Nullable)pushClickResponse API_AVAILABLE(ios(10.0));
//+(NSMutableDictionary *)PushNotificationActionDataFromResponse:(UNNotificationResponse *)response AutoRedirectOtherApps:(BOOL)autoRedirect API_AVAILABLE(ios(10.0));
+(void)didReceiveRemoteNotification:(NSDictionary *_Nullable)userInfo fetchCompletionHandler:(void(^_Nullable)(UIBackgroundFetchResult))completionHandler;
#else


// iOS 10 Push notification delegate and service extension methods>>


@interface notifyvisitors : NSObject
#endif
@property (nonatomic, weak)id <notifyvisitorsDelegate> _Nullable delegate;

+(instancetype _Nullable )sharedInstance;
+(void)Initialize:(NSString *_Nullable)nvMode;

+(void)RegisterPushWithDelegate:(id _Nullable)delegate App:(UIApplication * _Nullable)application launchOptions:(NSDictionary *_Nullable)launchOptions;
+(void)DidRegisteredNotification:(UIApplication *_Nullable)application deviceToken:(NSData * _Nullable)deviceToken;
+(void)didReceiveRemoteNotificationWithUserInfofor_iOS7orBelow:(NSDictionary *_Nullable)userInfo;

+(void)didReceiveRemoteNotificationWithUserInfo:(NSDictionary * _Nullable)userInfo;

+(NSMutableDictionary * _Nullable)PushNotificationActionDataFromUserInfo:(NSDictionary *_Nullable)userinfo;

+(void)OpenUrlWithApplication:(UIApplication *_Nullable)application Url:(NSURL *_Nullable)url;
+(NSMutableDictionary* _Nullable)OpenUrlGetDataWithApplication: (UIApplication * _Nullable)application Url:(NSURL * _Nullable)url;

+(void)Show:(NSMutableDictionary * _Nullable)UserTokens CustomRule:(NSMutableDictionary  * _Nullable)customRule;
+(void)UserIdentifier:(NSString *_Nullable) userID UserParams:(NSMutableDictionary * _Nullable) UserParams;
+(void)checkSetupComplete:(NSTimer * _Nullable)timer;
+(void)scrollViewDidScroll:(UIScrollView * _Nullable) scrollView;
+(BOOL)isScrolled:(NSString * _Nullable)NotificationID;
+(void)trackEvents:(NSString * _Nullable)event_name Attributes:(NSMutableDictionary * _Nullable)attributes lifetimeValue:(NSString * _Nullable)ltv Scope:(int)scope;

+(void)schedulePushNotificationwithNotificationID:(NSString * _Nullable)NID Tag:(NSString * _Nullable)tag TimeinSecond:(NSString * _Nullable)time Title:(NSString * _Nullable)title  Message:(NSString * _Nullable)message URL:(NSString * _Nullable)url  Icon:(NSString * _Nullable)icon;

+(void)pushPreferences:(NSArray*_Nullable)preferenceList;
//+(void)checkFetchClickComplete:(NSTimer * _Nullable)timer;
+(void)NotifyVisitorsNotificationCentre;
+(void)notificationCenterWithConfiguration:(NVCenterStyleConfig *_Nullable)configuration;


+(void)GetUnreadPushNotification:(nvGetCount _Nullable )UnreadCount;

//+(NSInteger)GetUnreadPushNotification;
//+(NSMutableArray * _Nullable)GetNotificationCentreData;
+ (void)GetNotificationCentreData:(NotificationListData _Nullable) notificationDataList;

+(void)NotifyVisitorsGeofencing;

+(void) NotifyVisitorsGeofencingReceivedNotificationWithApplication: (UIApplication * _Nullable) application window: (UIWindow * _Nullable) window didReceiveGeofencingNotification:(UILocalNotification * _Nullable) notification;

+(void)HandleLocalNotifications: (UILocalNotification *_Nullable) notification;

+(void)NotifyVisitorsGeofencingApplicationDidEnterBackground:(UIApplication *_Nullable)application DEPRECATED_MSG_ATTRIBUTE("first deprecated in Notifyvisitors iOS SDK 4.1.0 Use [notifyvisitors applicationDidEnterBackground:] (see notifyvisitors.h)");

//API_DEPRECATED(@"%@ %@",nvDeprecatedInSDKVersion, nvGeoDeprecatedInBackgroundMsg);
+(void)NotifyVisitorsGeofencingapplicationDidBecomeActive:(UIApplication *_Nullable)application DEPRECATED_MSG_ATTRIBUTE("first deprecated in Notifyvisitors iOS SDK 4.1.0 Use [notifyvisitors applicationDidBecomeActive:] (see notifyvisitors.h)");


+(void)applicationDidEnterBackground:(UIApplication *_Nullable)application;
+(void)applicationDidBecomeActive:(UIApplication *_Nullable)application;
+(void)applicationWillEnterForeground:(UIApplication *_Nullable)application;
+(void)applicationWillTerminate;

+(void)DismissAllNotifyvisitorsInAppNotifications;
+(void)StopInAppNotifications;
+(void)stopPushNotification:(BOOL)pushStatus;
+(void)stopGeofencePushforDateTime:(NSString *_Nullable)nvDateTime additionalHours: (NSInteger)nvtimeinHours;
//+(void)setChatBotDelegate:(id _Nullable)aDelegate;


+(void)startChatBotWithScreenName: (NSString *_Nullable)nvBotScreenName;
+(void)getNvUid:(nv_UID _Nullable)nvUID;
+(void)requestAppleAppStoreInAppReview;




@end





//
//@property (nonatomic, strong, nullable) NSString *title;
//@property (nonatomic, strong, nullable) UIColor *backgroundColor;
//@property (nonatomic, strong, nullable) NSArray *messageTags;
//@property (nonatomic, strong, nullable) UIColor *navigationBarTintColor;
//@property (nonatomic, strong, nullable) UIColor *navigationTintColor;
//@property (nonatomic, strong, nullable) UIColor *tabSelectedBgColor;
//@property (nonatomic, strong, nullable) UIColor *tabSelectedTextColor;
//@property (nonatomic, strong, nullable) UIColor *tabUnSelectedTextColor;
//@property (nonatomic, strong, nullable) NSString *noMessageViewText;
//@property (nonatomic, strong, nullable) UIColor *noMessageViewTextColor;
//@property (nonatomic, strong, nullable) NSString *firstTabTitle;
//

//
//
//
