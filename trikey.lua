local key_conv = require("common/key_conv")

local M = {}

M.proc = {}

function M.proc.init(env)
	local config = env.engine.schema.config
	env.alphabet = config:get_string("speller/alphabet") or ""
	env.initials = config:get_string("speller/initials") or env.alphabet
end

function M.proc.fini(env)
end

function M.proc.func(key, env)
	local repr = key:repr()
	local char = key_conv.repr2char[repr]

	local context = env.engine.context
	local commit_text = context:get_commit_text() or ""
	local input = context.input or ""
	local back_seg = context.composition:back()
	local len = back_seg.length
	local abc = back_seg:has_tag("abc")

	if len % 3 == 0 and abc and char then
		if not env.initials:find(char,1,true) and commit_text then
			env.engine:commit_text(commit_text)
			context:clear()
		end
	end

	return 2
end

return M
