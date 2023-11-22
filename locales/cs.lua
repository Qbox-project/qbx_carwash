local Translations = {
    ["washing"] = "Vozidlo se myje...",
    ["canceled"] = "Zrušeno...",
    ["not_dirty"] = "Vozidlo není špinavé",
    ["not_available"] = "Myčka aut není k dispozici...",
    ["no_money"] = "Nemáte dost peněz...",
    ["reason"] = "Auto vyčištěno",
    ["label"] = "Myčka aut"
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
--translated by stepan_valic