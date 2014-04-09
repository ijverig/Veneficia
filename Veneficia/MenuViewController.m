//
//  MenuViewController.m
//  Veneficia
//
//  Created by Rodolfo Antoniazzi on 08/04/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic,strong) UIImage* backgroundImage;
@property (nonatomic,strong) UIImageView* background;
@property (nonatomic,strong) UIScrollView* scroll;


@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _backgroundImage = [UIImage imageNamed:@"menuFundo"];
    _background = [[UIImageView alloc] initWithImage:_backgroundImage];
    [_background setFrame:CGRectMake(-700, 0, _backgroundImage.size.width, _backgroundImage.size.height)];
    //[_background setCenter:self.view.center];
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scroll.delegate = self;
    [_scroll addSubview:_background];
    [_scroll setContentSize:_backgroundImage.size];
    _scroll.minimumZoomScale = 0.1f;
    _scroll.maximumZoomScale = 5.0f;
    [_scroll setZoomScale:0.93];
    [_scroll setUserInteractionEnabled:NO];
    [self.view addSubview:_scroll];
    
    UILabel *texto = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 500, 150)];
    [texto setText:@"Veneficia"];
    texto.font = [UIFont systemFontOfSize:110];
    texto.center = CGPointMake(self.view.center.x, self.view.center.y-200);
    texto.textAlignment = NSTextAlignmentCenter;
    texto.textColor = [UIColor colorWithRed:1 green:0.4 blue:0 alpha:0.9];
    [self.view addSubview:texto];
    
    UIButton *play = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    play.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    [play setTitle:@"JOGAR" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    play.titleLabel.font = [UIFont systemFontOfSize:50];
    [play addTarget:self action:@selector(goToGame:) forControlEvents:UIControlEventTouchUpInside];
    play.titleLabel.textColor = [UIColor darkTextColor];
    [self.view addSubview:play];
    
    
    
}

-(IBAction)goToGame:(UIButton*)sender{
    [self performSegueWithIdentifier:@"goToGame" sender:sender];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // Return the view that you want to zoom
    return _background;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
