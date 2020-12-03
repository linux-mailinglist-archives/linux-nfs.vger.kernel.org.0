Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC32CDFD2
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 21:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgLCUkv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 15:40:51 -0500
Received: from mail-dm6nam12on2098.outbound.protection.outlook.com ([40.107.243.98]:4769
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727348AbgLCUkv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 15:40:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhUFQ9funOXXW1pnMFc6J4dTUe9BaMldB9neGuSXhkMZL62lRJAX65Ol0LtjSUKSdIrGWOmlAgUI++XR0DAD0ZF0waFWe2suGBbKhwArmMC4OJXwkLfTtz4KDzsS7E3eMiIgSqKNIFDLVCSs+0LmnJivPn5p7ZRokYqw149OakeI4lxENTIXHqQ+uK2n22Qa5RNwSQTx0JK8ROpY3+d31uYt7El6CJCv54HHp2q9ROYi7nL7ogo5qCjZzmoWCsMgO9lrAAlbWU1USjuFjWahcK8gDKcaFNCuTn6CoiyZyHUZXOZkF9gMCPmXmUlkxMjayeJVarU1n5sHvDt84I+HeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWxO8xcBaPHz7Lz/ytJXXmwh7psmRQRZYfb5ttmDCFA=;
 b=bsSdFCy1maxkvdMkdZBT4ig1BcYEkA4QVN1ExC1y/O5ig9g5FT70QnnmEeaA6C3Yjv/BwxUkSA9gs9y7hYY9fe7Z24Agfj9wR5/VEzodaY+FIakkTiMCUBit8EUf4pKtujT+ZB49qxEMvXoWVX93CBU7O8+0iklKbdj4c9KO6CjxqEmbqQERnv9hbqABLERbr3xZs9cbJTrtagZSkehdItNFH5wDeVWMZ5adRb+DCsFAxMLxP7BOPe5srAxFZDGan4+Je3XobXifZyCrHHSIesUGojALpYOp34XasK6t7EQNFPfKkkkE9HvnY2Ad4D0BChgSDY8SHrIJtzpSonfNdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWxO8xcBaPHz7Lz/ytJXXmwh7psmRQRZYfb5ttmDCFA=;
 b=AOEaTmfwc2JQ9ofhyShjZfp+wE0frhs2ah7D4s7FuKFQZahoLzhGmZX5xfIT92x2iV2QZdQzSrU88n6N98s0h20/tUODs7o40aj7m+RnhYvyr5LKc6raXjqwPX1sIhCfxzLypJOlVlL8edxARep2iglx3mhscoD0VJq3sFLO998=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3408.namprd13.prod.outlook.com (2603:10b6:208:158::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Thu, 3 Dec
 2020 20:39:57 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 20:39:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] NFS: Allocate a scratch page for READ_PLUS
Thread-Topic: [PATCH 2/3] NFS: Allocate a scratch page for READ_PLUS
Thread-Index: AQHWybGxDfdcMTyCBUi+T2dnzB5n8qnl0fQAgAABLACAAAJmgA==
Date:   Thu, 3 Dec 2020 20:39:57 +0000
Message-ID: <dc191256b163d0c824c911fe7272d5443f2fd045.camel@hammerspace.com>
References: <20201203201841.103294-1-Anna.Schumaker@Netapp.com>
         <20201203201841.103294-3-Anna.Schumaker@Netapp.com>
         <8CE5CE8C-9301-4250-B077-ACE23969C19A@oracle.com>
         <CAFX2JfnsHskDd+tsGcZ1-JNaWpZ9V4c-5=x2VE4mwC6p+MhfYQ@mail.gmail.com>
In-Reply-To: <CAFX2JfnsHskDd+tsGcZ1-JNaWpZ9V4c-5=x2VE4mwC6p+MhfYQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deea5185-1641-46dd-fcc8-08d897cb98d2
x-ms-traffictypediagnostic: MN2PR13MB3408:
x-microsoft-antispam-prvs: <MN2PR13MB3408C8D148DFD8D364124F44B8F20@MN2PR13MB3408.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+Zpzn1Qho1TbPI6KqE05O1Z7JECVA7JDIqa7nvpd4JbDVJKB3WmavYpIRgyfzzdCIfNZV4458kOC7RRArZuqJhRrSiIzRQcN1XmdsnGp22gijKt+XCioC4+s6ZEW46JoFa5vEpMwIEdpKxv+haJ77MylPC4f0TD/g13aQX27Xu+DkyeP9C9GSxGbmvacgxfp8OL66rgkw7dvEvybSVJP1PjqGYomxW9DAj87EbJqLQ4GCFrENtxuOtp3SSBz8tRJyBoYN5OVN8MHA0PURpl8zsq/wH3qdmpYokzUB5Aby/fDrVMVzODF8AgqdBYUfAhx2qvbUsc8HZRRp8oYNktZ4gQS9QBvcl1/dbdF0Q4VqMv9O0PRPj5eK+49XeAJLpOqmqsDzcOTnrIPnmEVKr3Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(39840400004)(396003)(136003)(186003)(5660300002)(6486002)(76116006)(478600001)(91956017)(6512007)(53546011)(966005)(26005)(316002)(6506007)(71200400001)(110136005)(66446008)(64756008)(66476007)(66556008)(2616005)(2906002)(83380400001)(8936002)(36756003)(8676002)(4326008)(66946007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SCtWc1MrRllJWWcyUTBKd2IyMjZDeVljeC9lS0RsbG1nRTFmbkxtZUU4WVBO?=
 =?utf-8?B?MWU3VXZKTGp1aW52WXFoYnFleXY4MzBxOCtMWkpXd2d3d1J3U1htTlBpZHlv?=
 =?utf-8?B?UThGU0JYcUZKWW9KOWZPeHhQQXJMRTYveWcybC90QXg2L2MyRyt1cG1OTHJX?=
 =?utf-8?B?ZUxRZjlwMjdQR0lmVjBBdjdPRTFSUnM3bWhOdjFmeWdsZTYxeUl1bFVWZ1Yy?=
 =?utf-8?B?N0VGQXN4cExQb0R3a1ZTV3NhSkVxYTFkek1wZHBVUzFhdlFaSFhzUWNHVmxX?=
 =?utf-8?B?em95dGJYYXVnQTVMdG4wbHFHd3gwL3Z0VVBrQlhhSTZTNi9TL2MrRHZxcUhH?=
 =?utf-8?B?VlNwQnF0SFFVMWRySEVuRFNlVHZ4OUNrTDZjM0hXZXBmclJ4UjJHY1MyZE1W?=
 =?utf-8?B?YUJEM011aWRjeUhzQjBVYzVjVm9HSzBzQzczRkMzS0k3TXNMSFd6M3Fyd2VY?=
 =?utf-8?B?dHdZYlFjcVphV3I1MDlhZUJZNENpN0plMi9uZzZRUVYxZ1RVQjZnd212U25Q?=
 =?utf-8?B?MWJMVGRyQkw4U1lVWUw3SDNGZVBhTEZvRXd4TFcvb2pSMDRPOVFRaDB1aEtH?=
 =?utf-8?B?SVZGTi9pcVI3YkEvRkxGWVdTeGlRVDRaSnAxR2FwUzZSMTZJWHhLQmNtTkN0?=
 =?utf-8?B?UVlOZ0VsWXM5ZEljMFVwWGFvdFNxdlNsYkphVFhWd0d2WHhVK3ovRzVHWS9m?=
 =?utf-8?B?MjZNZGhNWTQwejIyVnVWaVViY05vQVZlb1hOZlM2VnZsaG44S3dxdDdybnIr?=
 =?utf-8?B?aDlKRTVxOHNPczc4OFN6enBoTzNPMEIwN2xTWHdqb3huUUV6VkxydUZOYTIv?=
 =?utf-8?B?dVA4TGZnYWpoS1VLRG5WZThBcGJjN1poRUhLelQ5c2YrZ1REeEtPUjk1SG1l?=
 =?utf-8?B?M2VqQ0VJbU9IZVJyV1hNcXBrd0RwMHB6SnZuNXEzM0xHU3F1VEdhL2o4Nis4?=
 =?utf-8?B?THllUU4xRHJXbG9HZkZxMWZtRkR1RFNzbFVCTzA4dzA2VkJKRHM3MlBkdVJn?=
 =?utf-8?B?WkU1akozdHQxS1ZRWHVsR1NVb2xZNjZGQXE4ZFZLZDExVXFGN3VKUE54MHc3?=
 =?utf-8?B?eUUvbDVPNWNwVUV0VEtxN2paTVkralBrL3NWK1QvWU0zT0x5eTZtSThTL2Js?=
 =?utf-8?B?ZVRIRmprT1NJb1B0TVdQMXpIQy9IQTErSGFZR0NKNWNYWUNPWXVzekJYZEFo?=
 =?utf-8?B?SlFDV2N6UUZDOGoxOEZSYVRmZlByMFBTQ0IyelFNcDJ4d1M0dy9wRG5Xc3Nz?=
 =?utf-8?B?TWN0aVNzenNzd3NzbHVzdFFUclo0SjFqRm5wdUI3dCtEQjFFb1N1a01YM3h2?=
 =?utf-8?Q?s5KFdXmemJ/WJRUDX24VqMTYZ6VxvRWIP2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF61224970D134BA1EF692946E30C72@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deea5185-1641-46dd-fcc8-08d897cb98d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 20:39:57.0277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z53Diyo5mJ9flB6wTIgeJzPdwFFJhQBtOUAHJTui8+UUG/v/wE/ze37ad11xu+b2zmLpE0nsLmkYnezOi3EtPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3408
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE1OjMxIC0wNTAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToN
Cj4gT24gVGh1LCBEZWMgMywgMjAyMCBhdCAzOjI3IFBNIENodWNrIExldmVyIDxjaHVjay5sZXZl
ckBvcmFjbGUuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiANCj4gPiANCj4gPiA+IE9uIERlYyAz
LCAyMDIwLCBhdCAzOjE4IFBNLCBzY2h1bWFrZXIuYW5uYUBnbWFpbC5jb23CoHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiBGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBwLmNv
bT4NCj4gPiA+IA0KPiA+ID4gV2UgbWlnaHQgbmVlZCB0aGlzIHRvIGJldHRlciBoYW5kbGUgc2hp
ZnRpbmcgYXJvdW5kIGRhdGEgaW4gdGhlDQo+ID4gPiByZXBseQ0KPiA+ID4gYnVmZmVyLg0KPiA+
ID4gDQo+ID4gPiBTdWdnZXN0ZWQtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxB
bm5hLlNjaHVtYWtlckBOZXRhcHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBmcy9uZnMvbmZzNDJ4
ZHIuY8KgwqDCoMKgwqDCoCB8wqAgMiArKw0KPiA+ID4gZnMvbmZzL3JlYWQuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgMTMgKysrKysrKysrKystLQ0KPiA+ID4gaW5jbHVkZS9saW51eC9uZnNfeGRy
LmggfMKgIDEgKw0KPiA+ID4gMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczQyeGRyLmMg
Yi9mcy9uZnMvbmZzNDJ4ZHIuYw0KPiA+ID4gaW5kZXggODQzMmJkNmI5NWYwLi5lZjA5NWE1Zjg2
ZjcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9mcy9uZnMvbmZzNDJ4ZHIuYw0KPiA+ID4gKysrIGIvZnMv
bmZzL25mczQyeGRyLmMNCj4gPiA+IEBAIC0xMjk3LDYgKzEyOTcsOCBAQCBzdGF0aWMgaW50IG5m
czRfeGRyX2RlY19yZWFkX3BsdXMoc3RydWN0DQo+ID4gPiBycGNfcnFzdCAqcnFzdHAsDQo+ID4g
PiDCoMKgwqDCoMKgIHN0cnVjdCBjb21wb3VuZF9oZHIgaGRyOw0KPiA+ID4gwqDCoMKgwqDCoCBp
bnQgc3RhdHVzOw0KPiA+ID4gDQo+ID4gPiArwqDCoMKgwqAgeGRyX3NldF9zY3JhdGNoX2J1ZmZl
cih4ZHIsIHBhZ2VfYWRkcmVzcyhyZXMtPnNjcmF0Y2gpLA0KPiA+ID4gUEFHRV9TSVpFKTsNCj4g
PiANCj4gPiBJIGludGVuZCB0byBzdWJtaXQgdGhpcyBmb3IgdjUuMTE6DQo+ID4gDQo+ID4gaHR0
cHM6Ly9naXQubGludXgtbmZzLm9yZy8/cD1jZWwvY2VsLTIuNi5naXQ7YT1jb21taXQ7aD0wYWU0
YzNlOGE2NGFjZTFiOGQ3ZGUwMzNiMDc1MWFmZTQzMDI0NDE2DQo+IA0KPiBUaGFua3MgZm9yIHRo
ZSBoZWFkcyB1cCEgVGhpcyBwYXRjaCBjYW4gcHJvYmFibHkgYmUgZGVmZXJyZWQgdW50aWwNCj4g
eW91cnMgZ29lcyBpbi4NCj4gDQo+ID4gDQo+ID4gQnV0IHNlZW1zIGxpa2UgZW5vdWdoIGNhbGxl
cnMgbmVlZCBhIHNjcmF0Y2ggYnVmZmVyIHRoYXQgdGhlIFhEUg0KPiA+IGxheWVyIHNob3VsZCBz
ZXQgdXAgaXQgdHJhbnNwYXJlbnRseSBmb3IgYWxsIHJlcXVlc3RzLg0KPiANCj4gVGhhdCBjb3Vs
ZCB3b3JrIHRvbywgYW5kIHNhdmUgc29tZSBoZWFkYWNoZS4NCj4gDQoNCldoeSBub3QganVzdCBp
bnRlZ3JhdGUgaXQgaW50byB4ZHJfaW5pdF9kZWNvZGVfcGFnZXMoKSwgYW5kIHRoZW4gYWRkIGEN
Cm1hdGNoaW5nIHhkcl9leGl0X2RlY29kZV9wYWdlcygpIHRvIGZyZWUgdXAgYW55IGFsbG9jYXRl
ZCBwYWdlPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
