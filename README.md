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
- [חלק ב](#-חלק-ב)
  - [שאילתות SELECT](#-שאילתות-SELECT)
  - [שאילתות UPDATE](#-שאילתות-UPDATE)
  - [שאילתות DELETE](#-שאילתות-DELETE)
  - [פקודות rollback & commit](#-פקודות)
  - [אילוצים](#-אילוצים)
- [חלק ג](#-חלק-ג)
  - [אינטגרציה](#-אינצגרציה)
  - [מבטים](#-מבטים)
  - 

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


<h2><span style="background-color: yellow;"> שלב ג: אינטגרציה ומבטים</span></h2>

על מנת לעשות את האינטגרציה עשינו מיזוג לשני בסיסי הנתונים.

ERD + DSD של בסיס הנתונים שקיבלנו: Food Delivery

<img width="793" height="571" alt="image (4)" src="https://github.com/user-attachments/assets/230b2263-834f-4ec7-87ab-5fc72c78f070" />

<img width="1205" height="579" alt="image (5)" src="https://github.com/user-attachments/assets/8f1611e3-bd3e-4d8b-b5e5-ead629453cae" />

ERD + DSD של בסיס הנתונים המאוחד

<img width="4092" height="1608" alt="ERD משותף" src="https://github.com/user-attachments/assets/f473683b-5ac8-485d-a69e-f7df20613a80" />

<img width="3062" height="888" alt="DSD משותף" src="https://github.com/user-attachments/assets/4b5b535f-d8fd-4540-9f83-5d62939eaf3b" />

החלטות שנעשו בזמן האינטגרציה:

כל הפקודות של האינטגרציה נמצאות בקובץ Integrate.sql.

האירגון שלנו- חלוקת סלי מזון.

הארגון של הקבוצה השניה- משלוחי מסעדות

לבסיס של בסיס הנתונים המשותף לקחנו את בסיס הנתונים שלנו וערכנו עליו שינויים.
מתנדב (אצלנו) ושליח (אצלם) התאחדו, והפכנו אותם לישות שליח עם אופציה לעבוד בשכר
(הוספנו תכונה משכורת).

משפחה (אצלנו) ולקוח (אצלם) התאחדו תחת הישות משפחה עם אופציה לתשלום (תכונה של
אופן התשלום) וכן תאריך לידה של אב המשפחה.

סל מזון (אצלנו) והזמנה (אצלם) התאחדו תחת הישות סל מזון, בשלב הקודם הוספנו תכונה
של תאריך הזמנה, ולכן בשלב זה אנחנו לא צריכות להוסיף תכונה.

מצרכים (אצלנו) וארוחה (אצלם) התאחדו תחת הישות מצרכים, הוספנו תכונה סוג, שבה
אפשר לבחור האם מדובר במצרך פשוט או בארוחה ממסעדה. 

ספק (אצלנו) ומסעדה (אצלם) התאחדו תחת הישות ספק, הוספנו תכונה אזור (בגלל שבטבלה מסעדה הייתה את התכונה הזאת) וכן את התכונה  amount בקשר Supplier_Groceries כי אצלם בקשר בין ארוחה למסעדה היתה את התכונה בקשר.

בנוסף שינינו את הקשר בין מצרכים לספק מיחיד לרבים לרבים לרבים (כי כך היה אצלם)
ולכן מחקנו את התכונה "מזהה ספק" מישות מצרכים,
ע"מ לשמור על הנתונים שהיו לנו יצרנו טבלת ביניים ששם הכנסנו את הקשר יחיד לרבים שהיה בטבלה המקורית שלנו בין מצרכים לספק (מפתח זר מזהה ספק בטבלת מצרכים) והוספנו את הערכים שלא מהווים כפילות לטבלת הרבים לרבים החדשה שיצרנו (Supplier_Groceries )
בטבלה זו גם שינינו את המפתחות הזרים בהתאמה.
בגלל שעבדנו על הטבלה שלהם קודם קידמנו את כל המזהים ב400 (כמו שעידכנו באינטגרציה) ורק אח"כ הכנסנו את שלנו.
כך גם עשינו בטבלה של groceries_nutrition (הקשר בין המוצר לבין הערך התזונתי שלו)

בנוסף, הוספנו קשרים לישות מצרכים עם קטגוריה וערך תזונתי. (בטבלה שלהם היה
קשר בין ארוחה לבין הישויות הנ"ל, בבסיס הנתונים המשותף כללנו כמובן את כל
התכונות שהיו בטבלאות של בסיס הנתונים שניתן לנו ע"מ לערוך אינטגרציה)

**מבטים:**

--מבט מנקודת המבט של האגף המקורי

--משלב FoodBasket + FoodBasket_Groceries + Groceries + Family

--נותן: שם משפחה + מספר סלים + ערך כספי כולל של כל המוצרים שקיבלו.
    
      CREATE VIEW family_basket_summary AS
      
      SELECT
      
          f.family_id,
          
          f.family_name,
          
          COUNT(DISTINCT fb.foodbasket_id) AS total_baskets,
          
          COALESCE(SUM(g.unit_price * fbg.quantity), 0) AS total_value
          
      FROM Family f
      
      LEFT JOIN FoodBasket fb ON fb.family_id = f.family_id
      
      LEFT JOIN FoodBasket_Groceries fbg ON fbg.foodbasket_id = fb.foodbasket_id
      
      LEFT JOIN Groceries g ON g.groceries_id = fbg.groceries_id
      
      GROUP BY f.family_id, f.family_name;


--בדיקת המבט

    SELECT * 
    
    FROM family_basket_summary
    
<img width="586" height="541" alt="צילום מסך 2025-12-10 150217" src="https://github.com/user-attachments/assets/948f0cdb-a58f-45c0-a461-2b2be9dd1648" />

    


--כל המשפחות שקיבלו סלים בשווי מעל 500 ש"ח

    SELECT * 
    
    FROM family_basket_summary
    
    WHERE total_value > 500;
    
<img width="580" height="408" alt="צילום מסך 2025-12-10 150103" src="https://github.com/user-attachments/assets/1b37005d-d055-40b8-9c96-e1f1d53401f1" />




--סידור המשפחות לפי מספר הסלים שקיבלו מהכי הרבה להכי מעט

    SELECT *
    
    FROM family_basket_summary
    
    ORDER BY total_baskets DESC;

<img width="674" height="410" alt="צילום מסך 2025-12-10 150037" src="https://github.com/user-attachments/assets/60e3e907-8e08-41ea-bccf-246e34e439d6" />


--מבט מנקודת המבט של האגף שקיבלנו

    CREATE VIEW dish_category AS
    
    SELECT
    
        g.groceries_id,
        
        g.groceries_name,
        
        g.unit_price,
        
        g.type,
        
        c.name AS category_name
        
    FROM Groceries g
    
    JOIN Category c
    
      ON g.category_id = c.category_id
      
    WHERE g.type = 'D';


--בדיקת המבט

    select * from dish_category
    
<img width="807" height="518" alt="image (3)" src="https://github.com/user-attachments/assets/69831688-5b74-428d-82e3-d9785232363f" />





--כמה מצרכי D יש בכל קטגוריה (כמה ארוחות)

    SELECT
    
        category_name,
        
        COUNT(*) AS num_items
        
    FROM dish_category
    
    GROUP BY category_name
    
    ORDER BY num_items DESC;
    
  <img width="363" height="510" alt="image (5)" src="https://github.com/user-attachments/assets/411830df-27cd-4b3b-ab9f-9ec8484d9cb6" />



--מחיר ממוצע של מצרכי D בכל קטגוריה

    SELECT
    
        category_name,
        
        ROUND(AVG(unit_price), 2) AS avg_price
        
    FROM groceries_d_by_category
    
    GROUP BY category_name
    
    ORDER BY avg_price DESC;
    
<img width="532" height="513" alt="image (6)" src="https://github.com/user-attachments/assets/4b0c9249-5219-4af0-a179-c260a2948b44" />


<h2><span style="background-color: yellow;"> שלב ד: כתיבת תוכניות</span></h2>

התוכנית main2:

הפונקציה basket_quality_score:

פונקציה זו מחשבת ציון איכות תזונתי לסל מזון על בסיס המוצרים הכלולים בו והערכים התזונתיים שלהם.

הפונקציה עוברת על כל המוצרים בסל באמצעות cursor מפורש, ושולפת עבור כל מוצר את ערכי הקלוריות, החלבון, השומן והפחמימות מטבלת groceries_nutrition.

לאחר שליפת הנתונים, הפונקציה מפחיתה נקודות מציון התחלתי בהתאם לכללים מוגדרים.

חישוב הציון מתבצע באופן שונה עבור:

מוצרים בסיסיים (type = 'B')

מוצרי ארוחה (type = 'M')

הפלט הוא ציון מספרי בין 0 ל־10, המייצג את איכות הסל מבחינה תזונתית.

קוד הפונקציה:

    CREATE OR REPLACE FUNCTION basket_quality_score(
    	p_foodbasket_id integer)
        RETURNS numeric
        LANGUAGE 'plpgsql'
        COST 100
        VOLATILE PARALLEL UNSAFE
    AS $BODY$
    DECLARE
      v_score numeric := 10;
    
      r record;
      v_cal numeric;
      v_pro numeric;
      v_fat numeric;
      v_carb numeric;
    
    --טוען את כל המוצרים שבסל
      cur CURSOR FOR
        SELECT g.groceries_id, g.type
        FROM foodbasket_groceries fg
        JOIN groceries g ON g.groceries_id = fg.groceries_id
        WHERE fg.foodbasket_id = p_foodbasket_id;
    BEGIN
      -- סל חייב להתקיים
      IF NOT EXISTS (SELECT 1 FROM foodbasket WHERE foodbasket_id = p_foodbasket_id) THEN
        RAISE EXCEPTION 'foodbasket_id % not found', p_foodbasket_id;
      END IF;
    
      OPEN cur;
      LOOP
        FETCH cur INTO r;
        EXIT WHEN NOT FOUND;

    -- להביא ערכים תזונתיים של המוצר (אם חסר ערך -> יהיה NULL)
    SELECT
      MAX(CASE WHEN nutrition_id = 1 THEN value END), -- Calories
      MAX(CASE WHEN nutrition_id = 2 THEN value END), -- Protein
      MAX(CASE WHEN nutrition_id = 3 THEN value END), -- Fat
      MAX(CASE WHEN nutrition_id = 4 THEN value END)  -- Carbs
    INTO v_cal, v_pro, v_fat, v_carb
    FROM groceries_nutrition
    WHERE groceries_id = r.groceries_id;

    -- type = 'B' (בסיסי)
    IF r.type = 'B' THEN
      IF v_fat IS NOT NULL AND v_fat > 150 THEN v_score := v_score - 1; END IF;
      IF v_cal IS NOT NULL AND v_cal > 25  THEN v_score := v_score - 1; END IF;
      IF v_pro IS NOT NULL AND v_pro < 100 THEN v_score := v_score - 1; END IF;
      IF v_carb IS NOT NULL AND v_carb > 30 THEN v_score := v_score - 1; END IF;

    -- type = 'M' (ארוחה)
    ELSIF r.type = 'M' THEN
      IF v_pro  IS NOT NULL AND v_pro  < 30 THEN v_score := v_score - 1; END IF;
      IF v_cal  IS NOT NULL AND v_cal  > 50 THEN v_score := v_score - 1; END IF;
      IF v_fat  IS NOT NULL AND v_fat  > 70 THEN v_score := v_score - 1; END IF;
      IF v_carb IS NOT NULL AND v_carb < 30 THEN v_score := v_score - 1; END IF;
    END IF;

    END LOOP;
    CLOSE cur;
    -- גבולות: 0..10


    IF v_score < 0 THEN v_score := 0; END IF;
    IF v_score > 10 THEN v_score := 10; END IF;
  
    RETURN v_score;
    END;
    $BODY$;

  דוגמת הרצה:

  <img width="598" height="466" alt="צילום מסך 2025-12-17 164120" src="https://github.com/user-attachments/assets/e1bd571a-91e8-4fe0-b08b-9730cdb28efb" />

  זריקת חריגה עבור סל שלא קיים:

  <img width="573" height="135" alt="image" src="https://github.com/user-attachments/assets/f0796be0-6828-447b-982c-eba5bb42ffba" />

fix_courier_city_mismatch() הפרוצדורה:

פרוצדורה זו מבצעת בדיקת התאמה בין שליחים למשפחות ומתקנת הקצאות שגויות של שליחים לסלי מזון.

הפרוצדורה עוברת על כל הסלים שלא נשלחו ובודקת האם השליח המשויך לכל סל מתגורר באותה עיר של המשפחה המקבלת את הסל.

במקרה של אי־התאמה, הפרוצדורה מחפשת שליח אחר המתגורר בעיר המשפחה ומעדכנת את הסל בהתאם.

קוד הפרוצדורה:

    CREATE OR REPLACE PROCEDURE fix_courier_city_mismatch()
    LANGUAGE plpgsql
    AS $$
    DECLARE
      r record;
      v_new_courier_id int;
    
      cur CURSOR FOR
        SELECT
          b.foodbasket_id,
          b.courier_id,
          f.city_id AS family_city_id,
          c.city_id AS courier_city_id
        FROM foodbasket b
        JOIN family f  ON f.family_id = b.family_id
        JOIN courier c ON c.courier_id = b.courier_id
        WHERE b.family_id IS NOT NULL
          AND b.courier_id IS NOT NULL
          AND b.status <> 'delivered';  -- לא נוגעים בסלים שנשלחו
    BEGIN
      OPEN cur;
    
      LOOP
        FETCH cur INTO r;
        EXIT WHEN NOT FOUND;

    BEGIN
      -- אם השליח כבר גר בעיר של המשפחה – אין מה לעשות
      IF r.family_city_id = r.courier_city_id THEN
        CONTINUE;
      END IF;

      -- חיפוש שליח שגר בעיר של המשפחה
      SELECT courier_id
      INTO v_new_courier_id
      FROM courier
      WHERE city_id = r.family_city_id
      ORDER BY courier_id
      LIMIT 1;


      -- אם נמצא שליח מתאים – מעדכנים את הסל
      IF v_new_courier_id IS NOT NULL THEN
        UPDATE foodbasket
        SET courier_id = v_new_courier_id
        WHERE foodbasket_id = r.foodbasket_id;
      END IF;

    EXCEPTION WHEN OTHERS THEN
      -- מדלגים על סל בעייתי וממשיכים
      RAISE NOTICE 'Basket % skipped due to error: %',
        r.foodbasket_id, SQLERRM;
    END;
    END LOOP;

    CLOSE cur;
    END;
    $$;

לפני הרצה:

השאילתה סופרת כמה סלים יש שאין התאמה בין עיר השליח לבין עיר המשפחה וגם קיים שליח בעיר של המשפחה.

<img width="627" height="651" alt="צילום מסך 2025-12-17 193410" src="https://github.com/user-attachments/assets/1ae423d6-3b93-429d-958d-318c32041a43" />

אחרי הרצה:

<img width="605" height="742" alt="צילום מסך 2025-12-17 193511" src="https://github.com/user-attachments/assets/f6b1db43-a905-4bdc-a332-4d4a90bb42c6" />




