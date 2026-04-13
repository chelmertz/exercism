#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    if first_list == second_list {
        return Comparison::Equal;
    }
    if first_list.len() == 0 {
        return Comparison::Sublist;
    }

    if second_list.len() == 0 {
        return Comparison::Superlist;
    }

    if first_list
        .windows(second_list.len())
        .any(|window| window == second_list) {
            return Comparison::Superlist;
    }

    if second_list
        .windows(first_list.len())
        .any(|window| window == first_list) {
            return Comparison::Sublist;
    }

    Comparison::Unequal
}
