import logging

import requests


logger = logging.getLogger('nbp')

class NBPApiReader:
    def __init__(self, url: str, table: str = 'a') -> None:
        self.table = table
        self.url = url

    def get_current_exchangerate(self, currency_code) -> float:
        """Pobiera aktualny kurs, dla wskazanego kodu waluty w formacie ISO 8601, z api NBP."""
        rate = None
        try:
            logger.info(f'Pobieranie kursu z tabeli: {self.table} dla {currency_code}')
            response = requests.get(f'{self.url}api/exchangerates/rates/{self.table}/{currency_code}/', timeout=10)
            response.raise_for_status()
            rate = response.json()['rates'][0]['mid']
        except requests.exceptions.HTTPError as errh:
            logger.error(errh)
        except requests.exceptions.ConnectionError as errc:
            logger.error(errc)
        except requests.exceptions.Timeout as errt:
            logger.error(errt)
        except requests.exceptions.RequestException as err:
            logger.error(err)
        return rate
