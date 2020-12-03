import com.github.ajalt.clikt.core.CliktCommand
import com.github.ajalt.clikt.parameters.arguments.argument
import com.github.ajalt.clikt.parameters.options.default
import com.github.ajalt.clikt.parameters.options.option
import com.github.ajalt.clikt.parameters.types.file
import com.github.ajalt.clikt.parameters.types.int
import java.math.BigInteger


class ElvesAccountingFixer : CliktCommand() {
    private val source by argument().file(mustExist = true)
    private val day by option(help="Advent of Code day?").int().default(1)

    fun dayThree() {
        val mapTile = source.useLines { lines -> lines.toList() }
        var mapMatrix = mapTile.toList()
        fun countSlope(moveRight: Int, moveDown: Int): BigInteger {
            var positionX = 0
            var positionY = 0
            var treeCount = 0
            fun extendMap(mapMatrix: List<String>, mapTile: List<String>): List<String> {
                return mapMatrix.mapIndexed { index, s -> s.plus(mapTile[index]) }
            }
            while (true) {
                positionX = positionX + moveRight
                positionY = positionY + moveDown
                if (positionY >= mapMatrix.size) {
                    break
                }
                if (positionX >= mapMatrix[positionY].length) {
                    mapMatrix = extendMap(mapMatrix, mapTile)
                }
                if (mapMatrix[positionY][positionX] == '#') {
                    treeCount++
                }
            }
            return treeCount.toBigInteger()
        }
        val first_result = countSlope(1, 1)
        val second_result = countSlope(3, 1)
        val third_result = countSlope(5, 1)
        val fourth_result = countSlope(7, 1)
        val fifth_result = countSlope(1, 2)

        println("Tree count 1,1 ".plus(first_result))
        println("Tree count 3,1 ".plus(second_result))
        println("Tree count 5,1 ".plus(third_result))
        println("Tree count 7,1 ".plus(fourth_result))
        println("Tree count 1,2 ".plus(fifth_result))
        val final_result = first_result * second_result * third_result * fourth_result * fifth_result
        println("Final Result ".plus(final_result))
    }

    override fun run() {
        when(day) {
            3 -> dayThree()
        }
    }

    }

fun main(args: Array<String>) = ElvesAccountingFixer().main(args)