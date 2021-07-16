
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
    n: i64,
    d: i64,
}

impl Rational {
    pub fn new(n: i64, d: i64) -> Rational {
        // TODO
        Rational { n: n, d: d}
    }
    // TODO: the reduce method
    pub fn reduce(&mut self){
        let divisor = gcd(self.n,self.d);
        self.n = self.n / divisor;
        self.d = self.d / divisor;
    }
}

impl From<i64> for Rational {
    // TODO
    fn from(n: i64) -> Rational {
        Rational { n:n , d: 1}
    }
}
