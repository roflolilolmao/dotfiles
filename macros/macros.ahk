#SingleInstance
#WinActivateForce

F13::
{
    current_id := WinGetID("A")
    RunWait(A_ScriptDir "/commander.ahk")
    WinActivate(current_id)
}
