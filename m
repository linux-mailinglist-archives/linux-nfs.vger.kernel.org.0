Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1D1C1D97
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgEATFu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 15:05:50 -0400
Received: from mail-mw2nam12on2115.outbound.protection.outlook.com ([40.107.244.115]:60610
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729766AbgEATFt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 May 2020 15:05:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz+Gospb3EVRQ7HgE4+LX6UsEZ4ppEh6wa+8q0GcPCR/iGIuBImGPpb8kcPN3kLpqSimVHlsUDrMyI7wqEAQm7KoVf11Uh2fF0Dy5tY1TFP1sWQkbPDq2v2P0lBsqPCfUyKE9yLVxDt2mpTxybHcFVikIKZo99yPuRDSx4ky/w5W1GAcVYf7SZFkSSydHs5qlmMXH2jr7Byx6iq4XLmq62Nzi6gs7qOsVjw8JfaKfYqjdzWg5vYm5EyGqoEVSaPzLQJlvsJEYFv0OnR9N5tV8dPFeXs89EZIh4sNg1bjFkED/+5bl/KbE0NX6JFRvgxgTmkQAzw0DJK6szbKWbQbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYVCvZBpLiKANs0uTrGLayUXf0G20Ue04qWn5sejOsI=;
 b=VCKBAncvbmcCsd1Rxsj556/nvHfVGmmyr+3DrQxYWFSSpK1ISXIRxGfX0bfHQpZsIPo9PRSwKs7DD6ZdMgHMZ1Wco0KrJeXZ10Pqr4KC3ZJmlqcDNPgCz+KLRejuhcMmoWNTRUbl/jRgu46ZNgAtghMO4/RDzDfNo6GECwV0tZ/WKzvcMtHiOufKvX7+KwXSHNiVoui+IcxL60IBNIUr+YACXuIZR2IlvIwcEaUl0tiMASXfvPkZq4sQ3YVmDJYacYp9uoXcBs3P5xJMDnDnkuCNZiQyMRn2LS3PkHIZP5uWyWBFDbah4wFFVZTwuyjH5n/KlL3MPNhlr11891jIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYVCvZBpLiKANs0uTrGLayUXf0G20Ue04qWn5sejOsI=;
 b=XQqfcFEbU9l46YpM5OnAAIPhrlfiN6PfE1I2XJ5MLGBsbkUdQm/zYEMrXNfjrQKjRfDhzuS6M2F6Nu1xpYuptSy+NBTBuRdfs1ACgTvUFcxQmESwRIQ6tuPwxSDb9elkYtUf7N9/EZq+dXnCv52hZKGuP25mOsmYpcuT5cXP3tM=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3845.namprd13.prod.outlook.com (2603:10b6:610:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.14; Fri, 1 May
 2020 19:05:46 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.020; Fri, 1 May 2020
 19:05:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jlayton@redhat.com" <jlayton@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "shli@fb.com" <shli@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
Thread-Topic: [PATCH 0/4] allow multiple kthreadd's
Thread-Index: AQHWH9HY9FPsmROjLUGJeMt1ojnpm6iThNsAgAAGSQCAAAe8gIAABIMA
Date:   Fri, 1 May 2020 19:05:46 +0000
Message-ID: <d937c9956c0edb0d6fefb9f7dc826367015db4aa.camel@hammerspace.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
         <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
         <20200501182154.GG5462@mtj.thefacebook.com>
         <20200501184935.GD9191@pick.fieldses.org>
In-Reply-To: <20200501184935.GD9191@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0135d75-349c-479b-1fca-08d7ee02a7b9
x-ms-traffictypediagnostic: CH2PR13MB3845:
x-microsoft-antispam-prvs: <CH2PR13MB3845FC74739D33E17A148E99B8AB0@CH2PR13MB3845.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0390DB4BDA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xpfL40F1aM/Tf860bBqjd1OvYKpz/tgWJYVjEM9oeWTMFUTDjk4nqJhuPeGPD0zsDKYQO1C9PU74nOqJtQAPNnjWhkJ/Y2+XtKPIISIWMPUe+7jIJ1W9GVogvQNedLmTWA172oq0c0BCFPqnLQXzlQHG6FIgglahWaw2rvVVpohQbK1fBxzbfBaG1ptLFKi3chpjpxNbYeGf7ebW5NzUF397d6I5juTxhkYMm4MrZ7FnWbIiKWUNRlKHsmDefLJBlNZ2bbN+F5w5vY2vmTLJZz/ptxz4eK02dZjfzVXuYrCKIEwOV/rBQ7xQtlRP4i5sKPzRiCF6CEtrksZ7Dw5ZUSO+51YRlpVbvUkYrwuu/2vKzrnIWNpt6a+Ma308gGbS9n/6bweeABp8Ff5rrpw6Tjpojs4Irs0KLy/FY4VRaBByq+LQ34T0w4dEmOjZxcD/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(136003)(39830400003)(376002)(66946007)(76116006)(4326008)(2616005)(8936002)(6506007)(5660300002)(8676002)(2906002)(6512007)(66476007)(66446008)(64756008)(66556008)(71200400001)(110136005)(91956017)(86362001)(6486002)(26005)(186003)(478600001)(316002)(36756003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NuqSs6OvMhkziz5yoOuiK4EHMAMoa+eYHo/m/QcGrb9x6IfWnsJxNGE9L9zrf/C43Lz/Lwxuzpfn92Zeg+lDRBSzBM7sGSvvyrZ4HLuROWZFxXgRR8DztDKcz2jiMjeraeT+K4uy2g0/7LE0AXIdQjGJ6tqagRh9n2plGpsHzT19hk9SRoWt+A0lOQVsHmlbnlLRoN60AnG6osm29QUZ4jm/YtU+i6DXMH6dye63OYs1hyXR6mT16h0Pu1QznRmfKYK+mvimTZ7aNoRGPIkffNpwtWtEmDGTT/scf7rqPGfhL2ILSU33V1apKGrqARbm2b0X2oXoLXNbmmHZWHu6pf+hPqiOiPdqYSplFtPNSwdekKs35kGgCkf1qi9YdZa0KsJKItBRyHIJFSvzVSKhieC7tx3wtZZ365Xcg+sVy7fJPs8KSUsigqCIjcZDqINSCLVBF3Lh1Slrsu45twnjSg5qfdrho7gfEBZZ+jOoqsULT9+s37Si3D7TWZ8yi0MwXlX4AfiszlBH4BOjvnuvXXUFDALqOM/zfJC/yobGttMnjEUTfqDihhWBqHegXPudgSeeNiHVzQ7Hfh0oVfJfmWLI+bVvNwm67HQLqWYEpQm6Mc8B52aw0IjyUB9M/ifEpcrfk1c9qR96ia5kuhhIFRraRm7V/AfVyKQcOFfTMfzkKLVkDgiqhh1Xc3zYi+/cCcGnFRgeiIQCYJKAY4InOlTB6fECwFu5JSE7Kk6C2GmTKfObl0Pqxv/u0S6d9KRvXIY6DJuFJEHErtJsstESG3mwKA6nOidKb1RX9zb6Now=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <66F25ECF2874224EBB3CB7DE05851F4A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0135d75-349c-479b-1fca-08d7ee02a7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 19:05:46.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqCUx5OnIcR3XpNEpA0z8n9VVwFt38IeZz8/ezT0GO3Ox4FNmWu81wrw+ZaHvzNexzrJipu4Q9mDZPPOGud03A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3845
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTAxIGF0IDE0OjQ5IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIEZyaSwgTWF5IDAxLCAyMDIwIGF0IDAyOjIxOjU0UE0gLTA0MDAsIFRlanVuIEhlbyB3
cm90ZToNCj4gPiBIZWxsbywNCj4gPiANCj4gPiBPbiBGcmksIE1heSAwMSwgMjAyMCBhdCAxMDo1
OToyNEFNIC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gPiA+IFdoaWNoIGtpbmQgb2Yg
bWFrZXMgbWUgd2FudCB0byBwb2ludCBhIGZpbmdlciBhdCBUZWp1bi4gQnV0IGl0J3MNCj4gPiA+
IGJlZW4NCj4gPiA+IG1vc3RseSBQZXRlclogdG91Y2hpbmcgdGhpcyBmaWxlIGxhdGVseS4uDQo+
ID4gDQo+ID4gTG9va3MgZmluZSB0byBtZSB0b28uIEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB0
aGUgdXNlY2FzZSB0aG8uIEl0DQo+ID4gbG9va3MNCj4gPiBsaWtlIGFsbCBpdCdzIGJlaW5nIHVz
ZWQgZm9yIGlzIHRvIHRhZyBzb21lIGt0aHJlYWRzIGFzIGJlbG9uZ2luZw0KPiA+IHRvIHRoZQ0K
PiA+IHNhbWUgZ3JvdXAuDQo+IA0KPiBQcmV0dHkgbXVjaC4NCj4gDQoNCldlbiBydW5uaW5nIGFu
IGluc3RhbmNlIG9mIGtuZnNkIGZyb20gaW5zaWRlIGEgY29udGFpbmVyLCB5b3Ugd2FudCB0bw0K
YmUgYWJsZSB0byBoYXZlIHRoZSBrbmZzZCBrdGhyZWFkcyBiZSBwYXJlbnRlZCB0byB0aGUgY29u
dGFpbmVyIGluaXQNCnByb2Nlc3Mgc28gdGhhdCB0aGV5IGdldCBraWxsZWQgb2ZmIHdoZW4gdGhl
IGNvbnRhaW5lciBpcyBraWxsZWQuDQoNClJpZ2h0IG5vdywgd2UgY2FuIGVhc2lseSBsZWFrIHRo
b3NlIGtlcm5lbCB0aHJlYWRzIHNpbXBseSBieSBraWxsaW5nDQp0aGUgY29udGFpbmVyLg0KDQo+
ID4gQ2FuJ3QgdGhhdCBiZSBkb25lIHdpdGgga3RocmVhZF9kYXRhKCk/DQo+IA0KPiBIdWgsIG1h
eWJlIHNvLCB0aGFua3MuDQo+IA0KPiBJIG5lZWQgdG8gY2hlY2sgdGhpcyBmcm9tIGdlbmVyaWMg
ZmlsZSBsb2NraW5nIGNvZGUgdGhhdCBjb3VsZCBiZSBydW4NCj4gYnkNCj4gYW55IHRhc2stLWJ1
dCBJIGFzc3VtZSB0aGVyZSdzIGFuIGVhc3kgd2F5IEkgY2FuIGNoZWNrIGlmIEknbSBhDQo+IGt0
aHJlYWQNCj4gYmVmb3JlIGNhbGxpbmcgIGt0aHJlYWRfZGF0YShjdXJyZW50KS4NCj4gDQo+IEkg
ZG8gZXhwZWN0IHRvIGV4cG9zZSBhIGRlbGVnYXRpb24gaW50ZXJmYWNlIGZvciB1c2Vyc3BhY2Ug
c2VydmVycw0KPiBldmVudHVhbGx5IHRvby4gIEJ1dCB3ZSBjb3VsZCBkbyB0aGUgdGdpZCBjaGVj
ayBmb3IgdGhlbSBhbmQgc3RpbGwNCj4gdXNlDQo+IGt0aHJlYWRfZGF0YSgpIGZvciBuZnNkLiAg
VGhhdCBtaWdodCB3b3JrLg0KPiANCj4gLS1iLg0KPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
