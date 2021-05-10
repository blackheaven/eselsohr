module Lib.Web.View.App
  ( render
  ) where

import qualified Lib.Web.Route                 as Route
import           Lucid
import           Lucid.Servant                  ( linkAbsHref_ )
import           Servant                        ( fieldLink )

render :: Html () -> Html ()
render page = doctypehtml_ $ do
  head_ $ do
    title_ "Eselsohr"
    meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1"]
    link_ [rel_ "stylesheet", linkAbsHref_ $ fieldLink Route.stylesheet]
  body_ $ do
    header
    main_ page
    footer

header :: Html ()
header = header_ ""

footer :: Html ()
footer = footer_ $ p_ "Eselsohr 📄 (α)"
