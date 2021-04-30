Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD636FACE
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Apr 2021 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhD3Mo4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Apr 2021 08:44:56 -0400
Received: from mail-bn8nam12on2128.outbound.protection.outlook.com ([40.107.237.128]:55232
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231476AbhD3Mnl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Apr 2021 08:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVY+ndG8RlVTtON+W8qH1jFUVMKJr/t722oXljIYuPWktRJLKxHJXDphQXv7+D2nmGmn/F+wNC1vB4muDb8YVR4jjlL91WZvKWtf6xqENOvbKcUKZ+o7ychBDtLDAhvqczv6xfD1Y/WJW1mkmOPwV5WWzDXYZqvQrnKa+bhqonmRp8zmS/aqS7wTXQKbF7sfG/gbKzSGbA41L4vZT8qKiGPwJA7wD7dfoRyXzjU6kLtjrFz+HlhSLwMdUIlFi7Q5egWex2Y6z5Z4XuRKUhRruhgyQS0X5Fh6qZqtSxbgvivUEY0PTxLUt5sscZ1+X0q+3AFCLV7Uhm7ih3FEKeNoVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8e2wxR2rznsVgbmH3zdmnbpnv9qUGDN6jlzkaSLznA=;
 b=H3jlbBxbI6cmTlwtsdJVrszRBmTyXhKCIifGz8Rwu5E4HfiBZ9HIRn1EGYB6WxCGruMP0dyO7HbAusdezlf+vyQ41sPuVOD/tq7B3ovZOBfbi6JNYHVQJFEiAu8f7dP0M0Kx9fb1myOO/1ZNuXo1cwqdnVUUQAyh5OUS6UqHd03RuS49Xafx/fpO6M1/vop9TAHBC5lg3n201QmU2RTQk7ps+fRrFToljEbIADd9THA0FbgQk91xsetBdaRfmJdgU+PuNv77I8p4UgIOXY2kh8M5zSHc6i7H2fky9JgMeTq1ePplaWCqneuFzwwRdjwsAmGQ64GcrUM8Pu5djeNW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8e2wxR2rznsVgbmH3zdmnbpnv9qUGDN6jlzkaSLznA=;
 b=I+CUbd4aWLwfHegRla9PGfiRSsCxBq4NQ02MEhMrf/SPz3z/9RH/vdzeNP/A2wI6AQoRBZCZXI1vUqK6Z2BrDkbqXP466kMJN0dqveTrSgHcrYPG3n9eghZ5+df2Cl6I04zq3c2hpkIND+pVPyaQDI9Pv3I87n9oTUtYhexLEJw=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB1225.namprd13.prod.outlook.com (2603:10b6:3:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.24; Fri, 30 Apr
 2021 12:42:52 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4108.015; Fri, 30 Apr 2021
 12:42:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4: can_open_cached needs to be called with
 so_lock
Thread-Topic: [PATCH 1/1] NFSv4: can_open_cached needs to be called with
 so_lock
Thread-Index: AQHXPX71UYnllJQ790m1s7wNeL9eS6rNAaoA
Date:   Fri, 30 Apr 2021 12:42:52 +0000
Message-ID: <8fadf7c12b188eacf5c2bb577a2fbf938e51ebaa.camel@hammerspace.com>
References: <20210430050900.106851-1-dai.ngo@oracle.com>
In-Reply-To: <20210430050900.106851-1-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6091ac5-9411-42bc-d841-08d90bd57834
x-ms-traffictypediagnostic: DM5PR13MB1225:
x-microsoft-antispam-prvs: <DM5PR13MB1225BE93E365065AB2BEA4E5B85E9@DM5PR13MB1225.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TqiX/x0PX31X6N/kHDxXzg8sL7Z9JLy8KRyh50Jtb5m/Yz0idPvkzUIGU6XCNDUwFG6P3ro3IRnq1CmvQMAWWXmOGEWXKfzIBTg69rNLo3BjSCro8AScUyt6oo3wxWJm8w3Qmc/37PUOO96bydlIWDC2jW9VEuzC5AIV7WSeXag9rYPkwHjuOwTMzQweCuNhKxRVay5jDseqJmkK1cJC76ndaV9a+/a3K7CXp0EII2qLNrXogNus8mVQsa31E/7p0Z3Iyxrvh7+hlnZ/ghVmAdSd+tkWm52sz55bTS/WJCsWAydsRh0OXnvioKRDori49YGl5SFcOXDxxSSGs+QEWU3K8rjf+Fb+9dMLWhrS8W9LjrDSZOe/c9M1aNo8sahBoaddw/IaUsDB26aAA+vb1yqLTsodOIAb5ZNzTb7V3/2Wxw8IShRzmbpDXf5bXeNKm9MXk8pGErPGtTHjlwFjZ3Vdlwg+ijAe+N9xeoDIlmlcgnmCMz4Wy4bbbWdHW6aydud49BnHG/vHRhWLuvNhiGQA/RgjqKgAlhTzBY8XpSoIZZZdWGkPJGLxmqTLZXafGLJBzhMup8bzsK8Y6rh7P5O/piPZAnZZABqIA0gFMNg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(376002)(366004)(136003)(396003)(2616005)(86362001)(76116006)(91956017)(26005)(186003)(66946007)(2906002)(83380400001)(6916009)(36756003)(5660300002)(66556008)(64756008)(66446008)(66476007)(316002)(71200400001)(8676002)(6506007)(6486002)(4326008)(8936002)(478600001)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NkYzMlNQd1I0TStDUEdNeVk4eXJVYlV5SFNvS1I2Y0RiTjM4dFEyNFJCSmNM?=
 =?utf-8?B?ajE4ZGthOW15ZEFXRDIxZTBTN3l2Y09JcUxmeGs2VU1WZlNQYjNKMmsyQUc3?=
 =?utf-8?B?S2lFRWJwSXIvM3RCcmg0S2g3RE52NTg1OHFITHdCM1pDenBsckdVbzdtNEtG?=
 =?utf-8?B?T3Q5dlUvKy90TjJoRlRZY2o2VFNFZUNZOXUwam9jSWxOcXQ1WFhRTlQ1Z3p1?=
 =?utf-8?B?dEJIbko5cXppRjFUdlJ6SGF3cDR0d0J6blpQR3o1b3F1NSs5VG1hUlRVV3h0?=
 =?utf-8?B?YmZDNXdWWmpqbmxMZUVwemdscnZDWWJKK0VlK3JlTWwrbVF2WjRHV1paYThu?=
 =?utf-8?B?OFlObmhncnp5VUErOUI0OFVtdFdYUUxVWnBXQjErUjQ0L05sNXhHbVMyOTBL?=
 =?utf-8?B?ZzJLZDN0YmtpMUF5RG1KamVuTkxVdkxWaCtzWWowVlAzUGpEVHBic2p3bWlt?=
 =?utf-8?B?TUpUeFBwcDdXVUZtOERWY1I1Z3dMUUN4VC82L2FGMGFZUmdnOG9kR3hBWWhy?=
 =?utf-8?B?c1gwVDZhVVJvVU1YME5IZUh5TyszUUV5dGNkS0dhL25TaFpvYjBpSkovcUpE?=
 =?utf-8?B?dytnMmw1YnhHUjN2T3NFOHY2WjZlUGlRYzc1SGlRSFpZbDJzeFMzemJVTnZH?=
 =?utf-8?B?a2tHMzgwVWlZd0V3b01PR0kzZHRhdFlsS3liOUdMNEJiTjEwN2VVL28yWS9Z?=
 =?utf-8?B?djFLZkhkVUpjWHdoUFFtUURRcXRiZDJLMGNsYkNnZU14RHR5UThxZ0dkOFZX?=
 =?utf-8?B?eHRMWG9ITkcrVE5zS3piZy81WXFKNVZZUWtOa3lHUCthb1UxNEU5LzRYaGhZ?=
 =?utf-8?B?aU9pUVhTVzlIc3JiZ1owREx1SkxxRHFheEoxZUZTMXNucXlrRlZCY1MwWjdC?=
 =?utf-8?B?Y0RyMU8yUG9NbzlWMEFtcHFkRnNrTDAxVXFQZ2ZCVGZJK0NSRnRNZlRGWUJ2?=
 =?utf-8?B?Y1p2UlhETS9CYlpwK1dMMG1rdlQ1Y2tTcjU5K0RMZzFPdVNoUlRHdDFMU21P?=
 =?utf-8?B?VXJHUUhtVXQ3cEFJank2bDh3RWRmZ0RNSjVmUkMxR3B3RlJiWm5MZVR0R2F0?=
 =?utf-8?B?WTNCTlBxVGNsVjErRUtCcHM1WTZySVNseGt2dUErdFdmQXN4b2p5b0RrNldZ?=
 =?utf-8?B?ZXFFeURZdytDa0E1ZVNuS3hLNTJ1NGlySUhhYUpvTGVZM3FnZURUKzFlUk1O?=
 =?utf-8?B?UXlGOG41RWVGalRYMC9jY0lod3NlakY2S05tdDNqbmMxMGttY3ROaERmNmZq?=
 =?utf-8?B?N3Q2cmpVMHZ0b0lqdjZLZlFBU3JJMkpmdFlJOWNQNFlWNHhQNWE4T3FXeTVm?=
 =?utf-8?B?VzVoWXA0OHp0WWZUYWZLblNZd1hEYmtPQkNMKzdqb2dzY3lEQUJYOWFlWitq?=
 =?utf-8?B?Q2F6dUMxeTBoeHBVTFdLWUkxdDgxRkZBMHpiMS9SOHR5OC9vV3FEeCs5Qy9a?=
 =?utf-8?B?Tm5XYVZMcHY4MlFtSS83VGF4YWFaS0lYd253V0xZemlwbTllQ0pHUlpzVllK?=
 =?utf-8?B?ejBIc1Q2NktWVzFkVXJzRFVHbnFLQ0dOZ0xYZ0p6aWpTamlQbHFLQ3FPNnNk?=
 =?utf-8?B?bGNKay9UdElZZUtnbFRGaEdxNDJKU1Q4RENnNy9hRkRIZ3EybWNHVGg4MmQw?=
 =?utf-8?B?b1dLRmFyU3ExaWE4RSthR0pZL1YzbjkzcFJMbWF5WTR4TWdENzhvczRFTnhS?=
 =?utf-8?B?VzVxcXpnTXV1TDF4TDcrY1hmY2gvRXNvRXZOQUdCdERCSHArSUFaa0ZWMU1F?=
 =?utf-8?Q?iOWxP5EAsRE4XkdDAV9lsWRGSSQRhEYUbKn8oir?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B9A63BC24611147984E94D52BCDE621@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6091ac5-9411-42bc-d841-08d90bd57834
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 12:42:52.1537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSpAftJZLvPKpv4ABlS2alhutdL8rQOsGh6A3hCDRDJelJ2VM+tckRfFNmDXrpGwu+ScCPHa7StMul/uLAfjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1225
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTMwIGF0IDAxOjA5IC0wNDAwLCBEYWkgTmdvIHdyb3RlOg0KPiBDdXJy
ZW50bHkgY2FuX29wZW5fY2FjaGVkIGFjY2Vzc2VzIHRoZSBvcGVuc3RhdGUncyBmbGFncyB3aXRo
b3V0IHRoZQ0KPiBzb19sb2NrIGFuZCBhbHNvIGRvZXMgbm90IHVwZGF0ZSB0aGUgZmxhZ3Mgb2Yg
dGhlIGNhY2hlZCBzdGF0ZS4gVGhpcw0KPiByZXN1bHRzIGluIHRoZSBvcGVuc3RhdGUncyBmbGFn
cyBiZSBvdXQgb2Ygc3luYyB3aGljaCBjYW4gY2F1c2UgdGhlDQo+IGZpbGUgdG8gYmUgY2xvc2Vk
IHByZW1hdHVyZWx5Lg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBtaXNzaW5nIHNvX2xvY2sg
YXJvdW5kIHRoZSBjYWxsIHRvDQo+IGNhbl9vcGVuX2NhY2hlZA0KPiBhbmQgYWxzbyB1cGRhdGVz
IHRoZSBvcGVuc3RhdGUncyBmbGFncyBpZiB0aGUgY2FjaGVkIG9wZW5zdGF0ZSBpcw0KPiB1c2Vk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29tPg0KPiAt
LS0NCj4gwqBmcy9uZnMvbmZzNHByb2MuYyB8IDggKysrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMv
bmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBpbmRleCBjNjVjNGI0MWUyYzEu
LjI0NjRlNzdjNTFmOSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gKysrIGIv
ZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTI0MTAsOSArMjQxMCwxNSBAQCBzdGF0aWMgdm9pZCBu
ZnM0X29wZW5fcHJlcGFyZShzdHJ1Y3QgcnBjX3Rhc2sNCj4gKnRhc2ssIHZvaWQgKmNhbGxkYXRh
KQ0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGRhdGEtPnN0YXRlICE9IE5VTEwpIHsNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX2RlbGVnYXRpb24gKmRlbGVnYXRp
b247DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzcGluX2xvY2soJmRh
dGEtPnN0YXRlLT5vd25lci0+c29fbG9jayk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKGNhbl9vcGVuX2NhY2hlZChkYXRhLT5zdGF0ZSwgZGF0YS0+b19hcmcuZm1vZGUs
DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkYXRhLT5vX2FyZy5vcGVuX2ZsYWdzLA0KPiBjbGFp
bSkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGRhdGEtPm9fYXJnLm9wZW5fZmxhZ3MsIGNsYWltKSkgew0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVwZGF0ZV9vcGVuX3N0YXRl
ZmxhZ3MoZGF0YS0+c3RhdGUsIGRhdGEtDQo+ID5vX2FyZy5mbW9kZSk7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2soJmRhdGEtPnN0
YXRlLT5vd25lci0+c29fbG9jayk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X25vX2FjdGlvbjsNCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoH0NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5s
b2NrKCZkYXRhLT5zdGF0ZS0+b3duZXItPnNvX2xvY2spOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmN1X3JlYWRfbG9jaygpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGRlbGVnYXRpb24gPSBuZnM0X2dldF92YWxpZF9kZWxlZ2F0aW9uKGRhdGEt
PnN0YXRlLQ0KPiA+aW5vZGUpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChjYW5fb3Blbl9kZWxlZ2F0ZWQoZGVsZWdhdGlvbiwgZGF0YS0+b19hcmcuZm1vZGUsDQo+IGNs
YWltKSkNCg0KVGhpcyBpcyBnb2luZyB0byBpbnRyb2R1Y2Ugc3RhdGVpZCBsZWFrcy4gVGhlIGFj
dHVhbCB1cGRhdGUgb2YgdGhlIG9wZW4NCnN0YXRlIGZsYWdzIGhhcHBlbnMgaW4gbmZzNF90cnlf
b3Blbl9jYWNoZWQoKSwgd2hpY2ggaXMgY2FsbGVkIGZyb20NCm5mczRfb3BlbmRhdGFfdG9fbmZz
NF9zdGF0ZSgpLg0KDQpXaGlsZSB3ZSBjb3VsZCBwdXQgc3BpbmxvY2tzIGFyb3VuZCB0aGUgY2Fs
bCB0byBjYW5fb3Blbl9jYWNoZWQoKSBoZXJlLA0KdGhlcmUgaXMgbGl0dGxlIHBvaW50IGluIGRv
aW5nIHNvLCBzaW5jZSB0aGlzIGlzIGp1c3QgYSByZWFkLW9ubHkNCmFkdmlzb3J5IGNoZWNrLiBU
aGUgcmVhbCBjaGVjayBpcyBwZXJmb3JtZWQsIGFzIEkgc2FpZCwgaW4NCm5mczRfdHJ5X29wZW5f
Y2FjaGVkKCkuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
