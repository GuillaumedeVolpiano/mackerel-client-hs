{-# LANGUAGE TemplateHaskell #-}
-- | Service API.
module Web.Mackerel.Api.Service (listServices) where

import Data.Aeson.TH (deriveJSON)
import Network.Http.Client

import Web.Mackerel.Client
import Web.Mackerel.Internal.Api
import Web.Mackerel.Internal.TH
import Web.Mackerel.Types.Service

data ListServicesResponse = ListServicesResponse { responseServices :: [Service] }
$(deriveJSON options ''ListServicesResponse)

listServices :: Client -> IO (Either ApiError [Service])
listServices client
  = request client GET "/api/v0/services" emptyBody (createHandler responseServices)
