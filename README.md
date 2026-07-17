# SPLIT STREET
SPLIT STREET is a three-dimensional rhythm game built in Godot that, unlike traditional flat-plain games, has your focus split across the horizon! Watch out for unsuspecting notes flying above your head or below your feet. Sort of.

<img width="1918" height="1102" alt="Screenshot 2026-07-16 204633" src="https://github.com/user-attachments/assets/1fb9ff2d-a5d6-49ac-b45e-33e0349f52fb" />

## Installation and Setup
### Downloading the Desktop Version for Players (Windows Only)
 1. Head to the itch.io page for our game (https://finnstar17.itch.io/split-street) and download the .zip for Windows.
 2. Open the newly downloaded .zip file in your file browser and click Extract All.
 3. After extracting the files, open the folder and double click split-street.exe to open the game.

### Downloading for Contributors and for Debugging
**Requirements:**
 1. Godot Engine v4.2+ (https://godotengine.org/)
 2. Git (https://git-scm.com/install/windows)
**Cloning the Repository**
 1. Open Git Bash.
 2. Change the current working directory to where you want the cloned directory.
 3. Type `git clone` and paste the URL of this repository (https://github.com/finnstar17/SPLIT-STREET.git)
    - `git clone https://github.com/finnstar17/SPLIT-STREET.git`
 4. Press enter.
You're all set! Now you can open the project in your Godot Engine.

## How to Play
### Controls
| Plane | Lane | Keybind |
| --- | --- | --- |
| Bottom | Lane 1 | D |
| | Lane 2 | F |
| | Lane 3 | J |
| | Lane 4 | K |
| Top | Lane 1 | E |
| | Lane 2 | R |
| | Lane 3 | U |
| | Lane 4 | I |
### Note Types
 1. Regular Notes
    - Just like in other rhythm games, these notes are meant to be hit once it enters the target zone in its respective lane.

 2. Hold Notes
    - Under regular notes, hold notes are to be interacted with by holding the button in its corresponding lane in order to hit it.

 3. Climb Notes
    - These notes are tricky. Once hit in its target zone, it will redirect itself to move to the opposite lane it is from.
      (e.g. from bottom to top and vice versa)

## Credits
Due to my limited time, I decided to use songs I thought would sound nice for a project like this.

- Koraii - **Trick Room**
- Metaroom - **CARLOT32 (METAROOM REMIX)**

## In Regards to AI Usage
AI was used minimally in this project for efficiency in charting. I originally charted the first half of Trick Room because it highlights the main mechanic, Climb notes. Due to the game's method in charting songs, I decided to skip manually changing each bar by having AI assist me in shifting those simple numbers by 32.

## License
This project is licensed under the MIT License - see [MIT License](split-street/LICENSE) for more details.
