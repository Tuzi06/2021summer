//pub mod find;
pub mod hailstone;
//pub mod rational;

fn main() {
    // nothing is required here, but you may want to use it for testing.
    println!("{}", hailstone::hailstone(17)==52);
    println!("{}", hailstone::hailstone(18)==9);
    println!("{}", hailstone::hailstone_sequence_append(5) == Vec::<u64>::from([5, 16, 8, 4, 2, 1]));
    println!("{}", hailstone::hailstone_sequence_prealloc(5) == Vec::<u64>::from([5, 16, 8, 4, 2, 1]));
    
    
}
