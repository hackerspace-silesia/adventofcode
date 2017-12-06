package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func readInput() ([]int, error) {
	readder := bufio.NewReader(os.Stdin)
	data, err := readder.ReadString('\n')
	if err != nil {
		return nil, err
	}
	data = strings.TrimSuffix(data, "\n")
	sBanks := strings.Fields(data)
	banks := []int{}
	for _, s := range sBanks {
		v, _ := strconv.Atoi(s)
		banks = append(banks, v)
	}
	return banks, nil
}

func hashBanks(banks []int) string {
	s := []string{}
	for _, v := range banks {
		s = append(s, fmt.Sprintf("%d", v))
	}
	return strings.Join(s, ",")
}

func rebalance(banks []int) []int {
	max := 0
	maxIndex := 0
	for i, v := range banks {
		if v > max {
			max = v
			maxIndex = i
		}
	}

	banks[maxIndex] = 0
	blocks := max
	index := maxIndex + 1
	maxIndex = len(banks)
	for blocks > 0 {
		if index >= maxIndex {
			index = 0
		}
		banks[index]++
		blocks--
		index++
	}
	return banks
}

func main() {
	banks, err := readInput()
	if err != nil {
		log.Fatal(err)
	}
	hashes := map[string]bool{}
	steps := 0
	hash := ""
	// part 1
	for true {
		steps++
		banks = rebalance(banks)
		hash = hashBanks(banks)
		_, ok := hashes[hash]
		if ok {
			break
		}
		hashes[hash] = true
	}
	fmt.Println(steps)

	//part 2
	steps = 0
	for true {
		steps++
		banks = rebalance(banks)
		newHash := hashBanks(banks)
		if hash == newHash {
			break
		}
	}
	fmt.Println(steps)
}
