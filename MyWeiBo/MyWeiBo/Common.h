
//定义是否为iphone5
#define Iphone5 ([UIScreen mainScreen].bounds.size.height == 568)
//是否为IOS7
#define IOS7 ([[[UIDevice currentDevice] systemVersion]floatValue] >=7.0)
//RGB颜色设置
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//微博API
#define KAppKey @"1516405886"
#define KAppSecret @"5a440e4fefef49f212b2b7bff766afef"
#define KRedirectUrl @"http://www.baidu.com"
#define KBaseUrl @"https://api.weibo.com"

#define KAuthorizeUrl [KBaseUrl stringByAppendingPathComponent:@"oauth2/authorize"]
#define KAccessTokenUrl [KBaseUrl stringByAppendingPathComponent:@"oauth2/access_token"]
#define KRevokeOauthUrl [KBaseUrl stringByAppendingPathComponent:@"oauth2/revokeoauth2"]
#define KStatusesUrl [KBaseUrl stringByAppendingPathComponent:@"2/statuses/friends_timeline.json"]

// 头像
#define kIconSmallW 34
#define kIconSmallH 34

// 认证加V图标
#define kVertifyW 18
#define kVertifyH 18

// 设置cell内部间隔
#define kCellPaddingWidth 10
// 设置微博dock的高度
#define kStatusDockHeight 30

// cell内部子控件的字体设置
#define kScreenNameFont [UIFont systemFontOfSize:15]
#define kTimeFont [UIFont systemFontOfSize:11]
#define kTextFont [UIFont systemFontOfSize:13]
#define kRetweetedTextFont [UIFont systemFontOfSize:13]
#define kRetweetedScreenNameFont [UIFont systemFontOfSize:13]

//表单间隔
#define kTableBorderWidth 8
#define kCellMargin 10
// 会员皇冠图标
#define kMBIconW 14
#define kMBIconH 14
// 会员昵称颜色
#define kMBScreenNameColor kColor(243, 101, 18)
// 非会员昵称颜色
#define kScreenNameColor kColor(93, 93, 93);
// 被转发微博昵称颜色
#define kRetweetedScreenNameColor kColor(63, 104, 161)

// 全局的背景色
#define kGlobalBg kColor(235, 235, 235)
// 转发背景色
#define kRetweetedBg kColor(240, 240, 240);

//配图大小（多图）
#define kImageW 80
#define kImageH 80
//配图大小（单图）
#define kSingleImageW 100
#define kSingleImageH 150
//配图间隔
#define kImageListPadding 5

