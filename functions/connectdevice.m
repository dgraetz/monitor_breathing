function dev = connectdevice

while 1
    disp('Scanning for Bluetooth devices...');
    av_dev = instrhwinfo('Bluetooth');
    names = av_dev.RemoteNames;
    n = size(names,1);
    no = [1:n+1]';
    names = [names; {'repeat search'}];
    
    
    disp(['The following devices are available. Type in number from 1 to ' num2str(n+1) ' to select device you want to connect to.']);
    disp(table(no, names));
    
    dev_idx = input('Device number: ');
    
    if dev_idx <= n(1)
        break
    end

end

disp('Connecting...');
dev = Bluetooth(char(av_dev.RemoteNames(dev_idx)), 1);

end