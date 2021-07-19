Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094693CD454
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhGSL0X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 07:26:23 -0400
Received: from mail-sn1anam02on2125.outbound.protection.outlook.com ([40.107.96.125]:62366
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236440AbhGSL0X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Jul 2021 07:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKuiFhZ+GW4SWEfBeV5oLinwxXFD3a1Ey8saMQpdZ5DbOE62JqizAV/Cp/cAL4N/xk5NLO2wuOxYvwyc+dLJwNwnknwrGL93eNV2FenAQofYCoWNs6PkvWxGmn5gP1RY+yUSzde3GjDRmzJe9tIsw7zc0vG/oKrx5qfRY8WVBisNdxFKvBZ/g1fgmaWDTbUrcgb7UXz8Cj1gbGkT6BPODbWvc+Vv3bUF9ZWl2KeZH2QshYvgttXPNESBZ3YzqUjtw5S8tSCbCGwmGrhjIh9+SVRCaejsPNVR64TioaJvbIbd9CxNZwbhDjp49NiL+tR1fnFd7Vdg4W8Jpn8ZJaZkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0BAr8EHTqjJWswIVczULX21/oJh+LBqJPLGZuaJ/T8=;
 b=jm8q6AK+34M697q8apaXLTY6pBK0yjhba9fHuKJEJoDAdoO7hQ6iL5G6/uaExZQ5uvptpOiJRFoaFBfTQ+4+tq1wZAvP0MCGP15gVSQtGcYrarkODphjQpIsXrivgUhcKI9p5u+zPyPqtt+s9Ae7UGp0om7k/PPL2r98rR+0eYDfv2NIhsTbiKY3zRT9xDU7WERxa6SDGlUV4x17YhSt+5QEoUGCkbMfsC13qH1E5ToYpP/IqPjPJwRpilhe8bB1vDS4SPsrAcWQv6EQ2do5Bj9oRjoUqynzcuu5QOaxNEo9m/44Bq5Q49+0PUYSHusdlBsaG93ggFgE2e+pHQhPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0BAr8EHTqjJWswIVczULX21/oJh+LBqJPLGZuaJ/T8=;
 b=HOGE229P6vjaZMWKeblbd3tKQ6/5JCGZKGIoajypHMfDEk/W+3z9A9EL28Knfvv7WUa5HMX2ya9NPExbz696+npMytOVpPY2qTDcb3leGtkJxf4RFI4fRKE6s+E1pqFWexjXaI4eJcXJbuEPuJ9Xo0mlTNejvJhwp7eumgsgDFo=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB4553.namprd13.prod.outlook.com (2603:10b6:610:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10; Mon, 19 Jul
 2021 12:07:00 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4352.022; Mon, 19 Jul 2021
 12:07:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Convert rpc_client refcount to use refcount_t
Thread-Topic: [PATCH] SUNRPC: Convert rpc_client refcount to use refcount_t
Thread-Index: AQHXezAfzhqcwAhSGUqpu5VeF8M9JatKNTiAgAABjoA=
Date:   Mon, 19 Jul 2021 12:07:00 +0000
Message-ID: <190d0dec631a2219c4c16a41f7c17e914f625082.camel@hammerspace.com>
References: <20210717172052.232420-1-trondmy@kernel.org>
         <6AF75462-495E-4B63-9A3E-C9639C45C1F2@redhat.com>
In-Reply-To: <6AF75462-495E-4B63-9A3E-C9639C45C1F2@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 942153d4-025c-4cb5-aed7-08d94aadb6c9
x-ms-traffictypediagnostic: CH2PR13MB4553:
x-microsoft-antispam-prvs: <CH2PR13MB4553E13AC12C24548F74920BB8E19@CH2PR13MB4553.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZ3CQoeUz3mQ4GhzN6C/elwoTVfn9FvbWiLpZ+XoygNnL/SG5qARiGs579PZromqTXJtDYm1wlUPUmTeGQslcS+AR8iURBQZ0FF/ftGZXkRVehQdgR6TKf9UVTtq4rH2hTrtLk2wkm6yFiStegYS/BnUzVjZLLc8uJfWK1MuUPPf8nvBY7ej0RFk0R+C1PMiE540s1qcWodse8TUREG2XFeFecWTnPvXVvjjoPASO9/RueAE0X6Km/dBoYa7UoOfOUQDBnrPHBuM2dZGQphlkLjOAfjpqlrbEuCeRiAMzlh2XQrUcHVCzX4mh0rgXyYgHhT0UXtULkf8hfhWILk2puamPdpP6VGumtHFm0SXocepWIo/xWXFqXvXggy2ckcZ6vAvVBiRTeaqX+kcouQ7XHnlTZsOEIYiyOJ0uIZfQ6LxwK+rLh20guKVSaoD/+eSvkRYsBtyqFPmPCNkKfKxfxUArpEyBcaDBITCbEQC/PjF4Jg9dgNf1Z3MG4DWFLHPNw8rgpHnhC1b3EacwZDRWdU0+BTJR5T3cQJOhJY1J52a7jAHyl+6CKiGGDoZp7rTYkBCzQJMTdZcUC5UuHd59Ra7O+PpXKq0dMGiBIiDfWiPVuJzSimF5jMFlzwJyQK8ESmcASgAPh5m5RbIBgh4/ammhOFdmspp7RdzSnr1o1Fm+3n8RjIuy86jOypZv9USOFkVtUPmkEqZXkg5Kk+H6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(26005)(66946007)(38100700002)(122000001)(66446008)(316002)(4326008)(66476007)(66556008)(6916009)(86362001)(36756003)(508600001)(64756008)(5660300002)(6512007)(76116006)(186003)(54906003)(4744005)(2616005)(53546011)(71200400001)(2906002)(8936002)(8676002)(6506007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUViZ3ZvL3hjSVR5NUdSMXU2VVhUVGs4eDZ0c0VTQzVpSW5YckxVYTM4dmUx?=
 =?utf-8?B?cUFrR0Z0eFM0OGdiNE05T01YVm9kRUJST1dHZTBYRlBQcW93TEFLOGhpVCtG?=
 =?utf-8?B?WnJTYXI2cDJXUFJmK3IzcG5WUVpvbnd3aXVndDB3ajM4cmJWNUJpWC91cjBi?=
 =?utf-8?B?dklsNGlaNmgrdkxvdDZINEpQVzhrZThrcVZJM1dUTEhPckxZRjI4OGhoYXR1?=
 =?utf-8?B?Rm9weStCeEd2cGYvZkMwckNjWXpJVlYyQ2Q4bVhqOVFUc0pOTnRIUmdyZ1ZM?=
 =?utf-8?B?M3podUFtaGpabmh4VlNFTC94amQ0QXNRSm96a0FranhseUtsQXl4QVBUdjhZ?=
 =?utf-8?B?S25aVVRzN1pONCs1UHU4R3NJYlJ4K2JzbjNycFJyejVaVDR3UUJEWEEvZGpF?=
 =?utf-8?B?VjNEOTJRNDFyenhycE5xWmtyRTIxLzdkNDM0NXprUEFieTVXZWV3ekhUSTNw?=
 =?utf-8?B?R3FGdzNKekt5ZHdUalFrbm8vY0Q2dzExZlEzRzVMcGx6Mk1VMHZueE8xLzlD?=
 =?utf-8?B?cVFwdy9STnU0TXhYMDl1YWM0MVRnbUZCRHVETFBTZ2I3M2hVOWFpU3o5V3Bm?=
 =?utf-8?B?UndtRmZxZjdlcm5pQTk4b2s0OFlnekptYlJDdWpta2hGd0VWNkRBRFlodVJ4?=
 =?utf-8?B?MDAzVUVkdEJ3Z2w2OHl3Q201UGJxM010eWdZbzhTdXRiUk1uQ3dzMGFPWjBR?=
 =?utf-8?B?Y3FQS2FCZ1dTbUlRU3ZlSDBpRnRqYnV4WHdqT1dNNjF3ZWtxNHlERFhSMjF1?=
 =?utf-8?B?OFhGa1hmemVMbi9ha0lQZ2tqRkcwQUZyd3ZGZXFiYkdxS1Z5VFE3NnBSWU5Q?=
 =?utf-8?B?NW5CSUpaOVUxZU9VdDA3bjEvb2JNTzJYYktmSTRnT1JZZXRIemUxMDg5Wjk0?=
 =?utf-8?B?SitESWJmbGc1Q21NUmlISHR3VEtzODZkYjZEQTVFNTR5eFN3T2drSUllc1pZ?=
 =?utf-8?B?STA5VVhCbkw0MHVISVgxdzc2cUFnRGJybEZJQXZRdE5hd2sremxma2JydDZM?=
 =?utf-8?B?dW1TaFlqYWN1L2phL1R2cUJMZXJjc2k4RGRqQ1k1Y2lpK2JMZ0RZK3ZYcE9P?=
 =?utf-8?B?OTBoTko2T0xMSXVGOWVEaHh5YXNoS1RpTWN6dldic2pIYkplcGFHbVhUdGRC?=
 =?utf-8?B?bUd2ZzBiUFRzUjVvK3hTSW5PS2Q4NzFQQm0rQXY2cTRpMTNzZTdUZmFZNmlM?=
 =?utf-8?B?S2t2ZmlNcXRoY2pRa1RMbjRhQjhZRlBDcnVzaGhUcW1tTGllNTE2Um1oeUhy?=
 =?utf-8?B?TlBZUmFpSnFFRmUwclVBS1lZK2JJNE9XMm5NUStnQzExVzc3Q21IeC92Nitw?=
 =?utf-8?B?cUZLQ29aZ1ViTFlMZ2dUa0hYZTJyejhWZUNYekl1dkQrKzl2cTRma2RBUUd1?=
 =?utf-8?B?WjY1K1lvaE5xVEpUU29UR0tlZmRpZmlOclp2bEEycGZ0WGsyWWJSM2ZpaEhr?=
 =?utf-8?B?ZkRBSU5YbmVaQ3lIdUJNb01xNGRTV3Z3L2NwM2NzK0ZXK3ViNWRwNjZ1d0cv?=
 =?utf-8?B?NU5zdGRhUGNWZkdFUlkrcGhBTlFxSHBqRENtQ3U3L2FWVkRrNHpCbVlPak9u?=
 =?utf-8?B?eXlKWUloWlRmRWZwWkFPYVVGVGdsTUhVKzNvZTBWemlVdUZER2dGdW5jMkhZ?=
 =?utf-8?B?WDF0aDVkYXA3RDVWQk9WdlNRTFN2TDRaYlhhNnh5RjhzOERIZlM5aFU2ZzZ6?=
 =?utf-8?B?eGEvakxKL1ZScnorU3M2Q0RkdFhmSXlwTER5ZlU4ODM4SFZSWDk2UTR5MFlC?=
 =?utf-8?Q?YWXbNiwPG9aOtZxQgGXtqlJYfoO9a2C62aCyaiv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F6441F4BE7D8F4B942AD0DAA7921BD0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942153d4-025c-4cb5-aed7-08d94aadb6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 12:07:00.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1kkLtRFn6txmuXkzd5Y/QdJSA245c3efGdA8lF2ys+0ZJuAsZGUTQzOPn89nw/qoWsDAImmmRRCXvqA+9+pKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4553
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTE5IGF0IDA4OjAxIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBIaSBUcm9uZCwNCj4gDQo+IE9uIDE3IEp1bCAyMDIxLCBhdCAxMzoyMCwgdHJvbmRt
eUBrZXJuZWwub3JnwqB3cm90ZToNCj4gDQo+ID4gQEAgLTk0Myw3ICs5NDEsNyBAQCBycGNfcmVs
ZWFzZV9jbGllbnQoc3RydWN0IHJwY19jbG50ICpjbG50KQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqBk
byB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobGlzdF9lbXB0eSgm
Y2xudC0+Y2xfdGFza3MpKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHdha2VfdXAoJmRlc3Ryb3lfd2FpdCk7DQo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmICghYXRvbWljX2RlY19hbmRfdGVzdCgmY2xudC0+Y2xfY291bnQp
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmVmY291bnRfZGVjX25v
dF9vbmUoJmNsbnQtPmNsX2NvdW50KSkNCj4gDQo+IEkgZ3Vlc3Mgd2UncmUgbm90IHdvcnJpZWQg
YWJvdXQgZXh0cmEgY2FsbHMgcmFjaW5nIGludG8NCj4gcnBjX2ZyZWVfYXV0aD8NCg0KVGhlIHJl
ZmNvdW50IHdvdWxkIG5vcm1hbGx5IGJlIGdvaW5nIHRvIHplcm8gaW4gdGhlIGFib3ZlIGNhc2Uu
IElmDQphbnl0aGluZyBvdXRzaWRlIHRoZSBSUEMgY29kZSBpdHNlbGYgdHJpZXMgdG8gYnVtcCB0
aGUgY291bnRlciB0aGVuDQp0aGF0IGlzIGEgdmVyeSBjbGVhciBjdXQgY2FzZSBvZiB1c2UtYWZ0
ZXItZnJlZS4NCg0KPiANCj4gLi4gaG1tLCBpdCBsb29rcyBsaWtlIGN1cnJlbnQgY29kZSBjYW4g
ZG8gdGhhdCBhbHJlYWR5IHNpbmNlIHdlJ3JlDQo+IGJ1bXBpbmcgdGhlDQo+IHJlZiB1cCBhZ2Fp
bi7CoCBTZWVtcyBsaWtlIHdlIGNvdWxkIGVuZCB1cCBpbiBycGNhdXRoX3JlbGVhc2UgdHdpY2UN
Cj4gd2l0aA0KPiBhbiB1bmRlcmZsb3cgb24gYXVfY291bnQuDQo+IA0KDQpBcyBJIHNhaWQsIG9u
bHkgaWYgdGhlcmUgaXMgYSB1c2UtYWZ0ZXItZnJlZSBidWcgc29tZXdoZXJlIGVsc2UuDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
