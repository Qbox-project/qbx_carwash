local Translations = {
    ["wash_prompt"] = 'Wash the car for $%{value}',
    ["wash_prompt_dt"] = '~g~E~w~ - Wash the car for $%{value}',
    ["washing"] = "Vehicle is being washed...",
    ["canceled"] = "Canceled...",
    ["not_dirty"] = "The vehicle isn't dirty",
    ["not_available"] = "The car wash isn't available...",
    ["no_money"] = "You don't have enough money...",
    ["reason"] = "Car Washed",
    ["label"] = "Car Wash"
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
