Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8E1B31D1
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2020 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDUVUy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Apr 2020 17:20:54 -0400
Received: from mail-eopbgr680132.outbound.protection.outlook.com ([40.107.68.132]:9762
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbgDUVUy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Apr 2020 17:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8rkHLZmnybV3clR0iqc4k57QH09IdY4NpebVi4xpkHW+qM+IWqkL/i2OZP7VvJLuRfj0b3wkUZDBT2WAwQIi18CVqPZIJSVwefgr8m9lof2HJjf577bMXG67yNazCU9Ose8pfHSV9lXRbTrRA2TcDMoeM9IRtWMAj113Q1HsbpEK1CrNteFn0Bjd5x230lhEMav04OJJ/9FioBIpebaepFR6gw3SKL3OzdCrf6bAQ0QmC6WG09DY2OYIc6iYUoF9LUK6GX9K6Aq40bP65/pAGV0mA/L+u59yuGJMQ3BrAiq7jbPvTFV1j9lASUxM6oVR3K9W7OW9sI9lt/S0pDwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LHKpODu6a14f16Lx5K9d/pjVkRRyVj2CNJ2DFMtxC0=;
 b=Pl6i8OWt1du/eYDk804mWkJh7Se2eYdXaptbaR1UWXaprBe4+BElaOYNwWgzFvmIDeLHBTKMhy8OEOoH2yTxJAoC79nnf2T2kLiwPNwZFB68xNzRN8sfA2mZ8T3R0KbLcmE6El4CwHvniGtN2WgKFi4bkhnk7DrdGEpkxhev6aGq0Yq4kCFEHTOLxRlHbB2B2B75VNms98Y7VakSQu1CyjnSmvzj8vvkcYIs5ZmbWmZbDCxE4E+bZyebhcyMLk454vplSw0F45P0CEo1RZ3HX79a7nlJuWeMrXsPOEi4Fd+q28d9AlBUO5tgOv0/uWf510EGBy/Vstdx9Kzwgvi+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LHKpODu6a14f16Lx5K9d/pjVkRRyVj2CNJ2DFMtxC0=;
 b=MdivCsxUR6CyhwM5OMro51J1SHWErO/2aKdo2sULWS5GSUlh4hqNp+zccfIrezXido108m39bgMuloCiBgi3L2b/EHNRTFUCOZSIBBcRQCrWHGEHTVYcurHwWJ/rlCM9KcrhFtnn/Gr17b61Gc0JvyzVhdX9ZJN/F2jUg1VWN9o=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3461.namprd13.prod.outlook.com (2603:10b6:610:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.10; Tue, 21 Apr
 2020 21:20:50 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.012; Tue, 21 Apr 2020
 21:20:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Topic: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Index: AQHWFMsRjFm2JNXk8kav0WOkI+SUpah9cM+AgAADbACAAApfgIAAB24AgAAB0wCABIX4AIAAA9IAgAALwoCAAAGUAIAAQ8uAgAAJagCAAB1LgIABeD4AgAAaJAA=
Date:   Tue, 21 Apr 2020 21:20:50 +0000
Message-ID: <f428e641a062c18c2fcf87a662791cc1711d93c3.camel@hammerspace.com>
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
         <2e691fb93a4b6d362cdfd85feaaa9cfbfc68709c.camel@hammerspace.com>
         <CAN-5tyE2ix4urwhFN_ctcPoTwDrWu5jM2gEbuD4cvc-_k6NVvg@mail.gmail.com>
         <fbd6f65b176449e7a1abd5731361ad4e6fa15900.camel@hammerspace.com>
         <CAN-5tyFtUgiDe=5q0p61Cdpb8Z6QcWkMtxSFj3bs=ra-LiNWUw@mail.gmail.com>
In-Reply-To: <CAN-5tyFtUgiDe=5q0p61Cdpb8Z6QcWkMtxSFj3bs=ra-LiNWUw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc4ced15-3893-4643-c14b-08d7e639ddce
x-ms-traffictypediagnostic: CH2PR13MB3461:
x-microsoft-antispam-prvs: <CH2PR13MB3461827BD8865E9D2C25FDF8B8D50@CH2PR13MB3461.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39830400003)(396003)(376002)(136003)(366004)(53546011)(66946007)(91956017)(6506007)(86362001)(76116006)(66556008)(64756008)(26005)(5660300002)(71200400001)(81156014)(8676002)(2906002)(8936002)(54906003)(66446008)(478600001)(36756003)(66476007)(186003)(6916009)(2616005)(4326008)(6512007)(6486002)(316002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dw/4wEH9rOhfRb921R2YZpBch2fZmW3ENXsHOi5NUrp+ejnD6jC79Ixie42FCM+gyRz6uVSxRG15X8V6BiEpGRYPHEXT3RO9mB74DjLbuitZvJnQ4XThitmf5aSFR0e145WekVbEa6GmaVw5yWu35yLPwX0wmoi+yLczjnD5+1NYgPqSkSXV5hDBCWQ2bPcqWPWFCV5A0XvwqnOdPPa7y8fZeRr6o8bOGtUxvJInzD9nHy8wy5q26yDqI6rP4c+ixWp5cxeGY1c3y1qLvj9b/Mz3WYwHTd8llGJgoC6sZBowHok3pFn2hh4JMBzlneU0Rzdtce9m9iHw8ZJHp+FLmE/OFaOv4RF2kc6VQI8LfaP+I7rgwL+832B7IWseFk6mMMJewIV0GVJZ64EWD0G9YcvukgJZjHanYnuHvEsr9Pgqbj006EJkw0dt55vkqP9t
x-ms-exchange-antispam-messagedata: dGBU7XFPjFomBN4sTSpT1yzUAYwgW1HHwtHc61J0a6HJUNPrY+Fpp7GnrXcKrP7TeaRhX8yx+SinejUzroGX9t+VCeMBfnGc2Tdwz3HSycKkyGmj6jcq3gJNJwApmWrPBRRWUmOQQ3UZido6n6VnpsGEAOmr0zxLxCj/Az6o9KpCL5TCzx5mWG1L4ShrdpYlcIqlNGd5/rcUjeyyoXalWKodiUY5gd/Qq5t/vKT76lNBb2un6dTtuPbiZo2bjESSQgdnTlyaMvxuv9J+uJVNyu0BFUV2p6SjtqFXeql1yyahuVrQAl8FfR+2tNCyiVyAE4w27REcTB0YFdR0FG4fHbL0DkeMRe8eGhu+5mVtdap5kx7HgjKB6ttcBlvKEYFv33/t+jXBdVW1qqBwJ+e4PupH6q67pusA5lL/KYnMtrQ3UxDzOEVd4eLuM1CuyPollYOyFrJnTWPr9Xyk6XG508vch8v1pF6F3RwHSHnPBJYI+Iv/70/SBYOCskyA++fimiIbYFbzsoqmksWk/9N6nyaYQm7ALy872hYY4Gmo5M0YDt+aR7hxWgJSvXuaGgJ0ZrUsTxscV26U7jtN/scx3hJSW/G2tPny1qWp7dwwOJHBngA7X/CWSsSDhSDjkmBT93Oj/LM3aWlKMYyfliznD1yf23/gnL+y/+e0b9G3ZdZYDrEjiZbfknGP27H5FGRzRs2ZjMhYfs7FqXykMII1YoB26VikB1Zqmjz8Jup9RsPsCRoKeLFgyWBqKQLYbDW0cZ/N4+eplFQ3JmHfP85XZdVl7stFaX+LFMbrG4E7VSQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A9A25447E10F04DA7D12703D887B739@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4ced15-3893-4643-c14b-08d7e639ddce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 21:20:50.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qcaswr5yDOE1SIrI20lwyShR14rJe06XyNmYvOhKbeT7iXhLq45yU5EzjSu5qlYLWEB9bJf2PbNQv6bT6uDsAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3461
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTIxIGF0IDE1OjQ3IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gTW9uLCBBcHIgMjAsIDIwMjAgYXQgNToyMCBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gTW9uLCAyMDIwLTA0LTIw
IGF0IDE1OjM1IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IE9uIE1vbiwg
QXByIDIwLCAyMDIwIGF0IDM6MDIgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+IHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCAyMDIwLTA0LTIwIGF0IDEw
OjU5IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24sIEFw
ciAyMCwgMjAyMCBhdCAxMDo1MyBBTSBPbGdhIEtvcm5pZXZza2FpYSA8DQo+ID4gPiA+ID4gb2xn
YS5rb3JuaWV2c2thaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+IFllcyB3ZSBhcmUg
Y29uc2lzdGVudCBpbiByZXF1ZXN0aW5nIHRvIHNhbWUgY29ubmVjdGlvbiB0bw0KPiA+ID4gPiA+
ID4gd2l0aA0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBzYW1lIGNoYW5uZWwgYmluZGlu
ZywgYnV0IHdlIGRvbid0IHNlbmQNCj4gPiA+ID4gPiA+IEJJTkRfQ09OTl9UT19TRVNTSU9OIGFz
DQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+IGZpcnN0IHRoaW5nIG9uIHRoZSAibWFpbiIg
Y29ubmVjdGlvbiAoaWUgY29ubmVjdGlvbiB0aGF0DQo+ID4gPiA+ID4gPiBjYXJlZA0KPiA+ID4g
PiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBDUkVBVEVfU0VTU0lPTiBhbmQgd2FzIGJvdW5kIHRvIGZv
cmUgYW5kIGJhY2sgY2hhbm5lbCBieQ0KPiA+ID4gPiA+ID4gZGVmYXVsdCkuDQo+ID4gPiA+ID4g
PiBXaGVuIHRoYXQgY29ubmVjdGlvbiBpcyByZXNldCwgdGhlIGZpcnN0IHRoaW5nIHRoYXQgaGFw
cGVucw0KPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gY2xpZW50
IHJlLXNlbmRzIHRoZSBvcGVyYXRpb24gdGhhdCB3YXMgbm90IHJlcGxpZWQgdG8uIFRoYXQNCj4g
PiA+ID4gPiA+IGhhcw0KPiA+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+ID4gU0VRVUVOQ0UgYW5kIGJ5
IHRoZSBydWxlIHRoZSBzZXJ2ZXIgYmluZHMgdGhhdCBjb25uZWN0aW9uDQo+ID4gPiA+ID4gPiB0
bw0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBmb3JlIGNoYW5uZWwgb25seSAoYW5kIHNl
dHMgdGhlIGNhbGxiYWNrIGJlaW5nIGRvd24pLiBXZQ0KPiA+ID4gPiA+ID4gdGhlbg0KPiA+ID4g
PiA+ID4gc2VuZA0KPiA+ID4gPiA+ID4gQklORF9DT05OX1RPX1NFU1NJT04gYW5kIHJlcXVlc3Qg
Rk9SRV9PUl9CT1RIIHdoZXJlIHRoaXMNCj4gPiA+ID4gPiA+IGhhcw0KPiA+ID4gPiA+ID4gYWxy
ZWFkeSBiZWVuIGJvdW5kIHRvIEZPUkUgb25seS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEhvdyBhYm91dCB0aGlzOiBiZWZvcmUgd2Ugc2VuZCBCSU5EX0NPTk5fVE9fU0VT
U0lPTiB3aXRoDQo+ID4gPiA+ID4gZm9yZV9vcl9ib3RoLCB3ZSBzb21laG93IGFsd2F5cyByZXNl
dCB0aGUgY29ubmVjdGlvbiAobWF5YmUNCj4gPiA+ID4gPiB5b3UNCj4gPiA+ID4gPiB3ZXJlDQo+
ID4gPiA+ID4gc3VnZ2VzdGlvbiB0aGF0IGFscmVhZHkgYW5kIGkgd2Fzbid0IGZvbGxvd2luZyku
DQo+ID4gPiA+IA0KPiA+ID4gPiBOby4gSSBkaWRuJ3QgcmVhbGlzZSB0aGF0IHdlIHdlcmUgYmVp
bmcgYXV0b21hdGljYWxseSBzZXQgdG8NCj4gPiA+ID4ganVzdA0KPiA+ID4gPiB0aGUNCj4gPiA+
ID4gZm9yZSBjaGFubmVsLiBIb3dldmVyIGFzIEkgc2FpZCBlYXJsaWVyLCB0aGUgc3BlYyBzYXlz
IHRoYXQgdGhlDQo+ID4gPiA+IHNlcnZlcg0KPiA+ID4gPiBNVVNUIHJlcGx5IHdpdGggTkZTNEVS
Ul9JTlZBTCBpbiB0aGlzIGNhc2UuIEl0IGlzIG5vdCBhbGxvd2VkDQo+ID4gPiA+IHRvDQo+ID4g
PiA+IGp1c3QNCj4gPiA+ID4gcmV0dXJuIE5GUzRfT0sgYW5kIHNpbGVudGx5IHNldCB0aGUgd3Jv
bmcgY2hhbm5lbCBiaW5kaW5nLg0KPiA+ID4gDQo+ID4gPiBIb3cncyB0aGlzOg0KPiA+ID4gY2xp
ZW50IHNlbmRzIEJJTkRfQ09OTl9UT19TRVNTSU9OIHdpdGggRk9SRV9PUl9CT1RILCBzZXJ2ZXIN
Cj4gPiA+IHNlbGVjdA0KPiA+ID4gRk9SRSBjaGFubmVsLiBjb25uZWN0aW9uIGJyZWFrcyBiZWZv
cmUgdGhlIHJlcGx5IGdldHMgdG8gdGhlDQo+ID4gPiBjbGllbnQuDQo+ID4gPiBDbGllbnQgcmVz
ZW5kcy4gSXMgdGhlIHNlcnZlciBzdXBwb3NlIHRvIG5vdyBmYWlsIHdpdGggRVJSX0lOVkFMPw0K
PiA+ID4gDQo+ID4gPiBUaGVyZSBhY3R1YWxseSBpcyBzdWNoIGEgdGhpbmcgYmV0d2VlbiBkZW1h
bmQgYW5kIHJlcXVlc3QuIEZPUkUNCj4gPiA+IGFuZA0KPiA+ID4gQkFDSyBhcmUgZGVtYW5kcyBh
bmQgRk9SRV9PUl9CT1RIIGFuZCBCQUNLX09SX0JPVEggYXJlIHJlcXVlc3RzLg0KPiA+ID4gVGhl
DQo+ID4gPiBzcGVjIHdyaXRlcyBvbmx5IGFib3V0IGRlbWFuZHMgYW5kIG5vdCB0aGUgcmVxdWVz
dHMuIEkgYmVsaWV2ZQ0KPiA+ID4gdGhhdCdzDQo+ID4gPiBpbnRlbnRpb25hbCBiZWNhdXNlIEJJ
TkRfQ09OTl9UT19TRVNTSU9uIGRvZXNuJ3QgaGF2ZSBhIHNlcXVlbmNlDQo+ID4gPiBhbmQNCj4g
PiA+IG5vdCBwcm90ZWN0ZWQgYnkgcmVwbHkgc2Vzc2lvbiBzZW1hbnRpY3MuDQo+ID4gDQo+ID4g
T0suIEhvd2V2ZXIgaWYgd2UgdGFrZSB0aGF0IGludGVycHJldGF0aW9uLCB0aGVuIHRoZSBxdWVz
dGlvbiBpcw0KPiA+IHdoeQ0KPiA+IHdvdWxkIHRoZSBzZXJ2ZXIgZG93bmdyYWRlIG91ciBGT1JF
X09SX0JPVEggdG8gRk9SRSBhbmQgd2hhdCBpcyB0aGUNCj4gPiBwb2ludCBvZiB0aGUgY2xpZW50
IGV2ZW4gcmV0cnlpbmcgYXQgYWxsIGluIHRoYXQgY2FzZT8NCj4gDQo+IEFzIGZhciBhcyBJIGNh
biB0ZWxsLCB0aGUgY2xpZW50IGJlaGF2ZXMgaW1wcm9wZXJseS4gSXQgc2hvdWxkbid0DQo+IGhh
dmUNCj4gc2VudCBhbiBvcGVyYXRpb24gb24gYSBuZXcgY29ubmVjdGlvbiBiZWZvcmUgc2VuZGlu
Zw0KPiBCSU5EX0NPTk5fVE9fU0VTU0lPTi4NCj4gDQo+ID4gVGhlIHNlcnZlciBjYW4gYWx3YXlz
IHJlamVjdCB0aGUgY2xpZW50J3MgYmFjayBjaGFubmVsIGNyZWF0aW9uDQo+ID4gYXR0ZW1wdCwg
YnV0IGRvaW5nIHNvIGhhcyBjb25zZXF1ZW5jZXM6IGl0IG1lYW5zIHRoZXJlIGlzIG5vIHdheSB0
bw0KPiA+IGhhbmQgb3V0IGRlbGVnYXRpb25zIG9yIGxheW91dHMuIFNvIEknbSBjb25mdXNlZCBi
eSB0aGUgY29uY2VwdCBvZg0KPiA+IGENCj4gPiBzZXJ2ZXIgdGhhdCBzZXRzIFNFUTRfU1RBVFVT
X0NCX1BBVEhfRE9XTiBvcg0KPiA+IFNFUTRfU1RBVFVTX0NCX1BBVEhfRE9XTl9TRVNTSU9OLCBi
dXQgdGhlbiBkb2Vzbid0IGFsbG93IHRoZSBjbGllbnQNCj4gPiB0bw0KPiA+IHNldCBhIGJhY2sg
Y2hhbm5lbC4NCj4gDQo+IEJlY2F1c2Ugd2UgY2FuJ3QgZ3VhcmFudGVlIHRoYXQgQklORF9DT05O
X1RPX1NFU1NJT04gaGFwcGVucyBhcyB0aGUNCj4gZmlyc3Qgb3BlcmF0aW9uLCBJIHRoaW5rIHRo
ZSBzb2x1dGlvbiBpcyBmb3IgdGhlIHRyYW5zcG9ydCB0aGF0IHdpbGwNCj4gZG8gRk9SRV9PUl9C
T1RIIHJlcXVlc3QsIHRoZSBjbGllbnQgbXVzdCByZXNldCB0aGUgY29ubmVjdGlvbiBmaXJzdD8N
Cj4gV291bGQgdGhhdCBiZSBhY2NlcHRhYmxlPw0KPiANCg0KSXQgc291bmRzIGxpa2Ugd2UgaGF2
ZSBubyBjaG9pY2UuIEhvd2V2ZXIgaW4gdGhhdCBjYXNlLCB3ZSBzaG91bGQgbm90DQp0cnkgdG8g
cmVjb3ZlciBpbiB0aGUgY2FzZSB3aGVyZSB0aGUgYXR0ZW1wdCB0byBiaW5kIHRoZSBiYWNrY2hh
bm5lbA0KZmFpbHMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
