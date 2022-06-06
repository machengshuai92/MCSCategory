//  Created by Frank on 2019/2/18.
//  Copyright © 2019年 DJ. All rights reserved.
//

typedef enum : NSUInteger {
    ///早上 05:00-08:59
    CurrentTimeBelongToMorning      = 0,
    ///上午 09:00-11:59
    CurrentTimeBelongToForenoon     = 1,
    ///中午 12:00-13:59
    CurrentTimeBelongToNoon         = 2,
    ///下午 14:00-17:59
    CurrentTimeBelongToAfternoon    = 3,
    ///傍晚 18:00-18:59
    CurrentTimeBelongToEvening      = 4,
    ///晚上 19:00-23:59
    CurrentTimeBelongToNight        = 5,
    ///凌晨 00:00-04:59
    CurrentTimeBelongToBeforedawn   = 6,
    ///未知
    CurrentTimeBelongToUnknow       = 7
} CurrentTimeBelongTo;

@interface NSString (Add)


#pragma mark - Utilities
///=============================================================================
/// @name Utilities
///=============================================================================

/**
 Returns a new UUID NSString
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
+ (NSString *_Nonnull)stringWithUUID;

/**
 字符串正则表达式校验
 */
- (BOOL)isValidWithRegex:(NSString*_Nonnull)regex;

- (NSString *_Nullable)decodeFromPercentEscapeString:(NSString *)input;//url转义
- (NSString *_Nullable)timeWithTimeIntervalString;// 时间戳转化为时间


- (CGFloat)fetchHeightWithConstantWide:(CGFloat)Wide font:(UIFont *_Nullable)font;//根据nsstring固定宽度获取高度



- (BOOL)validateIdentityCard;//是否是身份证号
- (NSDictionary*_Nullable)dictionaryFromQueryUsingEncoding:(NSStringEncoding)encoding;  //将&符分割的字符串转化为字典
+ (NSString *_Nullable)keyValueStringWithDict:(NSDictionary *_Nullable)dict;//将字典转化为=拼接的字符串

- (id _Nonnull )jsonValue; //json转换

+ (NSString *_Nullable)timeFormatted:(NSInteger)totalSeconds;//iOS 秒数转换成时间,时，分，秒

-(NSString *_Nullable)compareDate:(NSDate *)date; //日期对比

/** 根据出生日期返回年龄的方法  **/
+(NSString*_Nonnull)dateToOld:(NSString*)bornDate;

-(NSString *_Nullable)getCodeFromCountryNameAndCode; //从国家名称和区号信息取区号


- (NSURL *)urlScheme:(NSString *)scheme;

-(NSString *)urlStringAppendCommonPataments;  //web url 拼接公共参数

#pragma mark - Hash
///=============================================================================
/// @name Hash
///=============================================================================

/**
 Returns a lowercase NSString for md2 hash.
 */
- (nullable NSString *)md2String;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (nullable NSString *)md4String;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (nullable NSString *)md5String;


/**
 sha1 编码

 @return 
 */
-(NSString*)sha1;

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *_Nonnull)stringByTrim;



#pragma mark - Drawing
///=============================================================================
/// @name Drawing
///=============================================================================

/**
 Returns the size of the string if it were rendered with the specified constraints.
 
 @param font          The font to use for computing the string size.
 
 @param size          The maximum acceptable size for the string. This value is
 used to calculate where line breaks and wrapping would occur.
 
 @param lineBreakMode The line break options for computing the size of the string.
 For a list of possible values, see NSLineBreakMode.
 
 @return              The width and height of the resulting string's bounding box.
 These values may be rounded up to the nearest whole number.
 */
- (CGSize)sizeForFont:(UIFont *_Nonnull)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 Returns the width of the string if it were to be rendered with the specified
 font on a single line.
 
 @param font  The font to use for computing the string width.
 
 @return      The width of the resulting string's bounding box. These values may be
 rounded up to the nearest whole number.
 */
- (CGFloat)widthForFont:(UIFont *_Nullable)font;

/**
 Returns the height of the string if it were rendered with the specified constraints.
 
 @param font   The font to use for computing the string size.
 
 @param width  The maximum acceptable width for the string. This value is used
 to calculate where line breaks and wrapping would occur.
 
 @return       The height of the resulting string's bounding box. These values
 may be rounded up to the nearest whole number.
 */
- (CGFloat)heightForFont:(UIFont *_Nullable)font width:(CGFloat)width;

- (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize Width:(CGFloat)width;

+(NSString *)getDistanceLat1:(NSString *)lat1 :(NSString *)lng1 :(NSString *)lat2 :(NSString *)lng2;  //经纬度转距离

//** 数量过万格式化 **//
+ (NSString *)formatCount:(NSInteger)count;

/** 获取当前时间*/
+ (NSString *)getCurrentTimeWithFormat:(NSString *)format;

/** 获取时间戳(毫秒为单位)*/
+(NSString *_Nonnull)getNowTimeTimestamp3;

/** 获取总周数*/
+ (NSInteger)getWeekNumYear:(NSInteger)year;

/** 获取第几周*/
+ (NSString *_Nonnull)getWeekNumInYear;

- (NSString *_Nonnull)removeKongGe;

/// 获取当前时间所属时间段
+ (CurrentTimeBelongTo)getCurrentTimeBelongTo;

/// 获取某一天是周几
/// @param date 日期 传nil默认当天
+ (NSString *_Nonnull)getWeekDayFordate:(NSDate *_Nullable)date;

/// 获取视频时长
- (NSTimeInterval)getVideoTime;

@end

