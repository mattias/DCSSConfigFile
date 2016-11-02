-- Uses the getMonsterList and escape functions above
function SpoilerAlert()
    local mobwarnings = {}
    --Add dangerous monsters to this table by using their name as the key, (as a lua pattern)
    --Set the value to the warning string you want to display, where it will formatted like:
    --"[The] Monster_Name Warning_Message"
    --If the Monster_Name includes a capital letter, the message will be prepended with [The]

    local xl = you.xl()
    local no_rP = you.res_poison() == 0
    local no_rF = you.res_fire() == 0
    local no_rC = you.res_cold() == 0
    local no_rN = you.res_draining() == 0
    local no_rE = you.res_shock() == 0
    local no_rMut = you.res_mutation() == 0
    local you_are_flying = you.flying()
    local no_see_invis = not you.see_invisible()
    local no_rCorr = not you.res_corr()
    local race = you.race()
    local form = you.transform()
    local you_are_undead = (race:find("ghoul") or race:find("vampire") or race:find("mummy") or form:find("lich"))
    --Only hide Torment for races with full, permanent immunity
    local you_perm_rTorment = (race:find("ghoul") or race:find("mummy"))

    --crawl.mpr(string.format("you.res_mutation() is: %s", you.res_mutation()))
    --crawl.mpr(string.format("no_rMut is: %s", no_rMut and "True" or "False"))

    if xl < 3 then
        if no_rP then
            mobwarnings["giant mite"] = "can poison!"
        end

        mobwarnings["ball python"] = "can constrict!"
        mobwarnings["giant cockroach"] = "is fast!"
        mobwarnings["giant gecko"] = "is fast!"
        mobwarnings["jackal"] = "is fast!"
    end

    if xl < 5 then
        if no_rP then
            mobwarnings["adder"] = "is fast and can poison!"
            mobwarnings["scorpion"] = "can poison!"
        end

        mobwarnings["worm"] = "can hit for moderate damage in melee!"
    end

    if xl < 9 then
        if no_rP then
            mobwarnings["worker ant"] = "is fast and can poison!"
        end

        if no_see_invis then
            if no_rP then
                mobwarnings["Natasha"] = "can cast Slow, Mephitic Cloud, Call Imp, and go Invisible!"
            else
                mobwarnings["Natasha"] = "can cast Slow, Call Imp, and go Invisible!"
            end
            if no_rF and no_rC then
                mobwarnings["Blork"] = "can cast Haste, Throw Frost, Throw Flame, and go Invisible!"
                mobwarnings["orc wizard"] = "might cast Slow, Confuse, Throw Flame, Throw Frost, or go Invisible!"
                mobwarnings["Sigmund"] = "can cast Slow, Confuse, Throw Flame, and go Invisible!"
            elseif no_rF then
                mobwarnings["Blork"] = "can cast Haste, Throw Flame, and go Invisible!"
                mobwarnings["orc wizard"] = "might cast Slow, Confuse, Throw Flame, or go Invisible!"
                mobwarnings["Sigmund"] = "can cast Slow, Confuse, Throw Flame, and go Invisible!"
            elseif no_rC then
                mobwarnings["Blork"] = "can cast Haste, Throw Frost, and go Invisible!"
                mobwarnings["orc wizard"] = "might cast Slow, Confuse, Throw Frost, or go Invisible!"
                mobwarnings["Sigmund"] = "can cast Slow, Confuse, and go Invisible!"
            else
                mobwarnings["Blork"] = "can cast Haste and go Invisible!"
                mobwarnings["orc wizard"] = "might cast Slow, Confuse, or go Invisible!"
                mobwarnings["Sigmund"] = "can cast Slow, Confuse, and go Invisible"
            end
        else
            if no_rP then
                mobwarnings["Natasha"] = "can cast Slow, Mephitic Cloud, and Call Imp!"
            else
                mobwarnings["Natasha"] = "can cast Slow and Call Imp!"
            end
            if no_rF and no_rC then
                mobwarnings["Blork"] = "can cast Haste, Throw Frost, and Throw Flame!"
                mobwarnings["orc wizard"] = "might cast Slow, Confuse, Throw Flame, or Throw Frost!"
                mobwarnings["Sigmund"] = "can cast Slow, Confuse, and Throw Flame!"
            elseif no_rF then
                mobwarnings["Blork"] = "can cast Haste, and Throw Flame!"
                mobwarnings["orc wizard"] = "might cast Slow, Confuse, or Throw Flame!"
                mobwarnings["Sigmund"] = "can cast Slow, Confuse, and Throw Flame!"
            elseif no_rC then
                mobwarnings["Blork"] = "can cast Haste and Throw Frost!"
                mobwarnings["orc wizard"] = "might cast Slow, Confuse, or Throw Frost!"
                mobwarnings["Sigmund"] = "can cast Slow and Confuse!"
            else
                mobwarnings["Blork"] = "can cast Haste!"
                mobwarnings["orc wizard"] = "might cast Slow or Confuse!"
                mobwarnings["Sigmund"] = "can cast Slow and Confuse!"
            end
        end

        mobwarnings["big kobold"] = "will probably throw things at you!"
        mobwarnings["Crazy Yiuf"] = "can hit for high damage in melee!"
        mobwarnings["Dowan"] = "can Haste Duvessa, and will become Hasted and cast Throw Icicle when Duvessa dies!"
        mobwarnings["Duvessa"] = "can hit for moderate damage in melee, and goes Berserk when Dowan dies!"
        mobwarnings["Eustachio"] = "can summon minor creatures and blink!"
        mobwarnings["gnoll"] = "can hit for moderate damage in melee, and throws nets!"
        mobwarnings["Ijyb"] = "will often zap you with wands!"
        mobwarnings["mummy"] = "can hit for moderate damage in melee!"
        mobwarnings["ogre"] = "can hit for high damage in melee!"
        mobwarnings["phantom"] = "can hit for moderate damage in melee and blinks!"
    end

    if xl < 14 then

        if no_rN then
            mobwarnings["Grinder"] = "can cast Paralyse and Pain!"
            mobwarnings["shadow imp"] = "can cast Pain and Animate Dead!"
            mobwarnings["wight"] = "can drain you in melee!"
        else
            mobwarnings["Grinder"] = "can cast Paralyse!"
            mobwarnings["shadow imp"] = "can Animate Dead!"
            mobwarnings["wight"] = "can hit for moderate damage in melee!"
        end

        if no_rC then
            mobwarnings["ice beast"] = "can hit for moderate damage in melee!"
            mobwarnings["simulacr"] = "can hit for high damage in melee!"
            mobwarnings["white imp"] = "can cast Throw Frost!"
            mobwarnings["white ugly thing"] = "is fast and can hit for high cold damage in melee!"
        else
            mobwarnings["simulacr"] = "can hit for moderate damage in melee!"
            mobwarnings["white ugly thing"] = "is fast and can hit for moderate damage in melee!"
        end

        if no_rF then
            mobwarnings["fire drake"] = "can breathe blasts of flame!"
            mobwarnings["red ugly thing"] = "is fast and can hit for high fire damage in melee!"
            mobwarnings["steam dragon"] = "breathes balls of steam!"
            if no_see_invis and no_rP then
                mobwarnings["Erica"] = "can hit for moderate fire damage in melee, can cast Venom Bolt, IMB, Confuse, Slow, go Invisible, and teleport away!"
            elseif no_rP then
                mobwarnings["Erica"] = "can hit for moderate fire damage in melee, can cast Venom Bolt, IMB, Confuse, Slow, and teleport away!"
            elseif no_see_invis then
                mobwarnings["Erica"] = "can hit for moderate fire damage in melee, can cast IMB, Confuse, Slow, go Invisible, and teleport away!"
            else
                mobwarnings["Erica"] = "can hit for moderate fire damage in melee, can cast IMB, Confuse, Slow, and teleport away!"
            end
        else
            mobwarnings["red ugly thing"] = "is fast and can hit for moderate damage in melee!"
            if no_see_invis and no_rP then
                mobwarnings["Erica"] = "can cast Venom Bolt, IMB, Confuse, Slow, go Invisible, and teleport away!"
            elseif no_rP then
                mobwarnings["Erica"] = "can cast Venom Bolt, IMB, Confuse, Slow, and teleport away!"
            elseif no_see_invis then
                mobwarnings["Erica"] = "can cast IMB, Confuse, Slow, go Invisible, and teleport away!"
            else
                mobwarnings["Erica"] = "can cast IMB, Confuse, Slow, and teleport away!"
            end
        end

        if no_rC or no_rF or no_rP then
            mobwarnings["Joseph"] = "shoots branded sling bullets!"
        end

        if no_rP then
            mobwarnings["black mamba"] = "is very fast, can hit for high damage in melee, and can poison!"
            mobwarnings["green ugly thing"] = "is fast and can hit for high poison damage in melee!"
            mobwarnings["killer bee"] = "is very fast and can poison!"
            mobwarnings["naga"] = "can constrict and spit poison!"
            mobwarnings["queen ant"] = "can berserk other ants, and can poison!"
            mobwarnings["redback"] = "is fast and can poison!"
            mobwarnings["soldier ant"] = "is fast and can poison!"
            mobwarnings["spiny frog"] = "is fast, can hit for high damage in melee, and can poison!"
            mobwarnings["swamp drake"] = "breathes Mephitic clouds!"
            mobwarnings["water moccasin"] = "is fast and can poison!"
        else
            mobwarnings["black mamba"] = "is very fast and can hit for high damage in melee!"
            mobwarnings["green ugly thing"] = "is fast and can hit for moderate damage in melee!"
            mobwarnings["killer bee"] = "is very fast!"
            mobwarnings["naga"] = "can constrict!"
            mobwarnings["queen ant"] = "can berserk other ants!"
            mobwarnings["redback"] = "is fast!"
            mobwarnings["soldier ant"] = "is fast!"
            mobwarnings["spiny frog"] = "is fast and can hit for high damage in melee!"
            mobwarnings["water moccasin"] = "is fast!"
        end

        if no_rE then
            mobwarnings["cyan ugly thing"] = "can hit for high electric damage in melee!"
            mobwarnings["electric eel"] = "can hit for high damage at range!"
        else
            mobwarnings["cyan ugly thing"] = "is fast and can hit for moderate damage in melee!"
        end

        if no_rCorr then
            mobwarnings["jelly"] = "can corrode equipment in melee!"
        end

        mobwarnings["blink frog"] = "is fast, can hit for moderate damage in melee, and blinks!"
        mobwarnings["centaur"] = "is fast and can hit for moderate damage at range!"
        mobwarnings["draconian"] = "can hit for high damage in melee!"
        mobwarnings["elephant"] = "can hit for high damage in melee, and can trample!"
        mobwarnings["gargoyle"] = "can cast Stone Arrow!"
        mobwarnings["gnoll shaman"] = "can heal itself and can heal or Haste other gnolls!"
        mobwarnings["goliath beetle"] = "can hit for high damage in melee!"
        mobwarnings["hill giant"] = "can hit for high damage in melee!"
        mobwarnings["hippogriff"] = "can hit for high damage in melee!"
        mobwarnings["Maud"] = "can hit for high damage in melee!"
        mobwarnings["orc warrior"] = "can hit for high damage!"
        mobwarnings["Pikel"] = "can hit for high damage in melee!"
        mobwarnings["Prince Ribbit"] = "is fast and can hit for high damage in melee!"
        mobwarnings["Psyche"] = "might banish you in melee!"
        mobwarnings["raven"] = "is very fast and can hit for moderate damage in melee!"
        mobwarnings["slave"] = "means Pikel is nearby!"
        mobwarnings["slime creature"] = "can hit for high damage in melee!"
        mobwarnings["small abomination"] = "might be fast and can hit for high damage in melee!"
        mobwarnings["troll"] = "can hit for high damage in melee, and regenerates quickly!"
        mobwarnings["two-headed ogre"] = "can hit for high damage in melee!"
        mobwarnings["warg"] = "is fast and can hit for moderate damage in melee!"
        mobwarnings["wolf"] = "is very fast and can hit for moderate damage in melee!"
        mobwarnings["wraith"] = "can slow you in melee!"
        mobwarnings["wyvern"] = "is fast and can hit for high damage in melee!"
        mobwarnings["yak"] = "can hit for moderate damage in melee!"
    end

    if you.xl() < 21 then
        local orcsorcwarn = ""
        local tenguconjwarn = ""

        if no_rF then
            if no_see_invis and no_rP then
                mobwarnings["Erica"] = "can cast Venom Bolt, IMB, go Invisible, and teleport away!"
            elseif no_rP then
                mobwarnings["Erica"] = "can cast Venom Bolt, IMB, and teleport away!"
            elseif no_see_invis then
                mobwarnings["Erica"] = "can cast IMB, go Invisible, and teleport away!"
            else
                mobwarnings["Erica"] = "can cast IMB and teleport away!"
            end
            mobwarnings["deep elf mage"] = "can cast Fireball and Slow!"
            mobwarnings["efreet"] = "can cast Bolt of Fire and Fireball!"
            mobwarnings["Harold"] = "can throw nets and cast Bolt of Fire!"
            mobwarnings["lindwurm"] = "has a nasty fire breath attack!"
            mobwarnings["red very ugly thing"] = "can hit for high fire damage in melee!"
            mobwarnings["salamander"] = "uses fire branded attacks!"
            orcsorcwarn = orcsorcwarn .. ", Bolt of Fire"
            tenguconjwarn = tenguconjwarn  .. ", Bolt of Magma"
        else
            if no_see_invis and no_rP then
                mobwarnings["Erica"] = "can cast Venom Bolt, IMB, go Invisible, and teleport away!"
            elseif no_rP then
                mobwarnings["Erica"] = "can cast Venom Bolt, IMB, and teleport away!"
            elseif no_see_invis then
                mobwarnings["Erica"] = "can cast IMB, go Invisible, and teleport away!"
            else
                mobwarnings["Erica"] = "can cast IMB, and teleport away!"
            end
            mobwarnings["deep elf mage"] = "can cast slow!"
            mobwarnings["Harold"] = "can throw nets!"
            mobwarnings["lindwurm"] = "can hit for high damage in melee!"
            mobwarnings["red very ugly thing"] = "can hit for high damage in melee!"
        end

        if no_rP then
            mobwarnings["green very ugly thing"] = "is fast and can hit for high poison damage in melee!"
            mobwarnings["naga mage"] = "can cast IMB and Poison Arrow, and spits poison!"
            mobwarnings["naga ritualist"] = "can give poison vulnerability, and do poison damage over time with toxic radiance!"
            mobwarnings["naga warrior"] = "can constrict you and hit for high damage in melee, and spits poison!"
            mobwarnings["redback"] = "is fast and can poison!"
            mobwarnings["Sonja"] = "shoots Curare needles and will probably banish you in melee!"
            mobwarnings["wolf spider"] = "is fast and can hit for high damage in melee, and can poison!"
            tenguconjwarn = tenguconjwarn  .. ", Venom Bolt"
        else
            mobwarnings["green very ugly thing"] = "is fast and can hit for high damage in melee!"
            mobwarnings["naga mage"] = "can cast IMB and Poison Arrow!"
            mobwarnings["naga ritualist"] = "can remove poison resistance, and do damage over time with toxic radiance!"
            mobwarnings["naga warrior"] = "can constrict you and hit for high damage in melee!"
            mobwarnings["Sonja"] = "will probably banish you in melee!"
            mobwarnings["wolf spider"] = "is fast and can hit for high damage in melee!"
        end

        if no_rE then
            mobwarnings["cyan very ugly thing"] = "is fast and can hit for high electric damage in melee!"
            mobwarnings["raiju"] = "is fast and can Lightning Bolt itself at you!"
            tenguconjwarn = tenguconjwarn  .. ", Lightning Bolt"
        else
            mobwarnings["cyan very ugly thing"] = "is fast and can hit for high damage in melee!"
            mobwarnings["raiju"] = "is fast and blinks around!"
        end

        if no_rC then
            mobwarnings["bog body"] = "can cast Slow and Bolt of Cold!"
            mobwarnings["Fannar"] = "can cast Bolt of Cold, Ozo's Refrigeration, Summon Ice Beast, and Blink!"
            mobwarnings["freezing wraith"] = "can hit for high cold damage and slow you in melee!"
            mobwarnings["simulacr"] = "can hit for high damage in melee!"
            mobwarnings["white very ugly thing"] = "is fast and can hit for high cold damage in melee!"
        else
            mobwarnings["bog body"] = "can cast Slow!"
            mobwarnings["Fannar"] = "can Blink and Summon Ice Beasts!"
            mobwarnings["freezing wraith"] = "can slow you in melee!"
            mobwarnings["white very ugly thing"] = "is fast and can hit for high damage in melee!"
        end

        if no_rN then
            orcsorcwarn = orcsorcwarn .. ", Bolt of Draining"
            mobwarnings["Nergalle"] = "can cast Bolt of Draining, Summon Spectral Orcs, Haste Other, and Death's Door!"
            if you_are_undead then
                mobwarnings["Josephine"] = "can cast Ghostly Fireball, Vampiric Draining, Animate Dead, and Dispel Undead!"
            else
                mobwarnings["Josephine"] = "can cast Ghostly Fireball, Vampiric Draining, and Animate Dead!"
            end
        else
            mobwarnings["Nergalle"] = "can Summon Spectral Orcs, cast Haste Other, and Death's Door!"
            if you_are_undead then
                mobwarnings["Josephine"] = "can cast Animate Dead, and Dispel Undead!"
            else
                mobwarnings["Josephine"] = "can cast Animate Dead!"
            end
        end

        if no_rCorr then
            mobwarnings["brown ugly thing"] = "is fas and can hit for high damage in melee, corroding equipment!"
            mobwarnings["brown very ugly thing"] = "is fast and can hit for high damage in melee, corroding equipment!"
            mobwarnings["oklob"] = "can corrode equipment at range!"
        else
            mobwarnings["brown ugly thing"] = "is fast and can hit for moderate damage in melee!"
            mobwarnings["brown very ugly thing"] = "is fast and can hit for high damage in melee!"
        end

        if no_see_invis then
            mobwarnings["Kirke"] = "can summon Monstrous Menageries, go invisible, turn you into a pig, and deflects missiles!"
            mobwarnings["Maurice"] = "can steal items, go invisible, and teleport away!"
        else
            mobwarnings["Kirke"] = "can summon Monstrous Menageries, turn you into a pig, and deflects missiles!"
            mobwarnings["Maurice"] = "can steal items, and teleport away!"
        end

        mobwarnings["anaconda"] = "is very fast and can constrict you!"
        mobwarnings["centaur warrior"] = "can hit for high damage at range!"
        mobwarnings["cyclops"] = "can throw large rocks!"
        mobwarnings["death yak"] = "can hit for high damage in melee!"
        mobwarnings["dire elephant"] = "can hit for high damage in melee, and can trample!"
        mobwarnings["enormous slime creature"] = "can hit for high damage in melee!"
        mobwarnings["Erolcha"] = "might cast banishment, paralyse, or LCS!"
        mobwarnings["firefly"] = "is very fast, can hit for moderate damage, and flashes a warning beacon!"
        mobwarnings["harpy"] = "is very fast and can hit for high damage in melee!"
        mobwarnings["hydra"] = "can hit for high damage in melee!"
        mobwarnings["kobold demonologist"] = "can summon minor demons!"
        mobwarnings["komodo dragon"] = "can hit for high damage in melee!"
        mobwarnings["large abomination"] = "might be fast and can hit for high damage in melee!"
        mobwarnings["large slime creature"] = "can hit for high damage in melee!"
        mobwarnings["manticore"] = "can hit for high damage at range, and Barbs causes damage when you move!"
        mobwarnings["naga sharpshooter"] = "can shoot you with portal projectiles!"
        mobwarnings["orc knight"] = "can hit for high damage!"
        mobwarnings["orc sorcerer"] = "can cast Paralyse, Summon Demon, Animate Dead"..orcsorcwarn.."!"
        mobwarnings["purple ugly thing"] = "can hit for high damage in melee!"
        mobwarnings["skeletal warrior "] = "can hit for high damage in melee!"
        mobwarnings["Snorg"] = "can berserk and hit for high damage!"
        mobwarnings["spriggan"] = "is very fast and can hit for moderate damage!"
        mobwarnings["tarantella"] = "is fast and can cause confusion in melee!"
        mobwarnings["tengu conjurer"] = "is fast and can cast Force Lance, IMB"..tenguconjwarn.."!"
        mobwarnings["tengu warrior"] = "is fast and can hit for high damage in melee!"
        mobwarnings["thorn lotus"] = "can hit for high damage at range!"
    end

    if you.xl() < 27 then
        local tengureaverwarn = ""

        if no_rF then
            mobwarnings["fire dragon"] = "has a nasty fire breath attack!"
            mobwarnings["fire giant"] = "can cast Fireball and Bolt of Fire!"
            mobwarnings["flaming corpse"] = "is fast, can cause sticky flames in melee!"
            mobwarnings["mottled draconian"] = "can spit sticky flames at range!"
            mobwarnings["red very ugly thing"] = "is fast, can cause sticky flames in melee!"
            mobwarnings["salamander firebrand"] = "is fast and melee attacks will surround you with flame clouds!"
            mobwarnings["salamander mystic"] = "can haste allies, and casts Bolt of Magma and IMB!"
            tengureaverwarn = tengureaverwarn .. ", can cast Bolt of Magma, Fireball"
        else
            mobwarnings["fire dragon"] = "can hit for high damage in melee!"
            mobwarnings["fire giant"] = "can hit for high damage in melee!"
            mobwarnings["flaming corpse"] = "is fast!"
            mobwarnings["red very ugly thing"] = "is fast!"
            mobwarnings["salamander firebrand"] = "is fast and melee attacks will surround you with flame clouds!"
            mobwarnings["salamander mystic"] = "can haste allies and casts IMB!"
        end

        if no_rC then
            mobwarnings["frost giant"] = "can cast Bolt of Cold!"
            mobwarnings["ice dragon"] = "has a nasty cold breath attack!"
            tengureaverwarn = tengureaverwarn .. ", can cast Freezing Cloud"
        else
            mobwarnings["frost giant"] = "can hit for high damage in melee!"
            mobwarnings["ice dragon"] = "can hit for high damage in melee!"
        end

        if no_rN then
            mobwarnings["eidolon"] = "can cast Bolt of Draining and Fear!"
        else
            mobwarnings["eidolon"] = "can cast Fear!"
        end

        if no_rE then
            tengureaverwarn = tengureaverwarn .. ", can cast Lightning Bolt"
        end

        if no_rP then
            mobwarnings["Aizul"] = "is very fast and casts Sleep, Poison Arrow, and Venom Bolt!"
            mobwarnings["greater naga"] = "is strong in melee, and casts Venom Bolt, Poison Arrow, IMB, and spits poison!"
        else
            mobwarnings["Aizul"] = "is very fast and casts Sleep and Poison Arrow!"
            mobwarnings["greater naga"] = "is strong in melee, and can cast Poison Arrow and IMB!"
        end

        if no_see_invis then
            mobwarnings["wizard"] = "might cast banishment, paralyse, LCS, or go Invisible!"
            if no_rN then
                if no_rC and no_rF then
                    mobwarnings["necromancer"] = "can cast Agony, Animate Dead, Bolt of Fire, Bolt of Cold, or go Invisible!"
                elseif no_rF then
                    mobwarnings["necromancer"] = "can cast Agony, Animate Dead, Bolt of Fire, or go Invisible!"
                elseif no_rC then
                    mobwarnings["necromancer"] = "can cast Agony, Animate Dead, Bolt of Cold, or go Invisible!"
                else
                    mobwarnings["necromancer"] = "can cast Agony, Animate Dead, or go Invisible!"
                end
            end
        else
            mobwarnings["wizard"] = "might cast banishment, paralyse, or LCS!"
            if no_rN then
                if no_rC and no_rF then
                    mobwarnings["necromancer"] = "can cast Agony, Animate Dead, Bolt of Fire, or Bolt of Cold!"
                elseif no_rF then
                    mobwarnings["necromancer"] = "can cast Agony, Animate Dead, or Bolt of Fire!"
                elseif no_rC then
                    mobwarnings["necromancer"] = "can cast Agony, Animate Dead, or Bolt of Cold!"
                else
                    mobwarnings["necromancer"] = "can cast Agony and Animate Dead!"
                end
            end
        end

        mobwarnings["deep troll earth mage"] = "can cast LRD and dig!"
        mobwarnings["ettin"] = "can hit for very high damage in melee!"
        mobwarnings["great orb of eyes"] = "can cast paralyse, disintegrate, slow, confuse, and teleport you!"
        mobwarnings["ironheart preserver"] = "can absorb the damage of its allies and heal itself!"
        mobwarnings["Lernaean hydra"] = "don't fight it in melee! Just don't!"
        mobwarnings["Louise"] = "can cast banishment!"
        mobwarnings["minotaur"] = "can hit for very high damage!"
        mobwarnings["ogre mage"] = "might cast banishment, paralyse, or LCS!"
        mobwarnings["orc warlord"] = "can hit for high damage!"
        mobwarnings["purple draconian"] = "can dispel your buffs!"
        mobwarnings["purple very ugly thing"] = "is fast and can cause rotting in melee!"
        mobwarnings["Rupert"] = "can paralyse you in fear!"
        mobwarnings["stone giant"] = "throws large rocks and can hit for very high damage!"
        mobwarnings["tengu reaver"] = "is fast"..tengureaverwarn.."!"
        mobwarnings["titanic slime creature"] = "can hit for high damage in melee!"
        mobwarnings["vampire knight"] = "can cast paralyse!"
        mobwarnings["vampire mage"] = "can Summon Undead and Animate Dead!"
        mobwarnings["Vashnia"] = "can blink herself and allies away!"
        mobwarnings["vault sentinel"] = "can mark you and blow a signal horn!"
        mobwarnings["vault warden"] = "can lock down doors and staircases!"
        mobwarnings["water nymph"] = "can create water, teleport to other water, and Waterstrike you!"
        mobwarnings["Wiglaf"] = "can cast might and haste on himself!"
        mobwarnings["yaktaur"] = "can hit for high damage at range!"
    end

    if no_rP then
        mobwarnings["red wasp"] = "is very fast and can Paralyse and poison in melee!"
        mobwarnings["yellow wasp"] = "is very fast and can Slow and poison in melee!"
    else
        mobwarnings["red wasp"] = "is very fast and can Slow in melee!"
    end

    if no_rF then
        mobwarnings["deep elf mage"] = "can cast fireball and slow!"
        mobwarnings["fire dragon"] = "has a nasty fire breath attack!"
        mobwarnings["fire giant"] = "can cast fireball and bolt of fire!"
        mobwarnings["merfolk aquamancer"] = "can cast Primal Wave, Steam Ball, Throw Icicle, and Blink!"
    else
        mobwarnings["merfolk aquamancer"] = "can cast Primal Wave, Throw Icicle, and Blink!"
    end

    if no_rN then
        mobwarnings["shadow dragon"] = "has a nasty draining breath attack!"
    end

    mobwarnings["electric golem"] = "is fast, has electric attacks, and blinks!"
    mobwarnings["Nikola"] = "casts Lightning Bolt, Chain Lightning and blinks!"
    mobwarnings["shock serpent"] = "is fast, casts Bolt of Lightning, does electric damage, and causes electric damage when injured!"
    mobwarnings["Sojobo"] = "is fast and can cast Airstrike and Lightning Bolt!"
    mobwarnings["storm dragon"] = "can hit for high damage in melee and has a nasty electric breath attack!"
    mobwarnings["titan"] = "can cast Lightning Bolt and Airstrike!"
    local electricwarning = ""
    if no_rE then
        electricwarning = "<red> You are not wearing rElec!</red>"
        mobwarnings["electric golem"] = mobwarnings["electric golem"] .. electricwarning
        mobwarnings["Nikola"] = mobwarnings["Nikola"] .. electricwarning
        mobwarnings["shock serpent"] = mobwarnings["shock serpent"] .. electricwarning
        mobwarnings["Sojobo"] = mobwarnings["Sojobo"] .. electricwarning
        mobwarnings["storm dragon"] = mobwarnings["storm dragon"] .. electricwarning
        mobwarnings["titan"] = mobwarnings["titan"] .. electricwarning
    end

    mobwarnings["giant orange brain"] = "can cast Shadow Creatures, and drain your Int!"
    mobwarnings["neqoxec"] = "can mutate you, and drain your Int!"
    mobwarnings["Norris"] = "can cast Paralyse, Smite you, and drain your Int!"
    mobwarnings["orange crystal statue"] = "can cast Confuse, Drain MP, and drain your Int!"

    mobwarnings["cacodemon"] = "can cast Energy bolts, Dig, and mutate you!"
    mobwarnings["orb of fire"] = "can cast Fireball and Bolt of Fire, and mutate you!"
    if no_rMut then
        local mutationwarning = "<red> You are not wearing rMut!</red>"
        mobwarnings["cacodemon"] = mobwarnings["cacodemon"] .. mutationwarning
        mobwarnings["neqoxec"] = mobwarnings["neqoxec"] .. mutationwarning
        mobwarnings["orb of fire"] = mobwarnings["orb of fire"] ..mutationwarning
        mobwarnings["pulsating lump"] = "can mutate you in melee!" .. mutationwarning
        mobwarnings["shining eye"] = "can temporarily mutate you!" .. mutationwarning
    end

    local gdwarn = "can hit for high damage in melee"
    local alichwarn = ""
    if (no_rF or no_rP or no_rC or no_rN or no_see_invis) then
        if no_rF then
            gdwarn = gdwarn .. ", breathe Bolts of Fire"
            alichwarn = alichwarn .. ", cast Bolt of Fire"
        end
        if no_rC then
            gdwarn = gdwarn .. ", breathe freezing blasts"
            alichwarn = alichwarn .. ", cast Bolt of Cold"
        end
        if no_rN then
            alichwarn = alichwarn .. ", cast Bolt of Draining"
        end
        if no_rP then
            gdwarn = gdwarn .. ", breathe poison clouds"
        end
        if no_see_invis then
            alichwarn = alichwarn .. ", or go Invisible"
        end
    end

    mobwarnings["ancient lich"] = "might cast Banishment, Paralyse, SGD, IOOD, or LCS" .. alichwarn .. "!"
    mobwarnings["golden dragon"] = gdwarn .. "!"
    mobwarnings["lich"] = "might cast Banishment, Paralyse, Summon Demon, IOOD, or LCS!"

    if no_rF then
        mobwarnings["Xtahua"] = "does high damage in melee and has a nasty fire breath attack"
    else
        mobwarnings["Xtahua"] = "does high damage in melee!"
    end

    mobwarnings["air mage"] = "can cast Airstrike!"
    mobwarnings["blizzard demon"] = "can cast Airstrike!"
    mobwarnings["Gastronok"] = "can cast Airstrike!"
    mobwarnings["wind drake"] = "can cast Airstrike and push you away!"
    if you_are_flying then
        local flightwarning = " <red>You are in flight!</red>"
        mobwarnings["air mage"] = mobwarnings["air mage"] .. flightwarning
        mobwarnings["blizzard demon"] = mobwarnings["blizzard demon"]..flightwarning
        mobwarnings["Gastronok"] = mobwarnings["Gastronok"]..flightwarning
        mobwarnings["Sojobo"] = mobwarnings["Sojobo"]..flightwarning
        mobwarnings["titan"] = mobwarnings["titan"]..flightwarning
        mobwarnings["wind drake"] = mobwarnings["wind drake"]..flightwarning
    end

    if no_see_invis then
        mobwarnings["boggart"] = "can cast Shadow Creatures and go Invisible!"
    else
        mobwarnings["boggart"] = "can cast Shadow Creatures!"
    end

    if no_rCorr then
        mobwarnings["yellow draconian"] = "can corrode your equipment at range!"
    end

    if no_rP and no_rE then
        mobwarnings["draconian annihilator"] = "can cast LCS, Poison Arrow, Lightning Bolt, and Iron Shot!"
    elseif no_rP then
        mobwarnings["draconian annihilator"] = "can cast LCS, Poison Arrow, and Iron Shot!"
    elseif no_rE then
        mobwarnings["draconian annihilator"] = "can cast LCS, Lightning Bolt, and Iron Shot!"
    else
        mobwarnings["draconian annihilator"] = "can cast Lehudib's Crystal Spear or Iron Shot!"
    end

    if you_perm_rTorment then
        mobwarnings["Brimstone Fiend"] = "can cast line-of-sight Hellfire!"
        mobwarnings["curse skull"] = "can cast Summon Undead!"
        mobwarnings["curse toe"] = "can cast Summon Fungus!"
        mobwarnings["Ereshkigal"] = "can cast Paralyse!"
        mobwarnings["greater mummy"] = "can smite you!"
        mobwarnings["Khufu"] = "can smite you!"
        mobwarnings["mummy priest"] = "can smite you!"
        mobwarnings["Shadow Fiend"] = "can cast Dispel Undead!"
    else
        mobwarnings["Brimstone Fiend"] = "can cast Torment and line-of-sight Hellfire!"
        mobwarnings["curse skull"] = "can cast Torment and Summon Undead!"
        mobwarnings["curse toe"] = "can cast Torment and Summon Fungus!"
        mobwarnings["Ereshkigal"] = "can cast Torment and Paralyse!"
        mobwarnings["Gloorx Vloq"] = "can cast Torment!"
        mobwarnings["greater mummy"] = "can cast Torment and smite you!"
        mobwarnings["Ice Fiend"] = "can cast Torment!"
        mobwarnings["Khufu"] = "can cast Torment and smite you!"
        mobwarnings["Menkaure"] = "can cast Torment!"
        mobwarnings["mummy priest"] = "can cast Torment and smite you!"
        mobwarnings["Shadow Fiend"] = "can cast Torment and Dispel Undead!"
        mobwarnings["tormentor"] = "can cast Torment!"
    end

    mobwarnings["apocalypse crab"] = "is fast and has a chaos cloud breath attack!"
    mobwarnings["Arachne"] = "can ensnare you in her webs!"
    mobwarnings["Asmodeus"] = "can cast line-of-sight Hellfire and Summon Greater Demons!"
    mobwarnings["Azrael"] = "can cast smite-targeted Hellfire!"
    mobwarnings["balrug"] = "can smite you, and cast fireball!"
    mobwarnings["black sun"] = "can give allies a dangerous black mark which gives melee effects!"
    mobwarnings["blood saint"] = "can cast LCS and other Legendary Destruction!"
    mobwarnings["catoblepas"] = "can petrify you with its breath!"
    mobwarnings["Cerebov"] = "can cast Fire Storm, Iron Shot, and Summon Greater Demons!"
    mobwarnings["chaos champion"] = "can dispel buffs, entrap you, and other chaotic effects!"
    mobwarnings["corrupter"] = "can summon allies from various branches!"
    mobwarnings["daeva"] = "can smite you!"
    mobwarnings["deep elf annihilator"] = "can cast Lehudib's Crystal Spear or Iron Shot!"
    mobwarnings["deep elf demonologist"] = "can cast banishment or summon Greater Demons!"
    mobwarnings["deep elf high priest"] = "can cast smite-targeted Hellfire or smite you!"
    mobwarnings["deep elf priest"] = "can smite you!"
    mobwarnings["deep elf sorcerer"] = "can cast banishment or line-of-sight Hellfire!"
    mobwarnings["deep troll shaman"] = "can cast haste and might on allies!"
    mobwarnings["Dispater"] = "can cast line-of-sight Hellfire, Iron Shot, and summon Greater Demons!"
    mobwarnings["draconian caller"] = "can summon Dragons and Death Drakes!"
    mobwarnings["draconian scorcher"] = "can cast smite-targeted Hellfire!"
    mobwarnings["draconian shifter"] = "can block teleports, blink allies encircling you, or cause you to blink!"
    mobwarnings["draconian zealot"] = "can cast smite-targeted Hellfire or smite you!"
    mobwarnings["Enchantress"] = "is very fast and can cast Dimension Anchor, Slow, Haste, Mass Confusion, and Strip Resistance!"
    mobwarnings["eye of draining"] = "will drain your Magic!"
    mobwarnings["flayed ghost"] = "can Flay you to shreds!"
    mobwarnings["Frances"] = "can smite you!"
    mobwarnings["Frederick"] = "can cast Iron Shot!"
    mobwarnings["ghost moth"] = "will drain your Magic!"
    mobwarnings["giant eyeball"] = "can paralyse you!"
    mobwarnings["golden eyeball"] = "can confuse you!"
    mobwarnings["guardian serpent"] = "can blink allies encircling you!"
    mobwarnings["Hell Sentinel"] = "can cast line-of-sight Hellfire and Iron Shot!"
    mobwarnings["hellion"] = "can cast smite-targeted Hellfire!"
    mobwarnings["Ignacio"] = "can cast Agony!"
    mobwarnings["ironbrand convoker"] = "can recall allies and cast might on them!"
    mobwarnings["Jorgrun"] = "can cast petrify and shatter!"
    mobwarnings["Jory"] = "can mesmerise, cast LCS and blink close!"
    mobwarnings["jumping spider"] = "is fast and can ensnare you in webs!"
    mobwarnings["mana viper"] = "is fast and has an antimagic bite!"
    mobwarnings["Mennas"] = "can cast silence and confuse!"
    mobwarnings["Mnoleg"] = "cast Summon Eyes and smite you!"
    mobwarnings["moth of wrath"] = "is fast and can enrage both enemies and you!"
    mobwarnings["octopode crusher"] = "can cast Iron Shot and throw you in melee!"
    mobwarnings["orb spider"] = "is fast and can cast Orb of Destruction!"
    mobwarnings["orc high priest"] = "can smite you!"
    mobwarnings["orc priest"] = "can smite you!"
    mobwarnings["phantasmal warrior"] = "can bypass armour and shields, and lowers MR!"
    mobwarnings["quicksilver dragon"] = "can dispel your buffs!"
    mobwarnings["rakshasa"] = "can cast IMB, Phantom Mirror, duplicating itself and allies, and blinks!"
    mobwarnings["Roxanne"] = "can cast LCS and Iron Shot at you, or shift your position!"
    mobwarnings["shadow demon"] = "can cast Shadow Creatures!"
    mobwarnings["smoke demon"] = "can smite you, and cast ranged sticky flame!"
    mobwarnings["sphinx"] = "can cast paralyse, slow, confuse, and smite you!"
    mobwarnings["spriggan druid"] = "is very fast, can awaken trees, recall animals, and cast Stone Arrow!"
    mobwarnings["starcursed mass"] = "can smite you!"
    mobwarnings["tentacled monstrosity"] = "has dangerous constriction in melee!"
    mobwarnings["thorn hunter"] = "can throw a nasty volley of thorns, and create brambles!"
    mobwarnings["warmonger"] = "can sap your magic and summon a grand avatar!"
    mobwarnings["ynoxinul"] = "can cast Iron Shot!"

    -- Holds the overall alert message and count of dangers
    local alerts = ""
    local short_alert = " "
    local total_dangers = 0
    -- For each type of monster you can see, using getMonsterList()
    -- This goes through each monster in the mobwarnings table above and
    -- Checks to see if it matches the description of each mob in sight
    -- Excluding forms that can't cast: zombie, skeleton, simulcrum, but not incapacitated forms
    for mons, count in pairs(getMonsterList()) do
        for mob, message in pairs(mobwarnings) do
            if string.find(mons, mob)
                and not string.find(mons, "zombie")
                and not string.find(mons, "skeleton")
                and not string.find(mons, "shaped block of ice")
                and not string.find(mons, "spectral")
                and not (string.find(mons, "simulacr") and mob ~= "simulacr")
                and not (string.find(mons, "orc") and mob == "wizard")
                and not (string.find(mons, "ancient lich") and mob == "lich")
                and not (string.find(mons, "death yak") and mob == "yak")
                and not (string.find(mons, "gnoll shaman") and mob == "gnoll")
                and not (string.find(mons, "gnoll captain") and mob == "gnoll")
                and not (string.find(mons, "mottled draconian") and mob == "mottled")
                and not (string.find(mons, "dire elephant") and mob == "elephant")
                and not (string.find(mons, "elephant slug") and mob == "elephant")
                and not (string.find(mons, "salamander mystic") and mob == "salamander")
                and not (string.find(mons, "Josephine") and mob == "Joseph") then
                --Used to format the string for Unique/Named mobs
                local is_fiend = (string.find(mons, "Fiend") ~= nil)
                local is_uppercase = (string.find(mons, "%u") ~= nil)
                local is_unique = is_uppercase and not is_fiend
                --Holds this mobs alert message
                local alert = ""
                local mob_name = ""
                --Formatting for uniques
                if is_unique then
                    alert = "<cyan>" .. mons .. "</cyan> " .. message
                    mob_name = mons
                    --For more than 1 of the same monster
                elseif (count > 1) then
                    alert = "The <cyan>".. mons .. "</cyan> " .. message .. " x" .. count
                    mob_name = mons .. " x" .. count
                    --For a single non-unique monster
                else
                    alert = "The <cyan>" .. mons .. "</cyan> " .. message
                    mob_name = mons
                end
                --Keeps a count of all the found matches
                total_dangers = total_dangers + count
                --Adds the created alert string to the full string of alerts
                alerts = alerts .. " " .. alert
                short_alert = short_alert .. mob_name .. ", "
            end
        end
    end

    short_alert = string.sub(short_alert, 1, -3) .. "!"

    --If there is an alert and it was not displayed in the last six messages then display the warning
    if not ((alerts == "")
        or string.find(crawl.messages(6), escape(alerts))) then
        --For a single monster
        if total_dangers == 1 then
            crawl.mpr("<lightgrey>Spoiler Alert:" .. alerts .. "</lightgrey>")
            --For 2 or 3
        elseif total_dangers < 4 then
            crawl.mpr("<yellow>Warning x"..total_dangers .. ":" .. alerts .. "</yellow>")
            --For 4 to 7
        elseif total_dangers < 8 and (not string.find(crawl.messages(6), escape(short_alert))) then
            crawl.mpr("<lightred>Danger x" ..total_dangers .. ":" .. short_alert .. "</lightred>")
            --For 8 or more
        elseif not string.find(crawl.messages(6), escape(short_alert)) then
            crawl.mpr("<red>PANIC x" ..total_dangers .. ":" .. short_alert .. "</red>")
        end
    end
end
