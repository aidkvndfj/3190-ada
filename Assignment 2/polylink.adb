with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

package body polylink is

    procedure readPOLY is
        tempPoly        : Polynomial;
        tempCoefficent  : Float   := 0.0;
        tempExponent    : Integer := 0;
        foundSpot       : Boolean := False;
        replaceLocation : Integer := 0;
    begin
        Put_Line ("Please enter the Coefficient followed by the Exponent");
        Put_Line
           ("When you have inputted all of the values, press enter and it will bring you back to the main menu");
        replaceLocation := 0;
        while True loop
            replaceLocation := replaceLocation + 1;
            Put_Line ("Please enter Coefficient" & replaceLocation'Img);
            tempCoefficent := Float'Value (Get_Line);
            Put_Line ("Please enter Exponent" & replaceLocation'Img);
            tempExponent := Integer'Value (Get_Line);

            Append (tempPoly, tempCoefficent, tempExponent);
        end loop;

    exception
        when others =>
            Put_Line ("Saving...");

            foundSpot       := False;
            replaceLocation := 0;

            for J in polyArray'Range loop
                if (polyArray (J).Head = null) then
                    polyArray (J) := tempPoly;
                    foundSpot     := True;
                    exit;
                end if;
            end loop;

            if (not foundSpot) then
                Put_Line
                   ("All polynomial spots are full, please enter a number from 1-5 representing the polynomial to replace.");

                for J in polyArray'Range loop
                    writePOLY (J);
                end loop;
                replaceLocation := Integer'Value (Get_Line);

                while (replaceLocation <= 0 and replaceLocation > 5) loop
                    Put_Line
                       ("Invalid number, please enter a number from 1-5");
                    replaceLocation := Integer'Value (Get_Line);
                end loop;

                polyArray (replaceLocation) := tempPoly;

            end if;

    end readPOLY;

    procedure writePOLY (num : in Integer) is
        CurrTerm  : TermPtr := polyArray (num).Head;
        firstDone : Boolean := False;
    begin
        if (CurrTerm = null) then
            Put_Line ("There is no poly to display");
        end if;

        while CurrTerm /= null loop
            if (CurrTerm.Coefficient > 0.0 and firstDone) then
                Put ("+");
            end if;

            Put (CurrTerm.Coefficient, Exp => 0, Aft => 3);
            Put ("x^" & CurrTerm.Exponent'Img & " ");
            CurrTerm  := CurrTerm.Next;
            firstDone := True;
        end loop;
        New_Line;
    end writePOLY;

    procedure writePOLY (poly : in Polynomial) is
        CurrTerm  : TermPtr := poly.Head;
        firstDone : Boolean := False;
    begin
        if (CurrTerm = null) then
            Put_Line ("There is no poly to display");
        end if;

        while CurrTerm /= null loop
            if (CurrTerm.Coefficient > 0.0 and firstDone) then
                Put ("+");
            end if;

            Put (CurrTerm.Coefficient, Exp => 0, Aft => 3);
            Put ("x^" & CurrTerm.Exponent'Img & " ");
            CurrTerm  := CurrTerm.Next;
            firstDone := True;
        end loop;
        New_Line;
    end writePOLY;

    procedure Append
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer)
    is
        NewTerm : TermPtr :=
           new Term'
              (Coefficient => Coefficient, Exponent => Exponent, Next => null);

        LastTerm : TermPtr := P.Head;

    begin

        if LastTerm = null then
            P.Head := NewTerm;
        else
            while LastTerm.Next /= null loop
                LastTerm := LastTerm.Next;
            end loop;
            LastTerm.Next := NewTerm;
        end if;
    end Append;

    procedure Remove
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer)
    is
        PrevTerm : TermPtr := null;
        CurrTerm : TermPtr := P.Head;
    begin
        while CurrTerm /= null loop
            if CurrTerm.Coefficient = Coefficient and
               CurrTerm.Exponent = Exponent
            then
                if PrevTerm = null then
                    P.Head := CurrTerm.Next;
                else
                    PrevTerm.Next := CurrTerm.Next;
                end if;
                return;
            end if;
            PrevTerm := CurrTerm;
            CurrTerm := CurrTerm.Next;
        end loop;
    end Remove;

    procedure Clear (P : in out Polynomial) is
        CurrTerm : TermPtr := P.Head;
        NextTerm : TermPtr;
    begin
        while CurrTerm /= null loop
            NextTerm := CurrTerm.Next;
            DeleteTerm (CurrTerm);
            CurrTerm := NextTerm;
        end loop;
        P.Head := null;
    end Clear;

    function GetPoly (num : in Integer) return Polynomial is
    begin
        return polyArray (num);
    end GetPoly;

    function SortPoly (L : Polynomial) return Polynomial is
        tmpPoly     : Polynomial := L;
        Sorted_List : Polynomial;
    begin
        while tmpPoly.Head /= null loop
            declare
                Max_Node  : TermPtr := tmpPoly.Head;
                Curr_Node : TermPtr := Max_Node.Next;
                Prev_Node : TermPtr := Max_Node;
            begin
                while Curr_Node /= null loop
                    if Curr_Node.Exponent > Max_Node.Exponent then
                        Max_Node       := Curr_Node;
                        Prev_Node.Next := Max_Node.Next;
                    else
                        Prev_Node := Curr_Node;
                    end if;
                    Curr_Node := Curr_Node.Next;
                end loop;
                Append (Sorted_List, Max_Node.Coefficient, Max_Node.Exponent);
                Remove (tmpPoly, Max_Node.Coefficient, Max_Node.Exponent);
            end;
        end loop;
        return Sorted_List;
    end SortPoly;

    function DisplayAll return Boolean is
        tmp     : Polynomial;
        counter : Integer := 0;
    begin
        for j in polyArray'Range loop
            tmp := polyArray (j);
            Put (j'Img & ": ");
            if (tmp.Head = null) then
                Put_Line ("Empty");
                counter := counter + 1;
            else
                writePOLY (j);
            end if;

        end loop;

        if (counter >= 2) then
            return True;
        else
            New_Line;
            return False;
        end if;
    end DisplayAll;

end polylink;
