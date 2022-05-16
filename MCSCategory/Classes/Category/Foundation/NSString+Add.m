//
//  __  __          ____           _          _
//  \ \/ / /\_/\   /___ \  _   _  (_)   ___  | | __
//   \  /  \_ _/  //  / / | | | | | |  / __| | |/ /
//   /  \   / \  / \_/ /  | |_| | | | | (__  |   <
//  /_/\_\  \_/  \___,_\   \__,_| |_|  \___| |_|\_\
//
//  Copyright (C) Heaven.
//
//	https://github.com/uxyheaven/XYQuick
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import "NSString+Add.h"
#import "NSData+YYAdd.h"
#import <CoreLocation/CoreLocation.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Add)

#pragma mark - Utilities
+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}
- (id)jsonValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}
+(NSString*)dateToOld:(NSString*)bornDate {
    //设置时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *expireDate = [formatter dateFromString:bornDate];
    NSTimeInterval timeAge = [expireDate timeIntervalSinceNow];
    timeAge = timeAge/(3600*24*365);
    NSString *age = nil;
    if (timeAge == 0) {
        age = [NSString stringWithFormat:@"%ld",(long)timeAge];
    }else{
        age = [[NSString stringWithFormat:@"%ld",(long)timeAge] substringFromIndex:1];
    }
    return age;
}
-(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}

// url转义
- (NSString *)decodeFromPercentEscapeString:(NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@""
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSDictionary*)dictionaryFromQueryUsingEncoding:(NSStringEncoding)encoding
{
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

+ (NSString *)keyValueStringWithDict:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
  //  NSMutableString *string = [NSMutableString stringWithString:@"?"];
     NSMutableString *string = [NSMutableString stringWithString:@""];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"%@=%@&",key,obj];
    }];
    
    if ([string rangeOfString:@"&"].length) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }
    
    return string;
}

- (BOOL)isValidWithRegex:(NSString*)regex{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:self];
}
//身份证号
- (BOOL)validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex= @"^(\\d{14}|\\d{17})(\\d|[xX])$";

    
 //   NSString *regex=@"^([1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3})|([1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X))$";
    
    
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [identityCardPredicate evaluateWithObject:self];
    return isMatch;
}

- (CGFloat)fetchHeightWithConstantWide:(CGFloat)Wide font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Wide, 0)];
    label.text = self;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label.frame.size.height;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}


- (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize Width:(CGFloat)width
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font ,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    return sizeToFit.size.height;
}


+ (NSString *)timeFormatted:(NSInteger)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

- (NSString *)timeWithTimeIntervalString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


-(NSString *_Nullable)getCodeFromCountryNameAndCode{
    NSAssert(self, @"区号不能为空");
    NSArray *codeArray = [self componentsSeparatedByString:@"+"];
    NSString *codeString = codeArray[1];
    return codeString;
}

- (NSURL *)urlScheme:(NSString *)scheme {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:self] resolvingAgainstBaseURL:NO];
    components.scheme = scheme;
    return [components URL];
}

//** 数量过万格式化 **//
+ (NSString *)formatCount:(NSInteger)count {
    if(count < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)count];
    }else {
        return [NSString stringWithFormat:@"%.1fw",count/10000.0f];
    }
}
+(NSString *)getDistanceLat1:(NSString *)lat1 :(NSString *)lng1 :(NSString *)lat2 :(NSString *)lng2{
    double lat_f = [lat1 doubleValue];
    double lng_f = [lng1 doubleValue];
    double nowLat_f = [lat2 doubleValue];
    double nowLng_f = [lng2 doubleValue];
    CLLocation  *orig = [[CLLocation alloc] initWithLatitude:lat_f longitude:lng_f];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:nowLat_f longitude:nowLng_f];
    CLLocationDistance km = [orig distanceFromLocation:dist]/1000;
    NSString *string =nil;
    if (km>50) {
        string=@">50";
    }else{
        string = [NSString stringWithFormat:@"%.1f",km];
    }
    return string;
}
#pragma mark - Hash
- (NSString *)md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md2String];
}

- (NSString *)md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md4String];
}
- (NSString *)md5String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}


//sha1 encode
-(NSString*)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString *)getCurrentTimeWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:format];

        //现在时间,你可以输出来看下是什么格式

    NSDate *datenow = [NSDate date];

        //----------将nsdate按formatter格式转成nsstring

    NSString *currentTimeString = [formatter stringFromDate:datenow];

//    DLog(@"currentTimeString =  %@",currentTimeString);

    return currentTimeString;
}

+(NSString *)getNowTimeTimestamp3{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];

    return timeSp;

}

/** 获取总周数*/
+ (NSInteger)getWeekNumYear:(NSInteger)year{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *desDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-12-31",year]];
    
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekOfYearCalendarUnit | NSQuarterCalendarUnit fromDate:desDate];
    
    NSInteger week = [comps weekOfYear];
    
    if (week == 1) {
        return 52;
    }else{
        return week;
    }
    
}

+ (NSString *)getWeekNumInYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    NSDateComponents *comps = [calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear
                                                    | NSCalendarUnitWeekdayOrdinal) fromDate:[NSDate date]];
    
    NSInteger week = [comps weekOfYear];
    
    return [NSString stringWithFormat:@"%ld",week];
    
}

- (NSString *)removeKongGe{
    if (self.length <= 0) return @"";
    /// 去掉首尾空格和换行符
    //[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    /// 去掉空格和换行符
    //[self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:self];
    
    [string replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length)];
    
    //[self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return [NSString stringWithFormat:@"%@",string];
}

/*
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
 */
+ (CurrentTimeBelongTo)getCurrentTimeBelongTo{
    NSLog(@"当前整数时间 %@",[NSString getCurrentTimeWithFormat:@"HH"]);
    
    int currentTime = [[NSString getCurrentTimeWithFormat:@"HH"] intValue];
    
    if (currentTime >= 5 && currentTime < 9) {
        
        return CurrentTimeBelongToMorning;
        
    }else if (currentTime >= 9 && currentTime < 12) {
        
        return CurrentTimeBelongToForenoon;
        
    }else if (currentTime >= 12 && currentTime < 14) {
        
        return CurrentTimeBelongToNoon;
        
    }else if (currentTime >= 14 && currentTime < 18) {
        
        return CurrentTimeBelongToAfternoon;
        
    }else if (currentTime >= 18 && currentTime < 19) {
        
        return CurrentTimeBelongToEvening;
        
    }else if (currentTime >= 19 && currentTime < 24) {
        
        return CurrentTimeBelongToNight;
        
    }else if (currentTime >= 0 && currentTime < 5) {
        
        return CurrentTimeBelongToBeforedawn;
        
    }
    
    return CurrentTimeBelongToUnknow;
}

+ (NSString *)getWeekDayFordate:(NSDate *)date{
    //获取星期几
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date ? date : [NSDate date]];
    NSInteger weekday = [componets weekday];//1代表星期日，2代表星期一，后面依次
    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *weekStr = weekArray[weekday-1];
    return weekStr;
}

@end


