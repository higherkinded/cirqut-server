{-# LANGUAGE OverloadedStrings #-}
module Application.Routes.About.Credits
  ( credits
  ) where


import Prelude hiding (replicate)


import Application.Common.Headers
import Data.ByteString.Lazy    hiding (replicate)
import Data.Text               hiding (intercalate)
import Data.Text.Encoding
import Network.HTTP.Types
import Network.Wai
import Util.Common.ByteString
import Util.Common.Request
import Util.Common.Response


creditsResponse :: Response
creditsResponse = responseLBS
  status200
  [server, cPlaintext]
  $ intercalate "\n"
  [ "Kudos to the contributors of this application:", n
  , "-- Be the first ;)", n, sep, n
  , "This application would be way harder to develop and maintain without these"
  , "libraries and their authors and maintainers:", n
  , "aeson            (Authored by Bryan O'Sullivan, Maintainer: Adam Bergmark)"
  , "beam             (Author and maintainer: Travis Athougies)"
  , "bytestring       (Authored and maintained by Don Stewart and Duncan Coutts)"
  , "case-insensitive (Author and maintainer: Bas van Dijk"
  , "comonad          (Authored by Dave Mendes, continued by Edward A. Kmett)"
  , "http-types       (Authored and maintained by Aristid Breitkreuz and"
  , "                  Michael Snoyman)"
  , "split            (Authored by Brent Yorgey)"
  , "text             (Authored by Tom Harper, continued by Bryan O'Sullivan)"
  , "time             (Authored and maintained by Ashley Yakeley)"
  , "uuid             (Authored by Antoine Latter)"
  , "wai and warp     (Authored by Michael Snoyman, Kazu Yamamoto and Matt Brown)"
  , n, sep, n
  , "Authored by higherkinded, distributed under a 3-Clause BSD license."
  ] where sep = toLazy . encodeUtf8 $ replicate 80 "-"
          n   = ""


credits :: Application
credits req res =
  let path = dissectPathInfo req
  in case path of
    PathEmpty -> res creditsResponse
    _ -> res notFound
