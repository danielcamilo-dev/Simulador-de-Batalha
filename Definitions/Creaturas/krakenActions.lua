local utils = require("utils")
local actions = require("Definitions.player.actions")
local krakenActions = {}

krakenActions.list = {}

-- Cria uma lista de ações
function krakenActions.build()
    krakenActions.list = {}

        local tentacleAttack = {

            description = "Ataque com um tentaculo.",

            requirement = nil,

            execute = function (playerData, creatureData)

                -- Se e a vez do kraken ele vai usar o ataque
                
                -- Calcular a chance da porcentagem de sucesso com base na velocidade do jogador e do boss
                local sucessChance = creatureData.speed == 0 and 1 or creatureData.speed / playerData.speed              
                local sucess = math.random() <= sucessChance

                -- Calcular o dano com base no ataque do jogador e na defesa do boss
                local damageRaw = creatureData.attack - math.random() * playerData.defense

                -- Garante que o damage vai ser 1 ou mais
                local damage = math.max(1, math.ceil(damageRaw))

                -- se for veridadeiro fassa
                if sucess then
                    if actions.isDoing then
                        print(string.format("%s desviou do ataque da criatura!", playerData.name))
                    else
                        print(string.format("A criatura te deu dano em %s! Dano causado: %d.", playerData.name, damage))
                        playerData.health = playerData.health - damage
                    end
                else
                    if actions.isDoing then
                        print("%s desviou do ataque da criatura!", playerData.name)
                    else
                        print(string.format("A criatura errou o ataque em %s.", playerData.name))
                    end
                end

                local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
                -- Printar a barra de vida do jogador
                print(string.format("%s: %s", playerData.name, utils.getProgessbar(healthRate)))
            end
        }

        local tisunamiAttack = {

            description = "Ataque com uma onda gigante.",
            
            requirement = nil,
            
            execute = function (playerData, creatureData)

                -- Calcular a chance da porcentagem de sucesso com base na velocidade do jogador e do boss
                local sucessChance = creatureData.speed == 0 and 1 or creatureData.speed / playerData.speed              
                local sucess = math.random() <= sucessChance

                -- Calcular o dano com base no ataque do jogador e na defesa do boss
                local damageRaw = creatureData.attack - math.random() * playerData.defense

                -- Garante que o damage vai ser 1 ou mais
                local damage = math.max(1, math.ceil(damageRaw * 0.3))
                
                -- Dar dano
                print(string.format("A criatura te deu dano em %s! Dano causado: %d.", playerData.name, damage))
                playerData.health = playerData.health - damage
                
                local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
                -- Printar a barra de vida do jogador
                print(string.format("%s: %s", playerData.name, utils.getProgessbar(healthRate)))

                if sucess then
                    if actions.isDoing then
                        print(string.format("%s desviou do ataque da criatura!", playerData.name))
                    else
                        print(string.format("A criatura te deu dano em %s! Dano causado: %d.", playerData.name, damage))
                        playerData.health = playerData.health - damage
                    end
                else
                    if actions.isDoing then
                        print(string.format("%s desviou do ataque da criatura!", playerData.name))
                    else
                        print("A criatura errou o ataque.")
                    end  
                end
            end
        }

        local redemoinhoAttack = {

            description = "Ataque com um redemoinho.",
            
            requirement = nil,
            
            execute = function (playerData, creatureData)

                -- Calcular a chance da porcentagem de sucesso com base na velocidade do jogador e do boss
                local sucessChance = creatureData.speed == 0 and 1 or creatureData.speed / playerData.speed              
                local sucess = math.random() <= sucessChance

                -- Calcular o dano com base no ataque do jogador e na defesa do boss
                local damageRaw = creatureData.attack - math.random() * playerData.defense

                -- Garante que o damage vai ser 1 ou mais
                local damage = math.max(1, math.ceil(damageRaw * 0.3))

                -- Dar dano
                print(string.format("A criatura te deu dano em %s! Dano causado: %d.", playerData.name, damage))
                playerData.health = playerData.health - damage
                
                local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
                -- Printar a barra de vida do jogador
                print(string.format("%s: %s", playerData.name, utils.getProgessbar(healthRate)))
                
                if sucess then
                    if actions.isDoing then
                        print(string.format("%s desviou do ataque da criatura!", playerData.name))
                    else
                        print(string.format("A criatura te deu dano em %s! Dano causado: %d.", playerData.name, damage))
                        playerData.health = playerData.health - damage
                    end
                else
                    if actions.isDoing then
                        print(string.format("%s desviou do ataque da criatura!", playerData.name))
                    else
                        print("A criatura errou o ataque.")    
                    end
                end
            end
        }

        local waitAction = {
            description = "A criatura está esperando...",
            requirement = nil,
            execute = function (playerData, creatureData)
                print("A criatura está esperando...")
            end
        }

        krakenActions.list[#krakenActions.list + 1] = tentacleAttack
        krakenActions.list[#krakenActions.list + 1] = tisunamiAttack
        krakenActions.list[#krakenActions.list + 1] = redemoinhoAttack
        krakenActions.list[#krakenActions.list + 1] = waitAction
end

--- verifica se a ação pode tem algum requisito para ser executada para ser executada
--- @ param playerData table Definição do jogador
--- @ param creatureData table Definição da criatura
--- @return table
function krakenActions.getValidActions(playerData, creatureData)

    local validActions = {}

    for  _, actions in ipairs(krakenActions.list) do

        local requirement = actions.requirement
        local isValid = requirement == nil or requirement(playerData, creatureData) -- Verificar se a ação é valida para ser executada
        
        -- se for verdaderio adicione a ação a lista de ações validas
        if isValid then
            validActions[#validActions + 1] = actions
        end
        
    end

   return validActions
end

return krakenActions