import Utils.Helpers

main :: IO ()
main = do
  putStrLn "Hi, haskeller!"
  testResult <- testConnect "/dev/modem"
  print testResult
  sendSMS "+79085069512" "Hi, Bro" "/dev/modem"