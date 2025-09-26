# qb-farming
🌾 QBCore Farming & Juice Script

A simple and customizable farming system for FiveM (QBCore).
Players can harvest crops, craft juices, and sell their products to an NPC for cash.

✨ Features

👨‍🌾 Harvesting System

-Multiple farm locations for different crops (apples, lemons, carrots, potatoes, etc.).

-Progressbar + animations while harvesting.

-Custom blips for farm zones.

🥤 Juice Crafting

-Juice station to craft fresh juices (apple juice, lemon juice, etc.).

-Requires fruits (e.g., 10 apples = 1 apple juice).

-Progressbar + blending animation.

💰 Selling System

-NPC crop buyer with target interaction.

-Menu to choose which crop to sell.

-Options to sell All, 10, or 1 item.

-Automatic money reward based on configurable prices.

🗺️ Blips & NPCs

-Blips for juice station, farms, and crop buyer.

-Invincible NPC that handles selling.

⚙️ Configuration

-Easily configurable farm locations, juice station, NPC position, and crop prices in config.lua.

📦 Dependencies

[QBCore Framework](https://github.com/qbcore-framework/qb-core.git)
[qb-target](https://github.com/qbcore-framework/qb-target.git)
[qb-menu](https://github.com/qbcore-framework/qb-menu.git)
[qb-inventory](https://github.com/qbcore-framework/qb-inventory.git)

🚀 Installation

1-Download and place the script in your resources/[qb] folder.

2-Add the following to your ```server.cfg```

```ensure qb-core
ensure farming-script
```
3-Configure locations, prices, and items in config.lua.

📝 Notes

-By default, crafting juice requires 10 fruits = 1 juice.

-Selling system uses a clean qb-menu for better player experience.

-Works with default QBCore inventory and money system.

