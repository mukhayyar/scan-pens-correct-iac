## PENS/EEPIS Captive Portal Discovery Scripts

These scripts are designed to help students and staff at PENS (Politeknik Elektronika Negeri Surabaya) identify the correct active captive portal node (IAC) for their current network segment.

Sometimes, the network may route you to a specific internal node (e.g., iac22, iac14) based on your IP class, but the default redirect might fail. These scripts scan the range iac1 to iac30 to find which server actually responds.

### Prerequisites

- Internet Connection: You must be connected to the campus network (WiFi or LAN).
- Curl: These scripts rely on curl, which is pre-installed on macOS, Linux, and Windows 10/11.

Usage

🖥️ Windows
1. Download or create the file check.bat.
2. Double-click the file to run it.
3. Alternatively, open Command Prompt (cmd) in the folder and type:

```
.\check.bat
```

Note: If you see a "Windows protected your PC" popup, click "More info" and then "Run anyway." This happens because it is a custom script not signed by Microsoft.

🍎 macOS / 🐧 Linux
1. Download or create the file check.sh.
2. Open your terminal.
3. Make the script executable:
```
chmod +x check.sh
```
4. Run the script:
```
./check.sh
```

### Understanding the Output

- . (Dot): The script is currently checking a node that is unreachable or inactive.
- [+] FOUND ACTIVE PORTAL: The script found a working server.
    - It will display the specific URL (e.g., https://iac14.pens.ac.id:8003...).
    - Copy and paste this URL into your browser to access the login page.

### Configuration

If you need to change the range of nodes scanned (default is 1-30), edit the script file in any text editor (Notepad, TextEdit, VS Code) and change these variables:

```
# Example change to scan up to 50
set END=50  # (Windows)
END=50      # (macOS/Linux)
```

### Troubleshooting

- "System cannot find the drive specified" (Windows): This issue has been patched in the latest version of the script. Ensure you are using the version that writes to a temporary file.

- Permission Denied (macOS/Linux): Ensure you ran the chmod +x command listed in the usage steps.

Disclaimer

These scripts are for diagnostic and troubleshooting purposes to assist in legitimate network connectivity. They do not bypass authentication; they simply locate the correct login page.
