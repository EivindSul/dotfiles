return {
	{
		"kndndrj/nvim-dbee",
		enabled = false,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup()
			-- 	{
			-- 	sources = {
			-- 		require("dbee.sources").MemorySource:new({
			-- 			{
			-- 				name = "headbook",
			-- 				type = "sqlite",
			-- 				url = "/Users/eivind/Documents/uib/5sem/inf226/ma2/users.db",
			-- 			},
			-- 		}),
			-- 		require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
			-- 		require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
			-- 	}
			-- })
		end,
	},
}
