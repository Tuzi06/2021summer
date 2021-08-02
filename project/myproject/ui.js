
const { spawn} = require('child_process');

const childPython = spawn('python'. ['com.py']);

childPython.stdout.on('data',(data)) =>{
    console.log("stdout: $")
}