Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ADF2C5670
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Nov 2020 14:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbgKZNs1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 08:48:27 -0500
Received: from mail-dm6nam08on2125.outbound.protection.outlook.com ([40.107.102.125]:34273
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390078AbgKZNs0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Nov 2020 08:48:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqPx9UgesbrbQVOP+VQFF/LYMANIFePNdIYbf62afjOIi9ZBvtz41XgloO14NVLmKEbpZahbwEzLhLs9SGbW/v3PtmC2msrWNTD1ATKFnT2gu78mZuLsvA+5/sq6vVEA7aQetSH29Cc26FaHkeoQqkf/tiIPr4XavhJPfGF8FohmoPDN50NReF3tEkhXRAkx8Yvp64dfW6xRJ80NDehfpJKv7+utGmjXMIH7S5lw7fb9vrfc0KJax6UK4bOFsq1SltiUV+i9TUC4ThB7HZq2fJlyWwLwUOGmKdlrcNFhY6d5V0a7EJb24cCfPOrBFGhXBTdW3AVhKHrmQbYkhiYcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV6CnqU/vVKM9SrVXfQf4rso/l2Y2Cug1/UbJMeBhsc=;
 b=jEpBympOe0gTf0u1Me/8a5tjJh5sgiDf9s3C5xThz0DwEvFXQVwyVROWXHtLBsMQt6TyRz8TnVhRHGqUGafAKgPZRhpDQYDPT2VHf4ZZIo9cRy6Uj9cFJlQej4oJwAk0WDWk0Vb/Lxg/KLmwz9JTdE73BXo/5ctOTOl6Ot+F1pp0bAjn0oSLJhErZMY0jE106qQw0Z+KJvoGMv9/iDRvt4gvFaQJhW0+OyCbNPlhybcZ+4J0LIluNTyp8amqH/aMR9W7flh9FN1tE02HuV1hAnc/yEd9hAlWw1s7Alx5Hxpuo+lDpxbcSFATmoV4JeQ+/q3QSVsNYs6J3H3B2DWGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV6CnqU/vVKM9SrVXfQf4rso/l2Y2Cug1/UbJMeBhsc=;
 b=TMe+6R0hxJ0HlupHUPzWXTUD1qbefZvvH3Mjt2m5HW4GqiTbjLVPJ0U1bdex3dwGwLNKNjYNDm4Ylhveu9ZSu47rWkJbAyKOdgD4KJtLLGZncARkmCjrWIMRcg45di+k6Nvp1gFJ1SvgtNxhr4aX8KWitdf0nJOMn6WkrmXeY1E=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2992.namprd13.prod.outlook.com (2603:10b6:208:152::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.15; Thu, 26 Nov
 2020 13:48:23 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3611.020; Thu, 26 Nov 2020
 13:48:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan@kernelim.com" <dan@kernelim.com>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFS v3 soft mount semantics affected by commit ce368536d
Thread-Topic: NFS v3 soft mount semantics affected by commit ce368536d
Thread-Index: AQHWw+GE4ByGxrEvak+YHKx9ogrt6KnabdkA
Date:   Thu, 26 Nov 2020 13:48:23 +0000
Message-ID: <dc888c162b3a30cd1c617072ae606d9d8c6d42f3.camel@hammerspace.com>
References: <20201126104712.GA4023536@gmail.com>
In-Reply-To: <20201126104712.GA4023536@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 727e0ceb-ce29-42a4-8af1-08d89211f160
x-ms-traffictypediagnostic: MN2PR13MB2992:
x-microsoft-antispam-prvs: <MN2PR13MB2992BFE0355C1D315562FB0CB8F90@MN2PR13MB2992.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cc1ZUuKmX4NIgKSEjZnOpsDicDJSencoNQkFVs7IW6PJMn5Xo5Fgmk1YIqUuJKVP6cw60vbAJSXfztVHldEta1NpD8DBtzRGnx5ukSCdDFGpI2bfHmDXPpH8g+GegBVrXB/qQmvbEKsNNLXT7mHoEuGEOpnfyU1A+7E+UlcDxAaN7PtdaW+9/zij3gJHoMbgLbaMu1wg0KBMUJba/5n2Cj9JKiSxN8ai9EBGc2EwpsfZLWphv5K9U+RhGwuzREo/yzw50Fk8Cg8pzv81cyHvoDHFlX7c8Y8iCpNF+lNvSb6GjTWq0UbaXQi9T6S7JogR9K/PUi6Xy/Bokvy9Ug/m9wGuSGWae1Igcm7zL93KT2FcWQGV5UlWW3p8fBmSZfhvC76ibKmw4kd0jyExATT4TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(136003)(396003)(346002)(366004)(4001150100001)(5660300002)(83380400001)(71200400001)(6486002)(2616005)(86362001)(110136005)(36756003)(316002)(66446008)(64756008)(4326008)(76116006)(6506007)(66476007)(66946007)(186003)(66556008)(26005)(478600001)(966005)(6512007)(91956017)(2906002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ag/iFnLy190eqkyqkw2rQ9pBMuzmSLzgQEOucLnv3TW6F/80SWlne7m4j3UbdIaBmC8RqlQckzVxgyMyv9T8I4YhTtYHHZEiLCrPx3qn91QigOHwcRCd2vFPRjk1nqm/BDqAMoUij8Otxax/Y+jtcOwBK6u5Qh0PjAvo63oe/geboM3k3ZUdF1GJ7c8v0YkBkabONJkpBsY8CGy1xgVBapmiseKD5MI6htmwDcdO9qbVgiRYEFhjWh6I5WINFlrsc10q2vgTorpygu+2vdJBGtjQavY5N+81odKxRJuFH5mguIvyCQfCwfK1QVEydsq/HSG8tIrwtzRtUONOGjUVK8AAtsa1QuIA/GT1+snTfoeI5tj1B3imYO9Q/cEF8k8pQMsq3uBMyMwG1Lh9xWnwEflq21Te0qDR7guWlgmVQtZ6XbzneXhd04yqDANIDvZZuVCJnT5nA3rjwrLbdK2aPDgFSC2Z/brqOEnOGM5aNoMUaKoDuITc2AGqy8DdipG+msEfOznpHHCIN0cfPiRvp3uRYXGowUr+jB1rHkVLf7zMVMW/78qiN8E2+5SRIluSNwtkNs9wRyji+OuwHAAaVCwS9Vq1Fjpp8KUWWrrNrAB5VeaGzbQc40lDVZl+E8LNfntmuRWc/z9J654iQhAvL5FHgTguIG292MjQQ5uboLuqCzmz+7gTy6mTqm3LsjlxNt6lj1gBk7OL6xs0llkF4GnspGIzFndLuR8VD8yf0ayZmSN114sxxqd31XHpBKitR+3z6clWq2CSp1JOh6z5Gxs8HKUnR1RbMtZlUkK6HFdaSqMKoicZGpFSp/kgrNYhDJe/ngBv10IrppjbPxITbTz70G6CQ34zhSWx8gpzTq7SDftfW5nS3W1pcPy4AmuBSoH5yFwZ4a1QDyeTOJJdsg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E55EB971D6D35946BAF4B97FA690790F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727e0ceb-ce29-42a4-8af1-08d89211f160
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 13:48:23.3067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJ+z7PM//HLNWz/ZHNlmseU4JLiIwAuaiovpOu5XRZfGDQnQLVs0nQfRIjIJEp9MblOiiQNeP16Yh2He9QbQAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2992
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTI2IGF0IDEyOjQ3ICswMjAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IEhp
IFNjb3R0LCBUcm9uZCwNCj4gDQo+IENvbW1pdCBjZTM2ODUzNmRkNjE0NDUyNDA3ZGMzMWUyNDQ5
ZWI4NDY4MWEwNmFmICgibmZzOg0KPiBuZnNfZmlsZV93cml0ZSgpDQo+IHNob3VsZCBjaGVjayBm
b3Igd3JpdGViYWNrIGVycm9ycyIpIHNlZW1zIHRvIGhhdmUgYWZmZWN0ZWQgTkZTIHYzDQo+IHNv
ZnQNCj4gbW91bnQgYmVoYXZpb3IsIGNhdXNpbmcgYXBwbGljYXRpb25zIHRvIGZhaWwgb24gYSBz
bG93IGJhbmQNCj4gY29ubmVjdGlvbg0KPiB3aXRoIGEgcHJvcGVybHkgZnVuY3Rpb25pbmcgc2Vy
dmVyLiBJIGNoZWNrZWQgdGhpcyB3aXRoIHJlY2VudCBMaW51eA0KPiA1LjEwLXJjNSwgYW5kIG9u
IDUuOC4xOCB0byB3aGVyZSB0aGlzIGNvbW1pdCBpcyBiYWNrcG9ydGVkLg0KPiANCj4gUXVlc3Rp
b246IHdoaWxlIHRoZSBORlMgdjQgcHJvdG9jb2wgdGFsa3MgYWJvdXQgYSBzb2Z0IG1vdW50IHRp
bWVvdXQNCj4gYmVoYXZpb3IgYXQgIlJGQzc1MzAgc2VjdGlvbiAzLjEuMSIgKHNlZSByZWZlcmVu
Y2UgYW5kIHBhdGNoc2V0DQo+IGFkZHJlc3NpbmcgaXQgaW4gWzFdKSwgaXMgaXQgdmFsaWQgdG8g
YXNzdW1lIHRoYXQgYSBzaW1pbGFyIGd1YXJhbnRlZQ0KPiBmb3IgTkZTIHYzIHNvZnQgbW91bnRz
IGlzIGV4cGVjdGVkPw0KPiANCj4gVGhlIHJlYXNvbiB3aHkgaXQgaXMgaW1wb3J0YW50LCBpcyBi
ZWNhdXNlIHRoZSBmdWxmaWxtZW50IG9mIHRoaXMNCj4gZ3VhcmFudGVlIHNlZW1lZCB0byBoYXZl
IGNoYW5nZWQgd2l0aCB0aGlzIHJlY2VudCBwYXRjaC4NCj4gDQo+IERldGFpbHMgb24gcmVwcm9k
dWN0aW9uIC0gdXNpbmcgdGhlIGZvbGxvd2luZyBtb3VudCBvcHRpb246DQo+IA0KPiDCoMKgwqAN
Cj4gdmVycz0zLHJzaXplPTEwNDg1NzYsd3NpemU9MTA0ODU3Nixzb2Z0LHByb3RvPXRjcCx0aW1l
bz01MCxyZXRyYW5zPTE2DQoNClNvcnJ5LCBidXQgdGhvc2UgYXJlIGNvbXBsZXRlbHkgc2lsbHkg
dGltZW8gYW5kIHJldHJhbnMgdmFsdWVzIGZvciBhDQpUQ1AgY29ubmVjdGlvbi4gSSBzZWUgbm8g
cmVhc29uIHdoeSB3ZSBzaG91bGQgdHJ5IHRvIHN1cHBvcnQgdGhlbS4NCg0KPiANCj4gVGhpcyBp
cyBkb25lIGFsb25nIHdpdGggcmF0ZSBsaW1pdGluZyBvbiB0aGUgb3V0Z29pbmcgaW50ZXJmYWNl
Og0KPiANCj4gwqDCoMKgIHRjIHFkaXNjIGFkZCBkZXYgZXRoMCByb290IHRiZiByYXRlIDQwMDBr
Yml0IGxhdGVuY3kgMW1zIGJ1cnN0DQo+IDE1NDANCj4gDQo+IEFuZCBwZXJmb3JtaW5nIGZvbGxv
d2luZyBwYXJhbGxlbCB3b3JrIG9uIHRoZSBtb3VudHBvaW50Og0KPiANCj4gwqDCoMKgIGZvciBp
IGluIGBzZXEgMSAxMDBgIDsgZG8gKGRkIGlmPS9kZXYvemVybyBvZj14JGkgJikgOyBkb25lDQo+
IA0KPiBSZXN1bHQgaXMgdGhhdCBFSU9zIGFyZSByZXR1cm5lZCB0byBgZGRgLCB3aGVyZWFzIHdp
dGhvdXQgdGhpcyBjb21taXQNCj4gdGhlIElPcyBzaW1wbHkgcGVyZm9ybWVkIHNsb3dseSwgYW5k
IG5vIGVycm9ycyBvYnNlcnZlZCBieSBkZC4gSXQNCj4gYXBwZWFycyBpbiB0cmFjZXMgdGhhdCB0
aGUgTkZTIGxheWVyIGlzIGRvaW5nIHRoZSByZXRyaWVzLg0KPiANCj4gWzFdICANCj4gaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW5mcy9jb3Zlci8yMDE5MDMyODIw
NTIzOS4yOTY3NC0xLXRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20vDQo+IA0KDQpZZXMu
IElmIHlvdSBhcnRpZmljaWFsbHkgY3JlYXRlIGNvbmdlc3Rpb24gYnkgdGVsbGluZyB0aGUgY2xp
ZW50IHRvDQprZWVwIHJlc2VuZGluZyBhbGwgeW91ciBvdXRzdGFuZGluZyBkYXRhIGV2ZXJ5IDUg
c2Vjb25kcywgdGhlbiBpdCBpcw0KdHJpdmlhbCB0byBzZXQgdXAgdGhpcyBraW5kIG9mIHNpdHVh
dGlvbi4gVGhhdCBoYXMgYWx3YXlzIGJlZW4gdGhlDQpjYXNlLCBhbmQgdGhlIHBhdGNoIHlvdSBw
b2ludCB0byBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoaXMuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
