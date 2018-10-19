-- load original
local clink_lua_file = clink.get_env('CLINK_ROOT')..'/clink.lua'
dofile(clink_lua_file)

local completions_dir = clink.get_env('USERPROFILE')..'/.clink/scripts/clink-completions/'
for _,lua_module in ipairs(clink.find_files(completions_dir..'*.lua')) do
    -- Skip files that starts with _. This could be useful if some files should be ignored
    if not string.match(lua_module, '^_.*') then
		local filename = completions_dir..lua_module
		dofile(filename)
	end
end
