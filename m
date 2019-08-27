Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0924F9DB01
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 03:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfH0B2U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 21:28:20 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:6112
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726257AbfH0B2T (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 21:28:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXYpiV4c03WvLfAtBDE8TGlO+YpwWyf2YyhMyFLoRkWIR94+1yYLAS/08WQ//7Hm7mw7xMQBS//V6ROQdXesyckPU8YkYqGDU3flsw8ehJC4rojZu2d3p8ionmXhQnho8wRZy8mK8lGa+C1AYX6fpmzq6Im4QVC0GYY1c2ZLrUAbS2bTd1Vlu4HV9Z+M8dmRpQlOBl1On7hcak3JSZkrsS2dq/PC61H/4zhBHRSZ6jCaoYDHN0/VOnXM8hWfKbJPjCHUSJBhhTus10GObv2EwuDU/OHFJJ2fyfGT9rz1ebU8X+26gTFKm7h8YUFDw4ocgQYpvdI5kwRmXmsjW34ycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VABII8kxCiQSgyvUE1xqh91+paLTm7PUPF1rAQ3Skeo=;
 b=OeWIetcYOZvw09YyKVthOKWodsP4chgCnriOMHvxUTZU3xrANmy0eiDdY4NFPj3Go9oZd/mja3bOD3/cjZ6angRfA+er7Ohh1mYU9h8zVLBOtvYeTtAKrg7v3gZpojp9YXBBh1ZX9CVfSpGyYcenH1i1xbEWdPo3PMaMFEA59uj03VzVh8PRjWV+xdriz7puqC980b4RqAFPdrVfcUUmx2c8EiNpUrzu3YSkBoIHoD0PF5agGxzagDv6YKUMcOL4bgPe9rPBtrAjbiyY07EgwgH8C3blMsSBdjS5KUMc++cs2JvK9NN1Sw5Fp0O+g8i3ohNtzDS/F74GhX6Ur2Je7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VABII8kxCiQSgyvUE1xqh91+paLTm7PUPF1rAQ3Skeo=;
 b=ZgQ7Z4vJBGPrfofSLS3w43G4VazPffwhMZM8tuLUosmodkDlG9SUfm9m7EiAQ27A9Td10N3y83/9xHu9OqBHAvZmvVK0BIak05Sh5g9zyKe6ICgknXQ0ewt9FH8LVEJLyQqqclCH79kwtkxZYN9OHyHBc6pysTC6y3//pc6fNYE=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0937.namprd13.prod.outlook.com (10.168.238.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.14; Tue, 27 Aug 2019 01:28:15 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 01:28:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Topic: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Index: AQHVXC7WXUD5cV8FEUS4EYbsSk6I0qcN59MAgAAC84CAAD8PgIAAAjcAgAAE+QCAAAQBAA==
Date:   Tue, 27 Aug 2019 01:28:15 +0000
Message-ID: <b4b0c968cc3b9a595c45abfa11452ca203f805e7.camel@hammerspace.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
         <20190826205156.GA27834@fieldses.org>
         <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
         <20190827004811.GA30827@fieldses.org>
         <a2045dcd33d7f53fadd50212160c531c2e0c236f.camel@hammerspace.com>
         <20190827011354.GB30827@fieldses.org>
In-Reply-To: <20190827011354.GB30827@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d602ace-8321-4754-1421-08d72a8dd577
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB0937;
x-ms-traffictypediagnostic: DM5PR13MB0937:
x-microsoft-antispam-prvs: <DM5PR13MB0937B82EC13F6B13965DB627B8A00@DM5PR13MB0937.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39840400004)(136003)(52314003)(189003)(199004)(316002)(6246003)(11346002)(76176011)(6916009)(2616005)(25786009)(6436002)(4326008)(5660300002)(446003)(36756003)(6506007)(99286004)(6486002)(486006)(71190400001)(86362001)(6512007)(2906002)(2501003)(476003)(53936002)(256004)(66066001)(478600001)(229853002)(91956017)(186003)(66946007)(8676002)(81166006)(1730700003)(81156014)(54906003)(118296001)(76116006)(26005)(66446008)(64756008)(66556008)(66476007)(14454004)(7736002)(3846002)(305945005)(6116002)(8936002)(102836004)(5640700003)(2351001)(71200400001)(17423001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0937;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +zdS+9Qkl0nV/YZt7MfBBEXY65N7LqefzTYuoK2xy9ylnMoER4w9xk9c90xw5CcYwDFc57XXJsGhePVYIqsZ4IrR/v7OhCJLYLV+hGfVSUhoaODVLcL63QdDyuRbDhdFQh7SPqL0tnX1Y6IZaKRSBsAXiduBljzWJ2pBIt4YPPPFzHJ1BILD43aPTIu2M9xVGGSHmX3Mqv4qO2nv+eLWrE9udeyaSUNrkBWN02C4jfnofrjCz4xryXrGvOhbg+mquUIHYnvZTx/GaGVOUqeZrwrciwzJZkzK+Ng1m0ele7Fubve9Tw3ngHV3h/pM23+I1AlWfQXQxKngRfhMe34U25RIv0WmNdDBvn5n8XIUznmVzEqhW0ABXNzMZ4//+pUZimAqfuNXFvbrbPbI4Bv+xEAR026pTInsKtbSKFGcQJI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A90E0A44A97FB748A5B3920F414C4168@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d602ace-8321-4754-1421-08d72a8dd577
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 01:28:15.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9g23DJQ7aDYhDQcdJFF+I5mGRBREdQss6xkXWFPNYDCXDorggz7W5cqtPoRoJ4y3bWNoFRRmyG5kHwns/gT+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0937
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDIxOjEzIC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgMTI6NTY6MDdBTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0wOC0yNiBhdCAyMDo0OCAtMDQwMCwg
YmZpZWxkc0BmaWVsZHNlcy5vcmcgd3JvdGU6DQo+ID4gPiBPbiBNb24sIEF1ZyAyNiwgMjAxOSBh
dCAwOTowMjozMVBNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IE9uIE1v
biwgMjAxOS0wOC0yNiBhdCAxNjo1MSAtMDQwMCwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+
ID4gPiA+IE9uIE1vbiwgQXVnIDI2LCAyMDE5IGF0IDEyOjUwOjE4UE0gLTA0MDAsIFRyb25kIE15
a2xlYnVzdA0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gTm90ZSB0aGF0IGlmIG11bHRp
cGxlIGNsaWVudHMgd2VyZSB3cml0aW5nIHRvIHRoZSBzYW1lDQo+ID4gPiA+ID4gPiBmaWxlLA0K
PiA+ID4gPiA+ID4gdGhlbiB3ZSBwcm9iYWJseSB3YW50IHRvIGJ1bXAgdGhlIGJvb3QgdmVyaWZp
ZXIgYW55d2F5LA0KPiA+ID4gPiA+ID4gc2luY2UNCj4gPiA+ID4gPiA+IG9ubHkgb25lIENPTU1J
VCB3aWxsIHNlZSB0aGUgZXJyb3IgcmVwb3J0IChiZWNhdXNlIHRoZQ0KPiA+ID4gPiA+ID4gY2Fj
aGVkDQo+ID4gPiA+ID4gPiBmaWxlIGlzIGFsc28gc2hhcmVkKS4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBJJ20gY29uZnVzZWQgYnkgdGhlICJwcm9iYWJseSBzaG91bGQiLiAgU28gdGhhdCdzIGZ1
dHVyZQ0KPiA+ID4gPiA+IHdvcms/DQo+ID4gPiA+ID4gSSBndWVzcyBpdCdkIG1lYW4gc29tZSBh
ZGRpdGlvbmFsIHdvcmsgdG8gaWRlbnRpZnkgdGhhdCBjYXNlLg0KPiA+ID4gPiA+IFlvdSBjYW4n
dCByZWFsbHkgZXZlbiBkaXN0aW5ndWlzaCBjbGllbnRzIGluIHRoZSBORlN2MyBjYXNlLA0KPiA+
ID4gPiA+IGJ1dA0KPiA+ID4gPiA+IEkgc3VwcG9zZSB5b3UgY291bGQgdXNlIElQIGFkZHJlc3Mg
b3IgVENQIGNvbm5lY3Rpb24gYXMgYW4NCj4gPiA+ID4gPiBhcHByb3hpbWF0aW9uLg0KPiA+ID4g
PiANCj4gPiA+ID4gSSdtIHN1Z2dlc3Rpbmcgd2Ugc2hvdWxkIGRvIHRoaXMgdG9vLCBidXQgSSBo
YXZlbid0IGRvbmUgc28geWV0DQo+ID4gPiA+IGluDQo+ID4gPiA+IHRoZXNlIHBhdGNoZXMuIEkn
ZCBsaWtlIHRvIGhlYXIgb3RoZXIgb3BpbmlvbnMgKHBhcnRpY3VsYXJseQ0KPiA+ID4gPiBmcm9t
DQo+ID4gPiA+IHlvdSwgQ2h1Y2sgYW5kIEplZmYpLg0KPiA+ID4gDQo+ID4gPiBEb2VzIHRoaXMg
cHJvY2VzcyBhY3R1YWxseSBjb252ZXJnZSwgb3IgZG8gd2UgZW5kIHVwIHdpdGggYWxsIHRoZQ0K
PiA+ID4gY2xpZW50cyByZXRyeWluZyB0aGUgd3JpdGVzIGFuZCwgYWdhaW4sIG9ubHkgb25lIG9m
IHRoZW0gZ2V0dGluZw0KPiA+ID4gdGhlDQo+ID4gPiBlcnJvcj8NCj4gPiANCj4gPiBUaGUgY2xp
ZW50IHRoYXQgZ2V0cyB0aGUgZXJyb3Igc2hvdWxkIHN0b3AgcmV0cnlpbmcgaWYgdGhlIGVycm9y
IGlzDQo+ID4gZmF0YWwuDQo+IA0KPiBIYXZlIGNsaWVudHMgaGlzdG9yaWNhbGx5IGJlZW4gZ29v
ZCBhYm91dCB0aGF0PyAgSSBqdXN0IHdvbmRlcg0KPiB3aGV0aGVyDQo+IGl0J3MgYSBjb25jZXJu
IHRoYXQgYm9vdC12ZXJpZmllci1idW1waW5nIGNvdWxkIG1hZ25pZnkgdGhlIGltcGFjdCBvZg0K
PiBjbGllbnRzIHRoYXQgYXJlIG92ZXJseSBwZXJzaXN0ZW50IGFib3V0IHJldHJ5aW5nIElPIGVy
cm9ycy4NCj4gDQoNCkNsaWVudHMgaGF2ZSBhbHdheXMgYmVlbiByZXF1aXJlZCB0byBoYW5kbGUg
SS9PIGVycm9ycywgeWVzLCBhbmQgdGhpcw0KaXNuJ3QganVzdCBhIExpbnV4IHNlcnZlciB0aGlu
Zy4gQWxsIG90aGVyIHNlcnZlcnMgdGhhdCBzdXBwb3J0DQp1bnN0YWJsZSB3cml0ZXMgaW1wb3Nl
IHRoZSBzYW1lIHJlcXVpcmVtZW50IG9uIHRoZSBjbGllbnQgdG8gY2hlY2sgdGhlDQpyZXR1cm4g
dmFsdWUgb2YgQ09NTUlUIGFuZCB0byBoYW5kbGUgYW55IGVycm9ycy4NCg0KPiA+ID4gSSB3b25k
ZXIgd2hhdCB0aGUgdHlwaWNhbCBlcnJvcnMgYXJlLCBhbnl3YXkuDQo+ID4gDQo+ID4gSSB3b3Vs
ZCBleHBlY3QgRU5PU1BDLCBhbmQgRUlPIHRvIGJlIHRoZSBtb3N0IGNvbW1vbi4gVGhlIGZvcm1l
ciBpZg0KPiA+IGRlbGF5ZWQgYWxsb2NhdGlvbiBhbmQvb3Igc25hcHNob3RzIHJlc3VsdCBpbiB3
cml0ZXMgZmFpbGluZyBhZnRlcg0KPiA+IHdyaXRpbmcgdG8gdGhlIHBhZ2UgY2FjaGUuIFRoZSBs
YXR0ZXIgaWYgd2UgaGl0IGEgZGlzayBvdXRhZ2Ugb3INCj4gPiBvdGhlcg0KPiA+IHN1Y2ggcHJv
YmxlbS4NCj4gDQo+IE1ha2VzIHNlbnNlLg0KPiANCj4gLS1iLg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
