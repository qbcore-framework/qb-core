QBShared = QBShared or {}
QBShared.Jobs = {
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
        incityhall = true, -- true lists job inside city hall
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
		["Locations"] = {
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
			["impound"] = { -- copy vector3 info for  from qb-garages/config.inc
				[1] = vector3(436.68, -1007.42, 27.32),
				[2] = vector3(-436.14, 5982.63, 31.34),
			},
			["armory"] = {
				[1] = vector3(462.23, -981.12, 30.68),
			},
			["clothingrooms"] = {
				[1] = {requiredJob = 'police', isGang = false, coords = vector3(454.43, -988.85, 30.69), width = 2, length = 2, cameraLocation = vector4(454.42, -990.52, 30.69, 358.48)},
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
        ["authorized-vehicles"] = {
			["aircraft"] = {
                [0] = {
                }
                [1] = {
                }
                [2] = {
                }
                [3] = {
                }
                [4] = {
                    ['POLMOV'] = "Police Maverick",
                }
			},
			["landcraft"] = {
				-- Grade 0
				[0] = {
					["police"] = "Police Car 1",
					["police2"] = "Police Car 2",
					["police3"] = "Police Car 3",
					["police4"] = "Police Car 4",
					["policeb"] = "Police Car 5",
					["policet"] = "Police Car 6",
					["sheriff"] = "Sheriff Car 1",
					["sheriff2"] = "Sheriff Car 2",
				},
				-- Grade 1
				[1] = {
					["police"] = "Police Car 1",
					["police2"] = "Police Car 2",
					["police3"] = "Police Car 3",
					["police4"] = "Police Car 4",
					["policeb"] = "Police Car 5",
					["policet"] = "Police Car 6",
					["sheriff"] = "Sheriff Car 1",
					["sheriff2"] = "Sheriff Car 2",
				},
				-- Grade 2
				[2] = {
					["police"] = "Police Car 1",
					["police2"] = "Police Car 2",
					["police3"] = "Police Car 3",
					["police4"] = "Police Car 4",
					["policeb"] = "Police Car 5",
					["policet"] = "Police Car 6",
					["sheriff"] = "Sheriff Car 1",
					["sheriff2"] = "Sheriff Car 2",
				},
				-- Grade 3
				[3] = {
					["police"] = "Police Car 1",
					["police2"] = "Police Car 2",
					["police3"] = "Police Car 3",
					["police4"] = "Police Car 4",
					["policeb"] = "Police Car 5",
					["policet"] = "Police Car 6",
					["sheriff"] = "Sheriff Car 1",
					["sheriff2"] = "Sheriff Car 2",
				},
				-- Grade 4
				[4] = {
					["police"] = "Police Car 1",
					["police2"] = "Police Car 2",
					["police3"] = "Police Car 3",
					["police4"] = "Police Car 4",
					["policeb"] = "Police Car 5",
					["policet"] = "Police Car 6",
					["sheriff"] = "Sheriff Car 1",
					["sheriff2"] = "Sheriff Car 2",
				}
			},
			["watercraft"] = {
                [0] = {
                    ['predator'] = 'Predator Boat',
                },
                [1] = {
                    ['predator'] = 'Predator Boat',
                },
                [2] = {
                    ['predator'] = 'Predator Boat',
                },
                [3] = {
                    ['predator'] = 'Predator Boat',
                },
                [4] = {
                    ['predator'] = 'Predator Boat',
                },
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
			["landcraft-cargo"] = {
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
			["landcraft-glove"] = {

			},
			["aircraft-cargo"] = {
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
			["aircraft-glove"] = {
			},
            ["watercraft-cargo"] = {
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
            ["watercraft-glove"] = {
            },
		},
		['uniforms'] = {
			-- Job
			['male'] = {
				-- Gender
				[0] = {
					-- Grade Level
					[1] = {
						-- Outfits
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 19, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 55, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 3}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					}
				},
				[1] = {
					-- Grade Level
					[1] = {
						-- Outfits
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 19, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 55, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 3}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					}
				},
				[2] = {
					-- Grade Level
					[1] = {
						-- Outfits
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 19, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 55, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 3}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[4] = {
						outfitLabel = 'Trooper Black',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 8}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 3}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					}
				},
				[3] = {
					-- Grade Level
					[1] = {
						-- Outfits
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 19, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 55, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 3}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[4] = {
						outfitLabel = 'Trooper Black',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 8}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 3}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[5] = {
						outfitLabel = 'SWAT',
						outfitData = {
							['pants'] = {item = 130, texture = 1}, -- Pants
							['arms'] = {item = 172, texture = 0}, -- Arms
							['t-shirt'] = {item = 15, texture = 0}, -- T Shirt
							['vest'] = {item = 15, texture = 2}, -- Body Vest
							['torso2'] = {item = 336, texture = 3}, -- Jacket
							['shoes'] = {item = 24, texture = 0}, -- Shoes
							['accessory'] = {item = 133, texture = 0}, -- Neck Accessory
							['hat'] = {item = 150, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 52, texture = 0} -- Mask
						}
					}
				},
				[4] = {
					-- Grade Level
					[1] = {
						-- Outfits
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 19, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 55, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 0}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = -1, texture = -1}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 3}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[4] = {
						outfitLabel = 'Trooper Black',
						outfitData = {
							['pants'] = {item = 24, texture = 0}, -- Pants
							['arms'] = {item = 20, texture = 0}, -- Arms
							['t-shirt'] = {item = 58, texture = 0}, -- T Shirt
							['vest'] = {item = 0, texture = 0}, -- Body Vest
							['torso2'] = {item = 317, texture = 8}, -- Jacket
							['shoes'] = {item = 51, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 58, texture = 3}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[5] = {
						outfitLabel = 'SWAT',
						outfitData = {
							['pants'] = {item = 130, texture = 1}, -- Pants
							['arms'] = {item = 172, texture = 0}, -- Arms
							['t-shirt'] = {item = 15, texture = 0}, -- T Shirt
							['vest'] = {item = 15, texture = 2}, -- Body Vest
							['torso2'] = {item = 336, texture = 3}, -- Jacket
							['shoes'] = {item = 24, texture = 0}, -- Shoes
							['accessory'] = {item = 133, texture = 0}, -- Neck Accessory
							['hat'] = {item = 150, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 52, texture = 0} -- Mask
						}
					}
				}
			},
			['female'] = {
				-- Gender
				[0] = {
					-- Grade Level
					[1] = {
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 48, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 3}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					}
				},
				-- Gender
				[1] = {
					-- Grade Level
					[1] = {
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 48, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 3}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					}
				},
				-- Gender
				[2] = {
					-- Grade Level
					[1] = {
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 48, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 3}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[4] = {
						outfitLabel = 'Trooper Black',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 8}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					}
				},
				-- Gender
				[3] = {
					-- Grade Level
					[1] = {
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 48, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 3}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[4] = {
						outfitLabel = 'Trooper Black',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 8}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[5] = {
						outfitLabel = 'Swat',
						outfitData = {
							['pants'] = {item = 135, texture = 1}, -- Pants
							['arms'] = {item = 213, texture = 0}, -- Arms
							['t-shirt'] = {item = 0, texture = 0}, -- T Shirt
							['vest'] = {item = 17, texture = 2}, -- Body Vest
							['torso2'] = {item = 327, texture = 8}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 102, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 149, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 35, texture = 0} -- Mask
						}
					}
				},
				-- Gender
				[4] = {
					-- Grade Level
					[1] = {
						outfitLabel = 'Short Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 48, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[2] = {
						outfitLabel = 'Long Sleeve',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 0}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[3] = {
						outfitLabel = 'Trooper Tan',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 3}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[4] = {
						outfitLabel = 'Trooper Black',
						outfitData = {
							['pants'] = {item = 133, texture = 0}, -- Pants
							['arms'] = {item = 31, texture = 0}, -- Arms
							['t-shirt'] = {item = 35, texture = 0}, -- T Shirt
							['vest'] = {item = 34, texture = 0}, -- Body Vest
							['torso2'] = {item = 327, texture = 8}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 0, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 0, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 0, texture = 0} -- Mask
						}
					},
					[5] = {
						outfitLabel = 'Swat',
						outfitData = {
							['pants'] = {item = 135, texture = 1}, -- Pants
							['arms'] = {item = 213, texture = 0}, -- Arms
							['t-shirt'] = {item = 0, texture = 0}, -- T Shirt
							['vest'] = {item = 17, texture = 2}, -- Body Vest
							['torso2'] = {item = 327, texture = 8}, -- Jacket
							['shoes'] = {item = 52, texture = 0}, -- Shoes
							['accessory'] = {item = 102, texture = 0}, -- Neck Accessory
							['bag'] = {item = 0, texture = 0}, -- Bag
							['hat'] = {item = 149, texture = 0}, -- Hat
							['glass'] = {item = 0, texture = 0}, -- Glasses
							['mask'] = {item = 35, texture = 0} -- Mask
						}
					}
				}
			}
		},
	},
}