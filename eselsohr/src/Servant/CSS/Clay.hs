module Servant.CSS.Clay
  ( CSS
  ) where

import           Clay                           ( Css
                                                , compact
                                                , renderWith
                                                )
import qualified Network.HTTP.Media            as M
import           Servant.API                    ( Accept(..)
                                                , MimeRender(..)
                                                )

data CSS
  deriving stock Typeable

-- | @text/css; charset=utf-8@
instance Accept CSS where
  contentTypes _ =
    "text" M.// "css" M./: ("charset", "utf-8") :| ["text" M.// "css"]

instance MimeRender CSS Css where
  mimeRender _ = encodeUtf8 . renderWith compact []
