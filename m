Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849341B8128
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Apr 2020 22:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDXUvW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Apr 2020 16:51:22 -0400
Received: from mail-mw2nam10on2092.outbound.protection.outlook.com ([40.107.94.92]:4918
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbgDXUvW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 24 Apr 2020 16:51:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpMvfLSbFkDbkKg0LBQUv6lSzLGWu9nRlWRLGUrMPNCscnlWNg+8qQmgtXB+B/WEeUQYINwQ0y5dhXQ7EKsqV1l8S6BAgv3dKqxY3pwocK3lAIKtM1B4xofM24cap22saXynHretNuWulALJFePVP6CTOG0JNGpIstd4qeK617rgdkzuayZmYuAnNz9Fp76BxmhlUYukQfvwe/0AlNNEOQGsSK9FghZbKjbtbgP8tN6PqcubpLZt6rua99fe0DkUKWSRqqIJlmN5DU0d94nOAvv1UMSEQWFfC+xNYndJwyHVOQ968QqWM5cP2+Uql3ZQBwkdbTYhUTVkQTw0VOhUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4GLgIH/kgMGYHkXqe2dKag3EPa/LhXBVE1eSn2BhwI=;
 b=my1kEqVH9z2MglFE7F4QrEPBlhswzo+a9taQNZR9OmsG4xEhZ31x4ioo+6zMvSDCMbFuXtZ/w85t5aP6sVXB2F3FICcFtNjV42bSPDeqUXsjIDQAX5hT9f55W9Y8iuR9zhHxqV6STpSOTIcG4yk5LlRX2YdCAYNTf4z23JLlh4IdWxu5FOHSKt/SiiVWABO2AoBgmQ1KtO+ZGfhxVqx/3SZBZzFqA5PnCZrgUE0pf13qIOy22IW4oE5i3YP+70sk6AE37bI1FzC6nDhbJsIFKx9irGYPYQAo/JLDbn6CXyXJLOu66cdPGWGAgREmCXI4WADhLYbmRgXUEc0ESXcADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4GLgIH/kgMGYHkXqe2dKag3EPa/LhXBVE1eSn2BhwI=;
 b=AVq5kwBAeBTH6NHUqcuCcyBQFcGYv8zhW4+pT7NYwbEDD0RXDD82mxheW6jbZY5gAZa7eYuMqwdvenRW8Xmkoep56gxy5+VzvpkgWqhL9zBO4yoI1SYvGKnb+r13DcSm4ov05qQWdKoBAr5GcUNVdcQ3Gz30r/H7+zdhOqP1IOk=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3413.namprd13.prod.outlook.com (2603:10b6:610:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Fri, 24 Apr
 2020 20:51:18 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 20:51:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1: fix handling of backchannel binding in
 BIND_CONN_TO_SESSION
Thread-Topic: [PATCH 1/1] NFSv4.1: fix handling of backchannel binding in
 BIND_CONN_TO_SESSION
Thread-Index: AQHWGmvLCjJXQHIz9UuoWdwWye6TXKiIv1oA
Date:   Fri, 24 Apr 2020 20:51:17 +0000
Message-ID: <dc483bc0dea9eab6b3fab1568fd18f710c818b39.camel@hammerspace.com>
References: <20200424190856.30292-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200424190856.30292-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71ed4cc6-0288-4614-2420-08d7e8913c91
x-ms-traffictypediagnostic: CH2PR13MB3413:
x-microsoft-antispam-prvs: <CH2PR13MB34130C54DE7B98E7823060CBB8D00@CH2PR13MB3413.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(366004)(376002)(396003)(136003)(346002)(6512007)(6506007)(186003)(86362001)(110136005)(36756003)(71200400001)(2616005)(8936002)(91956017)(66556008)(66946007)(64756008)(66446008)(66476007)(4326008)(6486002)(8676002)(478600001)(316002)(26005)(5660300002)(76116006)(2906002)(81156014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IGsZ3Q7TtB5Zwq04w4PMbyGfIO17nTd5cvXzlPdLUDh3yw7uFFstbL7VNBiutJkFbPUXMrCGkEl8eIVzNEZ6lh49k+EuNf+cRb84tFm9i2umQhIdvV6S+PwHpONBDnf292e18HUvMwl7wz93SnZuGkfvH+v0HCu4iepxvHUrvzveJXNBSN6sTJwtgfX2YZh+8PGYcjDoN9brDaRPrUeYCuRTCNwPsn+OB6al9/4aBJUFDrj/l4FTKgIij4vqT0nK0spW2qEVIb1ViXnSTKVH0cUX7p9+9fk7iFmOo/SvX44M2fAhPqW3UoPtbdBV6/ub/DyWE21EW84RzjO8U1TcduOovPP1brULodYHIV2lQOzFzQY5ROcNEp/Y/GhdXUuofezwZcsM33SBUwupLtjkaLvH2YzJErhPLhyPk4hTSQcKe/Z3R5naiqDRskIQ4wNz
x-ms-exchange-antispam-messagedata: korytvmQoqtcUPVF2n5+szzLEkHHmEgu/gusR4R8dR8HQDCAMZ5Lz2CPA+gO2yhfLNr6oEnaBUKplDcX8wVPvqRp+tI6ZTVJoRqpSGULrpisDVdbJx9+5UVUG8p198SRWRR6f3KHQakCGsaH5X0a8SegV3Hqtf8qgphfUQKe3IJpSKvSjX2TFeY4djqKrrvlP29JZ4k5fTAYRgK63F3ngyLBKrmfSU5qPx6j++4PWqJ9mkMS/ZOFrAJwbsO0cbxqGSPhKmasyXE5egNBIxfOgA4QehgtPCaEq/SZ46lP/rWq66WFPNdK5Pz6zPC/9LkRw5Xz1vw6VhER4QEN2kQhW9ziiV6k/kiqEDE4pTwz0rVAjk7C9b7JLeS2UdvVWc3599Jbz8lFgCS6HViqU1wBTu2kx0iZ3SKldL4Jhtsj71E0VVfWmAlLgQaoyFJZzi5uFIM6WqDd79MHIsMamRQaDIlubmlcfzEk3HH7itC8nrIR+hD0yCK9/1lliMg8iEZB+U7UCL+Vh7wiSzDMovWCzDDuBM9RHSvRXghd3vzJStC9HxBkaPYgPWWPUMU8V3uKvYo+CZlOtb5AjBZvMA/WJN8HrvmxmrUT7PIDuBiDt8te+KYZD8Ab5fKAJsOyv4KTk1FDM9UzHwBJ105+aNgalRUrNHypeHZesv6IiTIsta0vgB+XKAmTCuPhg3dVq7Eg5dTsguCF4QdNxg2GpzzSOZF0zxYovRj4k/zCS8D8gPaflHJF5Pqe1CcG3YPZbKWCQ3tXODrpdNs9bC0MwWDw4MiNYn0FDRqY7fHYY7MNLpo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDD1B7474F83374A81E421C802D84886@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ed4cc6-0288-4614-2420-08d7e8913c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 20:51:17.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4W/obo1jpb7hdZ2NKuKVtaDGr8ZLd2RgHHF6u9UbHqq44c9uFvGAD+J//3h1HBiGMkhdiCN53FcQuHWENbF0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3413
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBGcmksIDIwMjAtMDQtMjQgYXQgMTU6MDggLTA0MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBDdXJyZW50bHksIGlmIHRoZSBjbGllbnQgc2VuZHMgQklORF9DT05O
X1RPX1NFU1NJT04gd2l0aA0KPiBORlM0X0NERkM0X0ZPUkVfT1JfQk9USCBidXQgb25seSBnZXRz
IE5GUzRfQ0RGUzRfRk9SRSBiYWNrIGl0IGlnbm9yZXMNCj4gdGhhdCBpdCB3YXNuJ3QgYWJsZSB0
byBlbmFibGUgYSBiYWNrY2hhbm5lbC4NCj4gDQo+IFRvIG1ha2Ugc3VyZSwgdGhlIGNsaWVudCBz
ZW5kcyBCSU5EX0NPTk5fVE9fU0VTU0lPTiBhcyB0aGUgZmlyc3QNCj4gb3BlcmF0aW9uIG9uIHRo
ZSBjb25uZWN0aW9ucyAoaWUuLCBubyBvdGhlciBzZXNzaW9uIGNvbXBvdW5kcyBoYXZlbid0DQo+
IGJlZW4gc2VudCBiZWZvcmUpLCBhbmQgaWYgdGhlIGNsaWVudCdzIHJlcXVlc3QgdG8gYmluZCB0
aGUNCj4gYmFja2NoYW5uZWwNCj4gaXMgbm90IHNhdGlzZmllZCwgdGhlbiByZXNldCB0aGUgY29u
bmVjdGlvbiBhbmQgcmV0cnkuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBT
aWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gLS0t
DQo+ICBmcy9uZnMvbmZzNHByb2MuYyAgICAgICAgICAgfCA2ICsrKysrKw0KPiAgaW5jbHVkZS9s
aW51eC9zdW5ycGMvY2xudC5oIHwgNSArKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMv
bmZzNHByb2MuYw0KPiBpbmRleCA1MTJhZmIxLi42OWE1NDg3IDEwMDY0NA0KPiAtLS0gYS9mcy9u
ZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBAQCAtNzg5MSw2ICs3
ODkxLDcgQEAgc3RhdGljIGludCBuZnM0X2NoZWNrX2NsX2V4Y2hhbmdlX2ZsYWdzKHUzMg0KPiBm
bGFncykNCj4gIG5mczRfYmluZF9vbmVfY29ubl90b19zZXNzaW9uX2RvbmUoc3RydWN0IHJwY190
YXNrICp0YXNrLCB2b2lkDQo+ICpjYWxsZGF0YSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbmZzNDFfYmlu
ZF9jb25uX3RvX3Nlc3Npb25fYXJncyAqYXJncyA9IHRhc2stDQo+ID50a19tc2cucnBjX2FyZ3A7
DQo+ICsJc3RydWN0IG5mczQxX2JpbmRfY29ubl90b19zZXNzaW9uX3JlcyAqcmVzID0gdGFzay0N
Cj4gPnRrX21zZy5ycGNfcmVzcDsNCj4gIAlzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwID0gYXJncy0+
Y2xpZW50Ow0KPiAgDQo+ICAJc3dpdGNoICh0YXNrLT50a19zdGF0dXMpIHsNCj4gQEAgLTc4OTks
NiArNzkwMCwxMSBAQCBzdGF0aWMgaW50IG5mczRfY2hlY2tfY2xfZXhjaGFuZ2VfZmxhZ3ModTMy
DQo+IGZsYWdzKQ0KPiAgCQluZnM0X3NjaGVkdWxlX3Nlc3Npb25fcmVjb3ZlcnkoY2xwLT5jbF9z
ZXNzaW9uLA0KPiAgCQkJCXRhc2stPnRrX3N0YXR1cyk7DQo+ICAJfQ0KPiArCWlmIChhcmdzLT5k
aXIgPT0gTkZTNF9DREZDNF9GT1JFX09SX0JPVEggJiYNCj4gKwkJCXJlcy0+ZGlyICE9IE5GUzRf
Q0RGUzRfQk9USCkgew0KPiArCQlycGNfdGFza19jbG9zZV9jb25uZWN0aW9uKHRhc2spOw0KPiAr
CQl0YXNrLT50a19zdGF0dXMgPSAtTkZTNEVSUl9ERUxBWTsNCg0KV2UgZG9uJ3QgaGF2ZSBhbnkg
ZXJyb3IgaGFuZGxpbmcgZm9yIE5GUzRFUlJfREVMQVkgaW4gdGhpcyBmdW5jdGlvbiwgc28NCmlm
IHlvdXIgaW50ZW50aW9uIGlzIHRvIHJlcGxheSB0aGUgUlBDIGNhbGwsIHRoZW4gbWF5YmUgeW91
IHdhbnQgdG8NCnJlcGxhY2UgdGhpcyBsaW5lIHdpdGggYSBjYWxsIHRvIHJwY19yZXN0YXJ0X2Nh
bGwoKT8NCg0KSG93ZXZlciBpdCB3b3VsZCBiZSBnb29kIHRvIGVuc3VyZSB0aGF0IHdlIG9ubHkg
ZG8gdGhpcyBvbmNlIG9yIHR3aWNlDQpzbyB0aGF0IHdlIGRvbid0IGxvb3AgZm9yZXZlci4gTWF5
YmUgYWxzbyBhZGQgYSB2YXJpYWJsZSB0byB0aGUgc3RydWN0DQpuZnM0MV9iaW5kX2Nvbm5fdG9f
c2Vzc2lvbl9hcmdzIHRoYXQgY2FuIHNldCB0aGUgbnVtYmVyIG9mIHJldHJpZXMNCnJlbWFpbmlu
Zz8NCg0KPiArCX0NCj4gIH0NCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBycGNfY2FsbF9v
cHMgbmZzNF9iaW5kX29uZV9jb25uX3RvX3Nlc3Npb25fb3BzID0NCj4gew0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9zdW5ycGMvY2xudC5oDQo+IGIvaW5jbHVkZS9saW51eC9zdW5ycGMv
Y2xudC5oDQo+IGluZGV4IGNhN2UxMDguLmNjMjBhMDggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvc3VucnBjL2NsbnQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3N1bnJwYy9jbG50LmgN
Cj4gQEAgLTIzNiw0ICsyMzYsOSBAQCBzdGF0aWMgaW5saW5lIGludCBycGNfcmVwbHlfZXhwZWN0
ZWQoc3RydWN0DQo+IHJwY190YXNrICp0YXNrKQ0KPiAgCQkodGFzay0+dGtfbXNnLnJwY19wcm9j
LT5wX2RlY29kZSAhPSBOVUxMKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGluZSB2b2lkIHJw
Y190YXNrX2Nsb3NlX2Nvbm5lY3Rpb24oc3RydWN0IHJwY190YXNrICp0YXNrKQ0KPiArew0KPiAr
CWlmICh0YXNrLT50a194cHJ0KQ0KPiArCQl4cHJ0X2ZvcmNlX2Rpc2Nvbm5lY3QodGFzay0+dGtf
eHBydCk7DQo+ICt9DQo+ICAjZW5kaWYgLyogX0xJTlVYX1NVTlJQQ19DTE5UX0ggKi8NCg0KVGhh
bmtzDQogIFRyb25kDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
