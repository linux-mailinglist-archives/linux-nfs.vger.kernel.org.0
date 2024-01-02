Return-Path: <linux-nfs+bounces-868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2D822575
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 00:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8762848DB
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jan 2024 23:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C857B17982;
	Tue,  2 Jan 2024 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="H5VzvQtB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2123.outbound.protection.outlook.com [40.107.212.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1191798D
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jan 2024 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mej0Sqt5sG7XwhJmT6AOrbKUuOXKVmMnWNKrIh3lDk3s4FOBx8IblqxDIG3lpiaZ98IypUwTvdQoNLfk9jpy5JCHTH7aJQ/7iuKm1EJUiNz9QwZ2CPAeShK4WU23tDf1aiNY1UnmltWtM3s5N7BiZ/kAIldK9nia55iI50RwZzjh49GJKH9yXw/p9sTqwgji7GApVuw/tS+fG5XXSudSbZYMFC1nonadSGtkvUzzDzl1ydDfjDsSfH2wg/1c2o07J0l6e4edasU25PqVuFov9HBIbxG3L0Py5QA9QHqnn/Lfnugrthw60OsCBnPpIpzNDe9S55p4lw6z1xjZNktpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMfRIq5pmEliD64Rx2J0tKGd3J3Xy6DZiZd+iao6LMQ=;
 b=eJkfL/gibZDkKkMmqnI9KsD8eqLwk2ExzmBi4rv2TNSi5LLaOlO+6S6ccD/H9emryOyGwccQ5M/P3Po/5WoVo/Qvhq4TA6RkO/rEdAhWiKMcxRDLYCSZ9L5BKzatHOVXttqwUD02ayXuthXdEJdisZ+A5GSCFDVLbsa0ZoHS59u2iIa9WN3sIzPbCL6a+1LYL02fofHuEPVXIbPHH9N/n4l2EW+NVkjXBALlTaJAZ8quHgt3Nb5H/jauX5RoHWCpZbbgPA4DY/9kYJz5LPbCJoOvxe4YfujGtPV1Zv1amm2DCSyY6z+qKgK/m4zT/Ze5FQ0HiBU3MxpFBqlAxsMkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMfRIq5pmEliD64Rx2J0tKGd3J3Xy6DZiZd+iao6LMQ=;
 b=H5VzvQtBbxmybF0epZavStApEKkY47UAfHfdbbGkaHwyZa7gl3+uO6AGextBdVORvWKvcv7kfVhz1XO9n5bxwJ764DTDDCK9HELGRHfFXZ6PUtUYapR6QH1BTo7iqa2fDmL5Cdww0HyF/Y5nAtIbqe/D66vSP3oKmBGYxnNJX/M=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CO3PR13MB5669.namprd13.prod.outlook.com (2603:10b6:303:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Tue, 2 Jan
 2024 23:22:05 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 23:22:05 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"dan.f.shelton@gmail.com" <dan.f.shelton@gmail.com>
Subject: Re: Linux NFSv4 client: open() AlternateDataStreams via ioctl()?
Thread-Topic: Linux NFSv4 client: open() AlternateDataStreams via ioctl()?
Thread-Index: AQHaJ/UFdcXQArHlQ0O/lGmW/3OHprDF2FcAgAF8u4A=
Date: Tue, 2 Jan 2024 23:22:04 +0000
Message-ID: <325b7a5dd197589649d5236610782d5215218c9e.camel@hammerspace.com>
References:
 <CAAvCNcA9R5ChZ3pXN689A=pZ_bffX3vZRvk-DUsSgT2WW7T2Fg@mail.gmail.com>
	 <CAAvCNcByc-qNeNqT-0YeuiyzEpBY79=VjVdSFDh+_hahWGEtgw@mail.gmail.com>
In-Reply-To:
 <CAAvCNcByc-qNeNqT-0YeuiyzEpBY79=VjVdSFDh+_hahWGEtgw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CO3PR13MB5669:EE_
x-ms-office365-filtering-correlation-id: 6e30a299-ab33-4824-5972-08dc0be9a1c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H1lodYenCJ19wXonyIpFhvCkY7FPB5+o4T1TCSl1J520RO/wRH85PZ8l2Jt5rnWjBnac2VsogOq65PUV8z0/GHKzAo2cyeT6GMIP8NGZsgRr6MSnjUc+WusvGqx5L0NvQBWz4SzYSeOQ93BVYpAo1039aqm0MRZeaQWz/S7b9Gy9gMPnLBFSgYzeaAmIJGBR14bR7dHRacLcWuKnVCZzTign+npNi+uTelDgMnkrSa3pz0Jor7W7bD268Cwl0kR7Urn/NROR+o8ZdvQ0T6B5QfXhiZt6NELfz1vxTvXRfesp91klZ/BhYQoKzlrCjhKWgxOSvmwVhp3Ppcpk9VgRphkoUxNSC0Ys6UXv0I4Tgx71OC6PLKAfFtcaF/0+fSwC09zPEwI/WQ1cfJ4QPNuQ9I7EBUl6gJ/93vBCJGqkJChy/thMEGWY2ndBFW5B36ttuLE99ISqgDG7Fj86rlJhaFGYyDmWbHXeg/BuHEmqizp0zTU5ElTC4mSYx1cWcf+yuj60k3dQlgXP7OVNp6TAjP4JRy1lMSP5lgQZJIXEejrEzixH8xyZVxQ9+yfggyZH/g6QmI+7496vHeJywKTijnDxQjHh8Q5YdfJB5aIRDnAWVAPVWuINfMKCnf8UPT91CS+/FgdzMw033dCBm64jnaeT1fawKzEEv11QSMRmsqeVOlzod3w9oiYBvT3M2uA82f/skCKptPxPgkLNSP897Lj4iTnfpOrbpP/RMTax7rsXd+8dWHsGQvEdPn3ncl2B
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39840400004)(230922051799003)(230173577357003)(230473577357003)(230273577357003)(230373577357003)(1800799012)(64100799003)(186009)(451199024)(2616005)(6512007)(83380400001)(6506007)(86362001)(36756003)(38070700009)(38100700002)(5660300002)(2906002)(4744005)(66446008)(41300700001)(76116006)(478600001)(66476007)(122000001)(66946007)(66556008)(110136005)(8676002)(6486002)(8936002)(966005)(316002)(71200400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWQ1cUFwU1FCeDlUblVId3BJMHFiV0F4NEhvVE4yQ3NaZDdFZXQzTEtnRXNw?=
 =?utf-8?B?UWk5Q0VQbFp2M21ScUlpTnJBRnpUa3kzWVNSeXliRk5jYnRVTW5UT1RCVE9K?=
 =?utf-8?B?WGQ1YWVGVFEwVkV5MU1idFAxQlFRMFJraUhmZWVOMHJ5Qmt4NE4rY0thMUJw?=
 =?utf-8?B?Qm1NQjhmOTJlZnJQQmc3WEJQa056dHdZOFp0YkwyNC9ENjBPVC9WRVRXTHNB?=
 =?utf-8?B?eXpKd1lPZnFqaVNHeVQvd00xTDRiZXBKNys4T2NqK2NnaDJBWm1pRk9YYVdK?=
 =?utf-8?B?OEZNcFRVUUIvRTZjY0t2TVRHWDdNMDN3TDVpNkpXLzRuWng2RHNVVnBpVFls?=
 =?utf-8?B?c1U1SGFucm0rMTIxWms4QjBGUHdJMU5vWWFZditoeWZtM1NCWk1BbWFOUjhh?=
 =?utf-8?B?Mkhjb3lVZmM3NEUvdkNudGRRRGwvWmtweUEzbHdGaDNxSDBNUTdId0htZ2JI?=
 =?utf-8?B?S1FiSm1XWEZoNkJOOTNlbE11S2NZMWVFTkxoU2xQMFIwY2NBdk5DR2dhNUlm?=
 =?utf-8?B?SjdBYnFQWDUxZEI4SUc4ZXByRGNLYUlYcGZzMXdkVHJURENKcG41aFp6QzZU?=
 =?utf-8?B?c1N5bmdiSFB4RFUzN3krMHQ2bGJNUUxKbmlrZ0hEdGxNamx5QkhuUXdzb1dS?=
 =?utf-8?B?RzRCQUxPYUxBL3I2ZUJzQm1jcE1RQVZtSlpGcWRnSnJoazZIRFlJRkt3d3Bv?=
 =?utf-8?B?WU5xeFVVK2RDYmpvaU15YkRZQ1FzWVN3UUpRT0ZvZi9HUFQxYWtRNG1ndzQ0?=
 =?utf-8?B?aTZLa0xGQk1XM2Rxdm5tMFkyMFRUYlpSdFBrbC8xdFVoeDdCc1JSL0Nmcjkx?=
 =?utf-8?B?azVRc0FXd1NEaDVCOURWMDBzY0VLOWplQTVKUDMvYzN4NW1lV1NpYVBuRTF1?=
 =?utf-8?B?c0dRSi9aOXZzSktURGNnR3I3MU5HOXpKdTcwR0dxSUxGMnVrZCt5V2NtekFp?=
 =?utf-8?B?bHpObVBzeTMyRXFzN2YvWnRxWUNsT0I4RzROQzNpcVE3azBNbi9WVzhMUDlY?=
 =?utf-8?B?REJLVUE0eTM2ci85dVdKR2VnRklEVEZiMFlUK3M2YXVjWWVJeFZDUFBkdUFr?=
 =?utf-8?B?NU9NdCtDbVA0UEtkTGs1bmFZMHF5ZldsM0RhZExidytRQ1dFRGlrWnlDWFlz?=
 =?utf-8?B?Vy9IeXI1c0pFVkxrejFCeXZ4cmYvc1hmL0RyZVhsRkY5dzYra2U4S0w3UkZ5?=
 =?utf-8?B?bXpwVXpoMUdKNDM0NlBxT1hQbllneFIrdFZhS0JKTDgxdzlod0NlczU3Qk5G?=
 =?utf-8?B?eklSem1hVnFNUFkxS0d4OHovZ3Zmd210OGNsZTd0SENaMmd1MTkyWC9DSmo1?=
 =?utf-8?B?WEMzOUdSSForWGRhYzBUdVJyTmpyeXlRNm9MTUlObzNoU3l6dUo4UzFaUVBF?=
 =?utf-8?B?cEg3UWc3NnkrMmtUd2xNUmVCemsxZXJMRGNkNXl4WjFPZ1NiM1BVWGZxYjVZ?=
 =?utf-8?B?RVZXOERLVUtSdFV0WG43U0RCL0JZcVh1cFp2azRIT1hBYS9yWWpydlFoR1lo?=
 =?utf-8?B?VkNURUpZRHhRMkZkdTJlMWdNTktVSm5BVWZYSzQ2cDdNOVZhTDVxaUV2S0JE?=
 =?utf-8?B?eWZjZlY2RmUva0pIc1dJS2IzdWVPL05GamwyM0c4OVorS0VzeVM4SFNEZC8y?=
 =?utf-8?B?SzMzQ1NNZ3l3Yk5DNTR1WlNQQTYyMzd2NkxseE5qOGlYQUJuTEo4ZGpTdi9Z?=
 =?utf-8?B?YkFyaXgvZVZOeGNNbm5hZmhsQ3lsL25BZTRkTURRQWxrRVFLMk5JZUxTRWdD?=
 =?utf-8?B?cVA2Wnd0enQwZmYrZUt1WmtrS0JZc0NGR0JlMlV6cm5LMy9WRTdOLzNqU2Vz?=
 =?utf-8?B?a0dOR1hLdEVhYkVnMFVwUy91UzA4QTJVckhwd3h5MGVmQWkxbXZ4dHh6M3lO?=
 =?utf-8?B?VFlvN2VaOXVEMk1wN0U4WU5QeVV5bldFbTNhenM0ZWFWZGlhS1VMamtRTTRL?=
 =?utf-8?B?VkFFM0UzeFVZQVA4Y2VMY3Jad1RSRERJSzQ1OGZaRjhUUkpId1RrTW5Ta2pX?=
 =?utf-8?B?bEwrTTZQanluL1FZei9hYjF2dmVSN200MW1NWHRoOG5XTTdxNWQ0TWU4Slpq?=
 =?utf-8?B?b1dKRU9TUE1kWmVTQVBRWnZuNTV2aU02bzBQTFZBMmE0NzQ5M2EvTUlLamxM?=
 =?utf-8?B?UHlOblJpTWlHQXNxNjZyenZ6MDE2WEp1Y2ZYVlpuazBqSzRiUzNPWFVodW4v?=
 =?utf-8?B?NDlYbnpkUVZxV0VEakhwQk5GWEk3S1h6UUkrVWpFSDBsbjFjNTY5aWszb0c2?=
 =?utf-8?B?WEMyWllWSW5vZEFFL1RYK2lPSXZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <558596329A6C5B4C8130C1D3DD1F16EA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e30a299-ab33-4824-5972-08dc0be9a1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 23:22:04.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+Ofp4uLig2TX5hrK9J/UiI3dbNMzWnUOuJp8qM2welDe+w4/2J8Qm54MqGn6BpmKi0mPko88wWKGVll6DmpJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5669

T24gVHVlLCAyMDI0LTAxLTAyIGF0IDAxOjM5ICswMTAwLCBEYW4gU2hlbHRvbiB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkYW4uZi5zaGVsdG9uQGdtYWlsLmNvbS4g
TGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4gPw0KPiANCj4gT24gV2VkLCA2IERlYyAy
MDIzIGF0IDA0OjMzLCBEYW4gU2hlbHRvbiA8ZGFuLmYuc2hlbHRvbkBnbWFpbC5jb20+DQo+IHdy
b3RlOg0KPiA+IA0KPiA+IEhlbGxvIQ0KPiA+IFdlIGtub3cgdGhhdCBMaW51eCB3aWxsIG5ldmVy
IGltcGxlbWVudCBBbHRlcm5hdGVEYXRhU3RyZWFtcywgYnV0DQo+ID4gYXMNCj4gPiB3ZSBuZWVk
IGl0IGFuZCBuZWVkIGFjY2VzcyB0byB0aGVzZSBkYXRhLCBjb3VsZCB0aGUgTGludXggTkZTdjQN
Cj4gPiBjbGllbnQNCj4gPiBhZGQgYSBpb2N0bCgpIHRvIHJlcXVlc3QgYSBmZCB0byBhbiBBRFM/
DQoNCkFuIGlvY3RsKCkgd291bGQgcmVxdWlyZSB5b3UgdG8gaGF2ZSBwZXJtaXNzaW9uIHRvIG9w
ZW4gdGhlIGZpbGUgYmVmb3JlDQp5b3Ugd291bGQgYmUgYWxsb3dlZCB0byB0cnkgdG8gYWNjZXNz
IHRoZSBuYW1lZCBhdHRyaWJ1dGUgZGlyZWN0b3J5DQood2hpY2ggZGVwZW5kcyBvbiBhIHNlcGFy
YXRlIHNldCBvZiBwZXJtaXNzaW9ucyBpbiB0aGUgTkZTdjQgQUNMDQptb2RlbCkuIEkgZG9uJ3Qg
c2VlIHdoeSB3ZSB3b3VsZCBkZWxpYmVyYXRlbHkgYWRkIGFuIGltcGxlbWVudGF0aW9uDQp0aGF0
IGlzIGJyb2tlbi4NCg0KSWYgd2UgbmVlZCB0byBhZGQgc3VwcG9ydCBmb3IgTkZTdjQgbmFtZWQg
YXR0cmlidXRlcywgdGhlbiB3ZSBzaG91bGQNCmhhdmUgYSBkaXNjdXNzaW9uIGFib3V0IGFkZGlu
ZyBzdXBwb3J0IGZvciB0aGUgT19YQVRUUiBmbGFnLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==

