import Utils.Helpers

main :: IO ()
main = do
  putStrLn "Hi, haskeller!"
  testResult <- testConnect "/dev/modem"
  print testResult
  sendSMS "phonenumber" "Hi, Bro" "/dev/modem"
