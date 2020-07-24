# base image, alpine is small & compact with basic program for effiency
FROM node:alpine

# Specifying work directory '/usr/app' inside container to copy 
# & install dependencies inside the container.
# Note - if work dir don't exists, docker containers creates one automatically in the root dir
WORKDIR '/usr/app'
# Add package.json before npm install to avoid installing or not rerun 'npm install' again, which saves time & 
# rebuilding the image again & again to reflect changes in our source files.
# First copy package.json file in the workdir, then, run npm install,
# after installing all our dependencies, copy all other files.
# NOTE: The only time npm will get execute again is if we make a change to package.json file & any steps above it on top.
COPY ./package.json ./
RUN npm install
# after copying package.json, copy all files from the current work dir to inside the container
# anytime we update our source files now, only these files will be updated, steps above get cached from before installation
COPY ./ ./

# CMD is command to tell image to run a container - our app
CMD ["npm", "run", "start"]
