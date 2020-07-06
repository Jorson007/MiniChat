//
//  KWTalkViewController.m
//  MiniChat
//
//  Created by kwni on 2020/6/21.
//  Copyright © 2020 kwni. All rights reserved.
//

#import "KWTalkViewController.h"
#import "KWSocketManager.h"
#import "KWTableViewController.h"
#import "KWMessageModel.h"
#import "KWRightMessageFrameModel.h"

static BOOL isShowPanel = false;

@interface KWTalkViewController ()

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (strong, nonatomic) IBOutlet UITextField *message;
@property (strong, nonatomic) IBOutlet UIImageView *send;
@property (strong, nonatomic) IBOutlet UIImageView *emoj;
@property (strong, nonatomic) IBOutlet UIView *bottomview;
@property (strong, nonatomic) IBOutlet UIView *toolsview;

@property (strong, nonatomic) KWTableViewController *tableVC;

@end

@implementation KWTalkViewController
{
    UIImagePickerController *imagePicker;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableVC = [[KWTableViewController alloc] init];
    [_tableVC.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-60)];
    //初始化一个手势
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePanel:)];
    //为图片添加手势
    [_tableVC.view addGestureRecognizer:singleTap1];
    [self addChildViewController:_tableVC];
    
    [self.view addSubview:_tableVC.view];
    
    _bottomview = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    _bottomview.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    [self.view addSubview:_bottomview];
    
    _message=[[UITextField alloc]init];
    _message.frame=CGRectMake(self.view.frame.origin.x+10, self.view.frame.size.height-56, self.view.frame.size.width-120, 52);
    _message.borderStyle = UITextBorderStyleRoundedRect;
    _message.backgroundColor = [UIColor whiteColor];
    _message.layer.cornerRadius=5;
    [self.view addSubview:_message];
    
    _send = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-52, 40, 40)];
    //initWithFrame控制位置和尺寸
    _send.image = [UIImage imageNamed:@"tianjia.png"];
    _send.userInteractionEnabled = YES;//打开用户交互
    //初始化一个手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPanel:)];
    //为图片添加手势
    [_send addGestureRecognizer:singleTap];
    
    
    [self.view addSubview:_send];
    
    _emoj = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-105, self.view.frame.size.height-52, 40, 40)];
    //initWithFrame控制位置和尺寸
    _emoj.image = [UIImage imageNamed:@"biaoqing1.png"];
    
    
    [self.view addSubview:_emoj];
    
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[KWSocketManager share] connect];
}

-(void)transformView:(NSNotification *)notification{
    NSValue *begin = [[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [begin CGRectValue];
    
    NSValue *after = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect afterRect = [after CGRectValue];
    
    CGFloat deltaY = afterRect.origin.y - beginRect.origin.y;
    [UIView animateWithDuration:0.25f animations:^{
        [self->_message setFrame:CGRectMake(self->_message.frame.origin.x, self->_message.frame.origin.y+deltaY, self->_message.frame.size.width, self->_message.frame.size.height)];
        [self->_bottomview setFrame:CGRectMake(self->_bottomview.frame.origin.x, self->_bottomview.frame.origin.y+deltaY, self->_bottomview.frame.size.width, self->_bottomview.frame.size.height)];
        [self->_send setFrame:CGRectMake(self->_send.frame.origin.x, self->_send.frame.origin.y + deltaY, self->_send.frame.size.width, self->_send.frame.size.height)];
        [self->_emoj setFrame:CGRectMake(self->_emoj.frame.origin.x, self->_emoj.frame.origin.y+deltaY, self->_emoj.frame.size.width, self->_emoj.frame.size.height)];
    }];
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [[KWSocketManager share] disConnect];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    //通过UIImagePickerControllerMediaType判断返回的是照片还是视频
//    NSString* type = [info objectForKey:UIImagePickerControllerMediaType];
//    //如果返回的type等于kUTTypeImage，代表返回的是照片,并且需要判断当前相机使用的sourcetype是拍照还是相册
//    if ([type isEqualToString:(NSString*)kUTTypeImage]&&picker.sourceType==UIImagePickerControllerSourceTypeCamera) {
//        //获取照片的原图
//        UIImage* original = [info
//objectForKey:UIImagePickerControllerOriginalImage];
//        //获取图片裁剪的图
//        UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
//        //获取图片裁剪后，剩下的图
//        UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
//        //获取图片的url
//        NSURL* url = [info objectForKey:UIImagePickerControllerMediaURL];
//        //获取图片的metaData数据信息
//        NSDictionary* metaData = [info objectForKey:UIImagePickerControllerMediaMetadata];
//        //如果是拍照的照片，则需要手动保存到本地，系统不会自动保存拍照成功后的照片
//        UIImageWriteToSavedPhotosAlbum(edit, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    }else{
//
//    }
//    //模态方式退出uiimagepickercontroller
//    [imagepicker dismissModalViewControllerAnimated:YES];
}

//弹出下侧panel
- (void)showPanel:(UIGestureRecognizer *)gestureRecognizer{
    //do something....
    if(!isShowPanel){
        isShowPanel = true;
        CGFloat deltaY = -220;
        [UIView animateWithDuration:0.25f animations:^{
            [self->_message setFrame:CGRectMake(self->_message.frame.origin.x, self->_message.frame.origin.y+deltaY, self->_message.frame.size.width, self->_message.frame.size.height)];
            [self->_bottomview setFrame:CGRectMake(self->_bottomview.frame.origin.x, self->_bottomview.frame.origin.y+deltaY, self->_bottomview.frame.size.width, self->_bottomview.frame.size.height)];
            [self->_send setFrame:CGRectMake(self->_send.frame.origin.x, self->_send.frame.origin.y + deltaY, self->_send.frame.size.width, self->_send.frame.size.height)];
            [self->_emoj setFrame:CGRectMake(self->_emoj.frame.origin.x, self->_emoj.frame.origin.y+deltaY, self->_emoj.frame.size.width, self->_emoj.frame.size.height)];
        }];
    }
    [self performSelector:@selector(showGridView) withObject:nil afterDelay:0.25f];//延时0.25秒执行
    
    //    [self sendMessage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
     //模态方式退出UIImagePickerController
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
 }

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
}

-(void)showGridView{
    // 假设每行的应用的个数
    int columns = 4;
    
    _toolsview = [[UIView alloc] init];
    _toolsview.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-220, self.view.frame.size.width, 220);
    [self.view addSubview:_toolsview];
    
    // 每个应用的宽和高
    CGFloat appW = 90;
    CGFloat appH = 90;
    CGFloat marginTop = 20; // 第一行距离顶部的距离
    CGFloat marginX = 10;
    CGFloat marginY = marginX; // 假设每行之间的间距与marginX相等
    NSArray *toolName = @[@"照片",@"拍摄",@"视频通话",@"位置",@"红包",@"转账",@"语音输入",@"收藏"];
    NSArray *picName = @[@"picture-fill",@"paishe",@"iocnshiping",@"weibiaoti6",@"tianchongxing-",@"zhuanzhang",@"yuyin",@"shoucangblack"];
    NSArray *touchOperate = @[@"showPictureLibrary:",@"takePhoto:",@"startVideo:",@"showPosition:",@"giveHongBao:",@"payMoney:",@"voiceInput:",@"collectMessage:"];
    for (int i = 0; i < 8; i++) {
        
        // 1. 创建每个应用(UIView)
        UIView *appView = [[UIView alloc] init];
        
        // 2. 设置appView的属性
        // 2.1 设置appView的背景色
        appView.backgroundColor = [UIColor whiteColor];
        NSString *operate = touchOperate[i];
        SEL touchOperate = NSSelectorFromString(operate);
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:touchOperate];

        [appView addGestureRecognizer:tapGesturRecognizer];
        
        // 2.2 设置appView的frame属性
        // 计算每个单元格所在的列的索引
        int colIdx = i % columns;
        // 计算每个单元格的行索引
        int rowIdx = i / columns;
        
        CGFloat appX = marginX + colIdx * (appW + marginX);
        CGFloat appY = marginTop + rowIdx * (appH + marginY);
        appView.frame = CGRectMake(appX, appY, appW, appH);
        
        // 3. 将appView加到self.view(控制器所管理的那个view)
        [_toolsview addSubview:appView];
        
        
        // 4. 向UIView中增加子控件
        // 4.1 增加一个图片框
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        // 设置背景色
        //imgViewIcon.backgroundColor = [UIColor yellowColor];
        // 设置frame
        CGFloat iconW = 45;
        CGFloat iconH = 45;
        CGFloat iconX = (appView.frame.size.width - iconW) * 0.5;
        CGFloat iconY = 0;
        imgViewIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        
        // 把图片框添加到appView中
        [appView addSubview:imgViewIcon];
        // 设置图片框的数据
        imgViewIcon.image = [UIImage imageNamed:picName[i]];
        
        
        // 4.2 增加一个Label(标签)
        // 创建Label
        UILabel *lblName = [[UILabel alloc] init];
        // 设置背景色
        //lblName.backgroundColor = [UIColor redColor];
        // 设置frame
        CGFloat nameW = appView.frame.size.width;
        CGFloat nameH = 20;
        CGFloat nameY = iconH;
        CGFloat nameX = 0;
        lblName.frame = CGRectMake(nameX, nameY, nameW, nameH);
        // 添加到appView中
        [appView addSubview:lblName];
        // 设置lable的数据（标题）
        lblName.text = toolName[i];
        // 设置lable的文字的字体大小
        lblName.font = [UIFont systemFontOfSize:12];
        // 设置文字居中对齐
        lblName.textAlignment = NSTextAlignmentCenter;
        
    }
}

//从相册中取照片
- (void)showPictureLibrary:(UIGestureRecognizer *)gestureRecognizer{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[@"public.image"];

        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
        __weak UIImagePickerController *weakimagePicker = imagePicker;
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self presentViewController:weakimagePicker animated:YES completion:nil];
        }];
        [ac addAction:photoAction];
        [self presentViewController:ac animated:true completion:nil];
        
    }else{
        NSLog(@"showPictureLibrary error");
        return;
    }
}

//
- (void)takePhoto:(UIGestureRecognizer *)gestureRecognizer{
   if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        imagePicker.mediaTypes = @[@"public.image"];

        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
       
        __weak UIImagePickerController *weakimagePicker = imagePicker;
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self presentViewController:weakimagePicker animated:YES completion:nil];
        }];
        [ac addAction:cameraAction];
        [self presentViewController:ac animated:true completion:nil];
        
    }else{
        NSLog(@"takePhoto error");
        return;
    }
}

//
- (void)startVideo:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"44444");
}

//
- (void)showPosition:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"44444");
}

//
- (void)giveHongBao:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"44444");
}

//
- (void)payMoney:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"44444");
}
//
- (void)voiceInput:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"44444");
}
//
- (void)collectMessage:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"44444");
}

//关掉下侧panel
- (void)closePanel:(UIGestureRecognizer *)gestureRecognizer{
    //do something....
    if(isShowPanel){
        isShowPanel = false;
        _toolsview.hidden = true;
        CGFloat deltaY = 220;
        [UIView animateWithDuration:0.25f animations:^{
            [self->_message setFrame:CGRectMake(self->_message.frame.origin.x, self->_message.frame.origin.y+deltaY, self->_message.frame.size.width, self->_message.frame.size.height)];
            [self->_bottomview setFrame:CGRectMake(self->_bottomview.frame.origin.x, self->_bottomview.frame.origin.y+deltaY, self->_bottomview.frame.size.width, self->_bottomview.frame.size.height)];
            [self->_send setFrame:CGRectMake(self->_send.frame.origin.x, self->_send.frame.origin.y + deltaY, self->_send.frame.size.width, self->_send.frame.size.height)];
            [self->_emoj setFrame:CGRectMake(self->_emoj.frame.origin.x, self->_emoj.frame.origin.y+deltaY, self->_emoj.frame.size.width, self->_emoj.frame.size.height)];
        }];
    }
    //    [self sendMessage];
}

-(void)sendMessage{
    if (_message.text.length == 0) {
        return;
    }
    //    NSMutableArray *messages = _tableVC.KWInfoArray;
    NSDictionary *dict = @{@"name" : _message.text, @"icon" : @"girl.png", @"text" : @""};
    KWMessageModel *model = [KWMessageModel modelWithDict:dict];
    KWRightMessageFrameModel *frameModel = [[KWRightMessageFrameModel alloc] init];
    frameModel.model = model;
    [_tableVC.KWInfoArray addObject:frameModel];
    [_tableVC.tableView reloadData];
}


@end
