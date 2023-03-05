with polylink;    use polylink;
with polymath;    use polymath;
with Ada.Text_IO; use Ada.Text_IO;

procedure poly is
    menuChoice : Integer;
    option1    : Integer;
    option2    : Integer;

    procedure PrintMenu is
    begin
        Put_Line
           ("Please input one of the following numbers to complete that action:");
        Put_Line ("0. Exit");
        Put_Line ("1. Input a polynomial");
        Put_Line ("2. Print a polynomial");
        Put_Line ("3. Add 2 polynomials");

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
                if DisplayAll = True then
                    Put_Line ("Please select 2 polys to add together");
                    option1 := Integer'Value (Get_Line);
                    option2 := Integer'Value (Get_Line);
                    Put ("The result is:");
                    writePOLY (addPOLY (GetPoly (option1), GetPoly (option2)));
                else
                    Put_Line
                       ("There are not enough polynomials, please have at least 2 and try again");
                end if;

            when others =>
                Put_Line ("Invalid menu choice!");
        end case;
    end loop;

    Put_Line ("Thank you!");
end poly;
