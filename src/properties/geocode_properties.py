# geocode_properties.py
# Run this once: python geocode_properties.py

import pymysql
import requests
import time
from dotenv import load_dotenv
import os

load_dotenv()

def get_db_connection():
    return pymysql.connect(
        host=os.getenv('DB_HOST', 'localhost'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        database=os.getenv('DB_NAME'),
        cursorclass=pymysql.cursors.DictCursor
    )

def geocode_address(address, city, state, zip_code):
    """Get coordinates using Nominatim (free geocoding service)"""
    full_address = f"{address}, {city}, {state} {zip_code}, USA"
    
    url = "https://nominatim.openstreetmap.org/search"
    params = {
        'q': full_address,
        'format': 'json',
        'limit': 1
    }
    headers = {
        'User-Agent': 'RealEstateDBMS/1.0'  # Required by Nominatim
    }
    
    try:
        response = requests.get(url, params=params, headers=headers)
        response.raise_for_status()
        data = response.json()
        
        if data:
            return float(data[0]['lat']), float(data[0]['lon'])
        return None, None
    except Exception as e:
        print(f"Error geocoding {full_address}: {e}")
        return None, None

def update_location_coordinates():
    """Update all locations without coordinates"""
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Get locations without coordinates
    query = """
        SELECT location_id, street_address, city, state, zip_code
        FROM Locations
        WHERE latitude IS NULL OR longitude IS NULL
    """
    cursor.execute(query)
    locations = cursor.fetchall()
    
    print(f"Found {len(locations)} locations to geocode")
    
    for i, loc in enumerate(locations, 1):
        print(f"Processing {i}/{len(locations)}: {loc['city']}, {loc['state']}")
        
        lat, lon = geocode_address(
            loc['street_address'],
            loc['city'],
            loc['state'],
            loc['zip_code']
        )
        
        if lat and lon:
            update_query = """
                UPDATE Locations
                SET latitude = %s, longitude = %s
                WHERE location_id = %s
            """
            cursor.execute(update_query, (lat, lon, loc['location_id']))
            conn.commit()
            print(f"  ✓ Updated: {lat}, {lon}")
        else:
            print(f"  ✗ Could not geocode")
        
        # Be nice to the free API - wait 1 second between requests
        time.sleep(1)
    
    cursor.close()
    conn.close()
    print("\nGeocoding complete!")

if __name__ == "__main__":
    update_location_coordinates()