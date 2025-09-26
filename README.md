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
Make sure you have the items in ```qb-core/shared/items.lua```
```	lemon                  = { name = 'lemon', label = 'lemon', weight = 100, type = 'item', image = 'lemon.png', unique = false, useable = false, shouldClose = true, description = 'Fresh lemon, perfect for juice!' },
    potato                  = { name = 'potato', label = 'potato', weight = 100, type = 'item', image = 'potato.png', unique = false, useable = false, shouldClose = true, description = 'A raw potato from the farm.' },
	carrot                  = { name = 'carrot', label = 'carrot', weight = 100, type = 'item', image = 'carrot.png', unique = false, useable = false, shouldClose = true, description = 'Fresh carrot, healthy and crunchy!' },
    apple                  = { name = 'apple', label = 'apple', weight = 100, type = 'item', image = 'apple.png', unique = false, useable = false, shouldClose = true, description = 'A sweet red apple' },
	apple_juice                  = { name = 'apple_juice', label = 'Apple Juice', weight = 200, type = 'item', image = 'apple_juice.png', unique = false, useable = true, shouldClose = true, description = 'Apple Juice' },
    lemon_juice                  = { name = 'lemon_juice', label = 'Lemon Juice', weight = 200, type = 'item', image = 'lemon_juice.png', unique = false, useable = true, shouldClose = true, description = 'Lemon Juice' },
```
*Add the corresponding images (PNG) to ```qb-inventory/html/images```
3-Configure locations, prices, and items in config.lua.

📝 Notes

-By default, crafting juice requires 10 fruits = 1 juice.

-Selling system uses a clean qb-menu for better player experience.

-Works with default QBCore inventory and money system.

<img width="218" height="109" alt="image" src="https://github.com/user-attachments/assets/c9f2faf5-aaff-49ad-8f84-fe9b5b3e6a92" />

<img width="393" height="374" alt="image" src="https://github.com/user-attachments/assets/8de1c947-6b84-463d-bc05-6becb47a0c7a" />

<img width="416" height="185" alt="image" src="https://github.com/user-attachments/assets/5cce3ba9-be1c-4a47-b64d-3d838fc89e3e" />

<img width="654" height="426" alt="image" src="https://github.com/user-attachments/assets/37e52b98-5fda-4459-8ffc-7fa420c8050b" />

<img width="434" height="221" alt="image" src="https://github.com/user-attachments/assets/4cdfbac9-66b0-4fe7-a88b-36b4e9d6fd66" />

<img width="496" height="278" alt="image" src="https://github.com/user-attachments/assets/09089344-c5a7-41b4-96c4-92282e5ba1b0" />
