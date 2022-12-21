# https://kb.synology.com/de-de/DSM/tutorial/How_to_back_up_Linux_computer_to_Synology_NAS
# Pictures
rsync -avh --progress /mnt/local/pictures user@192.168.178.60::pictures/User/

# https://askubuntu.com/questions/476041/how-do-i-make-rsync-delete-files-that-have-been-deleted-from-the-source-folder
# Documents
rsync -avh --progress --delete-before /mnt/local/documents user@192.168.178.60::homes/User/documents