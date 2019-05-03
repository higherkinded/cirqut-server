{-# LANGUAGE OverloadedStrings #-}
module Application.Routes
  ( routes
  ) where


import Application.Routes.About
import Application.Routes.Api
import Application.Routes.Root
import Data.Bifunctor
import Data.Text.Encoding
import Data.Text.IO
import Network.Wai
import Util.Common.Request
import Util.Common.Response
import Util.Log


-- | Main route dispatcher
routes :: Application
routes req res = do
  let path = dissectPathInfo req
  let (method, rawPath) = bimap ($req) ($req) (requestMethod, rawPathInfo)
  -- Wraping response callback into logger. No middleware requred, as well as
  -- no unsafePerformIO: callback produces an IO action on its own, so a simple
  -- bind will do.
  let respond = (res =<<) . loggedResponse method rawPath
  case path of
    PathChain "about" _ -> about (popPath req) respond
    PathChain "api"   _ -> api   (popPath req) respond
    PathEmpty           -> root  req           respond
    _                   -> respond notFound