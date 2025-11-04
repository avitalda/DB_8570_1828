🥫 מיני פרויקט – בסיסי נתונים
✨ מגישות:
 
אביה יוסף ואביטל חדד  

📚 תוכן עניינים  

- [מבוא](#-מבוא)  
- [חלק 1: ERD](#-חלק-1-erd)  
  - [תרשים ERD כללי](#-תרשים-erd-כללי)  
  - [פירוט הישויות](#-פירוט-הישויות)  
- [ישויות במערכת](#-ישויות-במערכת)  
- [קשרים בין הישויות](#-קשרים-בין-הישויות)
- [גיבוי](#-גיבוי)
 

נושא: (חלוקת) סלי מזון  

חלק 1: ERD

הדיאגרמה שלנו מתארת מערכת לניהול סלי מזון.

🖼️ תרשים ERD כללי:
<img width="4512" height="1797" alt="ERD Diagram" src="https://github.com/user-attachments/assets/d20d9ad0-2cfe-4c63-bc2d-8a4f3a63a0b0" />
🖼️ פירוט הישויות:
<img width="1993" height="843" alt="ERD Entities" src="https://github.com/user-attachments/assets/3a978b1c-c369-4807-950a-2922aec06cde" />
🧱 ישויות במערכת
| שם הישות       | תיאור                                   | תכונות                                                     |
| -------------- | --------------------------------------- | ---------------------------------------------------------- |
| **City**       | עיר בה פועלים הספקים, המשפחות והמתנדבים | `City_ID`, `City_Name`, `Region`                           |
| **Volunteer**  | מתנדב בארגון                            | `Volunteer_ID`, `Volunteer_Name`, `JoiningDate`, `City_ID` |
| **Family**     | משפחה המקבלת סל מזון                    | `Family_ID`, `Family_Name`, `Number_Of_People`, `City_ID`  |
| **Supplier**   | ספק המספק מוצרי מזון                    | `Supplier_ID`, `Supplier_Name`, `Phone_Number`             |
| **Groceries**  | מוצרי המזון עצמם                        | `Groceries_ID`, `Groceries_Name`, `Unit_Price`             |
| **FoodBasket** | סל מזון המחולק למשפחות                  | `FoodBasket_ID`, `Kind`, `Status`, `BasketWeight`          |

🔗 קשרים בין הישויות

כל הקשרים הם מסוג 1 לרבים (One-to-Many)
מלבד הקשר בין FoodBasket ל-Groceries, שהוא רבים לרבים (Many-to-Many).
לכן נוצרה טבלת ביניים:
| טבלה                     | תיאור                    | תכונות נוספות               |
| ------------------------ | ------------------------ | --------------------------- |
| **FoodBasket_Groceries** | קשר בין סלי מזון למוצרים | `Quantity` – כמות המוצר בסל |
🗃️ שיטות למילוי נתונים בטבלאות (Data Population)

מילוי באמצעות קובצי CSV שנוצרו על ידי AI

טבלאות: City, Volunteer, Family, Supplier.

מילוי באמצעות סקריפט Python

הסקריפט יוצר קובצי CSV לטבלאות:
Groceries, FoodBasket.

מילוי באמצעות אתר Mockaroo

נוצר קובץ CSV עבור טבלת:
FoodBasket_Groceries.
<img width="1315" height="244" alt="צילום מסך 2025-11-04 111930" src="https://github.com/user-attachments/assets/c62133bf-1565-4d22-9b06-c73774248fa3" />

