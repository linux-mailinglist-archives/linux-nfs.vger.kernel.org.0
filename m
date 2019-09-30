Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B37CC268E
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2019 22:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfI3UhI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Sep 2019 16:37:08 -0400
Received: from mail-eopbgr800107.outbound.protection.outlook.com ([40.107.80.107]:23364
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726576AbfI3UhH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Sep 2019 16:37:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWFIH4y7Cqkyl+X8cV1NJHzxozN/ltfpU+POhA2xTtS0Qp/7qWP4ZmEdkKMLB/V6ysgx1SzgCln6waGmeKvtR05J33LQ1+/yGXAAuzD1sJdsGsf1yeYiU6RNHdVLVzSusl+Yx51i/6ilbZ7srAcY85iuVIaHnUJSO5YIrbKMLbgHaogDFNzuCnQWm6HyDAyvirwhq3PWfnupqGfqPvlNImMTqZzo7WFqEb0KDEZe6DC8faF2dtiqzDfLGzu9Cro4ZXdBG7eaxY6RlkxhMApWrFaS/udOHDxZadTYDVYxaadhTKG4bEvXeanVJzpit/2oBvfjGoVWGPOBVqnlcdsEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sXJu5WT75ph2ATR9nAKtvThcBFxjsZzJELz7+qc6b0=;
 b=gRyxpmDgX6hlrz4YP1JWIlBdkxwh+lTopXlQ2SRy+3SLq0Lpew/tevxQOL5BNt6PUujw7iY76cknVM/3wxa7s7BDIBhYQByAfV0AvnUwsAKtgdjjGZmYCVPDXPXcnWHgBfezg6wcePtLC38PvrDq/QNL+zI6ZUX/uBzNAraBwOwWOjDFTUsE8PBEuDX3lezw1CpTAJiYbsCUj1HRj7/zq2BaLgy+T5rPncp307v2Dxps8nen1lFH0Z8SLccoTPgZh6kzQz1D+qhgJEHPreagS7szkqC3YEhOsJCAz9zzN2lBMlg/4GRRkZaSh+nwTxVvOpNcgDyHDk7mQk5jI4SyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sXJu5WT75ph2ATR9nAKtvThcBFxjsZzJELz7+qc6b0=;
 b=ek5K6wJ6uGyBIt8wpRNpNzF9GsTfvQGFdotMtmRUGZ75onaF41TS6H+IImPTyYh2F44LVg2gr/6fcmsNkm1WzxmOOk7G/87KpX3zWWAN8H2py5luCcIYzeFnEEVUwN0V9yQzWirpcZFzUB26xjEK+me5hbu6b6bDuL+38/qyNxQ=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1035.namprd13.prod.outlook.com (10.168.239.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.7; Mon, 30 Sep 2019 18:06:00 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::d1be:764d:9347:764e%10]) with mapi id 15.20.2305.017; Mon, 30 Sep
 2019 18:06:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "suyj.fnst@cn.fujitsu.com" <suyj.fnst@cn.fujitsu.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: Fix O_DIRECT read problem when another write is
 going on
Thread-Topic: [PATCH] NFS: Fix O_DIRECT read problem when another write is
 going on
Thread-Index: AQHVd29ku8nD71E+VU+c3kukzbSbNqdEhIwA
Date:   Mon, 30 Sep 2019 18:06:00 +0000
Message-ID: <d7fee2b94f4af266054c6e975cdfd4d9adbf841b.camel@hammerspace.com>
References: <1569834678-16117-1-git-send-email-suyj.fnst@cn.fujitsu.com>
In-Reply-To: <1569834678-16117-1-git-send-email-suyj.fnst@cn.fujitsu.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc868fbd-3967-4606-93f7-08d745d0d99e
X-MS-TrafficTypeDiagnostic: DM5PR13MB1035:|DM5PR13MB1035:|DM5PR13MB1035:|DM5PR13MB1035:|DM5PR13MB1035:|DM5PR13MB1035:|DM5PR13MB1035:
x-microsoft-antispam-prvs: <DM5PR13MB10353C0C227E0270995E610CB8820@DM5PR13MB1035.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39830400003)(366004)(346002)(376002)(189003)(199004)(64756008)(66476007)(316002)(66946007)(71190400001)(91956017)(486006)(8676002)(305945005)(14444005)(256004)(8936002)(76116006)(54906003)(81166006)(81156014)(102836004)(6246003)(5640700003)(6512007)(476003)(66556008)(66446008)(86362001)(7736002)(36756003)(71200400001)(6436002)(6916009)(4326008)(76176011)(118296001)(5660300002)(11346002)(2906002)(2501003)(6116002)(446003)(66066001)(2616005)(229853002)(6506007)(186003)(25786009)(99286004)(3846002)(26005)(6486002)(14454004)(478600001)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1035;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8HCzP/vug4UeVX5oyojimwMM6aLIqIPzwRgYVD3vMRzpGhizyUYBbVROIJB+wCJa0hYZRPAx2t2JYQPohPkFyv8vKl3zkcDlx1E1b87OcRLUXox2s2pNL9PKJZD4+rNuGV+d/gHjeApAZHyrOhiG34IDVfQi2jzvOs2qA7Vif0OfsQguuZlDXqCbhbFpCiNGIatYB7OpSuWbTYSbQLSF8bidOQVy4NLERTvzNwEaLYPlMXOWAOexJJpgHilDnZom8wG+6H9+AaeJk4maTbqPWTx/jbxD0jsAWhCmUQ/TCPrW1keDPO9mLk2dd7qaMCCirpfeKkhj/YDwPd/Ja0mwAjZnQAni+YwTeJgk/agWtljFaFWldIRy8ctMIWO2TJdhGPmflvo/lHBcIvylzdXEeC6DgYotgWhDvi0pRMMfhc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <234A4827A21D054D98DD20387A8E1B15@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fc868fbd-3967-4606-93f7-08d745d0d99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 18:06:00.1997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTjg3tyvGiPkUgSBV49V7MnaJohPoqaUvgf1Iq+12tb4ivBC2VcbDCaZBz8b/mkfqnSrUyYN5gW1+WfLymYPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1035
X-OriginatorOrg: hammerspace.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgU3UsDQoNCk9uIE1vbiwgMjAxOS0wOS0zMCBhdCAxNzoxMSArMDgwMCwgU3UgWWFuanVuIHdy
b3RlOg0KPiBJbiB4ZnN0ZXN0cyBnZW5lcmljLzQ2NSB0ZXN0cyBmYWlsZWQuIEJlY2F1c2UgT19E
SVJFQ1Qgci93IHVzZQ0KPiBhc3luYyBycGMgY2FsbHMsIHdoZW4gci93IHJwYyBjYWxscyBhcmUg
cnVubmluZyBjb25jdXJyZW50bHkgd2UNCj4gbWF5IHJlYWQgcGFydGlhbCBkYXRhIHdoaWNoIGlz
IHdyb25nLg0KPiANCj4gRm9yIGV4YW1wbGUgYXMgZm9sbG93cy4NCj4gIHVzZXIgYnVmZmVyDQo+
IC8tLS0tLS0tLVwNCj4gPiAgICB8WFhYWHwNCj4gIHJwYzAgcnBjMQ0KPiANCj4gV2hlbiBycGMw
IHJ1bnMgaXQgZW5jb3VudGVycyBlb2Ygc28gcmV0dXJuIDAsIHRoZW4gYW5vdGhlciB3cml0ZXMN
Cj4gc29tZXRoaW5nLiBXaGVuIHJwYzEgcnVucyBpdCByZXR1cm5zIHNvbWUgZGF0YS4gVGhlIHRv
dGFsIGRhdGENCj4gYnVmZmVyIGNvbnRhaW5zIHdyb25nIGRhdGEuDQo+IA0KPiBJbiB0aGlzIHBh
dGNoIHdlIGNoZWNrIGVvZiBtYXJrIGZvciBlYWNoIGRpcmVjdCByZXF1ZXN0LiBJZg0KPiBlbmNv
dW50ZXJzDQo+IGVvZiB0aGVuIHNldCBlb2YgbWFyayBpbiB0aGUgcmVxdWVzdCwgd2hlbiB3ZSBt
ZWV0IGl0IGFnYWluIHJlcG9ydA0KPiAtRUFHQUlOIGVycm9yLiBJbiBuZnNfZGlyZWN0X2NvbXBs
ZXRlIHdlIGNvbnZlcnQgLUVBR0FJTiBhcyBpZiByZWFkDQo+IG5vdGhpbmcuIFdoZW4gdGhlIHJl
YWRlciBpc3N1ZSBhbm90aGVyIHJlYWQgaXQgd2lsbCByZWFkIG9rLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU3UgWWFuanVuIDxzdXlqLmZuc3RAY24uZnVqaXRzdS5jb20+DQo+IC0tLQ0KPiAgZnMv
bmZzL2RpcmVjdC5jIHwgMTQgKysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL2Rp
cmVjdC5jIGIvZnMvbmZzL2RpcmVjdC5jDQo+IGluZGV4IDIyMmQ3MTEuLjdmNzM3YTMgMTAwNjQ0
DQo+IC0tLSBhL2ZzL25mcy9kaXJlY3QuYw0KPiArKysgYi9mcy9uZnMvZGlyZWN0LmMNCj4gQEAg
LTkzLDYgKzkzLDcgQEAgc3RydWN0IG5mc19kaXJlY3RfcmVxIHsNCj4gIAkJCQlieXRlc19sZWZ0
LAkvKiBieXRlcyBsZWZ0IHRvIGJlDQo+IHNlbnQgKi8NCj4gIAkJCQllcnJvcjsJCS8qIGFueSBy
ZXBvcnRlZCBlcnJvcg0KPiAqLw0KPiAgCXN0cnVjdCBjb21wbGV0aW9uCWNvbXBsZXRpb247CS8q
IHdhaXQgZm9yIGkvbyBjb21wbGV0aW9uICovDQo+ICsJaW50CQkJZW9mOwkJLyogZW9mIG1hcmsg
aW4gdGhlDQo+IHJlcSAqLw0KPiAgDQo+ICAJLyogY29tbWl0IHN0YXRlICovDQo+ICAJc3RydWN0
IG5mc19tZHNfY29tbWl0X2luZm8gbWRzX2NpbmZvOwkvKiBTdG9yYWdlIGZvciBjaW5mbw0KPiAq
Lw0KPiBAQCAtMzgwLDYgKzM4MSwxMiBAQCBzdGF0aWMgdm9pZCBuZnNfZGlyZWN0X2NvbXBsZXRl
KHN0cnVjdA0KPiBuZnNfZGlyZWN0X3JlcSAqZHJlcSkNCj4gIHsNCj4gIAlzdHJ1Y3QgaW5vZGUg
Kmlub2RlID0gZHJlcS0+aW5vZGU7DQo+ICANCj4gKwkvKiByZWFkIHBhcnRpYWwgZGF0YSBqdXN0
IGFzIHJlYWQgbm90aGluZyAqLw0KPiArCWlmIChkcmVxLT5lcnJvciA9PSAtRUFHQUlOKSB7DQo+
ICsJCWRyZXEtPmNvdW50ID0gMDsNCj4gKwkJZHJlcS0+ZXJyb3IgPSAwOw0KPiArCX0NCj4gKw0K
PiAgCWlub2RlX2Rpb19lbmQoaW5vZGUpOw0KPiAgDQo+ICAJaWYgKGRyZXEtPmlvY2IpIHsNCj4g
QEAgLTQxMyw4ICs0MjAsMTMgQEAgc3RhdGljIHZvaWQgbmZzX2RpcmVjdF9yZWFkX2NvbXBsZXRp
b24oc3RydWN0DQo+IG5mc19wZ2lvX2hlYWRlciAqaGRyKQ0KPiAgCWlmIChoZHItPmdvb2RfYnl0
ZXMgIT0gMCkNCj4gIAkJbmZzX2RpcmVjdF9nb29kX2J5dGVzKGRyZXEsIGhkcik7DQo+ICANCj4g
LQlpZiAodGVzdF9iaXQoTkZTX0lPSERSX0VPRiwgJmhkci0+ZmxhZ3MpKQ0KPiArCWlmIChkcmVx
LT5lb2YpDQo+ICsJCWRyZXEtPmVycm9yID0gLUVBR0FJTjsNCj4gKw0KPiArCWlmICh0ZXN0X2Jp
dChORlNfSU9IRFJfRU9GLCAmaGRyLT5mbGFncykpIHsNCj4gIAkJZHJlcS0+ZXJyb3IgPSAwOw0K
PiArCQlkcmVxLT5lb2YgPSAxOw0KPiArCX0NCj4gIA0KPiAgCXNwaW5fdW5sb2NrKCZkcmVxLT5s
b2NrKTsNCj4gIA0KDQpUaGFua3MgZm9yIGxvb2tpbmcgaW50byB0aGlzIGlzc3VlLiBJIGFncmVl
IHdpdGggeW91ciBhbmFseXNpcyBvZiB3aGF0DQppcyBnb2luZyB3cm9uZyBpbiBnZW5lcmljLzQ2
NS4NCg0KSG93ZXZlciwgSSB0aGluayB0aGUgcHJvYmxlbSBpcyBncmVhdGVyIHRoYW4ganVzdCBF
T0YuIEkgdGhpbmsgd2UgYWxzbw0KbmVlZCB0byBsb29rIGF0IHRoZSBnZW5lcmljIGVycm9yIGhh
bmRsaW5nLCBhbmQgZW5zdXJlIHRoYXQgaXQgaGFuZGxlcw0KYSB0cnVuY2F0ZWQgUlBDIGNhbGwg
aW4gdGhlIG1pZGRsZSBvZiBhIHNlcmllcyBvZiBjYWxscyBjb3JyZWN0bHkuDQoNClBsZWFzZSBz
ZWUgdGhlIHR3byBwYXRjaGVzIEkgc2VudCB5b3UganVzdCBub3cgYW5kIGNoZWNrIGlmIHRoZXkg
Zml4DQp0aGUgcHJvYmxlbSBmb3IgeW91Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
