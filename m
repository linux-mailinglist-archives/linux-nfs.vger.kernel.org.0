Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E01FED8189
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 23:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfJOVQv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 17:16:51 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:21071
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726583AbfJOVQv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Oct 2019 17:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie3q/o8tVXUTivZUX3Osjh6I13X2lK1xhxUwzabeN8kX9CIxf8dhqK1QZcfsEj+Otk5IllsLmgA0Xp6WnDbiDhTEFeyRfZVyUftwW7LASal9edv6tHWfR2qp4IslZyQd7Syv1OPswH4O5OXB73KBQU+Hc3pNqi4eNnITrO6s0+9LlJk8lDuaGA/5xj+nD13za0ndoFQ34sicxG34WXQCUYudN7dC9EZvpMQz2uY9Yf1atUrExtnVJhhvvHZK+oAvUtBPFCGnWOggyY1m67Mk36qXU/H6Bme2DAVoXkukOxgOZy35jNsRSvySuLFV2GLv5gyVPNJNzuq5Sqwocxg8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+w6NpJqFhb8iKfx3XBiXqEcANGHJza+Q5drLTnxtmM=;
 b=TmXiutBiFzeAzOWmWuVgA49bRQRm4XXhiziI2ZjgOIPn4M4Z1uPLDR0RgURDy/SagBJWnKTbsSQljmyyoMfxc6yMIJ641WxKvDfsUqxdKB/tjVNy+pb+6/+xErKcbCkmmzgAS5hrNrHHU9RVjqlUC+Evi1ETy6hoJ5A5mCcNznxKUceIrvNKYRsow8gVRPhe505JlBpOABEGvsvtxj4EhMKako3r7nnOdxFRYMX+RTmEuWrqPNxbuLj7TD6BjknwyhzXJHWAYDFnyIIcskM4b7UNLiFN70jxZAmXiioAy27y6cCzRvk6A5utB4tINR1Fx1nKQ5V/iXAUkXGyEhZIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+w6NpJqFhb8iKfx3XBiXqEcANGHJza+Q5drLTnxtmM=;
 b=K3r5kDILbdFv+jbGrK3hXWiGU0otVLlpvDNAIQ3QBuS8DkTO16BuDQdEp5NyqpIvKua5kxElxm6HaBO6iShjkqD8gvW4UDHdU2tjoCprmojYAe2umwEXJapoBwsuOfnEEos0pXspldxq92DMN6uGLJPv5n5I699IG1RU5w3pxEc=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1801.namprd13.prod.outlook.com (10.171.156.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14; Tue, 15 Oct 2019 21:16:08 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e%10]) with mapi id 15.20.2347.023; Tue, 15 Oct
 2019 21:16:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: backchannel RPC request must reference XPRT
Thread-Topic: [PATCH] SUNRPC: backchannel RPC request must reference XPRT
Thread-Index: AQHVgug6tzsXLr0u4UmF6rOpq3JA9adcNbGA
Date:   Tue, 15 Oct 2019 21:16:07 +0000
Message-ID: <711ebfa5340c6e29ff640e855db5ad8e41a09a60.camel@hammerspace.com>
References: <87tv8iqz3b.fsf@notabene.neil.brown.name>
         <20191011165603.GD19318@fieldses.org>
         <87imoqrjb8.fsf@notabene.neil.brown.name>
In-Reply-To: <87imoqrjb8.fsf@notabene.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [66.187.232.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ec691df-1272-4597-2edc-08d751b4e57d
x-ms-traffictypediagnostic: DM5PR13MB1801:
x-microsoft-antispam-prvs: <DM5PR13MB1801CCE38EC62CA30F567763B8930@DM5PR13MB1801.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39840400004)(346002)(376002)(136003)(189003)(199004)(66446008)(91956017)(66946007)(66476007)(76116006)(66556008)(64756008)(14444005)(256004)(8936002)(14454004)(86362001)(2201001)(4326008)(118296001)(81156014)(8676002)(81166006)(2501003)(71190400001)(71200400001)(26005)(229853002)(6246003)(36756003)(66066001)(76176011)(446003)(6436002)(11346002)(2616005)(486006)(476003)(6506007)(6486002)(2906002)(4001150100001)(25786009)(99286004)(7736002)(305945005)(6116002)(478600001)(186003)(6512007)(110136005)(316002)(3846002)(5660300002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1801;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oz6maFayPBYvO1wDiWLLDNU2FQnn9srCjATO2wWBkrmbCUaKFUmwPclykLOg47NeSiJH8mrWdtern3PxvYpKzk+0oVmYYWtny/fxd7Sf4XP0fO6s75o/2BmA1B3unZYpzIlIEy9edeBvq/cvf9K+CaN0S6jZHD7HVoW06DpgfSP5I9S7u4QLtiv77V62W8eJGI9c4elM0lMtpJQ0aRk+2YEY+/wTJcHnGUGqLyp2hxSEGVuHVuds4c7PswiiwG4D5M1dn+qNy4MdRkcq5jrD8/aS32dLqa/Rn9lWOUbXVhE6VFSOn7i1m1yBWiffGiQ4ye5mmtNGkNUzDCoBjwdnpFBNlTsZ73+NF6YDvyWP7/XNXuwNp2MxNjQ24FiK0/Usvptvi3kC22UOahLQ7DWHjplTjsX2+2sHANvUscnYnxY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A50A51A8D64F1C49878B25DDA9B38B11@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec691df-1272-4597-2edc-08d751b4e57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 21:16:08.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghZuyeFna9ReoXFKMCYMswZt7TUrANfr3qk+H6eKpW7IzC/3BaPSR7ACTxYDdhrmQdyiJjw4sEI2Jt/ZVqYB0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1801
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTmVpbCwNCg0KT24gVHVlLCAyMDE5LTEwLTE1IGF0IDEwOjM2ICsxMTAwLCBOZWlsQnJvd24g
d3JvdGU6DQo+IFRoZSBiYWNrY2hhbm5lbCBSUEMgcmVxdWVzdHMgLSB0aGF0IGFyZSBxdWV1ZWQg
d2FpdGluZw0KPiBmb3IgdGhlIHJlcGx5IHRvIGJlIHNlbnQgYnkgdGhlICJORlN2NCBjYWxsYmFj
ayIgdGhyZWFkIC0NCj4gaGF2ZSBhIHBvaW50ZXIgdG8gdGhlIHhwcnQsIGJ1dCBpdCBpcyBub3Qg
cmVmZXJlbmNlIGNvdW50ZWQuDQo+IEl0IGlzIHBvc3NpYmxlIGZvciB0aGUgeHBydCB0byBiZSBm
cmVlZCB3aGlsZSB0aGVyZSBhcmUNCj4gc3RpbGwgcXVldWVkIHJlcXVlc3RzLg0KPiANCj4gSSB0
aGluayB0aGlzIGhhcyBiZWVuIGEgcHJvYmxlbSBzaW5jZQ0KPiBDb21taXQgZmI3YTBiOWFkZGJk
ICgibmZzNDE6IE5ldyBiYWNrY2hhbm5lbCBoZWxwZXIgcm91dGluZXMiKQ0KPiB3aGVuIHRoZSBj
b2RlIHdhcyBpbnRyb2R1Y2VkLCBidXQgSSBzdXNwZWN0IGl0IGJlY2FtZSBtb3JlIG9mDQo+IGEg
cHJvYmxlbSBhZnRlcg0KPiBDb21taXQgODBiMTRkNWU2MWNhICgiU1VOUlBDOiBBZGQgYSBzdHJ1
Y3R1cmUgdG8gdHJhY2sgbXVsdGlwbGUNCj4gdHJhbnNwb3J0cyIpDQo+IChvciB0aGVyZSBhYm91
dHMpLg0KPiBCZWZvcmUgdGhpcyBzZWNvbmQgcGF0Y2gsIHRoZSBuZnMgY2xpZW50IHdvdWxkIGhv
bGQgYSByZWZlcmVuY2UgdG8NCj4gdGhlIHhwcnQgdG8ga2VlcCBpdCBhbGl2ZS4gIEFmdGVyIG11
bHRpcGF0aCB3YXMgaW50cm9kdWNlZCwNCj4gYSBjbGllbnQgaG9sZHMgYSByZWZlcmVuY2UgdG8g
YSBzd3RpY2gsIGFuZCB0aGUgc3dpdGNoIGNhbiBoYXZlDQo+IG11bHRpcGxlDQo+IHhwcnRzIHdo
aWNoIGNhbiBiZSBhZGRlZCBhbmQgcmVtb3ZlZC4NCj4gDQo+IEknbSBub3Qgc3VyZSBvZiBhbGwg
dGhlIGNhdXNhbCBpc3N1ZXMsIGJ1dCB0aGlzIHBhdGNoIGhhcw0KPiBmaXhlZCBhIGN1c3RvbWVy
IHByb2JsZW0gd2VyZSBhbiBORlN2NC4xIGNsaWVudCB3b3VsZCBydW4gb3V0DQo+IG9mIG1lbW9y
eSB3aXRoIHRlbnMgb2YgdGhvdXNhbmRzIG9mIGJhY2tjaGFubmVsIHJwYyByZXF1ZXN0cw0KPiBx
dWV1ZWQgZm9yIGFuIHhwcnQgdGhhdCBoYWQgYmVlbiBmcmVlZC4gIFRoaXMgd2FzIGEgNjRLLXBh
Z2UNCj4gbWFjaGluZSBzbyBlYWNoIHJwY19ycXN0IGNvbnN1bWVkIG1vcmUgdGhhbiAxMjhLIG9m
IG1lbW9yeS4NCj4gDQo+IEZpeGVzOiA4MGIxNGQ1ZTYxY2EgKCJTVU5SUEM6IEFkZCBhIHN0cnVj
dHVyZSB0byB0cmFjayBtdWx0aXBsZQ0KPiB0cmFuc3BvcnRzIikNCj4gY2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcgKHY0LjYpDQo+IFNpZ25lZC1vZmYtYnk6IE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4NCj4gLS0tDQo+ICBuZXQvc3VucnBjL2JhY2tjaGFubmVsX3Jxc3QuYyB8IDMgKystDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy9iYWNrY2hhbm5lbF9ycXN0LmMNCj4gYi9uZXQvc3VucnBj
L2JhY2tjaGFubmVsX3Jxc3QuYw0KPiBpbmRleCAzMzllOGMwNzdjMmQuLmM5NWNhMzk2ODhiNiAx
MDA2NDQNCj4gLS0tIGEvbmV0L3N1bnJwYy9iYWNrY2hhbm5lbF9ycXN0LmMNCj4gKysrIGIvbmV0
L3N1bnJwYy9iYWNrY2hhbm5lbF9ycXN0LmMNCj4gQEAgLTYxLDYgKzYxLDcgQEAgc3RhdGljIHZv
aWQgeHBydF9mcmVlX2FsbG9jYXRpb24oc3RydWN0IHJwY19ycXN0DQo+ICpyZXEpDQo+ICAJZnJl
ZV9wYWdlKCh1bnNpZ25lZCBsb25nKXhidWZwLT5oZWFkWzBdLmlvdl9iYXNlKTsNCj4gIAl4YnVm
cCA9ICZyZXEtPnJxX3NuZF9idWY7DQo+ICAJZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXhidWZw
LT5oZWFkWzBdLmlvdl9iYXNlKTsNCj4gKwl4cHJ0X3B1dChyZXEtPnJxX3hwcnQpOw0KPiAgCWtm
cmVlKHJlcSk7DQo+ICB9DQoNCldvdWxkIGl0IHBlcmhhcHMgbWFrZSBiZXR0ZXIgc2Vuc2UgdG8g
bW92ZSB0aGUgeHBydF9nZXQoKSB0bw0KeHBydF9sb29rdXBfYmNfcmVxdWVzdCgpIGFuZCB0byBy
ZWxlYXNlIGl0IGluIHhwcnRfZnJlZV9iY19ycXN0KCk/IA0KDQpPdGhlcndpc2UgYXMgZmFyIGFz
IEkgY2FuIHRlbGwsIHdlIHdpbGwgaGF2ZSBmcmVlZCBzbG90cyBvbiB0aGUgeHBydC0NCj5iY19w
YV9saXN0IHRoYXQgaG9sZCBhIHJlZmVyZW5jZSB0byB0aGUgdHJhbnNwb3J0IGl0c2VsZiwgbWVh
bmluZyB0aGF0DQp0aGUgbGF0dGVyIG5ldmVyIGdldHMgcmVsZWFzZWQuDQoNCj4gIA0KPiBAQCAt
ODUsNyArODYsNyBAQCBzdHJ1Y3QgcnBjX3Jxc3QgKnhwcnRfYWxsb2NfYmNfcmVxKHN0cnVjdCBy
cGNfeHBydA0KPiAqeHBydCwgZ2ZwX3QgZ2ZwX2ZsYWdzKQ0KPiAgCWlmIChyZXEgPT0gTlVMTCkN
Cj4gIAkJcmV0dXJuIE5VTEw7DQo+ICANCj4gLQlyZXEtPnJxX3hwcnQgPSB4cHJ0Ow0KPiArCXJl
cS0+cnFfeHBydCA9IHhwcnRfZ2V0KHhwcnQpOw0KPiAgCUlOSVRfTElTVF9IRUFEKCZyZXEtPnJx
X2JjX2xpc3QpOw0KPiAgDQo+ICAJLyogUHJlYWxsb2NhdGUgb25lIFhEUiByZWNlaXZlIGJ1ZmZl
ciAqLw0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
