codeunit 50100 Killer
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterInitialization', '', false, false)]
    local procedure OnAfterInitialize()
    begin
        Message('Hello, there!');
    end;
}
