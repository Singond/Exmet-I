## Copyright 2021 Radek Hornak, Jan Slany, Lukas Vrana

pkg load report
main

## Experiment 3
disp("Plotting results of experiment 3.");
plot_sparam(experiment(3).freq, s11_smamm, "results03", "s11");
plot_sparam(experiment(3).freq, s21_smamm, "results03", "s21");

## Experiment 4
disp("Plotting results of experiment 4.");
plot_sparam(experiment(4).freq, s11_bnc, "results04", "s11");
plot_sparam(experiment(4).freq, s21_bnc, "results04", "s21");

## Experiment 5
disp("Plotting results of experiment 5.");
plot_sparam(experiment(5).freq, s11_bncff, "results05", "s11");
plot_sparam(experiment(5).freq, s21_bncff, "results05", "s21");

## Experiment 8
disp("Plotting results of experiment 8.");
e = experiment(8);
gp = gnuplotter();
p1 = gp.newplot();
p1.plot(e.freq, mag2db(abs(e.s21)), "with lines ls 2 title 'naměřené hodnoty'");
p1.plot(e.freq, mag2db(abs(s21_8p)),
	"with lines ls 5 title 'teoreticky spočtené hodnoty'");
p2 = gp.newplot();
p2.plot(e.freq, rad2deg(arg(e.s21)), "with lines ls 1");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results08-s21.tex'");
gp.multiplot(2,1);
gp.load("gnuplot/real.gp");
gp.exec("set key bottom left inside height 1 reverse Left");
gp.exec("set ylabel '$|\\sparam_{21}|\\,[\\si{\\decibel}]$'");
gp.doplot(p1);
gp.load("gnuplot/imag.gp");
gp.exec("set key off");
gp.exec("set ylabel '$\\arg{\\sparam_{21}}\\,[\\si{\\degree}]$'");
gp.doplot(p2);
clear gp;

## Experiment 12
disp("Plotting results of experiment 12.");
gp = gnuplotter();
gp.load("gnuplot/results-12-z.gp");
gp.plot(experiment(12).freq, abs(z12), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results12-z.tex'");
gp.doplot();
clear gp;

gp = gnuplotter();
gp.load("gnuplot/results-12-l.gp");
gp.plot(experiment(12).freq, abs(L12), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results12-l.tex'");
gp.doplot();
clear gp;

## Experiment 13
disp("Plotting results of experiment 13.");
gp = gnuplotter();
gp.load("gnuplot/results-13-z.gp");
gp.plot(experiment(13).freq, abs(z13), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results13-z.tex'");
gp.doplot();
clear gp;

gp = gnuplotter();
gp.load("gnuplot/results-13-c.gp");
gp.plot(experiment(13).freq, abs(C13), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results13-c.tex'");
gp.doplot();
clear gp;

## Experiment 15
disp("Plotting results of experiment 15.");
gp = gnuplotter();
gp.load("gnuplot/results-15-z.gp");
gp.plot(experiment(15).freq, abs(z15), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results15-z.tex'");
gp.doplot();
clear gp;

## Experiment 16
disp("Plotting results of experiment 16.");
gp = gnuplotter();
gp.load("gnuplot/results-16-z.gp");
gp.plot(experiment(16).freq, abs(z16), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results16-z.tex'");
gp.doplot();
clear gp;
