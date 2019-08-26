Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E75FA9D775
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfHZUkA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 16:40:00 -0400
Received: from mail-eopbgr700127.outbound.protection.outlook.com ([40.107.70.127]:52961
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbfHZUkA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 16:40:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj2C47l+b6j+NyGqKvcX+J9emqoizNjBWlOdoju0j7aajqnx4khwi2HJTiVZ9OEPLIHmy7mnzvMSEcXofEOg4iSViUgX2qQ4wbqXXN97EsSRph1gxIIkziHyiETqKw+ndMuAQIfmSKeB3tm0XUIE13uVp3XIpcdlUppq4wJMQRnrJniq2viSPDP9gsxvvuflNjsm1sIW+Y68hXIH0t258YOZkUlRIWYGjqdNNhGw+iHQiVQ8I/BZ4tVmcEWaXNA5DnXZsujlBPZnyIVTWa6FTh3suRP95+FPt4v1wnRTSVIQAe8NjVnzVIsTqjPcU0XJGNmeIw3UTAxKrAaReo6KiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHYFE6RCHDL2G69PgIGYLQPXqkdW2S6qLoZ1zV8rH2s=;
 b=PMz1PzhR4b79E/tZg8soyvoLRduzHpGYV6sU6FadttjliDsU5niHy2lmD95QElU6FaFNTZZlVj1PosJgNp9QhEsQ4wBdRgilRCdkXZ7MabdYNS8vokAfOg62Vvm0iAezSZaIM0jm2qHZKX2jBX6uxJxGGagNWJG+wZT6FtU/bhdZ+GKdmnbjSmsa5Vl1XaNnGZsbfnN4aaCSMiXBqRFv9wuaHjD+9dhljxc1IHPCI34AQBesyy6Z/bvSkhsg2NL17+8c7Lc2LgQg3EhMzhSSIzqclAY2hf0hrvVcSPImvVOZ5LttUVgMIZUXacW9zwZhmIYln2IZI/PI39v/31D/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHYFE6RCHDL2G69PgIGYLQPXqkdW2S6qLoZ1zV8rH2s=;
 b=NZALTdh8PPT1pWOimLGvUyZamvaVvHP0YQCL44sE1rIbXTMZZPCWGPFy5Wl6a/lkH4utRPnUYOF5XscAb3nYLctRt/cUOzejZAvUcUcHdlMt/SrMh9+JQf3lnb3LL47pPP+q7SALzlBD2q1D58TgS1xKdzsXdQq7N9D4oX9Guqw=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1594.namprd13.prod.outlook.com (10.175.110.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.13; Mon, 26 Aug 2019 20:39:54 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Mon, 26 Aug 2019
 20:39:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] NFSv3: nfs_instantiate() might succeed leaving dentry
 negative unhashed
Thread-Topic: [PATCH] NFSv3: nfs_instantiate() might succeed leaving dentry
 negative unhashed
Thread-Index: AQHVXExAbdA8Vm+B30KiQwEE/S1OS6cN5DuA
Date:   Mon, 26 Aug 2019 20:39:54 +0000
Message-ID: <e3b9ff47b2b195796ac30e8580764ce549d3c325.camel@hammerspace.com>
References: <d2076a27c1f3faa0d732e64d49bcbab054cae23b.1566850914.git.bcodding@redhat.com>
In-Reply-To: <d2076a27c1f3faa0d732e64d49bcbab054cae23b.1566850914.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 011487a5-d09e-4dc1-9239-08d72a658d60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1594;
x-ms-traffictypediagnostic: DM5PR13MB1594:
x-microsoft-antispam-prvs: <DM5PR13MB159445DB69F6EC2256D8FEC7B8A10@DM5PR13MB1594.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39840400004)(199004)(189003)(71200400001)(2616005)(4326008)(6116002)(3846002)(6506007)(305945005)(102836004)(25786009)(36756003)(5660300002)(11346002)(14454004)(99286004)(71190400001)(446003)(7736002)(76176011)(2501003)(8936002)(66066001)(110136005)(6512007)(6436002)(118296001)(256004)(53936002)(6246003)(478600001)(54906003)(81166006)(316002)(476003)(66946007)(229853002)(66556008)(6486002)(2906002)(64756008)(66476007)(91956017)(486006)(86362001)(186003)(66446008)(76116006)(81156014)(8676002)(14444005)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1594;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZfyUG3NNDGGj3O1e8PgJKkgV9vmBQxWjYfPK/ZZSjp5qt/GZiYXZvn02RibT4Te2QiaY9aWJd4a2Oc7abgm2QAhcP5hovm3z9IQRG+/7QuyLxoaz8YbPGpGZWoc6t2zeYaRHXdcfRRp4CbHW4tiD0XVQqBL2l1Zo0W/QU48eC6MmvhJK9vLcmI4UptKZ5/mismLVL0/JX8oZn/dtDwORjVSqMRnUtXz72NaABGDNAJo10D+j7UbpWg17BSDjmCPwViCu8Jg8IaECqJgh3HgFUxvoTMCJd8O4LGVrjMDAapK62/MxSg96HbXecTpdwEbgFbQhJjUUqmYkS3P+HunXdTr71JJtmQ0rS4QlBzxsOTjOU7iX4fcoOUE/NuAFYtq3jhampnqgRSStHymMq8mbUpMZNBTrZY5mEyQzpNGZWuU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABD0E12B079B3F4FBF3EF2D6605D2976@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011487a5-d09e-4dc1-9239-08d72a658d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 20:39:54.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/loA0318i55+FlpYtPeJijNdpE1uqS5GT7g6qmjdb6SSqHJGCu553bwqxbFo3Gt6q4FuPmlW/BhS+GNvYg2pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1594
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDE2OjI0IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBBZnRlciBhZGRpbmcgY29tbWl0IGIwYzYxMDhlY2Y2NCAoIm5mc19pbnN0YW50aWF0
ZSgpOiBwcmV2ZW50DQo+IG11bHRpcGxlDQo+IGFsaWFzZXMgZm9yIGRpcmVjdG9yeSBpbm9kZSIp
IG15IE5GUyBjbGllbnQgY3Jhc2hlcyB3aGlsZSBkb2luZw0KPiBsdXN0cmUgcmFjZQ0KPiB0ZXN0
cyBzaW11bHRhbmVvdXNseSBvbiBhIGxvY2FsIGZpbGVzeXN0ZW0gYW5kIHRoZSBzYW1lIGZpbGVz
eXN0ZW0NCj4gZXhwb3J0ZWQNCj4gdmlhIGtuZnNkOg0KPiANCj4gICAgIEJVRzogdW5hYmxlIHRv
IGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0DQo+IDAwMDAwMDAwMDAw
MDAwMjgNCj4gICAgICBDYWxsIFRyYWNlOg0KPiAgICAgICA/IGlwdXQrMHg3Ni8weDIwMA0KPiAg
ICAgICA/IGRfc3BsaWNlX2FsaWFzKzB4MzA3LzB4M2MwDQo+ICAgICAgID8gZHB1dC5wYXJ0LjMx
KzB4OTYvMHgxMTANCj4gICAgICAgPyBuZnNfaW5zdGFudGlhdGUrMHg0NS8weDE2MCBbbmZzXQ0K
PiAgICAgICBuZnMzX3Byb2Nfc2V0YWNscysweGEvMHgyMCBbbmZzdjNdDQo+ICAgICAgIG5mczNf
cHJvY19jcmVhdGUrMHgxY2MvMHgyMzAgW25mc3YzXQ0KPiAgICAgICBuZnNfY3JlYXRlKzB4ODMv
MHgxNjAgW25mc10NCj4gICAgICAgcGF0aF9vcGVuYXQrMHgxMWFhLzB4MTRkMA0KPiAgICAgICBk
b19maWxwX29wZW4rMHg5My8weDEwMA0KPiAgICAgICA/IF9fY2hlY2tfb2JqZWN0X3NpemUrMHhh
My8weDE4MQ0KPiAgICAgICBkb19zeXNfb3BlbisweDE4NC8weDIyMA0KPiAgICAgICBkb19zeXNj
YWxsXzY0KzB4NWIvMHgxYjANCj4gICAgICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NjUvMHhjYQ0KPiANCj4gICAgMTU4IHN0YXRpYyBpbnQgX19uZnMzX3Byb2Nfc2V0YWNscyhz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QNCj4gcG9zaXhfYWNsICphY2wsDQo+ICAgIDE1OSAg
ICAgICAgIHN0cnVjdCBwb3NpeF9hY2wgKmRmYWNsKQ0KPiAgICAxNjAgew0KPiA+ID4gMTYxICAg
ICBzdHJ1Y3QgbmZzX3NlcnZlciAqc2VydmVyID0gTkZTX1NFUlZFUihpbm9kZSk7DQo+IA0KPiBU
aGUgMHgyOCBvZmZzZXQgaXMgaV9zYiBpbiBzdHJ1Y3QgaW5vZGUsIHdlIHBhc3NlZCBhIE5VTEwg
aW5vZGUgdG8NCj4gbmZzM19wcm9jX3NldGFjbHMoKS4NCj4gDQo+IEFmdGVyIHRha2luZyB0aGlz
IGFwYXJ0LCBJIGZpbmQgdGhlIGRlbnRyeSBpbiBSMTIgaGFzIGEgTlVMTCBpbm9kZQ0KPiBhZnRl
cg0KPiBuZnNfaW5zdGFudGlhdGUoKSwgd2hpY2ggbWFrZXMgc2Vuc2UgaWYgd2UgbW92ZSBpdCB0
byB0aGUgYWxpYXMganVzdA0KPiBhZnRlcg0KPiBuZnNfZmhnZXQoKSAoU2VlIHRoZSByZWZlcmVu
Y2VkIGNvbW1pdCBhYm92ZSkuICBJbmRlZWQsIG9uIHRoZSBsaXN0DQo+IG9mDQo+IGNoaWxkcmVu
IGlzIHRoZSBpZGVudGljYWwgcG9zaXRpdmUgZGVudHJ5IHRoYXQgaXMgbGVmdCBiZWhpbmQgYWZ0
ZXINCj4gZF9zcGxpY2VfYWxpYXMoKS4gIE1vdmluZyBpdCB3b3VsZCB1c3VhbHkgYmUgZmluZSBm
b3IgY2FsbGVycywgZXhjZXB0DQo+IGZvcg0KPiBORlN2MyBiZWNhdXNlIHdlIHdhbnQgdGhlIGlu
b2RlIHBvaW50ZXIgdG8gcmlkZSB0aGUgZGVudHJ5IGJhY2sgdXANCj4gdGhlDQo+IHN0YWNrIHNv
IHdlIGNhbiBzZXQgQUNMcyBvbiBpdCBhbmQvb3Igc2V0IGF0dHJpYnV0ZXMgaW4gdGhlIGNhc2Ug
b2YNCj4gRVhDTFVTSVZFLg0KPiANCj4gQSBzaW1pbGFyIHByb2JsZW0gZXhpc3RlZCBpbiBuZnNk
X2NyZWF0ZV9sb2NrZWQoKSwgYW5kIHdhcyBmaXhlZCBieQ0KPiBjb21taXQNCj4gMzgxOWJiMGQ3
OWY1ICgibmZzZDogdmZzX21rZGlyKCkgbWlnaHQgc3VjY2VlZCBsZWF2aW5nIGRlbnRyeQ0KPiBu
ZWdhdGl2ZQ0KPiB1bmhhc2hlZCIpLiAgVGhpcyBwYXRjaCB0YWtlcyB0aGUgc2FtZSBhcHByb2Fj
aCB0byBmaXhpbmcgdGhlDQo+IHByb2JsZW06IGluDQo+IHRoZSByYXJlIGNhc2UgdGhhdCB3ZSBs
b3N0IHRoZSByYWNlIHRvIHRoZSBkZW50cnksIGxvb2sgaXQgdXAgYW5kIGdldA0KPiB0aGUNCj4g
aW5vZGUgZnJvbSB0aGVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIENvZGRpbmd0
b24gPGJjb2RkaW5nQHJlZGhhdC5jb20+DQo+IEZpeGVzOiBiMGM2MTA4ZWNmNjQgKCJuZnNfaW5z
dGFudGlhdGUoKTogcHJldmVudCBtdWx0aXBsZSBhbGlhc2VzIGZvcg0KPiBkaXJlY3RvcnkgaW5v
ZGUiKQ0KPiBDYzogQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+DQo+IC0tLQ0KPiAg
ZnMvbmZzL25mczNwcm9jLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2ZzL25mcy9uZnMzcHJvYy5jIGIvZnMvbmZzL25mczNwcm9jLmMNCj4gaW5kZXggYTNhZDJk
NDZmZDQyLi4yOTJjNTNjMDgyZjcgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnMzcHJvYy5jDQo+
ICsrKyBiL2ZzL25mcy9uZnMzcHJvYy5jDQo+IEBAIC0yMCw2ICsyMCw3IEBADQo+ICAjaW5jbHVk
ZSA8bGludXgvbmZzX21vdW50Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZnJlZXplci5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L3hhdHRyLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvbmFtZWkuaD4NCj4g
IA0KPiAgI2luY2x1ZGUgImlvc3RhdC5oIg0KPiAgI2luY2x1ZGUgImludGVybmFsLmgiDQo+IEBA
IC0zMDUsNiArMzA2LDcgQEAgbmZzM19wcm9jX2NyZWF0ZShzdHJ1Y3QgaW5vZGUgKmRpciwgc3Ry
dWN0IGRlbnRyeQ0KPiAqZGVudHJ5LCBzdHJ1Y3QgaWF0dHIgKnNhdHRyLA0KPiAgCXN0cnVjdCBw
b3NpeF9hY2wgKmRlZmF1bHRfYWNsLCAqYWNsOw0KPiAgCXN0cnVjdCBuZnMzX2NyZWF0ZWRhdGEg
KmRhdGE7DQo+ICAJaW50IHN0YXR1cyA9IC1FTk9NRU07DQo+ICsJc3RydWN0IGRlbnRyeSAqZCA9
IE5VTEw7DQo+ICANCj4gIAlkcHJpbnRrKCJORlMgY2FsbCAgY3JlYXRlICVwZFxuIiwgZGVudHJ5
KTsNCj4gIA0KPiBAQCAtMzU1LDYgKzM1NywyMiBAQCBuZnMzX3Byb2NfY3JlYXRlKHN0cnVjdCBp
bm9kZSAqZGlyLCBzdHJ1Y3QNCj4gZGVudHJ5ICpkZW50cnksIHN0cnVjdCBpYXR0ciAqc2F0dHIs
DQo+ICAJaWYgKHN0YXR1cyAhPSAwKQ0KPiAgCQlnb3RvIG91dF9yZWxlYXNlX2FjbHM7DQo+ICAN
Cj4gKwkvKiBQb3NzaWJsZSB0aGF0IG5mc19pbnN0YW50aWF0ZSgpIGxvc3QgYSByYWNlIHRvIG9w
ZW4tYnktDQo+IGZoYW5kbGUsDQo+ICsJICogaW4gd2hpY2ggY2FzZSB3ZSBkb24ndCBoYXZlIGEg
cmVmZXJlbmNlIHRvIHRoZSBkZW50cnkgKi8NCj4gKwlpZiAodW5saWtlbHkoZF91bmhhc2hlZChk
ZW50cnkpKSkgew0KPiArCQlkID0gbG9va3VwX29uZV9sZW4oZGVudHJ5LT5kX25hbWUubmFtZSwg
ZGVudHJ5LQ0KPiA+ZF9wYXJlbnQsDQo+ICsJCQkJCQkJZGVudHJ5LQ0KPiA+ZF9uYW1lLmxlbik7
DQo+ICsJCWlmIChJU19FUlIoZCkpIHsNCj4gKwkJCXN0YXR1cyA9IFBUUl9FUlIoZCk7DQo+ICsJ
CQlnb3RvIG91dF9yZWxlYXNlX2FjbHM7DQo+ICsJCX0NCj4gKwkJaWYgKHVubGlrZWx5KGRfaXNf
bmVnYXRpdmUoZCkpKSB7DQo+ICsJCQlzdGF0dXMgPSAtRU5PRU5UOw0KPiArCQkJZ290byBvdXRf
cHV0X2Q7DQo+ICsJCX0NCj4gKwkJZGVudHJ5ID0gZDsNCj4gKwl9DQo+ICsNCg0KDQpJZiB0aGlz
IGlzIGEgY29uc2VxdWVuY2Ugb2YgYSByYWNlIGluIG5mc19pbnN0YW50aWF0ZSwgdGhlbiB3aHkg
YXJlIHdlDQpub3QgZml4IGl0IHRoZXJlPyBXb24ndCB3ZSBvdGhlcndpc2UgZW5kIHVwIGhhdmlu
ZyB0byBkdXBsaWNhdGUgdGhlDQphYm92ZSBjb2RlIGluIGFsbCB0aGUgb3RoZXIgY2FsbGVycz8N
Cg0KSU9XOiB3aHkgbm90IHNpbXBseSBtb2RpZnkgbmZzX2luc3RhbnRpYXRlKCkgdG8gcmV0dXJu
IHRoZSBkZW50cnkgZnJvbQ0KZF9zcGxpY2VfYWxpYXMoKSwgbXVjaCBsaWtlIHdlIGFscmVhZHkg
ZG8gZm9yIG5mc19sb29rdXAoKT8NCg0KQ2hlZXJzDQogIFRyb25kDQoNCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
