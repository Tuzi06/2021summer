//      Benchmarking any_shape_zero_area: Collecting 100 samples in estimated 5.0778 s (                                                                                
//      any_shape_zero_area     time:   [28.811 us 28.934 us 29.069 us]
//      Found 3 outliers among 100 measurements (3.00%)
//       1 (1.00%) low mild
//       2 (2.00%) high mild
    
//      Benchmarking any_circle_zero_area: Collecting 100 samples in estimated 5.0443 s                                                                                 
//      any_circle_zero_area    time:   [16.357 us 16.441 us 16.528 us]
//      Found 7 outliers among 100 measurements (7.00%)
//       1 (1.00%) low mild
//       3 (3.00%) high mild
//       3 (3.00%) high severe
    
//      Benchmarking any_rectangle_zero_area: Collecting 100 samples in estimated 5.0840                                                                                
//      any_rectangle_zero_area time:   [16.903 us 16.988 us 17.072 us]
//      Found 3 outliers among 100 measurements (3.00%)
//       3 (3.00%) high mild
    

use rand::Rng;

pub trait Shape {
    fn area(&self) -> f64;
    fn description(&self) -> &str; // used to inspect types during testing
}

#[derive(Debug, Clone)]
pub struct Circle {
    radius: f64,
}
impl Circle {
    pub fn new(radius: f64) -> Circle {
        Circle { radius }
    }
    pub fn random() -> Circle {
        Circle {
            radius: rand::random::<f64>() + 1.0,
        }
    }
}
impl Shape for Circle {
    fn area(&self) -> f64 {
        std::f64::consts::PI * self.radius.powi(2)
    }
    fn description(&self) -> &str {
        "circle"
    }
}

#[derive(Debug, Clone)]
pub struct Rectangle {
    width: f64,
    height: f64,
}
impl Rectangle {
    pub fn new(width: f64, height: f64) -> Rectangle {
        Rectangle { width, height }
    }
    pub fn random() -> Rectangle {
        Rectangle {
            width: rand::random::<f64>() + 1.0,
            height: rand::random::<f64>() + 1.0,
        }
    }
}
impl Shape for Rectangle {
    fn area(&self) -> f64 {
        self.width * self.height
    }
    fn description(&self) -> &str {
        "rectangle"
    }
}

pub fn any_circle_zero_area(shapes: &Vec<Box<Circle>>) -> bool {
    for circle in shapes {
        if circle.area() == 0.0{
            return true;
        }
    }
    return false;
}
pub fn any_rectangle_zero_area(shapes: &Vec<Box<Rectangle>>) -> bool {
    for rectangle in shapes {
        if rectangle.area()== 0.0{
            return true;
        }
    }
    return false;
}
pub fn any_shape_zero_area(shapes: &Vec<Box<dyn Shape>>) -> bool {
    for shape in shapes{
        if shape.area() == 0.0{
            return true
        }
    }
    return false
}

// generate 2*n Circles
pub fn make_circle_vec(n: usize) -> Vec<Box<Circle>> {
    let mut v: Vec<Box<Circle>> = Vec::new();
    let mut i =0;
    while i <2*n{
        v.push(Box::new(Circle::random()));
        i +=1;
    }
    return v;
}
// generate 2*n Rectangles
pub fn make_rectangle_vec(n: usize) -> Vec<Box<Rectangle>> {
    let mut v: Vec<Box<Rectangle>> = Vec::new();
    let mut i =0;
    while i<2*n{
        v.push(Box::new(Rectangle::random()));
        i +=1;
    }
    return v;
}
// generate n Circles and n Rectangles
pub fn make_mixed_vec(n: usize) -> Vec<Box<dyn Shape>> {
    let mut v: Vec<Box<dyn Shape>> = Vec::new();
    let mut i =0;
    while i <n{
        v.push(Box::new(Rectangle::random()));
        v.push(Box::new(Circle::random()));
        i +=1;
    }
    return v;
}