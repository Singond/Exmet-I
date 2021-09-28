pkg load report
main

for e = experiment
	gp = gnuplotter();
	p1 = gp.newplot();
	p1.plot(e.freq, real(e.s), "with lines ls 2");
	p2 = gp.newplot();
	p2.plot(e.freq, imag(e.s), "with lines ls 1");
	gp.exec("set term epslatex size 16cm,10cm");
	gp.exec(sprintf("set output 'plots/%s.tex'", e.name));
	gp.multiplot(2,1);
	gp.load("real.gp");
	gp.doplot(p1);
	gp.load("imag.gp");
	gp.doplot(p2);
	clear gp;
endfor
