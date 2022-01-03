set -e

# install wasi
rm -f setup-wasi-linux.sh
wget "https://gitlab.com/librewolf-community/browser/source/-/raw/main/scripts/setup-wasi-linux.sh"
chmod +x setup-wasi-linux.sh
bash setup-wasi-linux.sh

# normal bootstrapping
cd /mozilla-unified
./mach --no-interactive bootstrap --application-choice=browser

# adding some python packages
pip install testresources pycairo

exit 0


