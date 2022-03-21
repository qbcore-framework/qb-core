-- Jobs
QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civil',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 20
            },
        },
	},
	['police'] = {
		label = 'LSPD',
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = 'Recrue',
                payment = 75
            },
			['1'] = {
                name = 'Officer',
                payment = 120
            },
			['2'] = {
                name = 'Sergeant',
                payment = 500
            },
			['3'] = {
                name = 'Lieutenant',
                payment = 750
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 1250
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = 'Recrue',
                payment = 100
            },
			['1'] = {
                name = 'Paramedic',
                payment = 175
            },
			['2'] = {
                name = 'Doctor',
                payment = 600
            },
			['3'] = {
                name = 'Surgeon',
                payment = 850
            },
			['4'] = {
                name = 'Chief Doctor',
				isboss = true,
                payment = 1000
            },
        },
	},
	['realestate'] = {
		label = 'Agent Immobilier',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recrue',
                payment = 50
            },
			['1'] = {
                name = 'Employé',
                payment = 75
            },
			['2'] = {
                name = 'Employé Confirmé',
                payment = 100
            },
			['3'] = {
                name = 'Manager',
                payment = 125
            },
			['4'] = {
                name = 'PDG',
				isboss = true,
                payment = 150
            },
        },
	},
    ["burgershot"] = {
		label = "Burgershot",
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = "Recrue",
                payment = 50
            },
			['1'] = {
                name = "Employé",
                payment = 75
            },
			['2'] = {
                name = "Employé confirmé",
                payment = 100
            },
			['3'] = {
                name = "Manager",
                payment = 125
            },
			['4'] = {
                name = "PDG",
				isboss = true,
                payment = 150
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = 'Recrue',
                payment = 40
            },
			['1'] = {
                name = 'Employé',
                payment = 80
            },
			['2'] = {
                name = 'Employé confirmé',
                payment = 100
            },
			['3'] = {
                name = 'Manager',
                payment = 125
            },
			['4'] = {
                name = 'PDG',
				isboss = true,
                payment = 150
            },
        },
	},
	['cardealer'] = {
		label = 'Concessionnaire',
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = 'Recrue',
                payment = 50
            },
			['1'] = {
                name = 'Employé',
                payment = 75
            },
			['2'] = {
                name = 'Employé confirmé',
                payment = 100
            },
			['3'] = {
                name = 'Manager',
                payment = 125
            },
			['4'] = {
                name = 'PDG',
				isboss = true,
                payment = 150
            },
        },
	},
	['mechanic'] = {
		label = 'Mécano',
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = 'Recrue',
                payment = 80
            },
			['1'] = {
                name = 'Employé',
                payment = 100
            },
			['2'] = {
                name = 'Employé Confirmé',
                payment = 120
            },
			['3'] = {
                name = 'Manager',
                payment = 150
            },
			['4'] = {
                name = 'PDG',
				isboss = true,
                payment = 175
            },
        },
	},
	['judge'] = {
		label = 'Juge',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Juge',
                payment = 500
            },
        },
	},
	['lawyer'] = {
		label = 'Avocat',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Associé',
                payment = 120
            },
        },
	},
	['reporter'] = {
		label = 'Weazel-News',
		defaultDuty = false,
		grades = {
            ['0'] = {
                name = 'Journaliste',
                payment = 65
            },
            ['1'] = {
                name = 'PDG',
                payment = 80
            },
        },
	},
	['trucker'] = {
		label = 'Camionneur',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employé',
                payment = 20
            },
        },
	},
	['tow'] = {
		label = 'Dépanneur',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employé',
                payment = 20
            },
        },
	},
    ['bus'] = {
		label = 'Conducteur de Bus',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employé',
                payment = 20
            },
        },
	},
	['garbage'] = {
		label = 'Éboueur',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employé',
                payment = 20
            },
        },
	},
	['vineyard'] = {
		label = 'Vigneron',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employé',
                payment = 20
            },
        },
	},
	['hotdog'] = {
		label = 'Hot-dog',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employé',
                payment = 20
            },
        },
	},
}