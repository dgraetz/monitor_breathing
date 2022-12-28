%displays data from bluetooth respiration units in 'real time'
%press Q and ESC simultaneously during plotting to end script
%Dominik Graetz, July 2022


clear all
addpath(genpath(pwd));
%for exiting program
KbName('UnifyKeyNames');
KEYS.Q = KbName('q');
KEYS.ESC = KbName('ESCAPE');

Nsamples = 300; %this is the length of the x axis

dev1 = connectdevice;

another = 'x';
while ~strcmp(another, 'y') && ~strcmp(another, 'n')
    another = input('Do you want to connect another device? (y/n) ', 's');
end

%recode another
if strcmp(another, 'y')
    another = 1;
elseif strcmp(another, 'n')
    another = 0;
end

%connect second device
if another
    dev2 = connectdevice;
    fopen(dev2);
end

fopen(dev1);

xx = figure('Position', [0 200 1000 1080]);

x = 1:Nsamples;
% y1 = zeros(1, Nsamples-1);
% y2 = zeros(1, Nsamples-1);
y1 = zeros(1, Nsamples);
y2 = zeros(1, Nsamples);

t = GetSecs;

%flush device(s)
while GetSecs - t < 2
    fgets(dev1);
    if another
        fgets(dev2);
    end
end

x = 1:Nsamples;

disp('Press Q and ESC simultaneously to end live view.');

iter = 0;
while 1

    dontSleep;
    
    iter = iter + 1;

    y1 = getDataAndDraw(dev1, x, y1);

    if another
        y2 = getDataAndDraw(dev2, x, y2);
    end
    
    %don't draw every single iteration
    if iter == 4
        
        %reference figure
        figure(xx);

        if another
            %if we have two devices connected, make two separate figures
            subplot(2,1,1);
        end

        plot(x, y1);
        title(dev1.RemoteName,'Interpreter', 'none'); %Interpreter 'none' prevents title to be ugly (underscore _ is interpreted to mean subscript

        if another

            subplot(2,1,2);
            plot(x, y2);
            title(dev2.RemoteName,'Interpreter', 'none');

        end
        drawnow;
        iter = 0; %resets iterations

    end

    %this is to keep the plot moving
%     y1(1) = [];
% 
%     if another
%         y2(1) = [];
%     end
    
    [~, ~, keys] = KbCheck;
    if keys(KEYS.Q) && keys(KEYS.ESC)

        close; %closes figure
        disp('Session ended by user.');
        fclose(dev1);
        delete dev1
        clear dev1

        if another
            fclose(dev2);
            delete dev2
            clear dev2
        end

        break

    end


end

