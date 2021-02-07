echo "start deleting unnecessary files for clean up!"
ssh -l rash -i xserver.key rash.xsrv.jp -p 10022 -t "cd rash.xsrv.jp/public_html ; rm precache-manifest* ; rm -r static"
echo "end deleting unnecessary files for clean up!"

