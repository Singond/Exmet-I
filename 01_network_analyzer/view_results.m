## Copyright 2021 Radek Hornak, Jan Slany, Lukas Vrana

main

## Plot the data for each experiment.
function view_sparam(freq, s, name, elem)
	axes_config = {"tickdir", "in"};
	line_config = {"linewidth", 0.5};

	figure;
	clf;
	## Real part
	h1 = axes('position', [0.05, 0.5, 0.9, 0.45], "xticklabel", "");
	semilogx(freq, mag2db(abs(s)), line_config{:});
	set(h1, axes_config{:});
	title(name);
	xticklabels({})
	ylabel(sprintf("|%s| [dB]", elem));
	grid off;
	# Imaginary part
	h2 = axes('position', [0.05, 0.05, 0.9, 0.45]);
	semilogx(freq, rad2deg(arg(s)), "r", line_config{:});
	set(h2, axes_config{:});
	xlabel("frekvence f [Hz]");
	ylabel(sprintf("arg(%s) [deg]", elem));
	yticks(-180:90:180);
	grid off;
endfunction

function view_sparame(ex)
	if (!isempty(ex.s11))
		view_sparam(ex.freq, ex.s11, ex.name, "s11");
	end
	if (!isempty(ex.s21))
		view_sparam(ex.freq, ex.s21, ex.name, "s21");
	end
endfunction

for e = experiment
	view_sparame(e);
endfor
