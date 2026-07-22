local P = {}

function P.init(env)
end

function P.fini(env)
end

function P.func(key, env)
	local context = env.engine.context
	local repr = key:repr()
	local commit_text = context:get_commit_text()

	if repr == "Return" and commit_text then
		env.engine:commit_text(commit_text)
		context:clear()
	end

	return 2
end

return P
