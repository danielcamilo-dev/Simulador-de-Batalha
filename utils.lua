local utils = {}

-- habilita o UTF8
function utils.enableUTF8()
    os.execute("chcp 65001")
end


-- faz o print da apresentação do jogo
function utils.printHeader()
    print([[
=========================================================================================================
                                           _.gd8888888bp._     
                                        .g88888888888888888p.  
                                      .d8888P""       ""Y8888b.
                                      "Y8P"               "Y8P'
                                         `.               ,'   
                                           \     .-.     /     
                                            \   (___)   /      
 .------------------._______________________:__________j       
/                   |  Battle simulator    |           |`-.,_  
\###################|######################|###########|,-'`   
 `------------------'                       :    ___   l       
                                            /   (   )   \      
                                           /     `-'     \     
                                         ,'               `.   
                                      .d8b.               .d8b.
                                      "Y8888p..       ,.d8888P"
                                        "Y88888888888888888P"  
                                           ""YY8888888PP""     
=========================================================================================================
                                        Let's go to battle!
                                  ------------------------------
                                              Welcome
]])
end
--- Printa os valores de algum atributo e reuslta em uma string
--- @param attribute number
--- @result strings
function utils.getProgessbar(attribute)
    local result = ""
    local fullChar = "⬜"
    local emptyChar = "⬛"

    for i = 1, 10, 1 do
        if i <= attribute then
            result = result .. fullChar
        else
            result = result .. emptyChar
        end
    end
    return result
end

---Printa os status de uma creatura
---@param creature table
---
function utils.creatureStatus(creature)
    local healthRate = math.floor((creature.health / creature.maxHealth) * 10)

    print("================================")
    print("| Nome: " .. creature.name)
    print("| Descrição: " .. creature.description)
    print()
    print("Atributos:")
    print()
    print("| Vida: " .. utils.getProgessbar(healthRate))
    print("| Defesa: " .. utils.getProgessbar(creature.defense))
    print("| Velocidade: " .. utils.getProgessbar(creature.speed))
    print("| Ataque: " .. utils.getProgessbar(creature.attack))
end

--- Pergunta ao jogador qual ação ele deseja executar em numero e retorna a resposta
--- @return number
function utils.ask()
    io.write("> ")
    local answer = io.read("*n")
    return answer
end

return utils