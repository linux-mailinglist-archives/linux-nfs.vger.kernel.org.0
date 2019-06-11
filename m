Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDD3D6B4
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407596AbfFKTVt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 15:21:49 -0400
Received: from mail-eopbgr810102.outbound.protection.outlook.com ([40.107.81.102]:51584
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407595AbfFKTVs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Jun 2019 15:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsXM2qhm2LZiKU6w7cfoc7Y7/IZC+izN2FghjdJvCM8=;
 b=e4NJ7QHcJ59ocNi0Hf/ilGFNvYnc8ft/n+Hh2ib8p+eKc5e3i1VJN3sqorqnBiKJh3E022IZXE0cHyXGFbp+QUlGWzWVx6VV/+w8TcTo+Bq/1posMeaJlSraDWa3xIaxDaqN3KAOZ91ApFRvSkPxvefX/L58VswnvBE7bQM4yho=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1515.namprd13.prod.outlook.com (10.175.111.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 11 Jun 2019 19:21:45 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1987.010; Tue, 11 Jun 2019
 19:21:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Cache consistency updates
Thread-Topic: [PATCH 0/3] Cache consistency updates
Thread-Index: AQHVIINyg1zxTQCAiUy7Z6tokCDIyKaWxrMAgAAOFIA=
Date:   Tue, 11 Jun 2019 19:21:45 +0000
Message-ID: <d7ac89498918ad28f434d29bf08cf99817b71820.camel@hammerspace.com>
References: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
         <B29E9170-287F-4E10-B1AE-4E12303435B3@oracle.com>
In-Reply-To: <B29E9170-287F-4E10-B1AE-4E12303435B3@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a2cf509-59fe-421f-dc52-08d6eea20b0e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1515;
x-ms-traffictypediagnostic: DM5PR13MB1515:
x-microsoft-antispam-prvs: <DM5PR13MB151596C81F8A7E1018BF8F69B8ED0@DM5PR13MB1515.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39830400003)(376002)(136003)(366004)(189003)(199004)(8936002)(14454004)(76176011)(118296001)(486006)(6506007)(53546011)(305945005)(5660300002)(68736007)(36756003)(6436002)(476003)(6916009)(8676002)(81156014)(99286004)(81166006)(316002)(11346002)(102836004)(5640700003)(53936002)(6486002)(446003)(26005)(186003)(229853002)(478600001)(6512007)(2616005)(73956011)(86362001)(66946007)(76116006)(66446008)(66556008)(64756008)(25786009)(6116002)(3846002)(66476007)(2906002)(14444005)(4326008)(66066001)(256004)(7736002)(2501003)(71200400001)(71190400001)(2351001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1515;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gBiCQ1eIUvHfNDd9Ld1QHHTbbDx25kgv3i1ghJ1nM6eLi3mZo6ifXD/6Q+flXJRu/4C3QMiBXTFjojxX1vblbLADovHn5wks1ZWSStXOVO6BHwLrz7wH+AHvkB6NTncO5AvmCik1NCTvw2xnZKJN7SD9SqkQ3YCj+cpYoKH8mJas9sy/HreuoxEX6DW+nxzMMR4rRJfNF5JoPl5OuGpwY9R5FW6pISHykZR/FfyIZq0Vuyw8VsdXW7jWheCJsdo0Aj7VaQXNlP9lGEjdRvnQ1NhNbARfkkdG76crK1kP/NTclI0oastuq9CZRmlwejIPrVlLbFHSBO++4vOPw25H8oQr+HUAyyrZaeJvfoRYdn1EoMUHczeyscyAB/5U2HG/2oWm8s9+Y5nbtvYFPlfsTKvHapufNY/aW4sk1QqHV+A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A342A74D3F2BA64881278371FDEAC212@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2cf509-59fe-421f-dc52-08d6eea20b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 19:21:45.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1515
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTExIGF0IDE0OjMxIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBKdW4gMTEsIDIwMTksIGF0IDI6MjUgUE0sIFRyb25kIE15a2xlYnVzdCA8dHJvbmRteUBn
bWFpbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIGEgJ2RlZmVycmVkIGNhY2hlIGlu
dmFsaWRhdGlvbicgbW9kZSB0aGF0IHdlIGNhbiB1c2Ugd2hlbiB3ZQ0KPiA+IHRoaW5nDQo+ID4g
dGhlIE5GUyBjYWNoZSBtYXkgaGF2ZSBiZWVuIGNoYW5nZWQgb24gdGhlIHNlcnZlciwgYnV0IHRo
ZSBmaWxlIGluDQo+ID4gcXVlc3Rpb24gaXMgYWxyZWFkeSBvcGVuIGFuZCBpcyBjYWNoZWQgb24g
dGhlIGNsaWVudC4gSW4gb3JkZXIgdG8NCj4gPiBhdm9pZA0KPiA+IHBlcmZvcm1hbmNlIGlzc3Vl
cyBkdWUgdG8gZmFsc2UgcG9zaXRpdmUgZGV0ZWN0aW9uIG9mIHNlcnZlcg0KPiA+IGNoYW5nZXMs
DQo+ID4gd2UgZGVmZXIgaW52YWxpZGF0aW5nIHRoZSBjYWNoZSB1bnRpbCB0aGUgZmlsZSBoYXMg
YmVlbiBjbG9zZWQsIGFuZA0KPiA+IHRoZSBjYWNoZWQgZGF0YSBpcyBubyBsb25nZXIgaW4gYWN0
aXZlIHVzZS4NCj4gPiANCj4gPiBUcm9uZCBNeWtsZWJ1c3QgKDMpOg0KPiA+ICBORlM6IEZpeCB1
cCBmdHJhY2UgcHJpbnRvdXQgb2YgdGhlIGNhY2hlIGludmFsaWRhdGlvbiBmbGFncw0KPiA+ICBO
RlM6IEZpeCB1cCBmdHJhY2UgbG9nZ2luZyBvZiBuZnNfaW5vZGUgZmxhZ3MNCj4gDQo+IEkgYWxz
byBmaXhlZCB0aGVzZSBpdGVtcyBpbiBteSBmb3ItNS4zIHBhdGNoIHNlcmllcywgYnV0DQo+IG15
IHBhdGNoZXMgYWRkIFRSQUNFX0RFRklORV9FTlVNIGRlZmluaXRpb25zLg0KDQpPaC4gSSBtaXNz
ZWQgdGhvc2UgYmVjYXVzZSB0aGV5IHdlcmUgZW1iZWRkZWQgd2l0aCB0aGUgUkRNQSBjaGFuZ2Vz
Lg0KDQpDYW4geW91IHBsZWFzZSBmaXggdGhlbSB1cCB0byBhbHNvIGNoYW5nZSB0aGUgKDEgPDwg
TkZTX0lOT18qKSBzdHVmZiB0bw0KdXNlIHRoZSBCSVQoKSBtYWNybz8gVGhhdCBjYXVzZXMgYW4g
ZXhwYW5zaW9uIHRvIGFuIHVuc2lnbmVkIGxvbmcgdHlwZQ0KaW5zdGVhZCBvZiB0aGUgY3VycmVu
dCBzaWduZWQgaW50Lg0KDQo+IA0KPiA+ICBORlM6IEFkZCBkZWZlcnJlZCBjYWNoZSBpbnZhbGlk
YXRpb24gZm9yIGNsb3NlLXRvLW9wZW4gY29uc2lzdGVuY3kNCj4gPiAgICB2aW9sYXRpb25zDQo+
ID4gDQo+ID4gZnMvbmZzL2Rpci5jICAgICAgICAgICB8ICA0ICsrKysNCj4gPiBmcy9uZnMvaW5v
ZGUuYyAgICAgICAgIHwgMTUgKysrKysrKysrKystLS0tDQo+ID4gZnMvbmZzL25mc3RyYWNlLmgg
ICAgICB8IDIyICsrKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiBpbmNsdWRlL2xpbnV4L25mc19m
cy5oIHwgIDIgKysNCj4gPiA0IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tIA0KPiA+IDIuMjEuMA0KPiA+IA0KPiANCj4gLS0NCj4g
Q2h1Y2sgTGV2ZXINCj4gDQo+IA0KPiANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
