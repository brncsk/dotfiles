# Load start.jl
const STARTUPFILE = "startup.jl"

startup_path = string(pwd(), "/", STARTUPFILE);
if isfile(startup_path)
	include(startup_path)
end
