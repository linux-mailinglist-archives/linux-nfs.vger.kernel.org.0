Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE62D46EC
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Dec 2020 17:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgLIQkM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Dec 2020 11:40:12 -0500
Received: from mail-dm6nam12on2127.outbound.protection.outlook.com ([40.107.243.127]:55905
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbgLIQkL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Dec 2020 11:40:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxBTAEodKriAR+LZ6p7aZcoSFSXZJlIkkp3iVCDagWUjblS1bbYkg36aRo5T4bAGYsL9e1GW/pCpGKBn1RxYBr0QvAIdWOXguZdeFgkaZMfbcjUDaiETqJ0aZ1Q/NoQnwOeqv5KeUOSo35Ib+vSbyURumHSSX7G7xO4gjAM29eVpx0480SSsXjoROUFeVL2Otdf0TvsdyKN9Y7r3lOmGLJg5wbUUeA+/km3z20GvIHHpRzmVyL1Vc7LFGI5ZBRpHC4NSzDBR7afU2WntTrSTa/hfolIUtW9EhYuw4BhkogaqjvWPXNeibF8+iPQUZ8qbmVxFKhcu23bWtaINm7E3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85N2P9d7JHC+4YXhl9o+0y4v25GUnduUDHGjgdwRa0o=;
 b=RqACThEUVGDTUv2p8Zc7q4+9S+Ch2DLoO4I6iTGrPJDe6bS9M6DUKr2PVVab0O4RK3w+jNSNESudZa23Y6gHaH8nKmIACvABsg/7+pB3hRpeQ1/C+PWXrH+SuMKD7G8Fh+4uJUsM6aWWlexpo86lKIr2mWHVbm3KnPOuFc442zdofRtmKE2RBliOY9xoj0MwXQADHnbReAiRnhkqXD5ZjjeOOfkVjH9pu6MZ6QqTIDoz4qJ9QbpG4G3NpqHkqqp1E49X2iKZYldjvcL7yRMrSN4psZM6/wLWy0QtQpBnoKQX+2NSE6zoEPYgsU6gY2sk0Ak+a4+bBTY44CFLbt+zDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85N2P9d7JHC+4YXhl9o+0y4v25GUnduUDHGjgdwRa0o=;
 b=YNPoSGmggV17NeE996zKhUYmiyklqhenokDbRixaNYCpocty3GYk0viAVqqj4JItwszhnFndp54SILPgo7QrVb2X1CKzckziIlVI7duvfQcXlEWrfreXbO8WL9/RK9Hoy5Ha4jyYgr68wjtpqPuh1I1e/BT0LVCULP5WEWHolY4=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by BL0PR13MB4529.namprd13.prod.outlook.com (2603:10b6:208:8a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.9; Wed, 9 Dec
 2020 16:39:16 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3654.009; Wed, 9 Dec 2020
 16:39:14 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 15/16] nfsd: Fixes for nfsd4_encode_read_plus_data()
Thread-Topic: [PATCH 15/16] nfsd: Fixes for nfsd4_encode_read_plus_data()
Thread-Index: AQHWzjqrXvJmu+c15kOF+vAO2VLZ76nu8PAAgAAGQYA=
Date:   Wed, 9 Dec 2020 16:39:14 +0000
Message-ID: <55246c5db6ec550827f1f230bd980760db28a689.camel@hammerspace.com>
References: <20201209144801.700778-1-trondmy@kernel.org>
         <20201209144801.700778-2-trondmy@kernel.org>
         <20201209144801.700778-3-trondmy@kernel.org>
         <20201209144801.700778-4-trondmy@kernel.org>
         <20201209144801.700778-5-trondmy@kernel.org>
         <20201209144801.700778-6-trondmy@kernel.org>
         <20201209144801.700778-7-trondmy@kernel.org>
         <20201209144801.700778-8-trondmy@kernel.org>
         <20201209144801.700778-9-trondmy@kernel.org>
         <20201209144801.700778-10-trondmy@kernel.org>
         <20201209144801.700778-11-trondmy@kernel.org>
         <20201209144801.700778-12-trondmy@kernel.org>
         <20201209144801.700778-13-trondmy@kernel.org>
         <20201209144801.700778-14-trondmy@kernel.org>
         <20201209144801.700778-15-trondmy@kernel.org>
         <20201209144801.700778-16-trondmy@kernel.org>
         <4BA2AAC7-C4F5-4740-B10F-D34022A58722@gmail.com>
In-Reply-To: <4BA2AAC7-C4F5-4740-B10F-D34022A58722@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b11d72c-8863-4704-8a45-08d89c60f709
x-ms-traffictypediagnostic: BL0PR13MB4529:
x-microsoft-antispam-prvs: <BL0PR13MB4529E5C35D768EE4C34E82CAB8CC0@BL0PR13MB4529.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fL/YI09GyJmNR9xZi2ycsX9wpzkjgsiiySZ4Oup1Gq0iRzGIwMderRWcAjQl5UxUzEutdGRlogaMSCV61VamBalqqMf4fDxEJ9uaMAE4D5y7X902Edps0qJqcWx7zK+EBfL9fTfO26geNCxn1r1MGRWuYO+s+XbtjSKTfekw1m7gKdsHpe8/MGv4FFMybUuu0ys+q8Adoo5sX9mcktBAe7kJWOc1SeikEPlOZKqM6lHZ0m9SX5W0vrOJ+HJPObWkIBJYVmxkQ8j5+k7KbELVC2qWlxWUj81Vz9Bs748uAeCBNK8BBEmdcb2wSdTlb4rAuJXnbxpOMnqHMSIGezd3Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(66946007)(4326008)(36756003)(8936002)(71200400001)(64756008)(6486002)(5660300002)(66446008)(66476007)(66556008)(91956017)(6512007)(186003)(6916009)(86362001)(26005)(2616005)(76116006)(53546011)(508600001)(2906002)(83380400001)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TVpTa01ocnppOThFR0M2akxRbDRqWXFiYTNyc2NTWlBkK3VWbHhYNHFOSDVk?=
 =?utf-8?B?b0srVmExQXhLQWRyQjRlczZKUUZ3bFg4ZG9zTEpYVWpYaUdreVBmYnBqN25T?=
 =?utf-8?B?VzdLdy9iR21vUkdqaDl0em91UklCc3AxWDJ3NFB6eW9jbU5kejNLeHlLK2k0?=
 =?utf-8?B?SHdUdzU0Y3ZEUUhpVXZQRzNkWnpISmhGdUlmL2tZTEUwc3pnSDhlTWN2RWx4?=
 =?utf-8?B?Mk0zREhJVTBVbysxMFRIdjNxWkRLUzZsRHZrMk9ERmJRNWs3SHB6cWFTRURq?=
 =?utf-8?B?T25jaGQ1Q1hISDBidks3cXhVWUc1UWhPc3FTOGRvSnQ0S0NUeVk0eC9MbFR6?=
 =?utf-8?B?NURFSTlsYWxhQUdyZjdneWxWWXZJeXpiR0tid3VKUFJINlI1UnQzLzlxT1Zw?=
 =?utf-8?B?cXJXL3JBWGRWZmdjb1c2bFRaNW1xYzF4OFNXWjhFUW9EOC9xeWtWMUUxQVQ1?=
 =?utf-8?B?T2ZWZjF2cWFxb1Uyd3RBZ28vRUVEczhhK3NVYjE5VmZCQk5zTkd4VGhmSElq?=
 =?utf-8?B?dVFJWVlpQVZrdXNHazlsTEpWZ21WSGVDYkpkNEQ5Q0d1N091MkVvSXA0Nzk0?=
 =?utf-8?B?c1E0MmlkUk5wVVZIc1NSTSt6dWlGRFFyQkVMRXJwM2FoS2lObXhCRDFJcnBH?=
 =?utf-8?B?TGZ1V01UVU44REYxV3VOeHBDaFB6T3IwSG1FN0xGeWVYK0o0anR4RDhUZjBU?=
 =?utf-8?B?RWZTZGxWK2pZNU01VENMSlNVekI5ZTlzdExheFB2bmoza2dtR0FwamV2bzZJ?=
 =?utf-8?B?UW1jank4emVoSnNJaXd0ZDVYV0liR1dHdi9sOUdnaG9DUTVIakpHZUpnOUFi?=
 =?utf-8?B?ckY4QUpKdEZMSUovNnNCanJiUytlQy9LOHh3dHlOcmNJczdqZFhKVGdoSWxN?=
 =?utf-8?B?THJ2S3ZHQWVQcEN2cThkTUkrWnR1N3R4YVpmV3lHbC9kU05iZEwyKyt4RVo1?=
 =?utf-8?B?Ym55d0h2M3dtbG83dHd4OTliZnVzUm8zRXA3M2JXSzZpb0Z6ejhPbzQxWVQy?=
 =?utf-8?B?QmRLR3FVc3doZXR4b0xhalp1Qko3blJ6Y0c5d09BMUl5RGxxVmRxMDNjR2da?=
 =?utf-8?B?ZWJta0JSK3lveWtoMDl3eU1OYW15KzhIUmQyRWdQSkRQclZCOGRyenJiQzVZ?=
 =?utf-8?B?c0VTVEFWaDRXSmZlcDBtaUFSU1pueXBjb1FsUkVtVlNaRk5nWEN6eEd2SkhO?=
 =?utf-8?B?Z3hzbUlzcUlFdElJa0dzY3Q3MVlTbThUTE9TVW12VWNwNlpybVdIUFRyWmEz?=
 =?utf-8?B?cGRWaU5ZMjc2aWtxQVJvbU9pMlNwa1ppeTRHTTlFTVpoWE5JcURsWkNoZlZC?=
 =?utf-8?Q?25wojm0FnRAIeVhsoUekdVXMyelkclRSXl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CB7348B3B2D0749888446401454F55A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b11d72c-8863-4704-8a45-08d89c60f709
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 16:39:14.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEfAfuzQp67ZEBucI7wyT7a0H5a17+y16rDjP8STQmFfKwNH+tS2S/Ni6fWPx0JwePOtjSYZsQIl2vOhE+D3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4529
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTA5IGF0IDExOjE2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGV5LQ0KPiANCj4gPiBPbiBEZWMgOSwgMjAyMCwgYXQgOTo0OCBBTSwgdHJvbmRteUBrZXJuZWwu
b3JnwqB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gRW5zdXJlIHRoYXQgd2UgZW5jb2RlIHRo
ZSBkYXRhIHBheWxvYWQgKyBwYWRkaW5nLCBhbmQgdGhhdCB3ZQ0KPiA+IHRydW5jYXRlDQo+ID4g
dGhlIHByZWFsbG9jYXRlZCBidWZmZXIgdG8gdGhlIGFjdHVhbCByZWFkIHNpemUuDQo+IA0KPiBE
aWQgeW91IGludGVuZCB0byBtZXJnZSAxNS8xNiBhbmQgMTYvMTYgdGhyb3VnaCB5b3VyIHRyZWU/
DQoNCk5vLiBUaGV5IGNhbiBnbyB0aHJvdWdoIHRoZSBuZnNkIHRyZWUuIEkgaW5jbHVkZWQgdGhl
bSBoZXJlIGJlY2F1c2UNCnRoZXkgYXJlIG5lY2Vzc2FyeSBpbiBvcmRlciB0byBwYXNzIHRoZSB4
ZnN0ZXN0cy4NCg0KPiBDYW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9ucyBzYXkgYSBsaXR0bGUgbW9y
ZSBhYm91dCB3aHkgdGhlc2UNCj4gY2hhbmdlcyBhcmUgbmVjZXNzYXJ5PyBJZiB0aGV5IGZpeCBh
IG1pc2JlaGF2aW9yLCBkZXNjcmliZQ0KPiB0aGUgcHJvYmxlbS4NCg0KSXQncyB0aGUgc2FtZSBw
cm9ibGVtIGFuZCBzb2x1dGlvbiB0aGF0IGV4aXN0cyBpbiB0aGUgUkVBRCBjb2RlLg0KDQpuZnNk
X3JlYWR2KCkgZG9lc24ndCBuZWNlc3NhcmlseSByZXR1cm4gdGhlIHNhbWUgbnVtYmVyIG9mIGJ5
dGVzIHRoYXQNCndlIHJlcXVlc3RlZCBhbmQgcHJlYWxsb2NhdGVkIGJ1ZmZlciBzcGFjZSBmb3Iu
IFNvIHRvIGRlYWwgd2l0aCB0aGF0LA0Kd2UgaGF2ZSB0byB0cnVuY2F0ZSB0aGUgcHJlYWxsb2Nh
dGVkIGJ1ZmZlci4NCg0KRmluYWxseSwgd2UgaGF2ZSB0byB3cml0ZSB6ZXJvcyBpbnRvIHRoZSBw
YWRkaW5nIGJ5dGVzIGFmdGVyIHRoZSByZWFkDQpidWZmZXIuDQoNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4g
LS0tDQo+ID4gZnMvbmZzZC9uZnM0eGRyLmMgfCA1ICsrKysrDQo+ID4gMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnNkL25mczR4ZHIu
YyBiL2ZzL25mc2QvbmZzNHhkci5jDQo+ID4gaW5kZXggODMzYTJjNjRkZmU4Li4yNmY2ZTI3NzEw
MWQgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzZC9uZnM0eGRyLmMNCj4gPiArKysgYi9mcy9uZnNk
L25mczR4ZHIuYw0KPiA+IEBAIC00NjMyLDYgKzQ2MzIsNyBAQCBuZnNkNF9lbmNvZGVfcmVhZF9w
bHVzX2RhdGEoc3RydWN0DQo+ID4gbmZzZDRfY29tcG91bmRyZXMgKnJlc3AsDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc3AtPnJx
c3RwLT5ycV92ZWMsIHJlYWQtPnJkX3ZsZW4sDQo+ID4gbWF4Y291bnQsIGVvZik7DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoGlmIChuZnNlcnIpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gbmZzZXJyOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHhkcl90cnVuY2F0ZV9lbmNv
ZGUoeGRyLCBzdGFydGluZ19sZW4gKyAxNiArDQo+ID4geGRyX2FsaWduX3NpemUoKm1heGNvdW50
KSk7DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHRtcCA9IGh0b25sKE5GUzRfQ09OVEVOVF9E
QVRBKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgd3JpdGVfYnl0ZXNfdG9feGRyX2J1Zih4ZHItPmJ1
Ziwgc3RhcnRpbmdfbGVuLMKgwqDCoMKgwqAgJnRtcCzCoMKgDQo+ID4gNCk7DQo+ID4gQEAgLTQ2
MzksNiArNDY0MCwxMCBAQCBuZnNkNF9lbmNvZGVfcmVhZF9wbHVzX2RhdGEoc3RydWN0DQo+ID4g
bmZzZDRfY29tcG91bmRyZXMgKnJlc3AsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHdyaXRlX2J5dGVz
X3RvX3hkcl9idWYoeGRyLT5idWYsIHN0YXJ0aW5nX2xlbiArIDQswqAgJnRtcDY0LA0KPiA+IDgp
Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqB0bXAgPSBodG9ubCgqbWF4Y291bnQpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqB3cml0ZV9ieXRlc190b194ZHJfYnVmKHhkci0+YnVmLCBzdGFydGluZ19sZW4g
KyAxMiwgJnRtcCzCoMKgDQo+ID4gNCk7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHRtcCA9
IHhkcl96ZXJvOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHdyaXRlX2J5dGVzX3RvX3hkcl9idWYoeGRy
LT5idWYsIHN0YXJ0aW5nX2xlbiArIDE2ICsNCj4gPiAqbWF4Y291bnQsICZ0bXAsDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
eGRyX3BhZF9zaXplKCptYXhjb3VudCkpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gbmZz
X29rOw0KPiA+IH0NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
