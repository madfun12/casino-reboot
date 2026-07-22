## Casino resource for QBCore

This is an updated version of the DOJ Casino resource for QBCore framework. I do not claim ownership of the original script. 
This update includes bug fixes and ensures compatibility with the latest QBCore versions.

[Showcase](https://www.youtube.com/watch?v=pu8Aoxo3RC8&ab_channel=Ry)

![image](https://github.com/user-attachments/assets/f0e8f06b-dffe-4124-b1a4-060ad6b66b84)

**Features:**

Membership System: Players can join the casino with a membership, giving them exclusive access to premium features.
Betting Chips: Players can bet with chips to play various games throughout the casino.

**Games:**

Blackjack
Horse Race (Inside Track)
Lucky Wheel: Spin the wheel for a chance to win big prizes, including a car (customizable to any vehicle you prefer).
3 Card Poker
Roulette
Slot Machines

**Penthouse:** A luxurious area for the rich, where you can install custom apartments.

**MLO Features:**

A massive MLO casino environment to explore, complete with a garage, staff area, and a huge basement.
Vault: A potential future location for a heist? Who knows, maybe one day you can rob this high-end casino!

## Depenencies:

[QBCore Framework](https://github.com/qbcore-framework)

[DLCiplLoader/MLO](https://github.com/RyFiction/DLCiplLoader)

## Installation instuctions:

**1. Install DLCiplLoader**

Drag and drop into the [Casino Reboot] folder.

**2. Add inventory Image**

Navigate to the following directory in your server files:
resources\[qb]\qb-inventory\html\images

Copy `casino_chip.png` into the images folder.

**3. Add Casino Items**

Open the items.lua file in the following directory:
resources\[qb]\qb-core\shared\items.lua

Add the following line of code to the file:

-- Casino Items
["casino_chip"]              = {["name"] = "casino_chip",            ["label"] = "Betting Chips",       ["weight"] = 3,         ["type"] = "item",      ["image"] = "casino_chip.png",              ["unique"] = false,     ["useable"] = false,    ["shouldClose"] = false,   ["combinable"] = nil,   ["description"] = "Diamond Casino Chips"},

Casino and VIP memberships are permanently stored in QBCore player metadata. They do not require item definitions, inventory images, or a separate SQL migration. Existing `casino_member` and `casino_vip` items are converted automatically the next time the player loads in.

**4. Restart Your Server**

Credits
Original Script: [DOJ Casino](https://github.com/dojwun/doj-casino/tree/92a5d5e76f1c6c900ae41d61872fec5d10696d86) -
Updates & Fixes: RyFiction

Feel free to reach out if you encounter any issues! 🎲
[Discord](https://discord.gg/CSvx3SvxAq)
