with polylink;          use polylink;
with polymath;          use polymath;
with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure poly is
    menuChoice : Integer;
    option1    : Integer;
    option2    : Integer;
    evalSum    : Float;

    -- Prints the menu options for the user to choose from
    procedure PrintMenu is
    begin
        Put_Line
           ("Please input one of the following numbers to complete that action:");
        Put_Line ("0. Exit");
        Put_Line ("1. Input a polynomial");
        Put_Line ("2. Print a polynomial");
        Put_Line ("3. Add 2 polynomials");
        Put_Line ("4. Subtract 2 polynomials");
        Put_Line ("5. Multiply 2 polynomails");
        Put_Line ("6. Evaluate a polynomial");

    end PrintMenu;

begin
    menuChoice := 1;
    Put_Line ("Welcome!");
    Put_Line
       ("Before you begin, please note that there is a maximum of 5 polynomials, if you wish to input more, you will be asked to overwrite an exisiting polynomial.");
    New_Line;

    while (menuChoice /= 0) loop
        PrintMenu;
        menuChoice := Integer'Value (Get_Line);

        case menuChoice is
            when 0 =>
                Put_Line ("Exiting...");
            when 1 =>
                readPOLY;
            when 2 =>
                Put_Line
                   ("From 1 - 5 which polynomial would you like to print?");
                writePOLY (Integer'Value (Get_Line));

            when 3 =>
                -- Checks if there are at least two polynomials to add and performs addition
                if DisplayAll = True then
                    Put_Line
                       ("Please input the number of the first polynomial to be added");
                    option1 := Integer'Value (Get_Line);
                    Put_Line
                       ("Please input the number of the second polynomial to be added");
                    option2 := Integer'Value (Get_Line);
                    Put ("The result is:");
                    writePOLY (addPOLY (GetPoly (option1), GetPoly (option2)));
                else
                    Put_Line
                       ("There are not enough polynomials, please have at least 2 and try again");
                end if;

            when 4 =>
                -- Checks if there are at least two polynomials to subtract and performs subtraction
                if DisplayAll = True then
                    Put_Line
                       ("Please input the number of the first polynomial to be subtracted");
                    option1 := Integer'Value (Get_Line);
                    Put_Line
                       ("Please input the number of the second polynomial to be subtracted from");
                    option2 := Integer'Value (Get_Line);
                    Put ("The result is:");
                    writePOLY (subPOLY (GetPoly (option1), GetPoly (option2)));
                else
                    Put_Line
                       ("There are not enough polynomials, please have at least 2 and try again");
                end if;

            when 5 =>
                -- Checks if there are at least two polynomials to multiply and performs multiplication
                if DisplayAll = True then
                    Put_Line
                       ("Please input the number of the first polynomial to be multiplied");
                    option1 := Integer'Value (Get_Line);
                    Put_Line
                       ("Please input the number of the second polynomial to be multiplied");
                    option2 := Integer'Value (Get_Line);
                    Put ("The result is:");
                    writePOLY
                       (multPOLY (GetPoly (option1), GetPoly (option2)));
                else
                    Put_Line
                       ("There are not enough polynomials, please have at least 2 and try again");
                end if;

            when 6 =>
                -- Evaluates a polynomial by taking user input for x value
                DisplayAll;
                Put_Line
                   ("Please input the number of the polynomial to be evaluated");
                option1 := Integer'Value (Get_Line);
                Put_Line ("Please input what you would like x to be");
                evalSum := Float'Value (Get_Line);
                evalSum := evalPOLY (GetPoly (option1), evalSum);
                Put ("The result is: ");
                Put (evalSum, Exp => 0, Aft => 3);
                New_Line;

            when others =>
                Put_Line ("Invalid menu choice!");
        end case;
    end loop;

    Put_Line ("Thank you!");
end poly;
