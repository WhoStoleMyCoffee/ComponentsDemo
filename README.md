# Components demo

Demo in [this video](https://youtu.be/ldxDJpRPCMI)

Made by Tienne_k in the Godot game engine


### Project structure:
- Player script is in `res://Player/player.gd`.
- Components are inside `res://Components/`.
- Game objects (crates, rocks, etc) are in `res://Objects/`.
- Main scene is `res://Scenes/Levels/test_level.tscn`.

    Some nodes in that scene have editor descriptions (`editor_description` property in the inspector); please be sure to read them to avoid some potential confusion

---

This is definitely not the best implementation, though.

Due to some coincidences of similar movement mechanics, the player... is technically pushable (i.e. has a PushableComponent)...

According to this implementation, the player is technically pushing themselves to move... Please don't copy this in your own projects, this was a mere coincidence lol.

---

If you're here because you're genuinely interested in learning this stuff, here are some exercises for you:

1. Make the trees pushable
2. Make it so the trees can only be pushed if no other objects are in the chain

    I.e. player pushing a rock, pushing a crate, pushing a tree wouldn't work; but the player pushing only a tree would

3. Make it so switches toggle whether specific crates are pushable or not

You can share your solutions on our [discord server](https://discord.gg/VTvG7ZQNdQ)

I hope this helps you on your journey

