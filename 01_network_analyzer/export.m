pkg load report
main

function plot_sparams(freq, s, name, elem)
	gp = gnuplotter();
	p1 = gp.newplot();
	p1.plot(freq, real(s), "with lines ls 2");
	p2 = gp.newplot();
	p2.plot(freq, imag(s), "with lines ls 1");
	gp.exec("set term epslatex size 16cm,10cm");
	gp.exec(sprintf("set output 'plots/%s.tex'", [name "-" elem]));
	gp.multiplot(2,1);
	gp.load("real.gp");
	if (strcmp(elem, "s11"))
		gp.exec("set ylabel '$\\Re(\\sparam_{11})\\,[\\si{\\decibel}]$'");
	elseif (strcmp(elem, "s21"))
		gp.exec("set ylabel '$\\Re(\\sparam_{21})\\,[\\si{\\decibel}]$'");
	endif
	gp.doplot(p1);
	gp.load("imag.gp");
	if (strcmp(elem, "s11"))
		gp.exec("set ylabel '$\\Im(\\sparam_{11})\\,[\\si{\\degree}]$'");
	elseif (strcmp(elem, "s21"))
		gp.exec("set ylabel '$\\Im(\\sparam_{21})\\,[\\si{\\degree}]$'");
	end
	gp.doplot(p2);
	clear gp;
endfunction

for e = experiment
	printf("Plotting experiment %s.\n", e.name);
	if (!isempty(e.s11))
		plot_sparams(e.freq, e.s11, e.name, "s11");
	end
	if (!isempty(e.s21))
		plot_sparams(e.freq, e.s21, e.name, "s21");
	end
endfor
