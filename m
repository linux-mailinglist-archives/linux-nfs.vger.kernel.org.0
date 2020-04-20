Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26471B1549
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgDTTCN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Apr 2020 15:02:13 -0400
Received: from mail-bn8nam12on2111.outbound.protection.outlook.com ([40.107.237.111]:55200
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgDTTCN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 20 Apr 2020 15:02:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWSOp+kJCIm0VlEpMLr1tGCZEh0Qg8mwrt/Sw7Mx2tg7ALaIWNVgksNMypygT+wVnky84U3BsK8+bOJ8py7hdhWAdvjJYm1FYUBkZxQ/4hjabRZFqP9TNFeMqHebFCLez8f2by/clbpW6PZS7Y+AGqJfh2hD2BYCGjCclgFUMIIupyP4Q2NDvXOZKRQLcAaHw4xcOhDlbg+FN+VwssDbL9I3xEEVYcFSTHh4wjCXqVGmX79wguVxxLbDk5Yr/c8JDil6zF5VLQOTTXabyXXJO/vzQN/eKTajHM3ggrTJOqk0rd/BBOC3zYyXf4ECp2Tyro7+ZuOu6NMl2uwdtpK9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LymMyk4mQhl8UI4xozMr0MoC+o79haB9mcfGy/HkktY=;
 b=gAyPvYKPDHqHeUSNYV6EyUQ9+hNXdx283FTiFoEoR9cNiHUsxIZPNUFWnBfPGg6CsVbpc9baMXL1HFuftz+Zxq7L0HTNae8DdahISCvbTAVgC1B4Wyye7aXrjvdNYzLx7F9mXzcyUrYWq+MqmMVinQTJS7hL0leKU1+uUQZ+mEaPkDBa5yr1mvuWpEwAoCRObTUAbphlocU37DARaPNRDDgZlMWK0eUWSTn5pNoLFrogSwsv99QpNA3TpAejyXdcV+1Vq9bdtrKSnE+LR86Y0KOgQG6Jev//s4KNwfwCwebJKLAQuYfdDP8RQesNeAAhfLMfU8+Edi1zSVl8vJx3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LymMyk4mQhl8UI4xozMr0MoC+o79haB9mcfGy/HkktY=;
 b=XH/wJhU/bZ3PU0cQk3x8nBLHAWrfD04hCJQW6EK3Xv5sKswohVr6XlWiplMuQMdcB+iVS9+YbIAnIamCigROrJ7taAkd3MtdyG+4svm+vQn/IymW+A3veBvCfbj37ae70/n0Rtz+Dz5XtPmahDYGCdZ9UmrUDVl029GkhDRjYkg=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3367.namprd13.prod.outlook.com (2603:10b6:610:16::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Mon, 20 Apr
 2020 19:02:07 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.011; Mon, 20 Apr 2020
 19:02:07 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Topic: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Index: AQHWFMsRjFm2JNXk8kav0WOkI+SUpah9cM+AgAADbACAAApfgIAAB24AgAAB0wCABIX4AIAAA9IAgAALwoCAAAGUAIAAQ8uA
Date:   Mon, 20 Apr 2020 19:02:07 +0000
Message-ID: <2e691fb93a4b6d362cdfd85feaaa9cfbfc68709c.camel@hammerspace.com>
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
         <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
         <CAN-5tyHQ_Gs-HmWLdbQYz1o8UyB2jv_oD2EtJP94qgtrfeK52Q@mail.gmail.com>
         <7dd1b9300d2a0ec1a31fb3879c62a94f535ccad5.camel@hammerspace.com>
         <CAN-5tyEbi8Z8bxU1enkkhjAyJj-nb9=j33xcLi7FE2+A79-qng@mail.gmail.com>
         <52b65780986192bb635638d4615176bbc1ad579c.camel@hammerspace.com>
         <CAN-5tyFjohv0YQOgtsoxcqL+eUxNXGRZOfd5zOvm_8nCOnJhJg@mail.gmail.com>
         <402396992273d33f880af913134b063819ab1d22.camel@hammerspace.com>
         <CAN-5tyFJQiG6osJ-gW-XHpQZm9SE0oJumRRfTTYkk-dEqDrYcg@mail.gmail.com>
         <CAN-5tyFLusaQbzw2uN9DUtytrWsuQrrYGz44X=Cvj1WS=gD=Hg@mail.gmail.com>
In-Reply-To: <CAN-5tyFLusaQbzw2uN9DUtytrWsuQrrYGz44X=Cvj1WS=gD=Hg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0062dc9-14e0-4fb0-74fe-08d7e55d525a
x-ms-traffictypediagnostic: CH2PR13MB3367:
x-microsoft-antispam-prvs: <CH2PR13MB3367B371227B61F0DE41E7F1B8D40@CH2PR13MB3367.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(136003)(39830400003)(478600001)(26005)(91956017)(2906002)(36756003)(2616005)(6486002)(86362001)(316002)(6916009)(5660300002)(54906003)(66476007)(81156014)(8676002)(66946007)(66556008)(6512007)(53546011)(8936002)(71200400001)(66446008)(6506007)(4326008)(64756008)(76116006)(186003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rTZ7LItaN0kcVRZGcNjrU154rYLZeXRknfixnGE63AAK2YtGvw46NBp5S0682COLSqAKSqB12lOKBqKyrvyMXPx7YvSVyI8oExHdMHvdQxQKufRqMG0r08gpmVYoJyVjindviPhwstiM6+NLXxl9NLE6oFZb0ULHAfic9lDwtgjn9hVreSDdqb4Ompb9BV9XWQCJnEAT34gEWYtV4/pDCnSIy5gjxHtlqEpQzHrYTueC3QSNMGUWKgRy+EcJZ/LCdBaD7qY2+RanP8baXNsyaKmvLJzB/+DHzNbglX8LBsb4KxOj/ZyynW4hBSwypFFmm1cwwMzQ7NNjTTM+XETUtgzEGshvPdEFGfcSst9PPQJeB04GLqu4KScphzgcx87CXcbz0v3E/8opWztwHoPYDpAPFHDMuRkyAPu09JyeyA68Bbv1x3H6RUEckJVwi9a7
x-ms-exchange-antispam-messagedata: GLAEDC1xYuQZCjOFDn8zqlh3/7J39+hSdEp3mfrqzHYnn/8SQpIQ5Xvt/qTdeVHar3OxhDdOcsRT2r7EsvYG/zDlgZNLf6aRjADAA6F9zrz3Kg58Pk3/odKetWpdn5SI7yqRIcKI7x7ZRyhY8BhuX9r5Akoz1TZL1uNtZas3ddCNC0pdwyEZ6brduLjvQ8ZzJUZfXbsx1zLCl9HFekspifkkVCs1WHJjElV6zcGabiKAtvYdFplOZUpH7jNbJmstpwmh/4koBzk6mj2wqTcdrswnbs5YqugkRy3fateQf8NVA6JFjKDWMn2YJhFGy3ysZ3BZILM2IGt/8rRY81dsB/ZW8gQv8h0zhGLTWIFVqQeqMc9xDya2dadDiD5aP+tnS1ixOk5b0730NM2oHCK7hvWA9nBcxZG2yOTnNANXCSfA0idL6cYgfLOiP7RIntno7u5T7NNBcmsz+5VsZSU7MnVpxzRSsvlq9Bq9hMjHsXTKkcpQrIdOa/L1owRYJQ9GdtCq+svnG+57dHLw5OeyTNvczogyORgD/xWAl+N5URHP/wGdy2JhayLsi+CXssyCQp4PZwhvUGISH/r3nAV1RcEjZsm3xj/UmpdDdpOviLBJVuq5cxx3SeZ5Km881MfSTxrkJtWKnlf4Y13ZMWybI7AeS0iX/bBR4vAeBIgFkys0LB9P4tiJM1JndQjZf5C5xJLB8aSi/VTmzpr64TQm3SRmU/pIKJWlI7rgLsVzxUrd89Mpmablme+sBJCPtspFq/gvBiIWxUu4sjkB2HhgpmRc+vpSrLg7H0h8kRWlKDg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E7EF6CA927B024588572B2D01FC3DEC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0062dc9-14e0-4fb0-74fe-08d7e55d525a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 19:02:07.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOGiZBZ47k0wHQHef+IYnag8K36qn0eciHHUz0tczo7CDDYqhJZkmZIvHO7brB2UGuu0EmkErfRd3NZS/zvs4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3367
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDEwOjU5IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gDQo+IA0KPiBPbiBNb24sIEFwciAyMCwgMjAyMCBhdCAxMDo1MyBBTSBPbGdhIEtvcm5p
ZXZza2FpYSA8DQo+IG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+
ID4gWWVzIHdlIGFyZSBjb25zaXN0ZW50IGluIHJlcXVlc3RpbmcgdG8gc2FtZSBjb25uZWN0aW9u
IHRvIHdpdGggdGhlDQo+ID4gc2FtZSBjaGFubmVsIGJpbmRpbmcsIGJ1dCB3ZSBkb24ndCBzZW5k
IEJJTkRfQ09OTl9UT19TRVNTSU9OIGFzIHRoZQ0KPiA+IGZpcnN0IHRoaW5nIG9uIHRoZSAibWFp
biIgY29ubmVjdGlvbiAoaWUgY29ubmVjdGlvbiB0aGF0IGNhcmVkIHRoZQ0KPiA+IENSRUFURV9T
RVNTSU9OIGFuZCB3YXMgYm91bmQgdG8gZm9yZSBhbmQgYmFjayBjaGFubmVsIGJ5IGRlZmF1bHQp
Lg0KPiA+IFdoZW4gdGhhdCBjb25uZWN0aW9uIGlzIHJlc2V0LCB0aGUgZmlyc3QgdGhpbmcgdGhh
dCBoYXBwZW5zIGlzIHRoZQ0KPiA+IGNsaWVudCByZS1zZW5kcyB0aGUgb3BlcmF0aW9uIHRoYXQg
d2FzIG5vdCByZXBsaWVkIHRvLiBUaGF0IGhhcyBhDQo+ID4gU0VRVUVOQ0UgYW5kIGJ5IHRoZSBy
dWxlIHRoZSBzZXJ2ZXIgYmluZHMgdGhhdCBjb25uZWN0aW9uIHRvIHRoZQ0KPiA+IGZvcmUgY2hh
bm5lbCBvbmx5IChhbmQgc2V0cyB0aGUgY2FsbGJhY2sgYmVpbmcgZG93bikuIFdlIHRoZW4gc2Vu
ZA0KPiA+IEJJTkRfQ09OTl9UT19TRVNTSU9OIGFuZCByZXF1ZXN0IEZPUkVfT1JfQk9USCB3aGVy
ZSB0aGlzIGhhcw0KPiA+IGFscmVhZHkgYmVlbiBib3VuZCB0byBGT1JFIG9ubHkuDQo+ID4gDQo+
IA0KPiANCj4gSG93IGFib3V0IHRoaXM6IGJlZm9yZSB3ZSBzZW5kIEJJTkRfQ09OTl9UT19TRVNT
SU9OIHdpdGgNCj4gZm9yZV9vcl9ib3RoLCB3ZSBzb21laG93IGFsd2F5cyByZXNldCB0aGUgY29u
bmVjdGlvbiAobWF5YmUgeW91IHdlcmUNCj4gc3VnZ2VzdGlvbiB0aGF0IGFscmVhZHkgYW5kIGkg
d2Fzbid0IGZvbGxvd2luZykuDQoNCk5vLiBJIGRpZG4ndCByZWFsaXNlIHRoYXQgd2Ugd2VyZSBi
ZWluZyBhdXRvbWF0aWNhbGx5IHNldCB0byBqdXN0IHRoZQ0KZm9yZSBjaGFubmVsLiBIb3dldmVy
IGFzIEkgc2FpZCBlYXJsaWVyLCB0aGUgc3BlYyBzYXlzIHRoYXQgdGhlIHNlcnZlcg0KTVVTVCBy
ZXBseSB3aXRoIE5GUzRFUlJfSU5WQUwgaW4gdGhpcyBjYXNlLiBJdCBpcyBub3QgYWxsb3dlZCB0
byBqdXN0DQpyZXR1cm4gTkZTNF9PSyBhbmQgc2lsZW50bHkgc2V0IHRoZSB3cm9uZyBjaGFubmVs
IGJpbmRpbmcuDQoNCk9uIHRoZSBjbGllbnQgd2Ugc2hvdWxkIHByb2JhYmx5IGRvIHNvbWV0aGlu
ZyB0byB0cmFjayB3aGV0aGVyIG9yIG5vdA0KdGhlIGJhY2tjaGFubmVsIGhhcyBiZWVuIGxvc3Qg
ZHVlIHRvIGNvbm5lY3Rpb24gYnJlYWthZ2UuIFdlIHByb2JhYmx5DQpuZWVkIHRvIGFsbG93IHRo
ZSBjbGllbnQgdG8gY2hlY2sgdGhlIHhwcnQtPmNvbm5lY3RfY29va2llIHRvIGZpbmQgb3V0DQpp
ZiB0aGUgY29ubmVjdGlvbiBicm9rZS4NCg0KPiBpIGRvbid0IHRoaW5rIHRoaXMgaXMgZ29pbmcg
dG8gdGhlIGxpc3QgYXMgaSdtIGdldHRpbmcgYXV0bw0KPiByZWplY3Rpb25zIGVtYWlscyBidXQg
aSBkb24ndCBrbm93IGhvdyB0byBmaXggaXQuDQoNCllvdSBuZWVkIHRvIHR1cm4gb2ZmIEhUTUwg
bWFpbC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
