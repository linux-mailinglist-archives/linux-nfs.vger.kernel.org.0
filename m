Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DF2B8230
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 22:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbfISUF7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 16:05:59 -0400
Received: from mail-eopbgr720098.outbound.protection.outlook.com ([40.107.72.98]:62019
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392458AbfISUF7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 16:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWb9pgrX35uzTn6G3aaVGd+xtRnpznHhfAyewqJnN0E5Y9wP3A9QhMa0P6pxCpBGw3ZYfAQg1ke3GE3Z2ATK0AQTSIUBRdCLHb2mMPf8hL8mr6tRouQiEAP52o3fUKOfDnK2w52rLuWPByjSwUuwG9EzKBzCG2Qs/nnfR+gIxS/tZzdtMOhLNSaKetaFZwmRiQhq5JSmtuT5EBij9bHWHIH+DbqBD7fkc66Zbv+RJpBd2uvZA+MvSLK5EinXLyz8O3FChnxAjG5sMBLdK8oSdZsqNBz9OZ14+idDyQfOCrnmyd2dz36KIayolwtQI/f7L+RV1I7cw4UAOyq+1h1W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sfYH8jabzhJfL8sRdD+IFrmayHs5MvRgp/XDTGbNtE=;
 b=d5ouRU7NnpXCpmUfgApx9j4VjyPmBgEGxyFS1mwSEjRu4xWNMSndKITiakkmfVlSS8CdsNmMjxHbT+SbPPfW+8FgsLDnoszhzbqoadeC6dxuRQ0lkhoq1zdzao98EYMEHyymvXiQCc8X67a5LSYD+eN0lWNlb3fQAYzbN/0Ufdkzxs5vNy7tyYoCZaLwYAbDWTFxiHqs/jOb4jfA6135rjbchmJrop21dhMtDPF7P2/cYNyv5eCwWGrCIUpRE26IBm1/qFCZzB/jF/jGH7fHr+mizfxD2IBpA1mfuiu3mhxL6vYuJEIzjeJChkDfTqvWjh9bqEGoIuSEqQQjv+E8mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sfYH8jabzhJfL8sRdD+IFrmayHs5MvRgp/XDTGbNtE=;
 b=YFcU6Kt92caeCEa/R1sweKT7FYOXx768GASCBGk2OKah4wNrs9kQyas6bJfbirPMe5+b0YpP5R+t8yDoS+qRd4rv7ObT2TJm/DTClEYJPxtSzCiRGdz2q6NzObRYgGvTUNO1l4mzbNXkqv2tNw25nCT/kExkowFSi6P++BRs9Ts=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1467.namprd13.prod.outlook.com (10.175.110.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.15; Thu, 19 Sep 2019 20:05:55 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 20:05:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "alkisg@gmail.com" <alkisg@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Topic: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Index: AQHVbwMN/jYKfSJ+jEOCnZqjx88626czK6CAgAA1K4CAAAiCAIAAAYOAgAACcYA=
Date:   Thu, 19 Sep 2019 20:05:55 +0000
Message-ID: <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
         <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
         <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
         <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
         <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
         <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
         <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
In-Reply-To: <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46efffda-1067-4f62-d23c-08d73d3cc7bf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1467;
x-ms-traffictypediagnostic: DM5PR13MB1467:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR13MB1467E58C165912E0144E621BB8890@DM5PR13MB1467.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39830400003)(346002)(366004)(199004)(189003)(446003)(2906002)(66066001)(6436002)(6246003)(110136005)(2616005)(6486002)(6306002)(6512007)(316002)(476003)(478600001)(966005)(14454004)(486006)(118296001)(11346002)(256004)(6116002)(3846002)(76176011)(81166006)(66946007)(76116006)(5660300002)(91956017)(86362001)(71190400001)(102836004)(99286004)(64756008)(7736002)(305945005)(53546011)(26005)(186003)(66556008)(8676002)(6506007)(71200400001)(66476007)(25786009)(561944003)(2501003)(81156014)(36756003)(8936002)(66446008)(229853002)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1467;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wmbb0Do1HW8Git6QeXFTQqMF+5XIBLal6dKN0cgoG+6ffqTBjWyCfUzjOEDprrXIGLIlKAVXFL8UJh+MLYyjHhKtBCe9zrLSIGAe6cGHr0+2ngK72MqCeKUChkqiV0ryLSWnA2yv4UdWdgX6nB9L1OCATiAI0DrC8t9xG2QUBptQcMJiI1Q7+TZOwstXgWmCUOqk3HExPQeAKpvQ3usolFyLzoKY7AUjwnESI5A0wWsZuVaqdLhtq9yVfcJoq+duFak1W2WB/jhEYIBvVbOHLu/UsM6nGbcvHulb2C7p29qhkWfSlhh+JdpnAvAMbkMtgC4q3UCkw7J8mnJptNItoPS+7CE6kIq7F0CwE1U+cwMWl7xsdmkzE9awRk6Uys9RtX+KLziu8n8YLmkO+FOzZeaSTt8MjwAseMywWe3WHso=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F4FDF0268294D43B645302C2255FEFF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46efffda-1067-4f62-d23c-08d73d3cc7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 20:05:55.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbqyI/R+dazoQBTzyGAcfy0cXlJN3D9jjSV3o/T31apST3Tb+58vyfQpFGPR4GVsLxjv5pz61ILUQxmKflr0oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1467
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDIyOjU3ICswMzAwLCBBbGtpcyBHZW9yZ29wb3Vsb3Mgd3Jv
dGU6DQo+IE9uIDkvMTkvMTkgMTA6NTEgUE0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBJ
IGRvbid0IHVuZGVyc3RhbmQgd2h5IGtsaWJjIHdvdWxkIGRlZmF1bHQgdG8gc3VwcGx5aW5nIGEg
dGltZW89Nw0KPiA+IGFyZ3VtZW50IGF0IGFsbC4gSXQgd291bGQgYmUgTVVDSCBiZXR0ZXIgaWYg
aXQganVzdCBsZXQgdGhlIGtlcm5lbA0KPiA+IHNldA0KPiA+IHRoZSBkZWZhdWx0LCB3aGljaCBp
biB0aGUgY2FzZSBvZiBUQ1AgaXMgdGltZW89NjAwLg0KPiA+IA0KPiA+IEkgYWdyZWUgd2l0aCB5
b3VyIGFyZ3VtZW50IHRoYXQgcmVwbGF5aW5nIHJlcXVlc3RzIGV2ZXJ5IDAuNw0KPiA+IHNlY29u
ZHMgaXMNCj4gPiBqdXN0IGdvaW5nIHRvIGNhdXNlIGNvbmdlc3Rpb24uIFRDUCBwcm92aWRlcyBm
b3IgcmVsaWFibGUgZGVsaXZlcnkNCj4gPiBvZg0KPiA+IFJQQyBtZXNzYWdlcyB0byB0aGUgc2Vy
dmVyLCB3aGljaCBpcyB3aHkgdGhlIGtlcm5lbCBkZWZhdWx0IGlzIGENCj4gPiBmdWxsDQo+ID4g
bWludXRlLg0KPiA+IA0KPiA+IFNvIHBsZWFzZSBhc2sgdGhlIGtsaWJjIGRldmVsb3BlcnMgdG8g
Y2hhbmdlIGxpYm1vdW50IHRvIGxldCB0aGUNCj4gPiBrZXJuZWwNCj4gPiBkZWNpZGUgdGhlIGRl
ZmF1bHQgbW91bnQgb3B0aW9ucy4gVGhlaXIgY3VycmVudCBzZXR0aW5nIGlzIGp1c3QNCj4gPiBw
bGFpbg0KPiA+IHdyb25nLg0KPiANCj4gVGhpcyB3YXMgd2hhdCBJIGFza2VkIGluIG15IGZpcnN0
IG1lc3NhZ2UgdG8gdGhlaXIgbWFpbGluZyBsaXN0LA0KPiBodHRwczovL2xpc3RzLnp5dG9yLmNv
bS9hcmNoaXZlcy9rbGliYy8yMDE5LVNlcHRlbWJlci8wMDQyMzQuaHRtbA0KPiANCj4gVGhlbiBJ
IHJlYWxpemVkIHRoYXQgdGltZW89NjAwIGp1c3QgaGlkZXMgdGhlIHJlYWwgcHJvYmxlbSwNCj4g
d2hpY2ggaXMgcnNpemU9MU0uDQo+IA0KPiBORlMgZGVmYXVsdHM6IHRpbWVvPTYwMCxyc2l6ZT0x
TSA9PiBsYWcNCj4gbmZzbW91bnQgZGVmYXVsdHM6IHRpbWVvPTcscnNpemU9MU1LID0+IGxhZyBB
TkQgZG1lc2cgZXJyb3JzDQo+IA0KPiBNeSBwcm9wb3NhbDogdGltZW89d2hhdGV2ZXIscnNpemU9
MzJLID0+IGFsbCBmaW5lDQo+IA0KPiBJZiBtb3JlIGJlbmNobWFya3MgYXJlIG5lZWRlZCBmcm9t
IG1lIHRvIGRvY3VtZW50IHRoZQ0KPiAiTkZTIGRlZmF1bHRzOiB0aW1lbz02MDAscnNpemU9MU0g
PT4gbGFnIg0KPiBJIGNhbiBzdXJlbHkgcHJvdmlkZSB0aGVtLg0KDQpUaGVyZSBhcmUgcGxlbnR5
IG9mIG9wZXJhdGlvbnMgdGhhdCBjYW4gdGFrZSBsb25nZXIgdGhhbiA3MDAgbXMgdG8NCmNvbXBs
ZXRlLiBTeW5jaHJvbm91cyB3cml0ZXMgdG8gZGlzayBhcmUgb25lLCBidXQgQ09NTUlUIChpLmUu
IHRoZSBORlMNCmVxdWl2YWxlbnQgb2YgZnN5bmMoKSkgY2FuIG9mdGVuIHRha2UgbXVjaCBsb25n
ZXIgZXZlbiB0aG91Z2ggaXQgaGFzIG5vDQpwYXlsb2FkLg0KDQpTbyB0aGUgcHJvYmxlbSBpcyBu
b3QgdGhlIHNpemUgb2YgdGhlIFdSSVRFIHBheWxvYWQuIFRoZSByZWFsIHByb2JsZW0NCmlzIHRo
ZSB0aW1lb3V0Lg0KDQpUaGUgYm90dG9tIGxpbmUgaXMgdGhhdCBpZiB5b3Ugd2FudCB0byBrZWVw
IHRpbWVvPTcgYXMgYSBtb3VudCBvcHRpb24NCmZvciBUQ1AsIHRoZW4geW91IGFyZSBvbiB5b3Vy
IG93bi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
