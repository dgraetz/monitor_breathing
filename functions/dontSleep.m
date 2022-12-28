function dontSleep()

format short g
x = clock;
x = round(x(6));
%disp(x);

if x == 2 %seconds

    [x, y] = GetMouse;

    if CoinFlip(1, 0.5)
        SetMouse(x + 1, y + 1);
    else
        SetMouse(x - 1, y - 1);
    end

    SetMouse(x, y);


end

end