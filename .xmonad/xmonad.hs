module Main (main) where

    import XMonad

    import qualified Data.Map as M
    import Graphics.X11.Xlib
    import XMonad.Prompt
    import XMonad.Prompt.Shell
    import XMonad.Prompt.XMonad
    import XMonad.Config.Gnome

    import XMonad hiding (Tall)
    import XMonad.Hooks.ManageDocks
    import XMonad.Hooks.SetWMName
    import XMonad.Layout.Circle
    import XMonad.Layout.Magnifier
    import XMonad.Layout.HintedTile
    import XMonad.Layout.NoBorders
    import XMonad.Hooks.EwmhDesktops

    import XMonad.Hooks.DynamicLog
    import XMonad.Hooks.ICCCMFocus

    myTerminal = "gnome-terminal"
    main :: IO ()
    main = xmonad $ gnomeConfig { keys = newKeys
     , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
     , terminal = myTerminal
     , handleEventHook = (handleEventHook gnomeConfig) <+> fullscreenEventHook
     }

    myManageHook = composeAll
        [ className =? "Gimp" --> doFloat ]


    newKeys x = M.union (keys defaultConfig x) (M.fromList (myKeys x))

    myKeys conf@(XConfig {XMonad.modMask = modm}) =
             [
                ((modm, xK_z), setWMName "LG3D") -- @@ Java hack
              , ((modm, xK_F12), xmonadPrompt defaultXPConfig)
              , ((modm, xK_F2 ), shellPrompt defaultXPConfig)
              , ((modm, xK_F3 ), spawn "exe=`dmenu_path | dmenu -fn '-*-terminus-*-*-*-*-12-*-*-*-*-*-*-u' -nb '#1c1c1c' -nf '#C4C4C4' -sf '#D7AF87'` && eval \"exec $exe\"")
             ]
