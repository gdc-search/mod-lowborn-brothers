local mod = ::Hooks.register
(
    "mod_lowborn_brothers",
    "1.0.0",
    "Minimize brothers' stats."
);

mod.queue(function()
{
    mod.hook("scripts/entity/tactical/player", function(q) 
    {
        q.fillTalentValues = @(__original) function()
        {
            this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
        }
        
        q.fillAttributeLevelUpValues = @(__original) function(_amount, _maxOnly = false, _minOnly = false)
        {
            local rand = ::Math.rand;
            ::Math.rand = @(min = 0, max = RAND_MAX ) min;

            __original(_amount, _maxOnly, _minOnly);

            ::Math.rand = rand;
        }
    });

    mod.hook("scripts/skills/backgrounds/character_background", function(q) 
    {
        q.buildAttributes = @(__original) function()
        {
            local rand = ::Math.rand;
            ::Math.rand = @(min = 0, max = RAND_MAX ) min;
            
            __original();

            ::Math.rand = rand;
        }
    });

    mod.hookTree("scripts/scenarios/world/starting_scenario", function(q) 
    {
        q.onSpawnAssets = @(__original) function()
        {
            __original();
            
            local brothers = this.World.getPlayerRoster().getAll();
            foreach(brother in brothers)
            {
                brother.m.Attributes = [];
                brother.fillTalentValues();
                brother.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
            }
        }
    });

    local randomMax = function (min = 0, max = RAND_MAX )
    {
        if(min <= 50 || (min == 90 && max == 110))
            return rand(min, max);
        else
            return max;
    }

    mod.hookTree("scripts/contracts/contract", function(q) 
    {
        q.create = @(__original) function()
        {
            local rand = ::Math.rand;
            ::Math.rand = randomMax;

            __original();
            
            ::Math.rand = rand;
        }

        q.setState = @(__original) function(_state)
        {
            local rand = ::Math.rand;
            ::Math.rand = randomMax;
        
            __original(_state);
        
            ::Math.rand = rand;
        }
    });


    mod.hook("scripts/contracts/contracts/break_greenskin_siege_contract", function(q) 
    {
        q.spawnSiege = @(__original) function()
        {
            local rand = ::Math.rand;
            ::Math.rand = randomMax;

            __original();
            
            ::Math.rand = rand;
        }
    });

    mod.hook("scripts/contracts/contracts/conquer_holy_site_contract", function(q) 
    {
        q.spawnEnemy = @(__original) function()
        {
            local rand = ::Math.rand;
            ::Math.rand = randomMax;

            __original();
            
            ::Math.rand = rand;
        }
    });

    mod.hook("scripts/contracts/contracts/conquer_holy_site_southern_contract", function(q) 
    {
        q.spawnEnemy = @(__original) function()
        {
            local rand = ::Math.rand;
            ::Math.rand = randomMax;

            __original();
            
            ::Math.rand = rand;
        }
    });

    mod.hook("scripts/contracts/contracts/escort_caravan_contract", function(q) 
    {
        q.spawnEnemies = @(__original) function()
        {
            local rand = ::Math.rand;
            ::Math.rand = randomMax;

            __original();
            
            ::Math.rand = rand;
        }
    });
});