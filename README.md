## BWCustomTransition
BWCustomTransition is a delightful transition animation library for iOS. It is built on the system transition animation API, encapsulating the complex logic of the system.It provide a modular architecture with well-designed APIs that are a joy to use.

## Features
In short, here is a short list of the cool things BWCustomTransition provide:

1. Provide dozens of well-designed transition animations.

2. Well-designed custom transition animation API, easy to use.

3. Multiple delegates, you can specify another delegate to specify other system delegate methods. Such as controller conversion tracking.

4. Support interactive conversion animation, and support the configuration of gesture direction, drag distance, start position and so on.

## GIF animation
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_11_11.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_11_45.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_12_15.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_13_06.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_13_34.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_14_09.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_14_39.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_15_20.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_15_54.gif)   
![image](https://github.com/BossKaiGe/BWCustomTransition/blob/master/gif/2017-05-15%2008_16_22.gif)   

## Installation with CocoaPods
`pod 'BWCustomTransition'`


## How To Use

```
#import <BWCustomTransition/BWCustomTransition.h>
...
    BW_WeakSelf(ws);
    BWNormalToViewController * imgVC = [[BWNormalToViewController alloc]init];
    [imgVC setInitializeBlock:^(BWTransitionManager *manager) {
        manager.stackInType = BWAnimationTransition_Scanning_Left;
        manager.stackOutType = BWAnimationTransition_Scanning_Right;
        manager.transitionDuration_StackIn = 0.6;
        manager.transitionDuration_StackOut = 0.6;
        manager.stackOutGesture = BWStackOutGesture_Right;
        manager.originDelegate = ws;
    }];
    imgVC.interactiveTransition.boundary = .4;
    imgVC.interactiveTransition.interactiveStackOutMaxAllowedInitialDistanceToLeftEdge = 100;
    [self.navigationController presentViewController:imgVC animated:YES completion:nil];
```
- For details about how to use the library and clear examples, Please download the demo example.
