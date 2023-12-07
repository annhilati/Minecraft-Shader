# Skin Effects
###### A minecraft core shader
## Features
* Adds regular blinking to all skins for which it is configured
* Customizes the damage flash color to all skins for which it is configured
* The configuration is in the skin texture itself

### Configuration
<a href="https://developer.mozilla.org/en-US/docs/Glossary/HTML5" target="_blank" rel="noreferrer"><img src="https://raw.githubusercontent.com/annhilati/minecraft-shader/main/Minecraft%20Core/Skin%20Effects/skin.png" width="100" alt="HTML5" /></a>  
Yellow: Regular skin  
Magenta: Regular second skin layer  
Blue: Front head when blinking  
Red: Time between blinking (`time = 5s * (color.r/255)`)
Green: Custom flash color when the player gets harmed
Grey-ish: If this pixel is exactly there in exactly this color (`117, 145, 145, 187`), the shader executes the effects for this player

## Compatibility
* Does definitely work in [pack_format 8](https://github.com/annhilati/minecraft/blob/main/doc/minecraft/pack_format.md) versions
* Does definitely not work in [pack_format 9](https://github.com/annhilati/minecraft/blob/main/doc/minecraft/pack_format.md) versions
* Does not work with most OptiFine Shaders, that are not adapted to it (practically everyone)
  
### Credits
Originally made by [McTsts](https://github.com/McTsts/mc-core-shaders/tree/main/skin%20effects)
