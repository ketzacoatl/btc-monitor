module Main where

import  Data.Base58String.Bitcoin   (fromText)
import  Data.Bitcoin.Types          (Address)
import  Data.Text                   (pack)
import  Network.Bitcoin.Api.Client  (Client, withClient)
import  Network.Bitcoin.Api.Misc    (getInfo)
import  Network.Bitcoin.Api.Wallet  (getAccountBalance, getAddressAccount)

localClient :: (Client -> IO a) -> IO a
localClient = withClient "127.0.0.1" 18332 (pack "username") (pack "password")

addr :: Address
addr = fromText $ pack "wallet_address"

main :: IO ()
main = do
  localClient $ \client -> do
    account <- getAddressAccount client addr
    balance <- getAccountBalance client account
    info    <- getInfo client

    putStrLn $ "info: "       ++ show info
    putStrLn $ "account: "    ++ show account
    putStrLn $ "balance: "    ++ show balance
