package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	data, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		log.Fatal(err)
	}
	strings := strings.Fields(string(data))
	ins := []int{}
	for _, s := range strings {
		v, _ := strconv.Atoi(s)
		ins = append(ins, v)
	}

	// part 1
	index := 0
	offset := 0
	steps := 0
	for true {
		if index < 0 || index >= len(ins) {
			break
		}
		offset = ins[index]
		ins[index]++
		steps++
		index += offset
	}
	fmt.Println(steps)

	// part2
	ins = []int{}
	for _, s := range strings {
		v, _ := strconv.Atoi(s)
		ins = append(ins, v)
	}
	index = 0
	offset = 0
	steps = 0
	for true {
		if index < 0 || index >= len(ins) {
			break
		}
		offset = ins[index]
		if offset >= 3 {
			ins[index]--
		} else {
			ins[index]++
		}
		steps++
		index += offset
	}
	fmt.Println(steps)
}
