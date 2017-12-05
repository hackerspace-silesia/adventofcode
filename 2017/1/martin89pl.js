const fs = require('fs');
const path = require('path');    
filePath = path.join(__dirname, 'input.txt');

function readInput(filePath){
    
    fs.readFile(filePath, 'utf-8' , function(err,data){
        if (!err) {
            console.log(InverseCaptcha(data));
        } else {
            throw new Error(`${err.message}`);
        }
    });

}

function InverseCaptcha(str) {

    let sum = 0; 

    for (var i = 0; i < str.length; i++) {
       if(Number.parseInt(str[i]) === Number.parseInt(str[i + 1]) ){
         sum += Number.parseInt(str[i]);
       }
       if((i === (str.length - 1)) && (Number.parseInt(str[str.length - 1]) === Number.parseInt(str[0]))){
        sum += Number.parseInt(str[i]);        
       }
    }
    return sum;
  }
readInput(filePath); // 1393
// That's the right answer! You are one gold star closer to debugging the printer.

