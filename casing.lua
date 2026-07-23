local M = {}

M.shift_up_map = {
	["a"] = "A",
	["b"] = "B",
	["c"] = "C",
	["d"] = "D",
	["e"] = "E",
	["f"] = "F",
	["g"] = "G",
	["h"] = "H",
	["i"] = "I",
	["j"] = "J",
	["k"] = "K",
	["l"] = "L",
	["m"] = "M",
	["n"] = "N",
	["o"] = "O",
	["p"] = "P",
	["q"] = "Q",
	["r"] = "R",
	["s"] = "S",
	["t"] = "T",
	["u"] = "U",
	["v"] = "V",
	["w"] = "W",
	["x"] = "X",
	["y"] = "Y",
	["z"] = "Z",
	["`"] = "~",
	["1"] = "!",
	["2"] = "@",
	["3"] = "#",
	["4"] = "$",
	["5"] = "%",
	["6"] = "^",
	["7"] = "&",
	["8"] = "*",
	["9"] = "(",
	["0"] = ")",
	["-"] = "_",
	["="] = "+",
	["["] = "{",
	["]"] = "}",
	["\\"] = "|",
	[";"] = ":",
	["'"] = '"',
	[","] = "<",
	["."] = ">",
	["/"] = "?"
}

M.shift_down_map = {
	["A"] = "a",
	["B"] = "b",
	["C"] = "c",
	["D"] = "d",
	["E"] = "e",
	["F"] = "f",
	["G"] = "g",
	["H"] = "h",
	["I"] = "i",
	["J"] = "j",
	["K"] = "k",
	["L"] = "l",
	["M"] = "m",
	["N"] = "n",
	["O"] = "o",
	["P"] = "p",
	["Q"] = "q",
	["R"] = "r",
	["S"] = "s",
	["T"] = "t",
	["U"] = "u",
	["V"] = "v",
	["W"] = "w",
	["X"] = "x",
	["Y"] = "y",
	["Z"] = "z",
	["~"] = "`",
	["!"] = "1",
	["@"] = "2",
	["#"] = "3",
	["$"] = "4",
	["%"] = "5",
	["^"] = "6",
	["&"] = "7",
	["*"] = "8",
	["("] = "9",
	[")"] = "0",
	["_"] = "-",
	["+"] = "=",
	["{"] = "[",
	["}"] = "]",
	["|"] = "\\",
	[":"] = ";",
	["'"] = '"',
	["<"] = ",",
	[">"] = ".",
	["?"] = "/"
}

function M.to_lower(text, uptolo)
	uptolo = uptolo or {}
	local ltext = ""
	for _, code in utf8.codes(text) do
		local char = utf8.char(code)
		ltext = ltext .. (uptolo[char] or char:lower())
	end
	return ltext
end

function M.to_upper(text, lotoup)
	lotoup = lotoup or {}
	local utext = ""
	for _, code in utf8.codes(text) do
		local char = utf8.char(code)
		utext = utext .. (lotoup[char] or char:lower())
	end
	return utext
end

return M
