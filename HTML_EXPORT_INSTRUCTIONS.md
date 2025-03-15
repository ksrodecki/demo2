# HTML5 Export Instructions for Brick Jumper

This document explains how to export the Brick Jumper game to HTML5 format so it can be played in a web browser.

## Prerequisites

- Godot Engine (latest stable version)
- Web browser that supports WebGL (Chrome, Firefox, Edge, etc.)

## Export Steps

1. **Open the project in Godot Engine**
   - Launch Godot Engine
   - Open the Brick Jumper project

2. **Export the project**
   - From the top menu, select "Project" → "Export..."
   - If this is your first time exporting, you may see a message about export templates. Click "Manage Export Templates" and then "Download and Install" to get the latest export templates.
   - Once templates are installed, you should see the HTML5 preset already configured in the export dialog
   - Click on "HTML5" in the left panel
   - Verify that the export path is set to "export/html/index.html"
   - Click "Export Project"
   - Choose a location to save the exported files (use the default or navigate to the project's "export/html/" folder)
   - Click "Save"

3. **Test the exported game**
   - Due to browser security restrictions, you cannot simply open the HTML file directly. You need to serve it from a web server.
   - You have several options:

### Option 1: Use a simple HTTP server

If you have Python installed, you can run a simple HTTP server:

```bash
# Navigate to the export folder
cd export/html

# If you have Python 3
python -m http.server 8000

# If you have Python 2
python -m SimpleHTTPServer 8000
```

Then open your browser and go to `http://localhost:8000`

### Option 2: Use the Godot Engine's built-in HTTP server

- In the Godot editor, after exporting, click on the "HTML5" preset again
- Click on the "Run" button next to "Export Project"
- This will start a local web server and open your browser to play the game

### Option 3: Upload to a web hosting service

- Upload the contents of the export/html folder to any web hosting service
- The game will be playable at the URL provided by your hosting service

## Known Issues with HTML5 Export

- WebGL performance may vary between browsers
- Some keyboard inputs might behave differently in a browser context
- Audio may not play until the user interacts with the page (browser policy)
- Some browsers may block the game if run from a local file (use a web server as described above)

## Distributing Your Game

To share your HTML5 game with others:

1. Host the exported files on a web server
2. Share the URL with players

Popular free hosting options include:
- GitHub Pages
- Itch.io
- Netlify
- Vercel