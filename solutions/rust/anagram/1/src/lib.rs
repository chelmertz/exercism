use std::collections::HashSet;

fn sorted_chars(word: &str) -> Vec<char> {
    let mut chars: Vec<char> = word.to_lowercase().chars().collect();
    chars.sort();
    chars
}

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let target: Vec<char> = sorted_chars(&word);

    possible_anagrams
        .iter()
        .copied() // avoid one level of indirection
        // same word = not anagram
        .filter(|maybe| maybe.to_lowercase() != word.to_lowercase())
        .filter(|maybe| {
            let sorted = sorted_chars(maybe);
            sorted == target
        })
        .collect::<HashSet<_>>()
}
