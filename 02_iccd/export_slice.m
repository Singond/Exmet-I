slice;

maxval = max(stslice(:));
if (!isfolder("results"))
	mkdir("results")
endif
imwrite(stslice ./ maxval, "results/slice.png");
