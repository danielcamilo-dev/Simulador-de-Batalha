local player = require("Definitions.player.player_data")
local kraken = require("Definitions.Creaturas.kraken_data")
local utils = require("utils")
local playerActions = require("Definitions.player.actions")
local krakenActions = require("Definitions.Creaturas.krakenActions")

utils.enableUTF8()
utils.printHeader()

local creature = kraken
local creatureActions = krakenActions

utils.creatureStatus(creature)

playerActions.build()
krakenActions.build()

-- iniciar o loop
while true do
    print()
    print("Escolha uma ação:")
    -- pegando apenas o que o jogador pode fazer
    local validPlayerActions = playerActions.getValidActions(player, creature)
    
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

    if creature.health <= 0 then
        break -- Encerramento do loop caso a creatura morra
    end

    print()
    local validBossActions = krakenActions.getValidActions(player, creature)
    local bossChosenAction = validBossActions[math.random(#validBossActions)]

    print(string.format("A criatura escolheu: %s", bossChosenAction.description))
    bossChosenAction.execute(player, creature)

    if player.health <= 0 then
        break -- Encerramento do loop caso o jogador morra
    end
end

