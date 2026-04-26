local utils = require("utils")
local actions = {}

actions.list = {}

-- Cria uma lista de ações
function actions.build()
    actions.list = {}
        local swordAttack = {
            description = "Ataque com a espada.",
            requirement = nil,
            execute = function (playerData, creatureData)
                -- Calcular a chance da porcentagem de sucesso com base na velocidade do jogador e do boss
                local sucessChance = creatureData.speed == 0 and 1 or creatureData.speed / playerData.speed

                local healthRate = math.floor((creatureData.health / creatureData.maxHealth) * 10)
                print(string.format("%s: %s", creatureData.name, utils.getProgessbar(healthRate)))
                -- Definir se o sucesso vai adiquirir true ou false para poder executar o dano
                local sucess = math.random() <= sucessChance

                -- Calcular o dano com base no ataque do jogador e na defesa do boss
                local damageRaw = playerData.attack - math.random() * creatureData.defense
                -- Garante que o damage vai ser 1 ou mais
                local damage = math.max(1, math.ceil(damageRaw))

                -- se for veridadeiro fassa
                if sucess then
                    print(string.format("Voce deu dano a criatura! Dano causado: %d.", damage))
                    creatureData.health = creatureData.health - damage
                else
                    print("Voce errou o ataque.")
                end
            end
        }
        
        local regenPotion = {
            description = "Usar poção de regeneração.",
            requirement = function(playerData)
                return playerData.potions >= 1
            end,
            execute = function(playerData)
                playerData.potions = playerData.potions - 1
                local healAmount = 3
                playerData.health = math.min(playerData.maxHealth, playerData.health + healAmount)
                print(string.format("Voce usou uma poção de regeneração! Vida restaurada: %d.", healAmount))
            end
        }


        actions.list[#actions.list + 1] = swordAttack
        actions.list[#actions.list + 1] = regenPotion
end

--- verifica se a ação pode tem algum requisito para ser executada para ser executada
--- @ param playerData table Definição do jogador
--- @ param creatureData table Definição da criatura
--- @return table
function actions.getValidActions(playerData, creatureData)
    local validActions = {}
    for  _, actions in ipairs(actions.list) do
        local requirement = actions.requirement
        local isValid = requirement == nil or requirement(playerData, creatureData) -- Verificar se a ação é valida para ser executada
        -- se for verdaderio adicione a ação a lista de ações validas
        if isValid then
            validActions[#validActions + 1] = actions
        end
    end

   return validActions
end

return actions