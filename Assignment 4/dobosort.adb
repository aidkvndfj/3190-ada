with Ada.Text_IO;                   use Ada.Text_IO;
with Ada.Real_Time;                 use Ada.Real_Time;
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Directories;               use Ada.Directories;

procedure DoboSort is
    N, Q, INC, K                : Integer;
    A                           : array (1 .. 50_000) of Integer;
    FileName_In                 : Unbounded_String;
    In_File_Head, Out_File_Head : File_Type;
    TempStr                     : Unbounded_String;
    Temp                        : Integer;

    Start_Time, Stop_Time : Time;
    Elapsed_Time          : Time_Span;

begin
    -- Prompt user for input file name
    Put ("Enter input file name: ");
    Get_Line (FileName_In);

    if not Exists (To_String (FileName_In)) then
        Put_Line ("Invalid filname, exiting");
        return;
    end if;

    -- Open input file and read integers into array A
    Open
       (File => In_File_Head, Mode => In_File,
        Name => To_String (FileName_In));
    N := 0;

    while not End_Of_File (In_File_Head) loop
        TempStr := Get_Line (In_File_Head);
        Temp    := Integer'Value (To_String (TempStr));
        N       := N + 1;
        if N > 50_000 then
            Put_Line ("Error: too many numbers in input file.");
            return;
        end if;
        A (N) := Temp;
    end loop;
    Close (In_File_Head);

    Start_Time := Clock;
    -- Perform DoboSort algorithm
    -- First loop
    Q          := 1;
    while Q <= N - 1 loop
        INC := Q;
        for i in 1 .. N - INC loop
            if A (i) > A (i + INC) then
                A (i)       := A (i) + A (i + INC);
                A (i + INC) := A (i) - A (i + INC);
                A (i)       := A (i) - A (i + INC);
            end if;
        end loop;
        Q := Q + 1;
    end loop;
    -- Second loop
    Q := N - 1;
    while Q > 0 loop
        K := 0;
        for i in 1 .. Q loop
            if A (i) > A (i + 1) then
                A (i)     := A (i) + A (i + 1);
                A (i + 1) := A (i) - A (i + 1);
                A (i)     := A (i) - A (i + 1);
                K         := i;
            end if;
        end loop;
        Q := K - 1;
    end loop;

    Stop_Time    := Clock;
    Elapsed_Time := Stop_Time - Start_Time;

    Put_Line
       ("Elapsed time: " & Duration'Image (To_Duration (Elapsed_Time)) &
        " seconds");

    Create (File => Out_File_Head, Name => "sortedF.txt", Mode => Out_File);
    for I in 1 .. N loop
        Put (Out_File_Head, Integer'Image (A (I)));
        New_Line (Out_File_Head);
    end loop;
    Close (Out_File_Head);

end DoboSort;
