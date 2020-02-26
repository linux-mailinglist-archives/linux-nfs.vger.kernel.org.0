Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93E7170CC4
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2020 00:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBZXsu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Feb 2020 18:48:50 -0500
Received: from mail-mw2nam12on2123.outbound.protection.outlook.com ([40.107.244.123]:33159
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbgBZXsu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 26 Feb 2020 18:48:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSFGSyTGZUuZp3j1tyKujKgxjVGAbsK2rS8WxDWF7yYhPSlfQQLH76QJl4rXJERkvyYx8OxkK6Oy8RWGWkQ2kdWXM13Ioe9zSypXPR316DDgRxK7sX/DQ3NLisWL0KNC3bONtH/LwE9SFP+w63Q6qTKN8mVlARmEk57INqQ6box5pJ24c/h11MBOQkJpknTLaiHKviM92xjxTTlspWM8k9Vg6xfe+gC+Ha+s95n/QTCNT+XqMylCmZwzHbvcXy3za81huk13SEfYQUyTnECW8bWR6BgsW7KlJUOiTtspn2H6+M3RZDHw0UG9mZ3Wh4MYEDA3mJfrIXi7xFDCr1vJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPyw0v25Qvno1Cf7DwCdSeEmpUJylYk93NguLzlIq5A=;
 b=JFFh6UZ+GqmeIZhHI88u7Z7BhFkL03f1i02JGqp3ss+iltCibU7JvnH/tha97tWGLx2w9xmVJLXESjaAk1aCqVUZ/OzKZldHkHGyhLUrUAXXSKgI/4/VO96HvpoBaye/9BVOO2OhK7z8y8qkVrb8WdOMg8KxfCoagkFdVGXdAodSBV0XFNiF8nJO5FtJiUBI9g1saAtJhH+4X1YIN+KZ4xr3R36FwWtSVnX75h9B65gjFhafMUM52EoCwo67plmYTbi2My6kbv7G35J2bYBIVS2wSDN581I4ijKPODmN8Fo3vHVlRrJ/AQPp5Xk7w9+tnxuzW8RbYvSuQ77byimYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPyw0v25Qvno1Cf7DwCdSeEmpUJylYk93NguLzlIq5A=;
 b=T7OmBHm9nQKXfoX5wj+Fdct+M/ucrA0oF4R28v3qSBjblAScNx/jQfMLrV+VEAU8NdLDPh3GKLd0qQH3+Kf0m/Uev0c9p3/3egclws2FXibldIUvMvuoswTBYhb4kGrXy3MsAxYmb8BJrEwrlTZjsHMBe8hjpJmbY6Z/g8AXnNQ=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (2603:10b6:4:34::34)
 by DM5PR1301MB2204.namprd13.prod.outlook.com (2603:10b6:4:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.12; Wed, 26 Feb
 2020 23:48:47 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2772.012; Wed, 26 Feb 2020
 23:48:47 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: check for allocation failure from mempool_alloc
Thread-Topic: [PATCH] NFS: check for allocation failure from mempool_alloc
Thread-Index: AQHV7P6JoOM0TXsPEkCbz3bKkoYohaguJJQA
Date:   Wed, 26 Feb 2020 23:48:47 +0000
Message-ID: <12d1e7a2ce5b0c64dfd81aeda75879c460e59fcb.camel@hammerspace.com>
References: <20200226234320.7722-1-colin.king@canonical.com>
In-Reply-To: <20200226234320.7722-1-colin.king@canonical.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ad27ea8-8343-4d4f-939f-08d7bb166c35
x-ms-traffictypediagnostic: DM5PR1301MB2204:
x-microsoft-antispam-prvs: <DM5PR1301MB220402423513EC713E637F8EB8EA0@DM5PR1301MB2204.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(39840400004)(376002)(199004)(189003)(86362001)(71200400001)(5660300002)(54906003)(91956017)(110136005)(66476007)(66556008)(36756003)(64756008)(66446008)(66946007)(6506007)(6486002)(8936002)(478600001)(26005)(186003)(6512007)(2906002)(81166006)(76116006)(316002)(4326008)(8676002)(2616005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2204;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXgD0Vb9R1z6EnE9VhvNqHHw2hGXIdjqkJUVf1xWZcJaQ2y7y2S8ezwSDP2U13lhETsTJ/ugprj8H3KBk9O0vXRb0TBWSM6vlsVQ6Uic7mpKwWwS4f4fCIvMs1luGzPwY8unZdH5baDEhlWhXIx6R/TCm1PkrrxZvwFPgOD4XknmOwvMeZkORaOTj0hC+3xReNhwd5m+rCP6yEolO9Vsz6v1Kje5czQ9v8iEz6w0eOoLUJiV+7mkbpDC1ZoZyEqLGrB+l8PWQcwSJsbVWhiSCc02462DumD+lHkFPTLGi0LP3LKMJ7EGN6eYecn/cTCva+WmbvHBvDB66gN9CvwxUWElHBoUaiGZEyOU+pSH1+i5MfaQVmkOoADbSMZlQD0/lpnbxwe/P51B/Iv8dhYU8bPZhmWCczyhqfCLrEOexHfzQmSYCPc9M0knqhSNoliU
x-ms-exchange-antispam-messagedata: yQAeAB87yJbXpXiMGMXhy625HFuAkM0zz7z5zxLyc2Vwfv3v7Y0Z8aNqVtYOnluMA14LVoZrvcD9loh/zQ6wSDjZyjpdf7oz3ji7lxV+QRiC7TPMXAQH/ku0cLUjqGVv3U01BS3v2rQWslmtnHejrg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A602D5C6C4E98468DC90270779AADE3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad27ea8-8343-4d4f-939f-08d7bb166c35
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 23:48:47.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gP00EH24aALU58p/6EbI//Uv6p1LcRZkzAUxZ91PfBGszbQ05RFPxVqPMjRvoUY6QehVSSlaXp7EwxG8Lz9UNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2204
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTI2IGF0IDIzOjQzICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gSXQg
aXMgcG9zc2libGUgZm9yIG1lbXBvb2xfYWxsb2MgdG8gcmV0dXJuIG51bGwgd2hlbiB1c2luZw0K
PiB0aGUgR0ZQX0tFUk5FTCBmbGFnLCBzbyByZXR1cm4gTlVMTCBhbmQgYXZvaWQgYSBudWxsIHBv
aW50ZXINCj4gZGVyZWZlcmVuY2Ugb24gdGhlIGZvbGxvd2luZyBtZW1zZXQgb2YgdGhlIG51bGwg
cG9pbnRlci4NCg0KVW1tLCBuby4gVGhhdCB3b3VsZCBiZSBhIGZhbHNlIHBvc2l0aXZlIGJ5IGNv
dmVyaXR5Lg0KDQpJZiB5b3UgbG9vayBhdCB0aGUgaGlzdG9yeSBvZiB0aGF0IGZ1bmN0aW9uLCB5
b3UnbGwgbm90ZSB0aGF0IHdlDQpvcmlnaW5hbGx5IGhhZCB0aG9zZSBjaGVja3MsIGJ1dCB0aGF0
IE5laWwgQnJvd24gcmVtb3ZlZCB0aGVtIGFmdGVyDQphbmFseXNpcyBvZiB0aGUgbWVtcG9vbF9h
bGxvYygpIGZ1bmN0aW9uLiBIZSBkZXRlcm1pbmVkIChjb3JyZWN0bHksIEkNCmJlbGlldmUpIHRo
YXQgYW55IHZhbHVlIHRoYXQgaW5jbHVkZXMgR0ZQX1dBSVQgY2Fubm90IGZhaWwgdG8gcmV0dXJu
IGENCnZhbGlkIHBvaW50ZXIuDQoNCj4gDQo+IEFkZHJlc3Nlcy1Db3Zlcml0eTogKCJEZXJlZmVy
ZW5jZSBudWxsIHJldHVybiIpDQo+IEZpeGVzOiAyYjE3ZDcyNWY5YmUgKCJORlM6IENsZWFuIHVw
IHdyaXRlYmFjayBjb2RlIikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGlu
LmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvd3JpdGUuYyB8IDMgKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMv
bmZzL3dyaXRlLmMgYi9mcy9uZnMvd3JpdGUuYw0KPiBpbmRleCBjNDc4Yjc3MmNjNDkuLjdjYTAz
NjY2MGRkMSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL3dyaXRlLmMNCj4gKysrIGIvZnMvbmZzL3dy
aXRlLmMNCj4gQEAgLTEwNiw2ICsxMDYsOSBAQCBzdGF0aWMgc3RydWN0IG5mc19wZ2lvX2hlYWRl
cg0KPiAqbmZzX3dyaXRlaGRyX2FsbG9jKHZvaWQpDQo+ICB7DQo+ICAJc3RydWN0IG5mc19wZ2lv
X2hlYWRlciAqcCA9IG1lbXBvb2xfYWxsb2MobmZzX3dkYXRhX21lbXBvb2wsDQo+IEdGUF9LRVJO
RUwpOw0KPiAgDQo+ICsJaWYgKCFwKQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKw0KPiAgCW1lbXNl
dChwLCAwLCBzaXplb2YoKnApKTsNCj4gIAlwLT5yd19tb2RlID0gRk1PREVfV1JJVEU7DQo+ICAJ
cmV0dXJuIHA7DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
