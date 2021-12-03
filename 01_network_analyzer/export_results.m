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

## Experiment 12
disp("Plotting results of experiment 12.");
gp = gnuplotter();
gp.load("results-12-z.gp");
gp.plot(experiment(12).freq, abs(z), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results12-z.tex'");
gp.doplot();
clear gp;

gp = gnuplotter();
gp.load("results-12-l.gp");
gp.plot(experiment(12).freq, abs(L), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results12-l.tex'");
gp.doplot();
clear gp;

## Experiment 13
disp("Plotting results of experiment 13.");
gp = gnuplotter();
gp.load("results-13-z.gp");
gp.plot(experiment(13).freq, abs(z), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results13-z.tex'");
gp.doplot();
clear gp;

gp = gnuplotter();
gp.load("results-13-c.gp");
gp.plot(experiment(13).freq, abs(C), "with lines ls 2");
gp.exec("set term epslatex size 16cm,10cm");
gp.exec("set output 'plots/results13-c.tex'");
gp.doplot();
clear gp;