import subprocess

def run(command):
    output = subprocess.check_output(command, shell=True)
    return output.decode().strip("\n").split("\n")

def diff2List(list1, list2, ignoreList):
    set_dif = set(list1).symmetric_difference(set(list2))
    toCreateList = list(set_dif)
    for ignore in ignoreList:
        if ignore in toCreateList:
            toCreateList.pop(toCreateList.index(ignore))
    print("diff: ", toCreateList)
    return toCreateList

def main():

    """ Get contracts and scripts list"""
    contractList = run("ls ./src/")
    scriptList = run("ls ./script/")

    """ Find diff of 2 lists """
    toCreateList = diff2List(contractList, scriptList, ['helpers'])

    """ Create script and README from template"""
    scriptDirectory = "./script"
    srcDirectory = "./src"
    templateWord = "SOLVERTEMPLATE"
    temaplateScriptContent = open("%s/%s/%s.s.sol"% (scriptDirectory, templateWord, templateWord)).read()
    temaplateREADMEContent = open("%s/%s/README.md"% (scriptDirectory, templateWord)).read()
    for directory in toCreateList:
        """ Script """
        contractPath = "%s/%s/" % (srcDirectory, directory)
        contract = run("ls %s" % contractPath)[0].replace(".sol", "")
        scriptPath = "%s/%s/%s.s.sol" % (scriptDirectory, directory, directory)
        newContent = temaplateScriptContent.replace(
            "src/SOLVERTEMPLATE/SOLVERTEMPLATE.sol",
            "src/%s/%s.sol" % (directory, contract)
        )
        print( "src/%s/%s.sol" % (directory, contract))
        run("mkdir ./script/%s" % directory)
        newContent = newContent.replace(templateWord, contract)
        newScript = open(scriptPath, "w")
        newScript.write(newContent)
        """ README """
        newREADMEPath = "%s/%s/README.md" % (scriptDirectory, directory)
        newREADMEContent = temaplateREADMEContent.replace(templateWord, directory)
        newREADME = open(newREADMEPath, "w")
        newREADME.write(newREADMEContent)
        
main()
