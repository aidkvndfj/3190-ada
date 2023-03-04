with Ada.Text_IO; use Ada.Text_IO;

package body LinkedList is

    procedure Append (L : in out List; Number : in Integer; Power : in Integer)
    is
        NewNode : NodePtr :=
           new Node'(Number => Number, Power => Power, Next => null);

        LastNode : NodePtr := L.Head;
    begin
        if LastNode = null then
            L.Head := NewNode;
        else
            while LastNode.Next /= null loop
                LastNode := LastNode.Next;
            end loop;
            LastNode.Next := NewNode;
        end if;
    end Append;

    procedure Remove (L : in out List; Number : in Integer; Power : in Integer)
    is
        PrevNode : NodePtr := null;
        CurrNode : NodePtr := L.Head;
    begin
        while CurrNode /= null loop
            if CurrNode.Number = Number and CurrNode.Power = Power then
                if PrevNode = null then
                    L.Head := CurrNode.Next;
                else
                    PrevNode.Next := CurrNode.Next;
                end if;
                return;
            end if;
            PrevNode := CurrNode;
            CurrNode := CurrNode.Next;
        end loop;
    end Remove;

    procedure Print (L : in List) is
        CurrNode : NodePtr := L.Head;
    begin
        while CurrNode /= null loop
            Put (CurrNode.Number'Img & "^" & CurrNode.Power'Img & " ");
            CurrNode := CurrNode.Next;
        end loop;
        New_Line;
    end Print;

end LinkedList;
