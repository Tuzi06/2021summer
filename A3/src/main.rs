pub mod queue;
pub mod block;
fn main() {
    // Nothing is required here, but it may be useful for testing.
    let mut b0 = Block::initial(16);
    b0.mine(1); // or b0.set_proof(56231);
    let mut b1 = Block::next(&b0, String::from("message"));
    b1.mine(1); // or b1.set_proof(2159);

}

