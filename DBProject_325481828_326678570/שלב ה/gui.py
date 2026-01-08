import tkinter as tk
from tkinter import messagebox
import psycopg2

# --- חיבור למסד הנתונים ---
try:
    conn = psycopg2.connect(
        host="localhost",
        port=5432,
        database="FoodDelivery",
        user="postgres",
        password="1234"
    )
    cur = conn.cursor()
except Exception as e:
    print("Error connecting to database:", e)
    exit()

# ===== עיצוב גלובלי =====
COLORS = {
    'bg_gradient_start': '#667eea',
    'bg_gradient_end': '#764ba2',
    'bg_main': '#f0f4f8',
    'primary': '#667eea',
    'secondary': '#764ba2',
    'success': '#48bb78',
    'danger': '#f56565',
    'dark': '#2d3748',
    'light': '#ffffff',
    'text_dark': '#2d3748',
    'text_light': '#718096',
    'button_hover': '#5a67d8',
    'shadow': '#e2e8f0'
}

FONTS = {
    'header': ('Segoe UI', 24, 'bold'),
    'subheader': ('Segoe UI', 18, 'bold'),
    'button': ('Segoe UI', 11, 'bold'),
    'label': ('Segoe UI', 11),
    'entry': ('Segoe UI', 11),
    'text': ('Consolas', 10)
}


def set_half_screen(window):
    screen_width = window.winfo_screenwidth()
    screen_height = window.winfo_screenheight()

    width = screen_width // 2
    height = screen_height // 2

    x = (screen_width - width) // 2
    y = (screen_height - height) // 2

    window.geometry(f"{width}x{height}+{x}+{y}")
    window.resizable(False, False)
    window.configure(bg=COLORS['bg_main'])


# -- חלון עובד--
def show_courier_window(courier_id):
    courier_window = tk.Toplevel(root)
    courier_window.title("Courier Panel")
    set_half_screen(courier_window)

    # ================= Frame ראשי =================
    main_frame = tk.Frame(courier_window, bg=COLORS['bg_main'])
    main_frame.pack(fill=tk.BOTH, expand=True)

    # ================= כותרת =================
    header = tk.Label(main_frame, text="🚚 Courier Panel", font=FONTS['header'],
                      bg=COLORS['bg_main'], fg=COLORS['primary'])
    header.pack(pady=40)

    # ================= אזור כפתורים מרכזי =================
    center_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
    center_frame.pack(expand=True)

    # --- פונקציית הצגת הסלים ---
    def show_baskets(courier_id):
        basket_window = tk.Toplevel(root)
        basket_window.title("Food Baskets")
        set_half_screen(basket_window)

        # Header
        header_frame = tk.Frame(basket_window, bg=COLORS['primary'], height=60)
        header_frame.pack(fill=tk.X)
        header_frame.pack_propagate(False)

        tk.Label(header_frame, text="📦 My Food Baskets", font=FONTS['subheader'],
                 bg=COLORS['primary'], fg=COLORS['light']).pack(pady=15)

        # יצירת Scrollbar + Text
        text_frame = tk.Frame(basket_window, bg=COLORS['bg_main'])
        text_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        scrollbar = tk.Scrollbar(text_frame)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        text = tk.Text(text_frame, width=80, height=20, yscrollcommand=scrollbar.set,
                       font=FONTS['text'], bg=COLORS['light'], fg=COLORS['text_dark'],
                       relief=tk.FLAT, borderwidth=0, padx=15, pady=15)
        text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        scrollbar.config(command=text.yview)

        # שאילתת הסלים של המתנדב
        cur.execute(
            "SELECT foodbasket_id, kind, status, basketweight, dateofrecepit FROM foodbasket WHERE courier_id=%s",
            (courier_id,)
        )
        baskets = cur.fetchall()

        if not baskets:
            text.insert(tk.END, "No baskets found for this courier.\n")
        else:
            # כותרת מסודרת
            text.insert(tk.END,
                        f"{'ID'.ljust(8)}{'Kind'.ljust(20)}{'Status'.ljust(15)}{'Weight'.ljust(10)}{'Delivery Date'.ljust(15)}\n")
            text.insert(tk.END, "─" * 70 + "\n")

            # הוספת הסלים עם הזחות
            for basket in baskets:
                basket_id = str(basket[0]).ljust(8)
                kind = str(basket[1]).ljust(20)
                status = str(basket[2]).ljust(15)
                weight = str(basket[3]).ljust(10)
                delivery_date = str(basket[4]).ljust(15)
                text.insert(tk.END, f"{basket_id}{kind}{status}{weight}{delivery_date}\n")

        text.config(state=tk.DISABLED)

    # כפתור מעוצב
    btn_baskets = tk.Button(center_frame, text="📦 Show My Baskets",
                            command=lambda: show_baskets(courier_id),
                            width=20, height=2, font=FONTS['button'],
                            bg=COLORS['primary'], fg=COLORS['light'],
                            relief=tk.FLAT, cursor='hand2', borderwidth=0)
    btn_baskets.pack(pady=10)

    # ================= אזור תחתון =================
    bottom_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
    bottom_frame.pack(side=tk.BOTTOM, anchor="e", padx=20, pady=20)

    def return_to_login():
        courier_window.destroy()
        root.deiconify()
        entry_username.delete(0, tk.END)
        entry_password.delete(0, tk.END)

    tk.Button(bottom_frame, text="Return", width=8, font=FONTS['button'],
              command=return_to_login, bg=COLORS['text_light'], fg=COLORS['light'],
              relief=tk.FLAT, cursor='hand2').pack(side=tk.RIGHT, padx=5)

    tk.Button(bottom_frame, text="Close", width=8, font=FONTS['button'],
              command=courier_window.destroy, bg=COLORS['danger'], fg=COLORS['light'],
              relief=tk.FLAT, cursor='hand2').pack(side=tk.RIGHT, padx=5)


# --חלון מנהל--
def show_admin_window():
    admin_window = tk.Toplevel(root)
    admin_window.title("Admin Panel")
    set_half_screen(admin_window)

    # ================= Frame ראשי =================
    main_frame = tk.Frame(admin_window, bg=COLORS['bg_main'])
    main_frame.pack(fill=tk.BOTH, expand=True)

    # ================= כותרת =================
    header = tk.Label(main_frame, text="⚙️ Admin Panel", font=FONTS['header'],
                      bg=COLORS['bg_main'], fg=COLORS['secondary'])
    header.pack(pady=40)

    # ================= אזור כפתורים מרכזי =================
    center_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
    center_frame.pack(expand=True)

    button_style = {
        "width": 18, "height": 3, "font": FONTS['button'],
        "bg": COLORS['primary'], "fg": COLORS['light'],
        "relief": tk.FLAT, "cursor": 'hand2', "borderwidth": 0
    }

    # הוספת סל
    def add_foodbasket():
        try:
            add_window = tk.Toplevel(admin_window)
            add_window.title("Add Food Basket")
            set_half_screen(add_window)

            main_frame = tk.Frame(add_window, bg=COLORS['bg_main'])
            main_frame.pack(fill=tk.BOTH, expand=True)

            tk.Label(main_frame, text="➕ Add Food Basket", font=FONTS['subheader'],
                     bg=COLORS['bg_main'], fg=COLORS['primary']).pack(pady=30)

            form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
            form_frame.pack(expand=True)

            def form_row(row, label_text):
                tk.Label(form_frame, text=label_text, font=FONTS['label'], width=22, anchor="w",
                         bg=COLORS['bg_main'], fg=COLORS['text_dark']
                         ).grid(row=row, column=0, padx=(0, 20), pady=8, sticky="w")

                entry = tk.Entry(form_frame, width=32, font=FONTS['entry'],
                                 relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
                entry.grid(row=row, column=1, pady=8)
                return entry

            entry_basket_id = form_row(0, "Basket ID:")
            entry_kind = form_row(1, "Kind:")
            entry_status = form_row(2, "Status:")
            entry_weight = form_row(3, "Basket Weight:")
            entry_courier_id = form_row(4, "Courier ID:")
            entry_family_id = form_row(5, "Family ID (optional):")

            button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
            button_frame.pack(side=tk.BOTTOM, anchor="e", padx=40, pady=25)

            def add_basket_button():
                try:
                    basket_id = int(entry_basket_id.get())
                    kind = entry_kind.get().strip()
                    status = entry_status.get().strip()
                    weight = float(entry_weight.get())
                    courier_id = int(entry_courier_id.get())

                    family_id_input = entry_family_id.get().strip()
                    family_id = int(family_id_input) if family_id_input else None

                    cur.execute("""
                            INSERT INTO foodbasket
                            (foodbasket_id, kind, status, basketweight, family_id, courier_id, dateofrecepit)
                            VALUES (%s, %s, %s, %s, %s, %s, %s)
                        """, (basket_id, kind, status, weight, family_id, courier_id, None))
                    conn.commit()

                    messagebox.showinfo("Success", f"Food basket {basket_id} added successfully!")
                    add_window.destroy()

                except ValueError:
                    conn.rollback()
                    messagebox.showerror("Error", "Please fill all required fields correctly")
                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", f"Database error:\n{str(e)}")

            tk.Button(button_frame, text="Add Basket", width=16, font=FONTS['button'],
                      command=add_basket_button, bg=COLORS['success'], fg=COLORS['light'],
                      relief=tk.FLAT, cursor='hand2').pack()

        except Exception as e:
            messagebox.showerror("Error", str(e))


    def baskets_management():
        def open_add_basket(parent_window):
            parent_window.destroy()
            add_foodbasket()

        def delete_basket():
            delete_window = tk.Toplevel(admin_window)
            delete_window.title("Delete Basket")
            set_half_screen(delete_window)

            header_frame = tk.Frame(delete_window, bg=COLORS['danger'], height=60)
            header_frame.pack(fill=tk.X)
            header_frame.pack_propagate(False)

            tk.Label(header_frame, text="🗑️ Delete Basket", font=FONTS['subheader'],
                     bg=COLORS['danger'], fg=COLORS['light']).pack(pady=15)

            form_frame = tk.Frame(delete_window, bg=COLORS['bg_main'])
            form_frame.pack(expand=True, fill=tk.BOTH, padx=20, pady=20)

            tk.Label(form_frame, text="Foodbasket ID:", font=FONTS['text'],
                     bg=COLORS['bg_main'], fg=COLORS['text_dark']).pack(pady=(10, 5))

            basket_id_entry = tk.Entry(form_frame, font=FONTS['text'], width=25,
                                       relief=tk.FLAT, bg=COLORS['light'])
            basket_id_entry.pack(pady=(0, 15))

            def do_delete():
                basket_id = basket_id_entry.get().strip()
                if not basket_id.isdigit():
                    messagebox.showerror("Error", "Please enter a valid numeric foodbasket_id.")
                    return

                try:
                    cur.execute("SELECT 1 FROM foodbasket WHERE foodbasket_id = %s", (int(basket_id),))
                    if cur.fetchone() is None:
                        messagebox.showinfo("Delete Basket", f"Basket {basket_id} not found.")
                        return

                    cur.execute("DELETE FROM foodbasket WHERE foodbasket_id = %s", (int(basket_id),))
                    conn.commit()
                    messagebox.showinfo("Success", f"Basket {basket_id} deleted successfully.")
                    delete_window.destroy()
                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", f"Database error:\n{str(e)}")

            tk.Button(form_frame, text="Delete", command=do_delete, width=16, font=FONTS['button'],
                      bg=COLORS['danger'], fg=COLORS['light'], relief=tk.FLAT, cursor='hand2').pack(pady=5)

        def open_delete_basket(parent_window):
            parent_window.destroy()
            delete_basket()

        def basket_score():
            score_window = tk.Toplevel(admin_window)
            score_window.title("Basket Quality Score")
            set_half_screen(score_window)

            header_frame = tk.Frame(score_window, bg=COLORS['secondary'], height=60)
            header_frame.pack(fill=tk.X)
            header_frame.pack_propagate(False)

            tk.Label(header_frame, text="⭐ Basket Quality Score", font=FONTS['subheader'],
                     bg=COLORS['secondary'], fg=COLORS['light']).pack(pady=15)

            form_frame = tk.Frame(score_window, bg=COLORS['bg_main'])
            form_frame.pack(expand=True, fill=tk.BOTH, padx=20, pady=20)

            tk.Label(form_frame, text="Foodbasket ID:", font=FONTS['text'],
                     bg=COLORS['bg_main'], fg=COLORS['text_dark']).pack(pady=(10, 5))

            basket_id_entry = tk.Entry(form_frame, font=FONTS['text'], width=25,
                                       relief=tk.FLAT, bg=COLORS['light'])
            basket_id_entry.pack(pady=(0, 15))

            def calc_score():
                basket_id = basket_id_entry.get().strip()
                if not basket_id.isdigit():
                    messagebox.showerror("Error", "Please enter a valid numeric foodbasket_id.")
                    return
                try:
                    cur.execute("SELECT basket_quality_score(%s)", (int(basket_id),))
                    res = cur.fetchone()
                    if res is None:
                        messagebox.showerror("Error", "No result returned from function.")
                        return
                    messagebox.showinfo("Basket Quality Score", f"For basket {basket_id}: quality score = {res[0]}")
                except Exception as e:
                    messagebox.showerror("Error", f"Database error:\n{str(e)}")

            tk.Button(form_frame, text="Calculate", command=calc_score, width=16, font=FONTS['button'],
                      bg=COLORS['secondary'], fg=COLORS['light'], relief=tk.FLAT, cursor='hand2').pack(pady=5)

        def open_score_window(parent_window):
            parent_window.destroy()
            basket_score()

        # ===== NEW: Update Basket (status) =====
        def update_basket():
            update_window = tk.Toplevel(admin_window)
            update_window.title("Update Basket")
            set_half_screen(update_window)

            main_frame = tk.Frame(update_window, bg=COLORS['bg_main'])
            main_frame.pack(expand=True, fill=tk.BOTH, padx=20, pady=20)

            tk.Label(main_frame, text="✏️ Update Basket", font=FONTS['subheader'],
                     bg=COLORS['bg_main'], fg=COLORS['primary']).pack(pady=20)

            form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
            form_frame.pack(pady=10, anchor="center")

            tk.Label(form_frame, text="Basket ID:", font=FONTS['label'],
                     bg=COLORS['bg_main'], fg=COLORS['text_dark']).grid(row=0, column=0, sticky="w", pady=5)
            entry_basket_id = tk.Entry(form_frame, font=FONTS['entry'], width=20,
                                       relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
            entry_basket_id.grid(row=0, column=1, pady=5, padx=5)

            tk.Label(form_frame, text="Status:", font=FONTS['label'],
                     bg=COLORS['bg_main'], fg=COLORS['text_dark']).grid(row=1, column=0, sticky="w", pady=5)

            status_var = tk.StringVar(value="pending")
            status_menu = tk.OptionMenu(form_frame, status_var, "pending", "delivered")
            status_menu.config(font=FONTS['entry'], bg=COLORS['light'], fg=COLORS['text_dark'],
                               relief=tk.FLAT, highlightthickness=0, borderwidth=0, width=18)
            status_menu.grid(row=1, column=1, pady=5, padx=5, sticky="w")

            def confirm_update():
                basket_id = entry_basket_id.get().strip()
                new_status = status_var.get().strip()

                if not basket_id.isdigit():
                    messagebox.showerror("Error", "Please enter a valid numeric Basket ID.")
                    return

                try:
                    cur.execute("SELECT 1 FROM foodbasket WHERE foodbasket_id=%s", (int(basket_id),))
                    if cur.fetchone() is None:
                        messagebox.showerror("Error", f"Basket {basket_id} not found.")
                        return

                    cur.execute("UPDATE foodbasket SET status=%s WHERE foodbasket_id=%s",
                                (new_status, int(basket_id)))
                    conn.commit()
                    messagebox.showinfo("Success", f"Basket {basket_id} updated successfully.")
                    update_window.destroy()
                    baskets_management()

                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", f"Database error:\n{str(e)}")

            button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
            button_frame.pack(side=tk.BOTTOM, anchor="e", pady=20, padx=20)
            tk.Button(button_frame, text="Update", font=FONTS['button'], width=16,
                      command=confirm_update, bg=COLORS['secondary'], fg=COLORS['light'],
                      relief=tk.FLAT, cursor='hand2').pack()

        def open_update_basket(parent_window):
            parent_window.destroy()
            update_basket()

        try:
            cur.execute("""
                SELECT foodbasket_id, kind, status, basketweight, family_id, courier_id, dateofrecepit
                FROM foodbasket
                ORDER BY foodbasket_id ASC
            """)
            results = cur.fetchall()

            result_window = tk.Toplevel(admin_window)
            result_window.title("Baskets")
            set_half_screen(result_window)

            header_frame = tk.Frame(result_window, bg=COLORS['primary'], height=60)
            header_frame.pack(fill=tk.X)
            header_frame.pack_propagate(False)

            tk.Label(header_frame, text="🧺 Baskets Management", font=FONTS['subheader'],
                     bg=COLORS['primary'], fg=COLORS['light']).pack(pady=15)

            button_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            button_frame.pack(fill=tk.X, padx=20, pady=15)

            btn_style = {"font": FONTS['button'], "relief": tk.FLAT, "cursor": "hand2", "width": 16}

            tk.Button(button_frame, text="🗑️ Delete Basket", command=lambda: open_delete_basket(result_window),
                      bg=COLORS['danger'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)

            tk.Button(button_frame, text="➕ Add Basket", command=lambda: open_add_basket(result_window),
                      bg=COLORS['success'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)

            tk.Button(button_frame, text="✏️ Update Basket", command=lambda: open_update_basket(result_window),
                      bg=COLORS['secondary'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)

            tk.Button(button_frame, text="⭐ Score", command=lambda: open_score_window(result_window),
                      bg=COLORS['dark'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)

            text_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            text_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=(0, 20))

            scrollbar = tk.Scrollbar(text_frame)
            scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

            text = tk.Text(text_frame, width=90, height=22, yscrollcommand=scrollbar.set,
                           font=FONTS['text'], bg=COLORS['light'], fg=COLORS['text_dark'],
                           relief=tk.FLAT, padx=15, pady=15)
            text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

            scrollbar.config(command=text.yview)

            header = (
                f"{'ID'.ljust(8)}{'Kind'.ljust(10)}{'Status'.ljust(14)}"
                f"{'Weight'.ljust(10)}{'Family'.ljust(10)}{'Courier'.ljust(10)}{'Receipt Date'.ljust(14)}\n"
            )
            text.insert(tk.END, header)
            text.insert(tk.END, "-" * 80 + "\n")

            for row in results:
                fb_id = str(row[0]).ljust(8)
                kind = str(row[1] if row[1] is not None else '').ljust(10)
                status = str(row[2] if row[2] is not None else '').ljust(14)
                weight = str(row[3] if row[3] is not None else '').ljust(10)
                fam = str(row[4] if row[4] is not None else '').ljust(10)
                cour = str(row[5] if row[5] is not None else '').ljust(10)
                rec = str(row[6] if row[6] is not None else '').ljust(14)
                text.insert(tk.END, f"{fb_id}{kind}{status}{weight}{fam}{cour}{rec}\n")

            text.config(state=tk.DISABLED)

        except Exception as e:
            messagebox.showerror("Error", str(e))

    tk.Button(center_frame, text="🧺 Baskets", command=baskets_management, **button_style).grid(row=0, column=0,
                                                                                                   padx=15, pady=15)

    # פרטים לכל עיר
    def details_of_cities():
        try:
            cur.execute("""
                SELECT 
                    c.city_name AS city,
                    COUNT(DISTINCT v.courier_id) AS total_couriers,
                    COUNT(fb.foodbasket_id) AS total_baskets_delivered
                FROM city c
                JOIN courier v ON c.city_id = v.city_id
                LEFT JOIN foodbasket fb ON v.courier_id = fb.courier_id
                WHERE fb.status = 'delivered'
                GROUP BY c.city_name
                ORDER BY total_baskets_delivered DESC;
            """)
            results = cur.fetchall()

            if not results:
                messagebox.showinfo("Cities Details", "No data found.")
                return

            result_window = tk.Toplevel(admin_window)
            result_window.title("Total per Cities")
            set_half_screen(result_window)

            header_frame = tk.Frame(result_window, bg=COLORS['secondary'], height=60)
            header_frame.pack(fill=tk.X)
            header_frame.pack_propagate(False)

            tk.Label(header_frame, text="🏙️ Cities Statistics", font=FONTS['subheader'],
                     bg=COLORS['secondary'], fg=COLORS['light']).pack(pady=15)

            text_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            text_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

            scrollbar = tk.Scrollbar(text_frame)
            scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

            text = tk.Text(text_frame, width=60, height=20, yscrollcommand=scrollbar.set,
                           font=FONTS['text'], bg=COLORS['light'], fg=COLORS['text_dark'],
                           relief=tk.FLAT, padx=15, pady=15)
            text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

            scrollbar.config(command=text.yview)

            text.insert(tk.END,
                        f"{'City Name'.ljust(15)}{'Total Couriers'.ljust(17)}{'Total Baskets Delivered'.ljust(15)}\n")
            text.insert(tk.END, "─" * 55 + "\n")

            for row in results:
                city_name = str(row[0]).ljust(15)
                total_couriers = str(row[1]).ljust(17)
                total_baskets_delivered = str(row[2]).ljust(15)
                text.insert(tk.END, f"{city_name}{total_couriers}{total_baskets_delivered}\n")

            text.config(state=tk.DISABLED)

        except Exception as e:
            messagebox.showerror("Error", str(e))

    tk.Button(center_frame, text="🏙️ Cities", command=details_of_cities, **button_style).grid(row=0, column=1, padx=15,
                                                                                              pady=15)

    # הוספת מתנדב
    def add_courier():
        add_window = tk.Toplevel(admin_window)
        add_window.title("Add Courier")
        set_half_screen(add_window)

        main_frame = tk.Frame(add_window, bg=COLORS['bg_main'])
        main_frame.pack(fill=tk.BOTH, expand=True)

        tk.Label(main_frame, text="➕ Add New Courier", font=FONTS['subheader'],
                 bg=COLORS['bg_main'], fg=COLORS['primary']).pack(pady=30)

        form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        form_frame.pack(expand=True)

        def form_row(row, text):
            tk.Label(form_frame, text=text, font=FONTS['label'], width=24, anchor="w",
                     bg=COLORS['bg_main'], fg=COLORS['text_dark']
                     ).grid(row=row, column=0, padx=(0, 20), pady=8, sticky="w")

            entry = tk.Entry(form_frame, width=32, font=FONTS['entry'],
                             relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
            entry.grid(row=row, column=1, pady=8)
            return entry

        entry_id = form_row(0, "Courier ID")
        entry_name = form_row(1, "Courier Name")
        entry_date = form_row(2, "Joining Date (YYYY-MM-DD)")
        entry_city = form_row(3, "City ID")
        entry_salary = form_row(4, "Salary (Y/N)")

        def save_courier():
            id = entry_id.get().strip()
            name = entry_name.get().strip()
            date = entry_date.get().strip()
            city_id = entry_city.get().strip()
            salary = entry_salary.get().strip()

            if not name or not date or not city_id:
                messagebox.showerror("Error", "All fields are required")
                return

            try:
                cur.execute(
                    """
                    INSERT INTO courier (courier_id, courier_name, joiningdate, city_id, salary, bonus)
                    VALUES (%s, %s, %s, %s, %s, 0)
                    """,
                    (id, name, date, city_id, salary)
                )
                conn.commit()
                messagebox.showinfo("Success", "Courier added successfully")
                add_window.destroy()
                courier()

            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", str(e))

        button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        button_frame.pack(side=tk.BOTTOM, anchor="e", padx=40, pady=25)
        tk.Button(button_frame, text="Save Courier", font=FONTS['button'], width=16,
                  command=save_courier, bg=COLORS['success'], fg=COLORS['light'],
                  relief=tk.FLAT, cursor='hand2').pack()

    def delete_courier():
        delete_window = tk.Toplevel(admin_window)
        delete_window.title("Delete Courier")
        set_half_screen(delete_window)

        main_frame = tk.Frame(delete_window, bg=COLORS['bg_main'])
        main_frame.pack(fill=tk.BOTH, expand=True)

        tk.Label(main_frame, text="🗑️ Delete Courier", font=FONTS['subheader'],
                 bg=COLORS['bg_main'], fg=COLORS['danger']).pack(pady=30)

        form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        form_frame.pack(expand=True)

        tk.Label(form_frame, text="Courier ID", font=FONTS['label'], width=20, anchor="w",
                 bg=COLORS['bg_main'], fg=COLORS['text_dark']
                 ).grid(row=0, column=0, padx=(0, 20), pady=10)

        entry_id = tk.Entry(form_frame, width=32, font=FONTS['entry'],
                            relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
        entry_id.grid(row=0, column=1, pady=10)

        def confirm_delete():
            id = entry_id.get().strip()
            if not id:
                messagebox.showerror("Error", "Enter ID")
                return

            try:
                cur.execute("DELETE FROM courier WHERE courier_id=%s", (id,))
                conn.commit()
                messagebox.showinfo("Success", "Courier deleted successfully")
                delete_window.destroy()
                courier()

            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", str(e))

        button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        button_frame.pack(side=tk.BOTTOM, anchor="e", padx=40, pady=25)
        tk.Button(button_frame, text="Delete", font=FONTS['button'], width=16,
                  command=confirm_delete, bg=COLORS['danger'], fg=COLORS['light'],
                  relief=tk.FLAT, cursor='hand2').pack()

    # רשימת מתנדבים
    def courier():
        def open_add_courier(parent_window):
            parent_window.destroy()
            add_courier()

        def open_delete_courier(parent_window):
            parent_window.destroy()
            delete_courier()

        try:
            cur.execute(""" 
                        SELECT c.courier_id, c.courier_name, c.joiningdate, c.salary, c.bonus,
                                COALESCE(cr.foodbasket_count, 0) AS courier_ranking
                        FROM courier c
                        LEFT JOIN courier_ranking cr
                            ON c.courier_id = cr.courier_id
                        ORDER BY c.courier_id;
                        """)
            results = cur.fetchall()

            if not results:
                messagebox.showinfo("Couriers", "No data found.")
                return

            result_window = tk.Toplevel(admin_window)
            result_window.title("Couriers")
            set_half_screen(result_window)

            header_frame = tk.Frame(result_window, bg=COLORS['primary'], height=60)
            header_frame.pack(fill=tk.X)
            header_frame.pack_propagate(False)

            tk.Label(header_frame, text="👥 Couriers Management", font=FONTS['subheader'],
                     bg=COLORS['primary'], fg=COLORS['light']).pack(pady=15)

            button_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            button_frame.pack(pady=15)

            btn_style = {"width": 18, "font": FONTS['button'], "relief": tk.FLAT, "cursor": 'hand2'}

            tk.Button(button_frame, text="Delete Courier", command=lambda: open_delete_courier(result_window),
                      bg=COLORS['danger'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)
            tk.Button(button_frame, text="Add Courier", command=lambda: open_add_courier(result_window),
                      bg=COLORS['success'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)
            tk.Button(button_frame, text="Calculate Bonus", command=lambda: open_bonus_window(result_window),
                      bg=COLORS['secondary'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)

            text_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            text_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=(0, 20))

            scrollbar = tk.Scrollbar(text_frame)
            scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

            text = tk.Text(text_frame, width=60, height=20, yscrollcommand=scrollbar.set,
                           font=FONTS['text'], bg=COLORS['light'], fg=COLORS['text_dark'],
                           relief=tk.FLAT, padx=15, pady=15)
            text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

            scrollbar.config(command=text.yview)

            text.insert(tk.END,
                        f"{'Courier ID'.ljust(12)}{'Courier Name'.ljust(19)}{'Date Of Joining'.ljust(16)}{'Salary'.ljust(8)}{'Bonus'.ljust(10)}{'Courier Ranking'.ljust(8)}\n")
            text.insert(tk.END, "─" * 80 + "\n")

            for row in results:
                courier_id = str(row[0]).ljust(12)
                courier_name = str(row[1]).ljust(19)
                joining_date = str(row[2]).ljust(16)
                salary = str(row[3]).ljust(8)
                bonus = str(row[4]).ljust(10)
                courier_ranking = str(row[5]).ljust(8)
                text.insert(tk.END, f"{courier_id}{courier_name}{joining_date}{salary}{bonus}{courier_ranking}\n")

            text.config(state=tk.DISABLED)

        except Exception as e:
            messagebox.showerror("Error", str(e))

    def open_bonus_window(parent_window):
        parent_window.destroy()

        bonus_window = tk.Toplevel(admin_window)
        bonus_window.title("Calculate Bonus")
        set_half_screen(bonus_window)

        main_frame = tk.Frame(bonus_window, bg=COLORS['bg_main'])
        main_frame.pack(fill=tk.BOTH, expand=True)

        tk.Label(main_frame, text="💰 Calculate Bonus", font=FONTS['subheader'],
                 bg=COLORS['bg_main'], fg=COLORS['secondary']).pack(pady=30)

        form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        form_frame.pack(expand=True)

        tk.Label(form_frame, text="Courier ID", font=FONTS['label'], width=20, anchor="w",
                 bg=COLORS['bg_main'], fg=COLORS['text_dark']
                 ).grid(row=0, column=0, padx=(0, 20), pady=10)

        entry_courier_id = tk.Entry(form_frame, width=32, font=FONTS['entry'],
                                    relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
        entry_courier_id.grid(row=0, column=1, pady=10)

        def calculate_bonus_button():
            try:
                courier_id = int(entry_courier_id.get())
                cur.execute("CALL calculate_courier_bonus(%s);", (courier_id,))
                conn.commit()
                cur.execute("SELECT bonus FROM courier WHERE courier_id=%s", (courier_id,))
                bonus = cur.fetchone()[0]

                messagebox.showinfo("Success",
                                    f"Bonus calculated for courier {courier_id}!\nThe bonus is: {bonus}")

                bonus_window.destroy()
                courier()

            except ValueError:
                messagebox.showerror("Error", "Please enter a valid number for Courier ID.")
            except Exception as e:
                messagebox.showerror("Error", str(e))

        button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        button_frame.pack(side=tk.BOTTOM, anchor="e", padx=40, pady=25)
        tk.Button(button_frame, text="Calculate", font=FONTS['button'], width=16,
                  command=calculate_bonus_button, bg=COLORS['success'], fg=COLORS['light'],
                  relief=tk.FLAT, cursor='hand2').pack()

    tk.Button(center_frame, text="👥 Couriers", command=courier, **button_style).grid(row=1, column=0, padx=15, pady=15)

    # מספר פריטים לכל משפחה
    def show_total_items():
        try:
            cur.execute("""
                   SELECT 
                       f.family_name,
                       SUM(fg.quantity) AS total_items,
                       COUNT(DISTINCT fb.foodbasket_id) AS baskets_count
                   FROM family f
                   JOIN foodbasket fb ON f.family_id = fb.family_id
                   JOIN foodbasket_groceries fg ON fb.foodbasket_id = fg.foodbasket_id
                   GROUP BY f.family_name
                   ORDER BY total_items DESC;
               """)
            results = cur.fetchall()

            if not results:
                messagebox.showinfo("Total Items", "No data found.")
                return

            result_window = tk.Toplevel(admin_window)
            result_window.title("Total Items per Family")
            set_half_screen(result_window)

            header_frame = tk.Frame(result_window, bg=COLORS['secondary'], height=60)
            header_frame.pack(fill=tk.X)
            header_frame.pack_propagate(False)

            tk.Label(header_frame, text="📊 Total Items per Family", font=FONTS['subheader'],
                     bg=COLORS['secondary'], fg=COLORS['light']).pack(pady=15)

            text_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            text_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

            scrollbar = tk.Scrollbar(text_frame)
            scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

            text = tk.Text(text_frame, width=60, height=20, yscrollcommand=scrollbar.set,
                           font=FONTS['text'], bg=COLORS['light'], fg=COLORS['text_dark'],
                           relief=tk.FLAT, padx=15, pady=15)
            text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

            scrollbar.config(command=text.yview)

            text.insert(tk.END, f"{'Family Name'.ljust(25)}{'Total Items'.ljust(15)}{'Baskets Count'.ljust(15)}\n")
            text.insert(tk.END, "─" * 55 + "\n")

            for row in results:
                family_name = str(row[0]).ljust(25)
                total_items = str(row[1]).ljust(15)
                baskets_count = str(row[2]).ljust(15)
                text.insert(tk.END, f"{family_name}{total_items}{baskets_count}\n")

            text.config(state=tk.DISABLED)

        except Exception as e:
            messagebox.showerror("Error", str(e))

    # הוספת משפחה למערכת
    def add_family():
        add_window = tk.Toplevel(admin_window)
        add_window.title("Add Family")
        set_half_screen(add_window)

        main_frame = tk.Frame(add_window, bg=COLORS['bg_main'])
        main_frame.pack(fill=tk.BOTH, expand=True)
        tk.Label(main_frame, text="➕ Add New Family", font=FONTS['subheader'],
                 bg=COLORS['bg_main'], fg=COLORS['primary']).pack(pady=30)

        form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        form_frame.pack(expand=True)

        def form_row(row, text):
            tk.Label(form_frame, text=text, font=FONTS['label'], width=24, anchor="w",
                     bg=COLORS['bg_main'], fg=COLORS['text_dark']
                     ).grid(row=row, column=0, padx=(0, 20), pady=8, sticky="w")

            entry = tk.Entry(form_frame, width=32, font=FONTS['entry'],
                             relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
            entry.grid(row=row, column=1, pady=8)
            return entry

        entry_id = form_row(0, "Family ID")
        entry_name = form_row(1, "Family Name")
        entry_num = form_row(2, "Number OF people")
        entry_city = form_row(3, "City ID")
        entry_date = form_row(4, "Birth Date(YYYY-MM-DD)")
        entry_pay = form_row(5, "Payment Details")

        def save_family():
            id = entry_id.get().strip()
            name = entry_name.get().strip()
            num = entry_num.get().strip()
            city_id = entry_city.get().strip()
            date = entry_date.get().strip()
            pay = entry_pay.get().strip()

            if not id or not name or not num or not city_id or not date or not pay:
                messagebox.showerror("Error", "All fields are required")
                return

            try:
                cur.execute(
                    """
                    INSERT INTO family (family_id, family_name, number_of_people, city_id, date_of_birth, payment_details)
                    VALUES (%s, %s, %s, %s, %s, %s)
                    """,
                    (id, name, num, city_id, date, pay)
                )
                conn.commit()
                messagebox.showinfo("Success", "Family added successfully")
                add_window.destroy()
                family()

            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", str(e))

        button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        button_frame.pack(side=tk.BOTTOM, anchor="e", padx=40, pady=25)
        tk.Button(button_frame, text="Save Family", font=FONTS['button'], width=16,
                  command=save_family, bg=COLORS['success'], fg=COLORS['light'],
                  relief=tk.FLAT, cursor='hand2').pack()

    # מחיקת משפחה מהמערכת
    def delete_family():
        delete_window = tk.Toplevel(admin_window)
        delete_window.title("Delete Family")
        set_half_screen(delete_window)

        main_frame = tk.Frame(delete_window, bg=COLORS['bg_main'])
        main_frame.pack(fill=tk.BOTH, expand=True)
        tk.Label(main_frame, text="🗑️ Delete Family", font=FONTS['subheader'],
                 bg=COLORS['bg_main'], fg=COLORS['danger']).pack(pady=30)

        form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        form_frame.pack(expand=True)

        tk.Label(form_frame, text="Family ID", font=FONTS['label'], width=20, anchor="w",
                 bg=COLORS['bg_main'], fg=COLORS['text_dark']
                 ).grid(row=0, column=0, padx=(0, 20), pady=10)

        entry_id = tk.Entry(form_frame, width=32, font=FONTS['entry'],
                            relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
        entry_id.grid(row=0, column=1, pady=10)

        def confirm_delete():
            id = entry_id.get().strip()
            if not id:
                messagebox.showerror("Error", "Enter ID")
                return

            try:
                cur.execute("DELETE FROM family WHERE family_id=%s", (id,))
                conn.commit()
                messagebox.showinfo("Success", "Family deleted successfully")
                delete_window.destroy()
                family()

            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", str(e))

        button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        button_frame.pack(side=tk.BOTTOM, anchor="e", padx=40, pady=25)
        tk.Button(button_frame, text="Delete", font=FONTS['button'], width=16,
                  command=confirm_delete, bg=COLORS['danger'], fg=COLORS['light'],
                  relief=tk.FLAT, cursor='hand2').pack()

    # עדכון מס הנפשות במשפחה
    def update_family():
        update_window = tk.Toplevel(admin_window)
        update_window.title("Update Family")
        set_half_screen(update_window)

        main_frame = tk.Frame(update_window, bg=COLORS['bg_main'])
        main_frame.pack(expand=True, fill=tk.BOTH, padx=20, pady=20)

        tk.Label(main_frame, text="✏️ Update Family", font=FONTS['subheader'],
                 bg=COLORS['bg_main'], fg=COLORS['primary']).pack(pady=20)

        form_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        form_frame.pack(pady=10, anchor="center")

        tk.Label(form_frame, text="Family ID:", font=FONTS['label'],
                 bg=COLORS['bg_main'], fg=COLORS['text_dark']).grid(row=0, column=0, sticky="w", pady=5)
        entry_id = tk.Entry(form_frame, font=FONTS['entry'], width=20,
                            relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
        entry_id.grid(row=0, column=1, pady=5, padx=5)

        tk.Label(form_frame, text="Number of people in the family:", font=FONTS['label'],
                 bg=COLORS['bg_main'], fg=COLORS['text_dark']).grid(row=1, column=0, sticky="w", pady=5)
        entry_num = tk.Entry(form_frame, font=FONTS['entry'], width=20,
                             relief=tk.FLAT, bg=COLORS['light'], borderwidth=2)
        entry_num.grid(row=1, column=1, pady=5, padx=5)

        def confirm_update():
            id = entry_id.get().strip()
            num = entry_num.get().strip()
            if not id or not num:
                messagebox.showerror("Error", "Enter ID")
                return

            try:
                cur.execute("UPDATE family SET number_of_people=%s WHERE family_id=%s", (num, id,))
                conn.commit()
                messagebox.showinfo("Success", "Family update successfully")
                update_window.destroy()
                family()

            except Exception as e:
                conn.rollback()
                messagebox.showerror("Error", str(e))

        button_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
        button_frame.pack(side=tk.BOTTOM, anchor="e", pady=20, padx=20)
        tk.Button(button_frame, text="Update", font=FONTS['button'], width=16,
                  command=confirm_update, bg=COLORS['secondary'], fg=COLORS['light'],
                  relief=tk.FLAT, cursor='hand2').pack()

    # רשימת משפחות
    def family():
        def open_add_family(parent_window):
            parent_window.destroy()
            add_family()

        def open_delete_family(parent_window):
            parent_window.destroy()
            delete_family()

        def open_update_family(parent_window):
            parent_window.destroy()
            update_family()

        try:
            cur.execute(""" 
                           SELECT family_id, family_name, number_of_people ,city_id
                           FROM family 
                           ORDER BY family_id
                           """)
            results = cur.fetchall()

            if not results:
                messagebox.showinfo("Families", "No data found.")
                return

            result_window = tk.Toplevel(admin_window)
            result_window.title("Families")
            set_half_screen(result_window)

            header_frame = tk.Frame(result_window, bg=COLORS['secondary'], height=60)
            header_frame.pack(fill=tk.X)
            header_frame.pack_propagate(False)

            tk.Label(header_frame, text="👨‍👩‍👧‍👦 Families Management", font=FONTS['subheader'],
                     bg=COLORS['secondary'], fg=COLORS['light']).pack(pady=15)

            button_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            button_frame.pack(pady=15)

            btn_style = {"width": 18, "font": FONTS['button'], "relief": tk.FLAT, "cursor": 'hand2'}

            tk.Button(button_frame, text="Total Items", command=show_total_items,
                      bg=COLORS['primary'], fg=COLORS['light'], **btn_style).pack(side=tk.RIGHT, padx=5)
            tk.Button(button_frame, text="Add Family", command=lambda: open_add_family(result_window),
                      bg=COLORS['success'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)
            tk.Button(button_frame, text="Delete Family", command=lambda: open_delete_family(result_window),
                      bg=COLORS['danger'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)
            tk.Button(button_frame, text="Update Family", command=lambda: open_update_family(result_window),
                      bg=COLORS['secondary'], fg=COLORS['light'], **btn_style).pack(side=tk.LEFT, padx=5)

            text_frame = tk.Frame(result_window, bg=COLORS['bg_main'])
            text_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=(0, 20))

            scrollbar = tk.Scrollbar(text_frame)
            scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

            text = tk.Text(text_frame, width=60, height=20, yscrollcommand=scrollbar.set,
                           font=FONTS['text'], bg=COLORS['light'], fg=COLORS['text_dark'],
                           relief=tk.FLAT, padx=15, pady=15)
            text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
            scrollbar.config(command=text.yview)

            col_widths = [12, 25, 20, 10]

            text.insert(tk.END,
                        f"{'Family ID'.ljust(col_widths[0])}{'Family Name'.ljust(col_widths[1])}{'Number of People'.ljust(col_widths[2])}{'City ID'.ljust(col_widths[3])}\n")
            text.insert(tk.END, "─" * sum(col_widths) + "\n")

            for row in results:
                family_id = str(row[0]).ljust(col_widths[0])
                family_name = str(row[1]).ljust(col_widths[1])
                num_people = str(row[2]).ljust(col_widths[2])
                city_id = str(row[3]).ljust(col_widths[3])
                text.insert(tk.END, f"{family_id}{family_name}{num_people}{city_id}\n")

            text.config(state=tk.DISABLED)

        except Exception as e:
            messagebox.showerror("Error", str(e))

    tk.Button(center_frame, text="👨‍👩‍👧‍👦 Familys", command=family, **button_style).grid(row=1, column=1, padx=15,
                                                                                         pady=15)

    # ================= אזור תחתון =================
    bottom_frame = tk.Frame(main_frame, bg=COLORS['bg_main'])
    bottom_frame.pack(side=tk.BOTTOM, anchor="e", padx=20, pady=20)

    def return_to_login():
        admin_window.destroy()
        root.deiconify()
        entry_username.delete(0, tk.END)
        entry_password.delete(0, tk.END)

    tk.Button(bottom_frame, text="Return", width=8, font=FONTS['button'],
              command=return_to_login, bg=COLORS['text_light'], fg=COLORS['light'],
              relief=tk.FLAT, cursor='hand2').pack(side=tk.RIGHT, padx=5)

    tk.Button(bottom_frame, text="Close", width=8, font=FONTS['button'],
              command=admin_window.destroy, bg=COLORS['danger'], fg=COLORS['light'],
              relief=tk.FLAT, cursor='hand2').pack(side=tk.RIGHT, padx=5)


# --- פונקציית כניסה ---
def login():
    username = entry_username.get()
    password = entry_password.get()

    if not username or not password:
        messagebox.showwarning("Login", "Please enter username and password")
        return

    if username == "!!!" and password == "!!!":
        messagebox.showinfo("admin", "Welcome admin:)")
        root.withdraw()
        show_admin_window()
        return

    cur.execute(
        "SELECT courier_id, courier_name FROM courier WHERE courier_name=%s AND courier_id=%s",
        (username, password)
    )
    result = cur.fetchone()

    if result:
        courier_id, firstname = result
        messagebox.showinfo("Success", f"Welcome {firstname}:)")
        root.withdraw()
        show_courier_window(courier_id)

    else:
        messagebox.showerror("Error", "Invalid username or password")


# --- מסך כניסה ---
root = tk.Tk()
root.title("Food Basket Management System")
set_half_screen(root)

# Canvas לרקע גרדיאנט
canvas = tk.Canvas(root, highlightthickness=0)
canvas.pack(fill=tk.BOTH, expand=True)


def create_gradient(canvas, color1, color2):
    width = canvas.winfo_width()
    height = canvas.winfo_height()
    if width <= 1 or height <= 1:
        root.after(100, lambda: create_gradient(canvas, color1, color2))
        return

    limit = height
    r1, g1, b1 = int(color1[1:3], 16), int(color1[3:5], 16), int(color1[5:7], 16)
    r2, g2, b2 = int(color2[1:3], 16), int(color2[3:5], 16), int(color2[5:7], 16)

    for i in range(limit):
        r = int(r1 + (r2 - r1) * i / limit)
        g = int(g1 + (g2 - g1) * i / limit)
        b = int(b1 + (b2 - b1) * i / limit)
        color = f'#{r:02x}{g:02x}{b:02x}'
        canvas.create_line(0, i, width, i, fill=color)


root.after(100, lambda: create_gradient(canvas, COLORS['bg_gradient_start'], COLORS['bg_gradient_end']))

# Frame ראשי על הקנבס
main_frame = tk.Frame(canvas, bg='')
main_frame.place(relx=0.5, rely=0.5, anchor='center')

# לוגו/כותרת
title_frame = tk.Frame(main_frame, bg=COLORS['light'], bd=0)
title_frame.pack(pady=(0, 30), padx=40)

tk.Label(title_frame, text="🍎", font=("Arial", 48), bg=COLORS['light']).pack(pady=(20, 5))
tk.Label(title_frame, text="Food Basket System", font=('Segoe UI', 22, 'bold'),
         bg=COLORS['light'], fg=COLORS['primary']).pack()
tk.Label(title_frame, text="Management Portal", font=('Segoe UI', 12),
         bg=COLORS['light'], fg=COLORS['text_light']).pack(pady=(0, 20))

# Login Frame
login_frame = tk.Frame(main_frame, bg=COLORS['light'], bd=0)
login_frame.pack(padx=50, pady=30)

# Username
tk.Label(login_frame, text="Username:", font=FONTS['label'],
         bg=COLORS['light'], fg=COLORS['text_dark']).grid(row=0, column=0, padx=15, pady=12, sticky="w")
entry_username = tk.Entry(login_frame, width=25, font=FONTS['entry'],
                          relief=tk.FLAT, bg=COLORS['bg_main'], borderwidth=0,
                          highlightthickness=2, highlightbackground=COLORS['shadow'],
                          highlightcolor=COLORS['primary'])
entry_username.grid(row=0, column=1, padx=15, pady=12, ipady=5)

# Password
tk.Label(login_frame, text="Password:", font=FONTS['label'],
         bg=COLORS['light'], fg=COLORS['text_dark']).grid(row=1, column=0, padx=15, pady=12, sticky="w")
entry_password = tk.Entry(login_frame, show="●", width=25, font=FONTS['entry'],
                          relief=tk.FLAT, bg=COLORS['bg_main'], borderwidth=0,
                          highlightthickness=2, highlightbackground=COLORS['shadow'],
                          highlightcolor=COLORS['primary'])
entry_password.grid(row=1, column=1, padx=15, pady=12, ipady=5)

# Login button
btn_login = tk.Button(
    login_frame,
    text="🔐 Login",
    width=30,
    font=FONTS['button'],
    command=login,
    bg=COLORS['primary'],
    fg=COLORS['light'],
    relief=tk.FLAT,
    cursor='hand2',
    borderwidth=0
)
btn_login.grid(row=2, column=0, columnspan=2, pady=25, ipady=8)

root.bind("<Return>", lambda event: login())

root.mainloop()

cur.close()
conn.close()
