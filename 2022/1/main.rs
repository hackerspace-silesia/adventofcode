use std::fs::File;
use std::io::{Error, BufReader};
use std::io::Read;


fn read_file_to_string(filepath: &str) -> String{
    let file = File::open(filepath).expect("Unable to open");
    let mut reader = BufReader::new(file);
    let mut contents = String::new();
    reader.read_to_string(&mut contents);
    return contents
}

fn swap(param_int_array: &mut [i32], i: usize, j: usize ) {
    let temp = param_int_array[i];
    param_int_array[i] = param_int_array[j];
    param_int_array[j] = temp;
}
//move to the left values lower than pivot
fn partition(param_int_array: &mut [i32], start: usize, end: usize ) -> i32 {

    let pivot = param_int_array[end];

    let mut index = start;

    let mut i = start;
    while i < end {

        if param_int_array[i] < pivot {
            swap(param_int_array, i, index);
            index+=1;
        }

        i+=1;
    }
    swap(param_int_array, index, end);
    return index as i32;
}
fn quick_sort(param_int_array: &mut [i32], start: usize, end: usize) {
    if start >= end {
        return;
    }
    if end < 0 {
        // be sure that values are not negative
        return;
    }

    let pivot = partition(param_int_array, start, end);
    if pivot >0{
    quick_sort(param_int_array, start, (pivot - 1) as usize);
    }
    quick_sort(param_int_array, (pivot + 1) as usize, end);
}

fn main() -> Result<(), Error> {
    let file_path = "./input.txt";
    let contents=read_file_to_string(file_path);
    let v: Vec<&str> = contents.split("\n").collect();
    // first task
    let mut max_sum = 0;
    let mut index_of_max_sum = 0;
    let mut local_sum = 0;
    for i in 0..v.len() {
        if ! v[i].eq(""){
            let calories: i32 = v[i].parse().unwrap();
            local_sum+=calories;
        }else{
            index_of_max_sum+=1;
            if local_sum>max_sum{
                max_sum=local_sum;
            }
            local_sum=0;
        }
    }
    print!("number of elf {:?} \n", index_of_max_sum);
    print!("max number of calories {:?} \n ", max_sum);

    // second task
    let mut calories_sums: Vec<i32> = Vec::new();
    let mut local_sum = 0;
    for i in 0..v.len() {
        if ! v[i].eq(""){
            let calories: i32 = v[i].parse().unwrap();
            local_sum+=calories;
        }else{
            calories_sums.push(local_sum);
            local_sum=0;
        }
    }

    let last_index = calories_sums.len() - 1;
    quick_sort(&mut calories_sums, 0, last_index);

    let top3_sum = calories_sums[last_index] + calories_sums[last_index-1]+ calories_sums[last_index-2];
    print!("top 3 sum {:?} \n", top3_sum);
    Ok(())
}
