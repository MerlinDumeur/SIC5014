function HX = Hdl(X)

    sc = X(1)^2 + X(3)^2;

    HX = [X(1)/sqrt(sc) 0 X(3)/sqrt(sc) 0
          -X(3)/sc      0 1/(X(1) + (X(3)^2 / X(1))) 0];

end

