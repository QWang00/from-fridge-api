--
-- PostgreSQL database dump
--

-- Dumped from database version 14.12 (Homebrew)
-- Dumped by pg_dump version 14.12 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: fridge_ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fridge_ingredient (
    id integer NOT NULL,
    ingredient_id bigint
);


ALTER TABLE public.fridge_ingredient OWNER TO postgres;

--
-- Name: fridge_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fridge_ingredient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fridge_ingredient_id_seq OWNER TO postgres;

--
-- Name: fridge_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fridge_ingredient_id_seq OWNED BY public.fridge_ingredient.id;


--
-- Name: ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredient (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.ingredient OWNER TO postgres;

--
-- Name: ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ingredient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredient_id_seq OWNER TO postgres;

--
-- Name: ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;


--
-- Name: recipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipe (
    id integer NOT NULL,
    title text NOT NULL,
    image_url text,
    servings integer,
    difficulty text,
    cook_time integer,
    method jsonb,
    description text
);


ALTER TABLE public.recipe OWNER TO postgres;

--
-- Name: recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recipe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipe_id_seq OWNER TO postgres;

--
-- Name: recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recipe_id_seq OWNED BY public.recipe.id;


--
-- Name: recipe_ingredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipe_ingredient (
    id integer NOT NULL,
    recipe_id integer,
    ingredient_id integer,
    quantity text,
    preparation text
);


ALTER TABLE public.recipe_ingredient OWNER TO postgres;

--
-- Name: recipe_ingredient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recipe_ingredient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipe_ingredient_id_seq OWNER TO postgres;

--
-- Name: recipe_ingredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recipe_ingredient_id_seq OWNED BY public.recipe_ingredient.id;


--
-- Name: fridge_ingredient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fridge_ingredient ALTER COLUMN id SET DEFAULT nextval('public.fridge_ingredient_id_seq'::regclass);


--
-- Name: ingredient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient ALTER COLUMN id SET DEFAULT nextval('public.ingredient_id_seq'::regclass);


--
-- Name: recipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe ALTER COLUMN id SET DEFAULT nextval('public.recipe_id_seq'::regclass);


--
-- Name: recipe_ingredient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredient ALTER COLUMN id SET DEFAULT nextval('public.recipe_ingredient_id_seq'::regclass);


--
-- Data for Name: fridge_ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fridge_ingredient (id, ingredient_id) FROM stdin;
\.


--
-- Data for Name: ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredient (id, name) FROM stdin;
1	Chicken wings
2	Oil
3	Coca-Cola
4	Ginger
5	Salt
6	Beer
7	Light soy sauce
8	Dark soy sauce
9	Toasted white sesame seeds
12	Cooking wine
15	White vinegar
17	Star anise
22	Shrimp
25	Garlic
29	Oyster sauce
31	Tomato sauce
32	Sugar
38	Sesame oil
40	Lean pork
41	Black fungus
42	Carrot
43	Green bell pepper
46	Vinegar
50	Water starch
51	Water
56	Chicken
57	Japanese curry block
58	Milk
59	Potato
61	Broccoli
62	Onion
69	Corn flour
70	Peanut butter
71	Sesame seed
72	Egg
73	Tomato
78	Pork belly
81	Rock sugar
88	Bay leaf
89	Cinnamon stick
90	Fennel seed
96	Black tea leaf
97	Tofu
98	Bean paste
100	Sichuan peppercorn
101	Ground pork
102	Thai chili pepper
105	Sichuan peppercorn powder
107	Chicken powder
111	Chili flake
113	Bamboo shoot
118	Pork tenderloin
119	Bok choy
120	Lettuce
121	Bean sprout
122	Green cabbage
123	Romaine lettuce
129	Egg white
133	Hot pot base
139	Dried chili
140	Chili powder
162	Aubergine
174	Plain flour
175	Yeast
178	Pork
188	Pork rib
204	Ketchup
212	Red bell pepper
213	Pineapple
219	Sweet potato starch
226	Beef brisket
241	White sugar
252	Cauliflower
264	Beef
265	Dried shiitake mushroom
272	Chicken thigh
281	Chicken stock
283	White pepper
285	Five-spice powder
286	Ginger powder
292	Boiled rice
295	Mushroom
297	Cucumber
298	Sausage
319	Sea bass
324	Fresh chili
338	Baking soda
342	Sichuan peppercorn oil
343	Spicy barbecue seasoning
344	Cumin powder
364	Black pepper
367	Soy sauce
368	Honey
383	Butter
388	Sweet potato
422	Cardamom pod
53	Spring onion
435	Tomatotest
\.


--
-- Data for Name: recipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe (id, title, image_url, servings, difficulty, cook_time, method, description) FROM stdin;
1	Cola Chicken Wings	https://res.cloudinary.com/deloldrn2/image/upload/v1742480916/coke_chicken_wings_t59f39.jpg	4	Easy	40	["Wash the chicken wings and make two cuts on the back of each wing for better flavor absorption. (If you're lazy, you can skip this step.)", "Place the chicken wings in a pot of cold water with 2 slices of ginger. Bring to a boil.", "Prepare 1 can of Coca-Cola and cut the remaining slice of ginger into thin strips.", "After the water boils, cook the wings for about 2 minutes, then remove and rinse them. Set aside.", "Heat a small amount of oil in a pan. Add the drained chicken wings and pan-fry until fragrant.", "Flip the wings to cook the other side.", "Once both sides are browned, add the ginger strips and beer. Stir-fry until fragrant and the beer reduces slightly. (If you don’t have beer, substitute with 1 tablespoon of cooking wine.)", "Add 1 tablespoon of light soy sauce.", "Add half a tablespoon of dark soy sauce.", "Stir-fry evenly to coat the wings with color.", "Pour in the Coca-Cola. Bring to a boil, then reduce to medium heat. Cover and simmer.", "When the sauce reduces by half, add salt. Increase the heat to reduce the sauce further.", "Reduce the sauce to your desired consistency.", "Plate the wings, sprinkle with toasted white sesame seeds, and serve. (Stir constantly during the final reduction to prevent burning.)"]	Cola Chicken Wings is a sweet and savory dish where chicken wings are simmered in a flavorful mixture of Coca-Cola, soy sauce, and beer. The result is tender, caramelized wings with a glossy finish, topped with toasted sesame seeds for added texture.
3	Home-Style Braised Shrimp	https://res.cloudinary.com/deloldrn2/image/upload/v1742481816/Home-Style_Braised_Prawns_phovfo.jpg	3	Easy	30	["Prepare the ingredients: shrimp, scallions, ginger, and garlic.", "Finely chop the scallions, ginger, and garlic.", "Remove the shrimp heads and antennae.", "Clean the shrimp heads as shown in the image.", "Devein the shrimp using a toothpick inserted between the 2nd and 3rd segments.", "Lift the toothpick to remove the vein.", "Set aside the cleaned shrimp.", "Prepare the sauce mixture: Combine 2 tablespoons of light soy sauce.", "Add 1 tablespoon of cooking wine.", "Add half a tablespoon of dark soy sauce.", "Add 1 tablespoon of oyster sauce.", "Add half a tablespoon of white vinegar.", "Add 1 tablespoon of tomato sauce.", "Add half a tablespoon of sugar.", "Add 4-5 tablespoons of room temperature water.", "Mix the sauce thoroughly.", "Heat oil in a pan and sauté the chopped scallions, ginger, and garlic until fragrant.", "Add the shrimp and stir-fry until both sides turn red.", "Pour in the sauce mixture.", "Cover and braise for about 2 minutes.", "Remove the lid and reduce the sauce.", "Plate the braised shrimp.", "Garnish with chopped scallions."]	Home-Style Braised Shrimp is a quick and flavorful dish featuring tender shrimp cooked in a savory and slightly tangy sauce. The combination of soy sauce, oyster sauce, and tomato sauce creates a rich umami flavor, while the garlic and ginger add a delightful aroma. Perfect for a family meal, this dish is both easy to prepare and delicious!
2	Sweet and Sour Pork Ribs	https://res.cloudinary.com/deloldrn2/image/upload/v1742481696/Sweet_and_Sour_Pork_Ribs_og7qqu.jpg	4	Medium	60	["Wash the pork ribs thoroughly.", "Place the ribs in a pot of cold water, bring to a boil, then remove and drain. Set aside.", "Heat an appropriate amount of oil in a pan and add rock sugar①.", "Heat over medium heat until the sugar turns caramel-colored, then reduce to low heat. Be careful not to overcook, as it can turn bitter and black.", "Add the ribs and quickly stir-fry to coat them with the caramelized sugar. Use a lid to shield yourself from splattering oil.", "Increase to medium-high heat. Add cooking wine, light soy sauce, dark soy sauce, rock sugar②, white vinegar, and ginger slices. Stir-fry until fragrant.", "Prepare star anise and bay leaves (optional).", "Add enough hot water to cover the ribs. Add star anise, bay leaves, and the scallion knot. Bring to a boil, then reduce to low heat and simmer for 30 minutes.", "After 30 minutes, increase the heat to reduce the sauce.", "Once the sauce has thickened, the ribs should have a beautiful glossy color.", "Adjust the sauce consistency to your liking. Taste and adjust saltiness if needed.", "Garnish with toasted white sesame seeds and chopped scallions before serving."]	Sweet and Sour Pork Ribs is a classic Chinese dish featuring tender ribs coated in a glossy, sweet, and tangy sauce. The caramelized sugar and vinegar create a perfect balance of flavors, while star anise and bay leaves add a subtle aromatic depth. Garnished with sesame seeds and scallions, this dish is both visually appealing and delicious!
4	Steamed Egg Custard	https://res.cloudinary.com/deloldrn2/image/upload/v1742481928/Steamed_Egg_Custard_ydbqdf.jpg	3	Easy	20	["Weigh the egg mixture to determine its volume.", "In a thick bowl, pour 1.5 times the volume of 60°C hot water relative to the egg mixture. Add salt and mix well. (For example, if the egg mixture is 120g, use 180g of hot water.)", "Add the beaten eggs to the hot water.", "Mix well, then strain the mixture twice through a sieve.", "Cover the bowl with plastic wrap and poke several small holes in it. Place the bowl in a steamer. Start steaming with cold water. Once the water boils, steam for 6 minutes, then turn off the heat and let it sit for 5 minutes before removing.", "The surface should be smooth like a mirror.", "Add light soy sauce, sesame oil, and chopped scallions. Serve and enjoy!"]	Steamed Egg Custard is a silky, smooth, and delicate dish that is incredibly simple to make. The key is using the right ratio of eggs to hot water and steaming gently to achieve a mirror-like surface. Topped with light soy sauce, sesame oil, and scallions, this dish is both comforting and satisfying, perfect as a side or light meal.
5	Fish-Flavored Shredded Pork	https://res.cloudinary.com/deloldrn2/image/upload/v1742482011/Fish-Flavored_Shredded_Pork_qqtwtz.jpg	3	Medium	30	["Cut the carrot into thin strips, wash the green bell pepper and cut into thin strips, and tear the black fungus into small pieces. Set aside.", "Cut the lean pork into thin strips, marinate with salt, pepper, cooking wine, egg white, and starch for 10 minutes.", "Measure 1 tablespoon of Doubanjiang and chop the scallions, ginger, and garlic.", "In a small bowl, mix sugar, vinegar, cooking wine, soy sauce, water, and water starch to create the sauce. (Skip adding salt if Doubanjiang is salty enough for your taste.)", "Heat oil in a wok or pan. Add the marinated pork and stir-fry until the meat turns white. Remove and set aside.", "In the same wok, add a little more oil. Stir-fry the carrot strips first (as they take longer to cook), then push them to the side. Add Doubanjiang and stir-fry until fragrant and the oil turns red.", "Add the chopped scallions, ginger, garlic, and the remaining vegetables (green bell pepper and black fungus). Stir-fry until cooked.", "Add the cooked pork back into the wok and stir-fry to combine.", "Pour in the prepared sauce and stir-fry until everything is evenly coated and the sauce thickens. Serve immediately."]	Fish-Flavored Shredded Pork is a classic Sichuan dish known for its bold, tangy, and slightly spicy flavor. Despite its name, it contains no fish—the \\"fish flavor\\" comes from the combination of Doubanjiang, vinegar, and sugar. Tender strips of pork are stir-fried with crisp vegetables and coated in a rich, savory sauce, making it a perfect accompaniment to steamed rice.
6	Japanese Chicken Curry Rice	https://res.cloudinary.com/deloldrn2/image/upload/v1742482110/Japanese_Chicken_Curry_Rice_ybd5by.jpg	4	Easy	40	["Marinate the chicken with cooking wine, light soy sauce, scallions, ginger, salt, and corn flour for about 20 minutes. (The corn flour helps keep the chicken tender.)", "Cut the carrot into small chunks (smaller than the potato).", "Cut the potato into chunks and soak in water to remove starch and prevent browning.", "Heat a little oil in a pan. Stir-fry the potato and carrot chunks until the potato turns golden. Remove and set aside. In the same pan, stir-fry the onion (if using) until fragrant, then add the marinated chicken and cook until the chicken changes color. Add the cooked potato and carrot back into the pan.", "Add enough cold water to cover all the ingredients. Bring to a boil, then reduce to low heat. Add the curry blocks and stir until melted. Simmer for about 10 minutes, stirring occasionally to prevent sticking.", "Once the potatoes are soft and the curry has thickened, increase the heat to reduce the sauce. Add a small amount of milk to enrich the flavor and create a creamy texture.", "Optional: Add a small amount of peanut butter (about 1 teaspoon) to enhance the flavor. Stir well.", "Serve the curry over steamed rice. Garnish with blanched broccoli and sesame seeds if desired."]	Japanese Chicken Curry Rice is a comforting and flavorful dish featuring tender chicken, soft potatoes, and carrots simmered in a rich, slightly sweet curry sauce. The addition of milk and a hint of peanut butter (optional) adds depth and creaminess to the curry. Served over steamed rice and garnished with broccoli, this dish is a hearty and satisfying meal that’s easy to make at home!
7	Tomato and Egg Stir-Fry	https://res.cloudinary.com/deloldrn2/image/upload/v1742482211/Tomato_and_Egg_Stir-Fry_nixcz2.jpg	3	Easy	20	["Dissolve 1 teaspoon of salt in a small amount of warm water.", "Beat 4 eggs in a bowl (about 200ml of egg mixture).", "Add water equal to 1/4 of the egg mixture and mix well.", "Heat a little oil in a pan. When the oil is warm, pour in the egg mixture. Cook over low heat. As the bottom sets, gently scrape with chopsticks to let the uncooked egg flow to the bottom.", "Cook until the eggs are mostly set but still slightly runny. Remove from heat immediately, as the residual heat will finish cooking the eggs. The eggs should be tender and moist.", "Set the cooked eggs aside.", "To peel the tomatoes, cut a small X at the top of each tomato.", "Boil water in a pot and blanch the tomatoes for about 30 seconds. Remove and peel the skin easily.", "Cut the peeled tomatoes into small pieces.", "Heat oil in the pan, then add the tomatoes and 2 teaspoons of salt. The salt helps the tomatoes release their juices faster.", "Add 1 tablespoon of sugar and stir well. Cook until the tomatoes break down into a saucy consistency.", "Taste and adjust the seasoning with more sugar or salt if needed. Add the cooked eggs back into the pan and gently mix.", "Garnish with chopped scallions and serve."]	Tomato and Egg Stir-Fry is a classic Chinese comfort dish that combines fluffy, tender scrambled eggs with sweet and tangy tomatoes. The key to this dish is cooking the eggs until they are just set and keeping them moist, while the tomatoes are cooked down into a rich, flavorful sauce. Simple, quick, and delicious, this dish is perfect served over steamed rice!
8	Braised Pork Belly	https://res.cloudinary.com/deloldrn2/image/upload/v1742482295/Braised_Pork_Belly_eseg7b.jpg	4	Medium	90	["Blanch the pork belly pieces in boiling water, then rinse and drain.", "Prepare scallion sections, rock sugar, and ginger slices.", "Heat a little oil in a wok or pot. Add scallions and ginger, and stir-fry until fragrant.", "Add the pork belly and stir-fry until the meat is lightly browned and aromatic.", "Add yellow cooking wine (or regular cooking wine).", "Add light soy sauce.", "Add dark soy sauce.", "Add rock sugar. (Note: Shanghai-style braised pork is slightly sweet. Adjust the amount of sugar to your taste.)", "Add enough warm water to cover the pork. Bring to a boil over high heat.", "Once boiling, reduce to low heat and simmer for about 45 minutes, stirring occasionally.", "After 45 minutes, increase the heat to reduce the sauce. This should take about 10–15 minutes until the sauce is thick and glossy.", "Serve the braised pork belly hot. The dish should be rich, tender, and flavorful!"]	Braised Pork Belly (红烧肉) is a classic Chinese dish known for its rich, savory, and slightly sweet flavor. The pork belly is simmered until tender, with a glossy, thick sauce that coats each piece. This dish is a staple of Shanghainese cuisine and is often served with steamed rice or as part of a larger meal. The variations, such as adding dried cuttlefish, eggs, or tofu skin knots, add unique textures and flavors to this beloved dish!
14	Oyster Sauce Lettuce	https://res.cloudinary.com/deloldrn2/image/upload/v1742482868/Oyster_Sauce_Lettuce_ja0qd9.jpg	3	Easy	15	["Remove any damaged leaves from the lettuce and wash thoroughly.", "Bring a pot of water to a boil, adding a pinch of salt and a few drops of oil.", "Blanch the lettuce in the boiling water for about 10 seconds, ensuring all leaves are evenly cooked. Remove and drain, then arrange on a serving plate.", "In a small bowl, mix oyster sauce, light soy sauce, salt, sugar, and a little water to create the sauce.", "Heat oil in a wok or pan. Add minced garlic and stir-fry until fragrant.", "Pour the prepared sauce into the wok and bring to a boil. Immediately turn off the heat.", "Drizzle the sauce over the blanched lettuce. Serve immediately."]	Oyster Sauce Lettuce (蚝油生菜) is a simple yet flavorful dish that highlights the natural freshness of lettuce. The lettuce is quickly blanched to retain its crispness, then topped with a savory and slightly sweet oyster sauce mixture. This dish is light, healthy, and incredibly easy to prepare, making it a perfect side dish for any meal!
9	Five-Spice Tea Eggs	https://res.cloudinary.com/deloldrn2/image/upload/v1742482372/Five-Spice_Tea_Eggs_wym6oz.jpg	10	Easy	30	["Wash the eggs and place them in a pot of cold water. Bring to a boil, then turn off the heat and let the eggs sit for 5 minutes.", "In a bowl, mix the sugar, salt, dark soy sauce, light soy sauce, and water.", "Rinse the spices (star anise, bay leaves, cinnamon stick, and fennel seeds) briefly in water to clean them. Measure the tea leaves.", "Add the sauce mixture and spices to a pot. Bring to a boil over high heat, then reduce to low heat and simmer for 3 minutes. Add the tea leaves and let the flavors infuse.", "Gently crack the boiled eggs all over their surfaces to create a web of cracks (this helps the eggs absorb the flavors). Add the eggs to the pot.", "Bring the mixture to a boil again, then reduce to low heat and simmer for 5 minutes.", "Turn off the heat and let the eggs steep in the liquid for 12–20 hours for the best flavor. The longer they steep, the more flavorful they will become."]	Five-Spice Tea Eggs (五香茶叶蛋) are a popular Chinese snack made by simmering boiled eggs in a fragrant broth of soy sauce, tea, and spices. The eggs are cracked before cooking to allow the flavorful liquid to seep in, creating a marbled pattern on the egg whites. These eggs are savory, aromatic, and slightly sweet, with a rich depth of flavor from the tea and spices. They are perfect as a snack, breakfast, or addition to a meal!
10	Mapo Tofu	https://res.cloudinary.com/deloldrn2/image/upload/v1742482714/Mapo_Tofu_quwknb.jpg	3	Medium	30	["Cut the tofu into 2–3 cm cubes.", "Blanch the tofu in lightly salted boiling water for about 2 minutes to remove the bean flavor. Drain and set aside.", "Marinate the ground pork with minced garlic, minced ginger, chopped Thai chili peppers, light soy sauce, and a pinch of salt.", "Prepare the sauce mixture by combining light soy sauce, Sichuan peppercorn powder, corn flour, chicken powder, white pepper powder, and water. Mix well.", "Heat oil in a wok or pan. Add the Sichuan peppercorns and fry over low heat until fragrant and slightly darkened. Remove and discard the peppercorns.", "Add the marinated ground pork and 1 tablespoon of bean paste to the wok. Stir-fry until the pork is cooked and the oil turns red.", "Add the blanched tofu cubes and the prepared sauce mixture. Stir gently to combine.", "Bring to a boil over medium heat, then add chili flakes (adjust to taste) and chopped scallions. Stir gently.", "Transfer to a serving plate and garnish with additional scallions if desired."]	Mapo Tofu is a classic Sichuan dish known for its bold, spicy, and numbing flavors. Tender tofu cubes are cooked in a savory, slightly spicy sauce with ground pork, bean paste, and Sichuan peppercorns. The dish is rich, aromatic, and incredibly satisfying, making it a perfect accompaniment to steamed rice. Adjust the level of spiciness to suit your taste!
11	Braised Spring Bamboo Shoots	https://res.cloudinary.com/deloldrn2/image/upload/v1745330145/Braised_Spring_Bamboo_Shoots_mueoai.jpg	3	Easy	40	["Peel the bamboo shoots, remove the tough base, and cut them in half. Blanch in boiling water for 15–20 minutes until tender and sweet. The shoots should turn slightly yellow and lose their raw, astringent smell.", "After blanching, cut the bamboo shoots into 1cm wide and 5cm long pieces.", "Heat a wok or pan and add 30ml of oil. Add the crushed rock sugar and melt it over low to medium heat.", "Add the bamboo shoots to the wok and stir-fry until the edges become slightly caramelized and fragrant.", "Add light soy sauce and dark soy sauce, stirring to coat the bamboo shoots evenly.", "Pour in about 50–100ml of water, cover the wok, and simmer over low heat until the liquid is mostly absorbed. Increase the heat at the end to reduce any remaining sauce."]	Braised Spring Bamboo Shoots (油焖春笋) is a seasonal delicacy that highlights the natural sweetness and tender texture of fresh bamboo shoots. The shoots are blanched to remove any bitterness, then braised with rock sugar and soy sauce to create a glossy, savory-sweet dish. Perfect as a side dish or paired with steamed rice, this dish captures the essence of spring!
12	Sichuan Boiled Beef Slices	https://res.cloudinary.com/deloldrn2/image/upload/v1742482721/Sichuan_Boiled_Beef_Slices_apqkuf.jpg	3	Medium	60	["Thinly slice the pork and marinate with salt, light soy sauce, white pepper powder, egg white, corn flour, and a little oil. Let it sit for at least 30 minutes.", "Chop the scallions and garlic, reserving some for garnish.", "Heat oil in a wok or pot. Add chopped scallions and garlic, then stir-fry until fragrant. Add bean paste (and hot pot base if using) and stir-fry until the oil turns red.", "Add water, salt, sugar, light soy sauce, oyster sauce, and a little vinegar. Bring to a boil, then strain out any solids.", "Add the vegetables to the boiling broth and cook until 80% done. Remove and place in a large serving bowl.", "Bring the broth back to a boil, then reduce to low heat. Gently add the marinated pork slices one by one, spreading them out. Do not stir immediately—wait 5–10 seconds before gently separating the slices. Increase to medium heat and cook for 2–3 minutes until the pork is fully cooked.", "Pour the pork and broth over the vegetables in the serving bowl.", "Heat a generous amount of oil in a wok until smoking hot.", "Top the pork with chopped scallions, minced garlic, Sichuan peppercorns, dried chili peppers, and chili powder.", "Carefully pour the hot oil over the toppings. The sizzling sound indicates the dish is ready!"]	Sichuan Boiled Beef Slices (水煮肉片) is a fiery and flavorful dish featuring tender slices of pork cooked in a spicy, aromatic broth. The dish is layered with blanched vegetables and topped with a sizzling mix of garlic, scallions, Sichuan peppercorns, and chili peppers. The final drizzle of hot oil releases an irresistible aroma, making this dish a true Sichuan classic. Perfect for spice lovers!
13	Sour and Spicy Potato Strips	https://res.cloudinary.com/deloldrn2/image/upload/v1742482846/Sour_and_Spicy_Potato_Strips_lhb1bm.jpg	3	Easy	20	["Prepare the ingredients. Cut the potato into thin, even strips and rinse to remove starch. Soak in water for a few minutes, then drain.", "Soak the dried chili peppers briefly, then cut into thin strips. Cut the green bell pepper into thin strips (if using).", "Heat oil in a wok or pan. Add the dried chili peppers and green bell pepper strips. Stir-fry until fragrant (be careful not to burn them).", "Add the drained potato strips and stir-fry over high heat. Drizzle white vinegar and light soy sauce along the edge of the wok for even distribution.", "Add salt and stir-fry quickly until the potato strips are tender but still crisp.", "Serve immediately as a side dish with steamed rice."]	Sour and Spicy Potato Strips (酸辣土豆丝) is a classic Chinese dish known for its refreshing tanginess and mild heat. The potato strips are crisp and tender, tossed with dried chili peppers and a splash of vinegar for a bright, zesty flavor. This dish is quick to prepare and pairs perfectly with steamed rice, making it a staple in home cooking!
16	Stir-fried Eggplant, Potatoes & Peppers (Di San Xian)	https://res.cloudinary.com/deloldrn2/image/upload/v1742482982/Di_San_Xian_qfb8ad.jpg	4	Medium	40	["Cut the eggplant, potatoes, and green bell peppers into bite-sized pieces.", "Coat the eggplant pieces with corn flour to reduce oil absorption.", "Heat oil in a wok or deep pan. Fry the eggplant for about 3 minutes, the potatoes for about 5 minutes (until golden), and the green bell peppers for about 10 seconds. Remove and drain on paper towels.", "In a small bowl, mix water, light soy sauce, oyster sauce, dark soy sauce, sugar, corn flour, and a pinch of salt to create the sauce.", "Heat a little oil in a clean wok or pan. Add minced garlic and stir-fry until fragrant.", "Pour the sauce mixture into the wok and bring to a boil.", "Add the fried vegetables to the wok and stir-fry until evenly coated with the sauce. Cook until the sauce thickens.", "Serve hot with steamed rice."]	Di San Xian (地三鲜) is a classic Northeastern Chinese dish featuring eggplant, potatoes, and green bell peppers. The vegetables are fried until tender and then tossed in a savory, slightly sweet sauce. This dish is hearty, flavorful, and incredibly satisfying, making it a perfect accompaniment to steamed rice. The combination of textures and flavors makes it a favorite in Chinese home cooking!
17	Juicy Meat Buns	https://res.cloudinary.com/deloldrn2/image/upload/v1742483133/Juicy_Meat_Buns_aylchi.jpg	12	Medium	120	["Prepare the dough by mixing flour, yeast, sugar, and warm water. Knead until smooth and let it ferment in a warm place for 30–40 minutes (or 1 hour in winter) until doubled in size.", "While the dough is fermenting, prepare the filling by mixing all the filling ingredients. Stir vigorously until the mixture becomes sticky and cohesive.", "After the dough has fermented, punch it down to release air and knead for 5–8 minutes until smooth.", "Divide the dough into small portions (50–60g each) and roll each into a round wrapper, thicker in the center and thinner at the edges.", "Place a spoonful of filling in the center of each wrapper. Pinch and pleat the edges to seal the bun, ensuring the top is tightly closed.", "Place the buns on a steamer tray lined with oiled parchment paper. Let them rest for 15 minutes for a second fermentation.", "Steam the buns over cold water for 15 minutes. Do not open the lid during steaming. Turn off the heat and let them sit for 3 minutes before opening the lid.", "Serve hot and enjoy the juicy, flavorful meat buns!"]	Juicy Meat Buns (肉包子) are a classic Chinese comfort food, featuring soft, fluffy dough filled with a savory and juicy pork filling. The buns are steamed to perfection, resulting in a tender texture and rich flavor. Perfect for breakfast, snacks, or any meal, these buns are sure to satisfy your cravings!
18	Braised Pork Ribs	https://res.cloudinary.com/deloldrn2/image/upload/v1742483253/Braised_Pork_Ribs_g9m3x9.jpg	3	Easy	60	["Cut the pork ribs into small pieces and blanch in boiling water. Rinse and drain.", "Hard-boil 3 eggs, peel, and set aside.", "Heat oil in a wok or pan. Add 2 tablespoons of sugar and cook over medium heat until it melts and turns amber (about 2 minutes).", "Add the blanched pork ribs to the caramelized sugar and stir-fry to coat evenly.", "Add ginger slices, bay leaves, and cinnamon stick. Stir-fry briefly.", "Pour in enough water to cover the ribs. Add light soy sauce and cooking wine.", "Add the hard-boiled eggs to the wok.", "Bring to a boil, then reduce to low heat. Cover and simmer for about 30 minutes.", "After 30 minutes, uncover and increase the heat to reduce the sauce until it thickens and coats the ribs.", "Gently stir the ribs and eggs to ensure they are evenly coated with the sauce.", "Serve hot with steamed rice."]	Braised Pork Ribs (红烧排骨) is a classic Chinese dish featuring tender pork ribs and hard-boiled eggs cooked in a savory, slightly sweet sauce. The ribs are caramelized in sugar for a rich color and flavor, then simmered with aromatic spices until tender. This dish is hearty, flavorful, and perfect for a comforting family meal!
19	Sweet and Sour Pork Tenderloin	https://res.cloudinary.com/deloldrn2/image/upload/v1742905134/Sweet_and_Sour_Pork_Tendeloin_bjqj3x.png	4	Easy	45	["Cut the pork tenderloin into finger-sized strips.", "Marinate the pork strips with salt, cooking wine, and egg for 20–30 minutes.", "Coat the marinated pork strips evenly with the cornstarch and flour mixture.", "Heat oil in a wok or deep pan. Fry the pork strips over low heat for about 4 minutes until golden. Remove and drain.", "Increase the heat to high and fry the pork strips again for 1 minute to make them crispy. Remove and drain.", "In a clean pan, combine ketchup, water, sugar, and white vinegar. Heat over low heat until the sugar dissolves.", "Add cornstarch slurry to thicken the sauce.", "Add the fried pork strips to the sauce and stir to coat evenly.", "Garnish with white sesame seeds and serve hot."]	Sweet and Sour Pork Tenderloin (糖醋里脊) is a classic Chinese dish featuring crispy, tender pork strips coated in a tangy and slightly sweet sauce. The combination of ketchup, sugar, and vinegar creates a vibrant flavor that is both refreshing and satisfying. Perfect for beginners and a guaranteed crowd-pleaser!
20	Sweet and Sour Pork with Pineapple	https://res.cloudinary.com/deloldrn2/image/upload/v1745316788/Sweet_and_Sour_Pork_with_Pineapple_nkbrlw.png	4	Medium	60	["Tenderize the pork by pounding with the back of a knife, then cut into bite-sized pieces.", "Marinate the pork with sugar, salt, white pepper powder, and beer for at least 30 minutes.", "Add egg to the marinated pork and mix well.", "Coat the pork pieces with sweet potato starch or a cornstarch-flour mixture.", "Heat oil in a deep pan or wok. Fry the pork pieces over medium heat until lightly golden. Remove and let cool.", "Reheat the oil and fry the pork again over high heat for about 10 seconds until crispy and golden. Remove and drain.", "In a clean pan, stir-fry bell peppers and pineapple until slightly tender. Remove and set aside.", "In the same pan, heat ketchup with a little water. Add sugar and white vinegar (if using), then thicken with cornstarch slurry.", "Add the fried pork to the sauce and stir to coat evenly.", "Add the stir-fried bell peppers and pineapple. Mix well and serve hot."]	Sweet and Sour Pork with Pineapple (菠萝咕咾肉) is a vibrant and flavorful dish featuring crispy pork, sweet pineapple, and colorful bell peppers in a tangy-sweet sauce. The pork is tenderized and double-fried for extra crispiness, while the pineapple adds a refreshing tropical twist. This dish is a delightful balance of textures and flavors, perfect for any meal!
34	Steamed Pork Ribs with Rice Flour	https://res.cloudinary.com/deloldrn2/image/upload/v1742821012/Steamed_Pork_Ribs_with_Rice_Flour_jajmx4.jpg	4	Intermediate	120	["Cut pork ribs into 3-inch pieces.", "Marinate ribs with cooking wine, light soy sauce, dark soy sauce, oyster sauce, white pepper, and chicken stock.", "Heat oil in a small pan, sauté bean paste and minced garlic until fragrant. Let cool and add to marinated ribs. Marinate for 40 minutes.", "Coat marinated ribs with rice flour mix. Add a splash of water if too dry; mixture should lightly cling.", "Layer sweet potato chunks at the bottom of a steaming dish. Place ribs on top, leaving small gaps for steam circulation.", "Steam over high heat for 90 minutes (reduce to 70 minutes if needed).", "Garnish with chopped scallion and serve hot."]	This comforting Cantonese-style dish features pork ribs marinated in a rich umami sauce and coated with a soft rice flour crust. Steamed slowly over sweet potatoes, the result is tender, juicy meat with deep flavor and subtle aromatics.
21	Braised Beef Brisket with Tomatoes	https://res.cloudinary.com/deloldrn2/image/upload/v1742819278/Braised_Beef_Brisket_with_Tomatoes_igcbjm.jpg	4	Intermediate	180	["Soak beef chunks in cold water for 30 minutes to remove blood. Drain.", "Blanch beef in cold water with scallions, ginger slices, and 2 tbsp cooking wine. Boil for 5 minutes, skim foam, then rinse with hot water.", "Blanch tomatoes to peel, then dice. Dice onion. Prepare spices: bay leaves, cinnamon, star anise, dried chili.", "Mix light soy sauce, 1 tbsp cooking wine, and dark soy sauce for the sauce base.", "Sauté onion in oil until translucent. Add tomatoes and 1g salt. Cook until mushy (5 minutes). Set aside.", "In a wok, heat oil and melt rock sugar until amber. Add beef and stir to coat evenly in caramel.", "Add prepared spices. Stir-fry until fragrant.", "Deglaze with sauce mix. Transfer to a clay pot. Add tomato-onion mixture and hot water to cover. Add 2g white sugar.", "Simmer covered for 1.5 hours on low heat.", "Add remaining 2g salt. Simmer uncovered for 30 more minutes until beef is tender.", "Discard spices and garnish with chopped scallions. Serve hot."]	Braised Beef Brisket with Tomatoes (番茄炖牛腩) is a comforting, rich dish of tender beef simmered in a tomato-based sauce with fragrant spices. Rock sugar adds a caramel note, while the long braising infuses deep flavor. Serve in a clay pot with steamed rice for a warm, hearty meal.
22	Silky Shrimp and Egg Stir-Fry	https://res.cloudinary.com/deloldrn2/image/upload/v1745402216/shrimp_egg_b9lmpd.jpg	2	Easy	15	["Pat the shrimp dry and marinate with cooking wine and salt for 10 minutes.", "Sear the shrimp over high heat for 90 seconds until pink, then remove and reserve the juices.", "Whisk eggs lightly with salt, being careful not to overbeat. Mix in the shrimp, reserved juices, and water starch.", "Heat the wok until smoking, then add oil.", "Immediately pour in the egg mixture and turn off the heat.", "Fold gently as the edges set, allowing residual heat to finish cooking the eggs to a silky texture.", "Garnish with chopped scallions and serve hot with steamed rice."]	Silky Shrimp and Egg Stir-Fry (虾仁滑蛋) is a Cantonese-style dish featuring lightly scrambled eggs combined with tender shrimp and a touch of scallion for brightness. The key to the silky texture lies in using water starch and mastering the heat timing for a custardy finish.
23	Dry Pot Cauliflower	https://res.cloudinary.com/deloldrn2/image/upload/v1742819279/Dry_Pot_Cauliflower_j7r6fj.jpg	3	Easy	20	["Break cauliflower into florets using a knife to retain crunch. Soak in brine (1 tsp salt + 500ml water) for 10 minutes. Dry thoroughly.", "Toast Sichuan peppercorns in cold oil. Remove when fragrant.", "Add thinly sliced pork belly. Render fat and cook until golden and crispy.", "Add smashed garlic, julienned scallions, and dried chili to bloom in pork fat over medium-low heat.", "Turn heat to high. Add cauliflower. Stir-fry quickly until it begins to char slightly.", "Drizzle oyster sauce, light soy sauce, sugar, and salt around the wok edges. Stir to coat evenly.", "Optional: Cover with lid and steam briefly (30 seconds max) to help cauliflower cook through.", "Serve immediately with a garnish of scallion threads. Best enjoyed with steamed rice or a cold beer."]	Dry Pot Cauliflower (干锅花菜) is a bold-flavored Sichuan-style dish made with charred cauliflower florets, crispy pork belly, and aromatic spices. Stir-fried at high heat, the dish develops wok hei, or the signature smoky aroma of Chinese dry pot cooking. Balanced with a savory-sweet sauce, this dish is quick, crunchy, and utterly satisfying.
24	Beef Chili Sauce	https://res.cloudinary.com/deloldrn2/image/upload/v1742819401/Homemade_Beef_Sauce_kseqic.jpg	0	Medium	30	["Soak dried shiitake mushrooms until soft, then finely dice.", "Mince garlic and chop Thai chili peppers.", "Cut beef into small cubes (slightly larger pieces add texture).", "Heat 2 cups of oil in a wok or deep pan.", "Add minced garlic and fry until golden (about 2 minutes).", "Add diced mushrooms and stir-fry until semi-dry (about 3 minutes).", "Add beef cubes and cook until moisture evaporates (8–10 minutes).", "Stir in chopped chilies and cook for 2 more minutes.", "Turn off heat, mix in bean paste and salt. Reheat and stir until the oil turns clear (about 5 minutes).", "Add toasted sesame seeds and cook 2 more minutes.", "Cool completely before storing in sterilized jars."]	This rich, umami-packed beef chili sauce combines tender beef, earthy mushrooms, and fiery chilies in a savory soybean base. Perfect as a condiment for noodles, rice, or dumplings, it develops deeper flavor after 1–2 days in the fridge. The toasted sesame seeds add a nutty finish. Adjust chili heat to preference. Yields ~3 cups.
25	Braised Chicken with Rice	https://res.cloudinary.com/deloldrn2/image/upload/v1742819794/Braised_Chicken_with_Rice_zecqwk.jpg	4	Intermediate	90	["Soak dried mushrooms in warm water. Reserve the soaking liquid.", "Cut chicken thighs into chunks and soak in cold water for 1 hour to remove blood.", "Marinate chicken with light soy sauce, dark soy sauce, cooking wine, white pepper, ginger powder, oyster sauce, and five-spice powder for 30 minutes.", "Cut potatoes into wedges, bell peppers into chunks, and mushrooms in half.", "Sear potatoes in hot oil until lightly browned. Set aside.", "Caramelize rock sugar in the same pan until amber. Add chicken and sear until colored.", "Stir in garlic, ginger, dried chilies, and bay leaf. Deglaze with cooking wine.", "Add oyster sauce, soy sauces, sugar, and mushrooms. Pour in reserved mushroom water (or boiling water) to cover.", "Simmer covered for 40 minutes. Add potatoes and cook for 25 more minutes.", "Stir in bell peppers and chicken stock. Cook for 3 more minutes and serve hot over rice."]	A hearty one-pot dish featuring tender braised chicken, earthy mushrooms, and potatoes in a savory-sweet sauce. The reserved mushroom liquid deepens the umami flavor, while caramelized sugar adds richness. Serve over steamed rice for a complete meal. Adjust chili heat to preference.
26	Egg Fried Rice	https://res.cloudinary.com/deloldrn2/image/upload/v1742819931/Egg_Fried_Rice_rsctsp.jpg	3	Easy	20	["Mix egg yolks with boiled rice until the grains are evenly coated.", "Dice all vegetables and sausage into uniform pieces.", "Heat oil until smoking, then reduce heat. Scramble egg whites until just set. Remove and set aside.", "In the same pan, add more oil. Stir-fry carrots and mushrooms for 2–3 minutes until edges caramelize. Remove and set aside.", "Add oil again and heat until smoking. Add yolk-coated boiled rice and break up clumps over medium-low heat for 10 minutes until grains separate.", "Return cooked vegetables, egg whites, sausage, and cucumber to the pan. Toss with chopped scallions, salt, sugar, and white pepper.", "Cook 1 more minute. Serve hot, optionally with chili flakes."]	Golden, fluffy fried rice with crisp vegetables and savory sausage. Coating the rice in egg yolks before frying ensures each grain is distinct and rich. Day-old rice works best, but fresh rice can be used with extra cooking time. Customize with your favorite proteins or spices!
27	Spicy Diced Chicken	https://res.cloudinary.com/deloldrn2/image/upload/v1742820046/Spicy_Diced_Chicken_qk1gjk.jpg	4	Intermediate	45	["Cut chicken thighs into bite-sized pieces.", "Soak dried chilies in warm water for 5 minutes to prevent burning.", "Marinate chicken with ginger, salt, five-spice powder, cooking wine, light soy sauce, and oyster sauce. Let sit for 30 minutes.", "Before frying, mix in egg white and corn flour to coat the chicken evenly.", "Heat oil to 180°C (350°F). Fry chicken in batches until golden (3–4 minutes). Drain.", "Increase oil temperature and refry chicken for 1 minute to enhance crispiness.", "In a separate pan, sauté garlic, ginger, and scallions until fragrant.", "Add Sichuan peppercorns and soaked chilies. Toast for 30 seconds.", "Add fried chicken, sugar, and sesame seeds. Toss to coat evenly and serve hot."]	Crispy chicken bites with a fiery kick from toasted chilies and numbing Sichuan peppercorns. The double-fry method ensures juicy meat with a crunchy shell. Adjust chili quantity for heat preference. Serve with steamed rice to balance the spice!
28	Steamed Sea Bass	https://res.cloudinary.com/deloldrn2/image/upload/v1742820145/Steamed_Sea_Bass_vz5xyv.jpg	3	Easy	10	["Clean the sea bass and make diagonal cuts along both sides of the backbone without cutting through.", "Rub the fish with salt, wait 10 seconds, and rinse to remove slime.", "Julienne scallions, ginger, and chili. Soak scallions in ice water to curl.", "Place fish on a plate with scallion stalks and ginger underneath.", "Steam the fish over boiling water for 7 minutes. Adjust time based on fish size.", "Discard the steamed aromatics and fish juices to reduce fishy odor.", "Transfer fish to a clean plate. Pour light soy sauce around the fish.", "Top with fresh scallions, ginger, and chili.", "Heat oil until smoking and drizzle over the fish to sizzle the aromatics."]	A restaurant-style steamed sea bass with silky flesh and clean flavors. The hot oil unlocks the aroma of fresh scallions and ginger, while soy sauce adds umami depth. Perfect for a light yet impressive meal. Adjust chili for subtle heat.
29	Twice-Cooked Pork	https://res.cloudinary.com/deloldrn2/image/upload/v1742820267/Twice_Cooked_Pork_chwflr.jpg	4	Intermediate	30	["Sear pork belly skin in a dry pan or over flame to remove odor.", "Boil pork belly in water until about 70% cooked (~15 minutes), then chill and slice thinly.", "Slice bell pepper and onion uniformly.", "Heat oil in a pan and fry the pork slices until fat is rendered and edges curl (~5 minutes).", "Push pork to the side and sauté ginger, garlic, and bean paste in the rendered fat until fragrant.", "Add sugar and light soy sauce, mix well with pork.", "Add sliced bell pepper and onion. Stir-fry for 1 minute until crisp-tender.", "Season with salt and chicken stock. Toss everything together and serve."]	Crisp-edged pork belly stir-fried with vibrant peppers and onions in a spicy bean paste glaze. The double-cooking method (boil + fry) ensures tender meat with caramelized edges. Serve over rice to soak up the rich sauce!
30	Stir-Fried Beef	https://res.cloudinary.com/deloldrn2/image/upload/v1742820374/Stir-fried_Beef_drxowp.jpg	3	Easy	15	["Slice beef against the grain into thin pieces (~2mm).", "Marinate beef with baking soda, dark soy sauce, light soy sauce, oyster sauce, Sichuan peppercorn oil, barbecue seasoning, and cumin powder. Let rest for at least 30 minutes or overnight.", "Heat oil in a wok and sauté garlic until fragrant (~10 seconds).", "Add beef over high heat, spread evenly, and sear undisturbed for 20 seconds.", "Stir-fry beef for 1–2 minutes until the pink color disappears.", "Remove from heat and mix in sesame seeds and chopped scallions.", "Serve hot with rice or lettuce wraps."]	Tender, spice-crusted beef with a smoky aroma from cumin and barbecue seasoning. The baking soda marinade guarantees melt-in-your-mouth texture. Serve with rice or lettuce wraps for a quick, flavorful meal. Adjust chili level to taste!
31	Green Pepper and Shredded Pork Rice Bowl	https://res.cloudinary.com/deloldrn2/image/upload/v1745405527/green_pepper_sliced_pork_cg6hwx.jpg	2	Easy	20	["Cut pork tenderloin into thin strips. Marinate with light soy sauce, cooking wine, and corn flour for 10 minutes.", "Mix sauce ingredients: light soy sauce, oyster sauce, salt, sugar, corn flour, and water.", "Heat 1 tbsp of oil in a pan. Stir-fry the marinated pork until opaque (~1 minute), then set aside.", "In the same pan, add 1 tbsp more oil and sauté minced garlic until fragrant.", "Add green bell pepper and stir-fry for 1 minute.", "Return pork to the pan and pour in the prepared sauce.", "Stir quickly until everything is evenly coated and glossy (~30 seconds).", "Serve over hot steamed rice."]	This dish balances tender pork with crisp green bell peppers in a glossy, flavorful sauce. The corn flour marinade keeps the meat juicy, while the sauce thickens perfectly in the pan. Quick cooking keeps the peppers vibrant. Great for a satisfying weeknight meal.
32	Teriyaki Chicken Rice Bowl	https://res.cloudinary.com/deloldrn2/image/upload/v1742820725/Teriyaki_Chicken_Rice_Bowl_cxz5qd.jpg	2	Easy	25	["Marinate chicken thighs with black pepper, salt, and sliced ginger for 5 minutes.", "In a bowl, mix soy sauce, honey, dark soy sauce, and water to form the teriyaki sauce.", "Heat oil in a pan. Place chicken skin-side down and sear until golden (~4 minutes).", "Flip chicken, add sliced garlic, and cook for another minute.", "Pour in the sauce. Cover and simmer on low heat for 10 minutes.", "Slice the chicken and serve over steamed rice with blanched broccoli and carrots.", "Drizzle with the reduced teriyaki sauce from the pan."]	Teriyaki Chicken Rice Bowl is a flavorful dish featuring juicy, pan-seared chicken glazed in a sweet-savory teriyaki sauce. Served with vibrant blanched vegetables and warm rice, this meal is simple yet deeply satisfying. Great for weeknight dinners or lunch boxes.
33	Japanese Beef Rice Bowl (Gyudon)	https://res.cloudinary.com/deloldrn2/image/upload/v1742820849/Japanese_Beef_Rice_Bowl_Gyudon_tuac84.jpg	1	Easy	15	["Mix all sauce ingredients except corn flour and water for the slurry.", "Optionally blanch the beef in boiling water for 10 seconds (skip for high-quality cuts).", "Heat butter or oil in a pan. Sauté sliced onions for about 3 minutes until soft.", "Add sliced beef and stir-fry for about 1 minute until fragrant.", "Pour in the sauce mixture and simmer for 2 minutes.", "Stir in the corn flour slurry to thicken the sauce slightly.", "Serve beef and onions over steamed rice. Top with sesame seeds and a soft-boiled egg."]	Gyudon is a beloved Japanese rice bowl dish made with tender beef slices simmered in a sweet-savory sauce and served over steamed rice. Butter and soy create rich umami depth, and the runny egg adds creaminess. A quick and comforting meal!
35	Garlic Butter Chicken Wings	https://res.cloudinary.com/deloldrn2/image/upload/v1742821197/Garlic_Butter_Chicken_Wings_yczlp3.jpg	2	Easy	30	["Toss chicken wings with garlic, soy sauce, oyster sauce, black pepper, salt, and sugar. Let marinate for 20 minutes.", "Heat oil in a pan. Fry the chicken wings skin-side down until golden and crispy on both sides (about 5 minutes per side). Remove from pan.", "In the same pan, sauté additional garlic until fragrant.", "Add the cooked wings and diced red and green bell peppers. Toss everything together for 1 minute over medium heat.", "Serve hot."]	Garlic Butter Chicken Wings are golden and juicy, tossed in a savory sauce with vibrant peppers. A quick sear locks in juices, while garlic and soy deliver deep flavor. Perfect for a comforting, easy dinner or as an appetizer.
36	Xinjiang Big Plate Chicken	https://res.cloudinary.com/deloldrn2/image/upload/v1742821297/Xinjiang_Big_Plate_Chicken_z5gsuv.jpg	6	Intermediate	60	["Heat oil and melt rock sugar until amber. Add chicken pieces and sear on both sides until golden.", "Push chicken to the side. Add star anise, cinnamon stick, Sichuan peppercorns, and cardamom pod. Toast until fragrant.", "Add ginger, garlic, and bean paste. Stir-fry briefly. Deglaze with beer.", "Add potatoes, light soy sauce, dark soy sauce, and chicken stock. Cover and simmer for 15 minutes until potatoes are almost tender.", "Add red and green bell peppers and onion chunks. Simmer uncovered for 2 minutes.", "Drizzle sesame oil and stir. Thicken the sauce with corn flour slurry if needed.", "Serve hot over wide noodles or rice."]	A hearty, spice-laden stew of chicken, potatoes, and peppers simmered in a fragrant broth of soy sauce, dried chili, and Xinjiang spices. Known for its rich color and bold flavor, this dish is often served over thick noodles to soak up the sauce.
\.


--
-- Data for Name: recipe_ingredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_ingredient (id, recipe_id, ingredient_id, quantity, preparation) FROM stdin;
1	1	1	12 pieces	Wash and make two cuts on the back of each wing for better flavor absorption
3	1	3	1 can	Prepare 1 can
4	1	4	3 slices	Slice 3 pieces, with one slice cut into thin strips
6	1	6	2 tablespoons	Measure 2 tbsp (can substitute with 1 tbsp of cooking wine)
7	1	7	1 tablespoon	Measure 1 tbsp
8	1	8	half a tablespoon	Measure 0.5 tbsp
12	2	12	1 tablespoon	
13	2	7	2 tablespoons	
15	2	15	4 tablespoons	
16	2	8	1 teaspoon	
17	2	17	1 piece	
20	2	4	3 slices	Slice 3 pieces
21	2	9	a small amount	
22	3	22	1 pound	Clean and devein
24	3	4	a small amount	Chop finely
25	3	25	5-6 cloves	Chop finely
26	3	7	2 tablespoons	
27	3	12	1 tablespoon	
28	3	8	half a tablespoon	
29	3	29	1 tablespoon	
30	3	15	half a tablespoon	
31	3	31	1 tablespoon	
32	3	32	half a tablespoon	
36	4	5	half a teaspoon	
37	4	7	1 tablespoon	
38	4	38	half a tablespoon	
40	5	40	250g	Cut into thin strips and marinate with salt, pepper, cooking wine, egg white, and starch for 10 minutes
41	5	41	50g	Soak and tear into small pieces
42	5	42	50g	Peel and cut into thin strips
43	5	43	40g	Wash, remove seeds, and cut into thin strips
45	5	32	20g	
46	5	46	20g	
47	5	12	15g	
48	5	7	15g	
49	5	5	1g	For marinating
50	5	50	10g	
51	5	51	20g	
53	5	53	appropriate amount	Chopped
54	5	4	appropriate amount	Chopped
55	5	25	appropriate amount	Chopped
56	6	56	amount as desired	Cut into bite-sized pieces and marinate for 20 minutes
57	6	57	50g for 2 servings, 100g for 4 servings	Break into small pieces for easier melting
58	6	58	about 80ml (1/3 cup)	
59	6	59	1 large or 2 medium	Peel and cut into chunks. Soak in water to remove starch and prevent browning
60	6	42	amount as desired	Peel and cut into smaller chunks than the potato
61	6	61	amount as desired	Used as garnish
62	6	62	amount as desired	Slice thinly (optional)
63	6	2	a small amount	
64	6	12	1 tablespoon	
65	6	7	2 tablespoons	
66	6	53	a small amount	
67	6	4	a small amount	
68	6	5	a small amount	
69	6	69	for tenderizing	
70	6	70	1 teaspoon	Optional, for flavor
71	6	71	a small amount	Optional, for garnish
72	7	72	4	Crack into a bowl
73	7	73	3	Blanch, peel, and cut into small pieces
74	7	2	appropriate amount	
75	7	5	3 teaspoons (divided)	
76	7	32	1 tablespoon	
77	7	53	a small amount	Chop finely for garnish
78	8	78	appropriate amount	Cut into bite-sized pieces, blanch, and drain
79	8	7	appropriate amount	
80	8	8	appropriate amount	
81	8	81	a small handful	
82	8	12	appropriate amount	
83	8	53	a few pieces	Cut into sections
84	8	4	a few pieces	Slice into thin pieces
85	8	2	a small amount	
86	9	72	10	Wash thoroughly
87	9	17	2 pieces	
88	9	88	2g	
89	9	89	1g	
90	9	90	2g	
91	9	32	30g	
92	9	5	20g	
93	9	8	15g	
94	9	7	25g	
95	9	51	600g	
96	9	96	5g	
97	10	97	300–400g	Cut into 2–3 cm cubes
98	10	98	1 tablespoon	
99	10	69	1 tablespoon	
100	10	100	30 pieces	
101	10	101	100g	Marinate with garlic, ginger, soy sauce, chili, and salt
102	10	102	2	Chopped
103	10	25	2 cloves	Minced
104	10	4	1 small piece	Minced
105	10	105	1 tablespoon	
106	10	5	a small amount	
107	10	107	1 tablespoon	
108	10	7	3 tablespoons	
109	10	53	1 stalk	Chopped
111	10	111	appropriate amount	
112	10	2	as needed	
113	11	113	4–5 pieces (about 1 pound with shells)	Peel, remove tough base, blanch 15–20 minutes
114	11	81	5–6 small pieces (or 10g white sugar)	Crush into smaller pieces
115	11	7	15–20ml	
116	11	8	5ml	
117	11	2	30ml	
118	12	118	300g	Thinly sliced and marinated
119	12	119	appropriate amount	
19	2	53	1 bunch	Tie into a knot
39	4	53	1 stalk	Chop finely
10	2	188	500g	Wash thoroughly
2	1	2	a small amount	
5	1	5	around 1 gram	
9	1	9	a small amount	
120	12	120	appropriate amount	
121	12	121	appropriate amount	
122	12	122	half	
123	12	123	2 stalks	
124	12	25	appropriate amount	Minced
125	12	53	appropriate amount	Chopped
126	12	5	to taste	
127	12	7	appropriate amount	
129	12	129	1	
130	12	69	appropriate amount	
131	12	2	as needed	
132	12	98	1–2 tablespoons	
133	12	133	a small piece	
134	12	51	appropriate amount	
135	12	32	a small amount	
136	12	29	a small amount	
137	12	46	a small amount	
138	12	100	appropriate amount	
139	12	139	appropriate amount	
140	12	140	appropriate amount	
141	13	59	1 large	Peel, cut into thin strips, rinse and soak
142	13	139	5	Soak briefly and cut into strips
143	13	43	1 (optional)	Cut into thin strips
144	13	46	2 tablespoons	
145	13	7	3 tablespoons	
146	13	5	2g	
147	13	2	appropriate amount	
148	14	120	3 heads	Remove damaged leaves and wash thoroughly
149	14	29	2 tablespoons	
150	14	25	4–5 cloves	Minced finely
151	14	7	3 tablespoons	
152	14	5	0.5 teaspoon	
153	14	32	0.5 teaspoon	
154	14	2	appropriate amount	
162	16	162	1	Cut into bite-sized pieces and coat with corn flour
163	16	43	2	Cut into bite-sized pieces
164	16	59	2	Peel and cut into bite-sized pieces
165	16	69	2 tablespoons	
166	16	5	to taste	
167	16	7	3 tablespoons	
168	16	8	1 tablespoon	
169	16	29	1 tablespoon	
170	16	32	1 tablespoon	
171	16	2	for frying	
172	16	25	3 cloves	Minced
173	16	51	half a bowl	
174	17	174	500g	
175	17	175	5g	
176	17	32	1 tablespoon	
177	17	51	250g + 2–3 tablespoons	Use 38°C for dough; use in filling for juiciness
178	17	178	300g	Finely chopped, 30% fat, 70% lean
179	17	53	to taste	Chopped
180	17	12	1 tablespoon	
181	17	7	1 tablespoon	
182	17	8	1 teaspoon	
183	17	29	1 tablespoon	
184	17	38	1 teaspoon	
185	17	5	to taste	
187	17	2	1–2 tablespoons	Heated and cooled before use
188	18	188	330g	Cut into small pieces and blanched
189	18	72	3	Hard-boiled and peeled
190	18	7	5 tablespoons	
191	18	32	2 tablespoons	
192	18	12	2 tablespoons	
193	18	4	5 slices	
194	18	88	2 pieces	
195	18	89	1 small piece	
196	18	2	appropriate amount	
197	18	51	enough to cover ribs	
198	19	118	400g	Cut into finger-sized strips
199	19	5	1 teaspoon	
200	19	12	appropriate amount	
201	19	72	1	
202	19	69	equal part of coating mix	
203	19	174	equal part of coating mix	
204	19	204	60g	
205	19	51	45g + for slurry	
206	19	32	30g	
207	19	15	20g	
208	19	2	for frying	
209	19	71	appropriate amount	
210	20	118	300g	Cut into bite-sized pieces and tenderized
211	20	43	half	Cut into diamond-shaped pieces
212	20	212	half	Cut into diamond-shaped pieces
213	20	213	half small	Cut into chunks and soaked in salted water
214	20	5	½ teaspoon	
216	20	32	½ teaspoon + 1 tablespoon	
217	20	6	1 tablespoon	
218	20	72	1	
219	20	219	appropriate amount	For coating
220	20	69	for slurry	
221	20	174	optional, mix with corn flour for coating	
222	20	204	3 tablespoons	
223	20	15	½ tablespoon	
224	20	51	as needed	For sauce and slurry
225	20	2	as needed	For frying
226	21	226	600g	Cut into large chunks
227	21	73	2	Blanched, peeled, and diced
228	21	62	half	Diced
229	21	53	4	3 whole for boiling, 1 chopped for garnish
230	21	81	9 small pieces	
231	21	4	1 thumb-sized piece	Sliced
232	21	25	5 cloves	Smashed
233	21	88	3	
234	21	89	1 small piece	
235	21	17	2	
236	21	139	5	
237	21	7	2 tablespoons	
238	21	8	1 tablespoon	
239	21	12	3 tablespoons	Divided
240	21	5	3g	Divided
241	21	241	2g	
242	21	2	as needed	
243	21	51	enough to cover beef	
244	22	72	4 (~220g)	
245	22	22	200g	Peeled and deveined
246	22	53	1 bunch	Chopped
247	22	12	2 tsp	
248	22	5	1.5 tsp	Divided
249	22	69	2 tsp	
128	12	283	a small amount	
186	17	283	a pinch	
215	20	283	1 teaspoon	
250	22	51	2 tbsp	
251	22	2	3 tbsp	
252	23	252	1 medium (~500g)	Broken into florets, soaked in brine and dried
253	23	78	100g	Thinly sliced
254	23	139	5–6	Halved
255	23	100	1 tsp	
256	23	25	5 cloves	Smashed
257	23	53	2 stalks	Julienned
258	23	29	1 tbsp	
259	23	7	1 tbsp	
260	23	32	½ tsp	
261	23	5	to taste	
262	23	2	2 tbsp	
263	23	51	500ml	For brine (with salt)
264	24	264	250g	Cut into small cubes
265	24	265	1 cup	Soaked and diced
266	24	25	1 cup	Minced
267	24	102	1 cup	Chopped
268	24	98	5 tbsp	
269	24	2	2 cups	
270	24	71	as needed	Toasted
271	24	5	2 tsp	
272	25	272	2	Bone-in, cut into chunks
273	25	265	10	Soaked, halved
274	25	43	2	Cut into chunks
275	25	59	2	Cut into wedges
276	25	12	2 tbsp	
277	25	81	Small handful	
278	25	29	3 tbsp	
279	25	7	2 tbsp	
280	25	8	2 tbsp	
281	25	281	1.5 tsp	
282	25	88	1	
283	25	283	1 tsp	
284	25	32	1 tsp	
285	25	285	½ tsp	
286	25	286	1 tsp	
287	25	4	3	
288	25	139	To taste	
289	25	25	4 cloves	
290	25	2	As needed	
291	25	51	As needed	Mushroom soaking liquid or boiling water
292	26	292	2 cups	Preferably day-old
293	26	72	2	Yolks and whites separated
294	26	53	1 bunch	Chopped
295	26	295	2	Diced
296	26	42	½	Diced
297	26	297	½	Diced
298	26	298	1 link	Diced
299	26	5	To taste	
300	26	32	Pinch	
301	26	283	To taste	
302	26	2	As needed	
303	27	272	3	Boneless, diced
304	27	139	1 small bowl	Soaked in warm water
305	27	129	1	
306	27	69	5 tbsp	
307	27	53	5	Chopped
308	27	4	1 small piece	Minced
309	27	25	1 bulb	Minced
310	27	12	2 tbsp	
311	27	5	½ tsp	
312	27	285	½ tsp	
313	27	7	1 tbsp	
314	27	29	1 tbsp	
315	27	32	½ tsp	
316	27	100	40–50	
317	27	71	1 tbsp	
318	27	2	As needed	For frying
319	28	319	1	Approx. 700g, cleaned with diagonal cuts
320	28	7	3 tbsp	
321	28	53	40g	Julienned, soaked in ice water
322	28	4	40g	Julienned
323	28	2	2 tbsp	For drizzling, heated until smoking
324	28	324	1	Julienned (optional)
325	28	5	1 tsp	For cleaning fish
326	29	78	500g	Boiled and thinly sliced
327	29	43	1	Sliced
328	29	62	½	Sliced
329	29	98	1 tbsp	
330	29	7	1 tbsp	
331	29	5	½ tsp	
332	29	281	1 tsp	
333	29	32	½ tsp	
334	29	4	1 tbsp	Minced
335	29	25	1 tbsp	Minced
336	29	2	1 tsp	
337	30	264	350g	Thinly sliced against the grain
338	30	338	1.5g	
339	30	8	1 tbsp	
340	30	7	2 tbsp	
341	30	29	1 tbsp	
342	30	342	1 tbsp	
343	30	343	1.5 tbsp	
344	30	344	½ tbsp	
345	30	71	2 tbsp	
346	30	25	1 tbsp	Minced
347	30	53	1 tbsp	Chopped
348	30	2	3 tbsp	
349	31	118	150g	Julienned
350	31	43	3	Julienned
351	31	25	3 cloves	Minced
352	31	7	2 tbsp	Divided for marinade and sauce
353	31	12	1 tbsp	
354	31	69	2 tbsp	Divided for marinade and sauce
355	31	29	1 tbsp	
356	31	5	½ tsp	
357	31	32	1 tsp	
358	31	51	3 tbsp	
359	31	2	2 tbsp	Divided for cooking
360	32	272	2	Boneless
361	32	61	¼ cup	Blanched
362	32	42	¼ cup	Blanched
363	32	12	1 tbsp	
364	32	364	1 tsp	
365	32	5	½ tsp	
366	32	4	3 slices	
367	32	367	2 tbsp	
368	32	368	1 tbsp	
369	32	8	½ tbsp	
370	32	51	2 tbsp	
371	32	25	2 cloves	Sliced
372	32	2	1 tbsp	
373	33	264	150g	Sliced
374	33	62	1	Thinly sliced
375	33	7	1 tbsp	
376	33	8	1 tbsp	
377	33	29	1 tbsp	
378	33	12	1 tbsp	
379	33	368	½ tbsp	
380	33	364	¼ tsp	
381	33	69	½ tbsp	
382	33	51	2 tbsp	
383	33	383	1 tsp	
385	33	72	1	Soft-boiled
386	33	2	1 tbsp	For sautéing (if not using butter)
388	34	388	1	Cut into large chunks
390	34	12	2 tbsp	
391	34	7	2 tbsp	
389	34	364	100g	
392	34	8	½ tbsp	
393	34	29	½ tbsp	
394	34	283	¼ tsp	
395	34	281	¼ tsp	
396	34	98	1 tsp	Sautéed in oil
397	34	25	2 cloves	Minced
398	34	2	1 tbsp	For sautéing bean paste and garlic
399	34	53	To garnish	Chopped
400	35	1	6	Split at joints
401	35	25	1 tbsp	Minced
402	35	7	1 tbsp	
403	35	29	1 tbsp	
404	35	364	1 tsp	
405	35	5	To taste	
406	35	32	½ tsp	
407	35	212	¼	Diced
408	35	43	¼	Diced
409	35	2	2 tbsp	For frying
410	36	56	1	Cut into chunks (~3 lbs)
411	36	59	3	Roll-cut into wedges
412	36	212	1	Roll-cut
413	36	43	1	Roll-cut
414	36	62	1	Cut into large chunks
415	36	25	6 cloves	Lightly smashed
416	36	4	5 slices	
417	36	139	10-15	
418	36	81	50g	
419	36	17	2	
420	36	89	1	
421	36	100	1 tsp	
422	36	422	1	
423	36	7	2 tbsp	
424	36	8	1 tbsp	
425	36	98	1 tbsp	
426	36	6	½ can	
427	36	281	2 cups	
428	36	38	1 tsp	
429	36	69	As needed	Mix with water
430	36	2	As needed	
23	3	53	appropriate amount	Chop finely
14	2	81	3 tablespoons (about 45g)	
11	2	81	15-20g	
34	4	72	3	Crack and beat the eggs
384	33	71	To taste	
18	2	88	2 small pieces	
44	5	98	20g	
33	3	51	4-5 tablespoons	
35	4	51	1.5 times the egg mixture	Measure based on egg mixture volume (e.g., 120g egg + 180g water)
110	10	283	a small amount	
387	34	188	600g	Cut into 3-inch pieces
\.


--
-- Name: fridge_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fridge_ingredient_id_seq', 4, true);


--
-- Name: ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingredient_id_seq', 439, true);


--
-- Name: recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipe_id_seq', 36, true);


--
-- Name: recipe_ingredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recipe_ingredient_id_seq', 430, true);


--
-- Name: fridge_ingredient fridge_ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fridge_ingredient
    ADD CONSTRAINT fridge_ingredient_pkey PRIMARY KEY (id);


--
-- Name: ingredient ingredient_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_name_key UNIQUE (name);


--
-- Name: ingredient ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredient
    ADD CONSTRAINT ingredient_pkey PRIMARY KEY (id);


--
-- Name: recipe_ingredient recipe_ingredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredient
    ADD CONSTRAINT recipe_ingredient_pkey PRIMARY KEY (id);


--
-- Name: recipe recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe
    ADD CONSTRAINT recipe_pkey PRIMARY KEY (id);


--
-- Name: fridge_ingredient fridge_ingredient_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fridge_ingredient
    ADD CONSTRAINT fridge_ingredient_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(id);


--
-- Name: recipe_ingredient recipe_ingredient_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredient
    ADD CONSTRAINT recipe_ingredient_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredient(id) ON DELETE CASCADE;


--
-- Name: recipe_ingredient recipe_ingredient_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredient
    ADD CONSTRAINT recipe_ingredient_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipe(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

