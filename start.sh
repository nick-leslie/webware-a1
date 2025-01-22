
#I use this instead of start so that I can include the luseter app
# this is for dev only
rm -rf priv/static
cd gleam-app
echo building frontend
sh ./build.sh
mv -f priv ../../
cd ..
npm run start
#275cbb7fa401dbfd70d54eeeb3d67aadd8dee606