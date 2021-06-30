Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B363B8774
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jun 2021 19:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhF3ROB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Jun 2021 13:14:01 -0400
Received: from mail-bn8nam12on2130.outbound.protection.outlook.com ([40.107.237.130]:65408
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229814AbhF3RN6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 30 Jun 2021 13:13:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuVOiisDyAWA6Qe5uJ9Pu8OK8xg8O9BKRA0kNtJyJ+slZw+PQjyReakM4NBJFAOiLt4Z7WIbD4iuMFpjMSGdc5ltZwYnsBHawbxUA2Xd+Vy9jaoJYkBddAalfT3o5BtQB7WI08mUvTXJRLzjuvnW8IUu3OofA3TAlV2WM872e9EkIpGltVHJ97MI9KTqGWayFEnR1fSIcIzdo757cUjxphQmDTMCmZEFEgY8ibVIQEs+73ExrUalCkp8AZZj+dyKm6bDzAnVmY0vbgtaPBFmGInBWdrzap2pgHndE8Kf+CCXD5dfMPar3jfJTP8SmFGcZCnou8mKbU+eFBos5HzUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z8O6+CwvnTe2ATspEkWe/05UU+EqwoqkTPJhGB5zvo=;
 b=Cm54PwZ3G3ZMt7Cp62RspEZbTJaqYlAzO+7NgGwWWqUkeOSDowBLu9+XAtnC/EKegL1GlX8EfIq9oqxBG4RfgPDB1vSDkzxztrfdvROURoF27kH4HrBKXrRfG/yhx+UlHiVQc5x3zAY7E6LWlW8ri9vh9Rdefmcczhvz4ZddLrGWM/hqC2nSXOQ5oYZrpg9TT4v2LWY4B722NqtGZbk+TjHAixDqqHDoL4cdyXArVXfy4bV8X2M2krzS1Vfle9a4KE9KhnlSkPaPzp3ejxNQDsHA1ej3wmTuvwP4vEDjWrJS2KzPSVBLqrxgbkeqa/A1YRz7vGN8kO4vB2eHAQGrUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z8O6+CwvnTe2ATspEkWe/05UU+EqwoqkTPJhGB5zvo=;
 b=YRavgy8tFtBN/CExhtwgiwP00yJpmIUQMggQuaIdNtu1XKVziWivqxOZLQk19jMjBx5kQfDClEMOExtwTwA3W0Iq8KvhghJTnSZhxxyQamcb30GyIlNW/LGhfn2iPSqAiXgbNga10gwuYxMSaImV9c/83LkJd1mfV7MyOr+SJ3U=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4587.namprd13.prod.outlook.com (2603:10b6:610:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.19; Wed, 30 Jun
 2021 17:11:26 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 17:11:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: client's caching of server-side capabilities
Thread-Topic: client's caching of server-side capabilities
Thread-Index: AQHXbFuMjtq3PRTcuEmeUcYpGr/LhKsp+uuAgAD5LgCAAA38gIAAAP2AgAGr0wCAABf6gIAABlIA
Date:   Wed, 30 Jun 2021 17:11:25 +0000
Message-ID: <e75b0190e171b001748505991bea7bfee3e73e0f.camel@hammerspace.com>
References: <CAN-5tyEuB5C9u+xZ5L47fSQ9cwZnsbhJuBs+gybU2A-jzAkfog@mail.gmail.com>
         <81154dc28d528402bf5e090a81e6892c7abc431c.camel@hammerspace.com>
         <B0CA736F-E3E8-4446-9A6E-3ADCDD7F8736@oracle.com>
         <CAN-5tyE5Y3+ZPrfAR8=UVdNnWxyzO6a_NTeTsMFH_TyyMqK-bQ@mail.gmail.com>
         <607F15BF-89B4-4123-8223-A3893229D219@oracle.com>
         <20210630152258.GC20229@fieldses.org>
         <CAN-5tyFD2SU1xVkiNh-Sp8s-_2QOu3O5ixOa_TDEXBNF=i2OVw@mail.gmail.com>
In-Reply-To: <CAN-5tyFD2SU1xVkiNh-Sp8s-_2QOu3O5ixOa_TDEXBNF=i2OVw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95a98008-4a9e-41f6-66fd-08d93bea1808
x-ms-traffictypediagnostic: CH0PR13MB4587:
x-microsoft-antispam-prvs: <CH0PR13MB4587C8F1D940FFD8983301DFB8019@CH0PR13MB4587.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4rF5bM0lqwu+YUQQd7ZLV9/S2wPfoq1v9WDxeJkTGoVhv0LCIp3sm8szWykT2R8RuqHuSGLHVdePmBeutAvSrb1ah5/ZT4UQ8oFozLL3q5G4yGcA4b1Cv6cdEt04hP9Xps7U7od6c+DYzrM7VdnEMGqr1zSOfgxLdwNog1XEtGNktovfrQfiYofl9iKVywIXn3us9UmnuCqGS3dskPtqf+gh618wmUdXlq6co8r/oAUHw198rfYpGt79LL8xpCobsjIttG2t7AY1VZKvlSnrSgXSAV5CxZZz9K6KXWYRVb0jRXfNOlB7gz6G/ayAtj8gL2nfahs1CkyEs0c0h4ri36YNkdiSy0WX0XS9mYOmaeVPUaN89EXIimYGuqUl+U/K6bCoLlFr1Z8LfMnWm/dWUNV2y7kF8c8YlUghwY/USqlt9YoSFfR699oBH/WkVR5VEOuI5Tgrjo6K7PDUyeUhktlMM3IwxzPOTCtNs0IkPUcyOgCcNUq9Y3QWpt01cW8vwcl6Kkej6kE9JzYEz9CZcAK5bTzemJ8/VCJGmELL9YMNAjTBFUgm+APOpznNpS+2IaaBOUnvscMQJOBQqn9/dMsV1saMErsfz8W+5eP/a6+CO1NVcTr8D6xp/VwB9FZsMgAn7vAlj7tQ4gKtXMPdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39830400003)(346002)(366004)(478600001)(8676002)(71200400001)(6512007)(86362001)(76116006)(8936002)(26005)(2616005)(83380400001)(4326008)(6486002)(5660300002)(2906002)(186003)(316002)(6506007)(110136005)(122000001)(54906003)(53546011)(38100700002)(64756008)(66556008)(66476007)(66946007)(66446008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmdDWWtSamlNeFR0UThESVl3VlFrWVFjTk9zMFFJNVNkc1Y2aDdUYVYvVWNL?=
 =?utf-8?B?bytYVTBKZUlyYmlWWTZLYVNVVTFrejVWNkxFTGk0VzU0T043aTJGRWRKVXhl?=
 =?utf-8?B?bTRybmVEN3UvRzZxYUZobGdiZzhpNGpRbW1jVG5Cd3Y2aHNJK0kxK3VHKzF3?=
 =?utf-8?B?VnJtb1BwNmJ0Q0M4WFdUZHdLNFk1WUNWWFVHUHh6QnNNVm1FazRsYlY3YVpa?=
 =?utf-8?B?KzkyYkJYVUhXV28yTnNnWmNaSjN6WWtTWEMzRHlUalhNNHlMWUxrNUJkeU1r?=
 =?utf-8?B?a1NVbHl0ZDJGcWU0aTk0REcrWElmVUJ6SENMUXRRZHJhTVZLMk9RSUMrbk11?=
 =?utf-8?B?dDhBOTRUYVZmMGlhVm9LODU1Nk9Nd0lmUENmclpacG5lOTJ6cG9XaXRSSkNE?=
 =?utf-8?B?WDdSYVdNUnl2OGIranVaMEY0akZiYUZKR3BzYnZHZDF6SGVSbnpCWlRjQjE2?=
 =?utf-8?B?cENHem5EWm1DUS9KcjNRc1g5c2cyYnl1U2FCNHRiTGJDSU1lMjBBYThQT0Fj?=
 =?utf-8?B?WVFURmlVMFdrbkRhOTJ1OE5LOHFQcnIzdTRBWWU0MXNLMnloZXZWaTBGMmY5?=
 =?utf-8?B?ZmdmQTJ3ZWc1TXEwQmhXdkpNWXJvOGhXQkg2V0pBdFQvWDZPaTd2WGY0TDhM?=
 =?utf-8?B?SG1NQWJkS3BZeW8xWnBNd3VNb1hEQkIvMmxWMkZkSElOcjF5MWVZYytDQWd0?=
 =?utf-8?B?N0ZaenBDcU1aUVo4SEllUTVST2tEaFF1QXREY054bnV5ZENDMVQrZzk4VGdm?=
 =?utf-8?B?ekRyNXFJb0NYMk5mRkEzTUpRQzE3b3RHRGREbUlHZ1NTSitkM2I1VEwvd28w?=
 =?utf-8?B?UFFoSGd1M0ZZeFVwektGVVppY0hScFhiWG9VYVg3S0ltQ2VwcUlLUXFzR2FE?=
 =?utf-8?B?R0Y1ejRnekV6K0pRR0hhcW5YeDZXMVozWjFCV3ZFSGRGc0twM3hmazhhU3hC?=
 =?utf-8?B?cXI4ckFpVnV0b0I1NE5vSlNKWWczRkFMQ0dtRWFqbktiOHN6NEZUOVcxWkNN?=
 =?utf-8?B?NGRTVFFUcm9ZajFHS2dzdDdLMXpjUEM5VDF2Vmw4V1BVQlJnbXhrcDVLM3hw?=
 =?utf-8?B?TmtIU0pxbGw3MGVoV0FrUEFzTTVaRjFKUWNkWVltYlJjQmNXUGZkWE5SYUFH?=
 =?utf-8?B?MmRGYUhCUE1BZzRkSTlzenVoTzN4eEZHOWJIZzY0QVArVGZrUG1aU1dFTXRL?=
 =?utf-8?B?OFl6TUM0VHFmeklMMEZrN1R4MlhDeWZDb3ByRTZDRGxJTUY4cncvT2FVbWVB?=
 =?utf-8?B?bnlqeEk3WFVic3czUG5rcFlWMktNU2VEMlRheXZOQmx1N01IMUNuOHdoVzBn?=
 =?utf-8?B?aEpiN3B2S3NHNzVRN2NXZXR5R2EwUGxqTkhmU3pIRWVSdk1BOVA0T1RVbWpi?=
 =?utf-8?B?Z012MFBpdE5iUTBjWkxhbnZ3aTlOOWRUbmJEMmtZWjZza1JGRG9nczF3RW10?=
 =?utf-8?B?bU1rNENWT1JsaHA0djZTNTROWTM0b2ExeEFINGUvNjZYV1hVdWljSHB4YmRG?=
 =?utf-8?B?TUJQNmJ2R1pjdnlMd3c5bjJKaDZSRFdHREhGS3l1bzZpaHlrRUJKTU9uWlUz?=
 =?utf-8?B?blB1UHFIZjNjS2lPUjJlNjBEUFpjU3B3cnNJRlZqais1Z2JvMXlXWTVJRk1h?=
 =?utf-8?B?ZkltVnVGaTBhTUIreExRMnBTMUk4dDN6UmxsaHlmZTNiNjg2UW5CL0lQSVpl?=
 =?utf-8?B?d0hGU3l1ZTlnRWNYRDhnbUFaVS9TbnRDTVJOVy9UL1VLLzg1bGtYZXFGVGVT?=
 =?utf-8?Q?icYRa8HV5iTAPzpwlwGyKMUQWgFMSSfgLt9Nhtp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <947E0CD5B9C3994DBAE10446425F9892@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a98008-4a9e-41f6-66fd-08d93bea1808
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 17:11:25.9931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDpbTfZ+v6oSR3Km6L0ij0ALLtrobli7RdrVtbwFV2reyeN1F1AcRo0quQQJAtIrRDK/t/HXQW6FK9wZ+huOAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4587
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTMwIGF0IDEyOjQ4IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBKdW4gMzAsIDIwMjEgYXQgMTE6MjMgQU0gSi4gQnJ1Y2UgRmllbGRzDQo+
IDxiZmllbGRzQGZpZWxkc2VzLm9yZz4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCBKdW4gMjks
IDIwMjEgYXQgMDE6NTE6NDNQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPiA+ID4g
DQo+ID4gPiANCj4gPiA+ID4gT24gSnVuIDI5LCAyMDIxLCBhdCA5OjQ4IEFNLCBPbGdhIEtvcm5p
ZXZza2FpYSA8YWdsb0B1bWljaC5lZHU+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+
ID4gT24gVHVlLCBKdW4gMjksIDIwMjEgYXQgODo1OCBBTSBDaHVjayBMZXZlciBJSUkNCj4gPiA+
ID4gPGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gSnVuIDI4LCAyMDIxLCBhdCA2OjA2IFBNLCBU
cm9uZCBNeWtsZWJ1c3QNCj4gPiA+ID4gPiA+IDx0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIE1vbiwgMjAyMS0wNi0yOCBhdCAxNjoy
MyAtMDQwMCwgT2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IEhpIGZvbGtz
LA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSSBoYXZlIGEgZ2VuZXJhbCBxdWVzdGlv
biBvZiB3aHkgdGhlIGNsaWVudCBkb2Vzbid0IHRocm93DQo+ID4gPiA+ID4gPiA+IGF3YXkgdGhl
DQo+ID4gPiA+ID4gPiA+IGNhY2hlZCBzZXJ2ZXIncyBjYXBhYmlsaXRpZXMgb24gc2VydmVyIHJl
Ym9vdC4gU2F5IGENCj4gPiA+ID4gPiA+ID4gY2xpZW50IG1vdW50ZWQgYQ0KPiA+ID4gPiA+ID4g
PiBzZXJ2ZXIgd2hlbiB0aGUgc2VydmVyIGRpZG4ndCBzdXBwb3J0IHNlY3VyaXR5X2xhYmVscywN
Cj4gPiA+ID4gPiA+ID4gdGhlbiB0aGUNCj4gPiA+ID4gPiA+ID4gc2VydmVyDQo+ID4gPiA+ID4g
PiA+IHdhcyByZWJvb3RlZCBhbmQgc3VwcG9ydCB3YXMgZW5hYmxlZC4gQ2xpZW50IHJlLQ0KPiA+
ID4gPiA+ID4gPiBlc3RhYmxpc2hlcyBpdHMNCj4gPiA+ID4gPiA+ID4gY2xpZW50aWQvc2Vzc2lv
biwgcmVjb3ZlcnMgc3RhdGUsIGJ1dCBhc3N1bWVzIGFsbCB0aGUgb2xkDQo+ID4gPiA+ID4gPiA+
IGNhcGFiaWxpdGllcw0KPiA+ID4gPiA+ID4gPiBhcHBseS4gQSByZW1vdW50IGlzIHJlcXVpcmVk
IHRvIGNsZWFyIG9sZC9maW5kIG5ldw0KPiA+ID4gPiA+ID4gPiBjYXBhYmlsaXRpZXMuIFRoZQ0K
PiA+ID4gPiA+ID4gPiBvcHBvc2l0ZSBpcyB0cnVlIHRoYXQgYSBjYXBhYmlsaXR5IGNvdWxkIGJl
IHJlbW92ZWQgKGJ1dA0KPiA+ID4gPiA+ID4gPiBJJ20gYXNzdW1pbmcNCj4gPiA+ID4gPiA+ID4g
dGhhdCdzIGEgbGVzcyBwcmFjdGljYWwgZXhhbXBsZSkuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiBJJ20gY3VyaW91cyB3aGF0IGFyZSB0aGUgcHJvYmxlbXMgb2YgY2xlYXJpbmcgc2Vy
dmVyDQo+ID4gPiA+ID4gPiA+IGNhcGFiaWxpdGllcyBhbmQNCj4gPiA+ID4gPiA+ID4gcmVkaXNj
b3ZlcmluZyB0aGVtIG9uIHJlYm9vdD8gSXMgaXQgYmVjYXVzZSBhIGxvY2FsDQo+ID4gPiA+ID4g
PiA+IGZpbGVzeXN0ZW0gY291bGQNCj4gPiA+ID4gPiA+ID4gbmV2ZXIgaGF2ZSBpdHMgYXR0cmli
dXRlcyBjaGFuZ2VkIGFuZCB0aHVzIGEgbmV0d29yayBmaWxlDQo+ID4gPiA+ID4gPiA+IHN5c3Rl
bQ0KPiA+ID4gPiA+ID4gPiBjYW4ndA0KPiA+ID4gPiA+ID4gPiBlaXRoZXI/DQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiBUaGFuayB5b3UuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IEluIG15IG9waW5pb24sIHRoZSBjbGllbnQgc2hvdWxkIGFpbSBmb3IgdGhlIGFic29sdXRlDQo+
ID4gPiA+ID4gPiBtaW5pbXVtIG92ZXJoZWFkDQo+ID4gPiA+ID4gPiBvbiBhIHNlcnZlciByZWJv
b3QuIFRoZSBnb2FsIHNob3VsZCBiZSB0byByZWNvdmVyIHN0YXRlIGFuZA0KPiA+ID4gPiA+ID4g
Z2V0IEkvTw0KPiA+ID4gPiA+ID4gc3RhcnRlZCBhZ2FpbiBhcyBxdWlja2x5IGFzIHBvc3NpYmxl
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgMTAwJSBhZ3JlZSB3aXRoIHRoZSBhYm92ZS4gSG93
ZXZlci4uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gRGV0ZWN0aW9uIG9m
IG5ldyBmZWF0dXJlcywgZXRjDQo+ID4gPiA+ID4gPiBjYW4gd2FpdCB1bnRpbCB0aGUgY2xpZW50
IG5lZWRzIHRvIHJlc3RhcnQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQSBzZXJ2ZXIgcmVib290
IGNhbiBiZSBwYXJ0IG9mIGEgZmFpbG92ZXIgdG8gYSBkaWZmZXJlbnQNCj4gPiA+ID4gPiBzZXJ2
ZXIuIEkNCj4gPiA+ID4gPiB0aGluayBjYXBhYmlsaXR5IGRpc2NvdmVyeSBuZWVkcyB0byBoYXBw
ZW4gYXMgcGFydCBvZiBzZXJ2ZXINCj4gPiA+ID4gPiByZWJvb3QNCj4gPiA+ID4gPiByZWNvdmVy
eSwgaXQgY2FuJ3QgYmUgb3B0aW1pemVkIGF3YXkuDQo+ID4gPiA+IA0KPiA+ID4gPiBDYW4geW91
IGNsYXJpZnkgd2hhdCB5b3UgbWVhbiBieSBhICJmYWlsb3ZlciB0byBhIGRpZmZlcmVudA0KPiA+
ID4gPiBzZXJ2ZXIiPw0KPiA+ID4gDQo+ID4gPiBJUC1iYXNlZCBmYWlsb3ZlciBtZWFucyB0aGF0
IGEgc2VydmVyIGNhbiBjcmFzaCwgYW5kIGl0cyBwYXJ0bmVyDQo+ID4gPiBjYW4NCj4gPiA+IGRl
dGVjdCB0aGF0IGFuZCB0YWtlIG92ZXIgdGhlIElQIGFkZHJlc3MgYW5kIGV4cG9ydHMgb2YgdGhl
DQo+ID4gPiBmYWlsZWQNCj4gPiA+IHNlcnZlci4gVGhlIHJlcGxhY2VtZW50IHNlcnZlciBkb2Vz
bid0IGhhdmUgdG8gaGF2ZSBleGFjdGx5IHRoZQ0KPiA+ID4gc2FtZQ0KPiA+ID4gc2V0IG9mIGNh
cGFiaWxpdGllcy4NCj4gPiANCj4gPiBTbyBpdCBjb3VsZCBhbHNvIGxvc2UgY2FwYWJpbGl0aWVz
Pw0KPiANCj4gV2VsbCwgd291bGRuJ3QgdGhlIGNsaWVudCBsb3NlIGNhcGFiaWxpdGllcyBldmVu
IG5vdz8gT3BlcmF0aW9ucw0KPiByZWx5aW5nIG9uIHRob3NlIGNhcGFiaWxpdGllcyB3b3VsZG4n
dCB3b3JrIChpZS4sIHNheSBzZWN1cml0eSBsYWJlbA0KPiB3b3VsZG4ndCBiZSByZXR1cm5lZCBv
ciBhbiBvcGVyYXRpb24gd291bGQgZXJyb3Igd2l0aCBFTk9UU1VQUCkuIEFuZA0KPiBJDQo+IHRo
aW5rIHdoZW4gaXQgY29tZXMgdG8gb3BlcmF0aW9ucywgdGhhdCdzIGZpbmUgYXMgdGhlIGNhcGFi
aWxpdHkNCj4gd291bGQNCj4gdGhlbiBiZSBhZGp1c3RlZCAocmVtb3ZlZCkuDQo+IA0KPiBUbyBt
YWtlIGl0IGNsZWFyIGFnYWluLCBJJ20gbm90IHN1Z2dlc3RpbmcgdG8gZG8gaXQgYXQgc2VydmVy
IHJlYm9vdA0KPiBhcyBpdCB3YXMgcG9pbnRlZCBvdXQgdG8gY2F1c2UgcGVyZm9ybWFuY2UgcHJv
YmxlbXMuDQo+IA0KDQpZZXAuIFRoZSByZWFzb24gd2h5IEknZCBiZSBtb3JlIHRvbGVyYW50IG9m
IHRoaXMgaW4gdGhlIGNhc2Ugb2YNCm1pZ3JhdGlvbi9zZXJ2ZXIgZmFpbG92ZXIgaXMgYmVjYXVz
ZSBpbiB0aGF0IGNhc2UsIHRoZSBjbGllbnQgaXMNCmFscmVhZHkgZXhwZWN0ZWQgdG8gdHJhd2wg
dGhlIHZhcmlvdXMgbW91bnRwb2ludHMgZm9yIE5GUzRFUlJfTU9WRUQNCmVycm9ycywgYW5kIHJ1
bm5pbmcgZnNfbG9jYXRpb25zIHByb2JlcyBhbnl3YXkuIFRoZSBwcm9jZXNzIGlzIGFscmVhZHkN
CnNsb3cgYW5kIGRpc3J1cHRpdmUsIHNvIHRocm93aW5nIGluIGFuIGZzaW5mbyBwcm9iZSB0byB0
aGUgbmV3IHNlcnZlcg0KaXNuJ3QgcmVhbGx5IGEgYmlnIGRlYWwuDQoNCj4gPiBJJ20gYSBsaXR0
bGUgbmVydm91cyBhYm91dCBzZXJ2ZXIgZmVhdHVyZXMgYmVpbmcgY2hhbmdlZCBvdXQgZnJvbQ0K
PiA+IHVuZGVyDQo+ID4gdGhlIGNsaWVudCB3aGlsZSB0aGUgY2xpZW50IGhhcyB0aGUgc2VydmVy
IG1vdW50ZWQuDQo+ID4gDQo+ID4gQnV0LCBJIGRvbid0IGtub3csIGxvb2tpbmcgcXVpY2tseSB0
aHJvdWdoIHRoZSBsaXN0IG9mIE5GU19DQVBfKg0KPiA+IGRlZmluaXRpb25zIGluIG5mc19mc19z
Yi5oLCBJJ20gbm90IGNvbWluZyB1cCB3aXRoIGEgY2FzZSB3aGVyZSB3ZQ0KPiA+IGNvdWxkbid0
IGhhbmRsZSBpdCwgbWF5YmUgaXQncyBPSy4NCj4gPiANCj4gPiAtLWIuDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
