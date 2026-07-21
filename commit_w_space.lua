local P = {}

function P.init(env)
end

function P.fini(env)
end

function P.func(key, env)
	local context = env.engine.context
	local repr = key:repr()
	local commit_text = context:get_commit_text()

	if repr ~= "space" or not commit_text then
		return 2
	end

	local back_seg = context.composition:back()
	if back_seg:has_tag("abc") then
		env.engine:commit_text(commit_text)
		context:clear()
	elseif back_seg:has_tag("punct") then
		if context:get_option("ascii_punct") then
			env.engine:commit_text(commit_text)
			context:clear()
		end
	end

	return 2
end

return P
