load_data

## Produce a spatio-temporal slice of the video
## by averaging a central slice of each image
## and putting the averages from each frame next to each other.
m = mean(img(:,300:600,:), 2);
m = squeeze(m);    # Remove the singleton dimension
## Scale in the horizontal direction for better visibility.
xscale = 40;
yscale = 1;
stslice = repelem(m, yscale, xscale);
