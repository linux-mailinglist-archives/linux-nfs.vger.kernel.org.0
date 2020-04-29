Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA61BE316
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgD2PtM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Apr 2020 11:49:12 -0400
Received: from mail-eopbgr700128.outbound.protection.outlook.com ([40.107.70.128]:37664
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbgD2PtJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Apr 2020 11:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9kUQlpukfSJbQMnlYa948aZ+9/GCb9qaGE3XXqMU0nrc58PSU20k2/HMbKKhowNHiE9v+oodEDxbmoePzix+OJN4KtoX84a4Ma/dvEr63IiWTASEJtzsU+BMVUVjxZA4FaP5hAzJhQHQWGFfUEzc9zfa1phvmT5EYpgkibRvftmrOwATQnM/D/a3hgIIFjU6jjT1y9F2BTqGXHFtmn6VzugfQaMVf6lX3LAmsFg/vFIdqtkFPpgS5KeKM4izeJ85lCeWw4Qe8A3A56OZE0uDz9lpfSoR9dO5IQLBCEHD8YXfjrvjQrRBHEEFehYyBLugrlu4wEPgo5ApnuijvGdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ncp0NO9YrzOmjzVh0zxL+5sH/EpoF65mJPlqtRPI8Q=;
 b=hgxTIUuY3vroZ6baKHfUXXMsRnz4nZTKyVhnPZnV4tL380s142Whg3rZI+RDIffBHYA/gPYj/cRzhhok6m9xJ3n28i/zXKTEoSwbLrdDkkccv9TaPqVv0Or+iiO0qrVE7ENy97drlewuo7xDlCkOKlpsdvT3uB7aAtKDthwfeGQWjLkouaFZWSHU03hJNh2XIYuQsQlLRmR1GXgAxSW9ob1SOWkyFQc2UGjaUTqimRJPcoTstlo/vdw83Ts2oNpt+FgXZufaXoX7JqptbT6uxoN8vXJ61TingwDo3KfoHgN4pbrrmVK5vLleA26IPVlKh6ZuIimUILS6kvV5LjobbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ncp0NO9YrzOmjzVh0zxL+5sH/EpoF65mJPlqtRPI8Q=;
 b=cD4QKzT4qWg3tza/Z682zXIW3rso8oFFFw7xbEyTi8fHvIQ5JYWXE1QaPxshTkhFibOohfEP9kekFbibl9ZkMdQ3/Vh6zAl3YTcrX4rWOa+ksIm7W/0KFgPcgV72UqgqoYZeIg2EV2mtWJLru2NxpxDPgwMB1M9N/lyF33lbXpA=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3334.namprd13.prod.outlook.com (2603:10b6:610:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Wed, 29 Apr
 2020 15:49:04 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.020; Wed, 29 Apr 2020
 15:49:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tom@talpey.com" <tom@talpey.com>,
        "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Thread-Topic: handling ERR_SERVERFAULT on RESTOREFH
Thread-Index: AQHWHYjzjBZLlmadoEGcRGdAsbmgTaiO38OAgAAfvACAAA5TAIAAGV4AgAAK7wCAACh4AIAA1X8AgAAQP4A=
Date:   Wed, 29 Apr 2020 15:49:03 +0000
Message-ID: <bdf460881155932400660b5b96fc1175ff1e274d.camel@hammerspace.com>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
         <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
         <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
         <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
         <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
         <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
         <CAN-5tyFOrb0bNWYon9QTQqWdhv4LG+-zBVbBt2E1NE=rwsBScg@mail.gmail.com>
         <d4109a36-e313-3649-336c-85e11d13d796@talpey.com>
In-Reply-To: <d4109a36-e313-3649-336c-85e11d13d796@talpey.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48a12da9-cfe2-4655-c2c7-08d7ec54d7fd
x-ms-traffictypediagnostic: CH2PR13MB3334:
x-microsoft-antispam-prvs: <CH2PR13MB333460ADA106E52D0D79C6A8B8AD0@CH2PR13MB3334.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03883BD916
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aw5P9zhq9U3iro9EVyBcjtzz6huXF9kmtzk/aa4ha7DPyZV3loB+dsTm4HTOPOcRTc2dp5/FUmSXZ+/NR+S1/33DljzA4CI8hh1lNeP40hdnKzPcOGYH3QiwTYGW9WuBxMz1XpG+HjqTL/FmuMStCqhWHOwRjyvG5TvzwcQH2r2iK8bfT1nSvo7MpHU/iB6ViWWc+hEoDjQvi3qE7G2mGtGiCjOnFHaf9cwYkt9VRrol08mId4wsE6Ufi5aaeuC1KjjdmC7ZvHvNuTnoKqRhr54rIw+5anOzZz/CdPlEHiXAkk8gPr7JT+6V2rV2ITenBl7nPCK+/jm/UdwCj2/kB0AyAT4JldJbVQq2rCzqvWElT3a9kcD9zYL5no3ww9jwvCPf7CGC0pgSlly/9h4ZUK3mYZNf4qVukIbNlqlaFVOtxvA/+pLijCRvMpXcERIm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39830400003)(136003)(396003)(366004)(346002)(376002)(5660300002)(26005)(53546011)(6506007)(186003)(2906002)(316002)(8936002)(4326008)(2616005)(8676002)(86362001)(6512007)(478600001)(71200400001)(36756003)(110136005)(76116006)(91956017)(66946007)(66556008)(66446008)(6486002)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WDOuzZsudbcWHzwA2TyJyfB/G05Y85aGaBpD4yrZq2q23EzGkircGO9DWN4FXTH0I9gmW9+BdRCEFs0T6emdf8Z7n+UVK2nRtbDkzozvm3Q1pMXXoaipB2UxRI09LimC/kssiG/qm0AdM767ecsO+k7Hfd1C039n2lWdnbBLZ++PEOFhboCUVu1OvhX6tngqu2zcxOeVECX9eK2Qsr9eTVyIToVRLL8BMVeGSxE5suHxO16JdvyPvvNKWdNOr2qQ5UwFCScme7MQKPfwaV5Iglk4ZuID7RkQ5AgUn6n1jr00KJqbQ3HFAykSz8nG1Q1XHkJ2VhTHwOU5hFDxveATBogpI83eOgmUrF9hH99v6hNf9BuK/SnBmBR3yqxAD38oM1A04rDwn3PHRSoHmYDF2unHAyAJXSmuKfMkAYukCgd69QGhmE5cwolkF2PLONXyqlgMw1quAZjioeGBaYg4MTc+EOohPgWzhKP0cvMG/cjebJ1CgXiGyenoPtB5ymyIjmnLEcfKrsXla/ySZnf1y6QkKSB0GJSQKkPSCk47BICTWcaqDX/WwW8cCNNy/mDmGKps6IQySLLedsn8q0k6jQdH+ZA9pBl22j4OWantlzgkKfRnX3GOMlNRSs+/3vNe3UsyHncT43OI06VUiG2WEpgrzV1Txh7X7tyo1qYcym8AfJhBJD4fjJsTJxw00lqM/pQxYF4jM5Gs4ayq693OmZ1oR66O6QcxZGNS+b7N1FGSpc/2Qm1EJVGFx+Fqx300YdCBmEBBsMSFUGKTlXuA/tgLn9axvVGu6lPo+rmOTtw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9840D98DF955DD40B2D4CD109D7E8B49@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a12da9-cfe2-4655-c2c7-08d7ec54d7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 15:49:03.9595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaH8i1G8TkUkAZZv9S7vr3DMXsA+niI5WcbxqGDcAdzZ21WMIKP+46m6hmXwp4cZyV0swNYGsO2GYrGRAv6EhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3334
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTI5IGF0IDEwOjUwIC0wNDAwLCBUb20gVGFscGV5IHdyb3RlOg0KPiBP
biA0LzI4LzIwMjAgMTA6MDYgUE0sIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgQXByIDI4LCAyMDIwIGF0IDc6NDIgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4gPiB0cm9uZG15
QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMjAtMDQtMjggYXQgMTk6
MDIgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIEFwciAy
OCwgMjAyMCBhdCA1OjMyIFBNIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gPiA+IHRyb25kbXlAaGFt
bWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gPiBPbiBUdWUsIDIwMjAtMDQtMjggYXQgMTY6
NDAgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gVHVlLCBB
cHIgMjgsIDIwMjAgYXQgMjo0NyBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+ID4gPiA+ID4gdHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBIaSBPbGdhLA0KPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24gVHVlLCAyMDIwLTA0LTI4IGF0IDE0OjE0IC0w
NDAwLCBPbGdhIEtvcm5pZXZza2FpYQ0KPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gPiBIaSBmb2xrLA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IExvb2tpbmcg
Zm9yIGd1aWRhbmNlIG9uIHdoYXQgZm9sa3MgdGhpbmsuIEEgY2xpZW50IGlzDQo+ID4gPiA+ID4g
PiA+ID4gc2VuZGluZw0KPiA+ID4gPiA+ID4gPiA+IGENCj4gPiA+ID4gPiA+ID4gPiBMSU5LDQo+
ID4gPiA+ID4gPiA+ID4gb3BlcmF0aW9uIHRvIHRoZSBzZXJ2ZXIuIFRoaXMgY29tcG91bmQgYWZ0
ZXIgdGhlIExJTksNCj4gPiA+ID4gPiA+ID4gPiBoYXMNCj4gPiA+ID4gPiA+ID4gPiBSRVNUT1JF
RkgNCj4gPiA+ID4gPiA+ID4gPiBhbmQgR0VUQVRUUi4gU2VydmVyIHJldHVybnMgU0VSVkVSX0ZB
VUxUIHRvIG9uDQo+ID4gPiA+ID4gPiA+ID4gUkVTVE9SRUZILiBCdXQNCj4gPiA+ID4gPiA+ID4g
PiBMSU5LIGlzDQo+ID4gPiA+ID4gPiA+ID4gZG9uZSBzdWNjZXNzZnVsbHkuIENsaWVudCBzdGls
bCBmYWlscyB0aGUgc3lzdGVtIGNhbGwNCj4gPiA+ID4gPiA+ID4gPiB3aXRoDQo+ID4gPiA+ID4g
PiA+ID4gRUlPLg0KPiA+ID4gPiA+ID4gPiA+IFdlDQo+ID4gPiA+ID4gPiA+ID4gaGF2ZSBhIGhh
cmRsaW5lIGFuZCAibG4iIHNheWluZyBoYXJkbGluayBmYWlsZWQuDQo+ID4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+ID4gU2hvdWxkIHRoZSBjbGllbnQgbm90IGZhaWwgdGhlIHN5c3RlbSBj
YWxsIGluIHRoaXMNCj4gPiA+ID4gPiA+ID4gPiBjYXNlPyBUaGUNCj4gPiA+ID4gPiA+ID4gPiBm
YWN0DQo+ID4gPiA+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+ID4gPiA+IHdlIGNvdWxkbid0IGdl
dCB1cC10by1kYXRlIGF0dHJpYnV0ZXMgZG9uJ3Qgc2VlbSBsaWtlDQo+ID4gPiA+ID4gPiA+ID4g
dGhlDQo+ID4gPiA+ID4gPiA+ID4gcmVhc29uDQo+ID4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4g
PiA+ID4gPiBmYWlsIHRoZSBzeXN0ZW0gY2FsbD8NCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiBUaGFuayB5b3UuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJIGRvbid0
IHJlYWxseSBzZWUgdGhpcyBhcyB3b3J0aCBmaXhpbmcgb24gdGhlIGNsaWVudC4gSXQNCj4gPiA+
ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4gdmVyeQ0KPiA+ID4gPiA+ID4gPiBjbGVhcmx5IGEg
c2VydmVyIGJ1Zy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gV2h5IGlzIHRoYXQgYSBzZXJ2
ZXIgYnVnPyBBIHNlcnZlciBjYW4gbGVnaXRpbWF0ZWx5IGhhdmUgYW4NCj4gPiA+ID4gPiA+IGlz
c3VlDQo+ID4gPiA+ID4gPiB0cnlpbmcgdG8gZXhlY3V0ZSBhbiBvcGVyYXRpb24gKFJFU1RPUkVG
SCkgYW5kIGxlZ2l0aW1hdGVseQ0KPiA+ID4gPiA+ID4gcmV0dXJuaW5nDQo+ID4gPiA+ID4gPiBh
biBlcnJvci4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJZiBpdCBpcyBoYXBwZW5pbmcgY29uc2lz
dGVudGx5IG9uIHRoZSBzZXJ2ZXIsIHRoZW4gaXQgaXMgYQ0KPiA+ID4gPiA+IGJ1ZywNCj4gPiA+
ID4gPiBhbmQgaXQNCj4gPiA+ID4gPiBnZXRzIHJlcG9ydGVkIGJ5IHRoZSBjbGllbnQgaW4gdGhl
IHNhbWUgd2F5IHdlIGFsd2F5cyByZXBvcnQNCj4gPiA+ID4gPiBORlM0RVJSX1NFUlZFUkZBVUxU
LCBieSBjb252ZXJ0aW5nIHRvIGFuIEVSRU1PVEVJTy4NCj4gPiA+ID4gDQo+ID4gPiA+IFllcyBi
dXQgdGhlIGNsaWVudCBkb2Vzbid0IHJldHJ5IHNvIGl0IGNhbid0IGFzc2VzcyBpZiBpdCdzDQo+
ID4gPiA+IGNvbnNpc3RlbnRseSBoYXBwZW5pbmcgb3Igbm90LiBJdCBjYW4gYmUgYSB0cmFuc2ll
bnQgZXJyb3IgKG9yDQo+ID4gPiA+IEVOT01FTSkNCj4gPiA+ID4gdGhhdCdzIGxhdGVyIHJlc29s
dmVkLg0KPiA+ID4gDQo+ID4gPiBJZiB0aGUgc2VydmVyIHdhbnRzIHRvIHNpZ25hbCBhIHRyYW5z
aWVudCBlcnJvciwgaXQgc2hvdWxkIHNlbmQNCj4gPiA+IE5GUzRFUlJfREVMQVkuDQo+ID4gDQo+
ID4gRVJSX0RFTEFZIG5vdCBhbiBhbGxvd2VkIGVycm9yIGZvciB0aGUgUkVTVE9SRUZILiBCdXQg
bGV0J3Mgc2F5LA0KPiA+IHRoZQ0KPiA+IHNlcnZlciBkb2VzIHJldHVybiBpdCwgdGhlbiBjbGll
bnQgaXMgbm90IGZvbGxvd2luZyB0aGUgc3BlYw0KPiA+IGJlY2F1c2UNCj4gPiBpZiBpdCdsbCBn
ZXQgdGhpcyBlcnJvciwgaXQgd2lsbCByZXRyeSB0aGUgd2hvbGUgY29tcG91bmQgKGNhdXNpbmcN
Cj4gPiBhDQo+ID4gZGlmZmVyZW50IGVycm9yIG9mIHJlZG9pbmcgYSBub24taWRlbXBvdGVudCBv
cGVyYXRpb24pLiBUaGUgc3BlYw0KPiA+IHNheXMNCj4gPiBjbGllbnQgaXMgcmVzcG9uc2libGUg
Zm9yIGhhbmRsaW5nIHBhcnRpYWxseSBjb21wbGV0ZWQgY29tcG91bmQuDQo+ID4gVGhlDQo+ID4g
Y2xpZW50IHNob3VsZCBvbmx5IHJldHJ5IHRoZSBmYWlsZWQgb3BlcmF0aW9ucyBpbiBhIGNvbXBv
dW5kLCBJDQo+ID4gZG9uJ3QNCj4gPiBzZWUgdGhhdCBjbGllbnQgZG9lcyB0aGF0Lg0KPiA+IA0K
PiA+ID4gPiA+ID4gTkZTIGNsaWVudCBhbHNvIGlnbm9yZXMgZXJyb3JzIG9mIHRoZSByZXR1cm5p
bmcgR0VUQVRUUg0KPiA+ID4gPiA+ID4gYWZ0ZXIgdGhlDQo+ID4gPiA+ID4gPiBSRVNUT1JFRkgu
IFNvIEknbSBub3Qgc3VyZSB3aHkgd2UgYXJlIHRoZW4gbm90IGlnbm9yaW5nDQo+ID4gPiA+ID4g
PiBlcnJvcnMNCj4gPiA+ID4gPiA+IChvcg0KPiA+ID4gPiA+ID4gc29tZSBlcnJvcnMpIG9mIHRo
ZSBSRVNUT1JFRkguDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2UgZG8gbmVlZCB0byBjaGVjayB0
aGUgdmFsdWUgb2YgUkVTVE9SRUZIIGluIG9yZGVyIHRvIGZpZ3VyZQ0KPiA+ID4gPiA+IG91dA0K
PiA+ID4gPiA+IGlmIHdlDQo+ID4gPiA+ID4gY2FuIGNvbnRpbnVlIHJlYWRpbmcgdGhlIFhEUiBi
dWZmZXIgdG8gZGVjb2RlIHRoZSBmaWxlDQo+ID4gPiA+ID4gYXR0cmlidXRlcy4NCj4gPiA+ID4g
PiBXZQ0KPiA+ID4gPiA+IHdhbnQgdG8gcmVhZCB0aG9zZSBmaWxlIGF0dHJpYnV0ZXMgYmVjYXVz
ZSB3ZSBkbyBleHBlY3QgdGhlDQo+ID4gPiA+ID4gY2hhbmdlDQo+ID4gPiA+ID4gYXR0cmlidXRl
LCB0aGUgY3RpbWUgYW5kIHRoZSBubGlua3MgdmFsdWVzIHRvIGFsbCBjaGFuZ2UgYXMgYQ0KPiA+
ID4gPiA+IHJlc3VsdCBvZg0KPiA+ID4gPiA+IHRoZSBvcGVyYXRpb24uDQo+ID4gPiA+IA0KPiA+
ID4gPiBJIGhhdmUgbm90aGluZyBhZ2FpbnN0IGRlY29kaW5nIHRoZSBlcnJvciBhbmQgdXNpbmcg
aXQgaW4gYQ0KPiA+ID4gPiBkZWNpc2lvbg0KPiA+ID4gPiB0byBrZWVwIGRlY29kaW5nLiBCdXQg
dGhlIGNsaWVudCBkb2Vzbid0IGhhdmUgdG8gcHJvcGFnYXRlIHRoZQ0KPiA+ID4gPiBSRVNUT1JF
RkggZXJyb3IgdG8gdGhlIGFwcGxpY2F0aW9uPw0KPiA+ID4gPiANCj4gPiA+ID4gSW4gYWxsIG90
aGVyIG5vbi1pZGVtcG90ZW50IG9wZXJhdGlvbnMgdGhhdCBoYXZlIG90aGVyDQo+ID4gPiA+IG9w
ZXJhdGlvbnMgKGllDQo+ID4gPiA+IEdFVEFUVFIpIGZvbGxvd2luZyB0aGVtLCB0aGUgY2xpZW50
IGlnbm9yZXMgdGhlIGVycm9ycy4gQnR3IEkNCj4gPiA+ID4ganVzdA0KPiA+ID4gPiBub3RpY2Vk
IHRoYXQgb24gT1BFTiBjb21wb3VuZCwgc2luY2Ugd2UgaWdub3JlIGRlY29kZSBlcnJvcg0KPiA+
ID4gPiBmcm9tIHRoZQ0KPiA+ID4gPiBHRVRBVFRSLCBpdCB3b3VsZCBjb250aW51ZSBkZWNvZGlu
ZyBMQVlPVVRHRVQuLi4NCj4gPiA+ID4gDQo+ID4gPiA+IENSRUFURSBoYXMgcHJvYmxlbSBpZiB0
aGUgZm9sbG93aW5nIEdFVEZIIHdpbGwgcmV0dXJuIEVERUxBWS4NCj4gPiA+ID4gQ2xpZW50DQo+
ID4gPiA+IGRvZXNuJ3QgZGVhbCB3aXRoIHJldHJ5aW5nIGEgcGFydCBvZiB0aGUgY29tcG91bmQu
IEl0IHJldHJpZXMNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHdob2xlIGNvbXBvdW5kLiBJdCBsZWFk
cyB0byBhbiBlcnJvciAoc2luY2Ugbm9uLWlkZW1wb3RlbnQNCj4gPiA+ID4gb3BlcmF0aW9uDQo+
ID4gPiA+IGlzIHJldHJpZWQpLiBCdXQgSSBndWVzcyB0aGF0J3MgYSAybmQgaXNzdWUgKG9yIGEg
M3JkIGlmIHdlDQo+ID4gPiA+IGNvdWxkIHRoZQ0KPiA+ID4gPiBkZWNvZGluZyBsYXlvdXRnZXQp
Li4uLg0KPiA+ID4gPiANCj4gPiA+ID4gQWxsIHRoaXMgaXMgdW5kZXIgdGhlIHVtYnJlbGxhIG9m
IGhvdyB0byBoYW5kbGUgZXJyb3JzIG9uDQo+ID4gPiA+IG5vbi1pZGVtcG90ZW50IG9wZXJhdGlv
bnMgaW4gYSBjb21wb3VuZC4uLi4NCj4gPiA+IA0KPiA+ID4gVGhlcmUgaXMgbm8gcG9pbnQgaW4g
dHJ5aW5nIHRvIGhhbmRsZSBlcnJvcnMgdGhhdCBtYWtlIG5vIHNlbnNlLg0KPiA+ID4gSWYgdGhl
DQo+ID4gPiBzZXJ2ZXIgaGFzIGEgYnVnLCB0aGVuIGxldCdzIGV4cG9zZSBpdCBpbnN0ZWFkIG9m
IHRyeWluZyB0byBoaWRlDQo+ID4gPiBpdCBpbg0KPiA+ID4gdGhlIHNvZmEgY3VzaGlvbnMuDQo+
ID4gDQo+ID4gRURFTEFZIG9uIEdFVEZIIGlzIGEgcmVhc29uYWJsZSBlcnJvciBmb3IgdGhlIHNl
cnZlciB0byByZXR1cm4uDQo+IA0KPiBJIGRvbid0IGRpc2FncmVlIHRoYXQgdGhpcyBpcyBhIGJy
b2tlbiBzZXJ2ZXIgYmVoYXZpb3IuIEJ1dCBmcm9tIHRoZQ0KPiBwcm90b2NvbCBwZXJzcGVjdGl2
ZSwgSSB3YW50IHRvIG1ha2UgdHdvIG9ic2VydmF0aW9ucy4NCj4gDQo+IDEpIFRoZSBwb3N0LW9w
ZXJhdGlvbiBhdHRyaWJ1dGVzIGFyZSBub3QgYXRvbWljLCB0aGVyZWZvcmUgYW4NCj4gYXR0cmli
dXRlDQo+IGZhaWx1cmUgZG9lcyBub3QgaW1wbHkgdGhlIG9wZXJhdGlvbiB3YXMgdW5zdWNjZXNz
ZnVsLg0KPiANCj4gMikgVGhlIGFwcGxpY2F0aW9uIGRpZCBub3QgbmVjZXNzYXJpbHkgcmVxdWVz
dCB0aGUgYXR0cmlidXRlcywgdGhpcw0KPiB3YXMgaW5zZXJ0ZWQgYnkgdGhlIGNsaWVudCwgcmln
aHQ/IFNvIGFnYWluLCB0aGVpciBzdWNjZXNzIG9yIGZhaWx1cmUNCj4gaXMgbm90IGFjdHVhbGx5
IHJlbGV2YW50IHRvIHRoZSBhcHBsaWNhdGlvbi4NCj4gDQoNClVuZGVyc3Rvb2QsIGhvd2V2ZXIg
aWYgYSBzZXJ2ZXIgdmVuZG9yIGRvZXNuJ3Qgd2FudCB0byB0YWtlDQpyZXNwb25zaWJpbGl0eSBm
b3IgdGhlaXIgcHJvZHVjdCBidWcsIHRoZW4gSSBkb24ndCB3YW50IHRoZSBMaW51eA0KY2xpZW50
IHRvIGhhdmUgdG8gb3duIHRoZWlyIHByb2JsZW0gaW4gcGVycGV0dWl0eS4NCg0KLS0gDQpUcm9u
ZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
