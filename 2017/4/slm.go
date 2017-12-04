package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"
)

type sortRunes []rune

func (s sortRunes) Less(i, j int) bool {
	return s[i] < s[j]
}

func (s sortRunes) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

func (s sortRunes) Len() int {
	return len(s)
}

func SortString(s string) string {
	r := []rune(s)
	sort.Sort(sortRunes(r))
	return string(r)
}
func main() {
	readder := bufio.NewReader(os.Stdin)
	part1 := 0
	part2 := 0

	for true {
		fields := map[string]bool{}
		sortedFields := map[string]bool{}

		data, err := readder.ReadString('\n')
		if err != nil {
			break
		}
		data = strings.TrimSuffix(data, "\n")
		line := strings.Fields(data)

		duplicates := false
		sortedDuplicates := false
		for _, field := range line {
			_, ok := fields[field]
			if ok {
				duplicates = true
			}
			sortedField := SortString(field)
			_, ok = sortedFields[sortedField]
			if ok {
				sortedDuplicates = true
			}

			sortedFields[sortedField] = true
			fields[field] = true
		}
		if !duplicates {
			part1++
		}
		if !sortedDuplicates {
			part2++
		}
	}
	fmt.Println(part1)
	fmt.Println(part2)
}
