main

## Plot the data for each experiment.
axes_config = {"tickdir", "in"};
line_config = {"linewidth", 0.5};
for e = experiment
	figure;
	clf;
	## Real part
	h1 = axes('position', [0.05, 0.5, 0.9, 0.45], "xticklabel", "");
	semilogx(e.freq, real(e.s), line_config{:});
	set(h1, axes_config{:});
	title(e.name);
	xticklabels({})
	ylabel("Re(s) [db]");
	grid off;
	# Imaginary part
	h2 = axes('position', [0.05, 0.05, 0.9, 0.45]);
	semilogx(e.freq, imag(e.s), "r", line_config{:});
	set(h2, axes_config{:});
	xlabel("frekvence f [Hz]");
	ylabel("Im(s) [deg]");
	yticks(-180:90:180);
	grid off;
endfor