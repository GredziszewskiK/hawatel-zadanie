import logging

import xlwt

logger = logging.getLogger('export')

class ExportToXLS:
    def __init__(self, file_name: str, data: list[dict], header: bool = True, sheet_name: str = 'Arkusz 1') -> None:
        self.header = header
        self.file_name = file_name
        self.data = data
        self.sheet_name = sheet_name

    def export(self) -> None:
        """Eksportuje dane wejsciowe w postaci listy slownikow do pliku xls"""
        logger.info('Rozpoczecie eksportu')
        try:
            workbook = xlwt.Workbook()
            worksheet = workbook.add_sheet(self.sheet_name)
            start_row = 0

            # dodawanie naglowka do pliku (nazwy kolumn z bazy)
            if self.header:
                logger.info('Dodawanie naglowka')
                columns = list(self.data[0].keys())
                for index, column in enumerate(columns):
                    worksheet.write(start_row, index, column)
                start_row = 1
            
            logger.info('Dodawanie danych')
            for rowindex, row in enumerate(self.data, start_row):
                for columnindex, column in enumerate(columns):
                    worksheet.write(rowindex, columnindex, row[column])

            workbook.save(self.file_name)
        except PermissionError as e:
            logger.error(e)
