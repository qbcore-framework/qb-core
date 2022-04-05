QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	["unemployed"] = {
		label = "Civilian",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Freelancer",
                payment = 10
            },
        },
	},
	["police"] = {
		label = "Law Enforcement",
		defaultDuty = false,
		bossmenu = vector3(463.09, -985.44, 30.73),
		grades = {
            ['0'] = {
                name = "Cadet",
                payment = 50
            },
			['1'] = {
                name = "Officer",
                payment = 75
            },
        	['2'] = {
                name = "Supervising Officer",
                payment = 85
            },
			['3'] = {
                name = "Sergeant",
                payment = 95
            },
        	['4'] = {
                name = "Staff Sergeant",
                payment = 105
            },
			['5'] = {
                name = "Lieutenant",
                payment = 120
            },
        	['6'] = {
                name = "Captain",
                payment = 140
            },
			['7'] = {
                name = "Chief",
				isboss = true,
                payment = 150
            },
        },
	},
	["ambulance"] = {
		label = "EMS",
		defaultDuty = false,
		bossmenu = vector3(270.5, -1363.0, 23.5),
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 50
            },
			['1'] = {
                name = "Paramedic",
                payment = 75
            },
			['2'] = {
                name = "Doctor",
                payment = 100
            },
			['3'] = {
                name = "Surgeon",
                payment = 125
            },
			['4'] = {
                name = "Chief",
				isboss = true,
                payment = 150
            },
        },
	},
	["realestate"] = {
		label = "Real Estate",
		defaultDuty = true,
		bossmenu = vector3(-124.786, -641.486, 167.820),
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 50
            },
			['1'] = {
                name = "House Sales",
                payment = 75
            },
			['2'] = {
                name = "Business Sales",
                payment = 100
            },
			['3'] = {
                name = "Broker",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
	["taxi"] = {
		label = "Taxi",
		defaultDuty = true,
		bossmenu = vector3(903.32, -170.55, 74.0),
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 75
            },
			['1'] = {
                name = "Driver",
                payment = 100
            },
			['2'] = {
                name = "Event Driver",
                payment = 125
            },
			['3'] = {
                name = "Sales",
                payment = 150
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 175
            },
        },
	},
	["cardealer"] = {
		label = "Vehicle Dealer",
		defaultDuty = true,
		bossmenu = vector3(-32.0, -1114.2, 25.4),
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 50
            },
			['1'] = {
                name = "Showroom Sales",
                payment = 75
            },
			['2'] = {
                name = "Business Sales",
                payment = 100
            },
			['3'] = {
                name = "Finance",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
    ["bikerental"] = {
		label = "Bicycle Renters",
		defaultDuty = true,
		bossmenu = vector3(-32.0, -1114.2, 24.4),
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 50
            },
			['1'] = {
                name = "Novice",
                payment = 75
            },
			['2'] = {
                name = "Experienced",
                payment = 100
            },
			['3'] = {
                name = "Advanced",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 125
            },
        },
	},
	["mechanic"] = {
		label = "Mechanic",
		defaultDuty = true,
		bossmenu = vector3(954.27, -114.74, 75),
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 70
            },
			['1'] = {
                name = "Novice",
                payment = 85
            },
			['2'] = {
                name = "Experienced",
                payment = 100
            },
			['3'] = {
                name = "Advanced",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
    ["carters"] = {
		label = "Carters",
		defaultDuty = true,
		bossmenu = vector3(-1345.22, -1062.22, 7.83),
		grades = {
            ['0'] = {
                name = "Bar Staff",
                payment = 70
            },
			['1'] = {
                name = "Waiter",
                payment = 85
            },
			['2'] = {
                name = "Supervisor",
                payment = 100
            },
			['3'] = {
                name = "Manger",
                payment = 115
            },
			['4'] = {
                name = "Boss",
				isboss = true,
                payment = 125
            },
        },
	},
    ["bonetti"] = {
		label = "Bonettie's",
		defaultDuty = true,
		bossmenu = vector3(-1345.22, -1062.22, 7.83),
		grades = {
            ['0'] = {
                name = "Bar Staff",
                payment = 70
            },
			['1'] = {
                name = "Waiter",
                payment = 85
            },
			['2'] = {
                name = "Supervisor",
                payment = 100
            },
			['3'] = {
                name = "Manger",
                payment = 115
            },
			['4'] = {
                name = "Boss",
				isboss = true,
                payment = 125
            },
        },
	},
	["judge"] = {
		label = "Honorary",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Judge",
                payment = 100
            },
        },
	},
	["lawyer"] = {
		label = "Law Firm",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Associate",
                payment = 50
            },
        },
	},
	["reporter"] = {
		label = "Reporter",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Journalist",
                payment = 50
            },
        },
	},
	["trucker"] = {
		label = "Trucker",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Driver",
                payment = 50
            },
        },
	},
	["tow"] = {
		label = "Towing",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Driver",
                payment = 50
            },
        },
	},
	["cigars"] = {
		label = "The Havana Harbour",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Tobacconist",
                payment = 50
            },
        },
	},
	["garbage"] = {
		label = "Garbage",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Collector",
                payment = 50
            },
        },
	},
	["vineyard"] = {
		label = "Vineyard",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Picker",
                payment = 50
            },
        },
	},
	["hotdog"] = {
		label = "Hotdog",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Sales",
                payment = 50
            },
        },
	},
    ["joes"] = {
		label = "Joey's Cafe",
		defaultDuty = true,
        bossmenu = vector3(319.33, -1081.25, 29.39),
		grades = {
            ['0'] = {
                name = "Waiter",
                payment = 50
            },
            ['1'] = {
                name = "Chef",
                payment = 75
            },
            ['2'] = {
                name = "Supervisor",
                payment = 100
            },
            ['3'] = {
                name = "General Manager",
                isboss = true,
                payment = 125
            },
            ['4'] = {
                name = "Owner",
                isboss = true,
                payment = 150
            },
        },
	},
    ["olsenlaywod"] = {
		label = "Olsen-Laywod Ltd",
		defaultDuty = true,
        bossmenu = vector3(92.37, -1291.78, 29.26),
		grades = {
            ['0'] = {
                name = "Employee",
                payment = 50
            },
            ['1'] = {
                name = "Employee Manager",
                payment = 80
            },
            ['2'] = {
                name = "Associate",
                payment = 50
            },
            ['3'] = {
                name = "Senior Associate",
                payment = 140
            },
            ['4'] = {
                name = "Board Member",
                isboss = true,
                payment = 140
            },
            ['5'] = {
                name = "Chief Executive Officer",
                isboss = true,
                payment = 175
            },
            ['6'] = {
                name = "Managing Director",
                isboss = true,
                payment = 350
            },
        },
	},
}