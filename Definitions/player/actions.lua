local actions = {}

actions.list = {}

function actions.build()
    actions.list = {}
        local swordAttack = {
            description = "Ataque com a espada.",
            requirement = nil,
            execute = function (playerData, bossData)
                -- Calcular a chance da porcentagem de sucesso com base na velocidade do jogador e do boss
                local sucessChance = bossData.speed == 0 and 1 or bossData.speed / playerData.speed
                -- Definir se o sucesso vai adiquirir true ou false para poder executar o dano
                local sucess = math.random() <= sucessChance

                -- Calcular o dano com base no ataque do jogador e na defesa do boss
                local damageRaw = playerData.attack - math.random() * bossData.defense
                -- Garante que o damage vai ser 1 ou mais
                local damage = math.max(1, math.ceil(damageRaw))

                -- se for veridadeiro fassa
                if sucess then
                    print(string.format("Voce deu dano a criatura! Dano causado: %d.", damage))
                    bossData.health = bossData.health - damage
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


        actions.list[#actions.list+1] = swordAttack
end

function actions.getValidActions()
    
end

return actions