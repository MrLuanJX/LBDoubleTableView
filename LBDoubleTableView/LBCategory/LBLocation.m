//
//  LBLocation.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/13.
//

#import "LBLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface LBLocation()<CLLocationManagerDelegate>

@property(nonatomic,retain)CLLocationManager *locationManager;

@end

@implementation LBLocation

- (void)locate {
    // 推断定位操作是否被同意
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init] ;
        
        self.locationManager.delegate = self;
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
        @"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    // 開始定位
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CoreLocation Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，假设不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //依据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             
             //将获得的全部信息显示到label上
             NSLog(@"%@",placemark.name);
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，仅仅能通过获取省份的方法来获得（假设city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
//             self.cityName = city;
             NSLog(@"city: %@",city);
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    //系统会一直更新数据。直到选择停止更新。由于我们仅仅须要获得一次经纬度就可以，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因。可按住Option键点击 KCLErrorDenied的查看很多其它出错信息，可打印error.code值查找原因所在
    }
}


@end
