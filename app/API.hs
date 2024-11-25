{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API where

import Servant

type ImgAPI = "comics" :> "img" :> Raw

