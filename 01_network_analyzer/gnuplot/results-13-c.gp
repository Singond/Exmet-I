# Copyright 2021 Radek Hornak, Jan Slany, Lukas Vrana

load "../plotsettings.gp"
set log
set border 15
set xtics in mirror
set ytics in mirror
set xtics ('$10^4$' 1e4+1, '$10^5$' 1e5, '$10^6$' 1e6, '$10^7$' 1e7, '$10^8$' 1e8, '$10^9$' 1e9, '$10^{10}$' 1e10)
set ytics ('$10^{-13}$' 1e-13, '$10^{-12}$' 1e-12, '$10^{-11}$' 1e-11, '$10^{-10}$' 1e-10, '$10^{-9}$' 1e-9, '$10^{-8}$' 0.999e-8)
set xlabel '$\freq\,[\si{\hertz}]$'
set ylabel '$\capacitance\,[\si{\farad}]$'
set key off
