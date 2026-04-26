local player = require("Definitions.player.player_data")
local kraken = require("Definitions.Creaturas.kraken_data")
local utils = require("utils")
local actions = require("Definitions.player.actions")

utils.enableUTF8()
utils.printHeader()

local creature = kraken


utils.creatureStatus(creature)

actions.build()
-- iniciar o loop
while true do
    print()
    print("Escolha uma ação:")
    -- pegando apenas o que o jogador pode fazer
    local validPlayerActions = actions.getValidActions(player, creature)
    
    -- listando as ações validas para o jogador escolher
    for i, action in pairs(validPlayerActions) do
        print(string.format("%d. %s", i, action.description))
    end
    -- faz a pergunta e armazena a resposta do jogador
    local chosenIndex = tonumber(utils.ask())
    local chosenAction = validPlayerActions[chosenIndex]
    local isValidAction = chosenAction ~= nil

    -- executa a ação escolhida pelo jogador
    if isValidAction then
        chosenAction.execute(player, creature)
    else
        print("Ação inválida. Você perdeu a vez.")
    end

    -- escolha de ação do jogador
    -- ainda não implementado
    if creature.health <= 0 then
        break -- Encerramento do loop caso a creatura morra
    end
    -- escolha de ação da creatura
    -- ainda não implementado
    if player.health <= 0 then
        break -- Encerramento do loop caso o jogador morra
    end
end

