#SingleInstance
#WinActivateForce

F13::
{
    SendEvent('{F5}')

    current_id := WinGetID("A")
    RunWait(A_ScriptDir "/commander.ahk")
    WinActivate(current_id)
}
