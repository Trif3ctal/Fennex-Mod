SMODS.Consumable {
    key = "midway_games",
    set = "Silly",
    config = {
        extra = {

        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_standard
        info_queue[#info_queue+1] = G.P_TAGS.tag_charm
        info_queue[#info_queue+1] = G.P_TAGS.tag_meteor
        info_queue[#info_queue+1] = G.P_TAGS.tag_buffoon
    end,
    atlas = "Consumables",
    pos = {x = 4, y = 1 },
    cost = 8,
    use = function(self, card, context, copier)
        local used_consumable = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local tags = {
                "tag_standard",
                "tag_charm",
                "tag_meteor",
                "tag_buffoon"
            }
            local tag = Tag(pseudorandom_element(tags, pseudoseed("midway")))
            add_tag(tag)
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            used_consumable:juice_up(0.3, 0.5)
        return true end}))
        delay(0.5)
    end,
    can_use = function(self, card)
        return true
    end
}