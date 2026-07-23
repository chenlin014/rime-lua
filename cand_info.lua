local function cand_info_filter(input)
	for cand in input:iter() do
		local comment = string.format(
			"tp:%s, st:%s, ed:%s, ql:%s",
			cand.type, tostring(cand.start), tostring(cand._end),
			tostring(cand.quality)
		)
		cand.comment = comment
		yield(cand)
	end
end

return cand_info_filter
