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
        -- Prompt the user to enter the coefficient and exponent
        Put_Line ("Please enter the Coefficient followed by the Exponent");
        Put_Line
           ("When you have inputted all of the values, press enter and it will bring you back to the main menu");
        replaceLocation := 0;

        -- loop untill the users enters and chars and causes and exception to occurr
        while True loop
            -- Increment replaceLocation and prompt the user to enter the coefficient and exponent
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

            -- Iterate over the polynomial array and check if any spot is free to store a new polynomial
            for J in polyArray'Range loop
                if (polyArray (J).Head = null) then
                    polyArray (J) := tempPoly;
                    foundSpot     := True;
                    exit;
                end if;
            end loop;

            -- If no spot is free, ask the user to enter the location where the polynomial is to be replaced and replace it
            if (not foundSpot) then

                -- get the location
                Put_Line
                   ("All polynomial spots are full, please enter a number from 1-5 representing the polynomial to replace.");
                if not DisplayAll then
                    Put_Line
                       ("BIG ERROR, SOMETHING IS BROKEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                end if;
                replaceLocation := Integer'Value (Get_Line);

                -- Validate the input and prompt the user to enter a valid number between 1 and 5
                while (replaceLocation <= 0 and replaceLocation > 5) loop
                    Put_Line
                       ("Invalid number, please enter a number from 1-5");
                    replaceLocation := Integer'Value (Get_Line);
                end loop;

                -- Replace the specified polynomial with the new polynomial
                polyArray (replaceLocation) := tempPoly;
            end if;
    end readPOLY;

    procedure writePOLY (num : in Integer) is
    begin
        writePOLY (polyArray (num));
    end writePOLY;

    procedure writePOLY (poly : in Polynomial) is
        CurrTerm  : TermPtr := poly.Head;
        firstDone : Boolean := False;
    begin
        --inform user if the polynomial is empty
        if (CurrTerm = null) then
            Put_Line ("There is no poly to display");
        end if;

        -- loop untill the end of the polynomial
        while CurrTerm /= null loop
            -- print a + if positive number
            if (CurrTerm.Coefficient >= 0.0 and firstDone) then
                Put ("+");
            end if;

            -- print the coefficient if it's not exactly 1
            if (CurrTerm.Coefficient /= 1.0) then
                Put (CurrTerm.Coefficient, Exp => 0, Aft => 3);
            end if;

            -- print the exponent
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
        -- if the head is empty put new term at the head
        if LastTerm = null then
            P.Head := NewTerm;
        else
            -- otherwise loop to the end of the polynomial and add the term
            while LastTerm.Next /= null loop
                LastTerm := LastTerm.Next;
            end loop;
            LastTerm.Next := NewTerm;
        end if;
    end Append;

    procedure Add
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer)
    is
        NewTerm : TermPtr :=
           new Term'
              (Coefficient => Coefficient, Exponent => Exponent, Next => null);

        LastTerm  : TermPtr := P.Head;
        FoundSame : Boolean := False;

    begin
        -- if the head is empty put new term at the head
        if LastTerm = null then
            P.Head := NewTerm;
        else
            -- otherwise loop to the end of the polynomial and add the term
            loop
                Put_Line (LastTerm.Exponent'Img & "  " & NewTerm.Exponent'Img);
                if (LastTerm.Exponent = NewTerm.Exponent) then
                    LastTerm.Coefficient :=
                       LastTerm.Coefficient + NewTerm.Coefficient;
                    FoundSame            := True;
                    exit;
                else
                    if (LastTerm.Next = null) then
                        exit;
                    end if;
                    LastTerm := LastTerm.Next;
                end if;
            end loop;
            if (FoundSame = False) then
                LastTerm.Next := NewTerm;
            end if;
        end if;
    end Add;

    procedure Remove
       (P : in out Polynomial; Coefficient : in Float; Exponent : in Integer)
    is
        PrevTerm : TermPtr := null;
        CurrTerm : TermPtr := P.Head;
    begin
        -- loop through the polynomial
        while CurrTerm /= null loop
            -- make sure the coefficient and exponent are the same as the requested.
            if CurrTerm.Coefficient = Coefficient and
               CurrTerm.Exponent = Exponent
            then
                -- remove term
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
        -- loop through polynomial and delete each term
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
        tmpPoly    : Polynomial := L;
        sortedList : Polynomial;
    begin
        -- loop through the polynomial
        while tmpPoly.Head /= null loop

            -- create vars tosort
            declare
                maxTerm  : TermPtr := tmpPoly.Head;
                currTerm : TermPtr := maxTerm.Next;
                lastTerm : TermPtr := maxTerm;
            begin
                -- loop through poly
                while currTerm /= null loop
                    -- if the current is > then the max, set max
                    if currTerm.Exponent > maxTerm.Exponent then
                        maxTerm       := currTerm;
                        lastTerm.Next := maxTerm.Next;
                    else
                        lastTerm := currTerm;
                    end if;
                    currTerm := currTerm.Next;
                end loop;

                -- at the end, add the max term to the sorted list and remove it from the tmp poly
                Append (sortedList, maxTerm.Coefficient, maxTerm.Exponent);
                Remove (tmpPoly, maxTerm.Coefficient, maxTerm.Exponent);
            end;
        end loop;
        return sortedList;
    end SortPoly;

    function DisplayAll return Boolean is
        tmp     : Polynomial;
        counter : Integer := 0;
    begin
        counter := 0;
        -- loop through the poly list
        for j in polyArray'Range loop
            tmp := polyArray (j);
            Put (j'Img & ": ");

            -- print empty if null, otherwise write the polynomial
            if (tmp.Head = null) then
                Put_Line ("Empty");
                counter := counter + 1;
            else
                writePOLY (j);
            end if;

        end loop;

        -- return false if there is less then 2 polynomials. Useful to check before an add/subtract/multiply.
        if (counter <= 3) then
            return True;
        else
            New_Line;
            return False;
        end if;
    end DisplayAll;

end polylink;
