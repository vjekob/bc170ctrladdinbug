page 50100 Killer
{
    PageType = Card;

    layout
    {
        area(Content)
        {
            usercontrol(Killer; Killer)
            {
                ApplicationArea = All;
                trigger OnControlReady();
                begin
                    CurrPage.Killer.Initialize();
                end;
            }
        }
    }
}
