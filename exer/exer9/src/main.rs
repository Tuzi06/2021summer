pub mod rational;
//pub mod sort;

fn main() {
    // nothing is required here, but you may want to use it for testing.
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
    println!("{}",f);
}

