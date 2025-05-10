from geopy.geocoders import Nominatim
import pandas as pd
from tqdm import tqdm

tqdm.pandas()

data_2022 = pd.read_csv('India2022Location.csv', low_memory=False)
data_2014 = pd.read_csv('India2014Location.csv', low_memory=False)

geolocator = Nominatim(user_agent="abcd")

data_2022['Location_Coordinate'] = data_2022.apply(lambda row: f"{row['lat_mask']},{row['lon_mask']}", axis=1)
data_2014['Location_Coordinate'] = data_2014.apply(lambda row: f"{row['lat_mask']},{row['lon_mask']}", axis=1)

# geolocator.reverse(x).raw['address'] can have either city or county extract which ever is available
# data_2014['District'] = data_2022['Location_Coordinate'].progress_apply(lambda x: (lambda location: location.raw['address'].get('state_district', '-1'))(geolocator.reverse(x)))
data_2022['District'] = data_2022['Location_Coordinate'].progress_apply(lambda x: geolocator.reverse(x).raw['address']['state_district'] if 'state_district' in geolocator.reverse(x).raw['address'] else '-1')

data_2022.to_csv('India2022LocationUpdated.csv', index=False)
# data_2014.to_csv('India2014LocationUpdated.csv', index=False)


# print(geolocator.reverse('23.0240306854248,72.5629501342774').raw['address'])

