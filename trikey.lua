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
	elseif back_seg:has_tag("punct") and len == 1 and not key:release() then
		if input ~= "" and env.initials:find(input:sub(#input,#input),1,true) then
			if char and env.alphabet:find(char,1,true) then
				context:clear()
				context:push_input(input..char)
				return 1
			end
		end
	end

	return 2
end

M.seg = {}

function M.seg.init(env)
	env.alphabet = env.engine.schema.config:get_string("speller/alphabet") or ""
end

function M.seg.fini(env)
end

function M.seg.func(segmentation, env)
	local input = segmentation.input

	if not input:match("^[".. env.alphabet .."]+$") then
		return true
	end

	if #input % 3 == 1 and input:match("%p$") then
		if #input > 1 then
			local abc_seg = Segment(0, #input - 1)
			abc_seg.tags = Set({ "abc" })
			segmentation:add_segment(abc_seg)
		end
		local seg = Segment(#input - 1, #input)
		seg.tags = Set({ "punct" })
		segmentation:add_segment(seg)
		return false
	end

	return true
end

return M
