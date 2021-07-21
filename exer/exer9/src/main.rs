pub mod rational;
pub mod sort;

fn main() {
    /*// nothing is required here, but you may want to use it for testing.
    let mut r = rational ::Rational::new(6, 8);
    println!("{:?}", r); // prints Rational { n: 6, d: 8 }
    r.reduce();
    println!("{:?}", r); // prints Rational { n: 3, d: 4 }
    let n = rational::Rational::from(4_i64);
    println!("{:?}", n); // prints Rational { n: 4, d: 1 }
    println!("{}", n == rational::Rational::new(4,1)); // prints true*

    println!("{}", r);

    let f= f64::from(r);
    println!("{}",f);

    let r = rational ::Rational::new(6, 8);
    let f: f64 = r.into();
    println!("{}",f);*/


    fn print_type_of<T>(_: &T) {
        println!("{}", std::any::type_name::<T>())
    }

    let mut v2 = Vec::from([1, 6, 2, 4, 8, 2, 1, 4]);
    sort::quicksort(&mut v2);
    println!{"{:?}",v2};
    print_type_of(&v2);
    let mut iterator = v2.iter();
    println!("{:?}", iterator);
    print_type_of(&iterator);

    let mut v3 = Vec::from([1, 6, 2, 4, 8, 2, 1, 4]);
    let mut inte= v3.into_iter();
    print_type_of(&inte);
    println!("{:?}", inte);
    //let mut v3: Vec<char> = "hello world".chars().collect();
    //sort::quicksort(&mut v3);
    //println!("{:?}", v3);

    let mut v = vec![1, 2, 3];
    let u= v.drain(1..);
    print_type_of(&u);
    println!("{:?}",u);
}

