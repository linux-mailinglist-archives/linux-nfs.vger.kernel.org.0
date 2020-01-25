Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6103B14977B
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Jan 2020 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgAYTg7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 25 Jan 2020 14:36:59 -0500
Received: from mail-bn7nam10on2120.outbound.protection.outlook.com ([40.107.92.120]:50336
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgAYTg6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 25 Jan 2020 14:36:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+zgBi7O0vhP0zT6RWo0dLs9ycJzGFOFNI6nZ1sQbht5kaY2TL3U20hevYlnY84k8dw6OiR4ffkb3skoU2P7capdOI4zB0K0J3BU/dAJbbY+NOaeETvuZL6ryhd6hZb2I+buGs5+mZQ0FL4z5L8IdYiyl57ExwePBFRPPtRYJtg2FAj9ZlIEVogg3tcdZEsZlM9pztJP4XQ7EFBicxlNuMu8nqPTbr8f9DbxcUl61nIaPRRczSDcfViUKWn7Bl2wrv5l6PcjK7SE7xs/9pYVXvOerbS2dt7VF7aV/hODTnVmwDScOA62Sz+0aq2gP6IkdrnlnLdmS+ruubrPE3ltIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie4I0QtOm+9GIKImRgMcG4MCLLucaYri+u+TufW6nIs=;
 b=Hb3utnp6//7Q02+Dlu+5qDVBM3mSYEb0lQnR14bUeqxoIwMTr1vFoiWlc0RREBwGpFPofZBnNozCpOQYi6gG8xXF38+8VzggNFIBm/SX5lI3AuIm6/Husx1+JAWHDHxtkLEeJoZmNj5Q8jC+VuwWBcsTAZI3qCQg+u/GMPzG7w+2OtqlqDowjXIofLIbJQOLrg2i9fxC9xeNHPc2BPb0SwTb+z+jOLIwcJR7SLyE5H2SZIzXKLroOCGkgjhQlS2nX1vQhRLgvG9gwYYvteDh0YnGntU/eI3y9e/1CGI0EC+rf39NqBRTsO206A8es804ZZ7b3CK2WWnyaigrLbLgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie4I0QtOm+9GIKImRgMcG4MCLLucaYri+u+TufW6nIs=;
 b=Ufx/kpshBEUOzhtReZj3UFusyXBhfKyFXjENNKmu4mcdyLVJKk7dk4GnN4k2LBG+OedMnFpaIcBzzvqWhhsuyOfegIQs2NSkWY9fwr3wpAthj9i5hf3t+3DY498ZNBxFJupT4FsMD484dFb+vw3vFIIIF14J45Ro27mZmfy2VDc=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2060.namprd13.prod.outlook.com (10.174.186.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.14; Sat, 25 Jan 2020 19:36:54 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2686.018; Sat, 25 Jan 2020
 19:36:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH] NFS: Revalidate once when holding a delegation
Thread-Topic: [PATCH] NFS: Revalidate once when holding a delegation
Thread-Index: AQHV0r/sgnCq9BoGhE2W4paUJOMO4qf6MmyAgABm8YCAAS60AA==
Date:   Sat, 25 Jan 2020 19:36:53 +0000
Message-ID: <859c878cb9c645de0950fae54e59f8c528b54b9e.camel@hammerspace.com>
References: <c65905b1e2fdaddc6271cbf510d7e30c8790de63.1579874894.git.bcodding@redhat.com>
         <ab9d72c908d5c3cecc53ec049572a7675ad12072.camel@hammerspace.com>
         <43817735-6694-406C-A66A-485A716C7FC5@redhat.com>
In-Reply-To: <43817735-6694-406C-A66A-485A716C7FC5@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [8.46.76.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8804b048-c641-45c7-8d37-08d7a1cdeeae
x-ms-traffictypediagnostic: DM5PR1301MB2060:
x-microsoft-antispam-prvs: <DM5PR1301MB20601A898E8A97870AAD5960B8090@DM5PR1301MB2060.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(199004)(189003)(81156014)(81166006)(36756003)(8676002)(64756008)(66556008)(66446008)(66946007)(66476007)(6512007)(508600001)(76116006)(91956017)(2616005)(186003)(2906002)(6486002)(26005)(54906003)(53546011)(5660300002)(8936002)(6506007)(4326008)(86362001)(6916009)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2060;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OZ2fH6fEUQxpa9BEx8yn++8PUKGJbXDcAN/jBmZfUAzuKaG+RCPXgna75+l4fqAvzoh7zaa/j3nPoGYD5wW5zyWEDbowHA7l+M1qT8rRj3GMxEqJbE4xCT/df+RUtt6CQxRQ8Rzybv95R8u3DhvfalADrtkoqJC8+6be1dsRTBS+ja24dhqi0TSeTBeMXTNndkrhAVIZJFrbBCh1UCLxo7XVA6WO8u39kMj6rQFXuqHsWkidv7ApuftNzpyi2NDLOScXVAeHA3rk5fPZBW2GE/pOkgJyzrbykEJLHrlx56IV9YSJj8RNzmVuDFkrmlRpzFUPbHPc6veJsaRDdXsUxW9Tb24PKnKxrBDBZRBHDnjgIzoP0fztts65sZx/lzmSRvyBzGaZr1Xci3Dy1yd3RnEPn2U9ZNFxDW/TltgEqHrvzpiTm8By6jy0O4CaDLTN
x-ms-exchange-antispam-messagedata: ITd+OrF57Qf+NbfQZQnOLnKhLSnh84135tDxNZZcMYgzw/j9qtL7kQqFv2Qzo4hvCqj/g0o18eJegLjrSiB0UsYyVDnIbUr2Skeng1BR+u6h0MzwMYygdtqRX5ghFEX9u81DDnRCW+KwtUHpmTPqWw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD8016429CAAD343B1D63B8373E82487@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8804b048-c641-45c7-8d37-08d7a1cdeeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 19:36:53.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTZYWSnwKdktvHCVl6+VAByE70bzgXrpei+noLjFGPhB9DMGNI16OjOTnE1cTOZ+GZFX+uiFwh5HbGs6Qi+o+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2060
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTI0IGF0IDIwOjMzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiAyNCBKYW4gMjAyMCwgYXQgMTQ6MjQsIFRyb25kIE15a2xlYnVzdCB3cm90ZToN
Cj4gDQo+ID4gT24gRnJpLCAyMDIwLTAxLTI0IGF0IDA5OjA5IC0wNTAwLCBCZW5qYW1pbiBDb2Rk
aW5ndG9uIHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggbmVlZHMgdG8gZml4IG5mc19mb3Jj
ZV9sb29rdXBfcmV2YWxpZGF0ZSgpIHRvIGF2b2lkIHRoZQ0KPiA+IHZhbHVlIE5GU19ERUxFR0FU
SU9OX1ZFUkYuDQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5LiAgRG9lc24ndCBuZnNfZm9y
Y2VfbG9va3VwX3JldmFsaWRhdGUoKSBqdXN0DQo+IGJ1bXAgdGhlDQo+IGRpcmVjdG9yeSdzIGNh
Y2hlX2NoYW5nZV9hdHRyaWJ1dGUsIHdoaWNoIGlzIHZhbHVlIHdlIGRvbid0IGNhcmUNCj4gYWJv
dXQgYXQNCj4gYWxsIGhlcmUuICBUaGlzIHBhdGNoIGp1c3Qgc2V0cyBhIG1hZ2ljIHZhbHVlIG9u
IHRoZSBkZW50cnkncyBkX3RpbWUNCj4gYWZ0ZXIgYQ0KPiByZXZhbGlkYXRpb24gb2NjdXJzIGZv
ciB0aGF0IGRlbnRyeSB3aGlsZSBob2xkaW5nIGEgZGVsZWdhdGlvbi4gIEl0DQo+IGRvZXNuJ3QN
Cj4gY2FyZSBhdCBhbGwgYWJvdXQgdGhlIGRpcmVjdG9yeSdzIGNoYW5nZV9hdHRyLg0KPiANCj4g
V2hhdCBhbSBJIG1pc3Npbmc/DQoNClRob3NlIGNhbGxzIHRvIG5mc19zZXRfdmVyaWZpZXIoZGVu
dHJ5LCBuZnNfc2F2ZV9jaGFuZ2VfYXR0cmlidXRlKGRpcikpDQphcmUgc3RvcmluZyB0aGUgcGFy
ZW50IGRpcmVjdG9yeSBjYWNoZV9jaGFuZ2VfYXR0cmlidXRlKCkgaW4gdGhlIGRfdGltZQ0KZmll
bGQgb2YgdGhlIGNoaWxkIGRlbnRyeS4gVGhhdCdzIHRoZSBub3JtYWwgdmFsdWUgZm9yIHRoZSBj
aGlsZCBkZW50cnkNCnZlcmlmaWVycyBvZiB0aGF0IGRpcmVjdG9yeSB3aGVuIHRoZXJlIGlzIG5v
IGRlbGVnYXRpb24uDQoNClNvIHRvIGF2b2lkIGNvbGxpc2lvbnMsIHlvdSBuZWVkIHRvIGVuc3Vy
ZSB0aGF0IGRpci0NCj5jYWNoZV9jaGFuZ2VfYXR0cmlidXRlIG5ldmVyIHRha2VzIHRoZSB2YWx1
ZSBORlNfREVMRUdBVElPTl9WRVJGLg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
