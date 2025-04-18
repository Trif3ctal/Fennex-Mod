FMOD = {}

FM = SMODS.current_mod
fmod_config = SMODS.current_mod.config

--Optional features
SMODS.optional_features = {
    cardareas = {
        unscored=true,
    }
}


-- file loading

local files = {
    jokers = {
        list = {
            "fennex",
            "despicable_bear",
            "generator",
            "countdown",
            "penny_joker",
            "low_hanging_fruit",
            "nerdcubed",
            "terminal_velocity",
            "nero_the_fool",
            "negative_joker"
        },
        directory = "jokers/"
    },
    vouchers = {
        list = {
            "circus",
            "showtime",
            "reroll_superfluity",
            "buffet",
            "dumpster_ritual",
            "anti_higgs_boson",
            "big_bang",
            "color_swatches",
            "fire_sale",
            "coupon",
            "extreme_couponing",
            "shopaholic"
        },
        directory = "vouchers/"
    },
    consumables = {
        list = {
            "clown_car",
            "squirt_flower",
            "pie",
            "bang_gun",
            "whoopie_cushion",
            "joy_buzzer",
            "juggler",
            "balloons",
            "split_pants",
            "midway_games",
        },
        directory = 'consumables/'
    },
    blinds = {
        list = {
            "hoard",
        },
        directory = "blinds/"
    },
    decks = {
        list = {
            "clown",
            "fennex",
            "recursive",
        },
        directory = "decks/"
    },
    tags = {
        list = {
            "goofy",
            "appraisal",
        },
        directory = "tags/"
    },
    boosters = {
        list = {
            "boosters" -- just using one file for ease of use
        },
        directory = "boosters/"
    }
}

-- atlases

SMODS.Atlas {
    key = "Jokers",
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Consumables",
    path = "Consumables.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
	key = "modicon",
	path = "Fennex_Mod_Icon.png",
	px = 32,
	py = 32
}

SMODS.Atlas {
    key = "Vouchers",
    path = "Vouchers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Blinds",
    path = "Blinds.png",
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "Tags",
    path = "Tags.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "Boosters",
    path = "Booster.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Decks",
    path = "Decks.png",
    px = 71,
    py = 95
}

-- silly packs

SMODS.ConsumableType {
    key = 'Silly',
    primary_colour = HEX('f4d494'),
    secondary_colour = HEX('84b4cc'),
    collection_rows = { 5, 6 },
    default = 'c_fmod_pie',
    shop_rate = 0,
    cards = {
        ["c_fmod_clown_car"] = true,
        ["c_fmod_squirt_flower"] = true,
        ["c_fmod_pie"] = true,
        ["c_fmod_bang_gun"] = true,
        ["c_fmod_whoopie_cushion"] = true,
        ["c_fmod_joy_buzzer"] = true,
        ["c_fmod_juggler"] = true,
        ["c_fmod_balloons"] = true,
        ["c_fmod_split_pants"] = true,
        ["c_fmod_midway_games"] = true,
    },
    loc_txt = {
        name = "Silly",
        collection = "Silly Cards",
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }
        }
    },
}

-- load everything

local function load_files(set)
    for i = 1, #files[set].list do
        if files[set].list[i] then assert(SMODS.load_file(files[set].directory .. files[set].list[i] .. '.lua'))() end
    end
end

for k, v in pairs(files) do
    load_files(k)
end

-- functions

local base_modify_hand = Blind.modify_hand
function Blind:modify_hand(cards, poker_hands, text, mult, hand_chips)
    local mult, hand_chips, modded = base_modify_hand(self, cards, poker_hands, text, mult, hand_chips)

    if G.GAME.new_poker_hand then

        G.GAME.hands[G.GAME.old_poker_hand].played = G.GAME.hands[G.GAME.old_poker_hand].played - 1
        G.GAME.hands[G.GAME.old_poker_hand].played_this_round = G.GAME.hands[G.GAME.old_poker_hand].played_this_round - 1

        G.GAME.hands[G.GAME.new_poker_hand].played = G.GAME.hands[G.GAME.new_poker_hand].played + 1
        G.GAME.hands[G.GAME.new_poker_hand].played_this_round = G.GAME.hands[G.GAME.new_poker_hand].played_this_round + 1

        G.GAME.last_hand_played = G.GAME.new_poker_hand
        set_hand_usage(G.GAME.new_poker_hand)
        G.GAME.hands[G.GAME.new_poker_hand].visible = true

        if self.name == 'The Eye' then

            if self.hands[G.GAME.old_poker_hand] then
                self.hands[G.GAME.old_poker_hand] = false
            end
            self.hands[G.GAME.new_poker_hand] = true

        elseif self.name == 'The Mouth' then

            self.only_hand = G.GAME.new_poker_hand

        end

        mult = G.GAME.hands[G.GAME.new_poker_hand].mult
        hand_chips = G.GAME.hands[G.GAME.new_poker_hand].chips
        modded = false

        G.GAME.new_poker_hand = false

    end

    return mult, hand_chips, modded
end
