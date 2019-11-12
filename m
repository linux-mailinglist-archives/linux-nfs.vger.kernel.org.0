Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3321F9907
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2019 19:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKLSrF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Nov 2019 13:47:05 -0500
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:44559
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbfKLSrF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Nov 2019 13:47:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wiz9NtkIY0dU15lNEn4EjTG7mNmpw2e92cu7/LNR3dPRWslVY+AzX6xNd0nmYvOA3g4V1/qmlxdt2JMvslWzHMAqXjyzBC6sYKNGzakQtWmQVrZNoJLUg/KzN+cdsC4apYSmlZzqn2i42Uv6XcFdbkNa0XqfuCGwZBoxI1JInGkxi6sbDXPANQdD83C5wve3cocGo+nlg6PTb0hU8szBH24WxXKlXrWvaxD6LKrCSB6hatybsmYtnNZNUUT6lzZQIf5pnJVhQt40U1ymFgBNePG1knHTNj8u7oJWru8IJWmplYnS0SO37hNVBoYVkCzl/8mEJhpM5lVcpRKL3Cppcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP1X+opom7ndeZuL89qZ16uBlmKa0pJhgXe5Oh+/Pv8=;
 b=lP0RDmerF1LSdW2AGBLCaISu20AK/0YGSHyKZatsX41tLmYZel/pLRAQhBDOnTcXWEZtHjBjdAIGTCA3RNt6aTRaNDPnmZMli3RRViMjylH+aykfDoOsn2YsrVBMN2OKGyanaMAVP0eeRkIJVyWAy2rm7CfBBGcbxbGUqRBWprESzvrnGtei6jMq3DZYBd85eCRyqWbAB4jya/VaJWKfVEqAJfl3SU+NqegbJnA6iycmpQdACpIN8MKEMoj9ziBa1wylfrl5R3QMRJ0RHLCvRGYCcfI+8Yp2jJzTh6pte2krydkLfXeGvZP6h+IoWnFKbmm9AwV3pszONl5NIkUFxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP1X+opom7ndeZuL89qZ16uBlmKa0pJhgXe5Oh+/Pv8=;
 b=NYwPO0bGPyaZODvybUvcq4pvvR+S3ZBeUH2MCh25WSLcZIB2sdRxb6ZxzRxvV9pi5plh8TUFuXB1cuyFt7o95A2JjQXuI8A5MfK65umabehcz5LlT9I0onJZbLA4bRiadcaweTcfshIf78g8j/y+ymxRnDex+/glOg4iHDmpmsE=
Received: from BYAPR06MB6054.namprd06.prod.outlook.com (20.178.51.220) by
 BYAPR06MB5270.namprd06.prod.outlook.com (20.178.48.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Tue, 12 Nov 2019 18:47:02 +0000
Received: from BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::918d:490e:90f0:61f8]) by BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::918d:490e:90f0:61f8%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 18:47:02 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "navid.emamdoost@gmail.com" <navid.emamdoost@gmail.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: fix memory leak if nfs4_begin_drain_session fails
Thread-Topic: [PATCH] NFSv4: fix memory leak if nfs4_begin_drain_session fails
Thread-Index: AQHVb0mHQVf9nUcIFEq8YuaR2ZlCSKd96fMAgApKmwA=
Date:   Tue, 12 Nov 2019 18:47:01 +0000
Message-ID: <d7531388512379288c5719f152fc5ae5ecd8509a.camel@netapp.com>
References: <20190920002232.27477-1-navid.emamdoost@gmail.com>
         <CAEkB2EQ2BPpXcpRpN-+ErJD5Vkq6LiKONy8XQfvu0F1pO4weqw@mail.gmail.com>
In-Reply-To: <CAEkB2EQ2BPpXcpRpN-+ErJD5Vkq6LiKONy8XQfvu0F1pO4weqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f5dc0b8-ddd7-4f00-9989-08d767a0b4b1
x-ms-traffictypediagnostic: BYAPR06MB5270:
x-microsoft-antispam-prvs: <BYAPR06MB5270480C3E324FD3218DE2DAF8770@BYAPR06MB5270.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(66066001)(7736002)(14454004)(186003)(446003)(2616005)(4326008)(5660300002)(11346002)(478600001)(476003)(486006)(2501003)(118296001)(25786009)(6506007)(102836004)(53546011)(305945005)(91956017)(2906002)(76116006)(66946007)(26005)(81156014)(8936002)(81166006)(86362001)(8676002)(99286004)(6116002)(36756003)(6246003)(316002)(66446008)(71190400001)(71200400001)(6512007)(76176011)(6486002)(58126008)(6436002)(64756008)(256004)(110136005)(229853002)(66556008)(66476007)(54906003)(3846002)(14444005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR06MB5270;H:BYAPR06MB6054.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtI+5WmbDtjwtvgTPCwCOJIuJvxY5X+qccFkjY6ULbQ/9xlA/hjGN2Z4mfyHrVYm/COKfA+oG1/FPIy9yrhsk7QnIvIcgGzgq6su7ZcSTLw6dEzy7egklkWEZ3DEf7SsOjV2FNVMUkVerEomcmbccKp1BfMAdBHgwZ1ZYiEeJsSUfLVwzXmZanhyq1N/hkeBbKbz9EaRdsrydecJAx9zyQNXx31hI8eTGcWgl3iAUW1uv3p6s8qAqU3KaG/6wHPVJFB/kiQcOof+rVr2N+UBNWe3Eo2GfHZwaNu79akghiRvaH5TOnJ0QCge7hWIfI5Ya7fQKE5kjndFVYUspoiPDBfNYAmkMwl9TG5bT16rLvYExGNUfWq0AHtCYvWKnWJn0c4CTCFZFuMEBJyd1ZtjQsQwb3YoZaxqJ0Ga5LHG1S3V8Gjnqmoi5IbVcSclpRDX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CB12A06CC22C64FBECABDDAC3EFD7F3@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5dc0b8-ddd7-4f00-9989-08d767a0b4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 18:47:01.9211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11VfcYXe4Q02tkugQDCtAcJWUM9U7pYw1RbZZ9E5NXEH3t+DgLOh+3kIUowJAnjcMNk8/fvu/joYhkurk2tvUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5270
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTmF2aWQsDQoNCk9uIFR1ZSwgMjAxOS0xMS0wNSBhdCAyMzozNyAtMDYwMCwgTmF2aWQgRW1h
bWRvb3N0IHdyb3RlOg0KPiBXb3VsZCB5b3UgcGxlYXNlIHJldmlldyB0aGlzIHBhdGNoPw0KDQpU
aGlzIG1lbW9yeSBsZWFrIHdhcyBmaXhlZCBieToNCg0KY29tbWl0IDFlNjcyZTM2NDQ5NDBkODNi
ZDk0ZTdjYjQ2YmFjNmJiMzYyN2RlMDINCkF1dGhvcjogV2Vud2VuIFdhbmcgPHdlbndlbkBjcy51
Z2EuZWR1Pg0KRGF0ZTogICBUdWUgQXVnIDIwIDIyOjIxOjIxIDIwMTkgLTA1MDANCg0KICAgIE5G
U3Y0OiBGaXggYSBtZW1vcnkgbGVhayBidWcNCiAgICANCiAgICBJbiBuZnM0X3RyeV9taWdyYXRp
b24oKSwgaWYgbmZzNF9iZWdpbl9kcmFpbl9zZXNzaW9uKCkgZmFpbHMsIHRoZQ0KICAgIHByZXZp
b3VzbHkgYWxsb2NhdGVkICdwYWdlJyBhbmQgJ2xvY2F0aW9ucycgYXJlIG5vdCBkZWFsbG9jYXRl
ZCwgbGVhZGluZyB0bw0KICAgIG1lbW9yeSBsZWFrcy4gVG8gZml4IHRoaXMgaXNzdWUsIGdvIHRv
IHRoZSAnb3V0JyBsYWJlbCB0byBmcmVlICdwYWdlJyBhbmQNCiAgICAnbG9jYXRpb25zJyBiZWZv
cmUgcmV0dXJuaW5nIHRoZSBlcnJvci4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBXZW53ZW4g
V2FuZyA8d2Vud2VuQGNzLnVnYS5lZHU+DQogICAgU2lnbmVkLW9mZi1ieTogQW5uYSBTY2h1bWFr
ZXIgPEFubmEuU2NodW1ha2VyQE5ldGFwcC5jb20+DQoNCg0KDQpBbmQgd2FzIGluY2x1ZGVkIGFz
IHBhcnQgb2YgdGhlIGluaXRpYWwgTkZTIG1lcmdlIGZvciB0aGUgdjUuNC1yYyBjeWNsZS4NCg0K
VGhhbmtzLA0KQW5uYQ0KDQo+IA0KPiBPbiBUaHUsIFNlcCAxOSwgMjAxOSBhdCA3OjIyIFBNIE5h
dmlkIEVtYW1kb29zdA0KPiA8bmF2aWQuZW1hbWRvb3N0QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4g
SW4gbmZzNF90cnlfbWlncmF0aW9uLCBpZiBuZnM0X2JlZ2luX2RyYWluX3Nlc3Npb24gZmFpbHMg
dGhlIGFsbG9jYXRlZA0KPiA+IG1lbW9yeSBzaG91bGQgYmUgcmVsZWFzZWQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogTmF2aWQgRW1hbWRvb3N0IDxuYXZpZC5lbWFtZG9vc3RAZ21haWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBmcy9uZnMvbmZzNHN0YXRlLmMgfCAyICstDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvbmZzNHN0YXRlLmMgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiBpbmRleCBj
YWQ0ZTA2NGIzMjguLjEyNDY0OWYxMjA2NyAxMDA2NDQNCj4gPiAtLS0gYS9mcy9uZnMvbmZzNHN0
YXRlLmMNCj4gPiArKysgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gPiBAQCAtMjA5Niw3ICsyMDk2
LDcgQEAgc3RhdGljIGludCBuZnM0X3RyeV9taWdyYXRpb24oc3RydWN0IG5mc19zZXJ2ZXINCj4g
PiAqc2VydmVyLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZA0KPiA+IA0KPiA+ICAgICAgICAgc3Rh
dHVzID0gbmZzNF9iZWdpbl9kcmFpbl9zZXNzaW9uKGNscCk7DQo+ID4gICAgICAgICBpZiAoc3Rh
dHVzICE9IDApDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiBzdGF0dXM7DQo+ID4gKyAgICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+IA0KPiA+ICAgICAgICAgc3RhdHVzID0gbmZzNF9yZXBs
YWNlX3RyYW5zcG9ydChzZXJ2ZXIsIGxvY2F0aW9ucyk7DQo+ID4gICAgICAgICBpZiAoc3RhdHVz
ICE9IDApIHsNCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+IA0KPiANCj4gLS0NCj4gTmF2aWQuDQo=
