PGDMP      	                |            meal    16.2    16.2 .    S           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            T           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            U           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            V           1262    16394    meal    DATABASE     f   CREATE DATABASE meal WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE meal;
                postgres    false            �            1255    16579    generate_meal_plan(numeric)    FUNCTION     %  CREATE FUNCTION public.generate_meal_plan(budget numeric) RETURNS TABLE(day integer, meal_type character varying, meal_name character varying, price numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    breakfast_name varchar;
    breakfast_price numeric;
    lunch_name varchar;
    lunch_price numeric;
    dinner_name varchar;
    dinner_price numeric;
BEGIN
    SELECT m_breakfast.meal_name, m_breakfast.price
    INTO breakfast_name, breakfast_price
    FROM Meals m_breakfast
    JOIN Meal_Types mt_breakfast ON m_breakfast.meal_id = mt_breakfast.type_id
    WHERE mt_breakfast.type_name = 'Breakfast' AND m_breakfast.price <= budget
    ORDER BY RANDOM()
    LIMIT 1;
    
    RAISE NOTICE 'Breakfast name: %, Breakfast price: %', breakfast_name, breakfast_price;

    SELECT m_lunch.meal_name, m_lunch.price
    INTO lunch_name, lunch_price
    FROM Meals m_lunch
    JOIN Meal_Types mt_lunch ON m_lunch.meal_id = mt_lunch.type_id
    WHERE mt_lunch.type_name = 'Lunch' AND m_lunch.price <= budget
    ORDER BY RANDOM()
    LIMIT 1;

    RAISE NOTICE 'Lunch name: %, Lunch price: %', lunch_name, lunch_price;

    SELECT m_dinner.meal_name, m_dinner.price
    INTO dinner_name, dinner_price
    FROM Meals m_dinner
    JOIN Meal_Types mt_dinner ON m_dinner.meal_id = mt_dinner.type_id
    WHERE mt_dinner.type_name = 'Dinner' AND m_dinner.price <= budget
    ORDER BY RANDOM()
    LIMIT 1;

    RAISE NOTICE 'Dinner name: %, Dinner price: %', dinner_name, dinner_price;

    RETURN QUERY
    SELECT 1 AS day, 'Breakfast'::varchar AS meal_type, breakfast_name::varchar, breakfast_price::numeric
    UNION ALL
    SELECT 1 AS day, 'Lunch'::varchar AS meal_type, lunch_name::varchar, lunch_price::numeric
    UNION ALL
    SELECT 1 AS day, 'Dinner'::varchar AS meal_type, dinner_name::varchar, dinner_price::numeric;
END;
$$;
 9   DROP FUNCTION public.generate_meal_plan(budget numeric);
       public          postgres    false            �            1259    16588    ingredients    TABLE     t   CREATE TABLE public.ingredients (
    ingredient_id numeric NOT NULL,
    ingredient_name character varying(255)
);
    DROP TABLE public.ingredients;
       public         heap    postgres    false            �            1259    16685    ingredients_nutrition    TABLE     �   CREATE TABLE public.ingredients_nutrition (
    nutrition_id numeric NOT NULL,
    ingredient_id numeric,
    nutrient_name character varying(100),
    nutrient_value numeric
);
 )   DROP TABLE public.ingredients_nutrition;
       public         heap    postgres    false            �            1259    16670 
   meal_diets    TABLE     M   CREATE TABLE public.meal_diets (
    meal_id numeric,
    diet_id numeric
);
    DROP TABLE public.meal_diets;
       public         heap    postgres    false            �            1259    16595    meal_ingredients    TABLE     �   CREATE TABLE public.meal_ingredients (
    meal_id numeric,
    ingredient_id numeric,
    quantity numeric,
    unit character varying(50)
);
 $   DROP TABLE public.meal_ingredients;
       public         heap    postgres    false            �            1259    16646    meal_reviews    TABLE     �   CREATE TABLE public.meal_reviews (
    review_id numeric NOT NULL,
    username character varying(255),
    meal_id numeric,
    rating integer
);
     DROP TABLE public.meal_reviews;
       public         heap    postgres    false            �            1259    16610 
   meal_types    TABLE     f   CREATE TABLE public.meal_types (
    type_id numeric NOT NULL,
    type_name character varying(50)
);
    DROP TABLE public.meal_types;
       public         heap    postgres    false            �            1259    16581    meals    TABLE     �   CREATE TABLE public.meals (
    meal_id numeric NOT NULL,
    meal_name character varying(255),
    meal_description text,
    price numeric,
    calories integer
);
    DROP TABLE public.meals;
       public         heap    postgres    false            �            1259    16629    plan_details    TABLE     �   CREATE TABLE public.plan_details (
    detail_id numeric NOT NULL,
    plan_id numeric,
    meal_id numeric,
    quantity numeric,
    subtotal numeric,
    "timestamp" timestamp without time zone
);
     DROP TABLE public.plan_details;
       public         heap    postgres    false            �            1259    16617    plans    TABLE     �   CREATE TABLE public.plans (
    plan_id numeric NOT NULL,
    username character varying(255),
    plan_date date,
    total_price numeric,
    "timestamp" timestamp without time zone
);
    DROP TABLE public.plans;
       public         heap    postgres    false            �            1259    16663    special_diets    TABLE     i   CREATE TABLE public.special_diets (
    diet_id numeric NOT NULL,
    diet_name character varying(50)
);
 !   DROP TABLE public.special_diets;
       public         heap    postgres    false            �            1259    16399    users    TABLE     �   CREATE TABLE public.users (
    username character varying(50) NOT NULL,
    name character varying(100),
    email character varying(100),
    password character varying(255),
    height numeric,
    age integer,
    weight numeric
);
    DROP TABLE public.users;
       public         heap    postgres    false            H          0    16588    ingredients 
   TABLE DATA           E   COPY public.ingredients (ingredient_id, ingredient_name) FROM stdin;
    public          postgres    false    217   F>       P          0    16685    ingredients_nutrition 
   TABLE DATA           k   COPY public.ingredients_nutrition (nutrition_id, ingredient_id, nutrient_name, nutrient_value) FROM stdin;
    public          postgres    false    225   �>       O          0    16670 
   meal_diets 
   TABLE DATA           6   COPY public.meal_diets (meal_id, diet_id) FROM stdin;
    public          postgres    false    224   "?       I          0    16595    meal_ingredients 
   TABLE DATA           R   COPY public.meal_ingredients (meal_id, ingredient_id, quantity, unit) FROM stdin;
    public          postgres    false    218   K?       M          0    16646    meal_reviews 
   TABLE DATA           L   COPY public.meal_reviews (review_id, username, meal_id, rating) FROM stdin;
    public          postgres    false    222   �?       J          0    16610 
   meal_types 
   TABLE DATA           8   COPY public.meal_types (type_id, type_name) FROM stdin;
    public          postgres    false    219   @       G          0    16581    meals 
   TABLE DATA           V   COPY public.meals (meal_id, meal_name, meal_description, price, calories) FROM stdin;
    public          postgres    false    216   Y@       L          0    16629    plan_details 
   TABLE DATA           d   COPY public.plan_details (detail_id, plan_id, meal_id, quantity, subtotal, "timestamp") FROM stdin;
    public          postgres    false    221   �A       K          0    16617    plans 
   TABLE DATA           W   COPY public.plans (plan_id, username, plan_date, total_price, "timestamp") FROM stdin;
    public          postgres    false    220   �A       N          0    16663    special_diets 
   TABLE DATA           ;   COPY public.special_diets (diet_id, diet_name) FROM stdin;
    public          postgres    false    223   _B       F          0    16399    users 
   TABLE DATA           U   COPY public.users (username, name, email, password, height, age, weight) FROM stdin;
    public          postgres    false    215   �B       �           2606    16691 0   ingredients_nutrition ingredients_nutrition_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.ingredients_nutrition
    ADD CONSTRAINT ingredients_nutrition_pkey PRIMARY KEY (nutrition_id);
 Z   ALTER TABLE ONLY public.ingredients_nutrition DROP CONSTRAINT ingredients_nutrition_pkey;
       public            postgres    false    225            �           2606    16594    ingredients ingredients_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (ingredient_id);
 F   ALTER TABLE ONLY public.ingredients DROP CONSTRAINT ingredients_pkey;
       public            postgres    false    217            �           2606    16652    meal_reviews meal_reviews_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.meal_reviews
    ADD CONSTRAINT meal_reviews_pkey PRIMARY KEY (review_id);
 H   ALTER TABLE ONLY public.meal_reviews DROP CONSTRAINT meal_reviews_pkey;
       public            postgres    false    222            �           2606    16616    meal_types meal_types_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.meal_types
    ADD CONSTRAINT meal_types_pkey PRIMARY KEY (type_id);
 D   ALTER TABLE ONLY public.meal_types DROP CONSTRAINT meal_types_pkey;
       public            postgres    false    219            �           2606    16587    meals meals_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (meal_id);
 :   ALTER TABLE ONLY public.meals DROP CONSTRAINT meals_pkey;
       public            postgres    false    216            �           2606    16635    plan_details plan_details_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.plan_details
    ADD CONSTRAINT plan_details_pkey PRIMARY KEY (detail_id);
 H   ALTER TABLE ONLY public.plan_details DROP CONSTRAINT plan_details_pkey;
       public            postgres    false    221            �           2606    16623    plans plans_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (plan_id);
 :   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_pkey;
       public            postgres    false    220            �           2606    16669     special_diets special_diets_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.special_diets
    ADD CONSTRAINT special_diets_pkey PRIMARY KEY (diet_id);
 J   ALTER TABLE ONLY public.special_diets DROP CONSTRAINT special_diets_pkey;
       public            postgres    false    223            �           2606    16405    users users_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215            �           2606    16692 >   ingredients_nutrition ingredients_nutrition_ingredient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ingredients_nutrition
    ADD CONSTRAINT ingredients_nutrition_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(ingredient_id);
 h   ALTER TABLE ONLY public.ingredients_nutrition DROP CONSTRAINT ingredients_nutrition_ingredient_id_fkey;
       public          postgres    false    217    3488    225            �           2606    16680 "   meal_diets meal_diets_diet_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meal_diets
    ADD CONSTRAINT meal_diets_diet_id_fkey FOREIGN KEY (diet_id) REFERENCES public.special_diets(diet_id);
 L   ALTER TABLE ONLY public.meal_diets DROP CONSTRAINT meal_diets_diet_id_fkey;
       public          postgres    false    224    3498    223            �           2606    16675 "   meal_diets meal_diets_meal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meal_diets
    ADD CONSTRAINT meal_diets_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES public.meals(meal_id);
 L   ALTER TABLE ONLY public.meal_diets DROP CONSTRAINT meal_diets_meal_id_fkey;
       public          postgres    false    216    3486    224            �           2606    16605 4   meal_ingredients meal_ingredients_ingredient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meal_ingredients
    ADD CONSTRAINT meal_ingredients_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(ingredient_id);
 ^   ALTER TABLE ONLY public.meal_ingredients DROP CONSTRAINT meal_ingredients_ingredient_id_fkey;
       public          postgres    false    3488    218    217            �           2606    16600 .   meal_ingredients meal_ingredients_meal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meal_ingredients
    ADD CONSTRAINT meal_ingredients_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES public.meals(meal_id);
 X   ALTER TABLE ONLY public.meal_ingredients DROP CONSTRAINT meal_ingredients_meal_id_fkey;
       public          postgres    false    216    218    3486            �           2606    16658 &   meal_reviews meal_reviews_meal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meal_reviews
    ADD CONSTRAINT meal_reviews_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES public.meals(meal_id);
 P   ALTER TABLE ONLY public.meal_reviews DROP CONSTRAINT meal_reviews_meal_id_fkey;
       public          postgres    false    216    3486    222            �           2606    16653 '   meal_reviews meal_reviews_username_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.meal_reviews
    ADD CONSTRAINT meal_reviews_username_fkey FOREIGN KEY (username) REFERENCES public.users(username);
 Q   ALTER TABLE ONLY public.meal_reviews DROP CONSTRAINT meal_reviews_username_fkey;
       public          postgres    false    215    3484    222            �           2606    16641 &   plan_details plan_details_meal_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plan_details
    ADD CONSTRAINT plan_details_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES public.meals(meal_id);
 P   ALTER TABLE ONLY public.plan_details DROP CONSTRAINT plan_details_meal_id_fkey;
       public          postgres    false    3486    216    221            �           2606    16636 &   plan_details plan_details_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.plan_details
    ADD CONSTRAINT plan_details_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans(plan_id);
 P   ALTER TABLE ONLY public.plan_details DROP CONSTRAINT plan_details_plan_id_fkey;
       public          postgres    false    3492    221    220            �           2606    16624    plans plans_username_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.plans
    ADD CONSTRAINT plans_username_fkey FOREIGN KEY (username) REFERENCES public.users(username);
 C   ALTER TABLE ONLY public.plans DROP CONSTRAINT plans_username_fkey;
       public          postgres    false    220    215    3484            H   j   x�3��I-))MN�2�t��L�N��2�t.�/-��+�2�.HL� *��2���M,�WN�7r�J��QE-8�rS���3RS�S�,a�*8�&�p��qqq ��%D      P   R   x�3�4�(�/I���44�2�4�tK,�4�2�4�tN,J�ϨL)J,I-�42�2�4����2�4+64�2�4CSmh����� ��x      O      x�3�4�2�4�2�4�����        I   ]   x�=�K
�0Dד�Hӟz7R�����;�"ټ̼Q(<�Ӻ(�YK%�)Y!�9�~u~�����#-������h� �A�
���6����      M   :   x�Ȼ�P���w�|�y-�؟(rsd�{��0R�v�R�����dR��I�n�й$����      J   G   x�3�tI-.N-*�2�tJ-K-JLO�2�t*JM�NK,.�2��)�K��2�t���K-�2��KL������ e"(      G   <  x�m��n�0Eד���(�ͲE��*UW�L��pl46T��"Z�K����q��˽q�"HpK�*X�	Z�4���5�����ѻ0@rU�Z�R`Wa1\.a<ͳlT7�a|�����v�	�96�*����(� C(�D�,�l�6����md����1/Q��^��͇��V�|�;";$e���{��˚��^I4��F���B������29<�j�k)�+���z퉱�T�IgEB�=�?v�t������ܐ�:�n���,qG�w��L{N��;x��T螸K��-	;J�T@�W��PL:���s�e��O�T      L   H   x�3�4C=KKN##]]C+S+C=3KcC#.#�64������q&��@h�i�_Y� �/�      K   R   x�}˱�0���p�p@ Cf�u=��K��I���	<�y	(��"��lc��2�s�@F�(���a�|1}eB�Q��      N   F   x�3�KMO-I,�L��2q��1�{NiIj��[Qj*�	�wjI>�)g@bNj>��O~��sbQW� ���      F   �   x�m�K
�0����*���F�]A��� �*�b���v����28p��<��s�t7��ʯ0n������\��Tm�@F|°)��s~��yHp���֫H	F�����u�k�F�jJ�dn�|�����m��c���@�̩�)�X��hw��"w)fo����j\h6     