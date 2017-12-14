package main

import (
	"fmt"
	"math/big"
	"strings"
)

func hexToBin(hex string) string {
	i := new(big.Int)
	i.SetString(hex, 16)

	return fmt.Sprintf("%0128b", i)
}

func readInput() []string {
	var hash string
	rows := []string{}
	for {
		n, _ := fmt.Scanf("%s\n", &hash)
		if n != 1 {
			break
		}
		rows = append(rows, hexToBin(hash))
	}
	return rows
}

func countUsed(rows []string) int {
	sum := 0
	for _, row := range rows {
		sum += strings.Count(row, "1")

	}
	return sum
}

func toMatrix(rows []string) [][]string {
	matrix := [][]string{}
	for _, row := range rows {
		matrix = append(matrix, strings.Split(row, ""))
	}
	return matrix
}

func markGroup(m [][]string, i, j int, group string) {
	m[i][j] = group
	// up
	if i > 0 && m[i-1][j] == "1" {
		markGroup(m, i-1, j, group)
	}
	// down
	if i+1 < len(m) && m[i+1][j] == "1" {
		markGroup(m, i+1, j, group)
	}
	// right
	if j+1 < len(m) && m[i][j+1] == "1" {
		markGroup(m, i, j+1, group)
	}
	// left
	if j > 0 && m[i][j-1] == "1" {
		markGroup(m, i, j-1, group)
	}
}

func countGroups(rows []string) int {
	currG := 2
	matrix := toMatrix(rows)
	for i := 0; i < len(matrix); i++ {
		for j := 0; j < len(matrix); j++ {
			if matrix[i][j] == "1" {
				g := fmt.Sprintf("%d", currG)
				markGroup(matrix, i, j, g)
				currG++
			}
		}
	}
	return currG - 2
}

func main() {
	rows := readInput()
	fmt.Println(countUsed(rows))
	fmt.Println(countGroups(rows))
}
