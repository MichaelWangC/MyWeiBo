//
//  DockController.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-1.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dock.h"

@interface DockController : UIViewController

@property (strong , nonatomic) Dock *dock;
@property (nonatomic) NSInteger selectedIndex;

@end
