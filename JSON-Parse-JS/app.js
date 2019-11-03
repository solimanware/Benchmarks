const fs = require('fs');
const JSONstring = fs.readFileSync('drugs.json').toString()
//benchmark scoope
const BenchmarkMS = (name, block) => {
    const start = +new Date();
    block();
    const end = +new Date();
    console.log(name, 'took', end - start);
    return end - start
};
//one time experiment
BenchmarkMS('json parsing', () => {
    const json = JSON.parse(JSONstring)
})
//multiple times experiments
const  benchOnScale = (name, times, block) => {
    let totalTime = 0;
    for (let i = 0; i < times; i++) {
        totalTime = totalTime + BenchmarkMS(name, () => {
            block()
        })

    }
    let avarage = totalTime / times
    console.log('Total of invoking', name, times, 'times', 'took', avarage);
}

//100 times experment
benchOnScale('JsonParsing', 100, () => {
    const json = JSON.parse(JSONstring)
})



