Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C880885
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Aug 2019 00:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfHCWWy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Aug 2019 18:22:54 -0400
Received: from mail-eopbgr800131.outbound.protection.outlook.com ([40.107.80.131]:12135
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729195AbfHCWWy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 3 Aug 2019 18:22:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9zK2kD7zn6rMrLlNZILLKAUGjwnwK9Vzs4AfYhiBGeoabdoKOO6EmjI8dqiAE71wfULO4XnDcW51UXDfxTExypzQbayEBueVqoV1eObdFKRWJ1dqjeAzTfP/dThhAaxp/u/x/2GnFqb4c9mNBm9r+mq4bvWgqjrNj/se7mlOEgRgwWEb+UZayQUgS0tUCRSSqe1T2FBlL05lrtTKTbd8//CneByvUtJv8v/1dmo5FXumQaaZQO8etVM+VbQFwSVHMpWa+ksFBO/+GrV1N0lvunEFPwyBZ0Z8J/upL8P9a5uQe6qfXkt/fs/KnRGpJ/4r9L4wH398PFlyzGQKW96bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqbvkg9pC7dOGLWXW4cXfbIazXnO5DnwOohLLGYYPjs=;
 b=WoBIv9ieqEXkjMW+a9kGDgAGm2mK/meQGFNRqwf3MbhP42D1/flgNbCQf85hbCQFhFTmfrbO7i8zMKO1aCkLZ8jQXcrGKlrHvSf1ZUZPWIKKiWZKU8QJjH67ZQFmUhiT/jrQoXvEL/kynzk5pWYuQ3o/e7lNhes4AATyyQaFgvafR5qu0ngYodfPD1L8doKTPvHuxfdS6yu68CvsdQwVwVcveGRlVh5ZOtUIXnUMD3ahx8KmHz50/acStYu4V4RiGqT7yudy1PIEhcD5zj1HjHK8sBpmUIsX4v6IZ2yGYNiQayT8o+nop/0URfUm+kzCs2f39zYJX5Y5h15u+zhT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hammerspace.com;dmarc=pass action=none
 header.from=hammerspace.com;dkim=pass header.d=hammerspace.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqbvkg9pC7dOGLWXW4cXfbIazXnO5DnwOohLLGYYPjs=;
 b=AZOkXR6QnCUPe5lpDDBDiVPSRxfLjvc54UEEIOT5PJ8HDArIodk9z4nDdhgUmmxYBVrH6K7ucwrIIk1kvfjXdWOSvVr7htMiCt4CflTqb4FeTeevDNdUIo5a6wYfY1sy2rqjqvcUvl/KNwI8uae5rcJ8Zzf5ApBzu1j0rfj74qM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1707.namprd13.prod.outlook.com (10.171.154.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.9; Sat, 3 Aug 2019 22:22:50 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2157.009; Sat, 3 Aug 2019
 22:22:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jhubbard@nvidia.com" <jhubbard@nvidia.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: Fix a potential sleep while atomic in
 nfs4_do_reclaim()
Thread-Topic: [PATCH] NFSv4: Fix a potential sleep while atomic in
 nfs4_do_reclaim()
Thread-Index: AQHVSgm+TlNEYd+F20ugHv7hAVnQoKbpyWyAgAA2dgA=
Date:   Sat, 3 Aug 2019 22:22:50 +0000
Message-ID: <47e39b00da52c3b873f6f23b420cbc8b3ad9139e.camel@hammerspace.com>
References: <20190803144042.15187-1-trond.myklebust@hammerspace.com>
         <f90372ee-272b-5bbb-e99a-796bccfa787a@nvidia.com>
In-Reply-To: <f90372ee-272b-5bbb-e99a-796bccfa787a@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dde42cde-2b89-40ec-6487-08d718611f0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1707;
x-ms-traffictypediagnostic: DM5PR13MB1707:
x-microsoft-antispam-prvs: <DM5PR13MB17076BE1640DEFADD0E14E7EB8D80@DM5PR13MB1707.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0118CD8765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39830400003)(376002)(366004)(189003)(199004)(85644002)(66446008)(5660300002)(91956017)(102836004)(66946007)(5640700003)(6486002)(76116006)(64756008)(229853002)(66476007)(66556008)(7736002)(305945005)(6436002)(6916009)(2501003)(25786009)(486006)(4326008)(36756003)(14454004)(68736007)(6512007)(53936002)(476003)(2616005)(6116002)(316002)(3846002)(26005)(6246003)(2906002)(11346002)(446003)(186003)(81166006)(81156014)(99286004)(76176011)(6506007)(53546011)(118296001)(1730700003)(86362001)(256004)(14444005)(71200400001)(66066001)(71190400001)(8936002)(478600001)(2351001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1707;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5uYy2K0s680Apzk/YnOQe7SSdAu8gQpcgJcq6Gyem6A84ODUSY1JgVKRpeN7s24AQpP7L7KzbHmqfzD5rSwq059RdvmNerXvvU6+OdH6qEBNmWxtieqO2VLHav/MSOdFGxAZhc5VAbS3bS6TDrGLFLmyAWEq3mFqg13vWKYVFpyih+liktWeySl1VJYcJrAEZtGSrD2u3jitLNTRtWCKPHFcqXJIGroSeKD9jSQtPUdsVE2K3p2TfAJn/rNp+G4ghuJQy4lChpuX8kJPZhB4qtcYgjHbWJEQM5KFqATfthodK5PteBYCfuN/qwQC47mDyOoSZDAD5cUPlZEkoE3VA5Lyjcag1SLM3Hgfn2Bg8IHF4JGpU8EFHk/34QhXbscPcLTgarr5bzzNT3sRq38EIjaO7cteHgihLkK+AEt8JRc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E599A3E0602DB408969DCEE78572D4F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde42cde-2b89-40ec-6487-08d718611f0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2019 22:22:50.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81wfOSRmaOsj5SFWtlxM1Dbkb0+1ysGEXOrlq6ezA0dvgScGKLPs36dD1kr/6OdbG5brWIK17tE+YUwPXagF5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1707
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDE5LTA4LTAzIGF0IDEyOjA3IC0wNzAwLCBKb2huIEh1YmJhcmQgd3JvdGU6DQo+
IE9uIDgvMy8xOSA3OjQwIEFNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gSm9obiBIdWJi
YXJkIHJlcG9ydHMgc2VlaW5nIHRoZSBmb2xsb3dpbmcgc3RhY2sgdHJhY2U6DQo+ID4gDQo+ID4g
bmZzNF9kb19yZWNsYWltDQo+ID4gICAgcmN1X3JlYWRfbG9jayAvKiB3ZSBhcmUgbm93IGluX2F0
b21pYygpIGFuZCBtdXN0IG5vdCBzbGVlcCAqLw0KPiA+ICAgICAgICBuZnM0X3B1cmdlX3N0YXRl
X293bmVycw0KPiA+ICAgICAgICAgICAgbmZzNF9mcmVlX3N0YXRlX293bmVyDQo+ID4gICAgICAg
ICAgICAgICAgbmZzNF9kZXN0cm95X3NlcWlkX2NvdW50ZXINCj4gPiAgICAgICAgICAgICAgICAg
ICAgcnBjX2Rlc3Ryb3lfd2FpdF9xdWV1ZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgX19j
YW5jZWxfd29ya190aW1lcg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Zs
dXNoX3dvcmsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXJ0X2Zs
dXNoX3dvcmsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtaWdo
dF9zbGVlcDoNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGtl
cm5lbC93b3JrcXVldWUuYzoyOTc1Og0KPiA+IEJVRykNCj4gPiANCj4gPiBUaGUgc29sdXRpb24g
aXMgdG8gc2VwYXJhdGUgb3V0IHRoZSBmcmVlaW5nIG9mIHRoZSBzdGF0ZSBvd25lcnMNCj4gPiBm
cm9tIG5mczRfcHVyZ2Vfc3RhdGVfb3duZXJzKCksIGFuZCBwZXJmb3JtIHRoYXQgb3V0c2lkZSB0
aGUgYXRvbWljDQo+ID4gY29udGV4dC4NCj4gPiANCj4gDQo+IEFsbCBiZXR0ZXIgbm93LS10aGlz
IGRlZmluaXRlbHkgZml4ZXMgaXQuIEkgY2FuIHJlYm9vdCB0aGUgc2VydmVyLA0KPiBhbmQNCj4g
b2YgY291cnNlIHRoYXQgYmFja3RyYWNlIGlzIGdvbmUuIFRoZW4gdGhlIGNsaWVudCBtb3VudHMg
aGFuZywgc28gSQ0KPiBkbw0KPiBhIG1vdW50IC1hIC1vIHJlbW91bnQsIGFuZCBhZnRlciBhYm91
dCAxIG1pbnV0ZSwgdGhlIGNsaWVudCBtb3VudHMNCj4gc3RhcnQgd29ya2luZyBhZ2Fpbiwgd2l0
aCBubyBpbmRpY2F0aW9uIG9mIHByb2JsZW1zLiBJIGFzc3VtZSB0aGF0DQo+IHRoZQ0KPiBwYXVz
ZSBpcyBieSBkZXNpZ24tLXRpbWluZyBvdXQgc29tZXdoZXJlLCB0byByZWNvdmVyIGZyb20gdGhl
IHNlcnZlcg0KPiBnb2luZyBtaXNzaW5nIGZvciBhIHdoaWxlLiBJZiBzbywgdGhlbiBhbGwgaXMg
d2VsbC4NCj4gDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRoZSByZXBvcnQsIGFuZCBmb3IgdGVz
dGluZyENCg0KV2l0aCByZWdhcmRzIHRvIHRoZSAxIG1pbnV0ZSBkZWxheSwgSSBzdHJvbmdseSBz
dXNwZWN0IHRoYXQgd2hhdCB5b3UNCmFyZSBzZWVpbmcgaXMgdGhlIE5GU3Y0ICJncmFjZSBwZXJp
b2QiLg0KDQpBZnRlciBhIE5GU3Y0Lnggc2VydmVyIHJlYm9vdCwgdGhlIGNsaWVudHMgYXJlIGdp
dmVuIGEgY2VydGFpbiBhbW91bnQNCm9mIHRpbWUgaW4gd2hpY2ggdG8gcmVjb3ZlciB0aGUgZmls
ZSBvcGVuIHN0YXRlIGFuZCBsb2NrIHN0YXRlIHRoYXQNCnRoZXkgbWF5IGhhdmUgaGVsZCBiZWZv
cmUgdGhlIHJlYm9vdC4gQWxsIG5vbi1yZWNvdmVyeSBvcGVucywgbG9ja3MgYW5kDQphbGwgSS9P
IGFyZSBzdG9wcGVkIHdoaWxlIHRoaXMgcmVjb3ZlcnkgcHJvY2VzcyBpcyBoYXBwZW5pbmcgdG8g
ZW5zdXJlDQp0aGF0IGxvY2tpbmcgY29uZmxpY3RzIGRvIG5vdCBvY2N1ci4gVGhpcyBlbnN1cmVz
IHRoYXQgYWxsIGxvY2tzIGNhbg0Kc3Vydml2ZSBzZXJ2ZXIgcmVib290cyB3aXRob3V0IGFueSBs
b3NzIG9mIGF0b21pY2l0eS4NCg0KV2l0aCBORlN2NC4xIGFuZCBORlN2NC4yLCB0aGUgc2VydmVy
IGNhbiBkZXRlcm1pbmUgd2hlbiBhbGwgdGhlIGNsaWVudHMNCmhhdmUgZmluaXNoZWQgcmVjb3Zl
cmluZyBzdGF0ZSBhbmQgZW5kIHRoZSBncmFjZSBwZXJpb2QgZWFybHksIGhvd2V2ZXINCkkndmUg
cmVjZW50bHkgc2VlbiBjYXNlcyB3aGVyZSB0aGF0IHdhcyBub3QgaGFwcGVuaW5nLiBJJ20gbm90
IHN1cmUgeWV0DQppZiB0aGF0IGlzIGEgcmVhbCBzZXJ2ZXIgcmVncmVzc2lvbi4NCg0KQ2hlZXJz
DQogIFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
