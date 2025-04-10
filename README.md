My first Addon!
This is for Druid Idol Swapping to maximize perfomance, Ill try to update it as I move through the other specs.

Keep in mind this add on works best when combined with SuperWoW, Nampower, CleveRoidMacros, VanillaFixes and SuperMacro!

/script DruidWrath() = Cast Wrath equip Idol of the Moonfang 
/script DruidStarfire() = Cast Starfire equip Idol of Ebb and Flow
/script DruidDoT() = Cast Moonfire equip Idol of the Moon


Here is my current Macro using all of these variables and functions for Boomkin.

/retarget
/startattack
/cast [mybuff:"Nature Eclipse"] {WrathSwap}
/castsequence [mybuff:"Arcane Eclipse"] Starfire, {StarfireSwap}
/cast [mydebuff:"Arcane Solstice",nomydebuff:"Natural Solstice"] {WrathSwap}
/cast [mydebuff:"Natural Solstice",nomydebuff:"Arcane Solstice"] {StarfireSwap}
/cast [nomydebuff:"Natural Solstice",nomydebuff:"Arcane Solstice"] {WrathSwap}
