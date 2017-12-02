package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	var curr string
	sum := 0
	readder := bufio.NewReader(os.Stdin)
	data, _ := readder.ReadString('\n')
	data = strings.TrimSuffix(data, "\n")

	// part 1
	prev := string([]byte{data[0]})
	start := prev

	for i := 1; i < len(data); i++ {
		curr = string([]byte{data[i]})
		if prev == curr {
			v, _ := strconv.Atoi(curr)
			sum += v
		}
		prev = curr
	}
	if start == curr {
		v, _ := strconv.Atoi(curr)
		sum += v
	}
	fmt.Println(sum)

	// part 2
	sum = 0
	var j int
	jump := len(data) / 2
	for i := 0; i < len(data); i++ {
		if i+jump >= len(data) {
			j = i + jump - len(data)
		} else {
			j = i + jump
		}
		curr := string([]byte{data[i]})
		jump := string([]byte{data[j]})
		if curr == jump {
			v, _ := strconv.Atoi(curr)
			sum += v
		}
		prev = curr
	}
	fmt.Println(sum)
}
