pub mod queue;
pub mod block; 
use std::fmt::Write;
fn main() {
    // Nothing is required here, but it may be useful for testing.
    // let mut b0 = block::Block::initial(16);
    // println!("{}",  b0.is_valid_for_proof(0));
    // b0.set_proof(56231);
    // println!("{}",  b0.is_valid_for_proof(56231));
    // println!("{}",   b0.is_valid());
    // let mut b1 = block::Block::next(&b0, String::from("message"));
    // b1.set_proof(2159);
    // use std::fmt::Write;
    // let mut output = String::new();

    // println!("{:?}",b0.hash_string());
    // write!(&mut output, "{:02x}", b0.hash()).unwrap();
    // println!("{}",output);

    // println!("{:?}", b0.hash());

    // let mut output = String::new();
    // println!("{:?}",b1.hash_string());
    // write!(&mut output, "{:02x}", b1.hash()).unwrap();
    // println!("{}",output);

    // let mut b0 = block::Block::initial(19);

    // println!("{}",19/8);
    // println!("{}",19%8);
    // b0.set_proof(87745);
    // let mut b1 = block::Block::next(&b0, String::from("hash example 1234"));
    // b1.set_proof(1407891);
    // let mut output = String::new();
    // println!("{:?}",b1.hash_string());
    // println!("{:?}",b1.hash());
    // write!(&mut output, "{:02x}", b1.hash()).unwrap();
    // println!("{}",output);
    // println!("{}",   b1.is_valid());

    //println!("{}",8*(1<<16)/2345);
    
    let mut b0 = block::Block::initial(7);
    b0.mine(1);

    //b0.set_proof(385);

    println!("{}",b0.is_valid());
    println!("{}", b0.hash_string());
    println!("{:02x}", b0.hash());
    // let mut b1 = block::Block::next(&b0, String::from("this is an interesting message"));
    // b1.mine(1);
    // println!("{}", b1.hash_string());
    // println!("{:02x}", b1.hash());
    // let mut b2 = block::Block::next(&b1, String::from("this is not interesting"));
    // b2.mine(1);
    // println!("{}", b2.hash_string());
    // println!("{:02x}", b2.hash());

}

