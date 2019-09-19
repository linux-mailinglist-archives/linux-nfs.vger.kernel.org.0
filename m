Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642B3B882F
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2019 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393236AbfISXmP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 19:42:15 -0400
Received: from mail-eopbgr760100.outbound.protection.outlook.com ([40.107.76.100]:15886
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393099AbfISXmO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 19:42:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbVIRVUP+RmN75/bvF9IU0IVnknYttlUkQnlfosLYsdJZD0SdmZRticju9Lqnpg42mBvbRtCBLI8teyUklUzTXiA4kow08VXvxWM6eNkB+Y+/Q61ZWrpSH8KA0veWtswhXSXq611F9W8Khx6IP+RDYtJ1x7GERVdJcBaIyaNvKUCFk/6VOKtjBnx5IWxItDDzplWeEcUgsOL5WIwfBGu/m1g7xV6eLJDC/XavYHVzeNtL5k66U6aS04TVc1bZUEE6EqKkHNYZBRpWzC2Jg5xjUM2fsQfbWMwqDcZAf1k14Gnkuqc8JPfi5o7P8xrGMuytjdfdetQOrnnzAnDXQeHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXsvnjf6ktq+bxqQWaXX8K3yAx7UwVAszO78EvzzSX0=;
 b=csgrEyC75sfBqIoXb562Vs1K+QViVGVNgXkUHQq4t8K+J26flBBa4dQz8Y+PtRDgJmKa48yv4JKbSTMnv1z/Du9BtaVWOc1NuGFjNvTe5lX5yr4+zNyllivlfVRSpQGK2I8PzrNYQsjt+pZLf0U70EW4dsDxCK2G3Snmmg/mhQlGhzkdp97ui7OQBc4Qk4ip3nKcPoeqmL3v4/eMrwjDK1ng83D4D8ZKiK3QRjxmfhUKe5b2xghIfQjGqePV5ejZNl7nJ5RedPFHame+l33ByPM7KFoix9j5M3KWZdVt9x45tk3KHb2/vH3I5kprs78mfaiqfA9BEWMbDN6NyI07rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXsvnjf6ktq+bxqQWaXX8K3yAx7UwVAszO78EvzzSX0=;
 b=EGUP42h6F6V3m4UiDh7L18jdX8zS79ginE9FR/wZEbToT19M+kR98yYS7r384NY7GpvHZNKQ2mNjb7hMvhn9kxQNq99JNHsjkN3+bsCnTPEMOn3Lh52GkZdqOqkYA+tTbGRkmEcR0fvk4qPIEer+QYffuwUy/U/o8aLY0jrMxcY=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0937.namprd13.prod.outlook.com (10.168.238.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.10; Thu, 19 Sep 2019 23:42:10 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 23:42:10 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v2 0/9] Various NFSv4 state error handling fixes
Thread-Topic: [PATCH v2 0/9] Various NFSv4 state error handling fixes
Thread-Index: AQHVbM/S/fixzh0y6ESu1Qgv6VvgnKcx18EAgABneQCAAL+UgIAAr0SA
Date:   Thu, 19 Sep 2019 23:42:09 +0000
Message-ID: <8720be3295e3b0035396b9bec70231a628231c93.camel@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
         <CAN-5tyF27z=+3tbU1De_wR0aosiczn67dNanBmBe4icj=uAYwQ@mail.gmail.com>
         <4c620de7a944ff38644eceb4fed863f5092f1a15.camel@hammerspace.com>
         <CAN-5tyGX_Mb-wGTREtSWRFFSNK0qjgqLbm8SFPG=DPM7M2OWoQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGX_Mb-wGTREtSWRFFSNK0qjgqLbm8SFPG=DPM7M2OWoQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78b7c34b-8dc6-40f4-61c4-08d73d5afd30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB0937;
x-ms-traffictypediagnostic: DM5PR13MB0937:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR13MB09374D63868E3023617840A2B8890@DM5PR13MB0937.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39830400003)(136003)(199004)(189003)(91956017)(2616005)(6246003)(86362001)(14454004)(2501003)(66066001)(2171002)(11346002)(446003)(186003)(26005)(6512007)(1730700003)(5660300002)(478600001)(81156014)(5640700003)(81166006)(3846002)(316002)(6116002)(6436002)(36756003)(15974865002)(2906002)(6916009)(229853002)(54906003)(76176011)(256004)(476003)(5024004)(305945005)(118296001)(8936002)(486006)(14444005)(25786009)(53546011)(6506007)(99286004)(102836004)(4326008)(76116006)(6486002)(8676002)(66556008)(2351001)(71190400001)(66946007)(7736002)(71200400001)(66446008)(66476007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0937;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W8/s0Hg1lpbZUeBy0pu0F7U3l1lopRMCgs5+FnzK6dioHMHEL7LL6xRrqX8sHgAI5c/gVShUIsBSqej2FQyCvBFAC4aKyEj5i4ayJUDUU3n1+7iGOz2aRjvfuAUahXnW4FZ/eHUvtIe4aW7skos+pBN8AsuqPfw9P22/dTJh7ZsuZR/RwNU3C3DJlzTU3cuzS7OX4Ql3Cq2Opbo9VuSo0/6BBv2A/68S1UcV2vdgnqexZEKuBdvkKFT1sGdiRuPEj7UNxZph142yRYr5dPMQ+/MiypqeRxYEX1YzPQr/NFKnXu2eyrvpbeDi6+QdyUfqpL0qg2uXbPIQmVzI1+ath80GxXIWKrrz/4nKeXbqtJvdXmj1CQBr9FMraurrZn+VhyxPCIAVvRoABCBK4Xygh8PDRdfeLHaApd3o3g7Mliw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE3F2C38B396EA43B193320E0D9CF5C3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b7c34b-8dc6-40f4-61c4-08d73d5afd30
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 23:42:09.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyY+ZDwIMCUDlk4PpPlDD6rbmhlvNIdni0WPOucRLyplfxiRWu2x3rFY/XjQqaueXS18arHZHsz9OyIXwaPGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0937
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBUaHUsIDIwMTktMDktMTkgYXQgMDk6MTQgLTA0MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBIaSBUcm9uZCwNCj4gDQo+IE9uIFdlZCwgU2VwIDE4LCAyMDE5IGF0
IDk6NDkgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdy
b3RlOg0KPiA+IEhpIE9sZ2ENCj4gPiANCj4gPiBPbiBXZWQsIDIwMTktMDktMTggYXQgMTU6Mzgg
LTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4gSGkgVHJvbmQsDQo+ID4gPiAN
Cj4gPiA+IFRoZXNlIHNldCBvZiBwYXRjaGVzIGRvIG5vdCBhZGRyZXNzIHRoZSBsb2NraW5nIHBy
b2JsZW0uIEl0J3MNCj4gPiA+IGFjdHVhbGx5DQo+ID4gPiBub3QgdGhlIGxvY2tpbmcgcGF0Y2gg
KHdoaWNoIEkgdGhvdWdodCBpdCB3YXMgYXMgSSByZXZlcnRlZCBpdA0KPiA+ID4gYW5kDQo+ID4g
PiBzdGlsbCBoYWQgdGhlIGlzc3VlKS4gV2l0aG91dCB0aGUgd2hvbGUgcGF0Y2ggc2VyaWVzIHRo
ZSB1bmxvY2sNCj4gPiA+IHdvcmtzDQo+ID4gPiBmaW5lIHNvIHNvbWV0aGluZyBpbiB0aGVzZSBu
ZXcgcGF0Y2hlcy4gU29tZXRoaW5nIGlzIHVwIHdpdGggdGhlDQo+ID4gPiAyDQo+ID4gPiBwYXRj
aGVzOg0KPiA+ID4gTkZTdjQ6IEhhbmRsZSBORlM0RVJSX09MRF9TVEFURUlEIGluIENMT1NFL09Q
RU5fRE9XTkdSQURFDQo+ID4gPiBORlN2NDogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgaW4g
TE9DS1UNCj4gPiA+IA0KPiA+ID4gSWYgSSByZW1vdmUgZWl0aGVyIG9uZSBzZXBhcmF0ZWx5LCB1
bmxvY2sgZmFpbHMgYnV0IGlmIEkgcmVtb3ZlDQo+ID4gPiBib3RoDQo+ID4gPiB1bmxvY2sgd29y
a3MuDQo+ID4gDQo+ID4gQ2FuIHlvdSBkZXNjcmliZSBob3cgeW91IGFyZSB0ZXN0aW5nIHRoaXMs
IGFuZCBwZXJoYXBzIHByb3ZpZGUNCj4gPiB3aXJlc2hhcmsgdHJhY2VzIHRoYXQgc2hvdyBob3cg
d2UncmUgdHJpZ2dlcmluZyB0aGVzZSBwcm9ibGVtcz8NCj4gDQo+IEknbSB0cmlnZ2VyaW5nIGJ5
IHJ1bm5pbmcgIm5mc3Rlc3RfbG9jayAtLW5mc3ZlcnNpb24gNC4xIC0tcnVudGVzdA0KPiBidGVz
dDAxIiBhZ2FpbnN0IGVpdGhlciBsaW51eCBvciBvbnRhcCBzZXJ2ZXJzICh3aGlsZSB0aGUgdGVz
dA0KPiBkb2Vzbid0DQo+IGZhaWwgYnV0IG9uIHRoZSBuZXR3b3JrIHRyYWNlIHlvdSBjYW4gc2Vl
IHVubG9jayBmYWlsaW5nIHdpdGgNCj4gYmFkX3N0YXRlaWQpLiBOZXR3b3JrIHRyYWNlIGF0dGFj
aGVkLg0KPiANCj4gQnV0IGFjdHVhbGx5IGEgc2ltcGxlIHRlc3Qgb3BlbiwgbG9jaywgdW5sb2Nr
IGRvZXMgdGhlIHRyaWNrIChuZXR3b3JrDQo+IHRyYWNlIGF0dGFjaGVkKS4NCj4gZmQxID0gb3Bl
bihSRFdSKQ0KPiBmY3RsKGZkMSkgKGxvY2sgL3VubG9jaykNCg0KDQpUaGVzZSB0cmFjZXMgcmVh
bGx5IGRvIG5vdCBtZXNoIHdpdGggd2hhdCBJJ20gc2VlaW5nIHVzaW5nIGEgc2ltcGxlDQpDb25u
ZWN0YXRob24gbG9jayB0ZXN0IHJ1bi4gV2hlbiBJIGxvb2sgYXQgdGhlIHdpcmVzaGFyayBvdXRw
dXQgZnJvbQ0KdGhhdCwgSSBzZWUgZXhhZHRseSB0d28gY2FzZXMgd2hlcmUgdGhlIHN0YXRlaWQg
YXJndW1lbnRzIGFyZSBib3RoDQp6ZXJvLCBhbmQgdGhvc2UgYXJlIGJvdGggU0VUQVRUUiwgc28g
ZXhwZWN0ZWQuDQoNCkFsbCB0aGUgTE9DS1UgYXJlIHNob3dpbmcgdXAgYXMgbm9uLXplcm8gc3Rh
dGVpZHMsIGFuZCBzbyBJJ20gc2VlaW5nIG5vDQpCQURfU1RBVEVJRCBvciBPTERfU1RBVEVJRCBl
cnJvcnMgYXQgYWxsLg0KDQpJcyB0aGVyZSBzb21ldGhpbmcgc3BlY2lhbCBhYm91dCBob3cgeW91
ciB0ZXN0IGlzIHJ1bm5pbmc/DQoNCkNoZWVycw0KICBUcm9uZA0KDQpQUzogTm90ZTogSSBkbyB0
aGluayBJIG5lZWQgYSB2MyBvZiB0aGUgTE9DS1UgcGF0Y2ggaW4gb3JkZXIgdG8gYWRkIGENCnNw
aW5sb2NrIGFyb3VuZCB0aGUgbmV3IGNvcHkgb2YgdGhlIGxvY2sgc3RhdGVpZCBpbg0KbmZzNF9h
bGxvY191bmxvY2tkYXRhKCkuIEhvd2V2ZXIgSSBkb24ndCBzZWUgaG93IHRoZSBtaXNzaW5nIHNw
aW5sb2Nrcw0KY291bGQgY2F1c2UgeW91IHRvIGNvbnNpc3RlbnRseSBiZSBzZWVpbmcgYW4gYWxs
LXplcm8gc3RhdGVpZCBhcmd1bWVudC4NCg0KDQo+IA0KPiA+IFRoYW5rcyENCj4gPiAgIFRyb25k
DQo+ID4gDQo+ID4gPiBPbiBNb24sIFNlcCAxNiwgMjAxOSBhdCA0OjQ2IFBNIFRyb25kIE15a2xl
YnVzdCA8DQo+ID4gPiB0cm9uZG15QGdtYWlsLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBW
YXJpb3VzIE5GU3Y0IGZpeGVzIHRvIGVuc3VyZSB3ZSBoYW5kbGUgc3RhdGUgZXJyb3JzIGNvcnJl
Y3RseS4NCj4gPiA+ID4gSW4NCj4gPiA+ID4gcGFydGljdWxhciwgd2UgbmVlZCB0byBlbnN1cmUg
dGhhdCBmb3IgQ09NUE9VTkRzIGxpa2UgQ0xPU0UgYW5kDQo+ID4gPiA+IERFTEVHUkVUVVJOLCB0
aGF0IG1heSBoYXZlIGFuIGVtYmVkZGVkIExBWU9VVFJFVFVSTiwgd2UgaGFuZGxlDQo+ID4gPiA+
IHRoZQ0KPiA+ID4gPiBsYXlvdXQgc3RhdGUgZXJyb3JzIHNvIHRoYXQgYSByZXRyeSBvZiBlaXRo
ZXIgdGhlIExBWU9VVFJFVFVSTiwNCj4gPiA+ID4gb3INCj4gPiA+ID4gdGhlIGxhdGVyIENMT1NF
L0RFTEVHUkVUVVJOIGRvZXMgbm90IGNvcnJ1cHQgdGhlIExBWU9VVFJFVFVSTg0KPiA+ID4gPiBy
ZXBseS4NCj4gPiA+ID4gDQo+ID4gPiA+IEFsc28gZW5zdXJlIHRoYXQgaWYgd2UgZ2V0IGEgTkZT
NEVSUl9PTERfU1RBVEVJRCwgdGhlbiB3ZSBkbw0KPiA+ID4gPiBvdXINCj4gPiA+ID4gYmVzdCB0
byBzdGlsbCB0cnkgdG8gZGVzdHJveSB0aGUgc3RhdGUgb24gdGhlIHNlcnZlciwgaW4gb3JkZXIN
Cj4gPiA+ID4gdG8NCj4gPiA+ID4gYXZvaWQgY2F1c2luZyBzdGF0ZSBsZWFrYWdlLg0KPiA+ID4g
PiANCj4gPiA+ID4gdjI6IEZpeCBidWcgcmVwb3J0cyBmcm9tIE9sZ2ENCj4gPiA+ID4gIC0gVHJ5
IHRvIGF2b2lkIHNlbmRpbmcgb2xkIHN0YXRlaWRzIG9uIENMT1NFL09QRU5fRE9XTkdSQURFDQo+
ID4gPiA+IHdoZW4NCj4gPiA+ID4gICAgZG9pbmcgZnVsbHkgc2VyaWFsaXNlZCBORlN2NC4wLg0K
PiA+ID4gPiAgLSBFbnN1cmUgTE9DS1UgaW5pdGlhbGlzZXMgdGhlIHN0YXRlaWQgY29ycmVjdGx5
Lg0KPiA+ID4gPiANCj4gPiA+ID4gVHJvbmQgTXlrbGVidXN0ICg5KToNCj4gPiA+ID4gICBwTkZT
OiBFbnN1cmUgd2UgZG8gY2xlYXIgdGhlIHJldHVybi1vbi1jbG9zZSBsYXlvdXQgc3RhdGVpZA0K
PiA+ID4gPiBvbg0KPiA+ID4gPiBmYXRhbA0KPiA+ID4gPiAgICAgZXJyb3JzDQo+ID4gPiA+ICAg
TkZTdjQ6IENsZWFuIHVwIHBORlMgcmV0dXJuLW9uLWNsb3NlIGVycm9yIGhhbmRsaW5nDQo+ID4g
PiA+ICAgTkZTdjQ6IEhhbmRsZSBORlM0RVJSX0RFTEFZIGNvcnJlY3RseSBpbiByZXR1cm4tb24t
Y2xvc2UNCj4gPiA+ID4gICBORlN2NDogSGFuZGxlIFJQQyBsZXZlbCBlcnJvcnMgaW4gTEFZT1VU
UkVUVVJODQo+ID4gPiA+ICAgTkZTdjQ6IEFkZCBhIGhlbHBlciB0byBpbmNyZW1lbnQgc3RhdGVp
ZCBzZXFpZHMNCj4gPiA+ID4gICBwTkZTOiBIYW5kbGUgTkZTNEVSUl9PTERfU1RBVEVJRCBvbiBs
YXlvdXRyZXR1cm4gYnkgYnVtcGluZw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gc3RhdGUNCj4gPiA+
ID4gICAgIHNlcWlkDQo+ID4gPiA+ICAgTkZTdjQ6IEZpeCBPUEVOX0RPV05HUkFERSBlcnJvciBo
YW5kbGluZw0KPiA+ID4gPiAgIE5GU3Y0OiBIYW5kbGUgTkZTNEVSUl9PTERfU1RBVEVJRCBpbiBD
TE9TRS9PUEVOX0RPV05HUkFERQ0KPiA+ID4gPiAgIE5GU3Y0OiBIYW5kbGUgTkZTNEVSUl9PTERf
U1RBVEVJRCBpbiBMT0NLVQ0KPiA+ID4gPiANCj4gPiA+ID4gIGZzL25mcy9uZnM0X2ZzLmggICB8
ICAxMSArKy0NCj4gPiA+ID4gIGZzL25mcy9uZnM0cHJvYy5jICB8IDIwNCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4gPiA+IC0tLS0NCj4gPiA+ID4gLS0tLQ0KPiA+
ID4gPiAgZnMvbmZzL25mczRzdGF0ZS5jIHwgIDE2IC0tLS0NCj4gPiA+ID4gIGZzL25mcy9wbmZz
LmMgICAgICB8ICA3MSArKysrKysrKysrKysrKy0tDQo+ID4gPiA+ICBmcy9uZnMvcG5mcy5oICAg
ICAgfCAgMTcgKysrLQ0KPiA+ID4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAyMjkgaW5zZXJ0aW9ucygr
KSwgOTAgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjIxLjAN
Cj4gPiA+ID4gDQo+ID4gLS0NCj4gPiBUcm9uZCBNeWtsZWJ1c3QNCj4gPiBMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQo+ID4gdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KPiA+IA0KPiA+IA0KVHJvbmQgTXlrbGVidXN0DQpDVE8sIEhhbW1lcnNwYWNlIElu
Yw0KNDMwMCBFbCBDYW1pbm8gUmVhbCwgU3VpdGUgMTA1DQpMb3MgQWx0b3MsIENBIDk0MDIyDQp3
d3cuaGFtbWVyLnNwYWNlDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
