package body polymath is
    function addPOLY (a : in Polynomial; b : in Polynomial) return Polynomial
    is
        Result : Polynomial;
        Curr1  : TermPtr := a.Head;
        Curr2  : TermPtr := b.Head;

    begin
        while Curr1 /= null and Curr2 /= null loop
            if Curr1.Exponent > Curr2.Exponent then
                Append (Result, Curr1.Coefficient, Curr1.Exponent);
                Curr1 := Curr1.Next;
            elsif Curr1.Exponent < Curr2.Exponent then
                Append (Result, Curr2.Coefficient, Curr2.Exponent);
                Curr2 := Curr2.Next;
            else -- Curr1.Exponent = Curr2.Exponent
                Append
                   (Result, Curr1.Coefficient + Curr2.Coefficient,
                    Curr1.Exponent);
                Curr1 := Curr1.Next;
                Curr2 := Curr2.Next;
            end if;
        end loop;

        while Curr1 /= null loop
            Append (Result, Curr1.Coefficient, Curr1.Exponent);
            Curr1 := Curr1.Next;
        end loop;

        while Curr2 /= null loop
            Append (Result, Curr2.Coefficient, Curr2.Exponent);
            Curr2 := Curr2.Next;
        end loop;

        return Result;
    end addPOLY;

    function subPOLY (a : in Polynomial; b : in Polynomial) return Polynomial
    is
        Result : Polynomial;
        Curr1  : TermPtr := a.Head;
        Curr2  : TermPtr := b.Head;

    begin
        while Curr1 /= null and Curr2 /= null loop
            if Curr1.Exponent > Curr2.Exponent then
                Append (Result, Curr1.Coefficient, Curr1.Exponent);
                Curr1 := Curr1.Next;
            elsif Curr1.Exponent < Curr2.Exponent then
                Append (Result, Curr2.Coefficient, Curr2.Exponent);
                Curr2 := Curr2.Next;
            else -- Curr1.Exponent = Curr2.Exponent
                if (Curr1.Coefficient - Curr2.Coefficient /= 0.0) then
                    Append
                       (Result, Curr1.Coefficient - Curr2.Coefficient,
                        Curr1.Exponent);
                end if;
                Curr1 := Curr1.Next;
                Curr2 := Curr2.Next;
            end if;
        end loop;

        while Curr1 /= null loop
            Append (Result, Curr1.Coefficient, Curr1.Exponent);
            Curr1 := Curr1.Next;
        end loop;

        while Curr2 /= null loop
            Append (Result, Curr2.Coefficient, Curr2.Exponent);
            Curr2 := Curr2.Next;
        end loop;

        return Result;
    end subPOLY;

    function multPoly (a : in Polynomial; b : in Polynomial) return Polynomial
    is
        resultPoly : Polynomial;
        polyA      : TermPtr;
        polyB      : TermPtr;
    begin
        -- Loop through each term in polynomial A
        polyA := a.Head;
        while polyA /= null loop
            -- Loop through each term in polynomial B
            polyB := b.Head;
            while polyB /= null loop
                -- Multiply the coefficients and add the exponents
                Add (resultPoly, polyA.Coefficient * polyB.Coefficient,
                    polyA.Exponent + polyB.Exponent);
                polyB := polyB.Next;
            end loop;
            polyA := polyA.Next;
        end loop;

        --  return SortPoly (resultPoly);
        return resultPoly;
    end multPoly;

end polymath;
