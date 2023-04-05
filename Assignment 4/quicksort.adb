with Ada.Text_IO;                   use Ada.Text_IO;
with Ada.Real_Time;                 use Ada.Real_Time;
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Directories;               use Ada.Directories;

procedure QuickSort is
    type Integer_Array is array (Natural range <>) of Integer;
    N                           : Integer;
    A                           : Integer_Array (1 .. 50_001);
    FileName_In                 : Unbounded_String;
    In_File_Head, Out_File_Head : File_Type;
    TempStr                     : Unbounded_String;
    Temp                        : Integer;

    Start_Time, Stop_Time : Time;
    Elapsed_Time          : Time_Span;

    procedure quicksort_rec (a : in out Integer_Array; l, r : Integer) is
    begin
        if (r > l) then
            declare
                pivot      : constant Integer := a (l);
                i, j, temp : Integer;
            begin
                i := l + 1;
                j := r;
                loop
                    while i <= r and a (i) <= pivot loop
                        i := i + 1;
                    end loop;

                    while j >= l + 1 and a (j) > pivot loop
                        j := j - 1;
                    end loop;

                    if i < j then
                        -- Swap a(i) and a(j)
                        temp  := a (i);
                        a (i) := a (j);
                        a (j) := temp;
                    else
                        exit;
                    end if;
                end loop;

                -- Swap a(l) and a(j)
                temp  := a (l);
                a (l) := a (j);
                a (j) := temp;

                -- Recursively sort the two sub-arrays
                quicksort_rec (a, l, j - 1);
                quicksort_rec (a, j + 1, r);
            end;
        end if;
    end quicksort_rec;

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
    -- Perform QuickSort algorithm
    quicksort_rec (A, 1, N);

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

end QuickSort;
