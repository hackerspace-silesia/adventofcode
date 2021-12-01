package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func calculateIncreases(inputFile string) int {
	file, err := os.Open(inputFile)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	prev := -1
	current := 0
	counter := 0
	for scanner.Scan() {
		current, err = strconv.Atoi(scanner.Text())
		fmt.Println(counter)
		if prev >= 0 {
			if current > prev {
				counter = counter + 1
				fmt.Println(counter)
			}
		}
		prev = current
	}

	return counter
}

func calculateIncreasesBySlidingWindow(inputFile string) int {
	file, err := os.Open(inputFile)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	var measurmentSlice []int
	for scanner.Scan() {
		current, _ := strconv.Atoi(scanner.Text())
		measurmentSlice = append(measurmentSlice, current)
	}
	idx := 0
	counter := 0
	for len(measurmentSlice) > idx+3 {
		fmt.Println(measurmentSlice[idx])
		if sum(measurmentSlice[idx:idx+3]) < sum(measurmentSlice[idx+1:idx+4]) {
			counter += 1
		}
		idx += 1
	}
	return counter
}

func sum(slice []int) int {
	sum := 0
	for _, val := range slice {
		sum += val
	}
	return sum
}

func main() {
	resultFirstPart := calculateIncreases("input_kg.txt")
	fmt.Println("Solution for first part is: ")
	fmt.Println(resultFirstPart)

	resultSecondPart := calculateIncreasesBySlidingWindow("input_kg.txt")
	fmt.Println("Solution for second part is: ")
	fmt.Println(resultSecondPart)

}
