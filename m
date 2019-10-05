Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D6FCCA83
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2019 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJEOfy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Oct 2019 10:35:54 -0400
Received: from mail-eopbgr730094.outbound.protection.outlook.com ([40.107.73.94]:31825
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfJEOfy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 5 Oct 2019 10:35:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brBPZJRl58H37dTFOLsH29A+pFK/sAuPXuwe1N86H88X7iTunvqDsIYjgF/zY0QyRUARtpfZ9vP4upu6TqzCrwDVnYW5J1QQTejS8gcryPvRdrcpXbOh6WyttBY4fNXwDY6eyFAwsFs+YOVeLdjTMMaLTKvBR3MGf9G3w365uqrG9C0FnhpOvI5tbFkA3Gn/Qy2Ois0AaQU9XLOdsyQck4/Yjtj9tSE3t56qnP1nmmtGZ0avK2GUKy1vy3RwRMJ7Gaz2dOxqcvh/N5CWEjIdsvzRIqORa/WILURRT6pFneGGCSmqief+PSWNNazrtV8BBdd8sfjxhOOEJXa3LFBHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmSs4SV0cUGTEsmCsNibdDC+JYckwEJV/2J6amd9w0Y=;
 b=IqukfxerdLGhMeFtnBCU9kcMtLmlu+hsxveEXFqyndPgDw7d0yM6EceGSFv9S68O7m2KWdgaCN3EFLKTi/Ay7HLa8QJ5Xtv88a5xDtDIdyIHLpOPZC6lWLI3lck2/bxbzbdxBhYr0wibyA/2RqXO25/hbI2dUaK6c7dFPgCWdwmlO4VwR4tZo8+b1f8LA4YWcdlRUMCDzrKN/KKlSFjqVNCucy2ObAOyqoUcwszdKiaFiSbynO/gQP3jymqqoRD+1tIPeEXkHQDwwQOH5uuhAr10F9Z7tFSxOnC+8Mu36KMR3yX0jdpBd3ulhzzsPp5saGkuEXAEJtoxIa9OzLk/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmSs4SV0cUGTEsmCsNibdDC+JYckwEJV/2J6amd9w0Y=;
 b=WliXnEZoCwg2cTfm/kBZjM6DRBW+jDMSV7bKk+yebz0djH6vo8//uGHEV7jEXt0zTXBlgJAFXlHQl+TNOR7XuOwNcshH2G44JP+AQBNK964MMEFxxug3lnVamYfFn811MZ9puZcmjiHQUnwoD64MByLtr9FLUpJL+XYJz1IOvTY=
Received: from CY4PR13MB1847.namprd13.prod.outlook.com (10.171.165.14) by
 CY4PR13MB1655.namprd13.prod.outlook.com (10.171.164.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.21; Sat, 5 Oct 2019 14:35:50 +0000
Received: from CY4PR13MB1847.namprd13.prod.outlook.com
 ([fe80::c922:bc8:f4c3:cd1c]) by CY4PR13MB1847.namprd13.prod.outlook.com
 ([fe80::c922:bc8:f4c3:cd1c%5]) with mapi id 15.20.2347.011; Sat, 5 Oct 2019
 14:35:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "zhangxiaoxu5@huawei.com" <zhangxiaoxu5@huawei.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
Thread-Topic: [PATCH] nfs: Fix nfsi->nrequests count error on
 nfs_inode_remove_request
Thread-Index: AQHVdDLYBQhYO0+XeUeeglb5KXlRoKdLVoQAgADNdgCAAAf7AA==
Date:   Sat, 5 Oct 2019 14:35:50 +0000
Message-ID: <cb955e718bd3c62f9c23661e95db77efa65d7177.camel@hammerspace.com>
References: <1569479378-128669-1-git-send-email-zhangxiaoxu5@huawei.com>
         <08ce0101-e8df-509a-f3e5-07063aa5492e@huawei.com>
         <5c50a4be3562877a5d96523e943b9976a3792e23.camel@hammerspace.com>
In-Reply-To: <5c50a4be3562877a5d96523e943b9976a3792e23.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c84c387b-50e8-4940-bf2e-08d749a1519e
x-ms-traffictypediagnostic: CY4PR13MB1655:
x-microsoft-antispam-prvs: <CY4PR13MB1655AE9BF8A3D89E440AD9BDB8990@CY4PR13MB1655.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0181F4652A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(6436002)(2201001)(26005)(486006)(45080400002)(53546011)(6506007)(102836004)(76176011)(446003)(11346002)(99286004)(186003)(25786009)(2616005)(478600001)(6246003)(229853002)(14454004)(6486002)(6512007)(66066001)(118296001)(86362001)(14444005)(256004)(110136005)(316002)(2501003)(3846002)(476003)(305945005)(8936002)(76116006)(66946007)(66476007)(64756008)(6116002)(66556008)(66446008)(91956017)(8676002)(81156014)(81166006)(71190400001)(2906002)(7736002)(71200400001)(36756003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR13MB1655;H:CY4PR13MB1847.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /q3GFM33b9XURdqTxF4EZyNzq+xb1xMUsrTxm2oTjNTrXopBL9r4J8ddv4M3ymZSqJhVWB9Q9IGqBEYyqWGNx50XDKXwOoNQg1+u1Elks7Xt5/qvL04stGmDVLIa5ox1G09jkR9SaugKDs7JseGy8husaoHbCN5osfPdUyLViRmF7KCmzdIAIOf4UalfQpdQw+eqZBpp8KiVJqkV0zuo9Fcav3DpQMa4CKY7rF5hK9hdH/RvUMCKDNvtchMDGfCzM7cgVhUsX2RXP2eU5d465IsgloeJ4SfvGRFlJUC4BAqG6WaSPb4iuHIhwDAtcvOZ1RBebyk08uHPv37vw5qX0xUuBXXOJSxpvtmYk9VqltWioxOr11SpU19CanYcmNBzWfQvb7kgExJJpoySiBTPCe74HS1H6V1s2xT7Il4zoXY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8536AB22B9FA1B44A3ABEBB9F5FAE11B@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84c387b-50e8-4940-bf2e-08d749a1519e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2019 14:35:50.1845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zW3S1yjj9VjGMgVskVj7M0ht0BLiwxBJApRBgzWQ2SQU8NJ7HEiFYohBiLl7McWAjrolZ1rxdDu/kb0R00o96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB1655
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gU2F0LCAyMDE5LTEwLTA1IGF0IDE0OjA3ICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IE9uIFNhdCwgMjAxOS0xMC0wNSBhdCAwOTo1MSArMDgwMCwgemhhbmd4aWFveHUgKEEpIHdy
b3RlOg0KPiA+IHBpbmcuDQo+ID4gDQo+ID4gT24gMjAxOS85LzI2IDE0OjI5LCBaaGFuZ1hpYW94
dSB3cm90ZToNCj4gPiA+IFdoZW4geGZzdGVzdHMgdGVzdGluZywgdGhlcmUgYXJlIHNvbWUgV0FS
TklORyBhcyBiZWxvdzoNCj4gPiA+IA0KPiA+ID4gV0FSTklORzogQ1BVOiAwIFBJRDogNjIzNSBh
dCBmcy9uZnMvaW5vZGUuYzoxMjINCj4gPiA+IG5mc19jbGVhcl9pbm9kZSsweDljLzB4ZDgNCj4g
PiA+IE1vZHVsZXMgbGlua2VkIGluOg0KPiA+ID4gQ1BVOiAwIFBJRDogNjIzNSBDb21tOiB1bW91
bnQubmZzDQo+ID4gPiBIYXJkd2FyZSBuYW1lOiBsaW51eCxkdW1teS12aXJ0IChEVCkNCj4gPiA+
IHBzdGF0ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8pDQo+ID4gPiBwYyA6IG5mc19j
bGVhcl9pbm9kZSsweDljLzB4ZDgNCj4gPiA+IGxyIDogbmZzX2V2aWN0X2lub2RlKzB4NjAvMHg3
OA0KPiA+ID4gc3AgOiBmZmZmZmMwMDBmNjhmYzAwDQo+ID4gPiB4Mjk6IGZmZmZmYzAwMGY2OGZj
MDAgeDI4OiBmZmZmZmUwMGM1MzE1NWMwDQo+ID4gPiB4Mjc6IGZmZmZmZTAwYzUzMTUwMDAgeDI2
OiBmZmZmZmMwMDA5YTYzNzQ4DQo+ID4gPiB4MjU6IGZmZmZmYzAwMGY2OGZkMTggeDI0OiBmZmZm
ZmMwMDBiZmFhZjQwDQo+ID4gPiB4MjM6IGZmZmZmYzAwMDkzNmQzYzAgeDIyOiBmZmZmZmUwMGM0
ZmY1ZTIwDQo+ID4gPiB4MjE6IGZmZmZmYzAwMGJmYWFmNDAgeDIwOiBmZmZmZmUwMGM0ZmY1ZDEw
DQo+ID4gPiB4MTk6IGZmZmZmYzAwMGMwNTYwMDAgeDE4OiAwMDAwMDAwMDAwMDAwMDNjDQo+ID4g
PiB4MTc6IDAwMDAwMDAwMDAwMDAwMDAgeDE2OiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiB4MTU6
IDAwMDAwMDAwMDAwMDAwNDAgeDE0OiAwMDAwMDAwMDAwMDAwMjI4DQo+ID4gPiB4MTM6IGZmZmZm
YzAwMGMzYTIwMDAgeDEyOiAwMDAwMDAwMDAwMDAwMDQ1DQo+ID4gPiB4MTE6IDAwMDAwMDAwMDAw
MDAwMDAgeDEwOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiB4OSA6IDAwMDAwMDAwMDAwMDAwMDAg
eDggOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiB4NyA6IDAwMDAwMDAwMDAwMDAwMDAgeDYgOiBm
ZmZmZmMwMDA4NGIwMjdjDQo+ID4gPiB4NSA6IGZmZmZmYzAwMDlhNjQwMDAgeDQgOiBmZmZmZmUw
MGMwZTc3NDAwDQo+ID4gPiB4MyA6IGZmZmZmYzAwMGMwNTYzYTggeDIgOiBmZmZmZmZmZmZmZmZm
ZmZiDQo+ID4gPiB4MSA6IDAwMDAwMDAwMDAwMDc2NGUgeDAgOiAwMDAwMDAwMDAwMDAwMDAxDQo+
ID4gPiBDYWxsIHRyYWNlOg0KPiA+ID4gICBuZnNfY2xlYXJfaW5vZGUrMHg5Yy8weGQ4DQo+ID4g
PiAgIG5mc19ldmljdF9pbm9kZSsweDYwLzB4NzgNCj4gPiA+ICAgZXZpY3QrMHgxMDgvMHgzODAN
Cj4gPiA+ICAgZGlzcG9zZV9saXN0KzB4NzAvMHhhMA0KPiA+ID4gICBldmljdF9pbm9kZXMrMHgx
OTQvMHgyMTANCj4gPiA+ICAgZ2VuZXJpY19zaHV0ZG93bl9zdXBlcisweGIwLzB4MjIwDQo+ID4g
PiAgIG5mc19raWxsX3N1cGVyKzB4NDAvMHg4OA0KPiA+ID4gICBkZWFjdGl2YXRlX2xvY2tlZF9z
dXBlcisweGI0LzB4MTIwDQo+ID4gPiAgIGRlYWN0aXZhdGVfc3VwZXIrMHgxNDQvMHgxNjANCj4g
PiA+ICAgY2xlYW51cF9tbnQrMHg5OC8weDE0OA0KPiA+ID4gICBfX2NsZWFudXBfbW50KzB4Mzgv
MHg1MA0KPiA+ID4gICB0YXNrX3dvcmtfcnVuKzB4MTE0LzB4MTYwDQo+ID4gPiAgIGRvX25vdGlm
eV9yZXN1bWUrMHgyZjgvMHgzMDgNCj4gPiA+ICAgd29ya19wZW5kaW5nKzB4OC8weDE0DQo+ID4g
PiANCj4gPiA+IFRoZSBucmVxdWVzdCBzaG91bGQgYmUgaW5jcmVhc2VkL2RlY3JlYXNlZCBvbmx5
IGlmIFBHX0lOT0RFX1JFRg0KPiA+ID4gZmxhZw0KPiA+ID4gd2FzIHNldHRlZC4NCj4gPiA+IA0K
PiA+ID4gQnV0IGluIHRoZSBuZnNfaW5vZGVfcmVtb3ZlX3JlcXVlc3QgZnVuY3Rpb24sIGl0IG1h
eWJlIGRlY3JlYXNlDQo+ID4gPiB3aGVuDQo+ID4gPiBubyBQR19JTk9ERV9SRUYgZmxhZywgdGhp
cyBtYXliZSBsZWFkIG5yZXF1ZXN0cyBjb3VudCBlcnJvci4NCj4gPiA+IA0KPiA+ID4gUmVwb3J0
ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogWmhhbmdYaWFveHUgPHpoYW5neGlhb3h1NUBodWF3ZWkuY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiAgIGZzL25mcy93cml0ZS5jIHwgNSArKystLQ0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZnMvbmZzL3dyaXRlLmMgYi9mcy9uZnMvd3JpdGUuYw0KPiA+ID4gaW5kZXggODVjYTQ5NS4uNTJj
YWI2NSAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL25mcy93cml0ZS5jDQo+ID4gPiArKysgYi9mcy9u
ZnMvd3JpdGUuYw0KPiA+ID4gQEAgLTc4Niw3ICs3ODYsNiBAQCBzdGF0aWMgdm9pZCBuZnNfaW5v
ZGVfcmVtb3ZlX3JlcXVlc3Qoc3RydWN0DQo+ID4gPiBuZnNfcGFnZSAqcmVxKQ0KPiA+ID4gICAJ
c3RydWN0IG5mc19pbm9kZSAqbmZzaSA9IE5GU19JKGlub2RlKTsNCj4gPiA+ICAgCXN0cnVjdCBu
ZnNfcGFnZSAqaGVhZDsNCj4gPiA+ICAgDQo+ID4gPiAtCWF0b21pY19sb25nX2RlYygmbmZzaS0+
bnJlcXVlc3RzKTsNCj4gPiA+ICAgCWlmIChuZnNfcGFnZV9ncm91cF9zeW5jX29uX2JpdChyZXEs
IFBHX1JFTU9WRSkpIHsNCj4gPiA+ICAgCQloZWFkID0gcmVxLT53Yl9oZWFkOw0KPiA+ID4gICAN
Cj4gPiA+IEBAIC03OTksOCArNzk4LDEwIEBAIHN0YXRpYyB2b2lkIG5mc19pbm9kZV9yZW1vdmVf
cmVxdWVzdChzdHJ1Y3QNCj4gPiA+IG5mc19wYWdlICpyZXEpDQo+ID4gPiAgIAkJc3Bpbl91bmxv
Y2soJm1hcHBpbmctPnByaXZhdGVfbG9jayk7DQo+ID4gPiAgIAl9DQo+ID4gPiAgIA0KPiA+ID4g
LQlpZiAodGVzdF9hbmRfY2xlYXJfYml0KFBHX0lOT0RFX1JFRiwgJnJlcS0+d2JfZmxhZ3MpKQ0K
PiA+ID4gKwlpZiAodGVzdF9hbmRfY2xlYXJfYml0KFBHX0lOT0RFX1JFRiwgJnJlcS0+d2JfZmxh
Z3MpKSB7DQo+ID4gPiAgIAkJbmZzX3JlbGVhc2VfcmVxdWVzdChyZXEpOw0KPiA+ID4gKwkJYXRv
bWljX2xvbmdfZGVjKCZuZnNpLT5ucmVxdWVzdHMpOw0KPiA+ID4gKwl9DQo+ID4gPiAgIH0NCj4g
PiA+ICAgDQo+ID4gPiAgIHN0YXRpYyB2b2lkDQo+ID4gPiANCj4gDQo+IEhtbS4uLiBXaGF0IGFi
b3V0IG5mc19wYWdlX2dyb3VwX2luaXQoKT8gVGhhdCBhbHNvIGJ1bXBzIG5mc2ktDQo+ID4gbnJl
cXVlc3RzLg0KDQpBaC4uLiBOZXZlciBtaW5kLCB0aGF0J3MganVzdCBjb3B5aW5nIHRoZSBQR19J
Tk9ERV9SRUYgZmxhZyB0byB0aGUgbmV3DQpzdWJyZXF1ZXN0Lg0KDQpIb3dldmVyIG5mc19sb2Nr
X2FuZF9qb2luX3JlcXVlc3RzKCkgbG9va3MgbGlrZSBpdCBkb2VzIG5lZWQgdG8gY2hhbmdlDQp0
byBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nOg0KDQogICAgICAgIC8qIFBvc3Rwb25lIGRl
c3RydWN0aW9uIG9mIHRoaXMgcmVxdWVzdCAqLw0KLSAgICAgICBpZiAodGVzdF9hbmRfY2xlYXJf
Yml0KFBHX1JFTU9WRSwgJmhlYWQtPndiX2ZsYWdzKSkgew0KLSAgICAgICAgICAgICAgIHNldF9i
aXQoUEdfSU5PREVfUkVGLCAmaGVhZC0+d2JfZmxhZ3MpOw0KKyAgICAgICBpZiAodGVzdF9hbmRf
Y2xlYXJfYml0KFBHX1JFTU9WRSwgJmhlYWQtPndiX2ZsYWdzKSAmJg0KKyAgICAgICAgICAgIXRl
c3RfYW5kX3NldF9iaXQoUEdfSU5PREVfUkVGLCAmaGVhZC0+d2JfZmxhZ3MpKSB7DQogICAgICAg
ICAgICAgICAga3JlZl9nZXQoJmhlYWQtPndiX2tyZWYpOw0KICAgICAgICAgICAgICAgIGF0b21p
Y19sb25nX2luYygmTkZTX0koaW5vZGUpLT5ucmVxdWVzdHMpOw0KICAgICAgICB9DQoNCg0KRG8g
eW91IGFncmVlPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
