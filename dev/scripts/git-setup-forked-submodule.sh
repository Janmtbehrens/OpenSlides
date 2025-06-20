# Creates a remote to given submodule.
# Call this from project root path
# Parameter #1 : abbreviated name of the submodule (eg. auth-service, backend, proxy, icc-service)
# Parameter #2 : name of your github fork repository
if [ -z $1 ]; then echo "Parameter #1 missing"; exit; fi
if [ -z $2 ]; then echo "Parameter #2 missing"; exit; fi

cd ./openslides-$1
git remote rename origin upstream
git remote add origin git@github.com:$2/openslides-$1.git
git fetch upstream
git remote -v
cd ..