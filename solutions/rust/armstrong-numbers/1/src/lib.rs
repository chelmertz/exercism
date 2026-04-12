pub fn is_armstrong_number(num: u32) -> bool {
    let mut sum: u64 = 0;
    let mut numbers = 0;
    let mut n = num;

    while n > 0 {
        numbers += 1;
        n /= 10;
    }

    n = num;

    while n > 0 {
        sum += (n%10).pow(numbers) as u64;
        n /= 10;
    }
    
    sum == num as u64
}
