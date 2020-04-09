Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E91A3B75
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 22:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDIUm2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Apr 2020 16:42:28 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:22017
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbgDIUm2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 Apr 2020 16:42:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvAeKEI8lEVn9KHwQHeRMdcmnDk3LB5KDjlTqzjkwj5bTYYNeoAe4zu0VF3Iv0Po0HXIYU2hpILu1Eb3QYfJZRDncZaeviZNScL4LClKp7cb2JgxDZUnHi6l2N5yn6bTbNdFpFa8Hbdmsu6vVckEZJAjLw7VSwvBfrz8j60yXIMlqhmvHfRL62xMK64VvdjEQEz6fyRqTa5YzsJloSD/UyBXQ55PnOkotaoiUX2aTsCI3COzCzr1DX1q/7xN5/8fxUnx1t2khUZ+DYXnntTEwQrVx+GT0bm58PXWLLChwVDDkTLjtCYTNH5HdXkeLeiOxGqbozTXKq6gO/gKPAkCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7f2WtBxF9FRIoM9Z24ke7n2pSV/FTMTI1rbhTcOQ7I=;
 b=eL2WQ2kaltARllkWYlK8bT9CTAjh2lHJg2K0IB0uWGo8tbWSHNJnS2iwwiY44tOcAK7O3zm2wEFcexIG3pDyEc1WEDSaiFF0mfiNZiKZIGV8HQDox7o/H5ztmgFshmxheb4qwlPvB63vjLmBYbJh2betlSDiPGQj06znWq0Zp0vRvnkM/FNELthsaW5bhZk100hza9T7fFVVPkhgsWp/Py4zCVgEXZSXXIUz1n1ck011NiNR6/3gWJ2rzf9PPVr6ROaUPPEzKtRFHPE+ZAq1wCS4opi3P2BeFPhJMfeODS7FxRn6orgXZ5dtitI+p1utDkGjppX5XlKYUjYeSUftzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7f2WtBxF9FRIoM9Z24ke7n2pSV/FTMTI1rbhTcOQ7I=;
 b=DE6BzmoBmsIo3Z6ddAnPirILEV62HyqDLlBAVQYAEsDQaglAONmAapL1TyUlNNRr7Kfva3otTvuT/+5Po57aXKNmhvS+3GggyeVrmJGC6S6lb4MdKMk5Dp0U9ZNGs6+x+DfLKK1jqB992aAWXOtYeHtaB0tCkpU0D3+hNQ7lnWs=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3606.namprd13.prod.outlook.com (2603:10b6:610:2e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.13; Thu, 9 Apr
 2020 20:42:12 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2921.009; Thu, 9 Apr 2020
 20:42:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: VFS rename hang
Thread-Topic: VFS rename hang
Thread-Index: AQHWDpJuMMm7Q8qVrEKw5hVGHY5A76hxKZ8AgAAQawCAAAd/AA==
Date:   Thu, 9 Apr 2020 20:42:12 +0000
Message-ID: <b189c96265936d55c4644a6007dc540d0c9f736d.camel@hammerspace.com>
References: <CAN-5tyE4w3LPx8oy=e=S+shq8w74iRGD-0Aktd0DtzGk8KkkJA@mail.gmail.com>
         <8be4b4e465f01f66f96c2308c833cbf95546e2cb.camel@hammerspace.com>
         <CAN-5tyE+s-iY=pqdUD6CVXCytYJiax3upCm=B_BM9iDUiiMGrg@mail.gmail.com>
In-Reply-To: <CAN-5tyE+s-iY=pqdUD6CVXCytYJiax3upCm=B_BM9iDUiiMGrg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c08ebbca-951a-4581-f997-08d7dcc67b34
x-ms-traffictypediagnostic: CH2PR13MB3606:
x-microsoft-antispam-prvs: <CH2PR13MB3606128C982E79FF2878909AB8C10@CH2PR13MB3606.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(39830400003)(366004)(346002)(136003)(81156014)(6506007)(2906002)(7116003)(26005)(186003)(86362001)(76116006)(53546011)(5660300002)(478600001)(8676002)(81166007)(6916009)(66476007)(4326008)(3480700007)(91956017)(8936002)(36756003)(66556008)(66946007)(66446008)(64756008)(71200400001)(316002)(6486002)(2616005)(6512007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Y5w9GNcMU6OGjnsN2hrGXnhbvJJOE2IgvOBn1GrzvLUi/uWuAsLsY01/f6BHaPhpJv9h189wV24buGY3o+Dg5KcqcGNnhieZ7q/nMbTjycdJsL9Um/ZkmzSUmWgAqow2UA8knY3uMasF7xD0wNEQl9kMwSV0rq6ClWFEMvGX3FLbRkGE5/dRFfbl6TTSlYzVXPrXpGIwSGCG2B3O/wxMXuDHfSoEPJgtRThDJ9+QGsw0zqaVA1YY4Az3eiZtqUrYthyFS8HsL+xD0jCRyUQnG7fxrVZoPxoano3aIR2U3XLK2TC0RqRYX0rKQrYy+u6GauxfIqDLUrbdeuLwwJywYdDRp60ozeXTdIFTylMYMKm9GckQ21YOFIEZKYqXo7LiakHx8Qpnq6sak9HX0xCnl+ZfVwoErjlrdoWgAGNCjdrmffvsr6FMNEbgA1y7CW+
x-ms-exchange-antispam-messagedata: hxjhlu4XHLnxmb+ik35fZrjDWRJUgnobGBtpm4gebOy8xmc2Bx07XLnsEuWl3ZEzxsByy3FDrRDY0/LymTQATle6+La5ZpLvO7cUZFYKUlZrXnHYjCbdz/PXhaIrP1Tvq80dX1+gYaBZxqDPUwn1xA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D2350750B6D3644B00F7F48528F792A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08ebbca-951a-4581-f997-08d7dcc67b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 20:42:12.2150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCKLBMM1cdu/T2gDJcDFquSLcVYZkep00DgaaxX+TTsl1o2ZjA6AksbleVKkfsdzt9GJAWylvWtc15qncDoRgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3606
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTA5IGF0IDE2OjE1IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBPbiBUaHUsIEFwciA5LCAyMDIwIGF0IDM6MTYgUE0gVHJv
bmQgTXlrbGVidXN0IDwNCj4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IEhp
IE9sZ2EsDQo+ID4gDQo+ID4gT24gVGh1LCAyMDIwLTA0LTA5IGF0IDEzOjE0IC0wNDAwLCBPbGdh
IEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IEhpIGZvbGtzLA0KPiA+ID4gDQo+ID4gPiBUaGlz
IGlzIGEgcmVuYW1lIG9uIGFuIE5GUyBtb3VudCBidXQgdGhlIHN0YWNrIHRyYWNlIGlzIG5vdCBp
bg0KPiA+ID4gTkZTLA0KPiA+ID4gYnV0IEknbSBjdXJpb3VzIGlmIGFueSBib2R5IHJhbiBpbnRv
IHRoaXMuIFRoYW5rcy4NCj4gPiA+IA0KPiA+ID4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0
MjAwMiBrZXJuZWw6ICAgICAgTm90IHRhaW50ZWQgNS41LjcgIzENCj4gPiA+IEFwciAgNyAxMzoz
NDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiAiZWNobyAwID4NCj4gPiA+IC9wcm9jL3N5cy9r
ZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLg0KPiA+
ID4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6IGR0ICAgICAgICAgICAg
ICBEICAgIDANCj4gPiA+IDI0Nzg4DQo+ID4gPiAyNDMyMyAweDAwMDAwMDgwDQo+ID4gPiBBcHIg
IDcgMTM6MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogQ2FsbCBUcmFjZToNCj4gPiA+IEFw
ciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiA/IF9fc2NoZWR1bGUrMHgyY2Ev
MHg2ZTANCj4gPiA+IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBzY2hl
ZHVsZSsweDRhLzB4YjANCj4gPiA+IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2Vy
bmVsOg0KPiA+ID4gc2NoZWR1bGVfcHJlZW1wdF9kaXNhYmxlZCsweGEvMHgxMA0KPiA+ID4gQXBy
ICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6DQo+ID4gPiBfX211dGV4X2xvY2su
aXNyYS4xMSsweDIzMy8weDRlMA0KPiA+ID4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAw
MiBrZXJuZWw6ID8NCj4gPiA+IHN0cm5jcHlfZnJvbV91c2VyKzB4NDcvMHgxNjANCj4gPiA+IEFw
ciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBsb2NrX3JlbmFtZSsweDI4LzB4
ZDANCj4gPiA+IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBkb19yZW5h
bWVhdDIrMHgxZTcvMHg0ZjANCj4gPiA+IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIg
a2VybmVsOg0KPiA+ID4gX194NjRfc3lzX3JlbmFtZSsweDFjLzB4MjANCj4gPiA+IEFwciAgNyAx
MzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBkb19zeXNjYWxsXzY0KzB4NWIvMHgyMDAN
Cj4gPiA+IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOg0KPiA+ID4gZW50
cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQ0KPiA+ID4gQXByICA3IDEzOjM0
OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6IFJJUDogMDAzMzoweDdmNzQ3YTEwYWM3Nw0KPiA+
ID4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6IENvZGU6IEJhZCBSSVAg
dmFsdWUuDQo+ID4gPiBBcHIgIDcgMTM6MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogUlNQ
Og0KPiA+ID4gMDAyYjowMDAwN2Y3NDc5ZjkyOTQ4DQo+ID4gPiBFRkxBR1M6IDAwMDAwMjA2IE9S
SUdfUkFYOiAwMDAwMDAwMDAwMDAwMDUyDQo+ID4gPiBBcHIgIDcgMTM6MzQ6NTMgc2NzcHIxODY1
MTQyMDAyIGtlcm5lbDogUkFYOiBmZmZmZmZmZmZmZmZmZmRhDQo+ID4gPiBSQlg6DQo+ID4gPiAw
MDAwMDAwMDAyMzYwNGMwIFJDWDogMDAwMDdmNzQ3YTEwYWM3Nw0KPiA+ID4gQXByICA3IDEzOjM0
OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4g
UlNJOg0KPiA+ID4gMDAwMDdmNzQ3OWY5NGE4MCBSREk6IDAwMDA3Zjc0NzlmOTZiODANCj4gPiA+
IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBSQlA6IDAwMDAwMDAwMDAw
MDAwMDUNCj4gPiA+IFIwODoNCj4gPiA+IDAwMDA3Zjc0NzlmOWQ3MDAgUjA5OiAwMDAwN2Y3NDc5
ZjlkNzAwDQo+ID4gPiBBcHIgIDcgMTM6MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogUjEw
OiA2NDVmNzI2NTY0NjQ2MTZjDQo+ID4gPiBSMTE6DQo+ID4gPiAwMDAwMDAwMDAwMDAwMjA2IFIx
MjogMDAwMDAwMDAwMDAwMDAwMQ0KPiA+ID4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAw
MiBrZXJuZWw6IFIxMzogMDAwMDdmNzQ3OWY5OGM4MA0KPiA+ID4gUjE0Og0KPiA+ID4gMDAwMDdm
NzQ3OWY5YWQ4MCBSMTU6IDAwMDA3Zjc0NzlmOTRhODANCj4gPiANCj4gPiBJdCBsb29rcyBsaWtl
IHRoZSByZW5hbWUgbG9ja2luZyAoaS5lLiB0YWtpbmcgdGhlIGlub2RlIG11dGV4IG9uDQo+ID4g
dGhlDQo+ID4gc291cmNlIGFuZCB0YXJnZXQgZGlyZWN0b3J5KSBpcyBodW5nLiBUaGF0IGxpa2Vs
eSBpbmRpY2F0ZXMgdGhhdA0KPiA+IHNvbWV0aGluZyBlbHNlIGlzIGxlYWtpbmcgb3IgaG9sZGlu
ZyBvbnRvIG9uZSBvciBtb3JlIG9mIHRoZQ0KPiA+IGRpcmVjdG9yeQ0KPiA+IG11dGV4ZXMuIElz
IHNvbWUgb3RoZXIgdGhyZWFkL3Byb2Nlc3MgcGVyaGFwcyBhbHNvIGh1bmcgb24gdGhlIHNhbWUN
Cj4gPiBkaXJlY3Rvcnk/DQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXBseS4gSSBzZWUgc2V2ZXJh
bCBodW5nIGFwcGxpY2F0aW9uIHByb2Nlc3NlcyB3aXRoDQo+IHRoZSBzYW1lIHN0YWNrLiBRdWVz
dGlvbiBub3cgaXMgdGhlcmUgc29tZSBORlMgcmVuYW1lIHRoYXQncyBtYXliZQ0KPiBoYW5naW5n
IGJlY2F1c2Ugc2VydmVyIGlzbid0IHJlcGx5aW5nIChidXQgSSB3b3VsZCB0aGluayBpbiB0aGF0
IGNhc2UNCj4gSSdkIGdldCBhIHN0YWNrIHdpdGggYSBodW5nIHNvbWV3aGVyZSBpbiBORlMgYW5k
IHRoZXJlIGlzbid0IG9uZSkuDQo+IFRoaXMgaXMgYWxzbyB3aXRoIG5jb25uZWN0IHNvIG5vdCBz
dXJlIGlmIHRoYXQgaGFzIGFueSBlZmZlY3Qgb24NCj4gdGhpcy4NCg0KVGhpcyBpcyBoYXBwZW5p
bmcgb24gdGhlIGNsaWVudCBzaWRlLCByaWdodD8gSSB3b3VsZG4ndCB3b3JyeSB0b28gbXVjaA0K
YWJvdXQgdGhlIGZhY3QgdGhhdCB0aGVzZSBzdGFjayB0cmFjZXMgZW5kIGluIHRoZSBWRlMgbGF5
ZXIuIEl0IG1heQ0Kc3RpbGwgYmUgdHJ5aW5nIHRvIGxvY2sgaW5vZGVzIGZyb20gTkZTLiBIb3dl
dmVyLCB5ZXMsIEkgd291bGQgbm9ybWFsbHkNCmV4cGVjdCB0aGVyZSB0byBiZSBhdCBsZWFzdCBz
b21lIG90aGVyIHByb2Nlc3Mgb3IgdGhyZWFkIHN0dWNrIGluIHRoZQ0KTkZTIGxheWVyLg0KDQpJ
ZiB0aGlzIGlzIE5GU3Y0LCBpcyB0aGVyZSBwZXJoYXBzIGEgcmVjb3ZlcnkgdGhyZWFkIHN0dWNr
IHRyeWluZyB0bw0KcnVuPyBZb3UgbWlnaHQgd2FudCB0byBncmVwIGZvciBuZnM0X2JlZ2luX2Ry
YWluX3Nlc3Npb24gaW4NCi9wcm9jLyovc3RhY2sNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=
