from urllib.parse import urlencode, quote_plus
import urllib.request

def encodeSliceURL(src, start, duration, year, gameID, quarter, filename):
    payload = {'src':src, 'start':start, 'duration':duration, 'year':year, 'gameID':gameID, 'quarter':quarter, 'filename':filename}
    result = urlencode(payload, quote_via=quote_plus)
    return result

def sendGETRequest(result):
    print("http://jiaxi.vip.gatech.edu/php/slice.php?"+result)
    urllib.request.urlopen("http://jiaxi.vip.gatech.edu/php/slice.php?"+result).read()

#Usage:
#sendGETRequest(encodeSliceURL("123.avi", "0:00", 5, 2016, 6011, 1, "045"))
