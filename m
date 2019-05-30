Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF32EA16
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 03:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfE3BJc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 21:09:32 -0400
Received: from mail-eopbgr760110.outbound.protection.outlook.com ([40.107.76.110]:20194
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3BJc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 21:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWSGOGTNKApfURcQ3/0Uj/dXirfO5CrHZovlOBHRF0A=;
 b=VOtyBVxSsETmGNpSdbEArGuqgHdY1wfq1yFnAssFwEbtz6TdiL2aTsbXv3pW3JETvG8Qs7tKoG26s3I9d9TuKc9gq5TZFFH08V/coMn2KXe4yyPXxBiCqK4FFH2e6S+T4gV3qOzv1nz2q67g8VmRi1frolXwZ8jIkdLjZFBmb6o=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1564.namprd13.prod.outlook.com (10.175.110.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.8; Thu, 30 May 2019 01:09:29 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 01:09:29 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "adp@prgmr.com" <adp@prgmr.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang followed by automount hang requiring
 reboot
Thread-Topic: User process NFS write hang followed by automount hang requiring
 reboot
Thread-Index: AQHVD10Mj9cHITmmLUmLNk72TvyfOqZ1udsAgATUlICACFPBAIAAB7sA
Date:   Thu, 30 May 2019 01:09:28 +0000
Message-ID: <9033f2fd4a777a8e2bce056e15f161984ac76283.camel@hammerspace.com>
References: <20190520223324.GL4158@turtle.email>
         <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
         <20190524173155.GQ4158@turtle.email> <20190530004146.GV4158@turtle.email>
In-Reply-To: <20190530004146.GV4158@turtle.email>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edafa5d4-52ef-4081-60fd-08d6e49b772d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1564;
x-ms-traffictypediagnostic: DM5PR13MB1564:
x-microsoft-antispam-prvs: <DM5PR13MB156422A085F3BA707EB66AB7B8180@DM5PR13MB1564.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(39830400003)(366004)(189003)(199004)(99286004)(2906002)(14454004)(76116006)(2501003)(2616005)(3846002)(6486002)(6116002)(186003)(86362001)(66066001)(118296001)(68736007)(6246003)(76176011)(5660300002)(66476007)(66556008)(6436002)(316002)(53936002)(478600001)(26005)(66946007)(486006)(73956011)(110136005)(71190400001)(66446008)(256004)(14444005)(305945005)(6512007)(476003)(8936002)(7736002)(102836004)(6506007)(25786009)(91956017)(446003)(8676002)(71200400001)(64756008)(229853002)(81166006)(36756003)(11346002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1564;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d6rxh8h7doECgV/aOrump32EiGeS1P8qF+zBUqLg49V8RPCXTCW2FqmTbjTANmAaADS7rvGfCU8k1WbNSCKnsH444d2y7rwwPykulcwEXx4oEfkx+LiuTqmz27YmNK6Fm8/LWBxGif+SFZRwH79ZJBUMTD8/XBBSGNqv3l/Qf6UvMb8F1FRw86BhgoTICOpdokbDoER8wT2vJNSbbTqb5A0/Uzi28ygyDZLfHUpG970iydk4i4hHGXtf5yF44KqoLpcH0EgLQsI6FsvHr925CArPZK2SRZmChcoRzGtMN4gsD17iDItao12ghhLKtHubFGCIRR7nL4/Ic0Z4mKk+SUlYNDMDLmB4i/6g2oQT7uHAHMvRzjtpifUbuvMjGNXSvIxba5UujjiPofGY0ALtSHabgFCxJ3YdNzXAayhOJl4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C9E5DE4A9D42349A253663A003ED808@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edafa5d4-52ef-4081-60fd-08d6e49b772d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 01:09:28.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1564
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDE4OjQxIC0wNjAwLCBBbGFuIFBvc3Qgd3JvdGU6DQo+IE9u
IEZyaSwgTWF5IDI0LCAyMDE5IGF0IDExOjMxOjU1QU0gLTA2MDAsIEFsYW4gUG9zdCB3cm90ZToN
Cj4gPiBPbiBUdWUsIE1heSAyMSwgMjAxOSBhdCAwMzo0NjowM1BNICswMDAwLCBUcm9uZCBNeWts
ZWJ1c3Qgd3JvdGU6DQo+ID4gPiBIYXZlIHlvdSB0cmllZCB1cGdyYWRpbmcgdG8gNC4xOS40ND8g
VGhlcmUgaXMgYSBmaXggdGhhdCB3ZW50IGluDQo+ID4gPiBub3QNCj4gPiA+IHRvbyBsb25nIGFn
byB0aGF0IGRlYWxzIHdpdGggYSByZXF1ZXN0IGxlYWsgdGhhdCBjYW4gY2F1c2Ugc3RhY2sNCj4g
PiA+IHRyYWNlcw0KPiA+ID4gbGlrZSB0aGUgYWJvdmUgdGhhdCB3YWl0IGZvcmV2ZXIuDQo+ID4g
PiANCj4gPiANCj4gPiBGb2xsb3dpbmcgdXAgb24gdGhpcy4gIEkgaGF2ZSBzZXQgYXNpZGUgYSBy
YWNrIG9mIG1hY2hpbmVzIGFuZCBwdXQNCj4gPiBMaW51eCA0LjE5LjQ0IG9uIHRoZW0uICBUaGV5
IHJhbiBqb2JzIG92ZXJuaWdodCBhbmQgd2lsbCBkbyB0aGUNCj4gPiBzYW1lIG92ZXIgdGhlIGxv
bmcgd2Vla2VuZCAoTWVtb3JpYWwgZGF5IGluIHRoZSBVUykuICBHaXZlbiB0aGUNCj4gPiBlcnJv
ciByYXRlIChib3RoIG92ZXIgdGltZSBhbmQgb3ZlciBzdWJtaXR0ZWQgam9icykgd2Ugc2VlIGFj
cm9zcw0KPiA+IHRoZSBjbHVzdGVyIHRoaXMgd2VsbCBiZSBlbm91Z2ggdGltZSB0byBkcmF3IGEg
Y29uY2x1c2lvbiBhcyB0bw0KPiA+IHdoZXRoZXIgNC4xOS40NCBleGhpYml0cyB0aGlzIGhhbmcu
DQo+ID4gDQo+IA0KPiBJbiB0aGUgc2l4IGRheXMgSSd2ZSBydW4gTGludXggNC4xOS40NCBvbiBh
IHNpbmdsZSByYWNrLCBJJ3ZlIHNlZW4NCj4gbm8gb2NjdXJyZW5jZXMgb2YgdGhpcyBoYW5nLiAg
R2l2ZW4gdGhlIGluY2lkZW50IHJhdGUgZm9yIHRoaXMNCj4gaXNzdWUgYWNyb3NzIHRoZSBjbHVz
dGVyIG92ZXIgdGhlIHNhbWUgcGVyaW9kIG9mIHRpbWUsIEkgd291bGQgaGF2ZQ0KPiBleHBlY3Rl
ZCB0byBzZWUgb25lIG9uIHR3byBpbmNpZGVudHMgb24gdGhlIHJhY2sgcnVubmluZyA0LjE5LjQ0
Lg0KPiANCj4gVGhpcyBpcyBwcm9taXNpbmctLUknbSBnb2luZyB0byBkZXBsb3kgNC4xOS40NCB0
byBhbm90aGVyIHJhY2sNCj4gYnkgdGhlIGVuZCBvZiB0aGUgZGF5IEZyaWRheSBNYXkgMzFzdCBh
bmQgaG9wZSBmb3IgbW9yZSBvZiB0aGUNCj4gc2FtZS4NCj4gDQo+IEkgd29uZGVyZWQgdXB0aHJl
YWQgd2hldGhlciB0aGUgZm9sbG93aW5nIGNvbW1pdHMgd2VyZSB3aGF0IHlvdQ0KPiBoYWQgaW4g
bWluZCB3aGVuIHlvdSBhc2tlZCBhYm91dCA0LjE5LjQ0Og0KPiANCj4gICAgIDYzYjBlZTEyNmY3
ZTogTkZTOiBGaXggYW4gSS9PIHJlcXVlc3QgbGVha2FnZSBpbg0KPiBuZnNfZG9fcmVjb2FsZXNj
ZQ0KPiAgICAgYmU3NGZkZGM5NzZlOiBORlM6IEZpeCBJL08gcmVxdWVzdCBsZWFrYWdlcw0KPiAN
Cj4gQ29uZmlybWluZyB0aGF0IGl0IGlzIHRoZXNlIHBhdGNoZXMgYW5kIG5vIG90aGVycyBoYXMg
YmVjb21lDQo+IHRvcGljYWwgZm9yIG1lOiBteSB1cHN0cmVhbSBpcyBub3cgcHJvdmlkaW5nIGEg
NC4xOS4zNyBidWlsZCwNCj4gYW5kIEkgbm90ZSB0aGVzZSB0d28gcGF0Y2hlcyBhcmUgaW5jbHVk
ZWQgc2luY2UgNC4xOS4zMSBhbmQgc28NCj4gYXJlIHByZXN1bWFibHkgaW4gbXkgbm93LWF2YWls
YWJsZSB1cHN0cmVhbSA0LjE5LjM3IGJ1aWxkLg0KPiANCj4gSWYgSSBjb3VsZCB0cm91YmxlIHlv
dSB0byBjb25maXJtIHdoZXRoZXIgb3Igbm90IHRoaXMgaXMgdGhlDQo+IGNvbXBsZXRlIHNldCBv
ZiBwYXRjaGVzIHlvdSBoYWQgaW4gbWluZCBmb3IgdGhlIDQuMTkgYnJhbmNoDQo+IGFmdGVyIDQu
MTkuMjggd2hlbiB5b3UgcmVjb21tZW5kZWQgSSB0cnkgNC4xOS40NCBJIHdvdWxkDQo+IGFwcHJl
Y2lhdGUgaXQuDQo+IA0KDQpZZXMsIHRob3NlIHR3byBwYXRjaGVzIGFyZSB0aGUgb25lcyBJIHdh
cyBzcGVjaWZpY2FsbHkgY29uc2lkZXJpbmcsDQpnaXZlbiB0aGUgcHJvYmxlbSB0aGF0IHlvdSBy
ZXBvcnRlZC4NCg0KQ2hlZXJzDQogIFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51
eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFt
bWVyc3BhY2UuY29tDQoNCg0K
