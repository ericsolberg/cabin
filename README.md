# GetStream.io React Tutorial
This is an attempt to make the [GetStream React Tutorial](https://getstream.io/cabin/) to work. I was having difficulty making it work on my Mac, with many version conflicts so I decided to use a Docker container to have a clean, repeatable environment.

Even with the clean Docker set, I still had numerous problems. I had to figure out the version dependencies of the tutorial through trial and error. After working through, everything installs and builds cleanly, but the tutorial starting code still doesn't run. Initially, I just got an empty white browser screen when I launched the browser to the app. After changing the versions of some React components, based on a response to this issue on the tutorial Github page, I now have a background image and some text, but it doesn't seem the full app is working yet.

I'm posting this here in case others will find it useful and perhaps someone may help get this working.

Note that the Dockerfile includes the secret key for my Getstream tutorial project. Of course, you should use your own (it's free). When I'm done with it I'll delete that project.
## Steps to run
### Clone this project
`git clone https://github.com/ericsolberg/cabin.git
cd cabin`
### Get the Cabin tutorial code
The cabin code isn't included in this repository (it is excluded in the .gitignore). Fetch it from Github:

`mkdir src
git clone https://github.com/GetStream/stream-react-example src/`
### Build the Docker container
`docker build -t cabin`
### Launch and build the tutorial
Open three terminal windows.

In the first window we'll launch the container interactively (so we can work inside the container). The cabin source code will be mapped to a directory inside the container. You can edit the files outside of the container using whatever editor you want to use, and the edits will appear in the container.

In Terminal 1:

`docker run --name "cabin" -p 3000:3000 -v $(pwd)/src:/app/src -it cabin
\# You're now inside the container at /app/src
cd api
npm install
cd ../app
npm install
\# This step comes from this issue:

\# https://github.com/GetStream/stream-react-example/issues/42

npm install react@15.6.2 react-dom@15.6.2 react-router@3.2.0

cd ../api

node index.js`

In Terminal 2:

`docker exec -it cabin /bin/bash

\# You're now inside the container at /app/src

cd app

webpack --watch --progress`

In Terminal 3:

`docker exec -it cabin /bin/bash

\# You're now inside the container at /app/src

cd app

npm start`

Now launch your browser to htpp://localhost:3000

You can Ctrl-C in Terminal 1, then type exit to shut down the container. You should then clean up the leftover image with:

`docker rm cabin`

The install/build changes should be persistent in the src directory, so if re-run the container you should be able to go straight to running the api/webpack and app.
