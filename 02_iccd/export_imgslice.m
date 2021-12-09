imgslice;

minval = min(stslice(:));
maxval = max(stslice(:));
if (!isfolder("results"))
	mkdir("results")
endif
imwrite((stslice - minval) ./ (maxval - minval), "results/slice.png");
