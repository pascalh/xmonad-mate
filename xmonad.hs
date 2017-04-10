--
-- Configuration file for XMonad + MATE
--
--  Usage:
--      * Copy this file to ~/.xmonad/
--      * Run:    $ xmonad --recompile
--      * Launch: $ xmonad --replace
--      [Optional] Create an autostart to command with "xmonad --replace"
--
--  Author: Arturo Fernandez <arturo at bsnux dot com>
--  Inspired by:
--      Spencer Janssen <spencerjanssen@gmail.com>
--      rfc <reuben.fletchercostin@gmail.com>
--  License: BSD
--
import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run (spawnPipe)
import qualified Data.Map as M
import System.Environment (getEnvironment)
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops(fullscreenEventHook)
import qualified XMonad.StackSet as W

mateConfig = desktopConfig
    { terminal = "mate-terminal"
    , keys     = mateKeys <+> keys desktopConfig
    , startupHook = setWMName "LG3D"
    , focusFollowsMouse = False
    , handleEventHook = fullscreenEventHook
    }

mateKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm, xK_p), mateRun)
    , ((modm .|. shiftMask, xK_q), spawn "mate-session-save --kill") ]

mateRun :: X ()
mateRun = withDisplay $ \dpy -> do
    rw <- asks theRoot
    mate_panel <- getAtom "_MATE_PANEL_ACTION"
    panel_run   <- getAtom "_MATE_PANEL_ACTION_RUN_DIALOG"

    io $ allocaXEvent $ \e -> do
        setEventType e clientMessage
        setClientMessageEvent e rw mate_panel 32 panel_run 0
        sendEvent dpy rw False structureNotifyMask e
        sync dpy False

main = do
    panel <- spawnPipe "/usr/bin/mate-panel"
    xmonad $ mateConfig
                { modMask = mod4Mask
                 , borderWidth = 2
                 , focusedBorderColor = "#7FBC71"
                } `additionalKeysP` myKeys

myKeys = [  (("M4-f"), spawn "firefox")
           ,(("M4-z"), kill)
         ]

myDoFullFloat :: ManageHook
myDoFullFloat = doF W.focusDown <+> doFullFloat
