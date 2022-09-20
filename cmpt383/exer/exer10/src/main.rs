mod dynamic;
// mod files;

// use files::SummationError;
// use std::path::Path;

// fn test_each_file(sum_file: fn(&Path) -> Result<i64, SummationError>) {
//     println!("Success: {:?}", sum_file(Path::new("good.txt")));
//     println!(
//         "No such file or directory: {:?}",
//         sum_file(Path::new("missing_file.txt"))
//     );
//     println!(
//         "Did not contain valid UTF-8: {:?}",
//         sum_file(Path::new("bad_utf8.txt"))
//     );
//     println!(
//         "Invalid digit found: {:?}",
//         sum_file(Path::new("bad_number.txt"))
//     );
// }

fn main() {
    // test_each_file(files::sum_file_1);
    // test_each_file(files::sum_file_2);

    let mut v: Vec<Box<dynamic::Circle>> = Vec::new();
    v.push(Box::new(dynamic::Circle::new(5.0)));
    v.push(Box::new(dynamic::Circle::new(2.0)));
    v.push(Box::new(dynamic::Circle::new(0.0)));
    v.push(Box::new(dynamic::Circle::new(2.0)));
    println!("{}",dynamic::any_circle_zero_area(&v));

    let mut v: Vec<Box<dynamic::Rectangle>> = Vec::new();
    v.push(Box::new(dynamic::Rectangle::new(5.4, 3.2)));
    v.push(Box::new(dynamic::Rectangle::new(1.2, 3.4)));
    //v.push(Box::new(dynamic::Rectangle::new(5.4, 0.0)));
    v.push(Box::new(dynamic::Rectangle::new(1.2, 4.8)));
    println!("{}",dynamic::any_rectangle_zero_area(&v));

    let mut v: Vec<Box<dyn dynamic::Shape>> = Vec::new();
    v.push(Box::new(dynamic::Rectangle::new(5.4, 3.2)));
    v.push(Box::new(dynamic::Circle::new(1.0)));
    //v.push(Box::new(dynamic::Rectangle::new(0.0, 3.2)));
    v.push(Box::new(dynamic::Circle::new(3.0)));
    println!("{}",dynamic::any_shape_zero_area(&v));



    let v: Vec<Box<dynamic::Circle>> = dynamic::make_circle_vec(100000);
    //println!("{:?}",v);
    println!("{}",dynamic::any_circle_zero_area(&v));
    let v: Vec<Box<dynamic::Rectangle>> = dynamic::make_rectangle_vec(100000);
    //println!("{:?}",v);
    println!("{}",dynamic::any_rectangle_zero_area(&v));

    let v: Vec<Box<dyn dynamic::Shape>> = dynamic::make_mixed_vec(100000);
    println!("{}",dynamic::any_shape_zero_area(&v));
}
