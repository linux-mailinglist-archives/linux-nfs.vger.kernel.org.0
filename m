Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AEA1B0E06
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 16:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgDTONV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 10:13:21 -0400
Received: from mail-mw2nam12on2125.outbound.protection.outlook.com ([40.107.244.125]:31073
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbgDTONU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 10:13:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6HwA45zvwKPcR/kK3MVaRGdSbe3cR3ZQH8UChBoMAnP7l9U59x/j6L3Nts0eQBMfB+jH1S8wyMGFuNRpcFPfGKFtDpOO/6QHlf7Lr+upckJiNzJga0QzU2t+N3mmRjq4K912jKigA+jgmV2tZ5La4q7rvEgZk6vryMuxOgPqeVxEeWhqr+pkV80aMxJw+5GOVZxFKpvB79YuoHHKA2n/1fzS9H/YnM6BLw4ba4PNF1Ji/tBotce/aX48XWC8r3UMED32MS9T7HBDA/jzACEfo9QKytZBGD8fxrCKk/mozul78VBBtDucU/LMOk69SfiBp/zj7mJMyEEnUJ545ooDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDQDbS2uEKcxC5J4nC3g2BLLPpCPwa77jOyzZxipoBs=;
 b=KPxVg+nQVsLbeLX1w6Ol8GtM8eFZhccv2k/DRC8l0KaYRJdMnaRllCz6igkMjuPOAXUdUBIRnCrdbv5Xa53vqGEtEgVgwq3pZCAj0OEdS3dNM3uCQLOGUQ9LEg6HXu+q6IfBfLCqZt/R1NgvIWYL61rerR9YDsNNfFWOg8uuTGn76eMrEjNborH40+4A7gMD8rTjPxIjQLDgkK0imczsDqNYU5ErleoMFgeOH3PZjZTZvGT5cisegfJ5BpBVzeBUEBYdRzi424zxH3MwtIRX31205nKapsph/MaHfjFG2u9Mja+wSgsOayqyjbCcuJk3BQvCXxUxhvdEWu5RZTPVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDQDbS2uEKcxC5J4nC3g2BLLPpCPwa77jOyzZxipoBs=;
 b=Xzx4X5GMz98XsKrvdXxv6AehJvYcSKb9OUMSHlSiJHP2sP8dfmOTnDYGr3iIX9FXQ6CQ97gvfqJY0vnLJD5nBPo6hVu/R9knlPSVqFObtWROGkUzClHUunsJr/sh+RR393A9GFhziLachJinumAQi26Kc9E4YKqzsyuiMpj9Hu0=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3879.namprd13.prod.outlook.com (2603:10b6:610:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Mon, 20 Apr
 2020 14:13:17 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 14:13:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "agruenba@redhat.com" <agruenba@redhat.com>
CC:     "okir@suse.de" <okir@suse.de>,
        "tanxin.ctf@gmail.com" <tanxin.ctf@gmail.com>,
        "xiyuyang19@fudan.edu.cn" <xiyuyang19@fudan.edu.cn>,
        "akpm@osdl.org" <akpm@osdl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "yuanxzhang@fudan.edu.cn" <yuanxzhang@fudan.edu.cn>
Subject: Re: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Topic: [PATCH] nfs: Fix potential posix_acl refcnt leak in nfs3_set_acl
Thread-Index: AQHWFxre2QGwujM/E0SOb8psJlnhQaiCDXSA
Date:   Mon, 20 Apr 2020 14:13:17 +0000
Message-ID: <718b787af216eb42cb742007a11acbbf2aa3e43d.camel@hammerspace.com>
References: <20200420135147.21572-1-agruenba@redhat.com>
In-Reply-To: <20200420135147.21572-1-agruenba@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c16a54f-bd7f-43d3-4991-08d7e534f921
x-ms-traffictypediagnostic: CH2PR13MB3879:
x-microsoft-antispam-prvs: <CH2PR13MB387905A9DF2A9D981FEF29AFB8D40@CH2PR13MB3879.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(366004)(39830400003)(136003)(76116006)(66946007)(66476007)(66446008)(64756008)(4326008)(66556008)(5660300002)(91956017)(6512007)(71200400001)(6916009)(478600001)(6486002)(81156014)(36756003)(8676002)(186003)(316002)(86362001)(6506007)(26005)(54906003)(8936002)(2616005)(2906002)(7416002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOFpJBUOVjdXPS1A0UnV6nbwaSlCUIqRHeldr9wpXHLyFu6WJBxbaPc5e8GUUtMJ7E7GJGjL65bzl2kRVPenQKqVw01A1iN9comTzMwY2mwtZKUDOFPvydNg22VqsDQ3vYWbZktc4wyoh/8NR+pXMI8apzM0ZbJnU4HJlLfNbq2lYuIRSYtcXxSfDnPHnO0oOcJU7auv/5MUrfJQk0FnAbsKmG8i/u1vdqZTssN7X7k+OS55PXCX+rv9n78SBicGyPCs2F651YxxvuTU7SmfoAuJ3dp4VqgKDkEhZnQckvY9f4XlRLxeXWpTeF97R3EJY7F8PXrRyglXaOT5wZLjDAYv9uJYF75hgulBFoOYLYOu6fNOuz6DPjOU3FB2yrEtLVwd3NRCk6zKMClM+FQdzDWMAzRKASIuuTvW1zN5YMT+TjBLTWYxReLWwLiXlWz3
x-ms-exchange-antispam-messagedata: wo4l/qqjcdCf1/NV85lEzzFpd4MC4PoyIMZX18U33UuRfOOtTPSr4b0WfqqZBOCR8PK7rx0JaXkgSRWYnP8NyF97qyoFx08TzWXY4Rcge3CaIei2AknMuIqsRCSGM5mfMZ44OzoBENT3A83z6X871MiMpFE3ppo6JpzsL4AxJPWpmcBXeZvRYnVCcdXyoLcMhUwkc0PNc97mKkpabY3FNp18FEND4luswzT53TarDoI+GOQdao3sX7FQRoJOTntSOyGTEmn8WrsVHXwCC8ogf3APoOuP4EyELeVPkMbiYViWKtYpB928//Jm2SRkhdrTjepu5RgaydjTI6LAbgvMxEBvY/K3OxxyxzKyCU79pV8vhCZwOlfLqLa6oWe+81OgPlnHr4goC/LFLKsCVEkG1Ak7QJQ419dsGAsuH5HmGSbpdixaL2GcT1t3Vh79jQp3DY2gl2wr1Ua7KQaw5XKZNDCeMByVvxuN8ApfSr/+XXZ8E8YWsYcw0pPlCRsaeSVlsQrmiK0Fb2dFPHdflnzhQTKcjOjQPWKvTc0tHA3+qmSLijHdwFBto4ViOWgmW20TVkYG+PHmFFwTDibMiOfihAACBusxNiWVTHGSslof1mKtghGFztiHywLRFLoz2x3BQebWB57YNvNsmMBCdJsK00BG6y2mf6tu1vU+sdT/GGIAeIKXC8lj4qYl97TbqguaZmOaKkyGdZ1yvH7hQv3shzMgfaPRnakh/PLw3s68ZPnrlHFx1Go0AYV3MNob6XSy8C63RLcwcyb4Ub24EW928S3VRAl6IHegSm0duw6T6FM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCCFBD03925C8E4BABBC70224FD4787E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c16a54f-bd7f-43d3-4991-08d7e534f921
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 14:13:17.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCv0VzIoQzTp0yDgonkOvxN2Q0bWY4ixcCm1WArlclu6CYjBN+WjOdiTDCpeKvXyQl0xNhAQeVLmUoUhuuYIUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3879
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDE1OjUxICswMjAwLCBBbmRyZWFzIEdydWVuYmFjaGVyIHdy
b3RlOg0KPiBuZnMzX3NldF9hY2wga2VlcHMgdHJhY2sgb2YgdGhlIGFjbCBpdCBhbGxvY2F0ZWQg
bG9jYWxseSB0byBkZXRlcm1pbmUNCj4gaWYgYW4gYWNsDQo+IG5lZWRzIHRvIGJlIHJlbGVhc2Vk
IGF0IHRoZSBlbmQuICBUaGlzIHJlc3VsdHMgaW4gYSBtZW1vcnkgbGVhayB3aGVuDQo+IHRoZQ0K
PiBmdW5jdGlvbiBhbGxvY2F0ZXMgYW4gYWNsIGFzIHdlbGwgYXMgYSBkZWZhdWx0IGFjbC4gIEZp
eCBieSByZWxlYXNpbmcNCj4gYWNscw0KPiB0aGF0IGRpZmZlciBmcm9tIHRoZSBhY2wgb3JpZ2lu
YWxseSBwYXNzZWQgaW50byBuZnMzX3NldF9hY2wuDQo+IA0KPiBGaXhlczogYjdmYTA1NTRjZjFi
ICgiW1BBVENIXSBORlM6IEFkZCBzdXBwb3J0IGZvciBORlN2MyBBQ0xzIikNCj4gUmVwb3J0ZWQt
Ynk6IFhpeXUgWWFuZyA8eGl5dXlhbmcxOUBmdWRhbi5lZHUuY24+DQo+IFNpZ25lZC1vZmYtYnk6
IEFuZHJlYXMgR3J1ZW5iYWNoZXIgPGFncnVlbmJhQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgZnMv
bmZzL25mczNhY2wuYyB8IDIyICsrKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2ZzL25mcy9uZnMzYWNsLmMgYi9mcy9uZnMvbmZzM2FjbC5jDQo+IGluZGV4IGM1YzNmYzZlNmM2
MC4uMjZjOTRiMzJkNmY0IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzM2FjbC5jDQo+ICsrKyBi
L2ZzL25mcy9uZnMzYWNsLmMNCj4gQEAgLTI1MywzNyArMjUzLDQ1IEBAIGludCBuZnMzX3Byb2Nf
c2V0YWNscyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiBzdHJ1Y3QgcG9zaXhfYWNsICphY2wsDQo+
ICANCj4gIGludCBuZnMzX3NldF9hY2woc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IHBvc2l4
X2FjbCAqYWNsLCBpbnQNCj4gdHlwZSkNCj4gIHsNCj4gLQlzdHJ1Y3QgcG9zaXhfYWNsICphbGxv
YyA9IE5VTEwsICpkZmFjbCA9IE5VTEw7DQo+ICsJc3RydWN0IHBvc2l4X2FjbCAqb3JpZyA9IGFj
bCwgKmRmYWNsID0gTlVMTCwgKmFsbG9jOw0KPiAgCWludCBzdGF0dXM7DQo+ICANCj4gIAlpZiAo
U19JU0RJUihpbm9kZS0+aV9tb2RlKSkgew0KPiAgCQlzd2l0Y2godHlwZSkgew0KPiAgCQljYXNl
IEFDTF9UWVBFX0FDQ0VTUzoNCj4gLQkJCWFsbG9jID0gZGZhY2wgPSBnZXRfYWNsKGlub2RlLA0K
PiBBQ0xfVFlQRV9ERUZBVUxUKTsNCj4gKwkJCWFsbG9jID0gZ2V0X2FjbChpbm9kZSwgQUNMX1RZ
UEVfREVGQVVMVCk7DQo+ICAJCQlpZiAoSVNfRVJSKGFsbG9jKSkNCj4gIAkJCQlnb3RvIGZhaWw7
DQo+ICsJCQlkZmFjbCA9IGFsbG9jOw0KPiAgCQkJYnJlYWs7DQo+ICANCj4gIAkJY2FzZSBBQ0xf
VFlQRV9ERUZBVUxUOg0KPiAtCQkJZGZhY2wgPSBhY2w7DQo+IC0JCQlhbGxvYyA9IGFjbCA9IGdl
dF9hY2woaW5vZGUsIEFDTF9UWVBFX0FDQ0VTUyk7DQo+ICsJCQlhbGxvYyA9IGdldF9hY2woaW5v
ZGUsIEFDTF9UWVBFX0FDQ0VTUyk7DQo+ICAJCQlpZiAoSVNfRVJSKGFsbG9jKSkNCj4gIAkJCQln
b3RvIGZhaWw7DQo+ICsJCQlkZmFjbCA9IGFjbDsNCj4gKwkJCWFjbCA9IGFsbG9jOw0KPiAgCQkJ
YnJlYWs7DQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gIAlpZiAoYWNsID09IE5VTEwpIHsNCj4gLQkJ
YWxsb2MgPSBhY2wgPSBwb3NpeF9hY2xfZnJvbV9tb2RlKGlub2RlLT5pX21vZGUsDQo+IEdGUF9L
RVJORUwpOw0KPiArCQlhbGxvYyA9IHBvc2l4X2FjbF9mcm9tX21vZGUoaW5vZGUtPmlfbW9kZSwg
R0ZQX0tFUk5FTCk7DQo+ICAJCWlmIChJU19FUlIoYWxsb2MpKQ0KPiAgCQkJZ290byBmYWlsOw0K
PiArCQlhY2wgPSBhbGxvYzsNCj4gIAl9DQo+ICAJc3RhdHVzID0gX19uZnMzX3Byb2Nfc2V0YWNs
cyhpbm9kZSwgYWNsLCBkZmFjbCk7DQo+IC0JcG9zaXhfYWNsX3JlbGVhc2UoYWxsb2MpOw0KPiAr
b3V0Og0KPiArCWlmIChhY2wgIT0gb3JpZykNCj4gKwkJcG9zaXhfYWNsX3JlbGVhc2UoYWNsKTsN
Cj4gKwlpZiAoZGZhY2wgIT0gb3JpZykNCj4gKwkJcG9zaXhfYWNsX3JlbGVhc2UoZGZhY2wpOw0K
PiAgCXJldHVybiBzdGF0dXM7DQo+ICANCj4gIGZhaWw6DQo+IC0JcmV0dXJuIFBUUl9FUlIoYWxs
b2MpOw0KPiArCXN0YXR1cyA9IFBUUl9FUlIoYWxsb2MpOw0KPiArCWdvdG8gb3V0Ow0KPiAgfQ0K
PiAgDQo+ICBjb25zdCBzdHJ1Y3QgeGF0dHJfaGFuZGxlciAqbmZzM194YXR0cl9oYW5kbGVyc1td
ID0gew0KPiANCj4gYmFzZS1jb21taXQ6IGFlODNkMGI0MTZkYjAwMmZlOTU2MDFlN2Y5N2Y2NGI1
OTUxNGQ5MzYNCg0KVGhhbmtzIEFuZHJlYXMhIFRoaXMgb25lIGxvb2tzIGdvb2QuDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
