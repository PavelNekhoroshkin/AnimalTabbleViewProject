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

//#import "NewProject5-Bridging-Header.h"
#import "AnimalTabbleViewProject-Swift.h"



@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary<NSString *, NSString *> *> *animals;

// UITableViewDelegate нажата ячейка списка
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//UITableViewDataSource - специальный источник строк-ячеек для отображения в табличке
- (NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section; //сколько всего размер списка
- (UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;//выдать новую свободную ячейку из пула
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@implementation ViewController

- (void)viewDidLoad {
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
    
    
    //  registerclass в таблице UITableView - регистрирует класс содержимого отдельной ячейки
    [self.tableView registerClass:[AnimalTableViewCell class] forCellReuseIdentifier:@"AnimalTableViewCell"];
    [self.tableView registerClass:[EvenAnimalTableViewCell class] forCellReuseIdentifier:@"EvenAnimalTableViewCell"];
//    [self.tableView registerClass:[AnimalTableViewCellEven class] forCellReuseIdentifier:@"AnimalTableViewCellEven"];

    
//    BirdViewController *burdViewController = [BirdViewController new];
//    [self.navigationController pushViewController:burdViewController animated:YES];
    
    
}





//сколько всего размер списка
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.animals.count;
}

//получить очередную ячейку для заполнения при перемещении экрана
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //извлечь свободную ячейку из очереди
    UITableViewCell *cell;
    if(indexPath.row%2 == 0){
          cell = [tableView dequeueReusableCellWithIdentifier:@"EvenAnimalTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            //если не хватает свободных (первое отображеник), очередь ячеек пустая, то создать новую ячейку
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EvenAnimalTableViewCell"];
        }
    } else {
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnimalTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            //если не хватает свободных (первое отображеник), очередь ячеек пустая, то создать новую ячейку
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AnimalTableViewCell"];
        }
    }
    
   
    NSDictionary *dictionaryForRow = (NSDictionary *)self.animals[indexPath.row];
    NSString *title = dictionaryForRow[@"title"];
    
//    уберем отображение текста в стандартной ячейке
//    cell.textLabel.text = title;
    
    
    
   
    
    NSString *imageName =  dictionaryForRow[@"pictureName"];
    UIImage *image = [UIImage imageNamed:imageName];

    
//    NSString * url = @"https://image.flaticon.com/icons/png/128/809/";
//    url = [url stringByAppendingString:[[NSNumber numberWithInteger: (809200 + indexPath.row) ] stringValue ]];
//    url = [url stringByAppendingString:@".png"];
//    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];

    [(UIImageView *)cell.contentView.subviews[0] setImage:image];
    ((UILabel *)cell.contentView.subviews[1]).text = title;
//    ((UILabel *)cell.contentView.subviews[2]).text = url;
    ((UILabel *)cell.contentView.subviews[2]).text = dictionaryForRow[@"subTitle"];

    
    return cell;
}


//UITableViewDelegate
//нажата ячейка списка, обработаем событие, которое от UITableView получает делегат (у нас это этот контроллер)
// Открыть алерт
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //получить по номеру в списке название животного
//    NSString *title = self.animals[indexPath.row];
    NSDictionary *dictionaryForRow = (NSDictionary *)self.animals[indexPath.row];
    NSString *title = dictionaryForRow[@"title"];

//    создадим объект алерта
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];

//    создадим кнопку и задаим замыкание-обработчик нажатия кнопки
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
//    добавим кнопку на алерт
    [alertController addAction:action];

    [alertController dismissViewControllerAnimated:YES completion:nil];

    [self presentViewController: alertController animated:YES completion:nil];
}



//зададим кастомную высоту ячейки НО ТОЛЬКО ЕСЛИ НЕ ИСПОЛЬЗУЕМ КОНСТРЕЙНТЫ, ИНАЧЕ ОНА НЕ ДАЕТ ПОДСТРОИТЬ ВЫСОТУ
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    return [indexPath row] * 20;
//    return 66;
//}



//пробобовать все методы и свойства таблицы
//сделать через одну ячейку два типа ячеек
@end


@implementation ViewController(BirdViewController)

//переписали действие по нажатию ячейки
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BirdViewController *birdViewController = [BirdViewController new];
    [self.navigationController pushViewController:birdViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"willDisplayCell");
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;

    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;

    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);


    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
   
    NSLog(@"%@", cell.contentView.subviews[0]);
    
//    Анимация при отображении кнопки на экране
    NSLog(@"%@", ((UILabel *) cell.contentView.subviews[1]).text);
    
    UIImageView *image = cell.contentView.subviews[0];

    //1. Setup the CATransform3D structure
    CATransform3D imageRotation;
    imageRotation = CATransform3DMakeRotation( ((180*M_PI)/180), 0.0, 1.0, 0.0);
//    imageRotation.m34 = 1.0/ -600;

    //2. Define the initial state (Before the animation)
    image.layer.shadowColor = [[UIColor blackColor]CGColor];
    image.layer.shadowOffset = CGSizeMake(5, 10);
    image.alpha = 0;//стартовое значение затенения
    image.layer.transform = imageRotation;
//    image.animationRepeatCount = 0;



    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1.8];//продолжительность анимации
    image.layer.transform = CATransform3DIdentity;
    image.animationRepeatCount = 0;

    image.alpha = 1;
    image.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
//
//    [self rotateImageView:image];

    
 
//    imageRotation = CATransform3DMakeRotation( ((180*M_PI)/180), 0.0, 1.0, 0.0);
//    imageRotation.m34 = 1.0/ -600;
//
//    //2. Define the initial state (Before the animation)
//    image.layer.shadowColor = [[UIColor greenColor]CGColor];
//    image.layer.shadowOffset = CGSizeMake(5, 10);
//    image.alpha = 1;//стартовое значение затенения
//
//    image.layer.transform = imageRotation;
////        image.layer.anchorPoint = CGPointMake(0, 0.5);
//
//
//    //3. Define the final state (After the animation) and commit the animation
//    [UIView beginAnimations:@"rotation" context:NULL];
//    [UIView setAnimationDuration:6.0];//продолжительность анимации
//    image.layer.transform = CATransform3DIdentity;
//    image.alpha = 1;
//    image.layer.shadowOffset = CGSizeMake(0, 0);
//    [UIView commitAnimations];
}




- (void)rotateImageView:(UIView *)item
{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [item setTransform:CGAffineTransformRotate(item.transform, M_PI_2)];
    }completion:^(BOOL finished){
        if (finished) {
            [self rotateImageView:item];
        }
    }];
}

-(void) rotateImageViewCATransform3DMakeRotation:(UIView *)item{
        //1. Setup the CATransform3D structure
        CATransform3D imageRotation;
        imageRotation = CATransform3DMakeRotation( ((180*M_PI)/180), 0.0, 1.0, 0.0);
    //    imageRotation.m34 = 1.0/ -600;
    
        //2. Define the initial state (Before the animation)
        item.layer.shadowColor = [[UIColor blackColor]CGColor];
        item.layer.shadowOffset = CGSizeMake(5, 10);
        item.alpha = 0;//стартовое значение затенения
        item.layer.transform = imageRotation;
    //    image.animationRepeatCount = 0;
    
    
    
        //3. Define the final state (After the animation) and commit the animation
        [UIView beginAnimations:@"rotation" context:NULL];
        [UIView setAnimationDuration:1.8];//продолжительность анимации
        item.layer.transform = CATransform3DIdentity;
    
        item.alpha = 1;
        item.layer.shadowOffset = CGSizeMake(0, 0);
        [UIView commitAnimations];
    }




 @end
