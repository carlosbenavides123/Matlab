%file name: bpf.m
%Last modified by David Schwartz on 10/10/2018
clear all
format compact

syms s t Chp Clp Rhp Rlp H(s) hpOrder lpOrder

zHP = Rhp/((1/(Chp*s))+ Rhp);
zLP =(1/(Clp*s)) /( (1/(Clp*s))+ Rlp);
H(s) = (zHP^hpOrder)*(zLP^lpOrder);
H(s) = simplify(H(s));
H(s) = expand(H(s));

% Define dialog properties
prompt = {
            'Enter coefficient of startFreq',
            'Enter coefficient of stopFreq',
            'Enter coefficient of hpOrder',
            'Enter coefficient of Rhp',
            'Enter coefficient of Chp',
            'Enter coefficient of lpOrder',
            'Enter coefficient of Rlp',
            'Enter coefficient of Clp'
        };
title = 'MatLab Assignment 2';
opts.Resize='on'
opts.WindowStyle = 'normal'
answer = inputdlg(prompt,title)

% extract values from input 
% convert to num
startFreq = str2num(answer{1})
stopFreq = str2num(answer{2})
hpOrder = str2num(answer{3})
Rhp = str2num(answer{4})
Chp = str2num(answer{5})
lpOrder = str2num(answer{6})
Rlp = str2num(answer{7})
Clp = str2num(answer{8})

H(s) = subs(H(s));
nSteps = 400;
dLog = (log10(stopFreq)-log10(startFreq))/nSteps;

freq(1) = startFreq;
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
