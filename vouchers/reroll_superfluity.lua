SMODS.Voucher {
    key = "reroll_superfluity",
    atlas = "Vouchers",
    pos = { x = 1, y = 0 },
    cost = 10,
    unlocked = true,
    available = true,
    requires = {"v_reroll_surplus", "v_reroll_glut"},
    add_to_deck = function(self, card, from_debuff)
        calculate_reroll_cost(true)
    end,
    remove_from_deck = function(self, card, from_debuff)
        calculate_reroll_cost(true)
    end,
    
}