const fs = require('fs'),
path = require('path');    
filePath = path.join(__dirname, 'input.txt');

class CorruptionChecksum {
    constructor(filePath){
        this.filePath = filePath;
    }
    getResult() {
        fs.readFile(filePath, 'utf8',  (err,data) => {
            let sum = 0; 
                data.match(/[^\r\n]+/g).map( (row)=>{ 
                    let arrRow = row.match(/(\d+)/g);
                    let numbersRow = arrRow.map( (numb) => Number.parseInt(numb) );
                    sum += Number.parseInt(Math.max(...numbersRow)) - Number.parseInt(Math.min(...numbersRow));    
                });
            console.log(sum);
        });
    }
}

let checksum = new CorruptionChecksum(filePath);
checksum.getResult();
// The first half of this puzzle is complete! It provides one gold star: *