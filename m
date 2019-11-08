Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2117CF53B1
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 19:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfKHSox (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 13:44:53 -0500
Received: from mail-eopbgr750103.outbound.protection.outlook.com ([40.107.75.103]:27527
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbfKHSox (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 13:44:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdIxnjohUcvuU62qujw39ynvSeXzQ/HXdx0aaEEI5POYX16d9ElKEL2Z47Kb6WsEBceLwQXFZow9ZdQNeYpDXt0mDxncRkc33WuHPFUO5yMM34vseVlb7jP+rCa5zyRtlkFPvwsI3LD1tLXqfspmBu6wJdyEIz/86lh5WHaZukSbMiouOUQhh2IIakMNZ4UQLog8gVZMLnw6DFswIofgsYJbcz69Ibuo0y3/F70quKqhfPfYUtUx3prAFr4/pzvvqSa6pX0fcBI0LCTP7h9tlR6zeFo4kXQ3iIO6GjBthhYrf0ZP6MCgxUiPmRhEsrTNBVwjd+AQdTO5v97vyJiiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Th89LRXdQ5jankurvdXgXALqHNNWYIVFOkiJMBYPF5Y=;
 b=dT6Deq+P0xlAsfPP3P6dtdCoOxx7UGw7JKhGC+jQcnSzDXEKKDCZwYIZQQ2oqQLDpt+I+u0+BFx9nCrBsI/OoqBcXy+dMbHJyBOUhtHTd/2LU5cCSbsrk9lDVMIgnNERp8g0ov99XXjzq0HQQ4tkcbCc4Jf61MlHynm/K8XUl3BXJ2NtTyR19qqk8slwqd8qHO8kLqouRiWrTMi3zo+RotIxOj1eVvllCNRMaf9SNOY6mX3pOrZw0LYmet7WYAwoeH2SOz5FBfvIJyw4lvbE4iu4/TRZE0WJQ0CibG/9Oca0XVGfBA7UIMf7UIP3S4jFKm680W9SPGpmveBmudUYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Th89LRXdQ5jankurvdXgXALqHNNWYIVFOkiJMBYPF5Y=;
 b=AAuPm+5yl21m844kVqJ3mRnaYbrz8B6vq3NN7AsPD7Mv4QkktUcYZEs0R4Dr7D/kOAbLrHEiX/cpV++9heHSjA0wWEvE4Cz/+TTR20nOrkMbr58tphMSvU1eOIgUX5idTKsROVYQC6sJhOoU6fnTyW1yZpgMytnaGBgcsKU39o4=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1945.namprd13.prod.outlook.com (10.174.184.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15; Fri, 8 Nov 2019 18:44:50 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::4c0b:3977:6b2d:6a8c%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 18:44:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "bfields@redhat.com" <bfields@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: Fix races between nfsd4_cb_release() and
 nfsd4_shutdown_callback()
Thread-Topic: [PATCH v2] nfsd: Fix races between nfsd4_cb_release() and
 nfsd4_shutdown_callback()
Thread-Index: AQHVies2JdHABN5ZLkasQ9xpK5TdU6drc5yAgAABGoCAAAcngIAAA24AgAaxrYCADjAxAIABVDCA
Date:   Fri, 8 Nov 2019 18:44:50 +0000
Message-ID: <b92c829eaea3ab1ebf045103ab9dd8ec57d5e859.camel@hammerspace.com>
References: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
         <20191025145147.GA16053@pick.fieldses.org>
         <97f56de86f0aeafb56998023d0561bb4a6233eb8.camel@hammerspace.com>
         <20191025152119.GC16053@pick.fieldses.org>
         <20191025153336.GA20283@fieldses.org> <20191029214705.GA29280@fieldses.org>
         <20191107222712.GB10806@fieldses.org>
In-Reply-To: <20191107222712.GB10806@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.243.139]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af4c92f0-fa52-4f90-c90a-08d7647bbc99
x-ms-traffictypediagnostic: DM5PR1301MB1945:
x-microsoft-antispam-prvs: <DM5PR1301MB1945AF361FA2130396ABACCEB87B0@DM5PR1301MB1945.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(39830400003)(396003)(376002)(189003)(199004)(6246003)(71200400001)(71190400001)(66946007)(5660300002)(36756003)(6436002)(6486002)(14454004)(8936002)(2906002)(229853002)(66066001)(76176011)(316002)(486006)(3846002)(446003)(11346002)(91956017)(2616005)(305945005)(118296001)(476003)(110136005)(26005)(7736002)(99286004)(6506007)(8676002)(25786009)(66446008)(256004)(478600001)(81156014)(81166006)(76116006)(86362001)(66476007)(66556008)(4326008)(64756008)(102836004)(2501003)(6116002)(186003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1945;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xr2cNiuIJLOWC6au5ShfdD61rvkun/Qa1dgelN2szaLRspiBkPtJuYaGnRtORtGcKrN8mrsw4D7ed9Ph5FzZd8selXM3YeGleujOnjv5+Hg1ZUzzCfoXb9FYkcnwTJL2FPaWFUr7UYCdZ+ZYGp+8ZN6dJQEezSpWSBuTX65WjROftE7N2FcriqJgLMFg2Y8J0woL9BgVxtA8zZiDYxCQeSL1P/YB4HTyyMNeAzWNAjxqf5Y6cBc0ZVTCFNjTLfJQZdVzzTau1DOtPyjAv3eOXz6BHiIKVWX7gApqcDvkzkR3+0doLuTF+o0eV7YJMWo5l3RVcBu/iXdS4yChFV2m3UU9DB7wIG1ojs1Ecm/ANfv/FpYMkEW9F/4Xdre34jl1K2FdImMW9iaXFI+gg6KERZmUVnuO/TwUd390w7xwCZNtLw8uCxm046x2/fCNKAqe
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED0615567C4174459E696E730C1B2BC3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4c92f0-fa52-4f90-c90a-08d7647bbc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 18:44:50.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSH/N7JLcsbMqN6BNiQtrbyF8IjdRSow/WmYhR8/5oN+yiRmdy2O5d5Rj9FG1Ka6x4PpAOaW6EuqOMNsDKoI4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1945
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDE3OjI3IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgT2N0IDI5LCAyMDE5IGF0IDA1OjQ3OjA1UE0gLTA0MDAsIEouIEJydWNlIEZp
ZWxkcyB3cm90ZToNCj4gPiBPbiBGcmksIE9jdCAyNSwgMjAxOSBhdCAxMTozMzozNkFNIC0wNDAw
LCBiZmllbGRzIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBPY3QgMjUsIDIwMTkgYXQgMTE6MjE6MTlB
TSAtMDQwMCwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gPiBJIHRob3VnaHQgSSB3YXMg
cnVubmluZyB2MiwgbGV0IG1lIGRvdWJsZS1jaGVjay4uLi4NCj4gPiA+IA0KPiA+ID4gWWVzLCB3
aXRoIHYyIEknbSBnZXR0aW5nIGEgaGFuZyBvbiBnZW5lcmljLzAxMy4NCj4gPiA+IA0KPiA+ID4g
SSBjaGVja2VkIHF1aWNrbHkgYW5kIGRpZG4ndCBzZWUgYW55dGhpbmcgaW50ZXJlc3RpbmcgaW4g
dGhlDQo+ID4gPiBsb2dzLA0KPiA+ID4gb3RoZXJ3aXNlIEkgaGF2ZW4ndCBkb25lIGFueSBkaWdn
aW5nLg0KPiA+IA0KPiA+IFJlcHJvZHVjZWFibGUganVzdCB3aXRoIC4vY2hlY2sgLW5mcyBnZW5l
cmljLzAxMy4gIFRoZSBsYXN0IHRoaW5nIEkNCj4gPiBzZWUNCj4gPiBpbiB3aXJlc2hhcmsgaXMg
YW4gYXN5bmNocm9ub3VzIENPUFkgY2FsbCBhbmQgcmVwbHkuICBXaGljaCBtZWFucw0KPiA+IGl0
J3MNCj4gPiBwcm9iYWJseSB0cnlpbmcgdG8gZG8gYSBDQl9PRkZMT0FELiAgSG0uDQo+IA0KPiBP
aCwgSSB0aGluayBpdCBqdXN0IG5lZWRzIHRoZSBmb2xsb3dpbmcuDQo+IA0KPiAtLWIuDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzZC9uZnM0Y2FsbGJhY2suYyBiL2ZzL25mc2QvbmZzNGNhbGxi
YWNrLmMNCj4gaW5kZXggZmI3MWU3ZjlkMGQ5Li5lNDk2MDQ3MDFhNzEgMTAwNjQ0DQo+IC0tLSBh
L2ZzL25mc2QvbmZzNGNhbGxiYWNrLmMNCj4gKysrIGIvZnMvbmZzZC9uZnM0Y2FsbGJhY2suYw0K
PiBAQCAtMTAyNiw4ICsxMDI2LDggQEAgc3RhdGljIGJvb2wgbmZzZDQxX2NiX2dldF9zbG90KHN0
cnVjdA0KPiBuZnNkNF9jYWxsYmFjayAqY2IsIHN0cnVjdCBycGNfdGFzayAqdGFzaykNCj4gIAkJ
CXJldHVybiBmYWxzZTsNCj4gIAkJfQ0KPiAgCQlycGNfd2FrZV91cF9xdWV1ZWRfdGFzaygmY2xw
LT5jbF9jYl93YWl0cSwgdGFzayk7DQo+IC0JCWNiLT5jYl9ob2xkc19zbG90ID0gdHJ1ZTsNCj4g
IAl9DQo+ICsJY2ItPmNiX2hvbGRzX3Nsb3QgPSB0cnVlOw0KPiAgCXJldHVybiB0cnVlOw0KPiAg
fQ0KPiAgDQoNCkRvaCEgVGhhbmtzIGZvciBzcG90dGluZyB0aGF0Lg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
