pub fn find_elt<T: Eq>(values: &Vec<T>, elt: T) -> Option<usize> {
    // TODO
    let mut i =0;
    for value in values{
        if *value == elt{
            return Some(i);
        }
        else {
            i=i+1;
        }
    }
    return None;
}
