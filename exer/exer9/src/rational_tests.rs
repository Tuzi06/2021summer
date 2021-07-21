#[cfg(test)]
use crate::rational::Rational;

#[test]
fn rational_test() {
    let mut r = Rational::new(6, 8);
    assert_eq!(format!("{:?}", r), "Rational { n: 6, d: 8 }");
    r.reduce();
    let four1 = Rational::from(4);
    let four2 = Rational::new(4, 1);
    assert_eq!(four1, four2);

    //test display
    let four3= Rational::new(6, 8);
    let four4 = Rational::new(6, 8);
    assert_eq!(f64::from(four3),0.75);
    asser_eq!(four4.into(),0.75);
}
