package main

import "fmt"

func generator(start, factor uint32) uint32 {
	product := start * factor % 2147483647
	return product
}

func generatorA2(start, factor uint32) uint32 {
	for {
		start = start * factor % 2147483647
		if start%4 == 0 {
			break
		}
	}
	return start
}

func generatorB2(start, factor uint32) uint32 {
	for {
		start = start * factor % 2147483647
		if start%8 == 0 {
			break
		}
	}
	return start
}

func count(genA, genB func(uint32, uint32) uint32, a, b uint32, cycles int) int {
	counter := 0
	for i := 0; i < cycles; i++ {
		a = genA(a, 16807)
		b = genB(b, 48271)
		if a&0xffff == b&0xffff {
			counter++
		}
	}
	return counter
}

func main() {
	var startA, startB uint32
	fmt.Scanf("%d %d", &startA, &startB)
	// part 1
	fmt.Println(count(generator, generator, startA, startB, 40000000))
	// part 2
	fmt.Println(count(generatorA2, generatorB2, startA, startB, 5000000))
}
