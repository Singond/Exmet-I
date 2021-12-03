pkg load report
addpath octave

load_data

for e = experiment
	printf("Plotting data for experiment %s.\n", e.name);
	if (!isempty(e.s11))
		plot_sparam(e.freq, e.s11, e.name, "s11");
	end
	if (!isempty(e.s21))
		plot_sparam(e.freq, e.s21, e.name, "s21");
	end
endfor
