Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 038C4B7ED4
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 18:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391785AbfISQLE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 12:11:04 -0400
Received: from mail-eopbgr700092.outbound.protection.outlook.com ([40.107.70.92]:30561
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391791AbfISQLE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 12:11:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMZqAVi7ytqyO6L7f0SrispD4rDJe50YtsvREYU6xxRNeP8MKgXQ7ei8mMvtHLbVIquFvo9Z9tuvNHdh5dzam5RD7+Wv78mIV/KHaPfQ7BzXkgvJUQ2Co8OQ0Bco0cjQn1rlpK8S6aMe8UHl3erMENAByhcVqlg/WbwN9QVOIY//Z+CH4eYb12QkfHmSD1RIH7NlVWXE/o7CkTiC01tjHM/z606OXK8lg3kWgHUNgZz+gOlfslfAOXwsphwFT3clyvBiZu0m6GWhNEixgtHhLeH+N0MAXuBaKJl/Rv+0aQpQMQ5sXZqUrTuLpaiqShJ2gi9E9vK/flwYXm2zGmqEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAePMrqEVOQjYytgpsQedh6Jl6wr6N8WF5sFgu9VXxY=;
 b=GuyyNfOsTIznHuJktEE4ooPLSRUTIKWSwBOYotoWBuPVR2vRxb9LYipRygBQkmoGwEuiYmCl8ebKwRijhceQJOriSVTRYNgOHtjKBvAzFX12XYEm0woTYvtDHNqa+HpzUSTQRu/6tr3KBG+qdmb//6dwE6OK8KVcqVK+AWwtubVIO2RsCSQX3CSpOcc30WDPPt0JlMz1nffghHrg7REUMrC1zfXkVMBfMxN0bMjPTOGtJDhpUbwMiZwA/PwVeEU1/CTmjdGPvh0Ht2ijlTIRMkN+VuiEHJfcicLlXWgrbMV1+smEkY6F6WWdWHSjFB2xV8YIqJxD5XBhgvOsqamp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAePMrqEVOQjYytgpsQedh6Jl6wr6N8WF5sFgu9VXxY=;
 b=feRb0Ho4jYRvRVt71X/oFW9wGqOgqggiouN7OGuAEwDZOHxiVgKbUP4XnQGtQ5qoXCHlITbfdhQp6rI7zQLjDFLTKO2HmJGzpaJ4lfeZTSsmJ7n/81L9Ej0QZSEWkwLSOSY1rCx2X7SYaxQOp29jTd41hPJP6tx24EPbfLzphbQ=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1402.namprd13.prod.outlook.com (10.175.110.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.17; Thu, 19 Sep 2019 16:11:00 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 16:11:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "alkisg@gmail.com" <alkisg@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Topic: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Index: AQHVbwMN/jYKfSJ+jEOCnZqjx88626czK6CA
Date:   Thu, 19 Sep 2019 16:11:00 +0000
Message-ID: <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
         <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
         <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
In-Reply-To: <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce4ee4f1-08d6-4856-191b-08d73d1bf690
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1402;
x-ms-traffictypediagnostic: DM5PR13MB1402:
x-microsoft-antispam-prvs: <DM5PR13MB14025A1CEAFD914D7DE3ED01B8890@DM5PR13MB1402.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39840400004)(376002)(366004)(396003)(189003)(199004)(66476007)(11346002)(446003)(25786009)(478600001)(64756008)(66446008)(66946007)(66556008)(476003)(2616005)(110136005)(71200400001)(316002)(71190400001)(86362001)(305945005)(81156014)(81166006)(8676002)(486006)(8936002)(5660300002)(14454004)(7736002)(6512007)(76176011)(66066001)(186003)(2501003)(102836004)(229853002)(2906002)(26005)(99286004)(6506007)(53546011)(256004)(6436002)(6486002)(6116002)(76116006)(3846002)(91956017)(6246003)(118296001)(36756003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1402;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HBZfFvM8/Q2fmg8HYAz0qw8gf2INmJOgUcC+Mx4wy+MxmR09NK7a/oxP18lwjpxP0QSSCFU2DKqd13BkS+VLSXkfxOpaajYVTx2NlbK0BExFbcDIrzapQW/3Bog1gAZ1JBuw7nwl7kFGjWxVU10hjs3yttYCY7iGh1cp0LE+ao4PwUZeoZrLSAr95v7jkaWgyvmPi2Kd1fw583dpyiD7rqQ6DKHQEwIx7AvZ/wDp0x8vD8KqfIdT71xBH4HXetZuplfm+oI3lpfkA3O5Kgixey4Pexb8GmGRqbaxVCNvGORjQz+Zqedvmr6gpqHUOCgrO7RynIEdf14RYTnyRyNXvwAkV1VgPOTN+R6A7mAeh7o+ZzNebhMjInlnJNxUvgXcw6pzyRFuySNaidK6obFktTIqKhvec93TGoKBukL0YZ4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE68936628E6E9428E05F2757517ABB8@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4ee4f1-08d6-4856-191b-08d73d1bf690
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:11:00.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6yfy4T62tP7REUxtmM0TFZFauh2T2yEczd2iyM/Yd/CBZWSqlITDYvBY4Ecf229aZ5eeN0UvK6IPxJ0EbRnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1402
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDE4OjU4ICswMzAwLCBBbGtpcyBHZW9yZ29wb3Vsb3Mgd3Jv
dGU6DQo+IE9uIDkvMTkvMTkgNjowOCBQTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+IFRo
ZSBkZWZhdWx0IGNsaWVudCBiZWhhdmlvdXIgaXMganVzdCB0byBnbyB3aXRoIHdoYXRldmVyDQo+
ID4gcmVjb21tZW5kZWQNCj4gPiB2YWx1ZSB0aGUgc2VydmVyIHNwZWNpZmllcy4gWW91IGNhbiBj
aGFuZ2UgdGhhdCB2YWx1ZSB5b3Vyc2VsZiBvbg0KPiA+IHRoZQ0KPiA+IGtuZnNkIHNlcnZlciBi
eSBlZGl0aW5nIHRoZSBwc2V1ZG8tZmlsZSBpbg0KPiA+IC9wcm9jL2ZzL25mc2QvbWF4X2Jsb2Nr
X3NpemUuDQo+IA0KPiBUaGFuayB5b3UsIGFuZCBJIGd1ZXNzIEkgY2FuIGF1dG9tYXRlIHRoaXMs
IGJ5IHJ1bm5pbmcNCj4gYHN5c3RlbWN0bCBlZGl0IG5mcy1rZXJuZWwtc2VydmVyYCwgYW5kIGFk
ZGluZzoNCj4gW1NlcnZpY2VdDQo+IEV4ZWNTdGFydFByZT1zaCAtYyAnZWNobyAzMjc2OCA+IC9w
cm9jL2ZzL25mc2QvbWF4X2Jsb2NrX3NpemUnDQo+IA0KPiBCdXQgaXNuJ3QgaXQgYSBwcm9ibGVt
IHRoYXQgdGhlIGRlZmF1bHRzIGNhdXNlIGVycm9ycyBpbiBkbWVzZyBhbmQgDQo+IHNldmVyZSBs
YWdzIGluIDEwLzEwMCBNYnBzLCBhbmQgZXZlbiBtYWtlIDEwMDAgTWJwcyBhIGxvdCBsZXNzDQo+
IHNuYXBweSANCj4gdGhhbiB3aXRoIDMySz8NCj4gDQoNCk5vLiBJdCBpcyBub3QgYSBwcm9ibGVt
LCBiZWNhdXNlIG5mcy11dGlscyBkZWZhdWx0cyB0byB1c2luZyBUQ1ANCm1vdW50cy4gRnJhZ21l
bnRhdGlvbiBpcyBvbmx5IGEgcHJvYmxlbSB3aXRoIFVEUCwgYW5kIHdlIHN0b3BwZWQNCmRlZmF1
bHRpbmcgdG8gdGhhdCBhbG1vc3QgMiBkZWNhZGVzIGFnby4NCg0KSG93ZXZlciBpdCBtYXkgd2Vs
bCBiZSB0aGF0IGtsaWJjIGlzIHN0aWxsIGRlZmF1bHRpbmcgdG8gdXNpbmcgVURQLCBpbg0Kd2hp
Y2ggY2FzZSBpdCBzaG91bGQgYmUgZml4ZWQuIFRoZXJlIGFyZSBtYWpvciBMaW51eCBkaXN0cm9z
IG91dCB0aGVyZQ0KdG9kYXkgdGhhdCBkb24ndCBldmVuIGNvbXBpbGUgaW4gc3VwcG9ydCBmb3Ig
TkZTIG92ZXIgVURQIGFueSBtb3JlLg0KDQpDaGVlcnMNCiAgVHJvbmQNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
