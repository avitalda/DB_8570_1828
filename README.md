🥫 מיני פרויקט – בסיסי נתונים
✨ מגישות:
אביה יוסף ואביטל חדד  

📚 תוכן עניינים  

- [מבוא](#-מבוא)  
- [חלק א:](#-חלק-1-erd)  
  - [תרשים ERD כללי](#-תרשים-erd-כללי)  
  - [פירוט הישויות](#-פירוט-הישויות)  
- [ישויות במערכת](#-ישויות-במערכת)  
- [קשרים בין הישויות](#-קשרים-בין-הישויות)
- [גיבוי ושחזור](#-גיבוי)
- [חלק ב](#-גיבוי)
  - [שאילתות SELECT](#-גיבוי)
  - [גשאילתות UPDATE](#-גיבוי)
  - [שאילתות DELETE](#-גיבוי)
  - [פקודות rollback & commit](#-גיבוי)
  - [אילוצים](#-גיבוי)


נושא: חלוקת סלי מזון  

מבוא

המערכת נועדה לנהל ולתאם את פעילות חלוקת סלי המזון בארגון התנדבותי.
באמצעות המערכת ניתן לתעד את המשפחות המקבלות סיוע, את המתנדבים המעורבים בתהליך, את הספקים המספקים את המוצרים, ואת המידע על כל סל מזון שנבנה ונמסר.
המערכת שואפת לייעל את תהליך החלוקה, לאפשר מעקב ובקרה אחר הנתונים, ולספק תמונה מלאה על כל סבב חלוקה.

⚙️ הפונקציונליות העיקרית במערכת

ניהול נתונים בסיסיים:
הוספה, עדכון ומחיקה של משפחות, מתנדבים, ספקים, סלים ומוצרים.

בניית סלי מזון:
הרכבת סלים חדשים לפי סוג האירוע (חג, חירום וכו׳) והוספת מוצרים אליהם.

קישור בין ישויות:
שיוך מתנדבים לערים, משפחות לסלים, ומוצרים לספקים.

מעקב אחר סטטוס הסלים:
צפייה ועדכון במצב הסל — האם הוכן, נשלח או נמסר למשפחה.

דוחות וניתוחים:
הפקת נתונים סטטיסטיים כמו מספר סלים שחולקו לפי אזור, עלות כוללת של סלים, או רמת פעילות מתנדבים.

<h2><span style="background-color: yellow;"> שלב א: עיצוב , בניה, אכלוס נתונים וגיבוי</span></h2>
 

הדיאגרמה שלנו מתארת מערכת לניהול סלי מזון.

תרשים ERD כללי
<img width="4512" height="1797" alt="ERD Diagram" src="https://github.com/user-attachments/assets/d20d9ad0-2cfe-4c63-bc2d-8a4f3a63a0b0" />
פירוט הישויות
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
הכנסה לבסיס נתונים עם פקודות COPY:

<img width="550" height="106" alt="צילום מסך 2025-11-05 152135" src="https://github.com/user-attachments/assets/a008be3e-eca4-4692-b7c9-67effd287c98" />


מילוי באמצעות סקריפט Python

הסקריפט יוצר קובצי CSV לטבלאות:
Groceries, FoodBasket.

מילוי באמצעות אתר Mockaroo

נוצר קובץ CSV עבור טבלת:
FoodBasket_Groceries.
<img width="1315" height="244" alt="צילום מסך 2025-11-04 111930" src="https://github.com/user-attachments/assets/c62133bf-1565-4d22-9b06-c73774248fa3" />


גיבוי ושחזור:  
<img width="876" height="686" alt="image (3)" src="https://github.com/user-attachments/assets/1e8d8898-605f-4994-a442-0130f76fbc71" />


<img width="1448" height="92" alt="צילום מסך 2025-11-04 164245" src="https://github.com/user-attachments/assets/3fb8abce-574b-4b3c-bf24-9a177eca600a" />


<h2><span style="background-color: yellow;">שלב ב שאילתות ואילוצים:</span></h2>

**שאילתות select:**

5.לזהות אילו ספקים היו המשמעותיים ביותר מבחינת ערך כלכלי, מציג רשימת ספקים שסיפקו סחורה שערכה הכולל מעל לממוצע הכללי של כל הספקים — עם חישוב תת־שאילתא להשוואה לערך ממוצע.

    SELECT 

    s.supplier_name,
    
    ROUND(SUM(g.unit_price * fg.quantity), 2) AS total_value_supplied
    
    FROM Supplier s

    JOIN Groceries g ON s.supplier_id = g.supplier_id

    JOIN FoodBasket_Groceries fg ON g.groceries_id = fg.groceries_id

    GROUP BY s.supplier_name

    HAVING SUM(g.unit_price * fg.quantity) > 

    (SELECT AVG(total_value)
    
    FROM (
    
        SELECT SUM(g2.unit_price * fg2.quantity) AS total_value
        
        FROM Groceries g2
        
        JOIN FoodBasket_Groceries fg2 ON g2.groceries_id = fg2.groceries_id
        
        GROUP BY g2.supplier_id
        
    ) AS supplier_totals)

    ORDER BY total_value_supplied DESC;

<img width="603" height="56" alt="צילום מסך 2025-11-06 164656" src="https://github.com/user-attachments/assets/5e1ae484-c351-475b-9562-52924aad662d" />

<img width="412" height="198" alt="image" src="https://github.com/user-attachments/assets/1dfebac7-5d98-4ce8-94a1-c0c9c90a9108" />

6.מציג בכל עיר – כמה מתנדבים יש וכמה סלים נמסרו בפועל (סטטוס 'delivered').

    SELECT 
    c.city_name AS city,
    COUNT(DISTINCT v.volunteer_id) AS total_volunteers,
    COUNT(fb.foodbasket_id) AS total_baskets_delivered
    FROM city c
    JOIN volunteer v ON c.city_id = v.city_id
    LEFT JOIN foodbasket fb ON v.volunteer_id = fb.volunteer_id
    WHERE fb.status = 'delivered'
    GROUP BY c.city_name
    ORDER BY total_baskets_delivered DESC;


<img width="602" height="57" alt="צילום מסך 2025-11-06 171309" src="https://github.com/user-attachments/assets/bd812171-f6cc-4785-807f-63897d061c2c" />

<img width="580" height="203" alt="צילום מסך 2025-11-06 171319" src="https://github.com/user-attachments/assets/75d61c3d-f6de-4042-9719-2451d7dc61b2" />

7.מציגה את כל הסלים שעדיין לא נמסרו למרות שעברו 7 ימים ממועד המסירה הצפוי.
  
    SELECT 
    fb.foodbasket_id,
    fb.kind,
    fb.status,
    fb.dateofrecepit,
    v.volunteer_name,
    f.family_name,
    (CURRENT_DATE - fb.dateofrecepit) AS days_since_sent
    FROM foodbasket fb
    JOIN volunteer v ON fb.volunteer_id = v.volunteer_id
    JOIN family f ON fb.family_id = f.family_id
    WHERE fb.status <> 'delivered'
    AND (CURRENT_DATE - fb.dateofrecepit) > 7
    ORDER BY days_since_sent DESC;
   

<img width="610" height="42" alt="צילום מסך 2025-11-06 174327" src="https://github.com/user-attachments/assets/6d8ee7fb-a16d-4b34-a10a-080b1224a8e1" />

<img width="1202" height="199" alt="צילום מסך 2025-11-06 174352" src="https://github.com/user-attachments/assets/fe7f0ff4-7a22-42ab-8873-1c5a34843f95" />

8.זיהוי המתנדבים החדשים שהכי פעילים,

השאילתה מציגה את שמות המתנדבים שהצטרפו במהלך השנה הנוכחית,שם העיר של המתנדב וכמה סלים הוא חילק בפועל.


    SELECT 
    v.volunteer_name,
    c.city_name,
    v.joiningdate,
    COUNT(fb.foodbasket_id) AS baskets_delivered
    FROM volunteer v
    JOIN city c ON v.city_id = c.city_id
    JOIN foodbasket fb ON v.volunteer_id = fb.volunteer_id
    WHERE fb.status = 'delivered'
    AND EXTRACT(YEAR FROM v.joiningdate) = EXTRACT(YEAR FROM CURRENT_DATE)
    GROUP BY v.volunteer_name, c.city_name, v.joiningdate
    ORDER BY baskets_delivered DESC;


<img width="604" height="58" alt="צילום מסך 2025-11-07 110700" src="https://github.com/user-attachments/assets/54ba8e34-f29c-4326-8e6d-e2fa1ff67109" />

<img width="700" height="206" alt="צילום מסך 2025-11-07 110707" src="https://github.com/user-attachments/assets/783efee6-4b90-4787-be27-61c09a3447fc" />

**שאילתות UPDATE**

1. עדכון שמוסיפה לעמודה של dateOfRecepit

תאריך המסירה המשוער של סל המזון ערך רנדומלי בין תחילת שנת 2020 לשנת 2026.

    UPDATE foodbasket
    SET dateofrecepit =
    DATE '2020-01-01' 
    + (floor(random() * ((current_date+365 - DATE '2020-01-01')::int))) * INTERVAL '1 day';

<img width="865" height="453" alt="image" src="https://github.com/user-attachments/assets/5e34bfd2-9e76-4993-a74c-d4094d972790" />

<img width="866" height="256" alt="image" src="https://github.com/user-attachments/assets/d9f85f48-2296-4ecb-add3-8580f4ae223f" />


<img width="865" height="126" alt="image" src="https://github.com/user-attachments/assets/a8cf7657-23e4-43d1-99d2-7bc5fff817bb" />



2.מעדכנת את הסטטוס של הסלים כך שכל סל שתאריך המסירה המשוער שלו עוד לא היה יעודכן מ'נמסר' ל'ממתין'. (תקינות נתונים)

    UPDATE foodbasket
    SET status = 'pending'
    WHERE dateofrecepit <= CURRENT_DATE
    AND status = 'delivered';

<img width="865" height="241" alt="image" src="https://github.com/user-attachments/assets/868e0444-ebf4-45a3-9a3b-b78dc7dbc16e" />

<img width="865" height="566" alt="image" src="https://github.com/user-attachments/assets/2383e78b-10c7-4438-b9e5-a7713c84a9b4" />

<img width="865" height="155" alt="image" src="https://github.com/user-attachments/assets/2549548a-521a-4199-afc7-8f9d1ab2d661" />

3.מעדכן את הסוג של הסל שתאריך החלוקה המשוער שלו הוא 16\6 (לא משנה באיזה שנה) לסוג 

"חג". (סתם נתנו דוג' לתאריך. אפשר לשנות את התאריך לפי מה שרוצים.)

    UPDATE foodbasket
    SET dateofrecepit =
    DATE '2020-01-01' 
    + (floor(random() * ((current_date+365 - DATE '2020-01-01')::int))) * INTERVAL '1 day';

<img width="865" height="573" alt="image" src="https://github.com/user-attachments/assets/8c05c913-c12e-4c59-a6ff-b080e6fa9125" />

<img width="865" height="171" alt="image" src="https://github.com/user-attachments/assets/3b1ce0f7-6095-446e-98da-cbf8a6fcc1d0" />

<img width="866" height="136" alt="image" src="https://github.com/user-attachments/assets/d5429202-6527-4b9d-a839-b6878701399e" />


**שאילתות DELETE**



