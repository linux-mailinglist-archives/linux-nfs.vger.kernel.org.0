Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1329F66104
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfGKVNj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jul 2019 17:13:39 -0400
Received: from mail-eopbgr710114.outbound.protection.outlook.com ([40.107.71.114]:6216
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbfGKVNi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 11 Jul 2019 17:13:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpv9yWQdeLajOkRGPfpz9cDS0L0POMQxzkl5rQYUbAn5A8LwVwQc9DPL78rlcNdnbLFRWvcTcGpYoKl4BaS8Gy5oaT5+PpFp4MncRiqHmF0ezGZvJmNGlCMPMSJvqYqxe5sl9hjP3huc8F7rOoQ8E1kMW5Ju7QGsomliHyfSY9DV4QNJB3d3BUKTY2U0kQlPVc4O0IzFQA7P8T0XG3ItAFa8jEhaoMRLpV2ez7OrFJWtZ4mBa0WiO2EsKy6DRnoHG3+A1ey6kSVG6NA4Y0kxJyz7Xbm8bY/y3o/SbAWcPIPVZyFf5wJEjJ679xW6TpYJLSp64I07/Qz/mqHvJNpVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3WQUD5KXRGcOoK4qcIu7JFB0NoLRbW/zdru7F38brQ=;
 b=U4y1ZnKOMCuAXvi3CFVXjp1eC3TswPgnq1hLq4d3XXD92NesERDlUSc76HVhWWHN8YGDWpKlqoOwOWznkCylN9NYXweW8GJ4TpdBe6DAhf6+d7N1HXgwv22q8lXYsVcTxOigUGh2uii4sz9iQTZbkVxGxUOowPLDlobA8S2K1TLmwJvD7oThz3iH+ocR7LeS8ZFblYq91+9DUGdz9GG3QHoBBsVO4W2zX1WrGb9kJWEOtz/wYeVX8RGWZCEna1Ph0EeY6ssM5FMGn3CMems4mS7p0+aBl7nu0zsbMUfH+Js3ZU65yFPVuqJd+Hp8qE8wnoiBqLK0NtxjVMp9NLFgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hammerspace.com;dmarc=pass action=none
 header.from=hammerspace.com;dkim=pass header.d=hammerspace.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3WQUD5KXRGcOoK4qcIu7JFB0NoLRbW/zdru7F38brQ=;
 b=UI5jinjzTA/vwh/zvBMo0mLEml0j53UW5mlVTlZYAJOrexPyYnGhw1TNftGmS6iHcQJnWEPo9a278H3+gfaqdXxJy5PhMqyzpge1QU4UooX47lVTATSFyRw0s60lGFfkkUYCqs/t+Fphojy2nCswWsD8jLkWdLKKnz+8r7ToeIc=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1338.namprd13.prod.outlook.com (10.168.118.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 21:13:34 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2094.007; Thu, 11 Jul 2019
 21:13:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: multipath patches
Thread-Topic: multipath patches
Thread-Index: AQHVOBvNTX2CipqtKUShUmL2lFq8ZqbFzciAgAAR7YCAAAsPAA==
Date:   Thu, 11 Jul 2019 21:13:34 +0000
Message-ID: <f614be728542c2cb9dd026a5e97b78d4e74a30af.camel@hammerspace.com>
References: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
         <1d019c416f69aa7f3ba7fed3bcfd4c08088fba57.camel@hammerspace.com>
         <CAN-5tyG0jdyn8C11v6b8=v3d1p=WoMAhXrAw8mWGEUn-TVXJ=g@mail.gmail.com>
In-Reply-To: <CAN-5tyG0jdyn8C11v6b8=v3d1p=WoMAhXrAw8mWGEUn-TVXJ=g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e73198b-bfe0-4428-d043-08d70644a255
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1338;
x-ms-traffictypediagnostic: DM5PR13MB1338:
x-microsoft-antispam-prvs: <DM5PR13MB133814836D20B1C11663D8B2B8F30@DM5PR13MB1338.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39830400003)(396003)(346002)(366004)(199004)(189003)(26005)(2501003)(2906002)(2351001)(5640700003)(6506007)(305945005)(8936002)(86362001)(81166006)(486006)(81156014)(221733001)(53546011)(14454004)(6486002)(1730700003)(6512007)(8676002)(4326008)(3846002)(6116002)(5660300002)(229853002)(2171002)(6916009)(53936002)(36756003)(478600001)(68736007)(11346002)(66556008)(71190400001)(54906003)(66946007)(446003)(71200400001)(76176011)(476003)(7736002)(102836004)(66476007)(64756008)(99286004)(6246003)(76116006)(25786009)(66446008)(2616005)(3480700005)(256004)(118296001)(316002)(66066001)(7116003)(186003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1338;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mgV0P812hLzGBHmrxAIauvrIHNnMQdOMk1HhkExxICGFhO9IukQqs45YwiBE5wZihmjOpt9VO28GdhKvmEJ2BhESJl8ew++//kVBEFBvkY55/MT97PCLZRx89DJmAMpUAUwEkozoEKVNgFfcWnEJ55mznt1rdaZHUWYwIgPgYXZy1etf/OldkceFKWFcl3VHdi9KSmSFxfa21CMrTqjRwl3u7hLYFOXf1EldAJjHLcU7BDVnPtoeC+Fg0vQpBnnR2l5GmWojO6Psscw68FMaKc0tEAVjsdup5IPYx2GToE1vzFxqxFwLbUPx89gy3oxGsMGMczOZ+WzCPwOZR2iWfvMmN32WL/NP7Kcccf14mNw0RMI/V7SuHA5bI1YF9gBXMYhXsj5uw4xIy0rQiaEEnb473NaZnbcvJeteZxngZbg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCCB5D460386F54E9AA54603BA47B2C9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e73198b-bfe0-4428-d043-08d70644a255
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 21:13:34.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1338
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA3LTExIGF0IDE2OjMzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBKdWwgMTEsIDIwMTkgYXQgMzoyOSBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDE5LTA3LTEx
IGF0IDE1OjA2IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IEhpIFRyb25k
LA0KPiA+ID4gDQo+ID4gPiBJIHNlZSB0aGF0IHlvdSBoYXZlIG5jb25uZWN0IHBhdGNoZXMgaW4g
eW91ciB0ZXN0aW5nIGJyYW5jaCAoYXMNCj4gPiA+IHdlbGwNCj4gPiA+IGFzIHlvdXIgbGludXgt
bmV4dCBhbmQgSSBhc3N1bWUgdGhleSBhcmUgdGhlIHNhbWUpLiAgVGhlcmUgaXMNCj4gPiA+IHNv
bWV0aGluZyB3cm9uZyB3aXRoIHRoYXQgdmVyc2lvbi4gQSBtb3VudCBoYW5ncyB0aGUgbWFjaGlu
ZS4NCj4gPiA+IA0KPiA+ID4gWyAgMTMyLjE0MzM3OV0gd2F0Y2hkb2c6IEJVRzogc29mdCBsb2Nr
dXAgLSBDUFUjMCBzdHVjayBmb3IgMjNzIQ0KPiA+ID4gW21vdW50Lm5mczoyNjI0XQ0KPiA+ID4g
DQo+ID4gPiBJIGRvbid0IGhhdmUgc3VjaCBwcm9ibGVtcyB3aXRoIHRoZSBwYXRjaCBzZXJpZXMg
dGhhdCBOZWlsIGhhcw0KPiA+ID4gcG9zdGVkLg0KPiA+ID4gDQo+ID4gPiBUaGFuayB5b3UuDQo+
ID4gDQo+ID4gSG93IGFyZSB0aGUgcGF0Y2hzZXRzIGRpZmZlcmVudD8gQXMgZmFyIGFzIEkga25v
dywgYWxsIEkgZGlkIHdhcw0KPiA+IGFwcGx5DQo+ID4gdGhlIDMgcGF0Y2hlcyB0aGF0IE5laWwg
YWRkZWQgdG8gbXkgZXhpc3RpbmcgYnJhbmNoLg0KPiANCj4gSSdtIG5vdCBzdXJlLiBJIGhhZCBh
IHByb2JsZW0gd2l0aCB5b3VyICJtdWx0aXBhdGgiIGJyYW5jaCBiZWZvcmUgYW5kDQo+IEkgcmVj
YWxsIHdoYXQgSSBkaWQgaXMgd2VudCBiYWNrIGFuZCByZWRvd25sb2FkZWQgeW91ciBwb3N0ZWQN
Cj4gcGF0Y2hlcy4NCj4gVGhhdCB3YXMgd2hlbiBJIHdhcyB0ZXN0aW5nIHBlcmZvcm1hbmNlLiBT
byBpZiB5b3UgaGF2ZW4ndCB0b3VjaGVkDQo+IHRoYXQgYnJhbmNoIGFuZCBqdXN0IHVzZWQgaXQg
SSB0aGluayBpdCdzIHRoZSBzYW1lIHByb2JsZW0uDQo+IA0KPiBJbiB0aGUgY3VycmVudCB0ZXN0
aW5nIGJyYW5jaCBJIGRvbid0IHNlZSBzZXZlcmFsIHBhdGNoZXMgdGhhdCBOZWlsDQo+IGhhcyBh
ZGRlZCAocG9zdGVkKSB0byB0aGUgbWFpbGluZyBsaXN0LiBTbyBJJ20gbm90IHN1cmUgd2hhdCB5
b3UgbWVhbg0KPiB5b3UgYWRkZWQgMyBvZiBoaXMgcGF0Y2hlcyBvbiB0b3Agb2YgeW91cnMuIEF0
IG1vc3QgSSBjYW4gc2F5IG1heWJlDQo+IHlvdSBhZGRlZCAyIG9mIGhpcyAob25lIHRoYXQgYWxs
b3dzIGZvciB2MiBhbmQgdjMgYW5kIGFub3RoZXIgdGhhdA0KPiBkb2VzIHN0YXRlIG9wZXJhdGlv
bnMgb24gYSBzaW5nbGUgY29ubmVjdGlvbi4gVGhlcmUgYXJlIG5vIHBhdGNoZXMNCj4gZm9yDQo+
IHN1bnJwYyBzdGF0cyB0aGF0IHdlcmUgcG9zdGVkKS4NCj4gDQo+IFdoYXQgSSBrbm93IGlzIHRo
YXQgaWYgSSByZXZlcnQgeW91ciBicmFuY2ggdG8NCj4gYmYxMWZiZGIyMGIzODUxNTdiMDQ2ZWE3
NzgxZjA0ZDBjNjI1NTRhMyBiZWZvcmUgcGF0Y2hlcyBhbmQgYXBwbHkNCj4gTmVpbHMgcGF0Y2hl
cy4gQWxsIGlzIGZpbmUuIEkgcmVhbGx5IGRvbid0IHdhbnQgdG8gZGVidWcgYSBub24tDQo+IHdv
cmtpbmcNCj4gdmVyc2lvbiB3aGVuIHRoZXJlIGlzIG9uZSB0aGF0IHdvcmtzLg0KDQpTdXJlLCBi
dXQgdGhhdCBpcyBub3QgcmVhbGx5IGFuIG9wdGlvbiBnaXZlbiB0aGUgcnVsZXMgZm9yIGhvdyB0
cmVlcyBpbg0KbGludXgtbmV4dCBhcmUgc3VwcG9zZWQgdG8gd29yay4gVGhleSBhcmUgY29uc2lk
ZXJlZCB0byBiZSBtb3JlIG9yIGxlc3MNCnN0YWJsZS4NCg0KQW55aG93LCBJIHRoaW5rIEkndmUg
Zm91bmQgdGhlIGJ1Zy4gTmVpbCBoYWQgc2lsZW50bHkgZml4ZWQgaXQgaW4gb25lDQpvZiBteSBw
YXRjaGVzLCBzbyBJJ3ZlIGFkZGVkIGFuIGluY3JlbWVudGFsIHBhdGNoIHRoYXQgZG9lcyBtb3Jl
IG9yDQpsZXNzIHdoYXQgaGUgZGlkLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
