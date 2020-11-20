Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31662B9F7A
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 01:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgKTA6l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Nov 2020 19:58:41 -0500
Received: from mail-bn8nam12on2136.outbound.protection.outlook.com ([40.107.237.136]:45025
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgKTA6l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Nov 2020 19:58:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV5qLoGeVyQ01gMGPT+7fUkSfZMLCwvcpD35iLxgNWInUCAEaOCokw2UkW4lP9GDJK6reVZcmIjYG0XccL9w38vPVkFWRqUIBTOJR/lFyAPvjLyyG6r/htyaiMNlW/HzrKpe3XtkV6y/zkde+8DnnJYSNSEkccOOhfxn0jlDcFEtS+bTxAde0i7KbxAMhWexWMPUa0y3T6ThYtS+biXKfmvd2WSKZoEjvVRp/qyx9U83ZwPnbE/tN8w8PJRYql+k61WzJEYGi17gcSNqUaXbsf5PLgWlurKNqmPkt8aThX4Ku0SB4ZD87z77QcXkgHp2i6OEXWIo39/ihv0rcaDOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg22FmfqdqVIcLE2hVJraOIOrXSFZBUhQPG3fwlpZEo=;
 b=DssxULljSQNCXZcN0VCFPCmKM+gVAMmKJ7jhGEPxMgH02I8kqAwL3sn1nOvBoznEHL7Vj1q2ADlPoasKp9IXhspP81RvTqMQxu6nu4ExETr6O0ZMEv1PEo/jnCKtw5jUDOLOLYKUWzrDfH0PZH8HrxskCZAyVblmhQGhDpSSJ0JNXB85xltxYOWn5Z5SSAWodWebYr1qsR1b8zAvmCa5dPxt7gaqLWiPMub9cRzte76xzgO6Yi0tVJPSDfDtwTdyhMZoIJiWqwT9QfyK7f+Getp4nd7YL6APbFTT+71V+O74zf9M+s8Vx1ieqgXm+J6z8kHHHWWE5hIiL+sMNpOdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg22FmfqdqVIcLE2hVJraOIOrXSFZBUhQPG3fwlpZEo=;
 b=d/O40zUgBIp/AaRa4JxNJSmrZlkBDkEzY+OvmqsbqCRvJxQ5PxJyb4o6AO8sXq7DQLRxcUjhTWiexKlXsS/5CXu4y9jB+2O/Gve+1Cnq6vNhOpmWwArzXGBevazlu3a/KjNPKs24iExM/qpQJJAPPwzjAd3NHQgYzRkpIFmNAQY=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2669.namprd13.prod.outlook.com (2603:10b6:208:f4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.9; Fri, 20 Nov
 2020 00:58:35 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3589.016; Fri, 20 Nov 2020
 00:58:35 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
Thread-Topic: [PATCH 3/3] NFS: Avoid copy of xdr padding in read()
Thread-Index: AQHWvfkXUHuTZLUV8keMpBIY5a4z6anPgYwAgAADcYCAAACHAIAAALUAgACMwwCAACGbgA==
Date:   Fri, 20 Nov 2020 00:58:34 +0000
Message-ID: <40f07903bf0cb1b80c6fa99f3465c4b1d771b027.camel@hammerspace.com>
References: <20201118221939.20715-1-trondmy@kernel.org>
         <20201118221939.20715-2-trondmy@kernel.org>
         <20201118221939.20715-3-trondmy@kernel.org>
         <42FFB4EC-5E31-4002-92FC-7CA329479D78@oracle.com>
         <57b085d32f624986412770d10cc4daa8211ee0f4.camel@hammerspace.com>
         <D322F599-E680-4715-AD9A-CC6017AFF8E0@oracle.com>
         <6f13978155f7f6fd6cc885f9efdb13c0e890faf3.camel@hammerspace.com>
         <F2A105B4-6395-45ED-ABFF-DD6A0EBE1D79@oracle.com>
In-Reply-To: <F2A105B4-6395-45ED-ABFF-DD6A0EBE1D79@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dc590c5-206c-4423-8b4b-08d88cef6876
x-ms-traffictypediagnostic: MN2PR13MB2669:
x-microsoft-antispam-prvs: <MN2PR13MB26693EE7867E453666944587B8FF0@MN2PR13MB2669.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7XdC+niopzJwgpFiZ/rpZkB+98hUhSYunWY2YP1H3aaIAhdE3nPlXExML64X8KQfQY9hAxBou0fYyV8sjFQL6hN+OzngWDxkQwVix6S/MFKvd1Z7dFNLDbDsdanVD/Cfrl12WVedmEIi/EEwf6jA7qSrcVKNABsfEtygdTdgORRZVRAf/syng6EkRyAbqVvLU4G7OjgHWi4VETtdsl6BNJ+RdZWmNnJirzN5HqMNm9uZOZYWEqMDpU7Lpyb7oqZwQf3GRE7tzYtf1DBRQRO1qDgjb+BM0ELOg3Qx61RfscbU1KuspQIPi8hzOpd/k8TN0FNfzIPo15TqH4MmbRV5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39840400004)(376002)(346002)(6512007)(2616005)(6486002)(4326008)(5660300002)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017)(478600001)(4001150100001)(36756003)(53546011)(2906002)(8676002)(6506007)(83380400001)(186003)(316002)(6916009)(8936002)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tla1DUANEL60h4RpkVPjP879PJpwTfM/bhVWoDQdCqUVb/gPDxTyLdKgl7JQxr4TN49KfT0F/waAwAoBbeveQbPZcb2tBm/7T1GAAV8/nWo59zM8/NH7GR3mA7g86JtZXhYu3R7DakJYJiDQ9r4KUd9WFtsgWgp9eTxTbkqqOQJ+ptFEru83r5TdEI0vEw9BMCzkZxZsazMpZxePRKG+BI9pgUVjjoyfy+0j/EGLGA/Q8jYV4dyEO+fkcPgeGlZ/IXAQIqKnGzeRRWT0wpwbOy5rqH02EwuLsggWjWoOK00dzEAIXvUHWnhyqsD0yqfuEE35xWMivsEhP6Z04lo3c6/MlWqSGEZ3Qn/W7vOwDPc5n8IfRm99HJ2fRXVAzUohER7fd0gIop1DQVk2mUCZrN5XAxh9/sx7NW2qWUEJNCWgvuEzCwvI1vLCAvu6BCg3rcy0ScWBYLcX7eTrdgAR8knrdHltCDKUGkmsLz7o4icsbvWmWHHcxFlTAnIa0tBZnhwMmMUoY/YiQrNNYte8pElqmMaQeDpkeTbU8bU+vvOv+csKZ23KatWAsEzjsZRPP7TuAh/JHRBlJE6OcbsLevnwxMpxCEeCtxM9kC+vtrg4AhNWOOSRXtR+Gc2g1/bZbMnGMG5kDzAlT+XUj9K2+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <614E0B0655A61C44AF549E0F02690725@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc590c5-206c-4423-8b4b-08d88cef6876
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 00:58:34.9740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BL6s8uLUHlkdnkNhJ8mbbI02/YvZkjbVR3d9fXOSodmE6+RNtVvnsOout9Jur3icmeVz99mSG31PfdB1L0J/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2669
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTE5IGF0IDE3OjU4IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIE5vdiAxOSwgMjAyMCwgYXQgOTozNCBBTSwgVHJvbmQgTXlrbGVidXN0IDwN
Cj4gPiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAy
MDIwLTExLTE5IGF0IDA5OjMxIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiA+IE9uIE5vdiAxOSwgMjAyMCwgYXQgOTozMCBBTSwgVHJvbmQgTXlrbGVidXN0
IDwNCj4gPiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4g
PiA+ID4gT24gVGh1LCAyMDIwLTExLTE5IGF0IDA5OjE3IC0wNTAwLCBDaHVjayBMZXZlciB3cm90
ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIE5vdiAxOCwgMjAyMCwg
YXQgNToxOSBQTSwgdHJvbmRteUBrZXJuZWwub3JnwqB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tPg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBXaGVuIGRvaW5nIGEgcmVhZCgpIGlu
dG8gYSBwYWdlLCB3ZSBhbHNvIGRvbid0IGNhcmUgaWYgdGhlDQo+ID4gPiA+ID4gPiBudWwNCj4g
PiA+ID4gPiA+IHBhZGRpbmcNCj4gPiA+ID4gPiA+IHN0YXlzIGluIHRoYXQgbGFzdCBwYWdlIHdo
ZW4gdGhlIGRhdGEgbGVuZ3RoIGlzIG5vdCAzMi1iaXQNCj4gPiA+ID4gPiA+IGFsaWduZWQuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hhdCBpZiB0aGUgUkVBRCBwYXlsb2FkIGxhbmRzIGluIHRo
ZSBtaWRkbGUgb2YgYSBmaWxlPyBUaGUNCj4gPiA+ID4gPiBwYWQgb24gdGhlIGVuZCB3aWxsIG92
ZXJ3cml0ZSBmaWxlIGNvbnRlbnQganVzdCBwYXN0IHdoZXJlDQo+ID4gPiA+ID4gdGhlIFJFQUQg
cGF5bG9hZCBsYW5kcy4NCj4gPiA+ID4gDQo+ID4gPiA+IElmIHRoZSBzaXplID4gYnVmLT5wYWdl
X2xlbiwgdGhlbiBpdCBnZXRzIHRydW5jYXRlZCBpbg0KPiA+ID4gPiB4ZHJfYWxpZ25fcGFnZXMo
KSBhZmFpay4NCj4gPiA+IA0KPiA+ID4gSSB3aWxsIG5lZWQgdG8gY2hlY2sgaG93IFJQQy9SRE1B
IGJlaGF2ZXMuIEl0IG1pZ2h0IGJ1aWxkIGENCj4gPiA+IGNodW5rIHRoYXQgaW5jbHVkZXMgdGhl
IHBhZCBpbiB0aGlzIGNhc2UsIHdoaWNoIHdvdWxkIGJyZWFrDQo+ID4gPiB0aGluZ3MuDQo+ID4g
DQo+ID4gVGhhdCB3b3VsZCBiZSBhIGJ1ZyBpbiB0aGUgZXhpc3RpbmcgY29kZSB0b28sIHRoZW4u
IEl0IHNob3VsZG4ndCBiZQ0KPiA+IHdyaXRpbmcgYmV5b25kIHRoZSBidWZmZXIgc2l6ZSB3ZSBz
ZXQgaW4gdGhlIE5GUyBsYXllci4NCj4gDQo+IFRlc3Rpbmcgbm93IHdpdGggeGZzdGVzdHMsIHdo
aWNoIHNob3VsZCBpbmNsdWRlIGZzeCB3aXRoIGRpcmVjdA0KPiBJL08gb2Ygb2RkIHNpemVzLiBT
byBmYXIgSSBoYXZlbid0IHNlZW4gYW55IHVuZXhwZWN0ZWQgYmVoYXZpb3IuDQo+IA0KPiBCdXQg
SSdtIG5vdCBzdXJlIHdoYXQgY29weSB5b3UncmUgdHJ5aW5nIHRvIGF2b2lkLiBUaGlzIG9uZSBp
bg0KPiB4ZHJfYWxpZ25fcGFnZXMoKSA/DQo+IA0KPiAxMTg5wqDCoMKgwqDCoMKgwqDCoCBlbHNl
IGlmIChud29yZHMgPCB4ZHItPm53b3Jkcykgew0KPiAxMTkwwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyogVHJ1bmNhdGUgcGFnZSBkYXRhIGFuZCBtb3ZlIGl0IGludG8gdGhlIHRh
aWwNCj4gKi8NCj4gMTE5McKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldCA9
IGJ1Zi0+cGFnZV9sZW4gLSBsZW47DQo+IDExOTLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb3BpZWQgPSB4ZHJfc2hyaW5rX3BhZ2VsZW4oYnVmLCBvZmZzZXQpOw0KPiAxMTkzwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2VfcnBjX3hkcl9hbGlnbm1lbnQoeGRy
LCBvZmZzZXQsIGNvcGllZCk7DQo+IDExOTTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB4ZHItPm53b3JkcyA9IFhEUl9RVUFETEVOKGJ1Zi0+bGVuIC0gY3VyKTsNCj4gMTE5NcKgwqDC
oMKgwqDCoMKgwqAgfQ0KPiANCj4gV2Ugc2V0IHVwIHRoZSByZWNlaXZlIGJ1ZmZlciBhbHJlYWR5
IHRvIGF2b2lkIHRoaXMgY29weS4gSXQgc2hvdWxkDQo+IHJhcmVseSwgaWYgZXZlciwgaGFwcGVu
LiBUaGF0J3MgdGhlIHBvaW50IG9mDQo+IHJwY19wcmVwYXJlX3JlcGx5X3BhZ2VzKCkuDQoNCg0K
Li4uYW5kIHRoZSBwb2ludCBvZiBwYWRkaW5nIGhlcmUgaXMgdG8gYXZvaWQgdW5hbGlnbmVkIGFj
Y2VzcyB0bw0KbWVtb3J5LiBUaGF0IGlzIGNvbXBsZXRlbHkgYnJva2VuIGJ5IHRoaXMgd2hvbGUg
bWVjaGFuaXNtLCB3aGljaCBjYXVzZXMNCnVzIHRvIHBsYWNlIHRoZSByZWFsIGRhdGEgaW4gdGhl
IHRhaWwgaW4gYW4gdW5hbGlnbmVkIGJ1ZmZlciB0aGF0DQpmb2xsb3dzIHRoaXMgcGFkZGluZy4N
Cg0KRnVydGhlcm1vcmUsIHJwY19wcmVwYXJlX3JlcGx5X3BhZ2VzKCkgb25seSBldmVyIHBsYWNl
cyB0aGUgcGFkZGluZyBpbg0KdGhlIHRhaWwgX2lmXyBvdXIgYnVmZmVyIHNpemUgaXMgYWxyZWFk
eSBub3QgMzItYml0IGFsaWduZWQuIE90aGVyd2lzZSwNCndlJ3JlIGVuZ2FnaW5nIGluIHRoaXMg
cG9pbnRsZXNzIGV4ZXJjaXNlIG9mIG1ha2luZyB0aGUgdGFpbCBidWZmZXINCmRhdGEgdW5hbGln
bmVkIGFmdGVyIHRoZSBmYWN0Lg0KDQo+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJv
bmQgTXlrbGVidXN0DQo+ID4gPiA+ID4gPiA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gZnMvbmZzL25mczJ4ZHIuYyB8IDIgKy0N
Cj4gPiA+ID4gPiA+IGZzL25mcy9uZnMzeGRyLmMgfCAyICstDQo+ID4gPiA+ID4gPiBmcy9uZnMv
bmZzNHhkci5jIHwgMiArLQ0KPiA+ID4gPiA+ID4gMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvbmZzMnhkci5jIGIvZnMvbmZzL25mczJ4ZHIuYw0KPiA+ID4gPiA+ID4gaW5k
ZXggZGI5YzI2NWFkOWUxLi40NjhiZmJmZTQ0ZDcgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9m
cy9uZnMvbmZzMnhkci5jDQo+ID4gPiA+ID4gPiArKysgYi9mcy9uZnMvbmZzMnhkci5jDQo+ID4g
PiA+ID4gPiBAQCAtMTAyLDcgKzEwMiw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX25mc2RhdGEoc3Ry
dWN0DQo+ID4gPiA+ID4gPiB4ZHJfc3RyZWFtDQo+ID4gPiA+ID4gPiAqeGRyLCBzdHJ1Y3QgbmZz
X3BnaW9fcmVzICpyZXN1bHQpDQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtl
bHkoIXApKQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAtRUlPOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgY291bnQgPSBiZTMyX3RvX2NwdXAo
cCk7DQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgIHJlY3ZkID0geGRyX3JlYWRfcGFnZXMoeGRy
LCBjb3VudCk7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHJlY3ZkID0geGRyX3JlYWRfcGFn
ZXMoeGRyLCB4ZHJfYWxpZ25fc2l6ZShjb3VudCkpOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgaWYgKHVubGlrZWx5KGNvdW50ID4gcmVjdmQpKQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2NoZWF0aW5nOw0KPiA+ID4gPiA+ID4gb3V0Og0K
PiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnMzeGRyLmMgYi9mcy9uZnMvbmZzM3hk
ci5jDQo+ID4gPiA+ID4gPiBpbmRleCBkM2UxNzI2ZDUzOGIuLjhlZjdjOTYxZDNlMiAxMDA2NDQN
Cj4gPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnMzeGRyLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2Zz
L25mcy9uZnMzeGRyLmMNCj4gPiA+ID4gPiA+IEBAIC0xNjExLDcgKzE2MTEsNyBAQCBzdGF0aWMg
aW50IGRlY29kZV9yZWFkM3Jlc29rKHN0cnVjdA0KPiA+ID4gPiA+ID4geGRyX3N0cmVhbSAqeGRy
LA0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgb2NvdW50ID0gYmUzMl90b19jcHVwKHArKyk7
DQo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkob2NvdW50ICE9IGNvdW50
KSkNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dF9t
aXNtYXRjaDsNCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqAgcmVjdmQgPSB4ZHJfcmVhZF9wYWdl
cyh4ZHIsIGNvdW50KTsNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgcmVjdmQgPSB4ZHJfcmVh
ZF9wYWdlcyh4ZHIsIHhkcl9hbGlnbl9zaXplKGNvdW50KSk7DQo+ID4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoCBpZiAodW5saWtlbHkoY291bnQgPiByZWN2ZCkpDQo+ID4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXRfY2hlYXRpbmc7DQo+ID4gPiA+ID4gPiBv
dXQ6DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczR4ZHIuYyBiL2ZzL25mcy9u
ZnM0eGRyLmMNCj4gPiA+ID4gPiA+IGluZGV4IDc1NWI1NTZlODVjMy4uNWJhYTc2NzEwNmRjIDEw
MDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZnMvbmZzL25mczR4ZHIuYw0KPiA+ID4gPiA+ID4gKysr
IGIvZnMvbmZzL25mczR4ZHIuYw0KPiA+ID4gPiA+ID4gQEAgLTUyMDIsNyArNTIwMiw3IEBAIHN0
YXRpYyBpbnQgZGVjb2RlX3JlYWQoc3RydWN0DQo+ID4gPiA+ID4gPiB4ZHJfc3RyZWFtDQo+ID4g
PiA+ID4gPiAqeGRyLCBzdHJ1Y3QgcnBjX3Jxc3QgKnJlcSwNCj4gPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTzsNCj4gPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgIGVvZiA9IGJlMzJfdG9fY3B1cChwKyspOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgY291bnQgPSBiZTMyX3RvX2NwdXAocCk7DQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgIHJl
Y3ZkID0geGRyX3JlYWRfcGFnZXMoeGRyLCBjb3VudCk7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgIHJlY3ZkID0geGRyX3JlYWRfcGFnZXMoeGRyLCB4ZHJfYWxpZ25fc2l6ZShjb3VudCkpOw0K
PiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKGNvdW50ID4gcmVjdmQpIHsNCj4gPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkcHJpbnRrKCJORlM6IHNlcnZlciBj
aGVhdGluZyBpbiByZWFkDQo+ID4gPiA+ID4gPiByZXBseTogIg0KPiA+ID4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ImNvdW50ICV1ID4gcmVjdmQgJXVcbiIsDQo+ID4gPiA+ID4gPiBjb3VudCwNCj4gPiA+ID4gPiA+
IHJlY3ZkKTsNCj4gPiA+ID4gPiA+IC0tIA0KPiA+ID4gPiA+ID4gMi4yOC4wDQo+ID4gDQo+ID4g
LS0gDQo+ID4gVHJvbmQgTXlrbGVidXN0DQo+ID4gTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCj4gPiAN
Cj4gPiANCj4gDQo+IC0tDQo+IENodWNrIExldmVyDQo+IA0KPiANCj4gDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
