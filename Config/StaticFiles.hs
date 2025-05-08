module Config.StaticFiles where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig
import IHP.StaticFiles.Router

instance InitControllerContext WebApplication where
    initContext = do
        initAutoRefresh
        initStaticFiles