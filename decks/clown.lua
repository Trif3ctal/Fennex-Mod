SMODS.Back {
    key = 'clown',
    atlas = 'Decks',
    pos = { x = 0, y = 1 },
    config = {
        voucher = 'v_fmod_circus'
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize {
                    type = "name_text",
                    set = "Voucher",
                    key = "v_fmod_circus"
                }, 
                colours = {HEX("ff98e2")}
            }
        }
    end
  }