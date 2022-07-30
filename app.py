import os
import time
from dotenv import load_dotenv

load_dotenv()
var1 = os.getenv('TWORPTEST')
print(var1)

while True:
    time.sleep(20)
    print(var1)
