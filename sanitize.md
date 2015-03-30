# Unix Shell Scripts and Tools
## Sanitize
Sanitize is a perl script to sanitize filenames. Allowed characters are alphanumeric uppers and lowers, ".", "-", "_" and "/". You can edit this to what everyou need. This was designed to fix bad filenames uploaded by users when using ownCloud.
### Setup

#### Console
```
cd /etc && mkdir scripts && touch sanatize && nano sanatize
```
Paste the content of the contents of the sanitize file to nano, save then exit.
```
chmod ugoa+x /etc/scripts/sanitize
```
Make executable for all

#### SFTP
SFTP as root and go to /etc, create a dir called scripts and drag the sanatize file into the scripts dir

### Usage
#### Single File
1. Move to the target location
```
cd /to/your/bad/filename/directory/location
```
2. Sanitize the correct file
```
perl /etc/scripts/sanitize file.name
```
3. Combined methiod
```
cd /to/your/bad/filename/directory/location && perl /etc/scripts/sanitize file.name
```

#### Multiple Files
1. Move to the target location
```
cd /to/your/bad/filename/directory/location
```
2. Find all file in the current location and sanitize
```
find . -type f -print0 | xargs -0 perl /etc/scripts/sanitize
```
3. Combined Method
```
cd /to/your/bad/filename/directory/location && find . -type f -print0 | xargs -0 perl /etc/scripts/sanitize
```

#### OwnCloud Complete File Sanitize
Example.
```
cd /home/files/public_html/data/ && find . -type f -print0 | xargs -0 perl /etc/scripts/sanitize && cd /home/files/public_html && sudo -u files php console.php files:scan --all
```

### Links
1. http://www.karakas-online.de/forum/viewtopic.php?t=10430