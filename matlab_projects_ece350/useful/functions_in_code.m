
% time goes from 0 to 4 pi in steps of 0.01
time = 0:0.01:4*pi;
% height 
ampl = 3;
phas = pi/3;
% frequency
frex = 1;

% sine wave
waveS = ampl * sin(2 * pi * frex * time  + phas);

% cos wave
waveC = ampl * cos(2 * pi * frex * time  + phas);

% tan wave
waveT = ampl * tan(2 * pi * frex * time  + phas);

% plot
figure(1), clf
plot(time,waveT,'linew',3)
xlabel('Time (rad)');
ylabel('Amplitude');
set(gca,'xtick',0:pi/2:time(end),'fontsize',15)