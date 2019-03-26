//
//  ViewController.m
//  NewProject5
//
//  Created by Павел Нехорошкин on 19.03.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

#import "ViewController.h"
#import "AnimalTableViewCell.h"
#import "EvenAnimalTableViewCell.h"
#import "AnimalTabbleViewProject-Swift.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *animals;

// метод UITableViewDelegate обрабатывающий событие нажатия ячейки списка
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// метод UITableViewDelegate обрабатывающий событие перед появлением ячейки (для анимации при прокрутке)
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

//метод  UITableViewDataSource сообщает сколько всего элементоа а списке
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section;

//метод  UITableViewDataSource раздает строки-ячейки для отображения в UITableView
- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor redColor];
    
    // создадим и сохраним в проперти новую view размером с экран
    self.tableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
    //добавим ее в иерархию в главное view
    [self.view addSubview: self.tableView];
    
    //имеет приоритет перед констрейнтами, если убрать, то высота ячеек подстроится к констрейнтам содержимого ячеек
//    self.tableView.rowHeight = 150;
    
    //добавим поддержку протокола источника данных в контроллер, для этого реализуем два метода
    self.tableView.dataSource = self;
    
    //делегат получае событие выбора ячейки в таблице
    self.tableView.delegate = self;
    
    self.animals = @[
  @{@"title":@"Строка 1", @"pictureName":@"Image-0.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 2", @"pictureName":@"Image-1.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 3", @"pictureName":@"Image-2.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 4", @"pictureName":@"Image-3.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 5", @"pictureName":@"Image-4.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 6", @"pictureName":@"Image-5.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 7", @"pictureName":@"Image-6.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 8", @"pictureName":@"Image-7.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 9", @"pictureName":@"Image-8.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 10", @"pictureName":@"Image-9.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 11", @"pictureName":@"Image-10.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 11", @"pictureName":@"Image-11.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 13", @"pictureName":@"Image-12.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 14", @"pictureName":@"Image-13.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."},
  @{@"title":@"Строка 15", @"pictureName":@"Image-14.png",@"subTitle":@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."}, ];
    
    
    //registerclass в таблице UITableView - регистрирует UITableViewCell для содержимого нечетной ячейки
    [self.tableView registerClass:[AnimalTableViewCell class] forCellReuseIdentifier:@"AnimalTableViewCell"];
    
    //registerclass в таблице UITableView - регистрирует UITableViewCell для содержимого четной ячейки
    [self.tableView registerClass:[EvenAnimalTableViewCell class] forCellReuseIdentifier:@"EvenAnimalTableViewCell"];
    
}

//имплементация метода  UITableViewDataSource сообщает сколько всего элементоа а списке
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.animals.count;
}

//имплементация метода  UITableViewDataSource раздает строки-ячейки для отображения в UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //извлечь свободную ячейку из очереди
    UITableViewCell *cell;
    if(indexPath.row%2 == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EvenAnimalTableViewCell" forIndexPath:indexPath];
        
        if (!cell)
        {
            //если не хватает свободных (первое отображеник), очередь ячеек пустая, то создать новую ячейку
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EvenAnimalTableViewCell"];
        }
    } else
    {

        cell = [tableView dequeueReusableCellWithIdentifier:@"AnimalTableViewCell" forIndexPath:indexPath];
        
        if (!cell)
        {
            //если не хватает свободных (первое отображеник), очередь ячеек пустая, то создать новую ячейку
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AnimalTableViewCell"];
        }
    }

    NSDictionary *dictionaryForRow = (NSDictionary *)self.animals[indexPath.row];
    
    NSString *title = dictionaryForRow[@"title"];

    NSString *imageName =  dictionaryForRow[@"pictureName"];
    
    UIImage *image = [UIImage imageNamed:imageName];

    [(UIImageView *)cell.contentView.subviews[0] setImage:image];
    
    ((UILabel *)cell.contentView.subviews[1]).text = title;

    ((UILabel *)cell.contentView.subviews[2]).text = dictionaryForRow[@"subTitle"];

    return cell;
}

@end


@implementation ViewController(BirdViewController)

// метод UITableViewDelegate обрабатывающий событие нажатия ячейки списка
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BirdViewController *birdViewController = [BirdViewController new];
    [self.navigationController pushViewController:birdViewController animated:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    анимация появления ячейки - поворот снизу
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    
    rotation.m34 = 1.0/ -600;

    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    
    cell.alpha = 0;

    cell.layer.transform = rotation;
    
    cell.layer.anchorPoint = CGPointMake(0, 0.5);


    [UIView beginAnimations:@"rotation" context:NULL];
    
    [UIView setAnimationDuration:0.5];
    
    cell.layer.transform = CATransform3DIdentity;
    
    cell.alpha = 1;
    
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    
    [UIView commitAnimations];
   
    
//    анимация появления ячейки - вращение иконки
    UIImageView *image = cell.contentView.subviews[0];

    CATransform3D imageRotation;

    imageRotation = CATransform3DMakeRotation( ((180*M_PI)/180), 0.0, 1.0, 0.0);

    image.layer.shadowColor = [[UIColor blackColor]CGColor];

    image.layer.shadowOffset = CGSizeMake(5, 10);

    image.alpha = 0;

    image.layer.transform = imageRotation;



    [UIView beginAnimations:@"rotation" context:NULL];

    [UIView setAnimationDuration:1.8];

    image.layer.transform = CATransform3DIdentity;

    image.animationRepeatCount = 0;

    image.alpha = 1;

    image.layer.shadowOffset = CGSizeMake(0, 0);

    [UIView commitAnimations];
}



 @end
