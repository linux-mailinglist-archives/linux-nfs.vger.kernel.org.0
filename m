Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F0167411
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2019 19:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfGLRSY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Jul 2019 13:18:24 -0400
Received: from mail-eopbgr770102.outbound.protection.outlook.com ([40.107.77.102]:33918
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbfGLRSX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Jul 2019 13:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWDFzBYQ+BHUslEPf2X+aPnUacpjP2rtc4gKlKkUsUKwj5VWMwAf5SsQ+2esPffCNyUs/R5M3HNqbu9uH1arF+r9DsjsNzfDMAhAOUcGwAtfiEqASY82YdNDuZntKyehv9ySexOW4WtoseRNpJAfAjjwJjLKVsfIGgy2o9dBXyQzAGrmGKJBU/ilnkTvDaS8iSglPoUi1fx02XSZbp6gyTBIq2SEL65oCYk5DAGdDYkWuyftmsxIanR7omPw0FxJNe6At6AYcIt9wfDe5Vc3gKzkSvCOb1HsnzS18SmgSeUcqDYpp3E037pZ5CP2sekyCPdBGsmyFXs4XdHkGAN/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6kXOo37LngZPu2xJB99zOAf290gt2zkC13w7fb6zb8=;
 b=TOqN2oH+ltTLhdzi0ctT/CV2n2qvF4ChM0LW0doGV3HnMxhiRxykCwApGZdAnUiKOFZTOZIBxNp487gnctiGcYuRKDpGyDNm9q2//iC5gX/xzjTC5xsCBaKQmvmo64XzxYerjbcx9P9k8zGiKDMonAQITJLPBhTKrKYhPvU7qidNqCTJdNGKqG6ihY4hMvFknI46TTh15dAMuxkWqq3FViNu5PH5ZGrUj+Ssy2JeCsdj7ZuqzTP4LXvp2h+gwGSRSKdByT5x6ZG+DeDCA68CJpcs7jfd6IqbvaHHsLnL4duAyhi9PYkTi93YfKjmbxTneEboKBS/Bz31vqcmCdWIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hammerspace.com;dmarc=pass action=none
 header.from=hammerspace.com;dkim=pass header.d=hammerspace.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6kXOo37LngZPu2xJB99zOAf290gt2zkC13w7fb6zb8=;
 b=epdeuAf5HB8+hYt0NIotiKYhwqzTQQSE8MEfo03FNvqj51kY+lS0S/AMfwcHJmvAbD4HgZ7Gr0fvhiiQS8AEfS7Rz7hsiS61+8YJJqfH2g5isgk0tKaPjje6+W0w4XGOWzD7pf4deAN2xv+kNva9ewpXDZh4v+PAzc4Vcppc4/Q=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1417.namprd13.prod.outlook.com (10.175.109.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.9; Fri, 12 Jul 2019 17:18:17 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2094.007; Fri, 12 Jul 2019
 17:18:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "neilb@suse.com" <neilb@suse.com>
Subject: Re: multipath patches
Thread-Topic: multipath patches
Thread-Index: AQHVOBvNTX2CipqtKUShUmL2lFq8ZqbFzciAgAAR7YCAAAsPAIABRcuAgAAKzwA=
Date:   Fri, 12 Jul 2019 17:18:17 +0000
Message-ID: <b220fa1ef8b73c99aacb28285af9025d5c7a55fd.camel@hammerspace.com>
References: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
         <1d019c416f69aa7f3ba7fed3bcfd4c08088fba57.camel@hammerspace.com>
         <CAN-5tyG0jdyn8C11v6b8=v3d1p=WoMAhXrAw8mWGEUn-TVXJ=g@mail.gmail.com>
         <f614be728542c2cb9dd026a5e97b78d4e74a30af.camel@hammerspace.com>
         <CAN-5tyHkdmTJZAYwAcfUy4hYOz=KHgdBeTrYMNYiWQaKp7UrJA@mail.gmail.com>
In-Reply-To: <CAN-5tyHkdmTJZAYwAcfUy4hYOz=KHgdBeTrYMNYiWQaKp7UrJA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f903e59b-daea-43e2-44e3-08d706ecee5d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1417;
x-ms-traffictypediagnostic: DM5PR13MB1417:
x-microsoft-antispam-prvs: <DM5PR13MB1417AF4BCE24553AC3675F63B8F20@DM5PR13MB1417.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39830400003)(396003)(189003)(199004)(2351001)(118296001)(446003)(2501003)(3480700005)(7116003)(81156014)(81166006)(1730700003)(229853002)(36756003)(3846002)(5660300002)(86362001)(6486002)(476003)(486006)(221733001)(6116002)(2616005)(66066001)(11346002)(2906002)(14454004)(25786009)(6916009)(6506007)(53546011)(102836004)(71190400001)(71200400001)(53936002)(2171002)(76116006)(5024004)(256004)(186003)(26005)(76176011)(316002)(54906003)(4326008)(6436002)(5640700003)(6246003)(7736002)(6512007)(8676002)(8936002)(66476007)(66556008)(478600001)(305945005)(66446008)(64756008)(99286004)(66946007)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1417;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i7DPsDWhykw3TvnK3ERwKJKNLJ0I/1Wc5BWxzIhEDEV0oWEnDaXs5FVt+dId/KTkcEmK0CA8Kn+AgcPr8sxVkp9Yl8I5tK64KcKpiu5PVk5EzzgtTFrwTa4Bg05NdA42QZxE5ggQH2gmkcDnUfHyps1beemSabEhFUzJEtN9elEGC/77y7uyMSXouxYAq/xcCywA7gAaB9DHOwJ61mjqJ+wKmFtZuBNhErCp/FCgdEc8r/v+R/pTkgPb2+BHRBhEybNeceP6IFs5MGYia29KbXpVK6YcbDVjx7bPWlV0zVvqTaAkzy4xRluDRZVdk8xlBeJiTiCwoRnoUQ5tPhc4kFi047gHzvh2I7sYgrqZLtB01tbpBB5x4bWVfl/2kicoyWg038sXol2g0m/RkyG/s61QSW9txTBRefWtkDmVUyQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5704AEBC70D8440A7555B6E4679BA4F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f903e59b-daea-43e2-44e3-08d706ecee5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 17:18:17.6303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1417
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTEyIGF0IDEyOjM5IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBKdWwgMTEsIDIwMTkgYXQgNToxMyBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDE5LTA3LTEx
IGF0IDE2OjMzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IE9uIFRodSwg
SnVsIDExLCAyMDE5IGF0IDM6MjkgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+IHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCAyMDE5LTA3LTExIGF0IDE1
OjA2IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gPiBIaSBUcm9uZCwN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIHNlZSB0aGF0IHlvdSBoYXZlIG5jb25uZWN0IHBhdGNo
ZXMgaW4geW91ciB0ZXN0aW5nIGJyYW5jaA0KPiA+ID4gPiA+IChhcw0KPiA+ID4gPiA+IHdlbGwN
Cj4gPiA+ID4gPiBhcyB5b3VyIGxpbnV4LW5leHQgYW5kIEkgYXNzdW1lIHRoZXkgYXJlIHRoZSBz
YW1lKS4gIFRoZXJlIGlzDQo+ID4gPiA+ID4gc29tZXRoaW5nIHdyb25nIHdpdGggdGhhdCB2ZXJz
aW9uLiBBIG1vdW50IGhhbmdzIHRoZSBtYWNoaW5lLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFsg
IDEzMi4xNDMzNzldIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0gQ1BVIzAgc3R1Y2sgZm9y
DQo+ID4gPiA+ID4gMjNzIQ0KPiA+ID4gPiA+IFttb3VudC5uZnM6MjYyNF0NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBJIGRvbid0IGhhdmUgc3VjaCBwcm9ibGVtcyB3aXRoIHRoZSBwYXRjaCBzZXJp
ZXMgdGhhdCBOZWlsDQo+ID4gPiA+ID4gaGFzDQo+ID4gPiA+ID4gcG9zdGVkLg0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFRoYW5rIHlvdS4NCj4gPiA+ID4gDQo+ID4gPiA+IEhvdyBhcmUgdGhlIHBh
dGNoc2V0cyBkaWZmZXJlbnQ/IEFzIGZhciBhcyBJIGtub3csIGFsbCBJIGRpZA0KPiA+ID4gPiB3
YXMNCj4gPiA+ID4gYXBwbHkNCj4gPiA+ID4gdGhlIDMgcGF0Y2hlcyB0aGF0IE5laWwgYWRkZWQg
dG8gbXkgZXhpc3RpbmcgYnJhbmNoLg0KPiA+ID4gDQo+ID4gPiBJJ20gbm90IHN1cmUuIEkgaGFk
IGEgcHJvYmxlbSB3aXRoIHlvdXIgIm11bHRpcGF0aCIgYnJhbmNoIGJlZm9yZQ0KPiA+ID4gYW5k
DQo+ID4gPiBJIHJlY2FsbCB3aGF0IEkgZGlkIGlzIHdlbnQgYmFjayBhbmQgcmVkb3dubG9hZGVk
IHlvdXIgcG9zdGVkDQo+ID4gPiBwYXRjaGVzLg0KPiA+ID4gVGhhdCB3YXMgd2hlbiBJIHdhcyB0
ZXN0aW5nIHBlcmZvcm1hbmNlLiBTbyBpZiB5b3UgaGF2ZW4ndA0KPiA+ID4gdG91Y2hlZA0KPiA+
ID4gdGhhdCBicmFuY2ggYW5kIGp1c3QgdXNlZCBpdCBJIHRoaW5rIGl0J3MgdGhlIHNhbWUgcHJv
YmxlbS4NCj4gPiA+IA0KPiA+ID4gSW4gdGhlIGN1cnJlbnQgdGVzdGluZyBicmFuY2ggSSBkb24n
dCBzZWUgc2V2ZXJhbCBwYXRjaGVzIHRoYXQNCj4gPiA+IE5laWwNCj4gPiA+IGhhcyBhZGRlZCAo
cG9zdGVkKSB0byB0aGUgbWFpbGluZyBsaXN0LiBTbyBJJ20gbm90IHN1cmUgd2hhdCB5b3UNCj4g
PiA+IG1lYW4NCj4gPiA+IHlvdSBhZGRlZCAzIG9mIGhpcyBwYXRjaGVzIG9uIHRvcCBvZiB5b3Vy
cy4gQXQgbW9zdCBJIGNhbiBzYXkNCj4gPiA+IG1heWJlDQo+ID4gPiB5b3UgYWRkZWQgMiBvZiBo
aXMgKG9uZSB0aGF0IGFsbG93cyBmb3IgdjIgYW5kIHYzIGFuZCBhbm90aGVyDQo+ID4gPiB0aGF0
DQo+ID4gPiBkb2VzIHN0YXRlIG9wZXJhdGlvbnMgb24gYSBzaW5nbGUgY29ubmVjdGlvbi4gVGhl
cmUgYXJlIG5vDQo+ID4gPiBwYXRjaGVzDQo+ID4gPiBmb3INCj4gPiA+IHN1bnJwYyBzdGF0cyB0
aGF0IHdlcmUgcG9zdGVkKS4NCj4gPiA+IA0KPiA+ID4gV2hhdCBJIGtub3cgaXMgdGhhdCBpZiBJ
IHJldmVydCB5b3VyIGJyYW5jaCB0bw0KPiA+ID4gYmYxMWZiZGIyMGIzODUxNTdiMDQ2ZWE3Nzgx
ZjA0ZDBjNjI1NTRhMyBiZWZvcmUgcGF0Y2hlcyBhbmQgYXBwbHkNCj4gPiA+IE5laWxzIHBhdGNo
ZXMuIEFsbCBpcyBmaW5lLiBJIHJlYWxseSBkb24ndCB3YW50IHRvIGRlYnVnIGEgbm9uLQ0KPiA+
ID4gd29ya2luZw0KPiA+ID4gdmVyc2lvbiB3aGVuIHRoZXJlIGlzIG9uZSB0aGF0IHdvcmtzLg0K
PiA+IA0KPiA+IFN1cmUsIGJ1dCB0aGF0IGlzIG5vdCByZWFsbHkgYW4gb3B0aW9uIGdpdmVuIHRo
ZSBydWxlcyBmb3IgaG93DQo+ID4gdHJlZXMgaW4NCj4gPiBsaW51eC1uZXh0IGFyZSBzdXBwb3Nl
ZCB0byB3b3JrLiBUaGV5IGFyZSBjb25zaWRlcmVkIHRvIGJlIG1vcmUgb3INCj4gPiBsZXNzDQo+
ID4gc3RhYmxlLg0KPiA+IA0KPiA+IEFueWhvdywgSSB0aGluayBJJ3ZlIGZvdW5kIHRoZSBidWcu
IE5laWwgaGFkIHNpbGVudGx5IGZpeGVkIGl0IGluDQo+ID4gb25lDQo+ID4gb2YgbXkgcGF0Y2hl
cywgc28gSSd2ZSBhZGRlZCBhbiBpbmNyZW1lbnRhbCBwYXRjaCB0aGF0IGRvZXMgbW9yZSBvcg0K
PiA+IGxlc3Mgd2hhdCBoZSBkaWQuDQo+IA0KPiBJIGp1c3QgcHVsbGVkIGFuZCBJIHN0aWxsIGhh
dmUgYSBwcm9ibGVtIHdpdGggdGhlIG5jb25uZWN0IG1vdW50Lg0KPiBNYWNoaW5lIHN0aWxsIGhh
bmdzLg0KPiANCj4gU3RhY2sgdHJhY2UgaXNuJ3QgaW4gTkZTIGJ1dCBJJ20gYmV0dGluZyBpdCdz
IHNvbWVob3cgcmVsYXRlZA0KPiANCj4gWyAgMjM1Ljc1Njc0N10gZ2VuZXJhbCBwcm90ZWN0aW9u
IGZhdWx0OiAwMDAwIFsjMV0gU01QIFBUSQ0KPiBbICAyMzUuNzY1MTg3XSBDUFU6IDAgUElEOiAy
NzgwIENvbW06IHBvb2wgVGFpbnRlZDogRyAgICAgICAgVw0KPiA1LjIuMC1yYzcrICMyOQ0KPiBb
ICAyMzUuNzY4NTU1XSBIYXJkd2FyZSBuYW1lOiBWTXdhcmUsIEluYy4gVk13YXJlIFZpcnR1YWwN
Cj4gUGxhdGZvcm0vNDQwQlggRGVza3RvcCBSZWZlcmVuY2UgUGxhdGZvcm0sIEJJT1MgNi4wMCAw
NC8xMy8yMDE4DQo+IFsgIDIzNS43NzQzNjhdIFJJUDogMDAxMDprbWVtX2NhY2hlX2FsbG9jX25v
ZGVfdHJhY2UrMHgxMGIvMHgxZTANCj4gWyAgMjM1Ljc3NzU3Nl0gQ29kZTogNGQgODkgZTEgNDEg
ZjYgNDQgMjQgMGIgMDQgMGYgODQgNWYgZmYgZmYgZmYgNGMNCj4gODkgZTcgZTggMDggYjYgMDEg
MDAgNDkgODkgYzEgZTkgNGYgZmYgZmYgZmYgNDEgOGIgNDEgMjAgNDkgOGIgMzkgNDgNCj4gOGQg
NGEgMDEgPDQ5PiA4YiAxYyAwNiA0YyA4OSBmMCA2NSA0OCAwZiBjNyAwZiAwZiA5NCBjMCA4NCBj
MCAwZiA4NA0KPiAzNg0KPiBmZiBmZg0KPiBbICAyMzUuNzg2ODExXSBSU1A6IDAwMTg6ZmZmZmJj
N2M0MjAwZmU1OCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFsgIDIzNS43ODk3NzhdIFJBWDogMDAwMDAw
MDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOg0KPiAwMDAwMDAwMDAwMDAyYjdj
DQo+IFsgIDIzNS43OTMyMDRdIFJEWDogMDAwMDAwMDAwMDAwMmI3YiBSU0k6IDAwMDAwMDAwMDAw
MDBkYzAgUkRJOg0KPiAwMDAwMDAwMDAwMDJkOTYNCj4gWyAgMjM1Ljc5NjE4Ml0gUkJQOiAwMDAw
MDAwMDAwMDAwZGMwIFIwODogZmZmZjljN2JmYTgyZDk2MCBSMDk6DQo+IGZmZmY5YzdiY2ZjMDZk
MDANCj4gWyAgMjM1Ljc5OTEzNV0gUjEwOiBmZmZmOWM3YmZkZGYwMjQwIFIxMTogMDAwMDAwMDAw
MDAwMDAwMSBSMTI6DQo+IGZmZmY5YzdiY2ZjMDZkMDANCj4gWyAgMjM1LjgwMjA5NF0gUjEzOiAw
MDAwMDAwMDAwMDAwMDAwIFIxNDogZjAwMGZmNTNmMDAwZmY1MyBSMTU6DQo+IGZmZmZmZmZmYmUy
ZDRkNzENCj4gWyAgMjM1LjgwNTA3Ml0gRlM6ICAwMDAwN2ZkN2YxZDQ4NzAwKDAwMDApIEdTOmZm
ZmY5YzdiZmE4MDAwMDAoMDAwMCkNCj4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiBbICAyMzUu
ODA4NDMwXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMz
DQo+IFsgIDIzNS44MTA3NjJdIENSMjogMDAwMDdmZDdmMGViNjVhNCBDUjM6IDAwMDAwMDAwMTIw
NDYwMDUgQ1I0Og0KPiAwMDAwMDAwMDAwMTYwNmYwDQo+IFsgIDIzNS44MTM2NjJdIENhbGwgVHJh
Y2U6DQo+IFsgIDIzNS44MTQ2OTRdICBhbGxvY19ydF9zY2hlZF9ncm91cCsweGYxLzB4MjUwDQo+
IFsgIDIzNS44MTY0MzldICBzY2hlZF9jcmVhdGVfZ3JvdXArMHg1OS8weDcwDQo+IFsgIDIzNS44
MTgwOTRdICBzY2hlZF9hdXRvZ3JvdXBfY3JlYXRlX2F0dGFjaCsweDNhLzB4MTYwDQo+IFsgIDIz
NS44MjAxNDhdICBrc3lzX3NldHNpZCsweGViLzB4MTAwDQo+IFsgIDIzNS44MjE2NDVdICBfX2lh
MzJfc3lzX3NldHNpZCsweGEvMHgxMA0KPiBbICAyMzUuODIzMjE2XSAgZG9fc3lzY2FsbF82NCsw
eDU1LzB4MWEwDQo+IFsgIDIzNS44MjQ3MTBdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg0NC8weGE5DQo+IA0KDQpBaC4uIE1pc3NpbmcgeHBydF9nZXQoKS4gRml4ZWQgaW4gdGhl
ICd0ZXN0aW5nJyBicmFuY2ggbm93LiBJJ2xsIHNlbmQNCm91dCBhIHBhdGNoIGZvciByZXZpZXcu
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
