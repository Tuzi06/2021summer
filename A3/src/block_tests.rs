#[cfg(test)]
mod block_tests {
    use crate::block::Block;
    use std::fmt::Write;
    #[test]
    fn basics() {
        let mut b0 = Block::initial(16);
        b0.set_proof(56231);
        assert_eq!(
            b0.hash_string(),
            "0000000000000000000000000000000000000000000000000000000000000000:0:16::56231"
        );
        let b1 = Block::next(&b0, String::from("message"));
        assert_eq!(
            b1.hash_string_for_proof(2159),
            "6c71ff02a08a22309b7dbbcee45d291d4ce955caa32031c50d941e3e9dbd0000:1:16:message:2159"
        );
        let mut output = String::new();
        write!(&mut output, "{:02x}", b1.hash_for_proof(2159)).unwrap();
        assert_eq!(
            output,
            "9b4417b36afa6d31c728eed7abc14dd84468fdb055d8f3cbe308b0179df40000"
        );
    }

    #[test]
    fn is_valid_proof() {
        let mut b0 = Block::initial(16);
        assert_eq!(b0.is_valid_for_proof(0), false);
        b0.set_proof(56231);
        assert_eq!(b0.is_valid_for_proof(56231), true);
        assert_eq!(b0.is_valid(), true);
    }

    #[test]
    fn mine_test() {
        let mut b0 = Block::initial(7);
        b0.mine(200);
        assert_eq!(
            "0000000000000000000000000000000000000000000000000000000000000000:0:7::385",
            b0.hash_string()
        );
        let mut b1 = Block::next(&b0, String::from("this is an interesting message"));
        b1.mine(200);
        assert_eq!(b1.hash_string(),"379bf2fb1a558872f09442a45e300e72f00f03f2c6f4dd29971f67ea4f3d5300:1:7:this is an interesting message:20");
        let mut b2 = Block::next(&b1, String::from("this is not interesting"));
        b2.mine(200);
        assert_eq!("4a1c722d8021346fa2f440d7f0bbaa585e632f68fd20fed812fc944613b92500:2:7:this is not interesting:40", b2.hash_string());
    }
}
