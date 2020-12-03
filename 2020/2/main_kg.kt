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

    fun dayTwo() {
        data class PasswordRule(
            var ruleMin: Int,
            val ruleMax: Int,
            val character: String,
            val password: String)


        val regex = """(\d+)-(\d+) (\w): (\w+)""".toRegex()
        val passwordList = source.useLines { lines -> lines.toList() }
        val finalFirstPasswordList = passwordList.filter {
            val (ruleMin, ruleMax, character, password) = regex.find(it)!!.destructured
            val passwordRule = PasswordRule(ruleMin.toInt(), ruleMax.toInt(), character, password)

            val countLambda = {
                char: Char -> char == character.single()
            }
            (passwordRule.ruleMin <= password.count(countLambda))
                    && (passwordRule.ruleMax >= password.count(countLambda))
        }
        val finalSecondPasswordList = passwordList.filter {
            val (ruleMin, ruleMax, character, password) = regex.find(it)!!.destructured
            val passwordRule = PasswordRule(ruleMin.toInt(), ruleMax.toInt(), character, password)

            (password[passwordRule.ruleMin-1] == character.single()).xor(password[passwordRule.ruleMax-1] == character.single())

        }
        println("Password list size: ".plus(passwordList.size))
        println("Password list size after using first filtering: ".plus(finalFirstPasswordList.size))
        println("Password list size after using second filtering: ".plus(finalSecondPasswordList.size))
    }
    override fun run() {
        when(day) {
            2 -> dayTwo()
        }
    }

    }

fun main(args: Array<String>) = ElvesAccountingFixer().main(args)