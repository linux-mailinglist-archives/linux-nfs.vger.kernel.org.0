Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646346C0E6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 20:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfGQSUf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 14:20:35 -0400
Received: from mail-eopbgr800090.outbound.protection.outlook.com ([40.107.80.90]:23920
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727434AbfGQSUf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jul 2019 14:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2GwqzB7fhatC9wQH4TMEJfzQ2xbnFHb/JQLlyVjohSpq3uE5QsVkxUQ1okIaFqxAIEEEQp4Je+e3TjrnrcSolQX9tETWTRhJXUOf7Rb7IFbiCo7Byr3v20Q4SPTBht65xM5QV+Yd/xYoDTCrwF/50GueqsE2A2KyHUEQUhgta0KvH231IOLwJlOuknAaSMCUSdohGBQ7YgNJFvNr1AatrL2CmP/qMy7MPvCRWYgorwajGYde8kWH55d8rGg5LFTTxNRwXXWd41ChoiaVUoXoprQRpWi6o9gjiA56u6wkqKhYd5NlQfAENnSTMSsFZ1YiOlPDmxgUBfY1jb6oeYJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le6zZEcadYvYYtyjwU53tFLrsL6/uWyDvRIm5qlou/Q=;
 b=H1Gb5iKSDUK52cNf2MHcaFhnqF5Bf0O6bMwLBwVrycKouk6Rc4ri2oZAdspGYP0NtrDfHNWVG9P7ynnPRHJ5Vj5SGtZqwdcjKlSjtylu/t+RuFo99f+huOeYB4BfjEVnsGxQonweDIJSSS76aepTlsB4paJqSyly59m1SLSo6RNQqaOwGGBDm2j5fWlQw0Nt+jiDsjcDQBQtjwpwInIQSOhgB4SNZa5nHfUD2r0fSLHeIQUMhcONcg4tViy/o8Ew+X0RtRi1mW12p2zB0N+eHySJuHjfOWEqZZzu6kuGqAyGH712J4ydjA7RhPeBQCR3ko3Yr8xcmG6RBpN+a1njUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hammerspace.com;dmarc=pass action=none
 header.from=hammerspace.com;dkim=pass header.d=hammerspace.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le6zZEcadYvYYtyjwU53tFLrsL6/uWyDvRIm5qlou/Q=;
 b=fUOYk77Cei7MRpAbeyi2ZaB9m8ckv4QvqUO9MqYRS4imDRgk4xCwJbbB0igQyyL86Qj/zI0NqMYMMWTqOfYZUebe1J18AG8CLacrsuecUDejdnpvwtheaqWuXhFsGVngdA29wBvD84/7rFZ6zUOt/3yfMKMV3SfT7hpJLPqXcf8=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1867.namprd13.prod.outlook.com (10.171.157.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.8; Wed, 17 Jul 2019 18:20:31 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2094.009; Wed, 17 Jul 2019
 18:20:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Fix up backchannel slot table accounting
Thread-Topic: [PATCH 1/2] SUNRPC: Fix up backchannel slot table accounting
Thread-Index: AQHVPBGky177GoZBdE6+Dd1fDjyBd6bO1lQAgAA4/wCAAA8NAIAAAhyA
Date:   Wed, 17 Jul 2019 18:20:31 +0000
Message-ID: <0928f5569e233cbbf0329a978327a5a18b483369.camel@hammerspace.com>
References: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
         <99A569FB-DD7F-4547-AB06-FEB5DABA8488@oracle.com>
         <97e9839faef3d1bc901d4ced3d0cf2e0bf2a0bd1.camel@hammerspace.com>
         <F138F86C-84FB-4FEA-8240-FDAD6FD4CE38@oracle.com>
In-Reply-To: <F138F86C-84FB-4FEA-8240-FDAD6FD4CE38@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7fa343e-532f-4e4b-ad5b-08d70ae37405
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1867;
x-ms-traffictypediagnostic: DM5PR13MB1867:
x-microsoft-antispam-prvs: <DM5PR13MB1867D1459CE1ED1FFA72EE25B8C90@DM5PR13MB1867.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(396003)(136003)(346002)(39830400003)(189003)(199004)(6116002)(81166006)(81156014)(256004)(25786009)(3846002)(8936002)(305945005)(7736002)(86362001)(36756003)(26005)(478600001)(229853002)(486006)(446003)(8676002)(5660300002)(14444005)(6512007)(53936002)(476003)(11346002)(6916009)(53546011)(6506007)(66946007)(76116006)(2616005)(316002)(99286004)(66446008)(71200400001)(71190400001)(64756008)(66556008)(66476007)(6436002)(68736007)(76176011)(2351001)(102836004)(5640700003)(2906002)(14454004)(6486002)(66066001)(2501003)(118296001)(186003)(6246003)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1867;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7g8YR0mIGOr/u99+KNgXOBY2hodbLufifox3oZMuATAcestADDfJmLhKleCYNHgzraOYVYP/Ce7Oe16sdBq5czP8h1jcboiQAK/Lkw8pqs4wZHuFVLBGpNIBjPpCTfblOT83GQqtK2qo87m8MoDfHTjQ6Db2nWdgb0IwmeGp0p5jHjamvtIdwcvqloKWrVxWzFMBxn7evjXOQuQaw57TctGRAljNbmHMCVKnUYjlgwLYMt8qRK2RU0xjdFcfHcJUWmy3VzZKWzEQrkerdpCu9Wp099ntiUqLva+7TuhbOxk+EcbdHEizmXed7bFH642QNB4D8dCo8vdewF0yuyOw1e91WcZeelaxmjX69zVCqV6gRfgxES2n7qjxPVavYt6GcAZWqTbl8QTq7nyfIjonMR2jRfo6f1pPLwDbLgpoYnk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F22A6AF5A846F74B913FBECF19B54CC7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fa343e-532f-4e4b-ad5b-08d70ae37405
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 18:20:31.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1867
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTE3IGF0IDE0OjEyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBKdWwgMTcsIDIwMTksIGF0IDE6MTkgUE0sIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gdHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAxOS0wNy0x
NyBhdCAwOTo1NSAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiBIaSBUcm9uZC0NCj4g
PiA+IA0KPiA+ID4gPiBPbiBKdWwgMTYsIDIwMTksIGF0IDQ6MDEgUE0sIFRyb25kIE15a2xlYnVz
dCA8dHJvbmRteUBnbWFpbC5jb20NCj4gPiA+ID4gPg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4g
DQo+ID4gPiA+IEFkZCBhIHBlci10cmFuc3BvcnQgbWF4aW11bSBsaW1pdCBpbiB0aGUgc29ja2V0
IGNhc2UsIGFuZCBhZGQNCj4gPiA+ID4gaGVscGVycyB0byBhbGxvdyB0aGUgTkZTdjQgY29kZSB0
byBkaXNjb3ZlciB0aGF0IGxpbWl0Lg0KPiA+ID4gDQo+ID4gPiBGb3IgUkRNQSwgdGhlIG51bWJl
ciBvZiBjcmVkaXRzIGlzIHBlcm1pdHRlZCB0byBjaGFuZ2UgZHVyaW5nIHRoZQ0KPiA+ID4gbGlm
ZQ0KPiA+ID4gb2YgdGhlIGNvbm5lY3Rpb24sIHNvIHRoaXMgaXMgbm90IGEgZml4ZWQgbGltaXQg
Zm9yIHN1Y2gNCj4gPiA+IHRyYW5zcG9ydHMuDQo+ID4gDQo+ID4gVGhpcyBpcyBkZWZpbmluZyBh
IG1heGltdW0gdmFsdWUsIHdoaWNoIGlzIHVzZWQgZm9yIGJhY2tjaGFubmVsDQo+ID4gc2Vzc2lv
bg0KPiA+IHNsb3QgbmVnb3RpYXRpb24uDQo+ID4gDQo+ID4gPiBBbmQsIEFGQUlDVCwgaXQncyBu
b3QgbmVjZXNzYXJ5IHRvIGtub3cgdGhlIHRyYW5zcG9ydCdzIGxpbWl0Lg0KPiA+ID4gVGhlDQo+
ID4gPiBsZXNzZXIgb2YgdGhlIE5GUyBiYWNrY2hhbm5lbCBhbmQgUlBDL1JETUEgcmV2ZXJzZSBj
cmVkaXQgbGltaXQNCj4gPiA+IHdpbGwNCj4gPiA+IGJlIHVzZWQuDQo+ID4gDQo+ID4gVGhlIHNl
cnZlciBuZWVkcyB0byBrbm93IGhvdyBtYW55IHJlcXVlc3RzIGl0IGNhbiBzZW5kIGluIHBhcmFs
bGVsDQo+ID4gb24NCj4gPiB0aGUgYmFjayBjaGFubmVsLiBJZiBpdCBzZW5kcyB0b28gbWFueSwg
d2hpY2ggaXQgY2FuIGFuZCB3aWxsIGRvIG9uDQo+ID4gVENQLCB0aGVuIHdlIGN1cnJlbnRseSBi
cmVhayB0aGUgY29ubmVjdGlvbiwgYW5kIHNvIGNhbGxiYWNrcyBlbmQNCj4gPiB1cA0KPiA+IGJl
aW5nIGRyb3BwZWQgb3IgbWlzc2VkIGFsdG9nZXRoZXIuDQo+IA0KPiBJSVVDLCBSUEMvUkRNQSBo
YXMgYSBmaXhlZCBtYXhpbXVtIGNvbnN0YW50LiBXb3VsZCB5b3UgbGlrZSBhIHBhdGNoDQo+IGF0
DQo+IHNvbWUgcG9pbnQgdGhhdCBhZHZlcnRpc2VzIHRoYXQgY29uc3RhbnQgdmlhIC0+YmNfbnVt
X3Nsb3RzID8NCj4gDQoNClN1cmUuIFRoYW5rcyENCiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
