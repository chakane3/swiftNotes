# Parsing Local JSON, search bar, segues

## The UI
<img src="/Pursuit-UIKit/Unit2/stories/Assets/topStoriesUI.png"></img>

## Local JSON Data
Here we will have a json file that we will use to display our data.
The structure of this file, and the values were looking for are:
```c++
 {
    dict
    dict
    dict: [
      section: String
      title: String
      abstract: String
      byline: String
      multimedia: [
        url: String
        format: String
      ]
    ]
 }
```
 
<details>
  <summary>json file</summary>
  
  ```c++
  
{
    "status": "OK",
    "copyright": "Copyright (c) 2019 The New York Times Company. All Rights Reserved.",
    "section": "technology",
    "last_updated": "2019-11-24T15:17:05-05:00",
    "num_results": 39,
    "results": [
        {
            "section": "Technology",
            "subsection": "",
            "title": "Internet Companies Prepare to Fight the ‘Deepfake’ Future",
            "abstract": "Researchers are creating tools to find A.I.-generated fake videos before they become impossible to detect. Some experts fear it is a losing battle.",
            "url": "https://www.nytimes.com/2019/11/24/technology/tech-companies-deepfakes.html",
            "byline": "By CADE METZ",
            "item_type": "Article",
            "updated_date": "2019-11-24T05:00:12-05:00",
            "created_date": "2019-11-24T05:00:12-05:00",
            "published_date": "2019-11-24T05:00:12-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Artificial Intelligence",
                "Rumors and Misinformation",
                "Video Recordings, Downloads and Streaming",
                "Computers and the Internet",
                "Social Media",
                "Presidential Election of 2020",
                "Research",
                "Deepfakes"
            ],
            "org_facet": [
                "Facebook Inc",
                "Google Inc",
                "YouTube.com"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/24DEEPFAKES-01/24DEEPFAKES-01-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Actors were filmed in a variety of scenes. The top picture is their actual image, with a deepfake altered image below it. ",
                    "copyright": "Google"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/24DEEPFAKES-01/24DEEPFAKES-01-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Actors were filmed in a variety of scenes. The top picture is their actual image, with a deepfake altered image below it. ",
                    "copyright": "Google"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/24DEEPFAKES-01/24DEEPFAKES-01-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Actors were filmed in a variety of scenes. The top picture is their actual image, with a deepfake altered image below it. ",
                    "copyright": "Google"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/24DEEPFAKES-01/24DEEPFAKES-01-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Actors were filmed in a variety of scenes. The top picture is their actual image, with a deepfake altered image below it. ",
                    "copyright": "Google"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/24DEEPFAKES-01/24DEEPFAKES-01-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Actors were filmed in a variety of scenes. The top picture is their actual image, with a deepfake altered image below it. ",
                    "copyright": "Google"
                }
            ],
            "short_url": "https://nyti.ms/2OeECau"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Why Everyone Is Angry at Facebook Over Its Political Ads Policy",
            "abstract": "The social network is said to be discussing changes that include restricting how precisely campaigns can reach specific groups.",
            "url": "https://www.nytimes.com/2019/11/22/technology/campaigns-pressure-facebook-political-ads.html",
            "byline": "By MIKE ISAAC",
            "item_type": "Article",
            "updated_date": "2019-11-22T10:17:49-05:00",
            "created_date": "2019-11-22T05:00:18-05:00",
            "published_date": "2019-11-22T05:00:18-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Political Advertising",
                "Online Advertising",
                "Rumors and Misinformation",
                "Corporate Social Responsibility",
                "Social Media",
                "Presidential Election of 2020",
                "United States Politics and Government"
            ],
            "org_facet": [
                "Facebook Inc"
            ],
            "per_facet": [
                "Zuckerberg, Mark E"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/business/22jpfacebook-print/22facebook-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Zuckerberg, Facebook&rsquo;s chief executive, has said he will run political ads in the interest of free speech. Although the company has reached no decisions, it is weighing some changes.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/business/22jpfacebook-print/22facebook-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Zuckerberg, Facebook&rsquo;s chief executive, has said he will run political ads in the interest of free speech. Although the company has reached no decisions, it is weighing some changes.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/business/22jpfacebook-print/22facebook-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Zuckerberg, Facebook&rsquo;s chief executive, has said he will run political ads in the interest of free speech. Although the company has reached no decisions, it is weighing some changes.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/business/22jpfacebook-print/22facebook-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Zuckerberg, Facebook&rsquo;s chief executive, has said he will run political ads in the interest of free speech. Although the company has reached no decisions, it is weighing some changes.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/business/22jpfacebook-print/22facebook-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1366,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Zuckerberg, Facebook&rsquo;s chief executive, has said he will run political ads in the interest of free speech. Although the company has reached no decisions, it is weighing some changes.",
                    "copyright": "Pete Marovich for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/34hrs2o"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "A Former Fox News Executive Divides Americans Using Russian Tactics",
            "abstract": "An investigation found that several sites owned by Ken LaCorte push inflammatory items — stories, petitions and the occasional conspiracy theory — to the public.",
            "url": "https://www.nytimes.com/2019/11/21/technology/LaCorte-edition-news.html",
            "byline": "By NICOLE PERLROTH",
            "item_type": "Article",
            "updated_date": "2019-11-22T01:19:16-05:00",
            "created_date": "2019-11-21T11:34:33-05:00",
            "published_date": "2019-11-21T11:34:33-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Rumors and Misinformation",
                "News and News Media",
                "Russian Interference in 2016 US Elections and Ties to Trump Associates",
                "Presidential Election of 2016",
                "Social Media",
                "Politics and Government",
                "Presidential Election of 2020"
            ],
            "org_facet": [
                "LaCorte News"
            ],
            "per_facet": [
                "LaCorte, Ken"
            ],
            "geo_facet": [
                "Macedonia"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21flamebait1-print/21flamebait1-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Ken LaCorte, a former Fox News executive who operates a number of socially and politically divisive websites.",
                    "copyright": "Celeste Sloman for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21flamebait1-print/21flamebait1-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Ken LaCorte, a former Fox News executive who operates a number of socially and politically divisive websites.",
                    "copyright": "Celeste Sloman for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21flamebait1-print/merlin_164764482_1bb37df6-5f2c-4c70-8772-2eb0409b52f6-articleInline.jpg",
                    "format": "Normal",
                    "height": 276,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Ken LaCorte, a former Fox News executive who operates a number of socially and politically divisive websites.",
                    "copyright": "Celeste Sloman for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21flamebait1-print/21flamebait1-mediumThreeByTwo210-v2.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Ken LaCorte, a former Fox News executive who operates a number of socially and politically divisive websites.",
                    "copyright": "Celeste Sloman for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21flamebait1-print/merlin_164764482_1bb37df6-5f2c-4c70-8772-2eb0409b52f6-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 2048,
                    "width": 1408,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Ken LaCorte, a former Fox News executive who operates a number of socially and politically divisive websites.",
                    "copyright": "Celeste Sloman for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2Ow1O37"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "The Week in Tech: A.I.’s Threat to White-Collar Jobs",
            "abstract": "Some workers may be more exposed to artificial intelligence than previously thought. But worry more about automation’s threat to less skilled employees.",
            "url": "https://www.nytimes.com/2019/11/22/technology/the-week-in-tech-ai-jobs.html",
            "byline": "By JAMIE CONDLIFFE",
            "item_type": "Article",
            "updated_date": "2019-11-22T09:00:06-05:00",
            "created_date": "2019-11-22T09:00:05-05:00",
            "published_date": "2019-11-22T09:00:05-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computers and the Internet",
                "Social Media",
                "Factories and Manufacturing"
            ],
            "org_facet": [
                "Apple Inc",
                "Facebook Inc",
                "Google Inc",
                "TikTok (ByteDance)"
            ],
            "per_facet": [
                "Legere, John J",
                "Cook, Timothy D",
                "Vestager, Margrethe",
                "Trump, Donald J"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22technewsletter/22technewsletter-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A robotic scanner at a Walmart Supercenter. A new Brookings Institution report looks at artificial intelligence’s future impact on “relatively well-paid managers, supervisors and analysts.”  ",
                    "copyright": "David J. Phillip/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22technewsletter/22technewsletter-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A robotic scanner at a Walmart Supercenter. A new Brookings Institution report looks at artificial intelligence’s future impact on “relatively well-paid managers, supervisors and analysts.”  ",
                    "copyright": "David J. Phillip/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22technewsletter/merlin_149671188_a6e69acb-9e54-4a88-b501-a7dbb0532704-articleInline.jpg",
                    "format": "Normal",
                    "height": 117,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A robotic scanner at a Walmart Supercenter. A new Brookings Institution report looks at artificial intelligence’s future impact on “relatively well-paid managers, supervisors and analysts.”  ",
                    "copyright": "David J. Phillip/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22technewsletter/22technewsletter-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A robotic scanner at a Walmart Supercenter. A new Brookings Institution report looks at artificial intelligence’s future impact on “relatively well-paid managers, supervisors and analysts.”  ",
                    "copyright": "David J. Phillip/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22technewsletter/merlin_149671188_a6e69acb-9e54-4a88-b501-a7dbb0532704-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1257,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A robotic scanner at a Walmart Supercenter. A new Brookings Institution report looks at artificial intelligence’s future impact on “relatively well-paid managers, supervisors and analysts.”  ",
                    "copyright": "David J. Phillip/Associated Press"
                }
            ],
            "short_url": "https://nyti.ms/347S7ym"
        },
        {
            "section": "U.S.",
            "subsection": "",
            "title": "Newscaster’s Errant Email Calling in Sick Gets National Attention",
            "abstract": "Colleagues at many of Nexstar Media Group’s nearly 200 television stations jokingly offered prayers and created a shrine for Nick Vasos, who started trending on Twitter.",
            "url": "https://www.nytimes.com/2019/11/24/us/nick-vasos-sick-email.html",
            "byline": "By NEIL VIGDOR",
            "item_type": "Article",
            "updated_date": "2019-11-24T14:07:18-05:00",
            "created_date": "2019-11-24T14:07:18-05:00",
            "published_date": "2019-11-24T14:07:18-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Social Media",
                "Computers and the Internet",
                "E-Mail",
                "Television",
                "Paid Time Off"
            ],
            "org_facet": [
                "Nexstar Media Group"
            ],
            "per_facet": [
                "Nick Vasos"
            ],
            "geo_facet": [
                "Kansas City (Mo)"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/multimedia/24xp-replyall/24xp-replyall-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Fox 4 anchor Jonathan McCall with a parody shrine to his colleague Nick Vasos, who accidentally emailed every employee at his company’s nearly 200 stations to take a sick day.",
                    "copyright": "Jonathan McCall"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/multimedia/24xp-replyall/24xp-replyall-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Fox 4 anchor Jonathan McCall with a parody shrine to his colleague Nick Vasos, who accidentally emailed every employee at his company’s nearly 200 stations to take a sick day.",
                    "copyright": "Jonathan McCall"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/multimedia/24xp-replyall/24xp-replyall-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Fox 4 anchor Jonathan McCall with a parody shrine to his colleague Nick Vasos, who accidentally emailed every employee at his company’s nearly 200 stations to take a sick day.",
                    "copyright": "Jonathan McCall"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/multimedia/24xp-replyall/24xp-replyall-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Fox 4 anchor Jonathan McCall with a parody shrine to his colleague Nick Vasos, who accidentally emailed every employee at his company’s nearly 200 stations to take a sick day.",
                    "copyright": "Jonathan McCall"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/multimedia/24xp-replyall/24xp-replyall-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 800,
                    "width": 1200,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Fox 4 anchor Jonathan McCall with a parody shrine to his colleague Nick Vasos, who accidentally emailed every employee at his company’s nearly 200 stations to take a sick day.",
                    "copyright": "Jonathan McCall"
                }
            ],
            "short_url": "https://nyti.ms/2QMZ5ox"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Democracy.com Has a New Owner. It’s Mark Cuban.",
            "abstract": "The billionaire said he bought the symbolic domain name this month “to make sure someone didn’t do something crazy with it.”",
            "url": "https://www.nytimes.com/2019/11/22/technology/mark-cuban-democracy.html",
            "byline": "By NIRAJ CHOKSHI",
            "item_type": "Article",
            "updated_date": "2019-11-22T15:52:52-05:00",
            "created_date": "2019-11-22T15:52:52-05:00",
            "published_date": "2019-11-22T15:52:52-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Domain Names (Internet)",
                "Democracy (Theory and Philosophy)",
                "Auctions",
                "Entrepreneurship"
            ],
            "org_facet": [
                "Heritage Auctions"
            ],
            "per_facet": [
                "Cuban, Mark",
                "Cooley, Talmage"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/us/politics/22xp-democracy/22xp-democracy-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Cuban bought Democracy.com, which, despite its resonant and memorable name, has had a relatively unremarkable history.",
                    "copyright": "Rich Fury/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/us/politics/22xp-democracy/22xp-democracy-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Cuban bought Democracy.com, which, despite its resonant and memorable name, has had a relatively unremarkable history.",
                    "copyright": "Rich Fury/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/us/politics/22xp-democracy/22xp-democracy-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Cuban bought Democracy.com, which, despite its resonant and memorable name, has had a relatively unremarkable history.",
                    "copyright": "Rich Fury/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/us/politics/22xp-democracy/22xp-democracy-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Cuban bought Democracy.com, which, despite its resonant and memorable name, has had a relatively unremarkable history.",
                    "copyright": "Rich Fury/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/us/politics/22xp-democracy/22xp-democracy-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mark Cuban bought Democracy.com, which, despite its resonant and memorable name, has had a relatively unremarkable history.",
                    "copyright": "Rich Fury/Getty Images"
                }
            ],
            "short_url": "https://nyti.ms/34h2O1G"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Huawei Funds Are Cut Off by F.C.C. Over Security Threats",
            "abstract": "The commission put new restrictions on money aimed at helping wireless carriers provide broadband to rural areas.",
            "url": "https://www.nytimes.com/2019/11/22/technology/huawei-funds-cut-fcc.html",
            "byline": "By DAVID McCABE",
            "item_type": "Article",
            "updated_date": "2019-11-22T14:52:39-05:00",
            "created_date": "2019-11-22T13:58:24-05:00",
            "published_date": "2019-11-22T13:58:24-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "5G (Wireless Communications)",
                "Politics and Government",
                "Blacklisting",
                "Espionage and Intelligence Services"
            ],
            "org_facet": [
                "Huawei Technologies Co Ltd",
                "Federal Communications Commission",
                "ZTE Corp"
            ],
            "per_facet": [
                "Pai, Ajit"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22huawei/22huawei-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“In taking these steps, we demonstrate the F.C.C.’s commitment to doing everything we can to address national security threats to our communications networks,” said Ajit Pai, the agency chairman.",
                    "copyright": "Lam Yik Fei for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22huawei/22huawei-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“In taking these steps, we demonstrate the F.C.C.’s commitment to doing everything we can to address national security threats to our communications networks,” said Ajit Pai, the agency chairman.",
                    "copyright": "Lam Yik Fei for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22huawei/merlin_155141463_e6cbf199-c939-4cd2-8ed0-f28ecf420b30-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“In taking these steps, we demonstrate the F.C.C.’s commitment to doing everything we can to address national security threats to our communications networks,” said Ajit Pai, the agency chairman.",
                    "copyright": "Lam Yik Fei for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22huawei/22huawei-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“In taking these steps, we demonstrate the F.C.C.’s commitment to doing everything we can to address national security threats to our communications networks,” said Ajit Pai, the agency chairman.",
                    "copyright": "Lam Yik Fei for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/22huawei/merlin_155141463_e6cbf199-c939-4cd2-8ed0-f28ecf420b30-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“In taking these steps, we demonstrate the F.C.C.’s commitment to doing everything we can to address national security threats to our communications networks,” said Ajit Pai, the agency chairman.",
                    "copyright": "Lam Yik Fei for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2XBoP91"
        },
        {
            "section": "Arts",
            "subsection": "Art & Design",
            "title": "Will Instagram Ever ‘Free the Nipple’?",
            "abstract": "For years, artists have put pressure on Facebook and Instagram to treat female and male nipples equally, but such a change may be too radical for Silicon Valley.",
            "url": "https://www.nytimes.com/2019/11/22/arts/design/instagram-free-the-nipple.html",
            "byline": "",
            "item_type": "Article",
            "updated_date": "2019-11-22T10:00:06-05:00",
            "created_date": "2019-11-22T10:00:07-05:00",
            "published_date": "2019-11-22T10:00:07-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Art",
                "Social Media",
                "Censorship",
                "Photography"
            ],
            "org_facet": [
                "Instagram Inc",
                "Facebook Inc"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/arts/instagram-nipple/instagram-nipple-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Shawna X"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/arts/instagram-nipple/instagram-nipple-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Shawna X"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/arts/instagram-nipple/instagram-nipple-articleInline.jpg",
                    "format": "Normal",
                    "height": 190,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Shawna X"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/arts/instagram-nipple/instagram-nipple-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Shawna X"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/23/arts/instagram-nipple/instagram-nipple-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 2000,
                    "width": 2000,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Shawna X"
                }
            ],
            "short_url": "https://nyti.ms/2D96XJ2"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "Imagine Being on Trial. With Exonerating Evidence Trapped on Your Phone.",
            "abstract": "Public defenders lack access to gadgets and software that could keep their clients out of jail.",
            "url": "https://www.nytimes.com/2019/11/22/business/law-enforcement-public-defender-technology-gap.html",
            "byline": "By KASHMIR HILL",
            "item_type": "Article",
            "updated_date": "2019-11-22T18:19:13-05:00",
            "created_date": "2019-11-22T05:00:27-05:00",
            "published_date": "2019-11-22T05:00:27-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Public Defenders and Court-Appointed Lawyers (Criminal)",
                "Forensic Science",
                "Legal Aid for the Poor (Civil)",
                "Computers and the Internet",
                "Social Media",
                "Electronic Communications Privacy Act",
                "Privacy",
                "Smartphones"
            ],
            "org_facet": [
                "Legal Aid Society",
                "Facebook Inc",
                "Google Inc",
                "Twitter",
                "Guidance Software Inc",
                "Harris Corporation"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/22FORENSICS-07/22FORENSICS-07-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Brandon Reim, a digital forensics analyst with the Legal Aid Society in Manhattan.",
                    "copyright": "Karsten Moran for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/22FORENSICS-07/22FORENSICS-07-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Brandon Reim, a digital forensics analyst with the Legal Aid Society in Manhattan.",
                    "copyright": "Karsten Moran for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/22FORENSICS-07/merlin_163684938_8a26e6ac-504d-4051-9a48-4792595bcab3-articleInline.jpg",
                    "format": "Normal",
                    "height": 285,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Brandon Reim, a digital forensics analyst with the Legal Aid Society in Manhattan.",
                    "copyright": "Karsten Moran for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/22FORENSICS-07/22FORENSICS-07-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Brandon Reim, a digital forensics analyst with the Legal Aid Society in Manhattan.",
                    "copyright": "Karsten Moran for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/24/business/22FORENSICS-07/merlin_163684938_8a26e6ac-504d-4051-9a48-4792595bcab3-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 2048,
                    "width": 1366,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Brandon Reim, a digital forensics analyst with the Legal Aid Society in Manhattan.",
                    "copyright": "Karsten Moran for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/3392wbT"
        },
        {
            "section": "Business",
            "subsection": "International Business",
            "title": "China’s Vaping Boom Alarms the Government",
            "abstract": "For years, Chinese e-cigarette makers had free rein to operate without regard to consumer safety. But new rules are set to change that.",
            "url": "https://www.nytimes.com/2019/11/22/business/international/china-vaping-ban.html",
            "byline": "By SUI-LEE WEE and ELSIE CHEN",
            "item_type": "Article",
            "updated_date": "2019-11-22T13:53:33-05:00",
            "created_date": "2019-11-22T05:00:27-05:00",
            "published_date": "2019-11-22T05:00:27-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "E-Cigarettes",
                "Politics and Government",
                "Regulation and Deregulation of Industry"
            ],
            "org_facet": [
                "Juul Labs Inc"
            ],
            "per_facet": [],
            "geo_facet": [
                "China",
                "Shenzhen (China)"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/00chinavaping-1/00chinavaping-1-thumbStandard-v2.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A production line for RELX e-cigarettes in Shenzhen, China. Exporters once dominated the Chinese industry, but vaping is surging domestically.",
                    "copyright": "Gilles Sabrié for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/00chinavaping-1/00chinavaping-1-thumbLarge-v2.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A production line for RELX e-cigarettes in Shenzhen, China. Exporters once dominated the Chinese industry, but vaping is surging domestically.",
                    "copyright": "Gilles Sabrié for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/00chinavaping-1/00chinavaping-1-articleInline-v2.jpg",
                    "format": "Normal",
                    "height": 131,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A production line for RELX e-cigarettes in Shenzhen, China. Exporters once dominated the Chinese industry, but vaping is surging domestically.",
                    "copyright": "Gilles Sabrié for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/00chinavaping-1/00chinavaping-1-mediumThreeByTwo210-v3.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A production line for RELX e-cigarettes in Shenzhen, China. Exporters once dominated the Chinese industry, but vaping is surging domestically.",
                    "copyright": "Gilles Sabrié for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/00chinavaping-1/00chinavaping-1-superJumbo-v2.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A production line for RELX e-cigarettes in Shenzhen, China. Exporters once dominated the Chinese industry, but vaping is surging domestically.",
                    "copyright": "Gilles Sabrié for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2D5nQ7v"
        },
        {
            "section": "Travel",
            "subsection": "",
            "title": "Five Places to Visit in Washington, D.C. With a Black Digital Storyteller",
            "abstract": "Lanae Spruce made a name for herself as a social media specialist at the Smithsonian’s African American Museum. Here are her top D.C. spots.",
            "url": "https://www.nytimes.com/2019/11/22/travel/five-places-to-visit-in-wash-dc-Lanae-Spruce.html",
            "byline": "By AUDREY E. HOFFER",
            "item_type": "Article",
            "updated_date": "2019-11-22T05:00:23-05:00",
            "created_date": "2019-11-22T05:00:23-05:00",
            "published_date": "2019-11-22T05:00:23-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Travel and Vacations",
                "Restaurants",
                "Social Media"
            ],
            "org_facet": [
                "National Museum of African American History and Culture",
                "Smithsonian Institution"
            ],
            "per_facet": [
                "Spruce, Lanae"
            ],
            "geo_facet": [
                "Washington (DC)"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/travel/22WashDC-FivePlaces03/22WashDC-FivePlaces03-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Lanae Spruce, a social media storyteller, lists the Anacostia Arts Center as one of her favorite spots in Washington. “It’s one of the hidden gems in Anacostia.”",
                    "copyright": "Darren S. Higgins for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/travel/22WashDC-FivePlaces03/22WashDC-FivePlaces03-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Lanae Spruce, a social media storyteller, lists the Anacostia Arts Center as one of her favorite spots in Washington. “It’s one of the hidden gems in Anacostia.”",
                    "copyright": "Darren S. Higgins for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/travel/22WashDC-FivePlaces03/22WashDC-FivePlaces03-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Lanae Spruce, a social media storyteller, lists the Anacostia Arts Center as one of her favorite spots in Washington. “It’s one of the hidden gems in Anacostia.”",
                    "copyright": "Darren S. Higgins for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/travel/22WashDC-FivePlaces03/22WashDC-FivePlaces03-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Lanae Spruce, a social media storyteller, lists the Anacostia Arts Center as one of her favorite spots in Washington. “It’s one of the hidden gems in Anacostia.”",
                    "copyright": "Darren S. Higgins for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/travel/22WashDC-FivePlaces03/22WashDC-FivePlaces03-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1367,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Lanae Spruce, a social media storyteller, lists the Anacostia Arts Center as one of her favorite spots in Washington. “It’s one of the hidden gems in Anacostia.”",
                    "copyright": "Darren S. Higgins for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2XI4xur"
        },
        {
            "section": "The Weekly",
            "subsection": "",
            "title": "Deepfakes — Believe at Your Own Risk",
            "abstract": "Watch — very closely — as these A.I. engineers create ultrarealistic videos that will have you questioning reality.",
            "url": "https://www.nytimes.com/2019/11/22/the-weekly/deepfake-joe-rogan.html",
            "byline": "",
            "item_type": "Article",
            "updated_date": "2019-11-24T14:50:26-05:00",
            "created_date": "2019-11-22T05:00:18-05:00",
            "published_date": "2019-11-22T05:00:18-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Artificial Intelligence",
                "Rumors and Misinformation",
                "Social Media",
                "The Weekly (TV Program)"
            ],
            "org_facet": [
                "FX (TV Network)",
                "Hulu.com"
            ],
            "per_facet": [
                "Rogan, Joe",
                "Pelosi, Nancy"
            ],
            "geo_facet": [],
            "multimedia": [],
            "short_url": "https://nyti.ms/2OCjhqy"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "Tesla’s Electric ‘Cybertruck’ Is Unveiled. It’s Pointy.",
            "abstract": "Elon Musk’s car company presented its long-awaited pickup truck, but it didn’t quite go as planned. (Broken windows were involved.)",
            "url": "https://www.nytimes.com/2019/11/21/business/tesla-cybertruck-pickup-truck.html",
            "byline": "By KAREN ZRAICK, NEAL E. BOUDETTE and DANIEL VICTOR",
            "item_type": "Article",
            "updated_date": "2019-11-22T18:19:59-05:00",
            "created_date": "2019-11-21T16:04:22-05:00",
            "published_date": "2019-11-21T16:04:22-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Sports Utility Vehicles and Light Trucks",
                "Electric and Hybrid Vehicles",
                "Automobiles",
                "cybertruck"
            ],
            "org_facet": [
                "Tesla Motors Inc"
            ],
            "per_facet": [
                "Musk, Elon"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/12/21/world/21xp-tesla1/21xp-tesla1-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“When we unveil this thing, there will be some people who are like, ‘Oh, that doesn’t look like a truck; I don’t want to buy it,’” Elon Musk, Tesla’s chief executive, said in an earlier interview.",
                    "copyright": "Ringo H.W. Chiu/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/12/21/world/21xp-tesla1/21xp-tesla1-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“When we unveil this thing, there will be some people who are like, ‘Oh, that doesn’t look like a truck; I don’t want to buy it,’” Elon Musk, Tesla’s chief executive, said in an earlier interview.",
                    "copyright": "Ringo H.W. Chiu/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/12/21/world/21xp-tesla1/merlin_164827188_ea5c30a5-d442-4535-92e3-ff450a139a74-articleInline.jpg",
                    "format": "Normal",
                    "height": 119,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“When we unveil this thing, there will be some people who are like, ‘Oh, that doesn’t look like a truck; I don’t want to buy it,’” Elon Musk, Tesla’s chief executive, said in an earlier interview.",
                    "copyright": "Ringo H.W. Chiu/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/12/21/world/21xp-tesla1/21xp-tesla1-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“When we unveil this thing, there will be some people who are like, ‘Oh, that doesn’t look like a truck; I don’t want to buy it,’” Elon Musk, Tesla’s chief executive, said in an earlier interview.",
                    "copyright": "Ringo H.W. Chiu/Associated Press"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/12/21/world/21xp-tesla1/merlin_164827188_ea5c30a5-d442-4535-92e3-ff450a139a74-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1279,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“When we unveil this thing, there will be some people who are like, ‘Oh, that doesn’t look like a truck; I don’t want to buy it,’” Elon Musk, Tesla’s chief executive, said in an earlier interview.",
                    "copyright": "Ringo H.W. Chiu/Associated Press"
                }
            ],
            "short_url": "https://nyti.ms/33b6GQg"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "WeWork Will Lay Off 2,400 Workers",
            "abstract": "The troubled office space company is slashing its total work force as it sells businesses and outsources some jobs.",
            "url": "https://www.nytimes.com/2019/11/21/business/wework-layoffs.html",
            "byline": "By PETER EAVIS",
            "item_type": "Article",
            "updated_date": "2019-11-21T15:50:55-05:00",
            "created_date": "2019-11-21T11:21:21-05:00",
            "published_date": "2019-11-21T11:21:21-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Co-Working",
                "Layoffs and Job Reductions"
            ],
            "org_facet": [
                "WeWork Companies Inc"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21wework-print/21wework3-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "WeWork&rsquo;s office in Manhattan on Thursday. The office space company said it was laying off 2,400 workers.",
                    "copyright": "Jeenah Moon for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21wework-print/21wework3-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "WeWork&rsquo;s office in Manhattan on Thursday. The office space company said it was laying off 2,400 workers.",
                    "copyright": "Jeenah Moon for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21wework-print/merlin_164800140_7b7a4bb5-1531-4a23-b675-c03eb7c539e6-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "WeWork&rsquo;s office in Manhattan on Thursday. The office space company said it was laying off 2,400 workers.",
                    "copyright": "Jeenah Moon for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21wework-print/merlin_164800140_7b7a4bb5-1531-4a23-b675-c03eb7c539e6-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "WeWork&rsquo;s office in Manhattan on Thursday. The office space company said it was laying off 2,400 workers.",
                    "copyright": "Jeenah Moon for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/21wework-print/merlin_164800140_7b7a4bb5-1531-4a23-b675-c03eb7c539e6-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "WeWork&rsquo;s office in Manhattan on Thursday. The office space company said it was laying off 2,400 workers.",
                    "copyright": "Jeenah Moon for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2XHtZ3m"
        },
        {
            "section": "New York",
            "subsection": "",
            "title": "16-Year-Old Scooter Rider Killed by Tow Truck in New Jersey",
            "abstract": "The accident in Elizabeth comes just a few weeks after the city started a shared scooter program.",
            "url": "https://www.nytimes.com/2019/11/21/nyregion/nj-scooter-death.html",
            "byline": "By PATRICK McGEEHAN",
            "item_type": "Article",
            "updated_date": "2019-11-21T17:30:12-05:00",
            "created_date": "2019-11-21T10:04:17-05:00",
            "published_date": "2019-11-21T10:04:17-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Motorcycles, Motor Bikes and Motorscooters",
                "Traffic Accidents and Safety",
                "Deaths (Fatalities)"
            ],
            "org_facet": [
                "LimeBike",
                "Lyft Inc",
                "Uber Technologies Inc"
            ],
            "per_facet": [
                "Bollwage, J Christian"
            ],
            "geo_facet": [
                "Elizabeth (NJ)"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/nyregion/22njscooter2-print/21njscooter02-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Luis Brioso, 17, hugs a friend at the intersection where Gomez died. &ldquo;He was like my big brother,&rdquo; Brioso said, who says he knew him for three years.",
                    "copyright": "Erica Seryhm Lee for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/nyregion/22njscooter2-print/21njscooter02-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Luis Brioso, 17, hugs a friend at the intersection where Gomez died. &ldquo;He was like my big brother,&rdquo; Brioso said, who says he knew him for three years.",
                    "copyright": "Erica Seryhm Lee for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/nyregion/22njscooter2-print/merlin_164808375_8a587776-b614-448c-a7f7-a0dbd281ac21-articleInline.jpg",
                    "format": "Normal",
                    "height": 126,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Luis Brioso, 17, hugs a friend at the intersection where Gomez died. &ldquo;He was like my big brother,&rdquo; Brioso said, who says he knew him for three years.",
                    "copyright": "Erica Seryhm Lee for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/nyregion/22njscooter2-print/21njscooter02-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Luis Brioso, 17, hugs a friend at the intersection where Gomez died. &ldquo;He was like my big brother,&rdquo; Brioso said, who says he knew him for three years.",
                    "copyright": "Erica Seryhm Lee for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/nyregion/22njscooter2-print/merlin_164808375_8a587776-b614-448c-a7f7-a0dbd281ac21-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1360,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Luis Brioso, 17, hugs a friend at the intersection where Gomez died. &ldquo;He was like my big brother,&rdquo; Brioso said, who says he knew him for three years.",
                    "copyright": "Erica Seryhm Lee for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2D2XF14"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "Free Internet Is Proposed in Britain. Is It Even Possible?",
            "abstract": "A Labour Party plan to provide government-sponsored broadband service has raised questions about how it would work, and who would pay for it.",
            "url": "https://www.nytimes.com/2019/11/21/business/free-internet-britain.html",
            "byline": "By ADAM SATARIANO",
            "item_type": "Article",
            "updated_date": "2019-11-21T02:16:12-05:00",
            "created_date": "2019-11-21T00:00:06-05:00",
            "published_date": "2019-11-21T00:00:06-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Politics and Government",
                "Computers and the Internet",
                "Telephones and Telecommunications"
            ],
            "org_facet": [
                "BT Group PLC",
                "Labour Party (Great Britain)"
            ],
            "per_facet": [
                "Corbyn, Jeremy (1949- )"
            ],
            "geo_facet": [
                "Great Britain"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/business/21ukbroadband/21ukbroadband-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Jeremy Corbyn, the leader of the Labour Party, talked last week with students at Lancaster University about the party’s proposal to deliver fast and free broadband across the country.",
                    "copyright": "Peter Byrne/Agence France-Presse, via Pool"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/business/21ukbroadband/21ukbroadband-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Jeremy Corbyn, the leader of the Labour Party, talked last week with students at Lancaster University about the party’s proposal to deliver fast and free broadband across the country.",
                    "copyright": "Peter Byrne/Agence France-Presse, via Pool"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/business/21ukbroadband/21ukbroadband-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Jeremy Corbyn, the leader of the Labour Party, talked last week with students at Lancaster University about the party’s proposal to deliver fast and free broadband across the country.",
                    "copyright": "Peter Byrne/Agence France-Presse, via Pool"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/business/21ukbroadband/21ukbroadband-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Jeremy Corbyn, the leader of the Labour Party, talked last week with students at Lancaster University about the party’s proposal to deliver fast and free broadband across the country.",
                    "copyright": "Peter Byrne/Agence France-Presse, via Pool"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/business/21ukbroadband/21ukbroadband-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Jeremy Corbyn, the leader of the Labour Party, talked last week with students at Lancaster University about the party’s proposal to deliver fast and free broadband across the country.",
                    "copyright": "Peter Byrne/Agence France-Presse, via Pool"
                }
            ],
            "short_url": "https://nyti.ms/2qwUXyn"
        },
        {
            "section": "U.S.",
            "subsection": "Politics",
            "title": "No, That Mac Factory in Texas Is Not New",
            "abstract": "President Trump said on Wednesday that he opened a facility that makes computers for Apple. It’s been operating since 2013.",
            "url": "https://www.nytimes.com/2019/11/20/us/politics/trump-texas-apple-factory.html",
            "byline": "By JACK NICAS",
            "item_type": "Article",
            "updated_date": "2019-11-20T22:16:10-05:00",
            "created_date": "2019-11-20T22:16:10-05:00",
            "published_date": "2019-11-20T22:16:10-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computers and the Internet",
                "Factories and Manufacturing"
            ],
            "org_facet": [
                "Apple Inc",
                "Flex Ltd."
            ],
            "per_facet": [
                "Cook, Timothy D",
                "Trump, Donald J"
            ],
            "geo_facet": [
                "Austin (Tex)"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/20apple-print/20apple-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "President Trump toured a factory that makes Mac computers for Apple with the chief executive, Timothy D. Cook, on Wednesday in Austin, Texas.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/20apple-print/20apple-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "President Trump toured a factory that makes Mac computers for Apple with the chief executive, Timothy D. Cook, on Wednesday in Austin, Texas.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/20apple-print/merlin_164751882_b9a14af0-2c80-4fb0-aab0-c5b45a6ff502-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "President Trump toured a factory that makes Mac computers for Apple with the chief executive, Timothy D. Cook, on Wednesday in Austin, Texas.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/20apple-print/20apple-mediumThreeByTwo210-v3.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "President Trump toured a factory that makes Mac computers for Apple with the chief executive, Timothy D. Cook, on Wednesday in Austin, Texas.",
                    "copyright": "Pete Marovich for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/22/business/20apple-print/merlin_164751882_b9a14af0-2c80-4fb0-aab0-c5b45a6ff502-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "President Trump toured a factory that makes Mac computers for Apple with the chief executive, Timothy D. Cook, on Wednesday in Austin, Texas.",
                    "copyright": "Pete Marovich for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2QErA7S"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Uber Embraces Videotaping Rides, Raising Privacy Concerns",
            "abstract": "The company says it is increasing the recording of rides to settle disputes between drivers and passengers and to improve safety.",
            "url": "https://www.nytimes.com/2019/11/20/technology/uber-recording-rides-privacy.html",
            "byline": "By KATE CONGER",
            "item_type": "Article",
            "updated_date": "2019-11-20T18:41:05-05:00",
            "created_date": "2019-11-20T18:41:05-05:00",
            "published_date": "2019-11-20T18:41:05-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Car Services and Livery Cabs",
                "Privacy",
                "Video Recordings, Downloads and Streaming",
                "Mobile Applications"
            ],
            "org_facet": [
                "Uber Technologies Inc"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20uber/merlin_123496049_06e5df84-69d0-49b0-8078-19974a3a0a12-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Uber has been recording some rides as part of a broad initiative to capture more objective data about what happens inside vehicles.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20uber/merlin_123496049_06e5df84-69d0-49b0-8078-19974a3a0a12-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Uber has been recording some rides as part of a broad initiative to capture more objective data about what happens inside vehicles.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20uber/merlin_123496049_06e5df84-69d0-49b0-8078-19974a3a0a12-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Uber has been recording some rides as part of a broad initiative to capture more objective data about what happens inside vehicles.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20uber/merlin_123496049_06e5df84-69d0-49b0-8078-19974a3a0a12-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Uber has been recording some rides as part of a broad initiative to capture more objective data about what happens inside vehicles.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20uber/merlin_123496049_06e5df84-69d0-49b0-8078-19974a3a0a12-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Uber has been recording some rides as part of a broad initiative to capture more objective data about what happens inside vehicles.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/3445kIE"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Google Policy Change Upends Online Plans for 2020 Campaigns",
            "abstract": "The company said political ads would not be directed specifically to audiences based on their public voter records or political affiliations.",
            "url": "https://www.nytimes.com/2019/11/20/technology/google-political-ads-targeting.html",
            "byline": "By DAISUKE WAKABAYASHI and SHANE GOLDMACHER",
            "item_type": "Article",
            "updated_date": "2019-11-21T14:33:51-05:00",
            "created_date": "2019-11-20T18:40:10-05:00",
            "published_date": "2019-11-20T18:40:10-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Political Advertising",
                "Online Advertising",
                "Data-Mining and Database Marketing",
                "Presidential Election of 2020"
            ],
            "org_facet": [
                "Google Inc"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20google/20google-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google said the new policy would go into effect worldwide in January.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20google/20google-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google said the new policy would go into effect worldwide in January.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20google/merlin_155876139_90b99942-3a55-44b4-9b82-587acfd9fdc2-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google said the new policy would go into effect worldwide in January.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20google/20google-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google said the new policy would go into effect worldwide in January.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20google/merlin_155876139_90b99942-3a55-44b4-9b82-587acfd9fdc2-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google said the new policy would go into effect worldwide in January.",
                    "copyright": "Christie Hemm Klok for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/348XUUy"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "Tesla’s Winding Road to Berlin",
            "abstract": "Elon Musk’s announcement of a factory in Germany took the industry by surprise, but the deal had been in the works for months.",
            "url": "https://www.nytimes.com/2019/11/20/business/tesla-germany.html",
            "byline": "By CHRISTOPHER F. SCHUETZE and JACK EWING",
            "item_type": "Article",
            "updated_date": "2019-11-20T17:28:32-05:00",
            "created_date": "2019-11-20T16:15:51-05:00",
            "published_date": "2019-11-20T16:15:51-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Automobiles",
                "Electric and Hybrid Vehicles",
                "Factories and Manufacturing"
            ],
            "org_facet": [
                "Tesla Motors Inc"
            ],
            "per_facet": [
                "Musk, Elon"
            ],
            "geo_facet": [
                "Berlin (Germany)"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20TESLAFACTORY2/20TESLAFACTORY2-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mr. Christiani, on the Tesla site, said local officials hoped the factory would lure working-age people back from the cities.",
                    "copyright": "Andreas Meichsner for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20TESLAFACTORY2/20TESLAFACTORY2-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mr. Christiani, on the Tesla site, said local officials hoped the factory would lure working-age people back from the cities.",
                    "copyright": "Andreas Meichsner for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20TESLAFACTORY2/merlin_164684256_103d9292-cc4b-4a4d-8229-b1f7588b7e7c-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mr. Christiani, on the Tesla site, said local officials hoped the factory would lure working-age people back from the cities.",
                    "copyright": "Andreas Meichsner for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20TESLAFACTORY2/20TESLAFACTORY2-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mr. Christiani, on the Tesla site, said local officials hoped the factory would lure working-age people back from the cities.",
                    "copyright": "Andreas Meichsner for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20TESLAFACTORY2/merlin_164684256_103d9292-cc4b-4a4d-8229-b1f7588b7e7c-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Mr. Christiani, on the Tesla site, said local officials hoped the factory would lure working-age people back from the cities.",
                    "copyright": "Andreas Meichsner for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2XBLLVI"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Google Hires Firm Known for Anti-Union Efforts",
            "abstract": "After nearly two years of unrest, the company appears to be cracking down on employee activism.",
            "url": "https://www.nytimes.com/2019/11/20/technology/Google-union-consultant.html",
            "byline": "By NOAM SCHEIBER and DAISUKE WAKABAYASHI",
            "item_type": "Article",
            "updated_date": "2019-11-20T17:22:38-05:00",
            "created_date": "2019-11-20T14:51:24-05:00",
            "published_date": "2019-11-20T14:51:24-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Organized Labor",
                "Sexual Harassment",
                "Consultants",
                "Workplace Hazards and Violations",
                "Computers and the Internet"
            ],
            "org_facet": [
                "Google Inc",
                "IRI Consultants"
            ],
            "per_facet": [
                "Pichai, Sundar",
                "Whittaker, Meredith"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20googleworkers/20googleworkers-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Employees walked out at Google’s headquarters in Mountain View, Calif., last November to protest how it handled sexual harassment complaints.",
                    "copyright": "Jim Wilson/The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20googleworkers/20googleworkers-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Employees walked out at Google’s headquarters in Mountain View, Calif., last November to protest how it handled sexual harassment complaints.",
                    "copyright": "Jim Wilson/The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20googleworkers/merlin_146189823_2c868948-6c89-48bd-ac0b-0a8a1ac323a6-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Employees walked out at Google’s headquarters in Mountain View, Calif., last November to protest how it handled sexual harassment complaints.",
                    "copyright": "Jim Wilson/The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20googleworkers/20googleworkers-mediumThreeByTwo210-v2.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Employees walked out at Google’s headquarters in Mountain View, Calif., last November to protest how it handled sexual harassment complaints.",
                    "copyright": "Jim Wilson/The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20googleworkers/merlin_146189823_2c868948-6c89-48bd-ac0b-0a8a1ac323a6-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Employees walked out at Google’s headquarters in Mountain View, Calif., last November to protest how it handled sexual harassment complaints.",
                    "copyright": "Jim Wilson/The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2D3O0rj"
        },
        {
            "section": "Technology",
            "subsection": "Personal Tech",
            "title": "Want the Greenest Device? You May Already Own It",
            "abstract": "One way to help the planet is not to buy new tech, especially stuff the planet never needed, says Kendra Pierre-Louis, who reports on the environment.",
            "url": "https://www.nytimes.com/2019/11/20/technology/personaltech/green-environmental-tech.html",
            "byline": "By KENDRA PIERRE-LOUIS",
            "item_type": "Article",
            "updated_date": "2019-11-21T00:16:06-05:00",
            "created_date": "2019-11-20T09:00:10-05:00",
            "published_date": "2019-11-20T09:00:10-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computers and the Internet",
                "Mobile Applications",
                "Laptop Computers",
                "Sustainable Living"
            ],
            "org_facet": [],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20techusing/20techusing-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;I think the greenest things I do are the things that I don&rsquo;t buy, honestly,&rdquo; said Kendra Pierre-Louis, who reports on the environment.",
                    "copyright": "Gabby Jones for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20techusing/20techusing-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;I think the greenest things I do are the things that I don&rsquo;t buy, honestly,&rdquo; said Kendra Pierre-Louis, who reports on the environment.",
                    "copyright": "Gabby Jones for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20techusing/20techusing-articleInline.jpg",
                    "format": "Normal",
                    "height": 285,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;I think the greenest things I do are the things that I don&rsquo;t buy, honestly,&rdquo; said Kendra Pierre-Louis, who reports on the environment.",
                    "copyright": "Gabby Jones for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20techusing/20techusing-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;I think the greenest things I do are the things that I don&rsquo;t buy, honestly,&rdquo; said Kendra Pierre-Louis, who reports on the environment.",
                    "copyright": "Gabby Jones for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20techusing/20techusing-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 2048,
                    "width": 1366,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;I think the greenest things I do are the things that I don&rsquo;t buy, honestly,&rdquo; said Kendra Pierre-Louis, who reports on the environment.",
                    "copyright": "Gabby Jones for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2s2ovo2"
        },
        {
            "section": "Style",
            "subsection": "",
            "title": "How a Gig Worker Revolt Begins",
            "abstract": "Rev was just a small start-up offering online transcriptions. Now it’s the latest symbol of a gig-economy company whose workers are fed up.",
            "url": "https://www.nytimes.com/2019/11/19/style/rev-transcription-workers-gig-economy.html",
            "byline": "By NATHANIEL POPPER",
            "item_type": "Article",
            "updated_date": "2019-11-20T11:43:17-05:00",
            "created_date": "2019-11-19T13:46:20-05:00",
            "published_date": "2019-11-19T13:46:20-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computers and the Internet",
                "Voice Recognition Systems",
                "Freelancing, Self-Employment and Independent Contracting",
                "Start-ups",
                "Labor and Jobs",
                "your-feed-selfcare",
                "your-feed-work",
                "your-feed-internet-culture"
            ],
            "org_facet": [],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/fashion/19REV/19REV-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/fashion/19REV/19REV-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/fashion/19REV/19REV-articleInline.jpg",
                    "format": "Normal",
                    "height": 107,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/fashion/19REV/19REV-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/fashion/19REV/19REV-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1152,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Getty Images"
                }
            ],
            "short_url": "https://nyti.ms/33XANfr"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "What Is End-to-End Encryption? Another Bull’s-Eye on Big Tech",
            "abstract": "After years of on-and-off debate over nearly snoop-proof security, the industry is girding for new pressure from law enforcement around the world.",
            "url": "https://www.nytimes.com/2019/11/19/technology/end-to-end-encryption.html",
            "byline": "By NICOLE PERLROTH",
            "item_type": "Article",
            "updated_date": "2019-11-19T17:52:36-05:00",
            "created_date": "2019-11-19T13:42:32-05:00",
            "published_date": "2019-11-19T13:42:32-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computer Security",
                "Surveillance of Citizens by Government",
                "Computers and the Internet",
                "Instant Messaging",
                "Privacy"
            ],
            "org_facet": [
                "Apple Inc",
                "Facebook Inc",
                "Google Inc",
                "WhatsApp Inc"
            ],
            "per_facet": [
                "Barr, William P",
                "Cook, Timothy D",
                "Zuckerberg, Mark E"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20endtoend-illo/19endtoend-illo-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Yarek Waszul"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20endtoend-illo/19endtoend-illo-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Yarek Waszul"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20endtoend-illo/19endtoend-illo-articleInline.jpg",
                    "format": "Normal",
                    "height": 138,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Yarek Waszul"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20endtoend-illo/19endtoend-illo-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Yarek Waszul"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/business/20endtoend-illo/19endtoend-illo-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1485,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Yarek Waszul"
                }
            ],
            "short_url": "https://nyti.ms/2raIroo"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Dealing With Bias in Artificial Intelligence",
            "abstract": "Three women with extensive experience in A.I. spoke on the topic and how to confront it.",
            "url": "https://www.nytimes.com/2019/11/19/technology/artificial-intelligence-bias.html",
            "byline": "By CRAIG S. SMITH",
            "item_type": "Article",
            "updated_date": "2019-11-19T05:00:23-05:00",
            "created_date": "2019-11-19T05:00:23-05:00",
            "published_date": "2019-11-19T05:00:23-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Artificial Intelligence",
                "Discrimination",
                "Women and Girls",
                "Computers and the Internet"
            ],
            "org_facet": [],
            "per_facet": [
                "Koller, Daphne",
                "Russakovsky, Olga",
                "Gebru, Timnit"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/multimedia/20sp-women-ai1a/20sp-women-ai1a-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Harriet Lee-Merrion"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/multimedia/20sp-women-ai1a/20sp-women-ai1a-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Harriet Lee-Merrion"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/multimedia/20sp-women-ai1a/20sp-women-ai1a-articleInline.jpg",
                    "format": "Normal",
                    "height": 78,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Harriet Lee-Merrion"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/multimedia/20sp-women-ai1a/20sp-women-ai1a-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Harriet Lee-Merrion"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/20/multimedia/20sp-women-ai1a/20sp-women-ai1a-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 839,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Harriet Lee-Merrion"
                }
            ],
            "short_url": "https://nyti.ms/2r5ptzr"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "Big Tech’s Toughest Opponent Says She’s Just Getting Started",
            "abstract": "Margrethe Vestager won praise for her oversight of the tech industry. Now, with more authority from the European Union, she envisions a more aggressive agenda.",
            "url": "https://www.nytimes.com/2019/11/19/technology/tech-regulator-europe.html",
            "byline": "By ADAM SATARIANO and MATINA STEVIS-GRIDNEFF",
            "item_type": "Article",
            "updated_date": "2019-11-19T15:19:19-05:00",
            "created_date": "2019-11-19T03:00:08-05:00",
            "published_date": "2019-11-19T03:00:08-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computers and the Internet",
                "International Trade and World Market",
                "Politics and Government",
                "Antitrust Laws and Competition Issues",
                "Regulation and Deregulation of Industry"
            ],
            "org_facet": [
                "European Commission",
                "Google Inc",
                "Apple Inc",
                "Amazon.com Inc",
                "Facebook Inc"
            ],
            "per_facet": [
                "Vestager, Margrethe"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/business/19VESTAGER/18VESTAGER-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;We do not leave it to market forces to have the final say,&rdquo; Margrethe Vestager said.",
                    "copyright": "Ans Brys for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/business/19VESTAGER/18VESTAGER-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;We do not leave it to market forces to have the final say,&rdquo; Margrethe Vestager said.",
                    "copyright": "Ans Brys for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/business/19VESTAGER/merlin_164270316_ac41e3ac-53c1-4d85-91dd-e9ff0ef72f35-articleInline.jpg",
                    "format": "Normal",
                    "height": 285,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;We do not leave it to market forces to have the final say,&rdquo; Margrethe Vestager said.",
                    "copyright": "Ans Brys for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/business/19VESTAGER/18VESTAGER-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;We do not leave it to market forces to have the final say,&rdquo; Margrethe Vestager said.",
                    "copyright": "Ans Brys for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/19/business/19VESTAGER/merlin_164270316_ac41e3ac-53c1-4d85-91dd-e9ff0ef72f35-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 2048,
                    "width": 1366,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "&ldquo;We do not leave it to market forces to have the final say,&rdquo; Margrethe Vestager said.",
                    "copyright": "Ans Brys for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2QA8ZtF"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "U.S. Offers Huawei Reprieve on Monday, but May Crack Down on Friday",
            "abstract": "The F.C.C. will vote this week on whether to ban federal subsidies from going to the Chinese telecom giant.",
            "url": "https://www.nytimes.com/2019/11/18/technology/huawei-us-china.html",
            "byline": "By DAVID McCABE",
            "item_type": "Article",
            "updated_date": "2019-11-18T19:04:21-05:00",
            "created_date": "2019-11-18T19:04:21-05:00",
            "published_date": "2019-11-18T19:04:21-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Blacklisting",
                "United States Politics and Government",
                "United States International Relations",
                "International Trade and World Market",
                "Defense and Military Forces",
                "Politics and Government",
                "Wireless Communications"
            ],
            "org_facet": [],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18DC-HUAWEI-01/18DC-HUAWEI-01-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Huawei, one of China’s most visible tech companies, has become a bargaining chip in the president’s trade war.",
                    "copyright": "Patricia De Melo Moreira/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18DC-HUAWEI-01/18DC-HUAWEI-01-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Huawei, one of China’s most visible tech companies, has become a bargaining chip in the president’s trade war.",
                    "copyright": "Patricia De Melo Moreira/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18DC-HUAWEI-01/merlin_164622342_b17ad35c-818a-4ea3-91b4-67034f0ae669-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Huawei, one of China’s most visible tech companies, has become a bargaining chip in the president’s trade war.",
                    "copyright": "Patricia De Melo Moreira/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18DC-HUAWEI-01/merlin_164622342_b17ad35c-818a-4ea3-91b4-67034f0ae669-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Huawei, one of China’s most visible tech companies, has become a bargaining chip in the president’s trade war.",
                    "copyright": "Patricia De Melo Moreira/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18DC-HUAWEI-01/merlin_164622342_b17ad35c-818a-4ea3-91b4-67034f0ae669-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1366,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Huawei, one of China’s most visible tech companies, has become a bargaining chip in the president’s trade war.",
                    "copyright": "Patricia De Melo Moreira/Agence France-Presse — Getty Images"
                }
            ],
            "short_url": "https://nyti.ms/2Qx4Xm2"
        },
        {
            "section": "Business",
            "subsection": "Media",
            "title": "Justice Dept. to Abolish Movie Distribution Rules Dating to 1949",
            "abstract": "The agency says the rules are effectively obsolete because of technological advancements like streaming.",
            "url": "https://www.nytimes.com/2019/11/18/business/media/movie-distribution-rules.html",
            "byline": "By BROOKS BARNES and CECILIA KANG",
            "item_type": "Article",
            "updated_date": "2019-11-18T19:02:12-05:00",
            "created_date": "2019-11-18T18:53:26-05:00",
            "published_date": "2019-11-18T18:53:26-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Movies",
                "Antitrust Laws and Competition Issues",
                "Regulation and Deregulation of Industry"
            ],
            "org_facet": [
                "Paramount Pictures",
                "National Assn of Theater Owners",
                "Justice Department"
            ],
            "per_facet": [
                "Delrahim, Makan"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18theaters/merlin_141974760_961fc2f5-e771-4eda-bf04-172d95926adb-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Regal Entertainment, AMC Entertainment and Cinemark Holdings control roughly half of the 40,000 movie screens in the United States.",
                    "copyright": "Allison Farrand for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18theaters/merlin_141974760_961fc2f5-e771-4eda-bf04-172d95926adb-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Regal Entertainment, AMC Entertainment and Cinemark Holdings control roughly half of the 40,000 movie screens in the United States.",
                    "copyright": "Allison Farrand for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18theaters/merlin_141974760_961fc2f5-e771-4eda-bf04-172d95926adb-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Regal Entertainment, AMC Entertainment and Cinemark Holdings control roughly half of the 40,000 movie screens in the United States.",
                    "copyright": "Allison Farrand for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18theaters/merlin_141974760_961fc2f5-e771-4eda-bf04-172d95926adb-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Regal Entertainment, AMC Entertainment and Cinemark Holdings control roughly half of the 40,000 movie screens in the United States.",
                    "copyright": "Allison Farrand for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18theaters/merlin_141974760_961fc2f5-e771-4eda-bf04-172d95926adb-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Regal Entertainment, AMC Entertainment and Cinemark Holdings control roughly half of the 40,000 movie screens in the United States.",
                    "copyright": "Allison Farrand for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2OogO2X"
        },
        {
            "section": "Science",
            "subsection": "",
            "title": "Watch Bees Surf to Safety on Waves They Create",
            "abstract": "When honeybees fall into water, they generate their own ripples, then glide to dry land, a study found.",
            "url": "https://www.nytimes.com/2019/11/18/science/bees-surfing-water.html",
            "byline": "By EMMA GOLDBERG",
            "item_type": "Article",
            "updated_date": "2019-11-20T05:40:36-05:00",
            "created_date": "2019-11-18T15:00:12-05:00",
            "published_date": "2019-11-18T15:00:12-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Bees",
                "Research",
                "Water",
                "Engineering and Engineers",
                "Surfing",
                "your-feed-science"
            ],
            "org_facet": [
                "Proceedings of the National Academy of Sciences"
            ],
            "per_facet": [
                "Roh, Chris",
                "Gharib, Morteza"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/26/science/18TB-SURFINGBEES1/18TB-SURFINGBEES1-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Chris Roh and Morteza Gharib, CalTech"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/26/science/18TB-SURFINGBEES1/18TB-SURFINGBEES1-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Chris Roh and Morteza Gharib, CalTech"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/26/science/18TB-SURFINGBEES1/18TB-SURFINGBEES1-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Chris Roh and Morteza Gharib, CalTech"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/26/science/18TB-SURFINGBEES1/18TB-SURFINGBEES1-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Chris Roh and Morteza Gharib, CalTech"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/26/science/18TB-SURFINGBEES1/18TB-SURFINGBEES1-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1281,
                    "width": 1922,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Chris Roh and Morteza Gharib, CalTech"
                }
            ],
            "short_url": "https://nyti.ms/2XqXaHz"
        },
        {
            "section": "Technology",
            "subsection": "Personal Tech",
            "title": "Google Stadia Wants You to Replace Your Video Game Console. Don’t.",
            "abstract": "The search giant’s new console-free gaming service is a neat concept. But there are bugs and too many unknowns.",
            "url": "https://www.nytimes.com/2019/11/18/technology/personaltech/google-stadia-review.html",
            "byline": "By BRIAN X. CHEN",
            "item_type": "Article",
            "updated_date": "2019-11-18T20:30:42-05:00",
            "created_date": "2019-11-18T12:00:20-05:00",
            "published_date": "2019-11-18T12:00:20-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computer and Video Games",
                "Cloud Computing",
                "Video Recordings, Downloads and Streaming"
            ],
            "org_facet": [
                "Google Stadia",
                "Google Inc"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18techfix3/18techfix3-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google launched its Stadia cloud service that allows people to play console-quality video games on a web browser or smartphone.",
                    "copyright": "Ina Fassbender/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18techfix3/18techfix3-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google launched its Stadia cloud service that allows people to play console-quality video games on a web browser or smartphone.",
                    "copyright": "Ina Fassbender/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18techfix3/merlin_164528130_90a36cdb-840c-45c4-8a8a-b90e55e3c2e8-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google launched its Stadia cloud service that allows people to play console-quality video games on a web browser or smartphone.",
                    "copyright": "Ina Fassbender/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18techfix3/18techfix3-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google launched its Stadia cloud service that allows people to play console-quality video games on a web browser or smartphone.",
                    "copyright": "Ina Fassbender/Agence France-Presse — Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18techfix3/merlin_164528130_90a36cdb-840c-45c4-8a8a-b90e55e3c2e8-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Google launched its Stadia cloud service that allows people to play console-quality video games on a web browser or smartphone.",
                    "copyright": "Ina Fassbender/Agence France-Presse — Getty Images"
                }
            ],
            "short_url": "https://nyti.ms/2OnhUvZ"
        },
        {
            "section": "Business",
            "subsection": "Media",
            "title": "T-Mobile’s Longtime C.E.O., John Legere, Will Step Down",
            "abstract": "Mr. Legere was credited with reviving the telecommunications company. He has been instrumental in navigating T-Mobile’s pending merger deal with Sprint.",
            "url": "https://www.nytimes.com/2019/11/18/business/media/t-mobile-john-legere.html",
            "byline": "By EDMUND LEE",
            "item_type": "Article",
            "updated_date": "2019-11-19T15:20:43-05:00",
            "created_date": "2019-11-18T09:07:29-05:00",
            "published_date": "2019-11-18T09:07:29-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Appointments and Executive Changes",
                "Wireless Communications",
                "Mergers, Acquisitions and Divestitures"
            ],
            "org_facet": [
                "T-Mobile US Inc",
                "Sprint Nextel Corporation",
                "WeWork Companies Inc",
                "SOFTBANK Corporation"
            ],
            "per_facet": [
                "Legere, John J"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18tmobile-1/18tmobile-1-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "T-Mobile’s chief executive, John Legere, will step down at the end of April after his contract expires.",
                    "copyright": "Alex Wong/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18tmobile-1/18tmobile-1-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "T-Mobile’s chief executive, John Legere, will step down at the end of April after his contract expires.",
                    "copyright": "Alex Wong/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18tmobile-1/18tmobile-1-articleInline.jpg",
                    "format": "Normal",
                    "height": 140,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "T-Mobile’s chief executive, John Legere, will step down at the end of April after his contract expires.",
                    "copyright": "Alex Wong/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18tmobile-1/18tmobile-1-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "T-Mobile’s chief executive, John Legere, will step down at the end of April after his contract expires.",
                    "copyright": "Alex Wong/Getty Images"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/business/18tmobile-1/merlin_150644649_72f955ce-e657-4dd3-b5d6-3bfe58a93fad-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "T-Mobile’s chief executive, John Legere, will step down at the end of April after his contract expires.",
                    "copyright": "Alex Wong/Getty Images"
                }
            ],
            "short_url": "https://nyti.ms/37fCeYx"
        },
        {
            "section": "Technology",
            "subsection": "Personal Tech",
            "title": "Stop! Don’t Charge Your Phone This Way",
            "abstract": "You might want to think twice before plugging in at an airport or on the train.",
            "url": "https://www.nytimes.com/2019/11/18/technology/personaltech/usb-warning-juice-jacking.html",
            "byline": "By AIMEE ORTIZ",
            "item_type": "Article",
            "updated_date": "2019-11-18T08:26:51-05:00",
            "created_date": "2019-11-18T08:26:51-05:00",
            "published_date": "2019-11-18T08:26:51-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Smartphones",
                "Cyberattacks and Hackers",
                "Wire and Cable",
                "Batteries",
                "Computer Security",
                "Juice Jacking"
            ],
            "org_facet": [],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/multimedia/17xp-USB/17xp-USB-thumbStandard-v2.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“Juice jacking” exploits the fact that somebody doesn’t have a full battery, one cybersecurity expert said.",
                    "copyright": "Shutterstock"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/multimedia/17xp-USB/17xp-USB-thumbLarge-v2.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“Juice jacking” exploits the fact that somebody doesn’t have a full battery, one cybersecurity expert said.",
                    "copyright": "Shutterstock"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/multimedia/17xp-USB/17xp-USB-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“Juice jacking” exploits the fact that somebody doesn’t have a full battery, one cybersecurity expert said.",
                    "copyright": "Shutterstock"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/multimedia/17xp-USB/17xp-USB-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“Juice jacking” exploits the fact that somebody doesn’t have a full battery, one cybersecurity expert said.",
                    "copyright": "Shutterstock"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/multimedia/17xp-USB/17xp-USB-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "“Juice jacking” exploits the fact that somebody doesn’t have a full battery, one cybersecurity expert said.",
                    "copyright": "Shutterstock"
                }
            ],
            "short_url": "https://nyti.ms/2NXR8LK"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "SoftBank and Line Corp. Seek to Create a Japanese Internet Giant",
            "abstract": "Fresh off a multibillion-dollar loss on WeWork, SoftBank plans to shore up its domestic business with a big bet on Japan’s leading messaging app company.",
            "url": "https://www.nytimes.com/2019/11/18/business/softbank-line-merger.html",
            "byline": "By BEN DOOLEY",
            "item_type": "Article",
            "updated_date": "2019-11-18T14:22:10-05:00",
            "created_date": "2019-11-18T07:54:19-05:00",
            "published_date": "2019-11-18T07:54:19-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Computers and the Internet",
                "Mergers, Acquisitions and Divestitures",
                "Wireless Communications",
                "Mobile Applications"
            ],
            "org_facet": [
                "Line Corp",
                "SOFTBANK Corporation",
                "Naver.com"
            ],
            "per_facet": [
                "Son, Masayoshi"
            ],
            "geo_facet": [
                "Japan"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/world/18softbank-1/18softbank-1-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Line is the dominant messaging app company in Japan.",
                    "copyright": "Toru Hanai/Reuters"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/world/18softbank-1/18softbank-1-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Line is the dominant messaging app company in Japan.",
                    "copyright": "Toru Hanai/Reuters"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/world/18softbank-1/merlin_164589801_9cc25877-de58-4fb3-b582-50e02696642b-articleInline.jpg",
                    "format": "Normal",
                    "height": 133,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Line is the dominant messaging app company in Japan.",
                    "copyright": "Toru Hanai/Reuters"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/world/18softbank-1/merlin_164589801_9cc25877-de58-4fb3-b582-50e02696642b-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Line is the dominant messaging app company in Japan.",
                    "copyright": "Toru Hanai/Reuters"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/world/18softbank-1/merlin_164589801_9cc25877-de58-4fb3-b582-50e02696642b-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1439,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Line is the dominant messaging app company in Japan.",
                    "copyright": "Toru Hanai/Reuters"
                }
            ],
            "short_url": "https://nyti.ms/2qnUf6v"
        },
        {
            "section": "Travel",
            "subsection": "",
            "title": "A 17-Mile Hike to Unite San Francisco",
            "abstract": "A motley alliance decided a single trail could unite this divided city. A sixth-generation native sets out to walk it.",
            "url": "https://www.nytimes.com/2019/11/18/travel/crosstown-trail-san-francisco.html",
            "byline": "By NELLIE BOWLES",
            "item_type": "Article",
            "updated_date": "2019-11-24T13:23:58-05:00",
            "created_date": "2019-11-18T05:00:28-05:00",
            "published_date": "2019-11-18T05:00:28-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Hikes and Hiking",
                "Travel and Vacations",
                "Parks and Other Recreation Areas",
                "Maps"
            ],
            "org_facet": [],
            "per_facet": [],
            "geo_facet": [
                "San Francisco (Calif)"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/travel/18san-francisco-hiking-trail17/18san-francisco-hiking-trail17-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "In San Francisco&rsquo;s aptly named Grandview Park, looking north to Golden Gate Park from the Crosstown Trail.",
                    "copyright": "Jason Henry for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/travel/18san-francisco-hiking-trail17/18san-francisco-hiking-trail17-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "In San Francisco&rsquo;s aptly named Grandview Park, looking north to Golden Gate Park from the Crosstown Trail.",
                    "copyright": "Jason Henry for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/travel/18san-francisco-hiking-trail17/merlin_164003931_7edaa132-9285-4350-94a0-57da8e8efaf4-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "In San Francisco&rsquo;s aptly named Grandview Park, looking north to Golden Gate Park from the Crosstown Trail.",
                    "copyright": "Jason Henry for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/travel/18san-francisco-hiking-trail17/18san-francisco-hiking-trail17-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "In San Francisco&rsquo;s aptly named Grandview Park, looking north to Golden Gate Park from the Crosstown Trail.",
                    "copyright": "Jason Henry for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/18/travel/18san-francisco-hiking-trail17/merlin_164003931_7edaa132-9285-4350-94a0-57da8e8efaf4-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "In San Francisco&rsquo;s aptly named Grandview Park, looking north to Golden Gate Park from the Crosstown Trail.",
                    "copyright": "Jason Henry for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/37jF9zM"
        },
        {
            "section": "Business",
            "subsection": "Media",
            "title": "The Streaming Era Has Finally Arrived. Everything Is About to Change.",
            "abstract": "Once a generation, Hollywood experiences a seismic shift. It is happening again.",
            "url": "https://www.nytimes.com/2019/11/18/business/media/streaming-hollywood-revolution.html",
            "byline": "By BROOKS BARNES",
            "item_type": "Article",
            "updated_date": "2019-11-19T15:41:32-05:00",
            "created_date": "2019-11-18T05:00:22-05:00",
            "published_date": "2019-11-18T05:00:22-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Video Recordings, Downloads and Streaming",
                "Movies",
                "Television",
                "AI November 2019"
            ],
            "org_facet": [
                "Disney Plus",
                "NBCUniversal",
                "Warner Media LLC",
                "Amazon.com Inc",
                "Apple Inc",
                "Netflix Inc"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/08/business/08streaming-02/08streaming-02-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Saiman Chow"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/08/business/08streaming-02/08streaming-02-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Saiman Chow"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/08/business/08streaming-02/08streaming-02-articleInline.jpg",
                    "format": "Normal",
                    "height": 139,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Saiman Chow"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/08/business/08streaming-02/08streaming-02-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Saiman Chow"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/08/business/08streaming-02/08streaming-02-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 766,
                    "width": 1050,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "",
                    "copyright": "Saiman Chow"
                }
            ],
            "short_url": "https://nyti.ms/2XqxVp6"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "TikTok’s Chief Is on a Mission to Prove It’s Not a Menace",
            "abstract": "Alex Zhu, the head of the Chinese-owned viral video app, is trying to assuage Washington’s fears. “I am quite optimistic,” he said.",
            "url": "https://www.nytimes.com/2019/11/18/technology/tiktok-alex-zhu-interview.html",
            "byline": "By RAYMOND ZHONG",
            "item_type": "Article",
            "updated_date": "2019-11-18T03:00:09-05:00",
            "created_date": "2019-11-18T03:00:09-05:00",
            "published_date": "2019-11-18T03:00:09-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Social Media",
                "Video Recordings, Downloads and Streaming",
                "Computers and the Internet",
                "United States Politics and Government",
                "International Trade and World Market",
                "Data-Mining and Database Marketing",
                "Foreign Investments"
            ],
            "org_facet": [
                "TikTok (ByteDance)",
                "Committee on Foreign Investment in the United States (CFIUS)",
                "Musical.ly Inc"
            ],
            "per_facet": [
                "Zhu, Alex",
                "Zhang Yiming (1983- )"
            ],
            "geo_facet": [
                "China"
            ],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/17tiktok-01/17tiktok-01-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Alex Zhu, the head of TikTok, in New York.",
                    "copyright": "Alexander Harris for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/17tiktok-01/17tiktok-01-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Alex Zhu, the head of TikTok, in New York.",
                    "copyright": "Alexander Harris for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/17tiktok-01/merlin_164414643_32964e20-940e-4c56-881c-acc87f04f99c-articleInline.jpg",
                    "format": "Normal",
                    "height": 285,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Alex Zhu, the head of TikTok, in New York.",
                    "copyright": "Alexander Harris for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/17tiktok-01/17tiktok-01-mediumThreeByTwo210-v2.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Alex Zhu, the head of TikTok, in New York.",
                    "copyright": "Alexander Harris for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/17tiktok-01/17tiktok-01-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 2048,
                    "width": 1366,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "Alex Zhu, the head of TikTok, in New York.",
                    "copyright": "Alexander Harris for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2NX6xvC"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "Ford Wants to Sell You an Electric S.U.V. It’s Called a Mustang.",
            "abstract": "Automakers have made battery-powered cars largely to meet environmental rules. Now they’re putting more skin in the game.",
            "url": "https://www.nytimes.com/2019/11/17/business/ford-mustang-electric-suv.html",
            "byline": "By NEAL E. BOUDETTE",
            "item_type": "Article",
            "updated_date": "2019-11-19T17:29:15-05:00",
            "created_date": "2019-11-17T21:30:20-05:00",
            "published_date": "2019-11-17T21:30:20-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Electric and Hybrid Vehicles",
                "Automobile Service and Charging Stations",
                "Sports Utility Vehicles and Light Trucks",
                "Batteries",
                "Los Angeles Auto Show"
            ],
            "org_facet": [
                "Ford Motor Co"
            ],
            "per_facet": [
                "Ford, William Clay Jr",
                "Hackett, Jim"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/reader-center/18MUSTANGpageone/merlin_164580282_acb0cbd0-3b23-4e42-a3cf-fe195948ebab-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "The Mustang Mach E was unveiled on Sunday. It is set to come to auto showrooms next year.",
                    "copyright": "Ryan Young for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/reader-center/18MUSTANGpageone/merlin_164580282_acb0cbd0-3b23-4e42-a3cf-fe195948ebab-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "The Mustang Mach E was unveiled on Sunday. It is set to come to auto showrooms next year.",
                    "copyright": "Ryan Young for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/reader-center/18MUSTANGpageone/merlin_164580282_acb0cbd0-3b23-4e42-a3cf-fe195948ebab-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "The Mustang Mach E was unveiled on Sunday. It is set to come to auto showrooms next year.",
                    "copyright": "Ryan Young for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/reader-center/18MUSTANGpageone/18MUSTANGpageone-mediumThreeByTwo210-v3.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "The Mustang Mach E was unveiled on Sunday. It is set to come to auto showrooms next year.",
                    "copyright": "Ryan Young for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/21/reader-center/18MUSTANGpageone/merlin_164580282_acb0cbd0-3b23-4e42-a3cf-fe195948ebab-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1365,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "The Mustang Mach E was unveiled on Sunday. It is set to come to auto showrooms next year.",
                    "copyright": "Ryan Young for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2KxsDmf"
        },
        {
            "section": "Business",
            "subsection": "",
            "title": "WeWork May Lay Off Thousands",
            "abstract": "The beleaguered office space company is said to be planning to cut its work force by at least a third in a bid to stabilize its business.",
            "url": "https://www.nytimes.com/2019/11/17/business/wework-layoffs.html",
            "byline": "By PETER EAVIS and MIKE ISAAC",
            "item_type": "Article",
            "updated_date": "2019-11-18T11:51:21-05:00",
            "created_date": "2019-11-17T19:27:09-05:00",
            "published_date": "2019-11-17T19:27:09-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Layoffs and Job Reductions",
                "Co-Working",
                "Real Estate (Commercial)"
            ],
            "org_facet": [
                "WeWork Companies Inc",
                "SOFTBANK Corporation"
            ],
            "per_facet": [
                "Neumann, Adam"
            ],
            "geo_facet": [],
            "multimedia": [
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/00weworklayoffs1/00weworklayoffs1-thumbStandard.jpg",
                    "format": "Standard Thumbnail",
                    "height": 75,
                    "width": 75,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A WeWork office in Midtown Manhattan. The company could announce layoffs as early as this week.",
                    "copyright": "An Rong Xu for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/00weworklayoffs1/00weworklayoffs1-thumbLarge.jpg",
                    "format": "thumbLarge",
                    "height": 150,
                    "width": 150,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A WeWork office in Midtown Manhattan. The company could announce layoffs as early as this week.",
                    "copyright": "An Rong Xu for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/00weworklayoffs1/merlin_163133157_b7f9adc2-8306-4539-8a2d-419c6134e3ce-articleInline.jpg",
                    "format": "Normal",
                    "height": 127,
                    "width": 190,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A WeWork office in Midtown Manhattan. The company could announce layoffs as early as this week.",
                    "copyright": "An Rong Xu for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/00weworklayoffs1/00weworklayoffs1-mediumThreeByTwo210.jpg",
                    "format": "mediumThreeByTwo210",
                    "height": 140,
                    "width": 210,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A WeWork office in Midtown Manhattan. The company could announce layoffs as early as this week.",
                    "copyright": "An Rong Xu for The New York Times"
                },
                {
                    "url": "https://static01.nyt.com/images/2019/11/17/business/00weworklayoffs1/merlin_163133157_b7f9adc2-8306-4539-8a2d-419c6134e3ce-superJumbo.jpg",
                    "format": "superJumbo",
                    "height": 1367,
                    "width": 2048,
                    "type": "image",
                    "subtype": "photo",
                    "caption": "A WeWork office in Midtown Manhattan. The company could announce layoffs as early as this week.",
                    "copyright": "An Rong Xu for The New York Times"
                }
            ],
            "short_url": "https://nyti.ms/2rLO4td"
        },
        {
            "section": "Technology",
            "subsection": "",
            "title": "HP Rejects Xerox Takeover Bid",
            "abstract": "The cash-and-stock offer “significantly undervalues HP and is not in the best interests of HP shareholders,” company officials wrote.",
            "url": "https://www.nytimes.com/2019/11/17/technology/hp-xerox-takeover.html",
            "byline": "By DAVID YAFFE-BELLANY",
            "item_type": "Article",
            "updated_date": "2019-11-17T15:22:34-05:00",
            "created_date": "2019-11-17T15:22:34-05:00",
            "published_date": "2019-11-17T15:22:34-05:00",
            "material_type_facet": "",
            "kicker": "",
            "des_facet": [
                "Mergers, Acquisitions and Divestitures"
            ],
            "org_facet": [
                "Xerox Corporation",
                "HP Inc"
            ],
            "per_facet": [],
            "geo_facet": [],
            "multimedia": [],
            "short_url": "https://nyti.ms/2XlEiK0"
        }
    ]
}

  
  ```
</details>

## The Data Model
When we want our data from our json file, we need to turn it into a swift model. We do this by using multiple structs that lead us reach result.<br></br>
For example, our data it a dictionary, whic holds key value pairs, and those values could also be dictionaries{} or even lists{}.

<details>
  <summary>File to collect an array of headlines</summary>
  
  ```swift
  ```

</details

