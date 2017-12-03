package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func main() {
	readder := bufio.NewReader(os.Stdin)
	data, err := readder.ReadString('\n')
	if err != nil {
		fmt.Println("Waat: %v", err)
	}
	data = strings.TrimSuffix(data, "\n")
	v, err := strconv.Atoi(data)
	if err != nil {
		fmt.Println("Waat: %v", err)
	}

	// part 1
	row := 0
	maxVal := 0
	for true {
		maxVal = int(math.Pow(float64(row*2)+math.Pow(1.0, float64(row)), 2))
		if v < maxVal {
			break
		}
		row++
	}
	fmt.Println(row + int(math.Abs(float64(row-(maxVal-v)%(2*row)))))

	// part 2

}
