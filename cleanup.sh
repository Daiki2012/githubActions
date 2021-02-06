echo "start deleting unnecessary files for clean up"
shopt -s extglob
rm !(".htaccess"|".user.ini"|"config.php"|"create.php"|"updateOrderToBePaid.php"|"cleanup.sh")
rm -r static
echo "end deleting unnecessary files for clean up"

