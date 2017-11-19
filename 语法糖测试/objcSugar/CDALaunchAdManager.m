//
//  CDALaunchAdManager.m
//  Camdora
//
//  Created by wuping on 06/07/2017.
//  Copyright © 2017 camdora. All rights reserved.
//

#import "CDALaunchAdManager.h"
#import "XHLaunchAd.h"
#import "AppDelegate.h"
#import "CDAAPIManager.h"
#import "UIViewController+Nav.h"
#import "CDAWebViewController.h"
#import "CDALaunchAdModel.h"
#import "CDAAPIManager.h"
#import "CDAUserManager.h"

#define BEAUTIFUL_UR @"http://i2.letvimg.com/vrs/201406/15/49df2239-9599-4304-ac4e-e0d07dea73a1.jpg"
#define CDA_DEFAULT_LUANCHAD_TIME 3

@interface CDALaunchAdManager()<XHLaunchAdDelegate>
{
    void(^javascriptContextInitedListener)();
}

@property (nonatomic, strong)  CDALaunchAdModel *model;

@end

@implementation CDALaunchAdManager

+(void)load
{
    [self shareManager];
}

+ (CDALaunchAdManager *)shareManager{
    static CDALaunchAdManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[CDALaunchAdManager alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //在UIApplicationDidFinishLaunching时初始化开屏广告
        //当然你也可以直接在AppDelegate didFinishLaunchingWithOptions中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
            //初始化开屏广告
            [self setupXHLaunchAd];
            
        }];
    }
    return self;
}
-(void)setupXHLaunchAd
{
    //1.******图片开屏广告 - 网络数据******
    [self example01];
    
    //2.******图片开屏广告 - 本地数据******
//    [self example02];
    
    //3.******视频开屏广告 - 网络数据(网络视频只支持缓存OK后下次显示)******
    //[self example03];
    
    //4.******视频开屏广告 - 本地数据******
    //[self example04];
    
    //5.******如需自定义跳过按钮,请看这个示例******
    //[self example05];
    
    //6.******使用默认配置快速初始化,请看下面两个示例******
    //[self example06];//图片
    //[self example07];//视频
    
    //7.******如果你想提前缓存图片/视频请调下面这两个接口*****
    //批量缓存图片
    //[XHLaunchAd downLoadImageAndCacheWithURLArray:@[[NSURL URLWithString:imageURL1],[NSURL URLWithString:imageURL2],[NSURL URLWithString:imageURL3]]];
    //批量缓存视频
    //[XHLaunchAd downLoadVideoAndCacheWithURLArray:@[[NSURL URLWithString:videoURL1],[NSURL URLWithString:videoURL2],[NSURL URLWithString:videoURL3]]];
    
}
#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)example01
{
    weakSelf();
    [XHLaunchAd setWaitDataDuration:3];//请求广告数据前,必须设置,否则会先进入window的RootVC
    [[CDAAPIManager sharedManager] getLaunchAdDataWithSuccess:^(id result) {
        
        _model = result;
        XHLaunchImageAdConfiguration *imageAdconfiguration = [[XHLaunchImageAdConfiguration alloc] init];
        imageAdconfiguration.duration = _model.skipTime ? _model.skipTime : CDA_DEFAULT_LUANCHAD_TIME;
        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        imageAdconfiguration.imageNameOrURLString = _model.splash;
        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
        imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
        
        if (_model.linkToken) {
            imageAdconfiguration.openURLString = [[CDAUserManager sharedManager] webPageLinkAddTokenWithUrlString:_model.linkUrl];
        }
        else {
            imageAdconfiguration.openURLString = _model.linkUrl;
        }
        
        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
        imageAdconfiguration.showFinishAnimateTime = 0.8;
        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
        imageAdconfiguration.showEnterForeground = NO;
        imageAdconfiguration.hideCopyright = _model.hideCopyright;
        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        
    } failure:^(NSError *error) {
        NSLog(@"getLaunchAdData error: %ld", (long)error.code);
    }];
}

#pragma mark - 图片开屏广告-本地数据-示例
//图片开屏广告 - 本地数据
-(void)example02
{
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/1242*1786);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image2.jpg";
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开链接
    imageAdconfiguration.openURLString = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
}

#pragma mark - 视频开屏广告-网络数据-示例
//视频开屏广告 - 网络数据
-(void)example03
{
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将自动进入window的RootVC
    //3.数据获取成功,初始化广告时,自动结束等待,显示广告
    [XHLaunchAd setWaitDataDuration:3];//请求广告数据前,必须设置,否则会先进入window的RootVC
    
    //广告数据请求
//    [Network getLaunchAdVideoDataSuccess:^(NSDictionary * response) {
//        
//        NSLog(@"广告数据 = %@",response);
//        
//        //广告数据转模型
//        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
//        
//        //配置广告数据
//        XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
//        //广告停留时间
//        videoAdconfiguration.duration = model.duration;
//        //广告frame
//        videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/model.width*model.height);
//        //广告视频URLString/或本地视频名(请带上后缀)
//        //注意:视频广告只支持先缓存,下次显示
//        videoAdconfiguration.videoNameOrURLString = model.content;
//        //视频缩放模式
//        videoAdconfiguration.scalingMode = MPMovieScalingModeAspectFill;
//        //广告点击打开链接
//        videoAdconfiguration.openURLString = model.openUrl;
//        //广告显示完成动画
//        videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
//        //广告显示完成动画时间
//        videoAdconfiguration.showFinishAnimateTime = 0.8;
//        //后台返回时,是否显示广告
//        videoAdconfiguration.showEnterForeground = NO;
//        //跳过按钮类型
//        videoAdconfiguration.skipButtonType = SkipTypeTimeText;
//        //视频已缓存 - 显示一个 "已预载" 视图 (可选)
//        if([XHLaunchAd checkVideoInCacheWithURL:[NSURL URLWithString:model.content]])
//        {
//            //设置要添加的自定义视图(可选)
//            videoAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
//            
//        }
//        
//        [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
//        
//    } failure:^(NSError *error) {
//    }];
    
}
#pragma mark - 视频开屏广告-本地数据-示例
//视频开屏广告 - 本地数据
-(void)example04
{
    //配置广告数据
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = 5;
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"video1.mp4";
    //视频填充模式
    videoAdconfiguration.scalingMode = MPMovieScalingModeAspectFill;
    //广告点击打开链接
    videoAdconfiguration.openURLString =  @"http://www.it7090.com";
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeTimeText;
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //videoAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
    
}
#pragma mark - 自定义跳过按钮-示例
-(void)example05
{
    //注意:
    //1.自定义跳过按钮很简单,configuration有一个customSkipView属性.
    //2.自定义一个跳过的view 赋值给configuration.customSkipView属性便可替换默认跳过按钮,如下:
    
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/1242*1786);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image11.gif";
    //缓存机制(仅对网络图片有效)
    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
    //广告点击打开链接
    imageAdconfiguration.openURLString = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    
    //设置要添加的子视图(可选)
    imageAdconfiguration.subViews = [self launchAdSubViews];
    
    //start********************自定义跳过按钮**************************
    imageAdconfiguration.customSkipView = [self customSkipView];
    //********************自定义跳过按钮*****************************end
    
    //显示开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
    
}
#pragma mark - 使用默认配置快速初始化 - 示例
/**
 *  图片
 */
-(void)example06
{
    //使用默认配置
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//    imageAdconfiguration.imageNameOrURLString = imageURL3;
    //广告点击打开链接
    imageAdconfiguration.openURLString = @"http://www.it7090.com";
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
/**
 *  视频
 */
-(void)example07
{
    //使用默认配置
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration defaultConfiguration];
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"video0.mp4";
    ////广告点击打开链接
    videoAdconfiguration.openURLString = @"http://www.it7090.com";
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}
#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, 30, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}
-(NSArray<UIView *> *)launchAdSubViews
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-170, 30, 60, 30)];
    label.text  = @"subViews";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}
#pragma mark - customSkipView
//自定义跳过按钮
-(UIView *)customSkipView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor orangeColor];
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,30, 85, 40);
    [button addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
//跳过按钮点击事件
-(void)skipAction
{
    [XHLaunchAd skipAction];
}
#pragma mark - XHLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration
{
    //设置自定义跳过按钮时间
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    //设置时间
    [button setTitle:[NSString stringWithFormat:@"自定义%lds",duration] forState:UIControlStateNormal];
}
#pragma mark - XHLaunchAd delegate - 其他

/**
 *  广告点击事件 回调
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString;
{
    NSLog(@"广告点击");
    CDAWebViewController *VC = [[CDAWebViewController alloc] initWithTitle:_model.title url:openURLString coverUrl:nil isShowNavBar:YES];
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.myNavigationController pushViewController:VC animated:YES];
}
/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param image    image
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image
{
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}
/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL
{
    NSLog(@"video下载/加载完成/保存path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current
{
    NSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
    
}
/**
 *  广告显示完成
 */
-(void)xhLaunchShowFinish:(XHLaunchAd *)launchAd
{
    NSLog(@"广告显示完成");
}

/**
 如果你想用SDWebImage等框架加载网络广告图片,请实现此代理
 
 @param launchAd          XHLaunchAd
 @param launchAdImageView launchAdImageView
 @param url               图片url
 */
//-(void)xhLaunchAd:(XHLaunchAd *)launchAd launchAdImageView:(UIImageView *)launchAdImageView URL:(NSURL *)url
//{
//    [launchAdImageView sd_setImageWithURL:url];
//
//}


#pragma mark - tool
/**
 是否是横屏
 */
-(BOOL)isLandscape
{
    BOOL orientation = NO;
    UIDeviceOrientation duration = [[UIDevice currentDevice] orientation];
    switch (duration) {
        case UIDeviceOrientationLandscapeLeft://Home按钮右
        case UIDeviceOrientationLandscapeRight://Home按钮左
            orientation = YES;
            break;
        default:
            break;
    }
    NSLog(@"____方向=%d",orientation);
    return orientation;
}
@end

