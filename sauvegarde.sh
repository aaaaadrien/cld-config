#! /bin/bash

# On se positionne au bon endroit"
path=`dirname $0`
cd "$path"

# On défini les variables
#gitrepo="git@github.com:aaaaadrien/cld-config.git"
package="etc/portage/package."
jour=$(date +"%d-%m-%Y")
heure=$(date +"%H:%M:%S")

# Début du script

for fic in "use" "accept_keywords" "mask" "unmask" "env"
do
	chemin="etc/portage/package.$fic/"
	if [ -f "/$chemin/custom" ]
	then
		echo "On sauvegarde le fichier package.$fic ..."
		
		if [ -d $chemin ]
		then
			cp "/$chemin/custom" "$chemin/custom"
		else
			mkdir -p "$chemin"
			cp "/$chemin/custom" "$chemin/custom"
		fi
	fi
done

chemin="etc/portage/make.conf/"
if [ -f "/$chemin/custom" ]
then
        echo "On sauvegarde le make.conf customisé..."
        if [ -d $chemin ]
        then
                cp "/$chemin/custom" "$chemin/custom"
        else
                mkdir -p "$chemin"
                cp "/$chemin/custom" "$chemin/custom"
        fi
fi

chemin="etc/portage/env/"
if [ -d "/$chemin" ]
then
        echo "On sauvegarde le env customisé..."
        if [ -d $chemin ]
        then
                rsync -avzh "/$chemin/" "$chemin/"
        else
                mkdir -p "$chemin"
                rsync -avzh "/$chemin/" "$chemin/"
        fi
fi



chemin="var/lib/portage/"
if [ -f "/$chemin/world" ]
then
	echo "On sauvegarde la liste des applications installées..."
	if [ -d $chemin ]
	then
		cp "/$chemin/world" "$chemin/world"
	else
		mkdir -p "$chemin"
		cp "/$chemin/world" "$chemin/world"
	fi
fi


chemin="var/lib/calculate/" 
if [ -f "/$chemin/calculate.env" ]
then
        echo "On sauvegarde les préférences du système calculate..." 
	if [ -d $chemin ]
	then
		cp "/$chemin/calculate.env" "$chemin/calculate.env"
	else
		mkdir -p "$chemin"
		cp "/$chemin/calculate.env" "$chemin/calculate.env"
	fi
fi

chemin="usr/src/linux/"
fic=".config"
if [ -f "/$chemin/$fic" ]
then
	echo "On sauvegarde la conf kernel..."
	if [ -f $chemin/$fic ]
	then
		cp "/$chemin/$fic" "$chemin/$fic"
	else
		mkdir -p "$chemin"
		cp "/$chemin/$fic" "$chemin/$fic"
	fi
fi

git add *
git commit -m "Mise à jour de la configutaion le $jour à $heure"
git push 
