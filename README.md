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
  - [שאילתות UPDATE](#-גיבוי)
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

**שאילתות SELECT:**

1.מציגה את שם המשפחה של מקבל הסל, את העיר שלו, ואת שם המתנדב שחילק את הסל,

אך רק עבור הסלים שחולקו על ידי מתנדבים שהצטרפו בשנת 2024

    SELECT 
    f.family_name,
    v.volunteer_name,
    c.city_name,
    FROM foodbasket fb
    JOIN family f ON fb.family_id = f.family_id
    JOIN volunteer v ON fb.volunteer_id = v.volunteer_id
    JOIN city c ON f.city_id = c.city_id
    WHERE EXTRACT(YEAR FROM v.joiningdate) = 2024
    ORDER BY v.volunteer_id DESC;

<img width="865" height="519" alt="image" src="https://github.com/user-attachments/assets/a5ecc92d-d1a0-4539-af2a-3c5decc4b7b5" />

<img width="865" height="121" alt="image" src="https://github.com/user-attachments/assets/edd46488-537c-4447-ba13-568cbacc846a" />

2.מציגה את כל הסלים שחולקו בשנת 2025, כולל התאריך בו חולק הסל (ממויין לפי סדר עולה), 

שם המשפחה של המקבל, שם המתנדב שהעביר את הסל, וסוג הסל.

    SELECT 
    f.family_name,
    v.volunteer_name,
    fb.kind,
    fb.dateofreceipt
    FROM foodbasket fb
    JOIN family f ON fb.family_id = f.family_id
    JOIN volunteer v ON fb.volunteer_id = v.volunteer_id
    JOIN city c ON f.city_id = c.city_id
    WHERE EXTRACT(YEAR FROM fb.dateofreceipt) = 2025
    ORDER BY fb.dateofreceipt ASC;

  <img width="865" height="738" alt="image" src="https://github.com/user-attachments/assets/99cefa0e-7501-4d51-93ff-d56143a212b7" />

<img width="865" height="106" alt="image" src="https://github.com/user-attachments/assets/43be961f-1c05-4a0e-af92-2b25318f8d7d" />


3.כמות המצרכים הכוללת שקבלה כל משפחה.

    SELECT 
    f.family_name,
    SUM(fg.quantity) AS total_items,
    COUNT(DISTINCT fb.foodbasket_id) AS baskets_count
    FROM family f
    JOIN foodbasket fb ON f.family_id = fb.family_id
    JOIN foodbasket_groceries fg ON fb.foodbasket_id = fg.foodbasket_id
    GROUP BY f.family_name
    ORDER BY total_items DESC;

  <img width="865" height="532" alt="image" src="https://github.com/user-attachments/assets/3ef2ab67-0670-4b94-8132-d5ce8c93f54e" />
  
  <img width="865" height="167" alt="image" src="https://github.com/user-attachments/assets/1e5e548f-8623-4e13-a20d-f612f1997ca1" />

4.רשימת המתנדבים והעיר שלהם, כולל מספר המשפחות שהם עזרו להם ממוין לפי שם המשפחה. 

    SELECT 
    v.volunteer_name,
    c.city_name,
    COUNT(DISTINCT fb.family_id) AS families_helped
    FROM volunteer v
    JOIN city c ON v.city_id = c.city_id
    JOIN foodbasket fb ON fb.volunteer_id = v.volunteer_id
    GROUP BY v.volunteer_name, c.city_name
    ORDER BY families_helped DESC;

  <img width="865" height="620" alt="image" src="https://github.com/user-attachments/assets/e1c610d8-513f-49c4-bb4a-dabfcfcc7d78" />

  <img width="865" height="114" alt="image" src="https://github.com/user-attachments/assets/09047af7-62f1-4a95-bb86-d936baefae4f" />



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
    SET kins = 'holiday'
    WHERE EXTRACT(MONTH FROM dateofreceipt) = 6
    AND EXTRACT(DAY FROM dateofreceipt) = 16;

<img width="865" height="573" alt="image" src="https://github.com/user-attachments/assets/8c05c913-c12e-4c59-a6ff-b080e6fa9125" />

<img width="865" height="171" alt="image" src="https://github.com/user-attachments/assets/3b1ce0f7-6095-446e-98da-cbf8a6fcc1d0" />

<img width="866" height="136" alt="image" src="https://github.com/user-attachments/assets/d5429202-6527-4b9d-a839-b6878701399e" />


**שאילתות DELETE**
 
 עלמנת לבצע את שאילתות המחיקה היינו צריכות שינויים בהגדרות של המפתחות הזרים:

אם סל נמחק בסכמה foodbasket אז ימחק אוטומטית הסלים שקשורים אליו בקשר foodbasket_groceries.

הסבר: ON DELETE CASCADE אומר ל־PostgreSQL:

"אם רשומה מטבלת foodbasket נמחקת — תמחק אוטומטית גם את כל הרשומות המשויכות אליה ב־foodbasket_groceries."



    ALTER TABLE foodbasket_groceries
    DROP CONSTRAINT foodbasket_groceries_foodbasket_id_fkey;
 
    ALTER TABLE foodbasket_groceries
    ADD CONSTRAINT foodbasket_groceries_foodbasket_id_fkey
    FOREIGN KEY (foodbasket_id)
    REFERENCES foodbasket(foodbasket_id)
    ON DELETE CASCADE;

2.אם ספק נמחק אז גם כל המוצרים שלו ימחקו.

    ALTER TABLE groceries
    DROP CONSTRAINT groceries_supplier_id_fkey;


    ALTER TABLE groceries
    ADD CONSTRAINT groceries_supplier_id_fkey
    FOREIGN KEY (supplier_id)
    REFERENCES supplier(supplier_id)
    ON DELETE CASCADE;

3.אם מחקתי משפחה אז גם כל הסלים שלה ימחקו.

    ALTER TABLE foodbasket
    DROP CONSTRAINT foodbasket_family_id_fkey;

    ALTER TABLE foodbasket
    ADD CONSTRAINT foodbasket_family_id_fkey
    FOREIGN KEY (family_id)
    REFERENCES family(family_id)
    ON DELETE CASCADE;



    
1.מחיקת כל הסלים שנשלחו לפני השלוש שנים האחרונות.
           
    DELETE FROM foodbasket
    WHERE dateofrecepit <= (CURRENT_DATE - INTERVAL '3 years');

<img width="685" height="397" alt="צילום מסך 2025-11-07 120740" src="https://github.com/user-attachments/assets/718b14ce-b62a-4866-8217-2b3a6ca0d397" />

<img width="386" height="43" alt="image" src="https://github.com/user-attachments/assets/5c9004af-dc13-42a8-abc9-107e7d0cf5dc" />

<img width="981" height="302" alt="image" src="https://github.com/user-attachments/assets/e383b735-e134-49f6-9b80-99f3a9a78da2" />

2.מחיקת כל הספקים שלא מספקים אף מוצר.

    DELETE FROM supplier s
    WHERE NOT EXISTS (
    SELECT 1
    FROM groceries g
    WHERE g.supplier_id = s.supplier_id
    );


<img width="540" height="457" alt="image" src="https://github.com/user-attachments/assets/32631567-e1b7-4f0d-8cdd-44a1160e9e4b" />

<img width="503" height="303" alt="image" src="https://github.com/user-attachments/assets/2e727ce2-818f-43b1-af19-f944dbdae5c3" />

<img width="552" height="365" alt="image" src="https://github.com/user-attachments/assets/7e52d97c-b80d-4dc2-b859-aea7341dadbb" />



3.מחיקת כל המשפחות שמספר הנפשות במשפחה הוא מתחת ל3 (אם נרצה למשל לקזז מהתקציב ונחליט לעזור רק למשפחות עם שני ילדים ומעלה).

    DELETE FROM family
    WHERE number_of_people < 3;

<img width="596" height="327" alt="image" src="https://github.com/user-attachments/assets/70000c0d-5a14-46e6-846d-d54d70cb2767" />

<img width="532" height="117" alt="image" src="https://github.com/user-attachments/assets/53de6469-7f25-4583-9687-b7ec82c88346" />

<img width="618" height="233" alt="image" src="https://github.com/user-attachments/assets/3ed147fe-a155-46ee-8535-a3b416160ad0" />



**פקודות Rollback & Commit**

Rollback:

<img width="641" height="378" alt="image" src="https://github.com/user-attachments/assets/c78b45c5-6051-4be0-b208-6f64abb9003e" />

<img width="623" height="353" alt="image" src="https://github.com/user-attachments/assets/2e536f84-a51f-4737-98ee-e92198ac37fb" />

Commit:

<img width="598" height="361" alt="image" src="https://github.com/user-attachments/assets/f02f5bcc-0c38-4814-badc-53d855fa8d20" />

<img width="675" height="361" alt="image" src="https://github.com/user-attachments/assets/bf9c8fad-dc8d-4be7-9c6f-205b001fbec1" />


**אילוצים**
1. אילוץ NOT NULL. שם משפחה לא יכול להיות חסר ערך.

       ALTER TABLE Family

       ALTER COLUMN family_name SET NOT NULL;

הכנסה סותרת + תמונת שגיאה:
<img width="865" height="408" alt="image" src="https://github.com/user-attachments/assets/e3a7951a-8881-46fe-bf49-1b86fb9267e7" />


2. אילוץ DEFAULT. ערך ברירת מחדל בסטטוס סל הוא "ממתין"
   
        ALTER TABLE FoodBasket

        ALTER COLUMN status SET DEFAULT 'Pending';


במקרה זה אין נתונים סותרים להכניס. כיוון שהאילוץ הוא הכנסת ערך דיפולטיבי.

3.אילוץ CHECK. בדיקה האם תאריך ההצטרפות של המתנדב הוא תקין- בין שנת 2020 לתאריך הנוכחי.

    ALTER TABLE Volunteer
    
    ADD CONSTRAINT chk_join_year 
    
    CHECK (joiningdate >= DATE '2020-01-01' AND joiningdate <= CURRENT_DATE);

הכנסה סותרת + תמונת שגיאה:
<img width="865" height="403" alt="image" src="https://github.com/user-attachments/assets/64266ff5-1ea5-4434-858f-907a7b745ef0" />





 

 
