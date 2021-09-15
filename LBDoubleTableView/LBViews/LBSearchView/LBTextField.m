//
//  LBTextField.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/10.
//

#import "LBTextField.h"

@interface LBTextField() <UITextFieldDelegate>

@property(nonatomic, strong)UITextField *editTF;
@property(nonatomic, strong)UILabel *hintLabel;
@property(nonatomic, copy)NSString *lastText;

@end

@implementation LBTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.editTF];
    [self addSubview:self.hintLabel];
    
    [self.editTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.left.offset(10);
    }];
    
    [self.hintLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.offset(30);
    }];
    // 弹出键盘
    [self.editTF becomeFirstResponder];
}

- (void)tfResignFirstResponder {
    [self.editTF resignFirstResponder];
}

- (void)setLastText:(NSString *)lastText {
    _lastText = lastText;
    self.editTF.text = lastText;
    // 缓存历史数据
    [LBUserDefaultTool historyDefaultsWithText:lastText];
}

#pragma mark textfield的代理
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //敲删除键
    if ([string length] == 0) {
        return YES;
    }
    return YES;
}

#pragma mark - textFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];//点击return 去掉键盘
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {

}

-(void)textFieldTextEditing:(UITextField*)textField {
    //回调出去当前的文本输入框内容 和对象本身
    if (!self.editTF.isFirstResponder) {
        return;
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    self.hintLabel.hidden = textField.text.length > 0?YES:NO;
    if (self.editTF == textField) {
        self.editTF.text = [self.editTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//去除空格
        if (self.textFieldCallback) {
            self.textFieldCallback(textField.text);
        }
    }
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [UILabel new];
        _hintLabel.textColor = LBUIColorWithRGB(0xC3C3C3, 1.0);
        _hintLabel.font = LBFontNameSize(Font_Regular, 14);
        _hintLabel.text = [NSString stringWithFormat:@"%@",@"输入中文/拼音/首字母"];
        [_hintLabel sizeToFit];
    }
    return _hintLabel;
}

- (UITextField *)editTF {
    if (!_editTF) {
        _editTF = [UITextField new];
        _editTF.delegate = self;
        _editTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _editTF.textColor = LBUIColorWithRGB(0x666666, 1.0);
        _editTF.font = LBFontNameSize(Font_Regular, 14);
//        _editTF.keyboardType = UIKeyboardTypeWebSearch;
        _editTF.returnKeyType = UIReturnKeySearch;
        // 关闭首字母大写：
        [_editTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        // 关闭自动联想功能：
        [_editTF setAutocorrectionType:UITextAutocorrectionTypeNo];
        _editTF.leftViewMode = UITextFieldViewModeAlways;
        _editTF.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
        [_editTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _editTF;
}

@end
