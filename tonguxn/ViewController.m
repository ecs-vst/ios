//
//  ViewController.m
//  tonguxn
//
//  Created by 阿兵 on 15/12/18.
//  Copyright © 2015年 阿兵. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface ViewController ()<ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate>
@property (nonatomic, strong)UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 200, 50, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 150, 30)];
    self.textField.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.textField];
}

- (void)btnAction
{
    ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    peoplePicker.peoplePickerDelegate = self;
    [self presentViewController:peoplePicker animated:YES completion:nil];
}
#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(valuesRef, index);
        phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%@", phoneNO);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    if (valuesRef && phoneNO.length == 11) {
                [peoplePicker dismissViewControllerAnimated:YES completion:nil];
        
        self.textField.text = (__bridge NSString*)value;
                return;
            }else{
                [peoplePicker dismissViewControllerAnimated:NO completion:nil];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }
//    [self dismissViewControllerAnimated:YES completion:^{
//        self.textField.text = (__bridge NSString*)value;
//    }];
}
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
//    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
//    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
//    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    NSLog(@"%@", phoneNO);
//    if (phone && phoneNO.length == 11) {
//        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//        return;
//    }else{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//    }
//}
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person NS_AVAILABLE_IOS(8_0)
//{
//    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
//    personViewController.displayedPerson = person;
//    [peoplePicker pushViewController:personViewController animated:YES];
//}
//- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
//{
//    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//}
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person NS_DEPRECATED_IOS(2_0, 8_0)
//{
//    return YES;
//}
//- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier NS_DEPRECATED_IOS(2_0, 8_0)
//{
//    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
//    long index = ABMultiValueGetIndexForIdentifier(phone,identifier);
//    NSString *phoneNO = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, index);
//    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    NSLog(@"%@", phoneNO);
//    if (phone && phoneNO.length == 11) {
//        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
//        return NO;
//    }else{
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"请选择正确手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//    }
//    return YES;
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    ABPeoplePickerNavigationController *pNC = [[ABPeoplePickerNavigationController alloc] init];
//    pNC.peoplePickerDelegate = self;
//    [self presentViewController:pNC animated:YES completion:nil];
//}

@end
