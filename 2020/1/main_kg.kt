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

    fun dayOne() {
        val expenseColumn = source.useLines { lines -> lines.map { it.toInt() }.toList() }
        // TODO: optimize to only use sublist

        val resultsForThree = expenseColumn.filter {
                expense ->
            expenseColumn.any { secondExpense ->
                expenseColumn.any {
                    it + secondExpense + expense == 2020
                }
            }
        }
        val resultsForTwo = expenseColumn.filter {
                expense ->
            expenseColumn.any { secondExpense ->
                secondExpense + expense == 2020
            }
        }
        if(resultsForThree.size == 3){
            println("Found 3 numbers!")
            println(resultsForThree)
            println("Result of multiply:")
            println(resultsForThree[0]*resultsForThree[1]*resultsForThree[2])
        }
        if(resultsForTwo.size == 2){
            println("Found 2 numbers!")
            println(resultsForTwo)
            println("Result of multiply:")
            println(resultsForTwo[0]*resultsForTwo[1])
        }
    }
    override fun run() {
        when(day) {
            1 -> dayOne()
        }
    }

    }

fun main(args: Array<String>) = ElvesAccountingFixer().main(args)