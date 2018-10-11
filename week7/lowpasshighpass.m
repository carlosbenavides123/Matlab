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
            'Enter value for e to the power for startFreq ',
            'Enter value for e to the power for stopFreq',
            'Enter coefficient of hpOrder',
            'Enter coefficient of Rhp',
            'Enter value (negative) for e to the power for Chp',
            'Enter coefficient of lpOrder',
            'Enter coefficient of Rlp',
            'Enter value (negative) for e to the power for Clp'
        };
title               = 'MatLab Assignment 2';
opts.Resize         = 'on'
opts.WindowStyle    = 'normal'
answer              = inputdlg(prompt,title)


% i tried 
%     {'1'   }{'1'   }{'6'   }{'1000'}{'-6'  }{'1'   }{'100' }{'-6'  }
% and it looked pretty well
% extract values from input 
% convert to num

% his powerpoint value is
% startFreq = 1e2; stopFreq = 1e6;
startFreq   = power(1,str2num(answer{1}))
stopFreq    = power(10,str2num(answer{2}))

% his powerpoint value is
% hpOrder = 1; hp = 1000; Chp = 10e-6;
hpOrder     = str2num(answer{3})
Rhp         = str2num(answer{4})
Chp         = power(10,str2num(answer{5}))

% power point value is 
% lpOrder = 1; Rlp = 100; Clp = 1e-6;
lpOrder     = str2num(answer{6})
Rlp         = str2num(answer{7})
Clp         = power(10,str2num(answer{8}))

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
