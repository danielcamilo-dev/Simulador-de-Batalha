local player = require("Definitions.player_data")
local kraken = require("Definitions.Boses.kraken_data")
local utils = require("utils")

utils.enableUTF8()
utils.printHeader()

local boss = kraken

utils.creatureStatus(boss)

-- iniciar o loop
while true do

    -- escolha de ação do jogador
    -- ainda não implementado
    if boss.health <= 0 then
        break -- Encerramento do loop caso o boss morra
    end

    -- escolha de ação do boss
    -- ainda não implementado
    if player.health <= 0 then
        break -- Encerramento do loop caso o jogador morra
    end
end