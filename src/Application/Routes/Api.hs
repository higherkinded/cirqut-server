module Application.Routes.Api
  ( api
  ) where


import Network.HTTP.Types
import Network.Wai
import Util.Common.Request
import Util.Common.Response


api :: Application
api req res =
  let path = dissectPathInfo req
  in case path of
    PathEmpty -> res todo
    _ -> res notFound
