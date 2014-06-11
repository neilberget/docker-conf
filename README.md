Try it out
----------
bundle install

./update.sh


The shell script runs a ruby script that looks through all the subfolders, inspects the FROM: line in each Dockerfile and figures out the proper order to build all the images.

Then, it iterates through that list building each image.
