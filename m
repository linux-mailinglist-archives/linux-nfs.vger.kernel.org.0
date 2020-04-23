Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903E81B6694
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2020 23:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgDWV5r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Apr 2020 17:57:47 -0400
Received: from mail-dm6nam10on2132.outbound.protection.outlook.com ([40.107.93.132]:57408
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbgDWV5r (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 Apr 2020 17:57:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkYuJDQqHX0opc9rUhmhiYvNip/gMSZZRZ7THMhqFN42/HPYeLXdks4WMh9r45I1AA8ixjFL107nHXf3xkmuTJcWP2i2HxpSmoPCHeM2onJ6/Bh/HfDtWE9+otqhn0e84skUg5YvtbNUMFtfcWkAMEk+Vgtv4Eh9ip0LEPkgJH170LzKuGVYEXPkIAhGmbLR7SaoHbmc4AjHF/2adBI6vGVO2gF3El/pLh+AiRRqYet1S1GBsIXawnlaqgJS8K7M4u5j0P5tILRskk3eJXbisDz7MsxX5I/jZ3V4n5lqPaCpLmP6whg6Cy9Fh4ZbFwGmr/unj1v8rZMvEWaAjqg9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ12HgCdrZlCe5xsfJVEVrr2nPKDeur2kTiTMBtkUzU=;
 b=aDb5RHDhKiaumRwOUmvbmUC2+S5l4TjySDhhQHRn0mO1c+nohPdh6XaPSTijF3vRF8HlOw+XT/wM45oPEFU9iHGjed+svQPlzQjR6KdB9pvK/UvDP7WRVs1CopcBxOCkOdRj03TpP0ubwJy1DwmpF2lv6/CDqwaDLCzQdzeh7AC/nmRKXfImxvyY02+XkZCrA4wB1FeRZCROgwbtOZTJ1Vtbu+REam4hzufWw2CmAi7hbqO1XX6YAr7vf32QKSCARskTjT9X3EQGwSw8b7qFll9e+qL2LCA67Qm1Q7lRKwsfEP8tSynwz3QKyFxCSqpZjOk+ML8SzxwxH5U7s0kZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ12HgCdrZlCe5xsfJVEVrr2nPKDeur2kTiTMBtkUzU=;
 b=HkDzeJxxnrIIozVpnS8KHb7+fRXL4a910nM9isNxoUs1e2OyDxoVMuAdiJ/dTh17cymv1RHd4qB9XXyeeoEVG0o9vEQrEYaTKfL2ZI8fD73YRvlTqJlIhLqKQsJHvB/eVIHtpm0FOCJQJdnw3fAR9IEFcgqGYOupgvZ9RLOQ3jg=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3655.namprd13.prod.outlook.com (2603:10b6:610:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.11; Thu, 23 Apr
 2020 21:57:43 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 21:57:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Topic: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Thread-Index: AQHWFMsRjFm2JNXk8kav0WOkI+SUpah9cM+AgAADbACAAApfgIAAB24AgAAB0wCABIX4AIAAA9IAgAALwoCAAAGUAIAAQ8uAgAAJagCAAB1LgIABeD4AgAAaJACAAyhOAIAABqsA
Date:   Thu, 23 Apr 2020 21:57:43 +0000
Message-ID: <554bfe33f450f2adee221101c9762249b60c63df.camel@hammerspace.com>
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
         <f428e641a062c18c2fcf87a662791cc1711d93c3.camel@hammerspace.com>
         <CAN-5tyFazxkCTbj9MspP18ACuZzPfP8q-Kr0PLdQEaQXQy0Hkg@mail.gmail.com>
In-Reply-To: <CAN-5tyFazxkCTbj9MspP18ACuZzPfP8q-Kr0PLdQEaQXQy0Hkg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f83c689-3234-488b-ed0d-08d7e7d159ed
x-ms-traffictypediagnostic: CH2PR13MB3655:
x-microsoft-antispam-prvs: <CH2PR13MB36555C2B30DA5674D26A3960B8D30@CH2PR13MB3655.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(39830400003)(346002)(376002)(478600001)(2906002)(91956017)(71200400001)(81156014)(186003)(8676002)(66476007)(76116006)(6486002)(4326008)(5660300002)(66946007)(64756008)(66446008)(86362001)(6512007)(66556008)(316002)(6916009)(53546011)(2616005)(6506007)(8936002)(54906003)(26005)(36756003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XmPROVD/qmI8XShlArMcWJ5MgwXjhcYMSnLb7j+ArkaUfWUUXgc5R873imsEnj743vqssoDO6CZ6UdUoI62cT1cFIcDwlaM+WAreIm53SqJSt3cPqQceL+WZC18QOYWnBfXkrvAI+xSt+rb34FT40DZOOloA9cj813M8wh3BN9olyvg9Go/25QtB5/jFQhnr0102zIMm16LZXmlLb9dZFXQmyIIG7sqvw5yQl59vOBk/6N5O6UBhPkBn58YESgCer/KMNznImlFM+dRBe+b8MLuh1Oaqpl9AlI6JLtTGs4sCNxCWjtdHt0ceafgAYKu/2shkUWjOsx0wz98ZRgLCw1G6Qg1qN0ETiGAfFvCuQDMLxqeuT194TWc3YHeM6P4KJLw1Bmr3aSNvJ0OyWPLE2lRVPFKYs3tzkPD4admXVybXq9mJUEqHoPa0jg3TcDaK
x-ms-exchange-antispam-messagedata: rasO8Sby1qW4LKLaKjxFG6c/a1eLgyVTrsbpnuDUiyWE+fIwgCoxz+moWNQtoAYHraxS9Cg2KlUQ9wp/cwiwTKlZAxd66Gat6JyPGCGknbfB0JOAwGAV0ystumhwngPTxZ/2EFyGgvZAJ+OrfUnbnMxZWaZKih0ySopuU452+ZNN+PBvcDQ4RRJBsOPk3tuLek+79knfLb/uwtujzLKkhy8/4gklWzmBrsWDQdt3EXybJXjgVUDg51YDCk7U9blAEukEn7i04+IqksFzuleR45ezFCFgcMLB0us9+GA9+jFLxOwMXXV/+wlqskGv/XTvQOxUKFzg1J5iQdMIDj9RgLFX0wTPHXiIBbd3zu5t037gL85nunDQFYJxgp0gC12jAmVbuVVZ6NbBwzqgK2P8pInvOiktOParX0h1W3XZvKc1R/++7bPP5eRQzWRkRrjiv4pbdXNWHbOJnNU7G/+bSUehyJGz4C5wRn4Zmv4Llt++TXnFy4sVEHnGIUsOeWTKoP2WYbiL2zn694KduBC0X02zWalDmips0DI7Hcf28Z38fW33Ue0Nn46JGs99KkgeGPqRuKJrDW7GaHx4KjhMrqX4Cn+3Hc/U4ZI83m8QP8iQFeQ38vsL52Esp8+1XaqfnqmIa2jrB/sOfHBJf3PcLvTcsKhig6wS53wqODjhGpIfCJGfehx45mlnRX76XAp5+Fsc99bq59yQXZNbPKqJBr2gsMfQLEkFB8wsSjs+4zGhOQMnZaueOcw9tz2IFyvdKxLKQYeJzykpLm4ltdnlWHlRnV04V8ucQxuZIeOHCFg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF50B55A80B1F941A81289B711D88F12@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f83c689-3234-488b-ed0d-08d7e7d159ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 21:57:43.7941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xxiwv8/LU2y5va3IET57vfg0oV4yz4y8o5okXb5OIehP06o3jGtEvArzDe9uoupEDWRs8dIWtSeRbwQ/MjMMeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3655
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTIzIGF0IDE3OjMzIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBBcHIgMjEsIDIwMjAgYXQgNToyMCBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTA0LTIx
IGF0IDE1OjQ3IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+IE9uIE1vbiwg
QXByIDIwLCAyMDIwIGF0IDU6MjAgUE0gVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+IHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gT24gTW9uLCAyMDIwLTA0LTIwIGF0IDE1
OjM1IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24sIEFw
ciAyMCwgMjAyMCBhdCAzOjAyIFBNIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gPiA+ID4gdHJvbmRt
eUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gTW9uLCAyMDIwLTA0LTIw
IGF0IDEwOjU5IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
T24gTW9uLCBBcHIgMjAsIDIwMjAgYXQgMTA6NTMgQU0gT2xnYSBLb3JuaWV2c2thaWEgPA0KPiA+
ID4gPiA+ID4gPiBvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+
ID4gPiA+IFllcyB3ZSBhcmUgY29uc2lzdGVudCBpbiByZXF1ZXN0aW5nIHRvIHNhbWUgY29ubmVj
dGlvbg0KPiA+ID4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiA+ID4gd2l0aA0KPiA+ID4gPiA+
ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+IHNhbWUgY2hhbm5lbCBiaW5kaW5nLCBidXQgd2Ug
ZG9uJ3Qgc2VuZA0KPiA+ID4gPiA+ID4gPiA+IEJJTkRfQ09OTl9UT19TRVNTSU9OIGFzDQo+ID4g
PiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gZmlyc3QgdGhpbmcgb24gdGhlICJtYWlu
IiBjb25uZWN0aW9uIChpZSBjb25uZWN0aW9uDQo+ID4gPiA+ID4gPiA+ID4gdGhhdA0KPiA+ID4g
PiA+ID4gPiA+IGNhcmVkDQo+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gQ1JF
QVRFX1NFU1NJT04gYW5kIHdhcyBib3VuZCB0byBmb3JlIGFuZCBiYWNrIGNoYW5uZWwNCj4gPiA+
ID4gPiA+ID4gPiBieQ0KPiA+ID4gPiA+ID4gPiA+IGRlZmF1bHQpLg0KPiA+ID4gPiA+ID4gPiA+
IFdoZW4gdGhhdCBjb25uZWN0aW9uIGlzIHJlc2V0LCB0aGUgZmlyc3QgdGhpbmcgdGhhdA0KPiA+
ID4gPiA+ID4gPiA+IGhhcHBlbnMNCj4gPiA+ID4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+ID4gPiA+
IHRoZQ0KPiA+ID4gPiA+ID4gPiA+IGNsaWVudCByZS1zZW5kcyB0aGUgb3BlcmF0aW9uIHRoYXQg
d2FzIG5vdCByZXBsaWVkIHRvLg0KPiA+ID4gPiA+ID4gPiA+IFRoYXQNCj4gPiA+ID4gPiA+ID4g
PiBoYXMNCj4gPiA+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gPiA+ID4gU0VRVUVOQ0UgYW5kIGJ5
IHRoZSBydWxlIHRoZSBzZXJ2ZXIgYmluZHMgdGhhdA0KPiA+ID4gPiA+ID4gPiA+IGNvbm5lY3Rp
b24NCj4gPiA+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4g
PiA+IGZvcmUgY2hhbm5lbCBvbmx5IChhbmQgc2V0cyB0aGUgY2FsbGJhY2sgYmVpbmcgZG93biku
DQo+ID4gPiA+ID4gPiA+ID4gV2UNCj4gPiA+ID4gPiA+ID4gPiB0aGVuDQo+ID4gPiA+ID4gPiA+
ID4gc2VuZA0KPiA+ID4gPiA+ID4gPiA+IEJJTkRfQ09OTl9UT19TRVNTSU9OIGFuZCByZXF1ZXN0
IEZPUkVfT1JfQk9USCB3aGVyZQ0KPiA+ID4gPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiA+ID4g
PiBoYXMNCj4gPiA+ID4gPiA+ID4gPiBhbHJlYWR5IGJlZW4gYm91bmQgdG8gRk9SRSBvbmx5Lg0K
PiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gSG93IGFib3V0
IHRoaXM6IGJlZm9yZSB3ZSBzZW5kIEJJTkRfQ09OTl9UT19TRVNTSU9OIHdpdGgNCj4gPiA+ID4g
PiA+ID4gZm9yZV9vcl9ib3RoLCB3ZSBzb21laG93IGFsd2F5cyByZXNldCB0aGUgY29ubmVjdGlv
bg0KPiA+ID4gPiA+ID4gPiAobWF5YmUNCj4gPiA+ID4gPiA+ID4geW91DQo+ID4gPiA+ID4gPiA+
IHdlcmUNCj4gPiA+ID4gPiA+ID4gc3VnZ2VzdGlvbiB0aGF0IGFscmVhZHkgYW5kIGkgd2Fzbid0
IGZvbGxvd2luZykuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE5vLiBJIGRpZG4ndCByZWFs
aXNlIHRoYXQgd2Ugd2VyZSBiZWluZyBhdXRvbWF0aWNhbGx5IHNldA0KPiA+ID4gPiA+ID4gdG8N
Cj4gPiA+ID4gPiA+IGp1c3QNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gZm9yZSBjaGFu
bmVsLiBIb3dldmVyIGFzIEkgc2FpZCBlYXJsaWVyLCB0aGUgc3BlYyBzYXlzIHRoYXQNCj4gPiA+
ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gc2VydmVyDQo+ID4gPiA+ID4gPiBNVVNUIHJlcGx5IHdp
dGggTkZTNEVSUl9JTlZBTCBpbiB0aGlzIGNhc2UuIEl0IGlzIG5vdA0KPiA+ID4gPiA+ID4gYWxs
b3dlZA0KPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+IGp1c3QNCj4gPiA+ID4gPiA+IHJldHVy
biBORlM0X09LIGFuZCBzaWxlbnRseSBzZXQgdGhlIHdyb25nIGNoYW5uZWwgYmluZGluZy4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBIb3cncyB0aGlzOg0KPiA+ID4gPiA+IGNsaWVudCBzZW5kcyBC
SU5EX0NPTk5fVE9fU0VTU0lPTiB3aXRoIEZPUkVfT1JfQk9USCwgc2VydmVyDQo+ID4gPiA+ID4g
c2VsZWN0DQo+ID4gPiA+ID4gRk9SRSBjaGFubmVsLiBjb25uZWN0aW9uIGJyZWFrcyBiZWZvcmUg
dGhlIHJlcGx5IGdldHMgdG8gdGhlDQo+ID4gPiA+ID4gY2xpZW50Lg0KPiA+ID4gPiA+IENsaWVu
dCByZXNlbmRzLiBJcyB0aGUgc2VydmVyIHN1cHBvc2UgdG8gbm93IGZhaWwgd2l0aA0KPiA+ID4g
PiA+IEVSUl9JTlZBTD8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGVyZSBhY3R1YWxseSBpcyBz
dWNoIGEgdGhpbmcgYmV0d2VlbiBkZW1hbmQgYW5kIHJlcXVlc3QuDQo+ID4gPiA+ID4gRk9SRQ0K
PiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+IEJBQ0sgYXJlIGRlbWFuZHMgYW5kIEZPUkVfT1JfQk9U
SCBhbmQgQkFDS19PUl9CT1RIIGFyZQ0KPiA+ID4gPiA+IHJlcXVlc3RzLg0KPiA+ID4gPiA+IFRo
ZQ0KPiA+ID4gPiA+IHNwZWMgd3JpdGVzIG9ubHkgYWJvdXQgZGVtYW5kcyBhbmQgbm90IHRoZSBy
ZXF1ZXN0cy4gSQ0KPiA+ID4gPiA+IGJlbGlldmUNCj4gPiA+ID4gPiB0aGF0J3MNCj4gPiA+ID4g
PiBpbnRlbnRpb25hbCBiZWNhdXNlIEJJTkRfQ09OTl9UT19TRVNTSU9uIGRvZXNuJ3QgaGF2ZSBh
DQo+ID4gPiA+ID4gc2VxdWVuY2UNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiBub3QgcHJvdGVj
dGVkIGJ5IHJlcGx5IHNlc3Npb24gc2VtYW50aWNzLg0KPiA+ID4gPiANCj4gPiA+ID4gT0suIEhv
d2V2ZXIgaWYgd2UgdGFrZSB0aGF0IGludGVycHJldGF0aW9uLCB0aGVuIHRoZSBxdWVzdGlvbg0K
PiA+ID4gPiBpcw0KPiA+ID4gPiB3aHkNCj4gPiA+ID4gd291bGQgdGhlIHNlcnZlciBkb3duZ3Jh
ZGUgb3VyIEZPUkVfT1JfQk9USCB0byBGT1JFIGFuZCB3aGF0IGlzDQo+ID4gPiA+IHRoZQ0KPiA+
ID4gPiBwb2ludCBvZiB0aGUgY2xpZW50IGV2ZW4gcmV0cnlpbmcgYXQgYWxsIGluIHRoYXQgY2Fz
ZT8NCj4gPiA+IA0KPiA+ID4gQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoZSBjbGllbnQgYmVoYXZl
cyBpbXByb3Blcmx5LiBJdCBzaG91bGRuJ3QNCj4gPiA+IGhhdmUNCj4gPiA+IHNlbnQgYW4gb3Bl
cmF0aW9uIG9uIGEgbmV3IGNvbm5lY3Rpb24gYmVmb3JlIHNlbmRpbmcNCj4gPiA+IEJJTkRfQ09O
Tl9UT19TRVNTSU9OLg0KPiA+ID4gDQo+ID4gPiA+IFRoZSBzZXJ2ZXIgY2FuIGFsd2F5cyByZWpl
Y3QgdGhlIGNsaWVudCdzIGJhY2sgY2hhbm5lbCBjcmVhdGlvbg0KPiA+ID4gPiBhdHRlbXB0LCBi
dXQgZG9pbmcgc28gaGFzIGNvbnNlcXVlbmNlczogaXQgbWVhbnMgdGhlcmUgaXMgbm8NCj4gPiA+
ID4gd2F5IHRvDQo+ID4gPiA+IGhhbmQgb3V0IGRlbGVnYXRpb25zIG9yIGxheW91dHMuIFNvIEkn
bSBjb25mdXNlZCBieSB0aGUgY29uY2VwdA0KPiA+ID4gPiBvZg0KPiA+ID4gPiBhDQo+ID4gPiA+
IHNlcnZlciB0aGF0IHNldHMgU0VRNF9TVEFUVVNfQ0JfUEFUSF9ET1dOIG9yDQo+ID4gPiA+IFNF
UTRfU1RBVFVTX0NCX1BBVEhfRE9XTl9TRVNTSU9OLCBidXQgdGhlbiBkb2Vzbid0IGFsbG93IHRo
ZQ0KPiA+ID4gPiBjbGllbnQNCj4gPiA+ID4gdG8NCj4gPiA+ID4gc2V0IGEgYmFjayBjaGFubmVs
Lg0KPiA+ID4gDQo+ID4gPiBCZWNhdXNlIHdlIGNhbid0IGd1YXJhbnRlZSB0aGF0IEJJTkRfQ09O
Tl9UT19TRVNTSU9OIGhhcHBlbnMgYXMNCj4gPiA+IHRoZQ0KPiA+ID4gZmlyc3Qgb3BlcmF0aW9u
LCBJIHRoaW5rIHRoZSBzb2x1dGlvbiBpcyBmb3IgdGhlIHRyYW5zcG9ydCB0aGF0DQo+ID4gPiB3
aWxsDQo+ID4gPiBkbyBGT1JFX09SX0JPVEggcmVxdWVzdCwgdGhlIGNsaWVudCBtdXN0IHJlc2V0
IHRoZSBjb25uZWN0aW9uDQo+ID4gPiBmaXJzdD8NCj4gPiA+IFdvdWxkIHRoYXQgYmUgYWNjZXB0
YWJsZT8NCj4gPiA+IA0KPiA+IA0KPiA+IEl0IHNvdW5kcyBsaWtlIHdlIGhhdmUgbm8gY2hvaWNl
LiBIb3dldmVyIGluIHRoYXQgY2FzZSwgd2Ugc2hvdWxkDQo+ID4gbm90DQo+ID4gdHJ5IHRvIHJl
Y292ZXIgaW4gdGhlIGNhc2Ugd2hlcmUgdGhlIGF0dGVtcHQgdG8gYmluZCB0aGUNCj4gPiBiYWNr
Y2hhbm5lbA0KPiA+IGZhaWxzLg0KPiANCj4gSSBjYW4ndCBnZXQgdGhlIGNsaWVudCB0byByZXNl
dCB0aGUgY29ubmVjdGlvbi4gSXMgY2FsbGluZw0KPiB4cHJ0X2ZvcmNlX2Rpc2Nvbm5lY3QoKSBz
dXBwb3NlIHRvIGRvIHRoYXQ/IElmIHNvLCB0aGVuIHRoYXQgZG9lc24ndA0KPiBoYXBwZW4uIEkg
aGF2ZSB0cmllZCBjYWxsaW5nIGludG8geHBydC0+b3BzLT5jbG9zZSh4cHJ0KSBidXQgdGhhdA0K
PiBsZWFkcyB0byBiYWRuZXNzIGFzIHdlbGwuLi4gQW55IHN1Z2dlc3Rpb25zIG9mIGhvdyB0byBn
ZXQgY29ubmVjdGlvbg0KPiByZXNldD8gSXMgeHNfcmVzZXRfdHJhbnNwb3J0KCkgaXQ/IEl0J3Mg
aGFyZCB0byBmaWd1cmUgb3V0IGhvdyBhbGwNCj4gdGhlc2UgZnVuY3Rpb25zIGFyZSBkaWZmZXJl
bnQgd2hlbiB0aGVpciBuYW1lcyBpbXBseSBjb25uZWN0aW9uDQo+IHJlc2V0dGluZy4uLg0KDQp4
cHJ0X2ZvcmNlX2Rpc2Nvbm5lY3QoKSBzaG91bGQgYmUgdGhlIHJpZ2h0IGZ1bmN0aW9uLg0KDQpO
b3RlLCB0aG91Z2gsIHRoYXQgdGhlIGZ1bmN0aW9uIGlzIGFzeW5jaHJvbm91cyAoaXQgcXVldWVz
IHVwIHRoZSBjYWxsDQp0byB4cHJ0X2F1dG9jbG9zZSgpIG9uIHRoZSB4cHJ0aW9kIHdvcmtxdWV1
ZSksIHNvIGl0IHdvbid0IG5lY2Vzc2FyaWx5DQppbW1lZGlhdGVseSBzaG93IHRoZSBjb25uZWN0
aW9uIGFzIGJlaW5nIGJyb2tlbi4gSG93ZXZlciBpdCBzaG91bGQNCmVuc3VyZSB0aGF0IG5vIGZ1
cnRoZXIgcmVxdWVzdHMgYXJlIHRyYW5zbWl0dGVkIG9uIHRoYXQgeHBydCB1bnRpbA0KYWZ0ZXIg
dGhlIGNvbm5lY3Rpb24gYnJlYWtzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZT
IGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNw
YWNlLmNvbQ0KDQoNCg==
