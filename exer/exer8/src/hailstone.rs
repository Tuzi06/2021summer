pub fn hailstone(n: u64) -> u64 {
    // TODO
    let result = if n % 2 == 0{
        n/2
    } else {
        3*n+1
    };
    return result;
}

pub fn hailstone_sequence_append(n: u64) -> Vec<u64> {
    // TODO
    let mut seq=  Vec::new();
    let mut value =n;
    seq.push(value);
    while value != 1{
        value =  hailstone(value);
        seq.push(value);
    }
    return seq;
}

pub fn hailstone_sequence_prealloc(n: u64) -> Vec<u64> {
    // TODO
    let mut value = n;
    let mut length = 1;
    while value != 1{
        length += 1;
        value = hailstone(value);
    }
    let mut seq = Vec::with_capacity(length);
    let mut i = 0;
    value = n;
    while i <length{
        seq.insert(i,value);
        value = hailstone(value);
        i = i + 1;
    }
    return seq;
}