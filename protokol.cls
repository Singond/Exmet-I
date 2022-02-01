% Sablona pro protokoly z fyzikalniho praktika.
% Verze pro: LaTeX
% Verze hlavicky: 22. 2. 2007
% Autor: Ustav fyziky kondenzovanych latek
% Uprava: Jan Slany <slanyj@centrum.cz>
% Vychozi soubor ke stazeni: www.physics.muni.cz/ufkl/Vyuka/
% Licence: volne k pouziti, nejlepe k vcasnemu odevzdani protokolu z Vaseho mereni.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{protokol}[2018/03/14 Protokol fyzikalniho praktika]
\PassOptionsToClass{a4paper}{article}
\PassOptionsToClass{11pt}{article}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}
\usepackage[margin=2cm]{geometry}
\usepackage[utf8]{inputenc}
\usepackage{xstring}
\usepackage{tabularx}

% Sloupce pro zarovnani na desetinnem oddelovaci v tabulkach.
% Zaroven prepisuji desetinny oddelovac na carku.
\usepackage{dcolumn}
\newcolumntype{d}[1]{D{.}{,}{#1}}  % Ve zdrojaku je oddelovacem tecka
\newcolumntype{e}[1]{D{,}{,}{#1}}  % Ve zdrojaku je oddelovacem carka
\newcolumntype{g}[1]{D{.}{.}{#1}}  % Ve zdrojaku je oddelovacem tecka
\newcommand{\coltext}[1]{\multicolumn{1}{c}{#1}}    % Text ve sloupci
\newcommand{\coltextm}[1]{\multicolumn{1}{c}{$#1$}} % Matem. vyraz ve sloupci

% Nastaveni baliku pro kresleni elektrickych obvodu
\PassOptionsToPackage{european, cuteinductors}{circuitikz}

% Parametry
\newtoks\jmenopraktika
\newtoks\jmeno
\newtoks\datum
\newtoks\obor
\newtoks\skupina
\newtoks\rocnik
\newtoks\semestr
\newtoks\cisloulohy
\newtoks\jmenoulohy
\newtoks\tlak
\newtoks\teplota
\newtoks\vlhkost

% Zamezeni parchantu:
\widowpenalty 10000
\clubpenalty 10000
\displaywidowpenalty 10000

% Parametry pro moznost vsazeni vetsiho poctu obrazku na stranku
\setcounter{topnumber}{3}	      % max. pocet floatu nahore (specifikace t)
\setcounter{bottomnumber}{3}	  % max. pocet floatu dole (specifikace b)
\setcounter{totalnumber}{6}	      % max. pocet floatu na strance celkem
\renewcommand\topfraction{0.9}	  % max podil stranky pro floaty nahore
\renewcommand\bottomfraction{0.9} % max podil stranky pro floaty dole
\renewcommand\textfraction{0.1}	  % min podil stranky, ktery musi obsahovat text
\intextsep=8mm \textfloatsep=8mm  %\intextsep pro ulozeni [h] floatu a \textfloatsep pro [b] or [t]

% Format nadpisu sekci: cislo zakoncene teckou, jednopismenna mezera a nazev
\def\@seccntformat#1{\csname the#1\endcsname.\hspace{1ex}}

% Nasobeni
\newcommand{\tims}{\cdot}
% Exponencialni zapis cisel
\newcommand{\E}[1]{\tims 10^{#1}}
% Matematicke konstanty
\newcommand{\e}{\mathrm{e}}       % Eulerovo cislo
\newcommand{\im}{\mathrm{i}}      % imaginarni jednotka
% Vektory
\newcommand{\vect}[1]{\boldsymbol{#1}}
% Nejistoty velicin
\newcommand{\erabs}[1]{u(#1)}
\newcommand{\erabsa}[1]{u_A(#1)}
\newcommand{\erabsb}[1]{u_B(#1)}
\newcommand{\errel}[1]{r(#1)}
\newcommand{\mean}[1]{\bar{#1}}
\newcommand{\stddev}[1]{s(#1)}
\newcommand{\stderr}[1]{s(\bar{#1})}
% Tangens
\newcommand{\tg}{\mathrm{tg}}
\newcommand{\arctg}{\mathrm{arctg}}

% Definice pojmu
\newcommand{\term}[1]{{\textit{#1}}}

% Hlavicka protokolu
\newcommand{\header}{
	\thispagestyle{empty}
	\begin{center}
		\sf
		{\Large Ústav fyzikální elektroniky Přírodovědecké fakulty Masarykovy univerzity} \\
		\bigskip
		{\huge \bfseries FYZIKÁLNÍ PRAKTIKUM} \\
		\bigskip
		{\Large \the\jmenopraktika}
	\end{center}
	\smallskip
	\begin{center}
		\sf
		\noindent
		\begin{tabularx}{\textwidth}{@{}XXX@{}}
			\multicolumn{2}{@{}l@{}}{\large {\bfseries
				\IfSubStr{\the\jmeno}{,}{Zpracovali:}{Zpracoval:}} \the\jmeno} &
			\large {\bfseries Naměřeno:} \the\datum
			\\ [0.5em]
			\large {\bfseries Obor:} \the\obor &
			\large {\bfseries Skupina:} \the\skupina &
			\large {\bfseries Testováno:}
			\\ [0.5em] \hline
		\end{tabularx}
	\end{center}
	\bigskip
	{
		\sf
		\noindent \begin{tabular}{p{3cm} p{0.6\textwidth}}
			\Large  Úloha č. {\bfseries \the\cisloulohy:}
			\IfStrEq{\the\teplota\the\tlak\the\vlhkost}{}{}{\par \smallskip}
			\IfStrEq{\the\teplota}{}{}{$T=\the\teplota$~$^\circ$C \par}
			\IfStrEq{\the\tlak}{}{}{$p=\the\tlak$~hPa \par}
			\IfStrEq{\the\vlhkost}{}{}{$\varphi=\the\vlhkost$~\%}
			&\Large \bfseries \the\jmenoulohy  \\
		\end{tabular}
	}
	\vskip1cm
}
% Header without environmental conditions.
% Deprecated, because the default header can now achieve the same results.
\newcommand{\headernoenv}{\header}
\newcommand{\headerennoenv}{
	\thispagestyle{empty}
	\begin{center}
		\sf
		{\Large Department of Physical Electronics at the Faculty of Science, Masaryk University} \\
		\bigskip
		{\huge \bfseries PHYSICS LABORATORY} \\
		\bigskip
		{\Large \the\jmenopraktika}
	\end{center}
	\smallskip
	\begin{center}
		\sf
		\noindent
		\begin{tabularx}{\textwidth}{@{}XXX@{}}
			\multicolumn{2}{@{}l@{}}{\large {\bfseries \IfSubStr{\the\jmeno}{,}{Students:}{Student:}} \the\jmeno} &
			\large {\bfseries Measured at:} \the\datum
			\\ [0.5em]
			\large {\bfseries Programme:} \the\obor &
			\large {\bfseries Class:} \the\skupina &
			\large {\bfseries Tested at:}
			\\ [0.5em] \hline
		\end{tabularx}
	\end{center}
	\bigskip
	{
		\sf \noindent
		\begin{tabular}{p{3cm} p{0.6\textwidth}}
			\Large  Task {\bfseries \the\cisloulohy:} &
			\Large \bfseries \the\jmenoulohy \\
		\end{tabular}
	}
	\vskip1cm
}
\title{\the\jmenoulohy}
\author{\the\jmeno}
