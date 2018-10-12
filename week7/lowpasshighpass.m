% ECE 350 Matlab Assignment M-5
% Name: Carlos Benavides
% In collaboration with: Arnold Ortega

clear all
format compact

% define sysmbolic variables that will be used.
syms s t Chp Clp Rhp Rlp H(s) hpOrder lpOrder

% impedance High Pass
zHP = Rhp/((1/(Chp*s))+ Rhp);

% impedeance low pass
zLP =(1/(Clp*s)) /( (1/(Clp*s))+ Rlp);

H(s) = (zHP^hpOrder)*(zLP^lpOrder);
H(s) = simplify(H(s));
H(s) = expand(H(s));

% Define dialog properties
prompt = {
            'Enter value for e to the power for startFreq ',
            'Enter value for e to the power for stopFreq',
            'Enter coefficient of hpOrder',
            'Enter coefficient of Rhp',
            'Enter coefficient of Chp (pico wise operation)',
            'Enter coefficient of lpOrder',
            'Enter coefficient of Rlp',
            'Enter coefficient of Clp (pico wise operation)'
        };
title               = 'MatLab Assignment 5';
opts.Resize         = 'on'
opts.WindowStyle    = 'normal'
answer              = inputdlg(prompt,title)

% use power to mimic 1e10
% because can't use 1estr2num(answer{1})
startFreq   = power(10,str2double(answer{1}))
stopFreq    = power(10,str2double(answer{2}))

% highpass properties
hpOrder     = str2double(answer{3})
Rhp         = str2double(answer{4})
Chp         = str2double(answer{5})*power(10,-6)%pico wise operation

% low pass properties
lpOrder     = str2double(answer{6})
Rlp         = str2double(answer{7})
Clp         = str2double(answer{8})*power(10,-6)%pico wise operation

% Give H(s) the symbolic function to use
H(s) = subs(H(s))

% our for loop count
nSteps = 400;
dLog = (log10(stopFreq)-log10(startFreq))/nSteps;


freq(1) = startFreq
for fCount = 1: nSteps
    w = j*freq(fCount)*2*pi;
    Hval = subs(H(s),w);
    Hval = eval(Hval);
    magH(fCount) = norm(Hval);
    angH(fCount) = angle(Hval)*180/pi;
    
    if(fCount<nSteps)&& (freq(fCount)<stopFreq)
        logNextFreq = log10(freq(fCount))+ dLog;
        freq(fCount+1) = 10^logNextFreq;
    end 
end

maxMag = max(magH);
magH = magH/maxMag;

figure()
subplot(2,1,1)
semilogx(freq,20*log10(magH))
clear title
title(['Order,R,C HP:[',num2str(hpOrder),'; ',num2str(Rhp),...
    '; ',num2str(Chp),']  LP:[',num2str(lpOrder),...
    '; ',num2str(Rlp),'; ',num2str(Clp),']']);   
ylim([-40 5])
xlim([startFreq stopFreq]);
ylabel('Gain (dB)');
grid on
subplot(2,1,2)
semilogx(freq,angH)
grid on
xlabel('Frequency (Hz)');
ylabel('Phase (Deg)');
xlim([startFreq stopFreq]);
