# cc-novnc

Welcome to cc-novnc, your gateway to the ultimate Cookie Empire experience! Imagine having your own cookie utopia accessible from anywhere. With cc-novnc, you can enjoy Cookie Clicker through your web browser, and the best part is: your cookie empire keeps baking even when you're not playing! However, sometimes the game might crash or freeze, but don't worry, [fixing it is simple!](#issues-and-solutions)

## What You'll Need

### Required Items:

- A Steam account.
- Cookie Clicker from Steam (usually costs less than 5 EUR).
- A server with Docker/Docker Compose installed and decent specs.

### Before You Start

1. **Get the Files:** Download the files from this repository.
2. **Steam Account:** If you don't have one, create a Steam account.
3. **Get Cookie Clicker:** Purchase Cookie Clicker from the Steam Store (support the developers by buying it legally, don't be a pirate argh!).
4. **Prepare Your Server:** Make sure Docker and Docker compose are installed on your server.

## Steps to Install Cookie Clicker

1. **Download Cookie Clicker:** Get Cookie Clicker from your Steam account to your computer.
2. **Find Steam Folder:** Locate where Steam is installed on your computer.
3. **Find Cookie Clicker Directory:** Look for the folder where Cookie Clicker is installed.
4. **Locate the 'app' Folder:** Inside the Cookie Clicker directory, find the 'app' folder.
5. **Move 'app' Folder:** Copy the 'app' folder and paste it into the folder you downloaded from this repository. Use a tool like scp or rsync to copy the folder to your server.
6. **Delete mods:** Delete the contents the 'workshop' folders inside the 'mods' folder. (This step is optional, but it's recommended to avoid any issues.)

## Load your Cookie Clicker Save

1. **Copy your Save:** Start Cookie Clicker on your computer and create a save. You can use 'Export Save' to copy the save to your clipboard.
2. **Create Save Folder:** Make a folder named 'save' in the same directory as the 'config' folder.
3. **Create your Save File:** Create a file named 'save.cki' in the 'save' folder and paste your save into it.

## Installing the Docker Container

1. **Customize 'docker-compose.yml':** Edit the 'docker-compose.yml' file as needed.
2. **Run a Command:** Use the command `docker-compose up -d`.
3. **Wait:** Have a cup of tea and wait for the container to build.

## How to Play

### Playing Cookie Clicker

1. **Access noVNC:** Open your web browser and enter your server's IP address followed by port 8080 (or the one you specified in 'docker-compose.yml').
2. **Connect:** Click the 'Connect' button.
3. **Click Away:** Start playing Cookie Clicker!

## Issues and Solutions

If you encounter any problems like crashes or bugs:

- Visit [GitHub](https://github.com/staninna/cc-novnc/issues/new) to report issues.
- Known issue: If the game crashes or hangs when the browser window is large, make it smaller and close the game using the 'X' at the top right; then, the game will restart automatically after a minute or so.

## Licensing

This project is licensed under the MIT License. For more details, check the [LICENSE](LICENSE) file.

## Legal Disclaimer

I won't provide a pre-built container containing Cookie Clicker, a commercial product. You must buy Cookie Clicker from Steam and follow the steps in this guide to build the container yourself. I'm not responsible for any legal issues that may arise from using this project. Please use it at your own risk.
