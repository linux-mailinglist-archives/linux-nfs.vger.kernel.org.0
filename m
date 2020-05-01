Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA431C0D12
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 06:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEAEIt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 00:08:49 -0400
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:28328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbgEAEIs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 May 2020 00:08:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPCM69TCFVG54GFQwBWCBLHDd6Va4X9F65RrVhVpeOk7orq0Xr0FrA+perLfpdSonw5v5AkE5CJjvlyRAF9G2pg3x0S4hB81cI0H8K2u/CVrAzxGc3TiXrLf9PsHTaQ5fQ/0Oz/rNurQURnk9MeFcjvZZmOg2y31sbpq5PDPewAmjeHAw831kQ0VE80b/U1bFAciFLcklfX9HXE76pOoJgJJk2MFApLK31coKIV9vbvRIBTglpwb+AVYvf2bVAXnIVaH4ZbXrtfXaKqc0U0MVBEaeuTWDfdGU9okkLGSRcH+Zhq8lQirs7lOKjscwNK8mrs5slNkUAKbPaT8zxiWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihLsbsy/rbosJ55tyuBWcZoZsw5yOmXyOjNjbp2Sk4s=;
 b=HLXlta6sVnBCkaGEVSOLnl3YEPdm/9V6YDhJF4wVkWK9hHzEF++gtwwcC4YMKdYowIzC0M5BPP5uF/6kYLzeK22NNFgeUuFcLAN4Wx5qeMerVj29IrI4ttN8QLY5H0I4oqgSo1pynulU+Wf7zAEyBdrFqk0G2vTzyWWNKoRgRRSaFa9IjL3gQOnaKq6E09YAFd2zL9w1pJdttj14J7zVzjHfptNU9orNF7rBjDuVnV5lkHWSSSRNt7ZgUgEk0jUmi8EpBrk3Cs3stKpLslG9FLVaxO8S1SdtxzfO1HaHbTnWwlVerLkCqd3c4xNwAMG1GRzcj19gtceyVhpckf0T8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihLsbsy/rbosJ55tyuBWcZoZsw5yOmXyOjNjbp2Sk4s=;
 b=DClaiLimtoi1/fwvm0Ta/176MY4MsRjJcoeolA6QtWMD2jOtGYH0TcM+nven5EIhQVNV90UWnNwJM5iUbQ+uCyq0+2s65QW8zPjV2SfprLbDvc+rbwbZkuoA5D7OUckuDqOBw0dvOlQwb/qB54NVMXyE4H+cuyBRFKlnqg1gIiI=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3543.namprd13.prod.outlook.com (2603:10b6:610:2b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.16; Fri, 1 May
 2020 04:08:45 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.020; Fri, 1 May 2020
 04:08:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tom@talpey.com" <tom@talpey.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Thread-Topic: handling ERR_SERVERFAULT on RESTOREFH
Thread-Index: AQHWHYjzjBZLlmadoEGcRGdAsbmgTaiO38OAgAAfvACAAA5TAIAAGV4AgAAK7wCAAAQAgIAAJhOAgADjeACAAAn1AIACNWSAgAAiUoA=
Date:   Fri, 1 May 2020 04:08:45 +0000
Message-ID: <8f4e19727d17d85b0cd1886ab40e672bb7826171.camel@hammerspace.com>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
         <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
         <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
         <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
         <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
         <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
         <8549f1fc955faedc35d810a4ad3e21904379a59a.camel@hammerspace.com>
         <CAN-5tyFRDg7W9pt57jTzoRgL8L=0_d7gCoRiAqWQR36iny33NQ@mail.gmail.com>
         <20200429154638.GB4799@fieldses.org>
         <CAN-5tyE7i3qxv7WyrAZkq2VCFrh1Kw4Q1eonG2Ep_YLFkMiJwQ@mail.gmail.com>
         <0e626cd6-deca-14e7-3b9a-3218c4962e63@talpey.com>
In-Reply-To: <0e626cd6-deca-14e7-3b9a-3218c4962e63@talpey.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33f1bed0-9d17-4df1-c3ac-08d7ed85579a
x-ms-traffictypediagnostic: CH2PR13MB3543:
x-microsoft-antispam-prvs: <CH2PR13MB35437D62986C953F29594187B8AB0@CH2PR13MB3543.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0390DB4BDA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMDIlQbtks5rV3tot/ph0KPbQ2uMDjI4GPePPI8sqMeGer5C5fP9uC6femS9SvXHB/63pWRsGqVlE+7PSl8mhhfKQEZTQHylqpcidYo3bBymnyTTPzV8LY+YaV56E/BJwhYXd9SX7PSsf4k+sM9MRfIOIvgxolUbPiFn2BGSfA5OnAzo2b0Guom5+2+/688OFh5wByvUYgIpWvDAH5PAAsMdArV8NBDLCD1pL2aYM49JINMS7OwBqtecUeqWyVpHfbL9U9EYP4ExlS2/jCjIoiyOfQ6Z3ACOeG9FfMiV/mniyM3JOtoxdP6WErZu3WEzfoi3eTWZKM35TnWVwr1l0QJVDNsWZ5ft3tJ3DkFcfbpdFrfPbKMIDiBrHy6V5VcbWJGSsHdNHbSl1G99NXLck4xVtwtRaaw03xksYAS0Q0mJhX/s39Uo4PHI5MwTgGkG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(136003)(39830400003)(376002)(4326008)(91956017)(2906002)(316002)(66946007)(66556008)(76116006)(6512007)(478600001)(5660300002)(2616005)(186003)(26005)(53546011)(6506007)(66476007)(66446008)(64756008)(6486002)(110136005)(8676002)(86362001)(8936002)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3evOp5uncMj9Pd+LiELK4N5Fb8srHZTCI60bGGVvHr7PcXVg5K05k8mI6lqOeK1V+XtejdIYm7MoC8PkKMd3UuSBB3Vd3pJ1A2hiZV4w2HlTt2B55LO2n3pWXFlQZCWmG/4D1UuQ98upVXaEbcFF/avdnwCW90E+1N7Lhhp9sTF2NAs1cZvUNjifscj54WHldo5rQxhocFRTAz1eLQb6gNmvjhoW62RFQ7wPTpBYyeHXFRP1cR1dsp6T2iBeOrtMc8C+yHuSyjh8GSbMEHqOMa0mhsegyD3zOssM98ygTg90RJG9eEP0c4qWoPD6zurnwrRU1BVA71hmfWp0D7wfrO40gPiQKF/ilkBiSip+kxfFvz7WE4zdZVuudbHq7wFETvlnYf5pRS1IFHogpqgC5AOcLA6+Lj38ZEVb3cgMuxTO2nr4xEypQD1JyBqwxi68Ahr8QV+2mMY2IjGbvDnMqff/aSzRjGveoF2XX+98wsASR2Co28gpaw2LX8e7SoSPAdLTLMVCGUZYiJlOd6t3gh55QEFyM/G4fk0ci8ZWKtk0egg7SYScIFYWzzckfEuieUSVmRlHDMj15ENIDTCwh9Wq1/ub+htx67wLncbZszyrFSTgGEI3i968Z3Rg6TBl+vxqxDtGq/gs2RNAHPtwt8A43CF9td+mcHVuZdw2sOr446uscGUBbcBjRobtjsODSCzVfJECpJiNlSWmaKNViI7WHFSPanelaUyGIsNKbE8KrLh1aacXIqi1wZ/ZN6mDHYSHyEdK5nxCNDN3ZxPNxZ0MVtx4328sHoeBCDxlPKU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B42E0F3CEFE0D54BB7CC88A13F3F56DF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f1bed0-9d17-4df1-c3ac-08d7ed85579a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 04:08:45.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62Clo9N/3mNnnN/ulAo86p21ep6PQ798diG1n14cN/n0lRvZdd24KxwMBM6TB+Yoj8bChoThvPCeGfbeNEak7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3543
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTMwIGF0IDIyOjA1IC0wNDAwLCBUb20gVGFscGV5IHdyb3RlOg0KPiBP
biA0LzI5LzIwMjAgMTI6MjIgUE0sIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+IE9uIFdl
ZCwgQXByIDI5LCAyMDIwIGF0IDExOjQ2IEFNIEouIEJydWNlIEZpZWxkcyA8DQo+ID4gYmZpZWxk
c0BmaWVsZHNlcy5vcmc+IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMTA6
MTI6MjlQTSAtMDQwMCwgT2xnYSBLb3JuaWV2c2thaWENCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBJ
IGFsc28gYmVsaWV2ZSB0aGF0IGNsaWVudCBzaG91bGRuJ3QgYmUgY29kZWQgdG8gYSBicm9rZW4N
Cj4gPiA+ID4gc2VydmVyLiBCdXQNCj4gPiA+ID4gaW4gc29tZSBvZiB0aG9zZSBjYXNlcywgdGhl
IGNsaWVudCBpcyBub3Qgc3BlYyBjb21wbGlhbnQsIGhvdw0KPiA+ID4gPiBpcyB0aGF0DQo+ID4g
PiA+IGEgc2VydmVyIGJ1Zz8gVGhlIGNhc2Ugb2YgU0VSVkVSRkFVTFQgb2YgUkVTVE9SRUZIIEkn
bSBub3Qgc3VyZQ0KPiA+ID4gPiB3aGF0DQo+ID4gPiA+IHRvIG1ha2Ugb2YgaXQuIEkgdGhpbmsg
aXQncyBtb3JlIG9mIGEgc3BlYyBmYWlsdXJlIHRvIGFkZHJlc3MuDQo+ID4gPiA+IEl0DQo+ID4g
PiA+IHNlZW1zIHRoYXQgc2VydmVyIGlzbid0IGFsbG93ZWQgdG8gZmFpbCBhZnRlciBleGVjdXRp
bmcgYQ0KPiA+ID4gPiBub24taWRlbXBvdGVudCBvcGVyYXRpb24gYnV0IHRoYXQncyBhIGhhcmQg
cmVxdWlyZW1lbnQuIEkgc3RpbGwNCj4gPiA+ID4gdGhpbmsNCj4gPiA+ID4gdGhhdCBjbGllbnQn
cyBiZXN0IHNldCBvZiBhY3Rpb24gaXMgdG8gaWdub3JlIGVycm9ycyBvbg0KPiA+ID4gPiBSRVNU
T1JFRkguDQo+ID4gPiANCj4gPiA+IE1heWJlLiAgQnV0IGhvdyBpcyBhIHNlcnZlciBoaXR0aW5n
IFNFUlZFUkZBVUxUIG9uIFJFU1RPUkVGSCwNCj4gPiA+IGFueXdheT8NCj4gPiA+IFRoYXQncyBw
cmV0dHkgd2VpcmQuDQo+ID4gDQo+ID4gQW4gZXhhbXBsZSBlcnJvciBpcyBFTk9NRU0uIEEgc2Vy
dmVyIGlzIGRvaW5nIG9wZXJhdGlvbnMgdG8gbG9va3VwDQo+ID4gdGhlDQo+ID4gZmlsZWhhbmRs
ZSAoZHVlIHRvIGl0IGJlaW5nIHNvbWUgb3RoZXIgcGxhY2UpIGFuZCBuZWVkcyB0byBhbGxvY2F0
ZQ0KPiA+IG1lbW9yeS4gSXQncyBwb3NzaWJsZSB0aGF0IHJlc291cmNlcyBhcmUgY3VycmVudGx5
IHVuYXZhaWxhYmxlLg0KPiA+IFNpbmNlDQo+ID4gUkVTVE9SRUZIIGRvZXNuJ3QgYWxsb3cgRURF
TEFZLCBzZXJ2ZXIgY2FuIG9ubHkgcmV0dXJuIFNFUlZFUkZBVUxULg0KPiANCj4gV2h5IGRvZXMg
dGhlIHNlcnZlciBuZWVkIHRvIGRvIHRoYXQ/IFN1cmVseSBpdCBjYW4gYmVzdCBrbm93IGhvdyBh
bmQNCj4gd2hlbiB0byByZXNjaGVkdWxlIGEgbWVtb3J5IGFsbG9jYXRpb24sIGluc3RlYWQgb2Yg
d2hpbmluZyBhYm91dCBpdHMNCj4gdGVtcG9yYXJ5IGZhaWx1cmUgdG8gdGhlIGNsaWVudC4NCj4g
DQo+ID4gQnV0IGFzIEkgbWVudGlvbmVkIGJlZm9yZSwgZXZlbiBpZiBFREVMQVkgd2FzIGFsbG93
ZWQsIGNsaWVudCBvbmx5DQo+ID4gcmVzZW5kcyB0aGUgd2hvbGUgY29tcG91bmQgd2hpY2ggaXMg
aW5jb3JyZWN0IGluIGNhc2Ugb2YNCj4gPiBub24taWRlbXBvdGVudCBvcGVyYXRpb25zLg0KPiAN
Cj4gSW5kZWVkLCB0aGF0J3MgYSBwcm90b2NvbCBpbXBlcmF0aXZlLCB3aGljaCB0aGUgY2xpZW50
IHNob3VsZCBvYmV5DQo+IGJ5ICJjcmFja2luZyIgdGhlIGNvbXBvdW5kIHRvIGRldGVybWluZSB3
aGF0IHRvIHJldHJ5Lg0KDQoNClJGQzU2NjE6DQoNCjE1LjEuMS42LiAgTkZTNEVSUl9TRVJWRVJG
QVVMVCAoRXJyb3IgQ29kZSAxMDAwNikNCg0KICAgQW4gZXJyb3Igb2NjdXJyZWQgb24gdGhlIHNl
cnZlciB0aGF0IGRvZXMgbm90IG1hcCB0byBhbnkgb2YgdGhlDQogICBzcGVjaWZpYyBsZWdhbCBO
RlN2NC4xIHByb3RvY29sIGVycm9yIHZhbHVlcy4gIFRoZSBjbGllbnQgc2hvdWxkDQogICB0cmFu
c2xhdGUgdGhpcyBpbnRvIGFuIGFwcHJvcHJpYXRlIGVycm9yLiAgVU5JWCBjbGllbnRzIG1heSBj
aG9vc2UNCnRvDQogICB0cmFuc2xhdGUgdGhpcyB0byBFSU8uDQoNCg0KV2hpY2ggSSBiZWxpZXZl
IGlzIHdoYXQgd2UgZG8uIEFzIEkgc2FpZCwgdGhpcyBpcyBhIHNlcnZlciBidWcgdGhhdA0KbmVl
ZHMgdG8gYmUgZml4ZWQgb24gdGhlIHNlcnZlciBhbmQgSSBzZWUgbm8gbmVlZCB0byBjaGFuZ2Ug
dGhlIGNsaWVudA0KYmVoYXZpb3VyIGZvciBub3cuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
