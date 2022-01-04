## Copyright 2021 Radek Hornak, Jan Slany, Lukas Vrana

## Plot the modulus and argument of a scattering parameter s.
function plot_sparam(freq, s, name, elem)
	pkg load report;
	gp = gnuplotter();
	p1 = gp.newplot();
	p1.plot(freq, mag2db(abs(s)), "with lines ls 2");
	p2 = gp.newplot();
	p2.plot(freq, rad2deg(arg(s)), "with lines ls 1");
	gp.exec("set term epslatex size 16cm,10cm");
	gp.exec(sprintf("set output 'plots/%s.tex'", [name "-" elem]));
	gp.multiplot(2,1);
	gp.load("gnuplot/real.gp");
	if (strcmp(elem, "s11"))
		gp.exec("set ylabel '$|\\sparam_{11}|\\,[\\si{\\decibel}]$'");
	elseif (strcmp(elem, "s21"))
		gp.exec("set ylabel '$|\\sparam_{21}|\\,[\\si{\\decibel}]$'");
	endif
	gp.doplot(p1);
	gp.load("gnuplot/imag.gp");
	if (strcmp(elem, "s11"))
		gp.exec("set ylabel '$\\arg{\\sparam_{11}}\\,[\\si{\\degree}]$'");
	elseif (strcmp(elem, "s21"))
		gp.exec("set ylabel '$\\arg{\\sparam_{21}}\\,[\\si{\\degree}]$'");
	end
	gp.doplot(p2);
	clear gp;
endfunction
