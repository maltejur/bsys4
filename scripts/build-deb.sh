
set -e

mv -v librewolf lwdist

mkdir -p librewolf/DEBIAN
cd librewolf/DEBIAN
 cat <<EOF > control
Architecture: all
Build-Depends: inkscape, librsvg2-bin
Depends: libc6, libgcc1, libstdc++6, wget
Description: The Librewolf Browser
Download-Size: 56.0 MB
Essential: no
Installed-Size: 204 MB
Maintainer: Bert van der Weerd <bert@stanzabird.nl>
Package: librewolf
Priority: optional
Provides: gnome-www-browser, www-browser, x-www-browser
Section: web
EOF
 echo "Version: $1-$2" >> control
cd ..

mkdir -p usr/share/librewolf
mv -v ../lwdist/* usr/share/librewolf
rmdir ../lwdist

mkdir -p usr/bin
cd usr/bin
ln -vs ../share/librewolf/librewolf
cd ../..

# add the application icon
mkdir -p usr/share/applications
mkdir -p usr/share/icons
cp -v usr/share/librewolf/browser/chrome/icons/default/default64.png usr/share/icons/librewolf.png
cp -v ../register-librewolf ../start-librewolf ../start-librewolf.desktop usr/share/librewolf
chmod +x usr/share/librewolf/register-librewolf usr/share/librewolf/start-librewolf
cp -v ../start-librewolf.desktop usr/share/applications

cd ..
dpkg-deb --build librewolf

echo ""
ls -lh librewolf.deb
exit 0


