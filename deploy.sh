#!/bin/bash
rsync --exclude=".git" -avz --progress ./ cogtree@pixelmonkey.org:/data/vhosts/pixelmonkey.org/pub/rapid-web-slides
