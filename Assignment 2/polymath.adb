--TODO:
--  • The subprogram subpoly(a,b), which subtracts one polynomial from another
--  • The subprogram multpoly(a,b), which multiplies one polynomial by another

package body polymath is
    function addPOLY (a : Polynomial; b : Polynomial) return Polynomial is
        SortedPoly1 : Polynomial := sortPoly (a);
        SortedPoly2 : Polynomial := sortPoly (b);
        Result      : Polynomial;
        Curr1       : TermPtr    := SortedPoly1.Head;
        Curr2       : TermPtr    := SortedPoly2.Head;

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
end polymath;
