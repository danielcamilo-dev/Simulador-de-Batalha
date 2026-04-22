local player = require("Definitions.player_data")
local kraken = require("Definitions.Boses.kraken_data")
local utils = require("utils")

utils.enableUTF8()
utils.printHeader()

print(string.format("A vida do jogador e %d/%d", player.health, player.maxHealth))
print(string.format(kraken.description))

local boss = kraken

utils.creatureStatus(boss)