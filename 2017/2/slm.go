package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	spread := [][]int{}
	readder := bufio.NewReader(os.Stdin)
	for true {
		data, err := readder.ReadString('\n')
		if err != nil {
			break
		}
		data = strings.TrimSuffix(data, "\n")
		s := strings.Fields(data)
		line := []int{}
		for _, el := range s {
			v, _ := strconv.Atoi(el)
			line = append(line, v)
		}
		spread = append(spread, line)
	}

	// part 1
	sum := 0
	for _, line := range spread {
		min := line[0]
		max := line[0]
		for _, v := range line {
			if v > max {
				max = v
			}
			if v < min {
				min = v
			}
		}
		sum += max - min
	}
	fmt.Println(sum)

	// part 2
	sum = 0
	for _, line := range spread {
		for i, v := range line {
			for j := i + 1; j < len(line); j++ {
				v2 := line[j]
				if v > v2 {
					if v%v2 == 0 {
						sum += v / v2
					}
				} else {
					if v2%v == 0 {
						sum += v2 / v
					}
				}
			}
		}
	}
	fmt.Println(sum)
}
