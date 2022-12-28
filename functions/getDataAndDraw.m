function y = getDataAndDraw(dev, x,y)

if dev.BytesAvailable > 0 %this is helpful if one device is not producing data anymore (because it is disconnected, for example)
        string = fgets(dev);
        y(end+1) = str2double(string);
        y(1) = [];
end

end