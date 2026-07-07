local F = {}

function F.init(env)
	local name_space = env.name_space or ""
	local config = env.engine.schema.config

	local input_types_list = config:get_list(name_space.."/input_types")
	if input_types_list then
		env.input_types = {}
		for i=1, input_types_list.size do
			local item = input_types_list:get_value_at(i - 1)
			if item and #item.value > 0 then
				env.input_types[item.value] = true
			end
		end
	end
	env.output_type = config:get_string(name_space.."/output_type") or name_space

	env.output_source = config:get_bool(name_space.."/output_source")
	if env.output_source == nil then
		env.output_source = true
	end

	env.switch_name = config:get_string(name_space.."/switch")

	local schema = Schema(env.engine.schema.schema_id or "")
	local tran_type = config:get_string(name_space.."/tran_type") or "script_translator"
	env[name_space.."_tran"] = Component.Translator(env.engine, schema, name_space, tran_type)
end

function F.func(input, env)
	if env.switch_name and not env.engine.context:get_option(env.switch_name) then
		for cand in input:iter() do
			yield(cand)
		end
		return
	end

	local name_space = env.name_space or ""
	local trans = env[name_space.."_tran"]
	local seg = env.engine.context.composition:back()

	for cand in input:iter() do
		if env.input_types then
			if not env.input_types[cand.type] then
				yield(cand)
				goto continue
			end
		end

		if env.output_source then yield(cand) end

		local t = trans:query(cand.text, seg)
		if not t then return end
		for c in t:iter() do
			c.type = env.output_type
			yield(c)
		end

		::continue::
	end
end

return F
