Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20D1BD0AA
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 01:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1XmB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 19:42:01 -0400
Received: from mail-dm6nam10on2120.outbound.protection.outlook.com ([40.107.93.120]:48096
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbgD1XmA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Apr 2020 19:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNjqTX0XOIdPEDl0R7AXNpnjvz9dQV9hQCRQBD3MbIkdNGYtmeUlV6tWL1Q7vLp2/Kb3PQTDLrUUkvsSsLkdAEVhDs0c1C7BqJ6sf5nk5euLSr3H3zo5Xd0RREnyqddyR++uZ9/s+Vhqws2SIarxkkwAJtKdKuXONOWPj2jy469ZdBm0gnpzrM8Qje3Skdd/OE4T999TWNFuRpo4m1yuxqCgqskHFKKo8S2RPsdUA93UwqJmEyLqp77NwirhDB5Unlgh81HxpI3wNBcTLnanh5gjQ1YBDo4IVPAcUnR3OCBKgQBH/IQLrbdFjx87ZqicUSn27jYRpziR5STKbTc0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/yzCpMHyEtwm8Y+n+LrqnYC/e2jNxitV5JZY2PXq7w=;
 b=kPIXJHXd0xHLHCem7I1wDCy1vRqIKvU8u2S/vSiNqhLLXin8Vpve6S6owspvkCnAVNOgKSmjX/3P6Tc7WI9daLhIiIcyxABXKC5ZMDuCP08/WzDFxt1ph2VwiMQJd1IXKJEDln/167Dg4QO7qGZKljoXc1Jsx2oWptQzo81P9sCV0ypq844kMJ+heLZDX/hPkh17F2DqQwxnKcKK9AB8dqp9pNzg5ZoslyTD4xZta2O7RogFw6wbO5Lj+X9wwUBlnBWLUhE+UKM18y+WxhK3S43G1PIJjHSBzglI3l8ABxfGq1LsNSGj9rVrgLyUjOqTG//M2MLjsq6itTixB8KFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/yzCpMHyEtwm8Y+n+LrqnYC/e2jNxitV5JZY2PXq7w=;
 b=VwVpAqaL1kvANma90KVfOKrzwQU3D9RPfVqopoEEoJnfl++w151d+WrOxnUxKrRNGRk9NhOhlSS6MtJk34gCTUBq0wn7UD2zjH1COFyp2nUJT7xgHuLjdKPsN6SIBq0/bDwXRqlmrchCbXeKC8oC2kVUueisP2QLRmoA8UfLtso=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3606.namprd13.prod.outlook.com (2603:10b6:610:2e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Tue, 28 Apr
 2020 23:41:56 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 23:41:56 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Thread-Topic: handling ERR_SERVERFAULT on RESTOREFH
Thread-Index: AQHWHYjzjBZLlmadoEGcRGdAsbmgTaiO38OAgAAfvACAAA5TAIAAGV4AgAAK7wA=
Date:   Tue, 28 Apr 2020 23:41:56 +0000
Message-ID: <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
         <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
         <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
         <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
         <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
In-Reply-To: <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 091077e1-dfd7-4d69-896a-08d7ebcdbccc
x-ms-traffictypediagnostic: CH2PR13MB3606:
x-microsoft-antispam-prvs: <CH2PR13MB3606AD74E1DA3E869725E520B8AC0@CH2PR13MB3606.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0387D64A71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pFiYaSi6sCeNxJsfDiKawuR0sRki7dJwsn6I0SSjIipUw0CfX3PPoYh68Rw1wlCIJXjX7RoLnT7W1pUCGsv9yVTmkh9ge/5bxuhKTdeJfWSAATdWwIpp65eHVbZ9GrIAzD+vAFZmUngVObGuUw3ZFJEdM9Pfi9tD002EBAHUnnMlEbiKDKynO5KD1cfT4AcbMuOJt6Y0sO3ILDWhCb32kRnCdqA62rH+1J/K9ihhbZf9+ruyoPJ0Bos5eBdQDCGZ636jr03/a2/i5GoyYdVt/Aj5YeIpRj1A5qH7pRwtQhlLN4VB3o80sNoLoJ4B3jHQkIcA5Nmp2/MMgKkLxliSNmrzaTH+BiJgf4zC9Do5H4fGhXyvLSqUcMYejvzQLMIlZao1qyaKC1Iy8UFUW3ZIR6MeNi6wvR36lNFL9IXpKRN2BUQzlA/ZrXs0mwS1Wqv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(376002)(396003)(39830400003)(136003)(6512007)(2906002)(6486002)(316002)(71200400001)(86362001)(36756003)(8676002)(2616005)(6916009)(6506007)(53546011)(76116006)(4326008)(66446008)(8936002)(26005)(5660300002)(66946007)(91956017)(186003)(66556008)(64756008)(66476007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bUb14cnYseV4D6NIoip/HS5CncURTAR4COqlXOEAgyCGjX5lJUPWAkyMkduoSTRKOcUTz0Ypf7twNXo9QZ6K0l8lJ5+kAeFjQTXad4qtTHq6gSJAY3sM7BW7QPjKj340u3UHPgkJSZ8EyyFQ9Ky6txtIGBpI3NJR0uR3v5zGUgpZFLeASFmESMklvTbNpYaYDt3suBYTwiCOqndcODIa2iBiZXVzQ9cbBm9701IYHvWfYYceuiusFUCYfLaTfxIsznyx22LS8CtjmqmgOr1bDHEFdHg01IPXJtW6LU6BKtsSA6KyttJjfAujIWnvRFF3junvb1M2KTlrqECsrCaJAn8MlBenVynjZpYUNuDyhTGSu9+jWtdBow61NlzqLw514u/CQSv5nAnJvfVUgLRsuRHrWWwT5W440eUwoRQQsEL8Pd6NHenxqJUsLhLKoFUwZctayX88ZigzaKiCAo0p2wbUj88OwQoYROXNfeVye4lnQGH12liXOq166xwO2y8MLDM1qDDkyZd8gBQA7KRahnm+YZUBvnPhmKqxH5N5S9nKOsY3z2JalFo0pzrFCu6Jgiv4OljuNYwdd9a0aONX3v48hIESYyRWeLubuyX3BVTly6Yv0X0jb3zoD52X6i+JwJarxmgt/7Fj0UFbPHOJxQYdwnFFxiXIZgnOMJ4RWIyM6kaTC/pnN1uzJlbJssj50UxAGnViG3Ky+u/HIOwx+l69QCyCQhiuynSWdYMeduv/QToRqtiTygdy4w8hi0ac2HON4A3g7wapi2xhTqwzcuA4xYC0OvHAM2iIPU/D/U0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCB878378D63624383A0CFAA9DD388B2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091077e1-dfd7-4d69-896a-08d7ebcdbccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 23:41:56.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwpyIQWYSZSHefAAnwmJ58z31PIMt/GlAP0omoi3321bPsxkYeftqnvNSjSKYXuw04EN/iRA637FjqkYt8jU6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3606
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTI4IGF0IDE5OjAyIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgNTozMiBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTA0LTI4
IGF0IDE2OjQwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IE9uIFR1ZSwg
QXByIDI4LCAyMDIwIGF0IDI6NDcgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+IHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gSGkgT2xnYSwNCj4gPiA+ID4gDQo+ID4g
PiA+IE9uIFR1ZSwgMjAyMC0wNC0yOCBhdCAxNDoxNCAtMDQwMCwgT2xnYSBLb3JuaWV2c2thaWEg
d3JvdGU6DQo+ID4gPiA+ID4gSGkgZm9saywNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBMb29raW5n
IGZvciBndWlkYW5jZSBvbiB3aGF0IGZvbGtzIHRoaW5rLiBBIGNsaWVudCBpcyBzZW5kaW5nDQo+
ID4gPiA+ID4gYQ0KPiA+ID4gPiA+IExJTksNCj4gPiA+ID4gPiBvcGVyYXRpb24gdG8gdGhlIHNl
cnZlci4gVGhpcyBjb21wb3VuZCBhZnRlciB0aGUgTElOSyBoYXMNCj4gPiA+ID4gPiBSRVNUT1JF
RkgNCj4gPiA+ID4gPiBhbmQgR0VUQVRUUi4gU2VydmVyIHJldHVybnMgU0VSVkVSX0ZBVUxUIHRv
IG9uIFJFU1RPUkVGSC4gQnV0DQo+ID4gPiA+ID4gTElOSyBpcw0KPiA+ID4gPiA+IGRvbmUgc3Vj
Y2Vzc2Z1bGx5LiBDbGllbnQgc3RpbGwgZmFpbHMgdGhlIHN5c3RlbSBjYWxsIHdpdGgNCj4gPiA+
ID4gPiBFSU8uDQo+ID4gPiA+ID4gV2UNCj4gPiA+ID4gPiBoYXZlIGEgaGFyZGxpbmUgYW5kICJs
biIgc2F5aW5nIGhhcmRsaW5rIGZhaWxlZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaG91bGQg
dGhlIGNsaWVudCBub3QgZmFpbCB0aGUgc3lzdGVtIGNhbGwgaW4gdGhpcyBjYXNlPyBUaGUNCj4g
PiA+ID4gPiBmYWN0DQo+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+IHdlIGNvdWxkbid0IGdldCB1
cC10by1kYXRlIGF0dHJpYnV0ZXMgZG9uJ3Qgc2VlbSBsaWtlIHRoZQ0KPiA+ID4gPiA+IHJlYXNv
bg0KPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gZmFpbCB0aGUgc3lzdGVtIGNhbGw/DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gVGhhbmsgeW91Lg0KPiA+ID4gPiANCj4gPiA+ID4gSSBkb24ndCByZWFs
bHkgc2VlIHRoaXMgYXMgd29ydGggZml4aW5nIG9uIHRoZSBjbGllbnQuIEl0IGlzDQo+ID4gPiA+
IHZlcnkNCj4gPiA+ID4gY2xlYXJseSBhIHNlcnZlciBidWcuDQo+ID4gPiANCj4gPiA+IFdoeSBp
cyB0aGF0IGEgc2VydmVyIGJ1Zz8gQSBzZXJ2ZXIgY2FuIGxlZ2l0aW1hdGVseSBoYXZlIGFuIGlz
c3VlDQo+ID4gPiB0cnlpbmcgdG8gZXhlY3V0ZSBhbiBvcGVyYXRpb24gKFJFU1RPUkVGSCkgYW5k
IGxlZ2l0aW1hdGVseQ0KPiA+ID4gcmV0dXJuaW5nDQo+ID4gPiBhbiBlcnJvci4NCj4gPiANCj4g
PiBJZiBpdCBpcyBoYXBwZW5pbmcgY29uc2lzdGVudGx5IG9uIHRoZSBzZXJ2ZXIsIHRoZW4gaXQg
aXMgYSBidWcsDQo+ID4gYW5kIGl0DQo+ID4gZ2V0cyByZXBvcnRlZCBieSB0aGUgY2xpZW50IGlu
IHRoZSBzYW1lIHdheSB3ZSBhbHdheXMgcmVwb3J0DQo+ID4gTkZTNEVSUl9TRVJWRVJGQVVMVCwg
YnkgY29udmVydGluZyB0byBhbiBFUkVNT1RFSU8uDQo+IA0KPiBZZXMgYnV0IHRoZSBjbGllbnQg
ZG9lc24ndCByZXRyeSBzbyBpdCBjYW4ndCBhc3Nlc3MgaWYgaXQncw0KPiBjb25zaXN0ZW50bHkg
aGFwcGVuaW5nIG9yIG5vdC4gSXQgY2FuIGJlIGEgdHJhbnNpZW50IGVycm9yIChvcg0KPiBFTk9N
RU0pDQo+IHRoYXQncyBsYXRlciByZXNvbHZlZC4NCg0KSWYgdGhlIHNlcnZlciB3YW50cyB0byBz
aWduYWwgYSB0cmFuc2llbnQgZXJyb3IsIGl0IHNob3VsZCBzZW5kDQpORlM0RVJSX0RFTEFZLg0K
DQo+ID4gPiBORlMgY2xpZW50IGFsc28gaWdub3JlcyBlcnJvcnMgb2YgdGhlIHJldHVybmluZyBH
RVRBVFRSIGFmdGVyIHRoZQ0KPiA+ID4gUkVTVE9SRUZILiBTbyBJJ20gbm90IHN1cmUgd2h5IHdl
IGFyZSB0aGVuIG5vdCBpZ25vcmluZyBlcnJvcnMNCj4gPiA+IChvcg0KPiA+ID4gc29tZSBlcnJv
cnMpIG9mIHRoZSBSRVNUT1JFRkguDQo+ID4gDQo+ID4gV2UgZG8gbmVlZCB0byBjaGVjayB0aGUg
dmFsdWUgb2YgUkVTVE9SRUZIIGluIG9yZGVyIHRvIGZpZ3VyZSBvdXQNCj4gPiBpZiB3ZQ0KPiA+
IGNhbiBjb250aW51ZSByZWFkaW5nIHRoZSBYRFIgYnVmZmVyIHRvIGRlY29kZSB0aGUgZmlsZSBh
dHRyaWJ1dGVzLg0KPiA+IFdlDQo+ID4gd2FudCB0byByZWFkIHRob3NlIGZpbGUgYXR0cmlidXRl
cyBiZWNhdXNlIHdlIGRvIGV4cGVjdCB0aGUgY2hhbmdlDQo+ID4gYXR0cmlidXRlLCB0aGUgY3Rp
bWUgYW5kIHRoZSBubGlua3MgdmFsdWVzIHRvIGFsbCBjaGFuZ2UgYXMgYQ0KPiA+IHJlc3VsdCBv
Zg0KPiA+IHRoZSBvcGVyYXRpb24uDQo+IA0KPiBJIGhhdmUgbm90aGluZyBhZ2FpbnN0IGRlY29k
aW5nIHRoZSBlcnJvciBhbmQgdXNpbmcgaXQgaW4gYSBkZWNpc2lvbg0KPiB0byBrZWVwIGRlY29k
aW5nLiBCdXQgdGhlIGNsaWVudCBkb2Vzbid0IGhhdmUgdG8gcHJvcGFnYXRlIHRoZQ0KPiBSRVNU
T1JFRkggZXJyb3IgdG8gdGhlIGFwcGxpY2F0aW9uPw0KPiANCj4gSW4gYWxsIG90aGVyIG5vbi1p
ZGVtcG90ZW50IG9wZXJhdGlvbnMgdGhhdCBoYXZlIG90aGVyIG9wZXJhdGlvbnMgKGllDQo+IEdF
VEFUVFIpIGZvbGxvd2luZyB0aGVtLCB0aGUgY2xpZW50IGlnbm9yZXMgdGhlIGVycm9ycy4gQnR3
IEkganVzdA0KPiBub3RpY2VkIHRoYXQgb24gT1BFTiBjb21wb3VuZCwgc2luY2Ugd2UgaWdub3Jl
IGRlY29kZSBlcnJvciBmcm9tIHRoZQ0KPiBHRVRBVFRSLCBpdCB3b3VsZCBjb250aW51ZSBkZWNv
ZGluZyBMQVlPVVRHRVQuLi4NCj4gDQo+IENSRUFURSBoYXMgcHJvYmxlbSBpZiB0aGUgZm9sbG93
aW5nIEdFVEZIIHdpbGwgcmV0dXJuIEVERUxBWS4gQ2xpZW50DQo+IGRvZXNuJ3QgZGVhbCB3aXRo
IHJldHJ5aW5nIGEgcGFydCBvZiB0aGUgY29tcG91bmQuIEl0IHJldHJpZXMgdGhlDQo+IHdob2xl
IGNvbXBvdW5kLiBJdCBsZWFkcyB0byBhbiBlcnJvciAoc2luY2Ugbm9uLWlkZW1wb3RlbnQgb3Bl
cmF0aW9uDQo+IGlzIHJldHJpZWQpLiBCdXQgSSBndWVzcyB0aGF0J3MgYSAybmQgaXNzdWUgKG9y
IGEgM3JkIGlmIHdlIGNvdWxkIHRoZQ0KPiBkZWNvZGluZyBsYXlvdXRnZXQpLi4uLg0KPiANCj4g
QWxsIHRoaXMgaXMgdW5kZXIgdGhlIHVtYnJlbGxhIG9mIGhvdyB0byBoYW5kbGUgZXJyb3JzIG9u
DQo+IG5vbi1pZGVtcG90ZW50IG9wZXJhdGlvbnMgaW4gYSBjb21wb3VuZC4uLi4NCg0KVGhlcmUg
aXMgbm8gcG9pbnQgaW4gdHJ5aW5nIHRvIGhhbmRsZSBlcnJvcnMgdGhhdCBtYWtlIG5vIHNlbnNl
LiBJZiB0aGUNCnNlcnZlciBoYXMgYSBidWcsIHRoZW4gbGV0J3MgZXhwb3NlIGl0IGluc3RlYWQg
b2YgdHJ5aW5nIHRvIGhpZGUgaXQgaW4NCnRoZSBzb2ZhIGN1c2hpb25zLg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
