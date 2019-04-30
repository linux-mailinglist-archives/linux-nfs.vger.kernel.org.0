Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4311000C
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2019 21:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD3TDe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Apr 2019 15:03:34 -0400
Received: from mail-eopbgr820108.outbound.protection.outlook.com ([40.107.82.108]:55488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfD3TDe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Apr 2019 15:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44jCw6WLLHuK2OVclWyIzHbRmYvPV4bjJ4CvLQGaXZQ=;
 b=OHRRY9G3nQeTCi3DltCOgsB0m6d16WiviyVBZ9Omwgd0xWhDVPzvpw095yjCZnxZ8JXu9v+RuCmjLyNc4bK4w944Vp1PTbrWj5ZR0k13wFjmDVwgSuct2taowIZUcqJw+2iqIARU0a/lFWiyo4wwW9/Zy4ThY+RFI+V1xFNnFVY=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2495.namprd13.prod.outlook.com (52.135.95.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.5; Tue, 30 Apr 2019 19:03:29 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511%7]) with mapi id 15.20.1856.008; Tue, 30 Apr 2019
 19:03:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "smayhew@redhat.com" <smayhew@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: CB_RECALL can race with FREE_STATEID
Thread-Topic: [PATCH] nfsd: CB_RECALL can race with FREE_STATEID
Thread-Index: AQHU9eoA+LnbIrF7jEWsGwkuP/UCjKZCBqYAgABeNgCAAA0pAIASr5+AgAABTwA=
Date:   Tue, 30 Apr 2019 19:03:29 +0000
Message-ID: <5ef90bd5ac79236458ffa04b7eb1d7812431859f.camel@hammerspace.com>
References: <20190418132400.24161-1-smayhew@redhat.com>
         <20190418151312.GB29274@fieldses.org>
         <20190418205024.GB15226@coeurl.usersys.redhat.com>
         <20190418213730.GA1891@fieldses.org>
         <20190430185845.GG15226@coeurl.usersys.redhat.com>
In-Reply-To: <20190430185845.GG15226@coeurl.usersys.redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fa35e34-b469-4e59-2dda-08d6cd9e882a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR13MB2495;
x-ms-traffictypediagnostic: SN6PR13MB2495:
x-microsoft-antispam-prvs: <SN6PR13MB2495832C9FEABD9DDB75461CB83A0@SN6PR13MB2495.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39830400003)(136003)(366004)(199004)(189003)(81166006)(81156014)(5660300002)(478600001)(8676002)(6486002)(2616005)(446003)(11346002)(486006)(110136005)(54906003)(25786009)(316002)(14454004)(8936002)(186003)(26005)(102836004)(6436002)(476003)(6506007)(2906002)(118296001)(93886005)(53936002)(6246003)(256004)(71190400001)(71200400001)(229853002)(86362001)(97736004)(6512007)(36756003)(4326008)(2501003)(6116002)(3846002)(68736007)(305945005)(76176011)(66476007)(64756008)(66556008)(7736002)(66446008)(99286004)(66946007)(73956011)(66066001)(91956017)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2495;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W/ES9ty9zi4Oz37E3VKvCYA8x9o0gqqaHoUksCydQaFwZpl8WKhDwmBKHiN2dMGGnQReyxbA1sQD0X2Uu4YvxMvYX9DkTnDfUGSU2+kzUOZyvfO8FAjyryEWMm/uGx1MM/NtLVxOTDb+AltIQgrBBEpTJK68KpR9FXzAwz3fPkJeAuo61lNm5cxfiT3wu8Is4QIryQS3W5FQIpyxLp1CTLmiQIbxgTL2F15rNqfmdpmrIvAe/QMPgO5Ip6wcHL0TAWIk4GaL5wW96G1oZWxfK+Lb8+k11loeQFxyvTP8oq89avnslDs4lVGFl9ya7f9qPBNx/LzkL59drTeJePRr3hWUz6A4IAgNBCgHjE6dO1MTFI1Wekn7edM3UWmsZM0dwW/9AT5wu8O8OZv4TLrm1ylBljqTo++ysMcWbUJdDKo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E25E36EA87DEF14B99F1E30918677A55@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa35e34-b469-4e59-2dda-08d6cd9e882a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 19:03:29.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2495
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA0LTMwIGF0IDE0OjU4IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9uIFRodSwgMTggQXByIDIwMTksIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gDQo+ID4gT24g
VGh1LCBBcHIgMTgsIDIwMTkgYXQgMDQ6NTA6MjRQTSAtMDQwMCwgU2NvdHQgTWF5aGV3IHdyb3Rl
Og0KPiA+ID4gT24gVGh1LCAxOCBBcHIgMjAxOSwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+
ID4gDQo+ID4gPiA+IE9uIFRodSwgQXByIDE4LCAyMDE5IGF0IDA5OjI0OjAwQU0gLTA0MDAsIFNj
b3R0IE1heWhldyB3cm90ZToNCj4gPiA+ID4gPiBXaGlsZSB0cnlpbmcgdG8gdHJhY2sgZG93biBz
b21lIGlzc3VlcyBpbnZvbHZpbmcgbGFyZ2UNCj4gPiA+ID4gPiBudW1iZXJzIG9mDQo+ID4gPiA+
ID4gZGVsZWdhdGlvbnMgYmVpbmcgcmVjYWxsZWQvcmV2b2tlZCwgSSBjYXVnaHQgdGhlIHNlcnZl
cg0KPiA+ID4gPiA+IHNldHRpbmcNCj4gPiA+ID4gPiBTRVE0X1NUQVRVU19DQl9QQVRIX0RPV04g
d2hpbGUgdGhlIGNsaWVudCB3YXMgYWN0aXZlbHkNCj4gPiA+ID4gPiByZXNwb25kaW5nIHRvDQo+
ID4gPiA+ID4gQ0JfUkVDQUxMcy4gIEl0IHR1cm5zIG91dCB0aGF0IHRoZSBjbGllbnQgaGFkIGFs
cmVhZHkgZG9uZSBhDQo+ID4gPiA+ID4gVEVTVF9TVEFURUlEIGFuZCBGUkVFX1NUQVRFSUQgZm9y
IGEgZGVsZWdhdGlvbiBiZWluZyByZWNhbGxlZA0KPiA+ID4gPiA+IGJ5IHRoZQ0KPiA+ID4gPiA+
IHRpbWUgaXQgcmVjZWl2ZWQgdGhlIENCX1JFQ0FMTC4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYXQn
cyBpbnRlcmVzdGluZywgdGhhbmtzIQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBleGNlcHRpb24g
c2VlbXMgYXdmdWxseSBuYXJyb3csIHRob3VnaC4NCj4gPiA+ID4gDQo+ID4gPiA+IElmIHdlIGdl
dCBiYWNrIGFueSBORlMtbGV2ZWwgZXJyb3IgYXQgYWxsLCB0aGVuIEkgdGhpbmsgdGhlDQo+ID4g
PiA+IGNhbGxiYWNrDQo+ID4gPiA+IGNoYW5uZWwgaXMgd29ya2luZyAoYW0gSSB3cm9uZz8pDQo+
ID4gPiANCj4gPiA+IENvcnJlY3QsIGlmIHRoZSBjbGllbnQgcmVwbGllcyB3aXRoIGVpdGhlciBO
RlM0RVJSX0RFTEFZIG9yDQo+ID4gPiBORlM0RVJSX0JBRF9TVEFURUlELCB0aGUgc2VydmVyIHdp
bGwgcmV0cnkgMSB0aW1lIChzZWUNCj4gPiA+IGRsX3JldHJpZXMpLg0KPiA+ID4gQWZ0ZXIgdGhh
dCwgd2UgZmFsbCB0aHJ1IGFuZCBuZnNkNF9jYl9yZWNhbGxfZG9uZSgpIHJldHVybnMgLTENCj4g
PiA+IHdoaWNoDQo+ID4gPiBjYXVzZXMgdGhlIFNFUTRfU1RBVFVTX0NCX1BBVEhfRE9XTiBmbGFn
IHRvIGJlIHNldC4NCj4gPiA+IA0KPiA+ID4gPiBhbmQgdGVsbGluZyB0aGUgY2xpZW50IHRvIHNl
dCB1cCBhIG5ldw0KPiA+ID4gPiBvbmUgaXMgcHJvYmFibHkgbm90IGdvaW5nIHRvIGhlbHAuICBU
aGUgYmVzdCB3ZSBjYW4gZG8gaXMNCj4gPiA+ID4gcHJvYmFibHkganVzdA0KPiA+ID4gPiBnaXZl
IHVwDQo+ID4gPiANCj4gPiA+IFRoYXQncyB3aGF0IHRoZSBwYXRjaCBpcyBlc3NlbnRpYWxseSBk
b2luZy4gIE9yIGFyZSB5b3Ugc2F5aW5nDQo+ID4gPiBkb24ndA0KPiA+ID4gZXZlbiBib3RoZXIg
d2l0aCB0aGUgY2hlY2tzIGJ1dCBzdGlsbCByZXR1cm4gMSBzbyB3ZSBkb24ndCBzZXQNCj4gPiA+
IHRoZQ0KPiA+ID4gU0VRNF9TVEFUVVNfQ0JfUEFUSF9ET1dOIGZsYWc/DQo+ID4gDQo+ID4gUmln
aHQsIEkgZG9uJ3Qgc2VlIGFueSBwb2ludCByZXR1cm5pbmcgLTEgKHdoaWNoIGVuZHMgdXAgc2V0
dGluZw0KPiA+IENCX1BBVEhfRE9XTikgaW4gYW55IGNhc2Ugd2hlcmUgd2UgZ2V0IGFuIG5mcy1s
ZXZlbCBlcnJvci4gIElmIHRoZQ0KPiA+IGNsaWVudCBnb3Qgc28gZmFyIGFzIHJldHVybmluZyBh
biBlcnJvciwgdGhlbiB0aGUgY2FsbGJhY2sgcGF0aCBpcw0KPiA+IHdvcmtpbmcuDQo+ID4gDQo+
ID4gSSdtIG5vdCBzdXJlIGV4YWN0bHkgd2hhdCBlcnJvcnMgKnNob3VsZCogcmVzdWx0IGluIENC
X1BBVEhfRE9XTiwNCj4gPiB0aG91Z2guICBFVElNRURPVVQsIEVOT1RDT05OLCBFSU8/DQo+IA0K
PiBJJ20gbm90IHN1cmUgZWl0aGVyLiAgTG9va2luZyBhdA0KPiBjYWxsX3N0YXR1cy9jYWxsX3Rp
bWVvdXQvcnBjX2NoZWNrX3RpbWVvdXQsIGl0IGxvb2tzIHRvIG1lIGxpa2UNCj4gRU5PVENPTk4N
Cj4gd2lsbCBiZSB0cmFuc2xhdGVkIHRvIEVUSU1FRE9VVCBiZWNhdXNlIG5mc2Q0X3J1bl9jYl93
b3JrIHNldHMgdGhlIA0KPiBSUENfVEFTS19TT0ZUQ09OTiBmbGFnIGluIHRoZSBjYWxsIHRvIHJw
Y19jYWxsX2FzeW5jLg0KPiANCj4gSXQgbG9va3MgbGlrZSBjYWxsX3N0YXR1cyBjYW4gcmV0dXJu
IEVIT1NURE9XTiwgRU5FVERPV04sDQo+IEVIT1NUVU5SRUFDSCwNCj4gRU5FVFVOUkVBQ0gsIGFu
ZCBFUEVSTS4uLiBzaG91bGQgdGhvc2UgYmUgaGFuZGxlZCBhcyB3ZWxsPw0KDQpUaG9zZSBlcnJv
cnMgc2hvdWxkIG5ldmVyIGJlIHBhc3NlZCBiYWNrIHRvIGFwcGxpY2F0aW9ucy4NCg0KLS0gDQpU
cm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UN
CnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
