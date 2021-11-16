Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35DC453B4E
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 21:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhKPVAe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 16:00:34 -0500
Received: from mail-mw2nam12on2101.outbound.protection.outlook.com ([40.107.244.101]:41402
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229899AbhKPVAe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Nov 2021 16:00:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKFaXPSLcOAAjgg003FDAjjdkZo5KC4N3sl+Kq5pu1/88btNtJgNo8hjaO0JA45rAfnsjDDFM5cjHY72gWIDS2jGSg8Y0ZYgHhBC9igxnlRgSVGEoXWodqLzh4jaBhjucflf5ocIObtQZcEnPsC6a6bOJsL5WZY46fWtq8Ni4sWGQHhZ8GIiBuYX9c4VrOO+558qPGnvnMCUZXs5AhV1NFDOUP3d198XMmNii/Hq6STZ3t+4/YjlziIBm6Z2Urx8L9su0NVwUvEh/pF+tTou1q8XZPBj5jtn5y9lG8YrmTHSA5+UK7OvOgN56DGuXGd9E9PbBtUeZ5Xc+JGZeJsIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0GPySCWdrMgEmvktDxJpY0Fd6eTaX9rYK2TW5174rI=;
 b=El9O8X43O4+rvXWnP6+0PtXDH41CO9nn21I1vJmR3/a9GQLgCBf99a+9mn1yUI2F4l0zNmjv2F9gdzdIVeIbTwG89RJ6nMg9TndfJnEDrl1Nb88W0hVjxkGJXoRCsjCIuoc6boRsG99Ba/DeE9OZXmP3kKWHPYYcls09mIdp4Xzvqk/+gz3kZhWr0zyiXIp0k0y08rj9xkSnJQkUMIJvokauYFxn8dc9x27R7ow1sTPAv1Bdmw+sTr28PBF5oehPQyMJMr+ksdFX80xjXbbrzJxGaSDLow8l8Ef/oE3+edaVHfBuyZn++OliqdyQXfLWUEFCSJLy1O0/Zg0ud7s2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0GPySCWdrMgEmvktDxJpY0Fd6eTaX9rYK2TW5174rI=;
 b=ZxAoQkKT5OZ7j8538haD7rebSU5PCWMIeMtE2iRZj/v16MyRpYFyxvYW+5210T3OznTM4dENttG+lZEl6h5oOnPyDJdhpEFPNthS4CiO0IHZaxuzThyoHCmCM+pwL6o1FaNidagFZBfJVsNrvTJuSj+sFzcaOjnRaAcbU8QRmgA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3877.namprd13.prod.outlook.com (2603:10b6:610:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.15; Tue, 16 Nov
 2021 20:57:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 20:57:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Don't store cred in nfs_access_entry
Thread-Topic: [PATCH 0/3] Don't store cred in nfs_access_entry
Thread-Index: AQHXs/o+kAHQmJZpv06NYZRjm32M5awG7ukAgAACR4A=
Date:   Tue, 16 Nov 2021 20:57:33 +0000
Message-ID: <1b6b267598c8fcf5f50b6a118d88cf7ea938d076.camel@hammerspace.com>
References: <163278643081.17728.10586733395858659759.stgit@noble.brown>
         <163709576284.13692.2252149084412844753@noble.neil.brown.name>
In-Reply-To: <163709576284.13692.2252149084412844753@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad3c9535-cbd1-45b8-2b0e-08d9a943b695
x-ms-traffictypediagnostic: CH2PR13MB3877:
x-microsoft-antispam-prvs: <CH2PR13MB3877C823FCC8566227ECF229B8999@CH2PR13MB3877.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dr4Ng6tyydSShFDAl56JaAGjKm6X1Wm6WCMJzvlbD0JxfUwZFzn16ltWaSUF2yt1nfUEOydyBMD3AzhdkIAuUIS5g6d8LNBJzSKSq8hPzb5ZNSuU1GsJ3XaNQJF9vgpdmlF4c+UhO2fDlt3NYBnkROMx+C/pFp03kO+vhRvlo4P6h8JjjzaSjGGRrVy/K/tREtbgxpr7Mv/L9LuXUsQTyccHYTQJru4JwkqKgoa1G5Oen8uhcmZVxX//FCRLmSIvN+7wtLSRGNVck4tz2GyHSKq8ZOio4zsyvHjnXJE7pVlHFw0Hv363Q5ASuiiz51ir6QHo+7tLKdrDKIZ8xCGiHLV2nKwf/qMdi1A6y2Oui8rZkt+biOfK2/JDewcehevrev77bIlfyeHcLtEjjKVAQTZPhiNBS5iDHzAIl7gqPlTtyfIKEoZamcKkXsLXr2YXF/ijKQafTAHs7gHiRTi8L+MwxSs8Je0l3c6uyohNRfeVZ5Jp3LBWXniax9vkKJ4kCViVbrx3LbFoRqdbBmxdsyuRmbM+UMHCdyfgQTZivs39vd3Y1bITKNJIU+uxmtV5AeqMPZnOjUdW0C12izsN3luCyDuUxbj3PwPsoH1ALQEvwwkRlrI3cXRYvjT7Cy6aNzG2cp+xnbpI9+Bj4V3fc+22YXARomf9hZiT2oxZvVnDqBogGpdmXHJnh4DoSMQvypGoSqnzLN8cnLGcUcVZLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(396003)(39840400004)(36756003)(83380400001)(6506007)(66476007)(8936002)(2616005)(76116006)(6486002)(64756008)(66556008)(66446008)(26005)(8676002)(6512007)(186003)(316002)(38070700005)(66946007)(38100700002)(4326008)(5660300002)(4001150100001)(86362001)(71200400001)(122000001)(508600001)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzdPS2pURTIrcVNkNW1FWHJYOHUzSXhLK09oTlZuRnR2ODFNZ0NqNGY3Rzlx?=
 =?utf-8?B?THl6LzhPc0g2a2t6QU5UaitnVXFoWWo0N0tWSEcwMmJtUGJWeFIwNXU3cldp?=
 =?utf-8?B?L1BOMlhocTk1eUN6bFpRUFNiSVBPWnlKQk51Sk13RVdwTmVjUjV2YTRnYzFp?=
 =?utf-8?B?TEZaMHk3d3VtbWJIQnlVcFlPTk5xaSthY3RxZkQ4WHRYVU55R2hQT0xFY2VY?=
 =?utf-8?B?aU1IUTZpZmhkUjk2djdERFJtcWtFdi82V3IxQ0F1eDhrSSt2SVlyU0RiYmxp?=
 =?utf-8?B?TFd2MVdUQnZpam5vTldveTdKMVB6MU9oOXkvSWtJb1Bsa0xYa1RGekx5ekx5?=
 =?utf-8?B?LzNsYkZzOS9RTUtkb0RMUnRjcHhJN3JqdjdsRE9qTXBuc3hVTVI1TXFxS3pa?=
 =?utf-8?B?azFPUzZRUTZHVlBpU3dSOThQRXgrSFdCcUxPcnpMK041MFFzNmZ6RnVvdEox?=
 =?utf-8?B?NUxOaWN2cGdyS1RNR2hFV01selRWNXgycFpWYlVvUnlKODlKNkYrbFJPMDdR?=
 =?utf-8?B?TzNGTFRDQnJUSWo5RlBsTkVzMUhodStrc3VyTXlEcC8zV0NxMmFDZ1V1c1ox?=
 =?utf-8?B?UG9NdG1kcE9NcVhlc2pJZDB1blg0QnZSUjlOSEtQMllkbXhMb25ZQ2tjMzJW?=
 =?utf-8?B?RTZnZEx6Q3FYSTlKWVZFSDhadE5CK3FRd2M2VjQ2dXE2UVpyY2hrSjFWRDY1?=
 =?utf-8?B?N1VsekpRNmZhRXpqL2Q3OFEwbjlCYVVWNGE1N2ZHbWkyMEpDWkRBeUx2YU9q?=
 =?utf-8?B?SER6dUptZzRaajlQcFF0L09zTnlacG51UEJ1bGxKTTdQSFN3VlJyNU13QUFF?=
 =?utf-8?B?VHFGVldPcWhGNlZvM2RRRkUyRmxoNkVUTFp2STFvajNjMnBaOTRGeHBvWSts?=
 =?utf-8?B?d0RqcEk3aU00UGlwTy8yOWcyRVEvcEZNTE1MRXBDVnhsZm56eTB4THhBdVNN?=
 =?utf-8?B?MWUvbHJyR0JoT2MvYTBlYXdKNDJPNFpTUGN0bnRHeWFLd0swUktpeGFLRzV0?=
 =?utf-8?B?N01FMTlFNEJQd2xFWXNjRGRJdE4zMlJXU0I1NmFiZTRmaXZHbjF3SEhrVm5T?=
 =?utf-8?B?T1QzSkFpS20vb3FPK1hsSzMyeElxMmNnODJjcjFXTE00SSs5bnQzeitRNWtO?=
 =?utf-8?B?UE9tSlo2NkxtYlN5K1loM3RFUlpmeWg1TVdXUklvQ2tkZ0FVdExQaE9yMFBP?=
 =?utf-8?B?Y0IxbVBmblFkTGdCUFFzSHRUNlpML3ZudkVsT3FsTmxwdlkwVEhhR0RuTVVZ?=
 =?utf-8?B?Nld3aDlxZTdYQ3RNakZqUUI5clJuRWM1ZEFpVllweWdQS0ZCSGFOM3ZPYTNH?=
 =?utf-8?B?bEVTSFhyRTgxZytGMVoyOXN1VUhFVDJOVi9KTUxKNGF6Um5QeWNFWjlKK2ho?=
 =?utf-8?B?cUtGbjR3cWg2Q29MUzZGNndHWEpzQnpHTkFFdDIvakhlK3pQc21hbWs1NmZv?=
 =?utf-8?B?ZmMzTVBTS1UyT3NnZzhudjhaS2xTcGdzdDBLajhlTzRMenM3dG5kY2tUOEVZ?=
 =?utf-8?B?RDlYUXA2NE8rdFpwM1NuV2F4N1lYektXTnlIMUNjQURKWHB3QUJoVmN1MmZP?=
 =?utf-8?B?V3Vwa3NYMnJuVHI2amxzQ3pDbWdZZk81M2RwUUhtaS9kYVhWbHBsYXF2dGxk?=
 =?utf-8?B?bVViU3gydHdydjBSZmtwVnFVQy9lMFJWYlFVMlo5MWhmNUFrZjQ5ZEJ1VW1i?=
 =?utf-8?B?YzQvclpKT1VaL1JTL1lpQ25rcEdibDlmeWNGOU96LytZeFJyTmduemNvMkZV?=
 =?utf-8?B?b3lwU2hyalg3WCtpR2N4UkhGVHgrVVpmLzRKbUtwZHJ2WS9abGh0MkZEaWxw?=
 =?utf-8?B?Tkp3TksxeDdtWHdsSkZRWTBLWnRuK3I0YmRvdmhaMjJyUzFSbWVnVXhwODRD?=
 =?utf-8?B?NXd2QzZDaXdkOFBFWk50MHVzL2x5M1Bad2JmNU1aTlk1UmxqUjhFb2ljaXM0?=
 =?utf-8?B?bk9YN3dsdzV6SkdtK3RhRjAzQkJqSzg3RGVocjRBTHlNTkx6OGtVS0txTVBm?=
 =?utf-8?B?b3NmRmt3eitSelBsU2NMTlY5UmlxREhlTzRnZUJUL1V0ZVZHS2VFNXB0WjBx?=
 =?utf-8?B?QkJsWWNOUEw3S2VnT3pZWHdJWG1xZ1VLL0VMcTNoeHVZejg5MXZ4M0JycnJQ?=
 =?utf-8?B?S1ZiY242Q2lSbGk3U1Rkb0JDa015bkVuai9Qa2R6WmZzT3hYRzdXQXUwWWQy?=
 =?utf-8?Q?dOs3dADG2SUYda6CH3lXbtU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACE2E7D6330D5C4C8541518BE575E495@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3c9535-cbd1-45b8-2b0e-08d9a943b695
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 20:57:33.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axcoSo3u1xtZB4Bzs46uIhu5buQ0N7RCCAbRdSrWYzVTigmdpq2GP7pYhjY8TcR7Jf7swXFuOLuPQrbpto276g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3877
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTExLTE3IGF0IDA3OjQ5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IA0K
PiBIaSBUcm9uZC9Bbm5hLA0KPiDCoGhhdmUgeW91IGhhZCBhIGNoYW5jZSB0byBsb29rIGF0IHRo
ZXNlIHBhdGNoZXM/DQo+IA0KDQpPaCBjcmFwLi4uIEkgZGlkIHNlZSB0aG9zZSBwYXRjaGVzLCBh
bmQgaW50ZW5kZWQgdG8gcGljayB0aGVtIHVwIGZvcg0KdGhpcyBsYXN0IG1lcmdlIHdpbmRvdywg
YnV0IHNvbWVob3cgZm9yZ290IHRvIG1vdmUgdGhlbSBpbnRvIG15DQondGVzdGluZycgYnJhbmNo
Lg0KDQpBbm5hLCBjYW4geW91IHBsZWFzZSBxdWV1ZSB0aGVtIHVwIGZvciB0aGUgbmV4dCBtZXJn
ZSB3aW5kb3c/DQoNCkFwb2xvZ2llcw0KICBUcm9uZA0KDQo+IFRoYW5rcywNCj4gTmVpbEJyb3du
DQo+IA0KPiBPbiBUdWUsIDI4IFNlcCAyMDIxLCBOZWlsQnJvd24gd3JvdGU6DQo+ID4gSXQgdHVy
bnMgb3V0IHRoYXQgc3RvcmluZyBhIGNvdW50ZWQgcmVmIHRvICdzdHJ1Y3QgY3JlZCcgaW4NCj4g
PiBuZnNfYWNjZXNzX2VudHJ5IHdhc24ndCBhIGdvb2QgY2hvaWNlLg0KPiA+ICdzdHJ1Y3QgY3Jl
ZCcgY29udGFpbnMgY291bnRlZCByZWZlcmVuY2VzIHRvICdzdHJ1Y3Qga2V5JywgYW5kDQo+ID4g
dXNlcnMNCj4gPiBoYXZlIGEgcXVvdGEgb24gaG93IG1hbnkga2V5cyB0aGV5IGNhbiBoYXZlLsKg
IEtlZXBpbmcgYSBjcmVkIGluIGENCj4gPiBjYWNoZQ0KPiA+IGltcG9zZXMgb24gdGhhdCBxdW90
YS4NCj4gPiANCj4gPiBUaGUgbmZzIGFjY2VzcyBjYWNoZSBjYW4ga2VlcCBhIGxhcmdlIG51bWJl
ciBvZiBlbnRyaWVzLCBhbmQga2VlcA0KPiA+IHRoZW0NCj4gPiBpbmRlZmluaXRlbHkuwqAgVGhp
cyBjYW4gY2F1c2UgYSB1c2VyIHRvIGdvIG92ZXItcXVvdGEuDQo+ID4gDQo+ID4gVGhpcyBzZXJp
ZXMgcmVtb3ZlcyB0aGUgJ3N0cnVjdCBjcmVkIConIGZyb20gbmZzX2FjY2Vzc19lbnRyeSBhbmQN
Cj4gPiBpbnN0ZWFkIHN0b3JlcyB0aGUgdWlkLCBnaWQsIGFuZCBhIHBvaW50ZXIgdG8gdGhlIGdy
b3VwIGluZm8uDQo+ID4gVGhpcyBtYWtlcyB0aGUgbmZzX2FjY2Vzc19lbnRyeSA2NCBiaXRzIGxh
cmdlci4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gTmVpbEJyb3duDQo+ID4gDQo+ID4gLS0tDQo+
ID4gDQo+ID4gTmVpbEJyb3duICgzKToNCj4gPiDCoMKgwqDCoMKgIE5GUzogY2hhbmdlIG5mc19h
Y2Nlc3NfZ2V0X2NhY2hlZCB0byBvbmx5IHJlcG9ydCB0aGUgbWFzaw0KPiA+IMKgwqDCoMKgwqAg
TkZTOiBwYXNzIGNyZWQgZXhwbGljaXRseSBmb3IgYWNjZXNzIHRlc3RzDQo+ID4gwqDCoMKgwqDC
oCBORlM6IGRvbid0IHN0b3JlICdzdHJ1Y3QgY3JlZCAqJyBpbiBzdHJ1Y3QgbmZzX2FjY2Vzc19l
bnRyeQ0KPiA+IA0KPiA+IA0KPiA+IMKgZnMvbmZzL2Rpci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDYzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAtLS0tDQo+
ID4gwqBmcy9uZnMvbmZzM3Byb2MuY8KgwqDCoMKgwqDCoCB8wqAgNSArKy0tDQo+ID4gwqBmcy9u
ZnMvbmZzNHByb2MuY8KgwqDCoMKgwqDCoCB8IDEzICsrKysrLS0tLQ0KPiA+IMKgaW5jbHVkZS9s
aW51eC9uZnNfZnMuaMKgIHzCoCA2ICsrLS0NCj4gPiDCoGluY2x1ZGUvbGludXgvbmZzX3hkci5o
IHzCoCAyICstDQo+ID4gwqA1IGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDIyIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tDQo+ID4gU2lnbmF0dXJlDQo+ID4gDQo+ID4gDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
