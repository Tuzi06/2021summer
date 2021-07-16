
fn gcd(a: i64, b: i64) -> i64 {
    // TODO
    let mut common_divisor = 0;
    let mut i =1;
    while i <=a && i <=b{
        if a % i ==0 && b % i ==0 {
            common_divisor =i;
        }
        i+=1;
    }
    return common_divisor;
}

#[derive(Debug, Clone, PartialEq)]
pub struct Rational {
    // TODO
    num: i64,
    den: i64,
}

impl Rational {
    pub fn new(n: i64, d: i64) -> Rational {
        // TODO
        Rational { num: n, den: d}
    }
    // TODO: the reduce method
    pub fn reduce(&mut self){
        let divisor = gcd(num,den);
        self.num = self.num / divsor;
        self.den = self.den / divsor;
    }
}

impl From<i64> for Rational {
    // TODO
    
}
