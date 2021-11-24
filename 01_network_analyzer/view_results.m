main

## Plot the data for each experiment.
function view_sparam(freq, s, name, elem)
	axes_config = {"tickdir", "in"};
	line_config = {"linewidth", 0.5};

	figure;
	clf;
	## Real part
	h1 = axes('position', [0.05, 0.5, 0.9, 0.45], "xticklabel", "");
	semilogx(freq, real(s), line_config{:});
	set(h1, axes_config{:});
	title(name);
	xticklabels({})
	ylabel("Re(s) [db]");
	grid off;
	# Imaginary part
	h2 = axes('position', [0.05, 0.05, 0.9, 0.45]);
	semilogx(freq, imag(s), "r", line_config{:});
	set(h2, axes_config{:});
	xlabel("frekvence f [Hz]");
	ylabel(sprintf("Im(%s) [deg]", elem));
	yticks(-180:90:180);
	grid off;
endfunction

for e = experiment
	if (!isempty(e.s11))
		view_sparam(e.freq, e.s11, e.name, "s11");
	end
	if (!isempty(e.s21))
		view_sparam(e.freq, e.s21, e.name, "s21");
	end
endfor
