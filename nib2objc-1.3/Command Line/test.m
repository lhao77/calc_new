UITableViewCell *tableviewcell12 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellReuseIdentifier"];
tableviewcell12.frame = CGRectMake(0.0, 0.0, 320.0, 44.0);
tableviewcell12.accessoryType = UITableViewCellAccessoryNone;
tableviewcell12.alpha = 1.000;
tableviewcell12.autoresizesSubviews = YES;
tableviewcell12.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
tableviewcell12.clearsContextBeforeDrawing = YES;
tableviewcell12.clipsToBounds = NO;
tableviewcell12.contentMode = UIViewContentModeScaleToFill;
tableviewcell12.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
tableviewcell12.editingAccessoryType = UITableViewCellAccessoryNone;
tableviewcell12.hidden = NO;
tableviewcell12.indentationLevel = 0;
tableviewcell12.indentationWidth = 10.000;
tableviewcell12.multipleTouchEnabled = NO;
tableviewcell12.opaque = YES;
tableviewcell12.selectionStyle = UITableViewCellSelectionStyleBlue;
tableviewcell12.shouldIndentWhileEditing = YES;
tableviewcell12.showsReorderControl = NO;
tableviewcell12.tag = 0;
tableviewcell12.userInteractionEnabled = YES;

UILabel *label14 = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 11.0, 42.0, 21.0)];
label14.frame = CGRectMake(20.0, 11.0, 42.0, 21.0);
label14.adjustsFontSizeToFitWidth = YES;
label14.alpha = 1.000;
label14.autoresizesSubviews = YES;
label14.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
label14.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
label14.clearsContextBeforeDrawing = YES;
label14.clipsToBounds = YES;
label14.contentMode = UIViewContentModeLeft;
label14.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
label14.enabled = YES;
label14.hidden = NO;
label14.lineBreakMode = UILineBreakModeTailTruncation;
label14.minimumFontSize = 10.000;
label14.multipleTouchEnabled = NO;
label14.numberOfLines = 1;
label14.opaque = NO;
label14.shadowOffset = CGSizeMake(0.0, -1.0);
label14.tag = 0;
label14.text = @"Label";
label14.textAlignment = UITextAlignmentLeft;
label14.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000];
label14.userInteractionEnabled = NO;

UITextField *textfield13 = [[UITextField alloc] initWithFrame:CGRectMake(173.0, 6.0, 127.0, 31.0)];
textfield13.frame = CGRectMake(173.0, 6.0, 127.0, 31.0);
textfield13.adjustsFontSizeToFitWidth = YES;
textfield13.alpha = 1.000;
textfield13.autocapitalizationType = UITextAutocapitalizationTypeNone;
textfield13.autocorrectionType = UITextAutocorrectionTypeDefault;
textfield13.autoresizesSubviews = YES;
textfield13.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
textfield13.borderStyle = UITextBorderStyleRoundedRect;
textfield13.clearButtonMode = UITextFieldViewModeNever;
textfield13.clearsContextBeforeDrawing = YES;
textfield13.clearsOnBeginEditing = NO;
textfield13.clipsToBounds = YES;
textfield13.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
textfield13.contentMode = UIViewContentModeScaleToFill;
textfield13.contentStretch = CGRectFromString(@"{{0, 0}, {1, 1}}");
textfield13.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
textfield13.enabled = YES;
textfield13.enablesReturnKeyAutomatically = NO;
textfield13.hidden = NO;
textfield13.highlighted = NO;
textfield13.keyboardAppearance = UIKeyboardAppearanceDefault;
textfield13.keyboardType = UIKeyboardTypeDefault;
textfield13.minimumFontSize = 17.000;
textfield13.multipleTouchEnabled = NO;
textfield13.opaque = NO;
textfield13.returnKeyType = UIReturnKeyDefault;
textfield13.secureTextEntry = NO;
textfield13.selected = NO;
textfield13.tag = 0;
textfield13.text = @"";
textfield13.textAlignment = UITextAlignmentLeft;
textfield13.textColor = [UIColor colorWithWhite:0.000 alpha:1.000];
textfield13.userInteractionEnabled = YES;

[tableviewcell12 addSubview:textfield13];
[tableviewcell12 addSubview:label14];
