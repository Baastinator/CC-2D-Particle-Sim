local function makeFolder(path)
	if not fs.exists(path) then
		fs.makeDir(path)
	end
end

local function completed()
	print("completed")
end

local function creating(text)
	write("creating file "..text.."... ")
end

while true do
	term.clear() term.setCursorPos(1,1)
	print("Welcome to the particle simulation installation process, would you like to install? (y/n)")
	local input = read()
	if input == "y" then
		shell.run("cd /")
		write("making folder home... ")
		makeFolder("home")
		completed()
		write("making folder lib... ")
		makeFolder("lib")
		completed()
		shell.run("cd /home")
		creating("main")
		shell.run("pastebin get 6GYnRxNP main.lua")
		completed()
		shell.run("cd /lib")
		creating("linalg")
		shell.run("pastebin get EmRMxVGJ linalg.lua")
		completed()
		creating("draw")
		shell.run("pastebin get EmRMxVGJ draw.lua")
		completed()
		creating("grid")
		shell.run("pastebin get EmRMxVGJ grid.lua")
		completed()
		creating("import")
		shell.run("pastebin get EmRMxVGJ import.lua")
		completed()
		creating("mathb")
		shell.run("pastebin get EmRMxVGJ mathb.lua")
		completed()
		term.clear() term.setCursorPos(1,1)
		print("Successfully installed!")
		break
	elseif input == "n" then
		term.clear() term.setCursorPos(1,1)
		break
	else

	end
end