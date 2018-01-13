package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func abort(err string) {
	fmt.Println("ERROR: " + err)
	os.Exit(1)
}

type cfgOpts struct {
	filepath string
}

type gitModule struct {
	path   string
	branch string
	url    string
}

type pathState int

const (
	pathMissing pathState = iota
	pathFolder
	pathNonFolder
)

func main() {
	modules := getModules(cfgOpts{})

	commands := toGitCommands(modules)

	for _, cmd := range commands {
		fmt.Println(cmd)
		/**
		out, err := exec.Command("sh", "-c", cmd).Output()

		if err != nil {
			fmt.Println(string(out))
		}**/

		out, err := exec.Command(cmd).Output()
		if err != nil {
			log.Fatal(err)
		}
		fmt.Printf(string(out))

	}

}

/* debugCurrPath is used for debugging.
*  It should be the folder where command was
* invoked from, even if executable is in another folder
 */
func debugCurrPath() {
	cmd := "echo $PWD"
	out, err := exec.Command("sh", "-c", cmd).Output()
	check(err)
	fmt.Println(string(out))
}

/**
* Parse config file and return configuration
 */
func getModules(opts cfgOpts) []gitModule {
	modules := []gitModule{}

	if opts.filepath == "" {
		opts.filepath = "./config/repos.json"
	}

	bRepos, err := ioutil.ReadFile(opts.filepath)
	check(err)

	var msgMapTemplate interface{}
	err3 := json.Unmarshal([]byte(bRepos), &msgMapTemplate)
	check(err3)
	repos := msgMapTemplate.(map[string]interface{})

	var sBranch, sURL string

	for path, cfg := range repos {
		url := cfg.(map[string]interface{})["url"]
		if url == nil {
			abort("module configuration with missing URL: " + path)
		} else {
			sURL = url.(string)
		}

		branch := cfg.(map[string]interface{})["branch"]
		if branch == nil {
			sBranch = "master"
		} else {
			sBranch = branch.(string)
		}

		module := gitModule{
			path:   path,
			branch: sBranch,
			url:    sURL}

		modules = append(modules, module)
	}

	return modules
}

/*
* Turn config into appropriate git commands. If a destination already
* exists then we do git pull, if not: git clone
 */
func toGitCommands(modules []gitModule) []string {
	commands := []string{}

	var cmd string
	for _, module := range modules {
		pathIs := checkPath(module.path)
		if pathIs == pathFolder {
			cmd = fmt.Sprintf("cd %s && git pull && cd -", module.path)
		} else if pathIs == pathMissing {
			cmd = fmt.Sprintf("git clone -b %s %s %s", module.branch, module.url, module.path)
		} else { // pathIs == pathNonFolder
			abort("Path already exists and is not a folder: " + module.path)
		}
		commands = append(commands, cmd)
	}

	return commands
}

/**
* check whether path exists and is a folder.
*
 */
func checkPath(path string) pathState {
	fi, err := os.Stat(path)

	if os.IsNotExist(err) {
		return pathMissing
	}

	if err == nil {
		if fi.IsDir() {
			return pathFolder
		}
		return pathNonFolder
	}

	panic(err) // some other error
}
