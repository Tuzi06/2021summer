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


/*Benchmarking hailstone_sequence_append_7: Collecting 100 samples in estimated 5.                                                                                hailstone_sequence_append_7                        
                        time:   [129.41 ns 130.21 ns 131.04 ns]
Found 6 outliers among 100 measurements (6.00%)
  3 (3.00%) high mild
  3 (3.00%) high severe

Benchmarking hailstone_sequence_prealloc_7: Collecting 100 samples in estimated                                                                                 hailstone_sequence_prealloc_7                        
                        time:   [61.594 ns 61.930 ns 62.271 ns]
Found 6 outliers among 100 measurements (6.00%)
  2 (2.00%) low mild
  2 (2.00%) high mild
  2 (2.00%) high severe

Benchmarking hailstone_sequence_append_162964: Collecting 100 samples in estimat                                                                                hailstone_sequence_append_162964                        
                        time:   [232.49 ns 234.28 ns 236.11 ns]
Found 9 outliers among 100 measurements (9.00%)
  2 (2.00%) high mild
  7 (7.00%) high severe

Benchmarking hailstone_sequence_prealloc_162964: Collecting 100 samples in estim                                                                                hailstone_sequence_prealloc_162964                        
                        time:   [132.67 ns 133.25 ns 133.86 ns]
Found 8 outliers among 100 measurements (8.00%)
  2 (2.00%) low mild
  4 (4.00%) high mild
  2 (2.00%) high severe

Benchmarking hailstone_sequence_append_686901248: Collecting 100 samples in esti                                                                                hailstone_sequence_append_686901248                        
                        time:   [806.37 ns 810.03 ns 813.85 ns]
Found 6 outliers among 100 measurements (6.00%)
  4 (4.00%) low mild
  1 (1.00%) high mild
  1 (1.00%) high severe

Benchmarking hailstone_sequence_prealloc_686901248: Collecting 100 samples in es                                                                                hailstone_sequence_prealloc_686901248                        
                        time:   [922.95 ns 928.15 ns 933.72 ns]
Found 6 outliers among 100 measurements (6.00%)
  4 (4.00%) high mild
  2 (2.00%) high severe
*/