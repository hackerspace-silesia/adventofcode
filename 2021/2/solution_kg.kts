import java.io.File

fun getInputIntoList(fileName: String): List<String>
  = File(fileName).useLines { it.toList() }

val inputList = getInputIntoList("day_2_input_kg.txt")

data class Submarine(var horizontal: Int, var depth: Int)

fun getFinalPosition(inputList: List<String>): Submarine {
    val submarine = Submarine(0, 0)
    for(input in inputList){
      val instructions = input.split(" ")
      val command = instructions[0]
      val value  = instructions[1].toInt()
      when(command) {
        "forward" -> submarine.horizontal += value
        "down" -> submarine.depth += value
        "up" -> submarine.depth -= value
      }
    }
    return submarine
}
val submarine = getFinalPosition(inputList)
println(submarine.depth*submarine.horizontal)

data class AimSubmarine(var horizontal: Int, var depth: Int, var aim: Int)

fun getFinalPositionWithAim(inputList: List<String>): AimSubmarine {
    val submarine = AimSubmarine(0, 0, 0)

    for(input in inputList){
      val instructions = input.split(" ")
      val command = instructions[0]
      val value  = instructions[1].toInt()

      when(command) {
        "forward" -> {
            submarine.horizontal += value
            submarine.depth += submarine.aim * value
        }
        "down" -> submarine.aim += value
        "up" -> submarine.aim -= value
      }
    }
    return submarine
}
val aimSubmarine = getFinalPositionWithAim(inputList)

println(aimSubmarine.depth*aimSubmarine.horizontal)