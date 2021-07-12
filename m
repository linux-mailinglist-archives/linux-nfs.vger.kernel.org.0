Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE73C624D
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhGLSGL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 14:06:11 -0400
Received: from mail-mw2nam10on2113.outbound.protection.outlook.com ([40.107.94.113]:57312
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229907AbhGLSGK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 14:06:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEgg2Q3EPGXSNfCJUOdZ7abwdrndD28KiMqTVyJgUv4XiV9rVIecDJ880v/VJC/FRT7kaOFwTY5+r5T3fKQsDyVa+Ps5XMzQjt9wV0aZ7Z+tiIP0yMJT1B2nKkN4Q+Rx4IFSBodTP7tHPyPivwx2Ivq6gTMpOy9JcOkJkXkR8AiwP7UvkwHr/ZRo9OaA/oRNTjY0cH7LEjn/1lu+HkJ5QQKbkohxnUq+SP5HSzJjoOEWRGlvTsPdg0nCwXmjD+FTRTwiASMzMWrON70MoY94SdZyoy0dKP/P76fuzPEk9hrVPzDT/xSjg4jGAh68ZJs9kswNQYHIbDiY22Dk6sCE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvNACu5KkeNqZYBmlFtgkmpHpuxsRtVugL8ich3CmMo=;
 b=OSoJuWTUt4LvuOMrH0FMyCfg/qBFDVrheXKJGP5z0CamLBn6nDuBi+o3lpuQXfIH/PYej1iljDiarFL8mHP8BFmad/pRXttC9wwL5vW1QflE68X3f9hgv1+mlsEaZDxQqvOVki51DOUhoLRAacRScn8UH//cRNnJce6fD8b0McrkIgP8ZV+YLezwwZt2S+cxRjg30uqPL0fz6Hyzmq0y9jsINowgaLI3+/bVqG0JH2/Ji+4GqTH7HC7F1Bm3IRY8zANVCfUOwMu8JhPIVG73lEQjZj+SAW5dZ2jRopdQcVLmfRO+WyLfWiLjIsSksZn+Bcuy9ZKHju8DjvqrBhK3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvNACu5KkeNqZYBmlFtgkmpHpuxsRtVugL8ich3CmMo=;
 b=EjQOFM1hhm+3P4bh/bnd24dGQECRkVXTARrHgeOoQyDw86OkkhdItbSErWknVgbw7UqtffrqB/ToMSq1xqrb2FJZBPgSr3PkNT/se3fpZIC0YrFQBoSRbV7nSOt39S3gpy80uJo7fBRwK93QMKfWCZKwLmZDlSK1ubbd9rKd6yw=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB5154.namprd13.prod.outlook.com (2603:10b6:610:ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.17; Mon, 12 Jul
 2021 18:03:18 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%5]) with mapi id 15.20.4331.021; Mon, 12 Jul 2021
 18:03:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Topic: SOFT + NO_RETRANS_TIMEOUT semantics
Thread-Index: AQHXd0BYAPlUDv7myUCZIzGi/bl7Las/mkyAgAADYgCAAAQxAA==
Date:   Mon, 12 Jul 2021 18:03:18 +0000
Message-ID: <3eb9c594ca9b2fbc37d4bc3ad2a541c1bb68be2c.camel@hammerspace.com>
References: <981B8D74-2193-498C-8C4F-190E263FD8F6@oracle.com>
         <c902bfca197cac1c1328e833f768908ae518b829.camel@hammerspace.com>
         <FCDB802E-52FE-442E-A6D3-D623ED170EF6@oracle.com>
In-Reply-To: <FCDB802E-52FE-442E-A6D3-D623ED170EF6@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d7cec53-cea3-4e69-f25e-08d9455f5428
x-ms-traffictypediagnostic: CH0PR13MB5154:
x-microsoft-antispam-prvs: <CH0PR13MB5154241919DFFF9C77506C20B8159@CH0PR13MB5154.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7wAVTSohSz1HEYbVWLO31mOeBtpjS0KG41wQrMPonYX7/sY7aJ/m7f2C7MKqW0g2BUcCKsXrvKZ7nvU9FMSK4U5PWR8J5OY4ow/F+gJKfyb/E6sssHnmNuaIksNgqZoxSj1QyAtSiY/fkxiZJjaCaTZKkI4OQGA8l08qpQ8BJdqyn1aCjJPdJ0ZfsEBVGc/EI2QXJD1Sl/DnCu4qOvy80uUHIFLs6a0DtR3yokHRhtXmgwIS0I3VVKvxsCDhAioYuFjGsXBLehm2QrdgGUIHcl9accErJTMj0Lzjl39hD+pVSQCf7sTSgA90HZG5vwAtXTesNYDWp1dSJCtwqhvMniA3Efm0hofYioiXoe3VwyDa8+/xZGE8y8fU83VNXC6wKmyZq9PCOVyVhjoyJ+QJeKRhtTTTgdvhZaEZC7PH4OKx78Zq1+TK12rM3qY/6iW20oDJlvGGvsayeGVx07hqDvjoVlYC9y0j6xdsZEOUHiO7OZUTsIuBGcCPnylce7olc5ajupi1/dk11+pyeRa2Pwwk9t0SqYpoTgIbKNvwYUBuQdZZf4rz/g1HAUQLoyMH7lqXk59JtvNp0rZm6vQ9vR+UTf7Ux74vWj4fwwC0LorgoNRtmpmk3qWgQRf5I/Es0CdYpFrRksGkRVCxINmgjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(376002)(39830400003)(2616005)(66476007)(66446008)(6916009)(2906002)(66946007)(76116006)(66556008)(36756003)(83380400001)(64756008)(38100700002)(6486002)(71200400001)(4326008)(86362001)(26005)(186003)(478600001)(8936002)(6512007)(5660300002)(8676002)(316002)(53546011)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1BLRFJJT1liZ0x2THZnelhJVktJcmtnVjYwWUYrSW54bnQ4RkdTTTlJS1p4?=
 =?utf-8?B?WFplSG1udTdSSHFDaWFQOFU4YUFWeVFZeHM0cTRhYnI3ZWtHVGxqclFlL2p6?=
 =?utf-8?B?Nit3dHhHQ0tYZnNoRnVEZlMyaHBJUFVrb1QzRU01bERiK1dnVjN0elZSK3JN?=
 =?utf-8?B?N3JTVGdoczdnTzRPanVZZ2tyNVJwTDBOQkR3d3lPcGNkUTBjancxYzZjREt5?=
 =?utf-8?B?bm83KzFidVBEV0VYOVBOS3ZtV2J3WFAxZ01vbGZMRmRIMTJsNGdRWXRBbGJv?=
 =?utf-8?B?amQ1NWF1U05GK2ROeUZoTkxRSWJKcnZaSnJUTFByVkt3bStlejVJSkh6MjJQ?=
 =?utf-8?B?MVlBYnVkSVRrWnNUem5QVWpPQWc0OCs0ZllqRDBuUlBHRGRDZTRjeEdoRHBT?=
 =?utf-8?B?N1pFei92Q3IzVmczMUxTMWtYS2V4RUUxLzdlQzZISG41a3ZiRXFtV21LWk9V?=
 =?utf-8?B?c3B0SDlNd0hkME1IejFUN1FrYzFyWmo0MUlIc09IOFRvbGpOTkJueStnQ3Q5?=
 =?utf-8?B?WDk1RDNxM2NRTDZwdmRBcll4WTN2WGtGTk91TndjejJ5S0IrYnV4S0pXV0ND?=
 =?utf-8?B?MHcxZGIyMmpmRmxJSnZUM3BRK01Ma0Yzd25uRFluaUFyM0E1NVBGemhuZzlt?=
 =?utf-8?B?SVFySHNMc2Vrb3F4T0x4bStBZjR1bnczdWhaYVpsM1k5MHpIWkEwcG1zMy9C?=
 =?utf-8?B?Wk91dCt1QW5uRkFEdktLbFEra3ZQek1kbCtCQUpNVEtGSTliUnpnTEpOeGcz?=
 =?utf-8?B?VFJFbHFjUEFjLzhQb3NWWHltazhWZC9PQnpEdFg3dEQxYmtTODBiVHlFdjlr?=
 =?utf-8?B?MlN1MFhjblNGQmp0QWcySmRqcTFIVWlRTFdHWk5mQWZPZHRXdUp0Q3JxTWFV?=
 =?utf-8?B?TnFwMURLbEpZemdFOGxMdDB4b0t2cUhGd2FiWmZzWklseHk4bWpNeHF0MHUv?=
 =?utf-8?B?WWg2MVowYVRWUmlPbGw0aVc4SjI3QmFibCtJUUdYMHF5bGk5bkNKWjJ3ZWl2?=
 =?utf-8?B?QVhsM3ZiQm1VQXBoS3J3Ti9RS09ycFN0ZFJpN2pDbEVhZFk2MmJXQzkwOUcx?=
 =?utf-8?B?b3hRdjMyNmJmTHBwRk5HVHJLLzBseHdNc2prYWp5SHdVQkkrTk1MY0d5UjVa?=
 =?utf-8?B?NkZaMEdVT0tsb21CWTdiS3hScVh3NW9hZk1sREJnVHlMbGFWUjZmZHJGd1Y1?=
 =?utf-8?B?Wm96UjZJQ0wvWFJYSHdPVU5qd1JoRklueTBIaGtZYmJHVGYzeSs0UVBSdWR1?=
 =?utf-8?B?ZWgxOGplcHRJeWNvd1FUSUNzYThFWHkwVEdWTzE1emwrdlFVUzMyYTQ1Vlpa?=
 =?utf-8?B?a3h6dmtuYXlqMWlBYkxKQUdLYTNBcExHem1YczZVVGJ1V1BzcGpwWEs5dnNo?=
 =?utf-8?B?MUdEV0hVMk01NjRtakg1Nm9GeGtFWWlGTjRLcmxiYmpYd1NYN0RnOXo0M1U0?=
 =?utf-8?B?SUNrOEZWY3FUMkJVUkxBak9YdUNhWkRwZ2ZXaFBPOW8wUnlQOHNVSWh6Qmhp?=
 =?utf-8?B?QmxVU0srMW5MKzEyVFBYRWZZOEJrVlhpTzdFTm4za0tnSldKSTV6SUZjeHJR?=
 =?utf-8?B?OVNDTUlkTmJxcUFDYm1EZEZjeHM2K0ZtVzdUbUlBeDdpVzNVUDhZR1BhaHdS?=
 =?utf-8?B?ODlkQzI5UzRqNkg5K21JTURkQU9ZdXBiV0dwRjNnUzFNc3p0UFZMTU5CclVr?=
 =?utf-8?B?N2xxSmE2SkNvdmwrbzFpb2lXU3VYcktOMHhoYlRMNmVEOWJHMHhuUHVMRlI5?=
 =?utf-8?Q?42KYRPWr4WFoiUFb/OMYzU5b3bmC2C0iXY9Ljs4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <44DA8E010E614441B8506FBDDBD20A37@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7cec53-cea3-4e69-f25e-08d9455f5428
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 18:03:18.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VW9kbeEPQHOpmNbXkEBnXoLDcRdVr6G9Tmkxzn5DF2a0XKvqB5Zzp3y7fAynIXOXRPS6InrW00LdyoQj0EMhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5154
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTEyIGF0IDE3OjQ4ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdWwgMTIsIDIwMjEsIGF0IDE6MzYgUE0sIFRyb25kIE15a2xlYnVz
dA0KPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9u
LCAyMDIxLTA3LTEyIGF0IDE3OjA3ICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+ID4g
PiBIaSBUcm9uZC0NCj4gPiA+IA0KPiA+ID4gSSdtIHNlZWluZyBzb21lIGludGVyZXN0aW5nIGNs
aWVudCBoYW5ncyB0aGF0IGFyaXNlIGZyb20gYSB3ZWxsLQ0KPiA+ID4gdGltZWQgc2VydmVyIGNy
YXNoIG9yIG5ldHdvcmsgcGFydGl0aW9uLg0KPiA+ID4gDQo+ID4gPiBUaGUgZWFzaWVzdCB0byBz
ZWUgaXMgZ3NzX2Rlc3Ryb3koKSBvbiBhbiBLZXJiZXJpemVkIE5GU3Y0IG1vdW50Lg0KPiA+ID4g
DQo+ID4gPiBORlN2NCBhc3NlcnRzIHRoZSBSUENfVEFTS19OT19SRVRSQU5TX1RJTUVPVVQgZmxh
ZyAoaGVyZWFmdGVyDQo+ID4gPiBJJ2xsDQo+ID4gPiByZWZlciB0byBpdCBhcyBOT1JUTykgd2hl
biBjcmVhdGluZyBhIG5ldyBycGNfY2xudC4gVGhlIGluaXRpYWwNCj4gPiA+IHJwY19waW5nKCkg
Zm9yIHRoYXQgcnBjX2NsbnQgaXMgZG9uZSBiZWZvcmUgdGhlIGxvZ2ljIHRoYXQgc2V0cw0KPiA+
ID4gY2xfbm9yZXRyYW5zdGltZW8sIHRodXMgdGhhdCBwaW5nIHdvcmtzIGFzIGV4cGVjdGVkIChT
T0ZUIHwNCj4gPiA+IFNPRlRDT05OKSBhbmQgY2FuIHRpbWUgb3V0IHByb3Blcmx5IGlmIHRoZSBz
ZXJ2ZXIgaXNuJ3QNCj4gPiA+IHJlc3BvbnNpdmUuDQo+ID4gPiANCj4gPiA+IEhvd2V2ZXIsIG9u
Y2UgdGhhdCBwaW5nIHN1Y2NlZWRzLCBjbF9ub3JldHJhbnN0aW1lbyBpcyBhc3NlcnRlZCwNCj4g
PiA+IGFuZCBhbGwgc3Vic2VxdWVudCBSUEMgcmVxdWVzdHMgb24gdGhhdCBycGNfY2xudCBhcmUg
d2l0aCBOT1JUTw0KPiA+ID4gc2VtYW50aWNzLg0KPiA+ID4gDQo+ID4gPiBXaGVuIGl0IGNvbWVz
IHRpbWUgdG8gZGVzdHJveSB0aGUgR1NTIGNvbnRleHQgZm9yIHRoYXQgcnBjX2NsbnQsDQo+ID4g
PiB0aGUgTlVMTCBwcm9jZWR1cmUgd2l0aCB0aGUgR1NTIGRlY29yYXRpb25zIGlzIHNlbnQgd2l0
aCBTT0ZUIHwNCj4gPiA+IFNPRlRDT05OIHwgTk9SVE8uIElmIHRoZSBzZXJ2ZXIgaXNuJ3QgcmVz
cG9uZGluZyBhdCB0aGF0IHBvaW50LA0KPiA+ID4gdGhlIGNsaWVudCBjb250aW51ZXMgdG8gcmV0
cmFuc21pdCB0aGUgR1NTIGNvbnRleHQgZGVzdHJ1Y3Rpb24NCj4gPiA+IHJlcXVlc3QgZm9yZXZl
ciwgYW5kIHRoZSB4cHJ0IGFuZCBwb3NzaWJseSB0aGUgbmZzX2NsaWVudCBhcmUNCj4gPiA+IHBp
bm5lZC4NCj4gPiA+IA0KPiA+ID4gVGhlIHByb2JsZW0gYWxzbyBhcmlzZXMgZm9yIGxlYXNlIG1h
bmFnZW1lbnQgb3BlcmF0aW9ucyBzdWNoIGFzDQo+ID4gPiBzaW5nbGV0b24gU0VRVUVOQ0Ugb3Ig
UkVORVcgcmVxdWVzdHMuIFRoZXNlIGFyZSBhbHNvIGRvbmUgd2l0aA0KPiA+ID4gU09GVCwgYXMg
SSByZWNhbGwgdGhleSBuZWVkIHRvIHRpbWUgb3V0IHByb3Blcmx5LiBCdXQgd2l0aA0KPiA+ID4g
Tk9SVE8gKyBTT0ZULCB0aGV5IHdpbGwgYmUgcmV0cmllZCB1bnRpbCBhIGNvbm5lY3Rpb24gbG9z
cyB0aGF0DQo+ID4gPiBtaWdodCBuZXZlciBjb21lLg0KPiA+ID4gDQo+ID4gPiBJJ3ZlIHRob3Vn
aHQgb2Ygc29tZSB3YXlzIHRvIG1vZGlmeSB0aGUgY2xfbm9yZXRyYW5zdGltZW8gbG9naWMNCj4g
PiA+IHN1Y2ggdGhhdCBpdCBjYW4gYmUgZGlzYWJsZWQgZm9yIHBhcnRpY3VsYXIgUlBDIHRhc2tz
LCB0aG91Z2gNCj4gPiA+IG5vbmUgaXMgcmVhbGx5IHN0cmlraW5nIG1lIGFzIGV4Y2VwdGlvbmFs
bHkgY2xldmVyOg0KPiA+ID4gDQo+ID4gPiDCoC0gQWRkIGEgZmllbGQgdG8gc3RydWN0IHJwY19w
cm9jaW5mbyB0aGF0IGNvbnRhaW5zIGEgbWFzayBvZg0KPiA+ID4gwqDCoCBSUENfVEFTSyBmbGFn
cyB0byBjbGVhciBmb3IgZWFjaCBwcm9jZWR1cmUuDQo+ID4gPiDCoC0gQWRkIGxvZ2ljIHRvIHJw
Y190YXNrX3NldF9jbGllbnQoKSB0aGF0IGNsZWFycyBOT1JUTyBpbg0KPiA+ID4gwqDCoCBzb21l
IHNwZWNpYWwgY2FzZXMuDQo+ID4gPiDCoC0gUmV2ZXJzZSB0aGUgbWVhbmluZyBvZiBOT1JUTyAo
ZS5nLiwgbWFrZSBpdA0KPiA+ID4gwqDCoCBSUENfVEFTS19SRVRSQU5TX1RJTUVPVVQpIHNvIHRo
YXQgaXQgY2FuIGJlIHNldCBieSBhIGNhbGxlcg0KPiA+ID4gwqDCoCBmb3IgcGFydGljdWxhciBS
UEMgdGFza3MgaWYgdGhlIHJwY19jbG50LWRlZmF1bHQgYmVoYXZpb3INCj4gPiA+IMKgwqAgaXMg
Tk9SVE8uDQo+ID4gPiANCj4gPiA+IEFueSB0aG91Z2h0cz8NCj4gPiA+IA0KPiA+IA0KPiA+IFdo
eSB3b3VsZCB0aGUgY29ubmVjdGlvbiBub3QgYnJlYWsgd2hlbiB0aGUgc2VydmVyIGdvZXMgZG93
bj8NCj4gDQo+IFRoZSBzZXJ2ZXIgY2FuJ3QgYWN0aXZlbHkgUlNUIG9yIEZJTiB0aGUgY29ubmVj
dGlvbiBpZiBhIG5ldHdvcmsNCj4gcGFydGl0aW9uIG9jY3VyczsgYW5kIHNvbWUgc2VydmVycyBt
aWdodCBjcmFzaCB3aGlsZSB0aGVpciBrZXJuZWwNCj4gaXMgc3RpbGwgYWxpdmUgdG8gcmVzcG9u
ZCB0byBrZWVwLWFsaXZlLg0KPiANCj4gDQo+ID4gQXJlbid0DQo+ID4gdGhlIFRDUF9VU0VSX1RJ
TUVPVVQgb3IgdGhlIFRDUF9LRUVQQUxJVkUga2lja2luZyBpbiBhcyB0aGV5DQo+ID4gc2hvdWxk
Pw0KPiANCj4gSSBkb24ndCBzZWUgdGhlbSBraWNraW5nIGluLCBidXQgSSBsZXQgdGhlIHRlc3Qg
cnVuIG9ubHkgZm9yIGFib3V0DQo+IDEyIG1pbnV0ZXMuIA0KPiANCg0KVENQX1VTRVJfVElNRU9V
VCBzaG91bGQga2ljayBpbiBhbnkgdGltZSB3aGVuIHRoZSBzZXJ2ZXIgaXMgZmFpbGluZyB0bw0K
cmVhZCB0aGUgc29ja2V0IGNvbnRlbnRzLCBhbmQgc2hvdWxkIGNsb3NlIHRoZSBjb25uZWN0aW9u
Lg0KDQpBIG1vcmUgbGlrZWx5IHNjZW5hcmlvIGlzIHRoYXQgdGhlIHNlcnZlciBpcyBhY3R1YWxs
eSByZWFkaW5nIHRoZQ0Kc29ja2V0LCBidXQgaXMganVzdCBkcm9wcGluZyB0aGUgcmVxdWVzdHMg
b24gdGhlIGZsb29yLiBJIGFncmVlIHRoYXQNCm5lZWRzIHRvIGJlIGhhbmRsZWQgY29ycmVjdGx5
Lg0KT25lIHdheSB0byBkbyB0aGF0IGNvdWxkIGJlIHRvIGFkZCBhIGZsYWcgdGhhdCBzYXlzICJk
b24ndCBhcHBseSBhbnkNCm90aGVyIGRlZmF1bHQgdGFzayBmbGFncyIgZm9yIHNwZWNpYWwgY2Fz
ZXMgbGlrZSB0aGlzIG9uZT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
