Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E62BFEFE
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 05:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKWE3k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Nov 2020 23:29:40 -0500
Received: from mail-co1nam11on2127.outbound.protection.outlook.com ([40.107.220.127]:37495
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbgKWE3k (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 22 Nov 2020 23:29:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9LXMByHYZ7BGyl5X/LdkJxgkqBIUsdWrm9M9pyd66XMBglEvsa+e285gceTjtpLBGmVZcsCM43fJspdMJvcMwn5srd9/S5TyIMpjCWzDANURLhUUP65J/Da3kUJXVJefbRpu+GnFNZI04dCzI6NnVN92DbAD4+onTeHP4QOeP2REWoP8NeC6qx/z5pdehchxerzfO5b5unR9wH0/SMbdSxRZr1KklDswVQz0krOXJLVP9PGk8Y/B7HNculyp+ihovQQ00Mci42//Zpc6awaWUOmKFCEOSqZExaTx9QAGR40w7nHFk6KtxEvv2ONRdPaHrLOa12+ejA5v2iuXKKQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMG7iHMJPpYrWLSMdmfmTwFS8fnr3+R9sQSKb/57wls=;
 b=SHKuGi62RSNx1ZrXw9m/pw1GIPw1xWsL5gl1DJ4SPffM5NmH2bglLWknrEzb2JLAThlubh29QSlLNBC/p3FU5l7r31vUswOdGeAdDIu6CrwyocYYVvs2Gtc07KBJiwYq3Y7o+F5kY7FyTDNAkB8uMW8o9qxmPButuHYhqWuJOqT6KlK+xen7w45td9ee6/S06fWtLiojA7yUcGzabbfHa3m63+sOMJs4/7b1LPByu5P4KKFY/GjxvoNHLjZd92cM/8KXHkk7chkPNdIUNqS99MIjRfKu4YBlgbeUMzcmr299kPEiE/CKPTf7WRizEh0tB0JFjBdnoYXkH2KnulZfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMG7iHMJPpYrWLSMdmfmTwFS8fnr3+R9sQSKb/57wls=;
 b=XQHfdLcmM1f5ZLRH2sAb3WhFnftBRYMtgaW/YKSC2K53dEedQ2jzn/o1DlbfCg4XPchUpGXWm+P6eH+Gp3JGcBaLWsfDov1fvuMaoNZKjxuCI4ln2ZtiDqdq9u/NdhBj1amTVn+w5jEi2yawZyyhLgqOj/d6h8jYQGePUxpniaE=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3774.namprd13.prod.outlook.com (2603:10b6:208:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.14; Mon, 23 Nov
 2020 04:29:34 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3611.020; Mon, 23 Nov 2020
 04:29:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] SUNRPC: Don't truncate tail in xdr_inline_pages()
Thread-Topic: [PATCH 5/8] SUNRPC: Don't truncate tail in xdr_inline_pages()
Thread-Index: AQHWwRF4yd6FYecdbUORATZ5zTbL+6nU7ISAgAAz1IA=
Date:   Mon, 23 Nov 2020 04:29:34 +0000
Message-ID: <614498c69c40421f8581fd8b25633e8668959581.camel@hammerspace.com>
References: <20201122205229.3826-1-trondmy@kernel.org>
         <20201122205229.3826-2-trondmy@kernel.org>
         <20201122205229.3826-3-trondmy@kernel.org>
         <20201122205229.3826-4-trondmy@kernel.org>
         <20201122205229.3826-5-trondmy@kernel.org>
         <20201122205229.3826-6-trondmy@kernel.org>
         <0CB9471F-ACC6-42A1-8DCD-8A9E74BAF8F1@oracle.com>
In-Reply-To: <0CB9471F-ACC6-42A1-8DCD-8A9E74BAF8F1@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aede04ed-ea9c-4c8e-320f-08d88f68618f
x-ms-traffictypediagnostic: MN2PR13MB3774:
x-microsoft-antispam-prvs: <MN2PR13MB3774100F2294AFCB16B1A670B8FC0@MN2PR13MB3774.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEUDc0y0jSiLDb5uTdABpnYiq4NsxnXwdUwjwN5b2fPI9UeNF85cTYC9MZrgMnadH1k5YUwxbnuwJYqEFLAT1bl9zcm7Cc6CFpoxTLzUKyRlVmFPbA5vzuIO9vfRckS4MPY7F6iKdZ05oiNLHwtcLNI2EM5qodV8jV2d/GzHzUKUie5jvsBpx+4X/5RExuANAHIy5uvjbgauQDDB94tpVGx1QHcs3iJXO3cTxreuMCphngH+lJOQjr7Ia+WFMYLfMOcmHqKaYvOJH2S3AL0cfudldDyoLypzcY0vMgEzE/wVfEzCjAFaJvzzvse4Up8YJcZC4HsWdIiYFdut/aXXfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(396003)(376002)(91956017)(5660300002)(8676002)(110136005)(8936002)(4001150100001)(316002)(26005)(66556008)(64756008)(66446008)(186003)(66476007)(66946007)(6486002)(2616005)(76116006)(6506007)(53546011)(71200400001)(4326008)(2906002)(86362001)(478600001)(6512007)(36756003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GgzgxyX0lL1RTAZaVlLf5mBb/UXrFWXzDj/YsKd2kqzrsfChKg3I14O2JSX2hjbAjuWJegDz0bcfbug5FJdCO+Sni0hfmNZL5nsOL6/0ZHI5fa6KyqV52nQ0BBsfI9YIhCEUoi/zj0gM/lmCHEWRuaKshWIK5FswUwQ2iEdBgpika8RmNHk3RnBXmiJlsvk4isQ5NNKjpqJc1j40O/DsOHElwi7MRuA+V1TEbcTeyuEiFJorZAttzy/iQej3WL57bujAqIwJCwTW0Sh+ZTitO0A/j80hJVmJYRlGTWelEnKGCMfMqwDd34p6eaL+XFJbgYtQo3QYpnAWa6gbBNfgFCygn/J0JxzSl65a7q74BydId6UtNLYt+W1njmmM1qUaGhL0a1pOiBf7ZBLj24rAvGgAutXXlmSeuTY6I1bSSvAp2fsF+oBW0OIncVVvr2re8tS5UUo6EAq3wQ8WgioBJ7iXJDjhdFG8u4Xbibks4kAqONDSWOMNIVLLr1wD0zUccsNe7oAOexm7Rz2+D5ETEIECs6WjlPR3fBpbGcjZn0Js0YYJ/YCmJn0xViFrSS+oK6XhyssYNqYdbn0yfMNocLBo0zFvEeZP4yxXqTrS85nVJqRCQhsgKGPyZpXwobXVWQqOWBuSgy9vIX0gMfpvJg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <73B7F23F0C33DD4E9155FF5E4929F831@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aede04ed-ea9c-4c8e-320f-08d88f68618f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 04:29:34.8283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmDKSy4nN6j0VszLuVXdW8mm85RhLkyy+P3NNZG8pR0i2Voqr43P/Ir4gQWDnGXE7bdOhFUszsIUfhPrGvMZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3774
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU3VuLCAyMDIwLTExLTIyIGF0IDIwOjI0IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIE5vdiAyMiwgMjAyMCwgYXQgMzo1MiBQTSwgdHJvbmRteUBrZXJuZWwub3Jn
wqB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gVHJ1ZSB0aGF0IGlmIHRoZSBsZW5ndGggb2Yg
dGhlIHBhZ2VzW10gYXJyYXkgaXMgbm90IDQtYnl0ZSBhbGlnbmVkLA0KPiA+IHRoZW4NCj4gPiB3
ZSB3aWxsIG5lZWQgdG8gc3RvcmUgdGhlIHBhZGRpbmcgaW4gdGhlIHRhaWwsIGJ1dCB0aGVyZSBp
cyBubyBuZWVkDQo+ID4gdG8NCj4gPiB0cnVuY2F0ZSB0aGUgdG90YWwgYnVmZmVyIGxlbmd0aCBo
ZXJlLg0KPiANCj4gVGhpcyBkZXNjcmlwdGlvbiBjb25mdXNlcyBtZS4gVGhlIGV4aXN0aW5nIGNv
ZGUgcmVkdWNlcyB0aGUgbGVuZ3RoIG9mDQo+IHRoZSB0YWlsLCBub3QgdGhlICJ0b3RhbCBidWZm
ZXIgbGVuZ3RoLiIgQW5kIHdoYXQgdGhlIHJlbW92ZWQgbG9naWMNCj4gaXMNCj4gZG9pbmcgaXMg
dGFraW5nIG91dCB0aGUgbGVuZ3RoIG9mIHRoZSBYRFIgcGFkIGZvciB0aGUgcGFnZXMgYXJyYXkN
Cj4gd2hlbg0KPiBpdCBpcyBub3QgZXhwZWN0ZWQgdG8gYmUgdXNlZC4NCg0KV2h5IGFyZSB3ZSBi
b3RoZXJpbmcgdG8gZG8gdGhhdD8gVGhlcmUgaXMgbm90aGluZyBwcm9ibGVtYXRpYyB3aXRoIGp1
c3QNCmlnbm9yaW5nIHRoaXMgdGVzdCBhbmQgbGVhdmluZyB0aGUgdGFpbCBsZW5ndGggYXMgaXQg
aXMsIG5vciBpcyB0aGVyZQ0KYW55dGhpbmcgdG8gYmUgZ2FpbmVkIGJ5IGFwcGx5aW5nIGl0Lg0K
DQo+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IG5ldC9zdW5ycGMveGRyLmMgfCAzIC0tLQ0KPiA+
IDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9u
ZXQvc3VucnBjL3hkci5jIGIvbmV0L3N1bnJwYy94ZHIuYw0KPiA+IGluZGV4IDNjZTBhNWRhYTll
Yi4uNWE0NTAwNTU0NjlmIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9zdW5ycGMveGRyLmMNCj4gPiAr
KysgYi9uZXQvc3VucnBjL3hkci5jDQo+ID4gQEAgLTE5Myw5ICsxOTMsNiBAQCB4ZHJfaW5saW5l
X3BhZ2VzKHN0cnVjdCB4ZHJfYnVmICp4ZHIsIHVuc2lnbmVkDQo+ID4gaW50IG9mZnNldCwNCj4g
PiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgdGFpbC0+aW92X2Jhc2UgPSBidWYgKyBvZmZzZXQ7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoHRhaWwtPmlvdl9sZW4gPSBidWZsZW4gLSBvZmZzZXQ7DQo+ID4g
LcKgwqDCoMKgwqDCoMKgaWYgKCh4ZHItPnBhZ2VfbGVuICYgMykgPT0gMCkNCj4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGFpbC0+aW92X2xlbiAtPSBzaXplb2YoX19iZTMyKTsN
Cj4gPiAtDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHhkci0+YnVmbGVuICs9IGxlbjsNCj4gPiB9DQo+
ID4gRVhQT1JUX1NZTUJPTF9HUEwoeGRyX2lubGluZV9wYWdlcyk7DQo+ID4gLS0gDQo+ID4gMi4y
OC4wDQo+ID4gDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KPiANCj4gDQo+IA0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
