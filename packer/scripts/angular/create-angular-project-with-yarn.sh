export DIR_PATH_X_NG_PROJECT=${1}
export ANGULAR_PROJECT_NAME=${2}
export GIT_REPO_URL=${3}

echo ""
echo ""
echo "Move into the directory ${DIR_PATH_X_NG_PROJECT} ..."
cd ${DIR_PATH_X_NG_PROJECT}

echo ""
echo ""
echo "Show th Angular CLI version ..."
ng -v

echo ""
echo ""
echo "Create the angular project: ${ANGULAR_PROJECT_NAME}"

ng new ${ANGULAR_PROJECT_NAME}

cd ${ANGULAR_PROJECT_NAME}

echo ""
echo ""
echo "Add Material Design Libraries"
yarn add @angular/material @angular/cdk @angular/animations

echo ""
echo ""
echo "Configure project with Material Design libraries ..."
ng add @angular/material

echo ""
echo ""
echo "Add Angular Flex-Layout library"
yarn add @angular/flex-layout

echo ""
echo ""
echo "Add Firebase & Angularfire2"
yarn add angularfire2 firebase

echo "------------------------------------------------------------"
echo ""
echo ""
echo "Configure the git repo ..."
git remote add origin ${GIT_REPO_URL}

echo ""
echo ""
echo "Add the project file to the git repo ..."
git add .

echo ""
echo ""
echo "Commit locally the changes to the git repo ..."
git commit -m "Project initialization & First Import"

echo ""
echo ""
echo "Push to the Git repo server ${GIT_REPO_URL} ..."
git push -u origin master

echo ""
echo ""
echo "To visualize the project locally in your browser launch the following command:  ng serve --host 0.0.0.0"