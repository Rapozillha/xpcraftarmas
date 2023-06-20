Config = {}

-- XP

Config.SetXPCommand = "craft:setXP" -- Comando para selecionar o XP que o jogador têm

Config.AddXPCommand = "craft:addXP" -- Comando para adicionar XP

Config.CheckXPCommand = "craft:checkXP" -- Ver quanto XP o jogador tem

-- Notificações 
Config.UsingMythicNotify = false -- true/false se estiveres a utilizar o mythic_notify
Config.UsingokokNotify = true -- true/false se estiveres a utilizar o okokNotify
-- Se mudares aqui não te esqueças de mudar no client/craft.lua por volta da linha 104/105
-- É só escolheres qual queres utilizar e tirar os "--" antes do export


-- Traduções
Config.Text = {
    ['wrong_usage'] = 'Uso incorreto do comando.',
	['insufficent_permissions'] = 'Sem permissões.',
	['player_level1'] = 'O nível de XP do ID: ',
	['player_level2'] = ' é ',
	['xpsetted_success1'] = 'O nível de XP do ID: ',
	['xpsetted_success2'] = ' foi definido para ',
	['xpadded_success'] = ' XP adicionado ao ID: ',
    ['craft_item'] = '[~g~E~w~] para craftares o item',
    ['no_material'] = 'Não tens material suficiente',
    ['have_made'] = 'Fizeste um/a ',
    ['luck'] = 'Por sorte não perdeste nada.',
    ['failed'] = 'Falhas te a construção.',
}

-- Crafting

Crafting = {}

Crafting.Locations = { 
    [1] = {x = 260.037, y = -2491.46, z = 6.626},
}

Crafting.Items = {
    ["pistol"] = {
        label = "👟 Pistola 👟",
        needs = {
            ["water"] = {label = "➡️ Água", count = 1},
        },
        level = 0,
    },
    ["combatpistol"] = {
        label = "⚙️ Pistola de Combate ⚙️",
        needs = {
            ["bread"] = {label = "➡️ Pão", count = 1},
        },
        level = 5,
    },
}