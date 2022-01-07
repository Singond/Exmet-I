FROM texlive/texlive

RUN apt-get update \
	&& apt-get install -y octave \
	&& octave --eval 'pkg install https://github.com/Singond/Octave-report/releases/download/v0.5.0/report-0.5.0.tar.gz' \
	&& octave --eval 'pkg install https://github.com/Singond/Octave-extensions/releases/download/v0.1.2/singon-ext-0.1.2.tar.gz'
