% M-file, mag_ fi e l d.m
% M-file t o ca l c ulate the net magnetic fi e l d produ ced
% by a three-pha se s tat o r.
% Set up the basi c con d itio n s
bmax = 1; % No rmalize bmax t o 1
freq = 120; % 60 Hz
w = 2* pi * freq; % a n g ular ve l oc ity (rad/ s )
% Firs t , generate the three component magnetic fi e l ds
t = 0:1/6000:1/60;
Baa = sin(w*t).*(cos(0) + j*sin(0));
Bbb = sin(w*t - 2*pi/3) .* (cos (2*pi/3) + j*sin(2*pi/3)) ;
Bcc = sin(w*t + 2*pi/3) .* (cos (- 2*pi /3) + j*sin(- 2*pi /3)) ;

%Ca l c ulate Bnet
Bnet = Baa + Bbb + Bcc;

% Ca l c ulate a c irc l e representing the expected maximum
% va lue o f Enet

circle = 1.5 * (cos(w*t) + j *sin(w*t)) ;

% Plo t the magnitude and d irection of the r esulting magne ti c
% fi e l ds. No te that Baa i s b l ack, Bbb i s b lue, Bcc i s
% magenta , and Enet i s red.

for ii = 1:length(t)
    %   Plo t the reference c irc l e
    plot(circle,'k') ;
    hold on;
    % Plo t the f o ur magneti c fi e l ds
    plot ([0 real(Baa(ii))] , [ 0 imag(Baa(ii))] , 'k', 'LineWidth' ,2);
    plot ([0 real(Bbb(ii))] , [ 0 imag(Bbb(ii))] , 'b' , 'LineWidth' ,2) ;
    plot([0 real(Bcc(ii))] , [ 0 imag(Bcc(ii))] , 'm' , 'LineWidth' ,2) ;
    plot ( [0 real(Bnet(ii))] , [ 0 imag(Bnet (ii)) ] ,'r' ,'LineWidth',3 ) ;
    axis square;
    axis( [ -2 2 -2 2 ] ) ;
    drawnow;
    hold off ;
end