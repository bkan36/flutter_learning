/*
 * Copyright (c) 2019 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:magiccart/models/Item.dart';
import 'package:magiccart/models/Store.dart';

class Demo {
  static Store store = Store([
    Item(
        0,
        'Aqua vitae',
        'https://live.staticflickr.com/8184/8134315748_1c1e3e5061_q.jpg',
        '''Aqua vitae /ˌækwə ˈvaɪtiː/ (Latin for "water of life") or aqua vita is an archaic name for a concentrated aqueous solution of ethanol. The term was in wide use during the Middle Ages and the Renaissance, although its origin is likely much earlier. This Latin term appears in a wide array of dialectical forms throughout all lands and people conquered by ancient Rome. Generally, the term is a generic name for all types of distillates, and eventually came to refer specifically to distillates of alcoholic beverages (liquors).''',
        0.56),
    Item(
        1,
        'Aqua fortis',
        'https://upload.wikimedia.org/wikipedia/commons/5/53/Fuming_nitric_acid_40ml.jpg',
        'The pure compound is colorless, but older samples tend to acquire a yellow cast due to decomposition into oxides of nitrogen and water. Most commercially available nitric acid has a concentration of 68% in water. When the solution contains more than 86% HNO3, it is referred to as fuming nitric acid. Depending on the amount of nitrogen dioxide present, fuming nitric acid is further characterized as white fuming nitric acid at concentrations above 95%, or red fuming nitric acid at concentrations above 86%.',
        0.56),
    Item(
        2,
        'Cinnabar',
        'https://upload.wikimedia.org/wikipedia/commons/9/9e/Cinnabar_on_Dolomite.jpg',
        'Cinnabar (/ˈsɪnəbɑːr/) or cinnabarite (/sɪnəˈbɑːraɪt/), likely deriving from the Ancient Greek: κιννάβαρι (kinnabari), refer to the common bright scarlet to brick-red form of mercury(II) sulfide (HgS) that is the most common source ore for refining elemental mercury, and is the historic source for the brilliant red or scarlet pigment termed vermilion and associated red mercury pigments.',
        2.56),
    Item(
        3,
        'Cuprite',
        'https://upload.wikimedia.org/wikipedia/commons/6/6a/Cuprite-66649.jpg',
        '''Its dark crystals with red internal reflections are in the isometric system hexoctahedral class, appearing as cubic, octahedral, or dodecahedral forms, or in combinations. Penetration twins frequently occur. In spite of its nice color it is rarely used for jewelry because of its low Mohs hardness of 3.5 to 4. It has a relatively high specific gravity of 6.1, imperfect cleavage and is brittle to conchoidal fracture. The luster is sub-metallic to brilliant adamantine. The "chalcotrichite" (from Ancient Greek: χαλκός θρίξ τριχός, "plush copper ore") variety typically shows greatly elongated capillary or needle like crystals forms.''',
        2.42),
    Item(
        4,
        'Pyrite',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/2780M-pyrite1.jpg/520px-2780M-pyrite1.jpg',
        '''The mineral pyrite (/ˈpaɪraɪt/), or iron pyrite, also known as fool's gold, is an iron sulfide with the chemical formula FeS2 (iron(II) disulfide). Pyrite is considered the most common of the sulfide minerals.

Pyrite's metallic luster and pale brass-yellow hue give it a superficial resemblance to gold, hence the well-known nickname of fool's gold. The color has also led to the nicknames brass, brazzle, and Brazil, primarily used to refer to pyrite found in coal.''',
        0.42),
    Item(
        5,
        'Galena',
        'https://upload.wikimedia.org/wikipedia/commons/9/92/Calcite-Galena-elm56c.jpg',
        '''Galena, also called lead glance, is the natural mineral form of lead(II) sulfide (PbS). It is the most important ore of lead and an important source of silver.

Galena is one of the most abundant and widely distributed sulfide minerals. It crystallizes in the cubic crystal system often showing octahedral forms. It is often associated with the minerals sphalerite, calcite and fluorite.''',
        1.40),
    Item(
        6,
        'Glauber\'s Salt',
        'https://upload.wikimedia.org/wikipedia/commons/8/86/Sodium_sulfate.jpg',
        '''Sodium sulfate (also known as sodium sulphate or sulfate of soda) is the inorganic compound with formula Na2SO4 as well as several related hydrates. All forms are white solids that are highly soluble in water. With an annual production of 6 million tonnes, the decahydrate is a major commodity chemical product. It is mainly used for the manufacture of detergents and in the kraft process of paper pulping.''',
        0.01),
    Item(
        7,
        'Gum Arabic',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Gummi_arabicum_pieces_and_powder.jpg/2880px-Gummi_arabicum_pieces_and_powder.jpg',
        '''Gum arabic, also known as gum sudani, acacia gum, arabic gum, gum acacia, acacia, Senegal gum and Indian gum, and by other names, is a natural gum consisting of the hardened sap of various species of the acacia tree. Gum arabic is collected from acacia species, predominantly Acacia senegal and Vachellia (Acacia) seyal. The term "gum arabic" does not indicate a particular botanical source. In a few cases so‐called "gum arabic" may not even have been collected from Acacia species, but may originate from Combretum, Albizia or some other genus. The gum is harvested commercially from wild trees, mostly in Sudan (80%) and throughout the Sahel, from Senegal to Somalia—though it is historically cultivated in Arabia and West Asia.''',
        0.10),
    Item(
        8,
        'Oil of Virtiol',
        'https://upload.wikimedia.org/wikipedia/commons/b/b6/Sulphuric_acid_96_percent_extra_pure.jpg',
        '''Sulfuric acid (alternative spelling sulphuric acid), also known as vitriol, is a mineral acid composed of the elements sulfur, oxygen and hydrogen, with molecular formula H2SO4. It is a colorless, odorless, and syrupy liquid that is soluble in water and is synthesized in reactions that are highly exothermic''',
        1.00),
    Item(
        9,
        'Alembic',
        'https://upload.wikimedia.org/wikipedia/commons/c/ca/Alambik1.jpg',
        '''An alembic (‏الإنبيق‎, al-inbīq); Ancient Greek: ἄμβιξ (ambix, 'cup, beaker') is an alchemical still consisting of two vessels connected by a tube, used for distilling.''',
        10.42),
    Item(
        10,
        'Retort',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Alambique_056.jpg/440px-Alambique_056.jpg',
        '''In a chemistry laboratory, a retort is a device used for distillation or dry distillation of substances. It consists of a spherical vessel with a long downward-pointing neck. The liquid to be distilled is placed in the vessel and heated. The neck acts as a condenser, allowing the vapors to condense and flow along the neck to a collection vessel placed underneath.''',
        4.42),
    Item(
        11,
        'Athanor',
        'https://upload.wikimedia.org/wikipedia/commons/1/10/Athanor.jpg',
        '''In alchemy, an athanor is a furnace used to provide a uniform and constant heat for alchemical digestion. Etymologically, it descends from a number of Arabic texts of the period of the Califate which use the term "al-tannoor" in talismanic alchemy, meaning a bread-oven, from which the design portrayed evidently descends.''',
        14.42),
    Item(
        12,
        'Mortar and Pestle',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Molcajete_y_tejolote.jpg/300px-Molcajete_y_tejolote.jpg',
        '''Mortar and pestle are implements used since ancient times to prepare ingredients or substances by crushing and grinding them into a fine paste or powder in the kitchen, laboratory, and pharmacy. The mortar (/ˈmɔːrtər/) is a bowl, typically made of hard wood, metal, ceramic, or hard stone, such as granite. The pestle (/ˈpɛsəl/, also US: /ˈpɛstəl/) is a heavy and blunt club-shaped object. The substance to be ground, which may be wet or dry, is placed in the mortar, where the pestle is pressed and rotated onto it until the desired texture is achieved.''',
        14.42),
    Item(
        13,
        'Verdigris',
        'https://upload.wikimedia.org/wikipedia/commons/a/a3/Verdigris.JPG',
        '''Verdigris is the common name for a green pigment obtained through the application of acetic acid to copper plates or the natural patina formed when copper, brass or bronze is weathered and exposed to air or seawater over time. It is usually a basic copper carbonate (Cu
2CO
3(OH)2), but near the sea will be a basic copper chloride (Cu2(OH)3Cl). If acetic acid is present at the time of weathering, it may consist of copper(II) acetate.''',
        0.52),
    Item(
        14,
        'Plumbago',
        'https://upload.wikimedia.org/wikipedia/commons/3/3d/Graphite-233436.jpg',
        '''Graphite (/ˈɡræfaɪt/), archaically referred to as plumbago, is a crystalline form of the element carbon with its atoms arranged in a hexagonal structure. It occurs naturally in this form and is the most stable form of carbon under standard conditions. Under high pressures and temperatures it converts to diamond. Graphite is used in pencils and lubricants. Its high conductivity makes it useful in electronic products such as electrodes, batteries, and solar panels.''',
        3.52),
    Item(
        15,
        'Spirit of Hartshorn',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/First_aid_ammonia_inhalant_capsules.jpg/440px-First_aid_ammonia_inhalant_capsules.jpg',
        '''Smelling salts, also known as ammonia inhalants, spirit of hartshorn or sal volatile, are chemical compounds often used to arouse consciousness.''',
        0.12),
  ]);
}
