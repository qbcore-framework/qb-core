QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 10
            },
        },
	},
    ["police"] = {
		label = 'Law Enforcement',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Officer',
                payment = 75
            },
			['2'] = {
                name = 'Sergeant',
                payment = 100
            },
			['3'] = {
                name = 'Lieutenant',
                payment = 125
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
 --[[       ["Locations"] = {
            ["duty"] = {
                [1] = vector3(440.085, -974.924, 30.689),
                [2] = vector3(-449.811, 6012.909, 31.815),
            },
            ["aircraft"] = {
                [1] = vector4(449.168, -981.325, 43.691, 87.234),
                [2] = vector4(-475.43, 5988.353, 31.716, 31.34),
            },
            ["landcraft"] = {
                [1] = vector4(448.159, -1017.41, 28.562, 90.654),
                [2] = vector4(471.13, -1024.05, 28.17, 274.5),
                [3] = vector4(-455.39, 6002.02, 31.34, 87.93),
            },
            ["watercraft"] = {
            },
            ["stash"] = {
                [1] = vector3(453.075, -980.124, 30.889),
            },
            ["impound"] = {
                [1] = vector3(436.68, -1007.42, 27.32),
                [2] = vector3(-436.14, 5982.63, 31.34),
            },
            ["armory"] = {
                [1] = vector3(462.23, -981.12, 30.68),
            },
            ["trash"] = {
                [1] = vector3(439.0907, -976.746, 30.776),
            },
            ["fingerprint"] = {
                [1] = vector3(460.9667, -989.180, 24.92),
            },
            ["evidence"] = {
                [1] = vector3(442.1722, -996.067, 30.689),
                [2] = vector3(451.7031, -973.232, 30.689),
                [3] = vector3(455.1456, -985.462, 30.689),
            },
            ["stations"] = {
                [1] = {label = "Police Station", coords = vector4(428.23, -984.28, 29.76, 3.5)},
                [2] = {label = "Prison", coords = vector4(1845.903, 2585.873, 45.672, 272.249)},
                [3] = {label = "Police Station Paleto", coords = vector4(-451.55, 6014.25, 31.716, 223.81)},
            },
        },
        ["vehicles"] = {
            ["aircraft"] = {

            },
            ["landcraft"] = {

            },
            ["watercraft"]= {

            },
        },
        ["items"] = {
            ["stash"] = {

            },
            ["armory"] = {
                label = "Police Armory",
                slots = 30,
                items = {
                    [1] = {
                        name = "weapon_pistol",
                        price = 0,
                        amount = 1,
                        info = {
                            serie = "",
                            attachments = {
                                {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                            }
                        },
                        type = "weapon",
                        slot = 1,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [2] = {
                        name = "weapon_stungun",
                        price = 0,
                        amount = 1,
                        info = {
                            serie = "",
                        },
                        type = "weapon",
                        slot = 2,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [3] = {
                        name = "weapon_pumpshotgun",
                        price = 0,
                        amount = 1,
                        info = {
                            serie = "",
                            attachments = {
                                {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                            }
                        },
                        type = "weapon",
                        slot = 3,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [4] = {
                        name = "weapon_smg",
                        price = 0,
                        amount = 1,
                        info = {
                            serie = "",
                            attachments = {
                                {component = "COMPONENT_AT_SCOPE_MACRO_02", label = "1x Scope"},
                                {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                            }
                        },
                        type = "weapon",
                        slot = 4,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [5] = {
                        name = "weapon_carbinerifle",
                        price = 0,
                        amount = 1,
                        info = {
                            serie = "",
                            attachments = {
                                {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                                {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                            }
                        },
                        type = "weapon",
                        slot = 5,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [6] = {
                        name = "weapon_nightstick",
                        price = 0,
                        amount = 1,
                        info = {},
                        type = "weapon",
                        slot = 6,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [7] = {
                        name = "pistol_ammo",
                        price = 0,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 7,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [8] = {
                        name = "smg_ammo",
                        price = 0,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 8,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [9] = {
                        name = "shotgun_ammo",
                        price = 0,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 9,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [10] = {
                        name = "rifle_ammo",
                        price = 0,
                        amount = 5,
                        info = {},
                        type = "item",
                        slot = 10,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [11] = {
                        name = "handcuffs",
                        price = 0,
                        amount = 1,
                        info = {},
                        type = "item",
                        slot = 11,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [12] = {
                        name = "weapon_flashlight",
                        price = 0,
                        amount = 1,
                        info = {},
                        type = "weapon",
                        slot = 12,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [13] = {
                        name = "empty_evidence_bag",
                        price = 0,
                        amount = 50,
                        info = {},
                        type = "item",
                        slot = 13,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [14] = {
                        name = "police_stormram",
                        price = 0,
                        amount = 50,
                        info = {},
                        type = "item",
                        slot = 14,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [15] = {
                        name = "armor",
                        price = 0,
                        amount = 50,
                        info = {},
                        type = "item",
                        slot = 15,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [16] = {
                        name = "radio",
                        price = 0,
                        amount = 50,
                        info = {},
                        type = "item",
                        slot = 16,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    },
                    [17] = {
                        name = "heavyarmor",
                        price = 0,
                        amount = 50,
                        info = {},
                        type = "item",
                        slot = 17,
                        authorizedJobGrades = {0, 1, 2, 3, 4}
                    }
                }

            },
            ["landcraft"] = {
                [1] = {
                    name = "heavyarmor",
                    amount = 2,
                    info = {},
                    type = "item",
                    slot = 1,
                },
                [2] = {
                    name = "empty_evidence_bag",
                    amount = 10,
                    info = {},
                    type = "item",
                    slot = 2,
                },
                [3] = {
                    name = "police_stormram",
                    amount = 1,
                    info = {},
                    type = "item",
                    slot = 3,
                },
            },
            ["landcraft-gove"] = {

            },
            ["aircraft"] = {
                [1] = {
                    name = "heavyarmor",
                    amount = 2,
                    info = {},
                    type = "item",
                    slot = 1,
                },
                [2] = {
                    name = "empty_evidence_bag",
                    amount = 10,
                    info = {},
                    type = "item",
                    slot = 2,
                },
                [3] = {
                    name = "police_stormram",
                    amount = 1,
                    info = {},
                    type = "item",
                    slot = 3,
                },
            },
            ["aircraft-gove"] = {

            },
            ["watercraft"] = {
                [1] = {
                    name = "heavyarmor",
                    amount = 2,
                    info = {},
                    type = "item",
                    slot = 1,
                },
                [2] = {
                    name = "empty_evidence_bag",
                    amount = 10,
                    info = {},
                    type = "item",
                    slot = 2,
                },
                [3] = {
                    name = "police_stormram",
                    amount = 1,
                    info = {},
                    type = "item",
                    slot = 3,
                },
            },
            ["watercraft-gove"] = {

            },
        }, --]]
    },
    ['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Paramedic',
                payment = 75
            },
			['2'] = {
                name = 'Doctor',
                payment = 100
            },
			['3'] = {
                name = 'Surgeon',
                payment = 125
            },
			['4'] = {
                name = 'Chief',
				isboss = true,
                payment = 150
            },
        },
	},
    ['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'House Sales',
                payment = 75
            },
			['2'] = {
                name = 'Business Sales',
                payment = 100
            },
			['3'] = {
                name = 'Broker',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
    ['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Driver',
                payment = 75
            },
			['2'] = {
                name = 'Event Driver',
                payment = 100
            },
			['3'] = {
                name = 'Sales',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
    ['bus'] = {
       label = 'Bus',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Driver',
               payment = 50
           },
       },
   },
   ['cardealer'] = {
       label = 'Vehicle Dealer',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Recruit',
               payment = 50
           },
           ['1'] = {
               name = 'Showroom Sales',
               payment = 75
           },
           ['2'] = {
               name = 'Business Sales',
               payment = 100
           },
           ['3'] = {
               name = 'Finance',
               payment = 125
           },
           ['4'] = {
               name = 'Manager',
               isboss = true,
               payment = 150
           },
       },
   },
   ['mechanic'] = {
       label = 'Mechanic',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Recruit',
               payment = 50
           },
           ['1'] = {
               name = 'Novice',
               payment = 75
           },
           ['2'] = {
               name = 'Experienced',
               payment = 100
           },
           ['3'] = {
               name = 'Advanced',
               payment = 125
           },
           ['4'] = {
               name = 'Manager',
               isboss = true,
               payment = 150
           },
       },
   },
   ['judge'] = {
       label = 'Honorary',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Judge',
               payment = 100
           },
       },
   },
   ['lawyer'] = {
       label = 'Law Firm',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Associate',
               payment = 50
           },
       },
   },
   ['reporter'] = {
       label = 'Reporter',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Journalist',
               payment = 50
           },
       },
   },
   ['trucker'] = {
       label = 'Trucker',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Driver',
               payment = 50
           },
       },
   },
   ['tow'] = {
       label = 'Towing',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Driver',
               payment = 50
           },
       },
   },
   ['garbage'] = {
       label = 'Garbage',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Collector',
               payment = 50
           },
       },
   },
   ['vineyard'] = {
       label = 'Vineyard',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Picker',
               payment = 50
           },
       },
   },
   ['hotdog'] = {
       label = 'Hotdog',
       defaultDuty = true,
       offDutyPay = false,
       grades = {
           ['0'] = {
               name = 'Sales',
               payment = 50
           },
       },
   },
}