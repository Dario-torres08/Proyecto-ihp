module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome

instance Controller StaticController where
    action WelcomeAction = do
        let tasks = 
                [ Task "Estudiar Haskell" False
                , Task "Leer IHP Docs" True
                , Task "Crear una app web" False
                ]
        render WelcomeView { tasks }
