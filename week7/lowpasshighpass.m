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
H(s) = simplify(H(s));%simplify the equation
H(s) = expand(H(s));% give the extended solution

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
nSteps = 400;% our for loop count
dLog = (log10(stopFreq)-log10(startFreq))/nSteps;
% log the freq of user input, divded by the for loop max

freq(1) = startFreq%start of solution
for fCount = 1: nSteps
    w = j*freq(fCount)*2*pi;% frequency
    Hval = subs(H(s),w);% replace s variables with w
    Hval = eval(Hval);% evaulate 
    magH(fCount) = norm(Hval); % vector magnitude
    angH(fCount) = angle(Hval)*180/pi;% angle to radians
    
    if(fCount<nSteps)&& (freq(fCount)<stopFreq)
        logNextFreq = log10(freq(fCount))+ dLog;% update logNextFreq
        freq(fCount+1) = 10^logNextFreq;% add to vector of solution
    end 
end

maxMag = max(magH);% return max values from vector
magH = magH/maxMag;% calculate magH

figure()
% create gain plot
subplot(2,1,1)
semilogx(freq,20*log10(magH))%log x axis
clear title
title(['Order,R,C HP:[',num2str(hpOrder),'; ',num2str(Rhp),...
    '; ',num2str(Chp),']  LP:[',num2str(lpOrder),...
    '; ',num2str(Rlp),'; ',num2str(Clp),']']);   
ylim([-40 5])
xlim([startFreq stopFreq]);
ylabel('Gain (dB)');
grid on

% create phase plot
subplot(2,1,2)
semilogx(freq,angH)% log x axis
grid on
xlabel('Frequency (Hz)');
ylabel('Phase (Deg)');
xlim([startFreq stopFreq]);
