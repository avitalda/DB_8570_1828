#!/usr/bin/env python
# generate_csvs.py
import csv
import random
import sys
import os

start_id = 4
total_rows = 400

def safe_open_write(path):
    """
    מנסה לפתוח קובץ לכתיבה עם הפרמטרים המודרניים.
    אם זה מרים TypeError (למשל בסביבה מאוד מיושנת), יחזור לפתיחה פשוטה.
    מחזיר file object פתוח במצב כתיבה.
    """
    try:
        return open(path, "w", newline="", encoding="utf-8")
    except TypeError:
        # גרסאות ישנות של Python עשויות לא לתמוך בפרמטרים אלה
        return open(path, "w")

def safe_open_read(path):
    """
    מנסה לקרוא עם encoding מודרני, ואם נכשל — קורא בלי פרמטר.
    """
    try:
        return open(path, "r", encoding="utf-8")
    except TypeError:
        return open(path, "r")
    except FileNotFoundError:
        raise

# ====== יצירת groceries ======
names = [
    "Rice", "Pasta", "Oil", "Sugar", "Flour", "Salt", "Tuna", "Beans",
    "Lentils", "Cereal", "Tea", "Coffee", "Tomato Sauce", "Peas", "Corn",
    "Soup Mix", "Olives", "Pickles", "Honey", "Jam", "Chips", "Biscuits",
    "Crackers", "Chocolate", "Milk Powder", "Ketchup", "Mustard", "Mayonnaise",
    "Canned Corn", "Canned Peas", "Canned Mushrooms", "Canned Tuna", "Canned Beans"
]

groceries = []
for i in range(start_id, start_id + total_rows):
    groceries.append([
        i,
        f"{random.choice(names)} {i}",
        round(random.uniform(3.0, 25.0), 2),
        random.randint(1, total_rows)
    ])

# ====== יצירת foodbasket ======
kinds = ["basic", "family", "holiday", "emergency"]
statuses = ["ready", "pending", "delivered"]

foodbasket = []
for i in range(start_id, start_id + total_rows):
    foodbasket.append([
        i,
        random.choice(kinds),
        random.choice(statuses),
        round(random.uniform(10.0, 40.0), 2),
        random.randint(1, total_rows),
        random.randint(1, total_rows)
    ])

# ====== כתיבה לקבצים ======
def write_csv_file(filename, header, rows):
    f = safe_open_write(filename)
    try:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    finally:
        f.close()

write_csv_file("groceries.csv",
               ["groceries_id", "groceries_name", "unit_price", "supplier_id"],
               groceries)

write_csv_file("foodbasket.csv",
               ["foodbasket_id", "kind", "status", "basketweight", "family_id", "volunteer_id"],
               foodbasket)

# ====== הדפסת מידע ובדיקת תוכן ======
def show_info_and_sample(filename, sample_lines=8):
    abspath = os.path.abspath(filename)
    print(f"\n📄 {filename} -> {abspath}")
    try:
        size = os.path.getsize(filename)
        print(f"   גודל הקובץ: {size} bytes")
    except OSError:
        print("   (לא הצלחנו לקבל גודל קובץ)")

    try:
        with safe_open_read(filename) as f:
            print("   דוגמה לשורות ראשונות:")
            for i, line in enumerate(f):
                if i >= sample_lines:
                    break
                print("   ", line.rstrip("\n"))
    except FileNotFoundError:
        print("   ❌ הקובץ לא נמצא.")

show_info_and_sample("groceries.csv", sample_lines=10)
show_info_and_sample("foodbasket.csv", sample_lines=10)

print("\n✅ סיום: שני הקבצים נוצרו. אם את עדיין רואה בעיה — הדבק כאן את ה־Traceback שקיבלת (הודעת השגיאה המלאה).")
print("גרסת Python שמריצה את הסקריפט:", sys.version.replace("\n", " "))
