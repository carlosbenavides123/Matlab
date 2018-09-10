% Define dialog properties
prompt = {
            'Enter coefficient of dx/dt:',
            'Enter coefficient of x:',
            'Enter y(0):',
            'Enter dy(0)/dt:',
        };
title = 'MatLab Assignment 2';
answer = inputdlg(prompt,title)

% extract values from input 
% convert to num
p1 = str2num(answer{1})
p1 = str2num(answer{2})
p1 = str2num(answer{3})
p1 = str2num(answer{4})
