import requests
from bs4 import BeautifulSoup
import time

# --- CONFIGURATION ---
# Replace this with a real product URL (e.g., from an electronics site)
PRODUCT_URL = "https://www.example.com/product-item" 
TARGET_PRICE = 500.0
CHECK_INTERVAL = 3600  # Check every hour (3600 seconds)

# Headers make the request look like it's coming from a real browser
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
}

def check_price():
    try:
        response = requests.get(PRODUCT_URL, headers=HEADERS)
        soup = BeautifulSoup(response.content, "html.parser")

        # NOTE: You must update this selector to match the website you are tracking
        # For example: soup.find("span", class_="a-price-whole")
        price_element = soup.find("span", class_="price") 
        
        if price_element:
            price_str = price_element.get_text().replace("$", "").replace(",", "").strip()
            current_price = float(price_str)
            
            print(f"Current Price: ${current_price}")
            
            if current_price <= TARGET_PRICE:
                print("!!! PRICE DROP ALERT !!!")
            else:
                print("Price is still above target.")
        else:
            print("Could not find the price element on the page.")

    except Exception as e:
        print(f"Error occurred: {e}")

if __name__ == "__main__":
    print("Price Tracker Started...")
    while True:
        check_price()
        time.sleep(CHECK_INTERVAL)
