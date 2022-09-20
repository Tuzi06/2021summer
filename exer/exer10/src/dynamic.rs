// Zero Area Checks/any_shape_zero_area                        
//                         time:   [32.278 us 32.885 us 33.600 us]
//                         change: [-26.215% -23.404% -20.773%] (p = 0.00 < 0.05)
//                         Performance has improved.
// Found 6 outliers among 100 measurements (6.00%)
//   4 (4.00%) high mild
//   2 (2.00%) high severe
// Benchmarking Zero Area Checks/any_circle_zero_area: Collecting 100 samples in es                                                                                Zero Area Checks/any_circle_zero_area                        
//                         time:   [16.287 us 16.417 us 16.576 us]
//                         change: [-12.582% -11.326% -10.039%] (p = 0.00 < 0.05)
//                         Performance has improved.
// Found 6 outliers among 100 measurements (6.00%)
//   5 (5.00%) high mild
//   1 (1.00%) high severe
// Benchmarking Zero Area Checks/any_rectangle_zero_area: Collecting 100 samples in                                                                                Zero Area Checks/any_rectangle_zero_area                        
//                         time:   [16.656 us 16.733 us 16.822 us]
//                         change: [-34.298% -29.947% -25.435%] (p = 0.00 < 0.05)
//                         Performance has improved.
// Found 6 outliers among 100 measurements (6.00%)
//   3 (3.00%) high mild
//   3 (3.00%) high severe

    


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