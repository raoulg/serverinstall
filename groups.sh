#!/bin/bash
sudo groupadd collaborators
sudo mkdir -p /srv/shared
sudo chgrp collaborators /srv/shared
sudo chmod g+rws,o-w /srv/shared
echo "run: sudo usermod -aG collaborators another_user"
echo "replace 'another_user' with the actual username to add to the collaborators group."
