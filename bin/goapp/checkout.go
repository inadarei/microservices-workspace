package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

/**
* CfgOpts is an opts structure for toGitCommands
 */
type CfgOpts struct {
	update   bool
	filepath string
}

func main() {
	fmt.Println("Hello!")
	commands := toGitCommands(CfgOpts{update: false})

	for _, cmd := range commands {
		fmt.Println(cmd)
	}
}

func toGitCommands(opts CfgOpts) []string {
	commands := []string{}

	if opts.filepath == "" {
		opts.filepath = "../../config/repos.json"
	}
	bRepos, err := ioutil.ReadFile(opts.filepath)
	check(err)

	var msgMapTemplate interface{}
	err3 := json.Unmarshal([]byte(bRepos), &msgMapTemplate)
	check(err3)
	repos := msgMapTemplate.(map[string]interface{})

	for path, cfg := range repos {
		url := cfg.(map[string]interface{})["url"]

		branch := cfg.(map[string]interface{})["branch"]
		if branch == nil {
			branch = "master"
		}

		cmd := ""
		if opts.update {
			cmd = fmt.Sprintf("git clone -b %s %s %s", branch, url, path)
		} else {
			cmd = fmt.Sprintf("cd %s && git pull && cd -", path)
		}

		commands = append(commands, cmd)
	}

	return commands
}
