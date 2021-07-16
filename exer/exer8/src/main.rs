//pub mod find;
pub mod hailstone;
//pub mod rational;

fn main() {
    // nothing is required here, but you may want to use it for testing.
    println!("{}", hailstone::hailstone(17)==52);
    println!("{}", hailstone::hailstone(18)==9);
    println!("{}", hailstone::hailstone_sequence_append(5) == Vec::<u64>::from([5, 16, 8, 4, 2, 1]));
    println!("{}", hailstone::hailstone_sequence_prealloc(5) == Vec::<u64>::from([5, 16, 8, 4, 2, 1]));
    
    /*let v1: Vec<i32> = Vec::from([4, 5, 2, 8, 7, 3, 1]);
    println!("{:?}", find_elt(&v1, 8)); // Some(3)
    println!("{:?}", find_elt(&v1, 6)); // None
    let v2: Vec<char> = "Hello World!".chars().collect();
    println!("{:?}", find_elt(&v2, 'o')); // Some(4)
    println!("{:?}", find_elt(&v2, 'q')); // None*/

}
