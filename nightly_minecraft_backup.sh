#!/bin/bash
SCREEN_NAME="minecraft"
MINECRAFT_DIR="/usr/forge/world"
BACKUP_DIR="/usr/forge/backups"

if screen -list | grep -q "$SCREEN_NAME"; then
	echo Sending stop command...
	screen -S $SCREEN_NAME -p 0 -X stuff "stop^M"
	echo Waiting for server to stop...
	sleep 5
	TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
	echo "Backing up world to $BACKUP_DIR/minecraft-backup-$TIMESTAMP.tar.gz"
	tar -czvf $BACKUP_DIR/minecraft-backup-$TIMESTAMP.tar.gz $MINECRAFT_DIR
	echo Starting server again...
	/usr/forge_1.20.1/start_minecraft_server.sh # screen -dmS minecraft bash run.sh
else
    echo "Minecraft screen session not found. Backup aborted."
fi