Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1717A21DE44
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2020 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgGMRKW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Jul 2020 13:10:22 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:30977
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729659AbgGMRKV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 Jul 2020 13:10:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YACDf1NR04myBqeU4hvTSktU3lCdRLdNhGJfE6m9OqTKhz0iNwbPJ8L4FhYsODV5ZbW7l8GKRt/HWIwEuqkQtgP8ZOifJfdoUWJftBd51fgo8Ud5gyp5+TXH0Ty4oJpBbLt3lhxTCzbW03oVQkQzQ90sijzPS4qJm+otPpdJPL8IgPCaozPRXQc/tf/Mx4sUfIt+XllHQjAQsGdZiLCQhPQ7EnMxKuCWDvDIpteYzS6loaA6anNa2grGyneuRLkSgpxq8rBN0RXm+4uSlptNsewZxdrWa1jfWyQL9/aY7NiQkCoxQRIOzP9ygTDMW0NX4/GAN7lD3JmA5YvDX/3bWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OxI+X0U6nsfqPFFZ87LvBndzYID/ttC/qUfU1noEAk=;
 b=Pptj4DvlBMuxe9WjFCiWNp4jKsmHrsvHdSUaQk+nPrj8jxyq+Uf4g8dDtBue4J7AeVelCwFT7Hx03sQDQf+RqdwmFdWcvIm7hxx0u9ej5f9lGvaiR6Jws5BJohcuectFs5nt9BsQTUr8SP7eHuKW+an2+Uu/lBw9iRpyGGCyViW8s3wunen6yLNSpiJVeb3C2pmB42Cu07/k2cBlmxIYouLBz16RiPKngLv7qprJtmHENi+lacKu+Bd+EUHG1AYGn3Lfr6Emb/bY9lFZAZCiKiI+dJyLQ8rTh553t1b5QUiy9g9Igq7k0YiM0ywJDSFQ0Wwka1OTNmiFN6tLogvmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OxI+X0U6nsfqPFFZ87LvBndzYID/ttC/qUfU1noEAk=;
 b=K+XR5aClQ0AiX4TDkzVeLTW5sy1Dk1+Lns/FasaOETdm72NYRvgN1abD8xWU7qgJa4mY5vuVn2KYDq2Pp8v6lJUUmI9+M2Cy0buVUAkegachpShC2291QdUTll3KbiK3BcJpseOg41o1f2iADahvW8nkm21DKbO8JFEdZiMQQ5U=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3447.namprd13.prod.outlook.com (2603:10b6:610:21::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10; Mon, 13 Jul
 2020 17:10:17 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::352c:f318:f4a7:6a0f%3]) with mapi id 15.20.3195.017; Mon, 13 Jul 2020
 17:10:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] SUNRPC dont update timeout value on connection
 reset
Thread-Topic: [PATCH v2 1/1] SUNRPC dont update timeout value on connection
 reset
Thread-Index: AQHWWTEI4Pb0YBP7ekKdEYT3RCfTrakFvpIA
Date:   Mon, 13 Jul 2020 17:10:17 +0000
Message-ID: <593f2f82f09b6f0eda01f7980bb9ea9bb179c628.camel@hammerspace.com>
References: <20200713161842.90553-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200713161842.90553-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28142d74-341d-40ea-79ef-08d8274f9dfb
x-ms-traffictypediagnostic: CH2PR13MB3447:
x-microsoft-antispam-prvs: <CH2PR13MB3447EDEE1A5DF9CA7DE8543FB8600@CH2PR13MB3447.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j1/PbFYsViW5Wjuoqge4TgEAxlIRTFFFejEnyZgr6YIBFOlIjbAmcQ2dC9oQX1bXJUNA+ddkM419xMvwxXtQyvWgKYmVJ1YWD0x32lGF0wkv++ykKc7xS9Z7jZX1ylHS+P4PsTSTxD+tnac15THZByGJYo4I3HUqpIwRBWSwqXmhi3JNYoGa8Rh3g6Nvp/fQiIr3kVc5IJSZmTRQxOInHgYmBfZ9XzesixFGQGyVdnxThfPcG2G1oLIGUP4MEgM+LQauBYcafcgJyNO7MWOkhh/FVbQlEkovfeyoUKUVVUvbKkbokb28e9KzR5EGaA3q6PibpRIgpnPDVnkbCTkYfhIZEfNuHMKXoI1clu8QVsir/2LzJ48NWld//UChqJpF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(39830400003)(136003)(396003)(346002)(4326008)(5660300002)(186003)(6512007)(2906002)(478600001)(71200400001)(26005)(2616005)(8936002)(6486002)(66556008)(66446008)(110136005)(8676002)(64756008)(66476007)(86362001)(66946007)(6506007)(76116006)(83380400001)(316002)(36756003)(15650500001)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xJxUh+Ki+Tg2al5YFoNGKVr1xrfk8V8xm9mjxXGoWGiHGFXLJ7VNfS3Cfxiy8DseB8/LvazhdgFqY68LnXnsa3wWpjRMMRtMWJ3GbRhK9ycJ8NllFvwpJ3YKpr5KI5g6KP9g5IOWXFVjUlkoz+Mmad66PjWnPzn4pODnoWiSlvr1OsSxUbXQTXs/gd7hpYIVQrUbmENZNxSNvOKl8gslH4odh5DbHTizH1UH/GjLPa9w2CyYfIihq+nNmhtNFZJFja+Zg+oWMCTobgsU/HR8er4N47N/MhGPuW5EH8ohABTrbzKPPkqQ0EL9pgWQAIj3c1VuQkGTY3NwLOynIS0fllfTvWTvxjfg0RbY+WwXsGTN8Ujw+fEOnWnsogn+0EGj0fwcSUxf3+xq64ffpkq+tptTUzSTfwwnPqbdFmfiMVvLHqxjqverbSMiGGVbYmSSFRmCvUbf7M/MorudeeFkfAf/HKU81FrzO7Egl8FosIA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0596E24D12044D8A3903A70B780857@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28142d74-341d-40ea-79ef-08d8274f9dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 17:10:17.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXcnwwpn/rNivtE0nNNJ8r8IEWv6I14bOJdHfwyxVQEpUnhzWmpYZLC8F9H+9smJ25Koo93MN181hJbjEULLeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3447
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gTW9uLCAyMDIwLTA3LTEzIGF0IDEyOjE4IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gQ3VycmVudCBiZWhhdmlvdXI6IGV2ZXJ5IHRpbWUgYSB2MyBvcGVy
YXRpb24gaXMgcmUtc2VudCB0byB0aGUgc2VydmVyDQo+IHdlIHVwZGF0ZSAoZG91YmxlKSB0aGUg
dGltZW91dC4gVGhlcmUgaXMgbm8gZGlzdGluY3Rpb24gYmV0d2Vlbg0KPiB3aGV0aGVyDQo+IG9y
IG5vdCB0aGUgcHJldmlvdXMgdGltZXIgaGFkIGV4cGlyZWQgYmVmb3JlIHRoZSByZS1zZW50IGhh
cHBlbmVkLg0KPiANCj4gSGVyZSdzIHRoZSBzY2VuYXJpbzoNCj4gMS4gQ2xpZW50IHNlbmRzIGEg
djMgb3BlcmF0aW9uDQo+IDIuIFNlcnZlciBSU1QtcyB0aGUgY29ubmVjdGlvbiAocHJpb3IgdG8g
dGhlIHRpbWVvdXQpIChlZy4sDQo+IGNvbm5lY3Rpb24NCj4gaXMgaW1tZWRpYXRlbHkgcmVzZXQp
DQo+IDMuIENsaWVudCByZS1zZW5kcyBhIHYzIG9wZXJhdGlvbiBidXQgdGhlIHRpbWVvdXQgaXMg
bm93IDEyMHNlYy4NCj4gDQo+IEFzIGEgcmVzdWx0LCBhbiBhcHBsaWNhdGlvbiBzZWVzIDJtaW5z
IHBhdXNlIGJlZm9yZSBhIHJldHJ5IGluIGNhc2UNCj4gc2VydmVyIGFnYWluIGRvZXMgbm90IHJl
cGx5Lg0KPiANCj4gSW5zdGVhZCwgdGhpcyBwYXRjaCBwcm9wb3NlcyB0byBrZWVwIHRyYWNrIG9m
ZiB3aGVuIHRoZSBtaW5vciB0aW1lb3V0DQo+IHNob3VsZCBoYXBwZW4gYW5kIGlmIGl0IGRpZG4n
dCwgdGhlbiBkb24ndCB1cGRhdGUgdGhlIG5ldyB0aW1lb3V0Lg0KPiANCj4gdjI6IHVzaW5nIHRo
ZSBzdWdnZXN0ZWQgYXBwcm9hY2ggYnkgVHJvbmQgTXlrbGVidXN0IGFuZCBub3QgdXNlIHRoZSAN
Cj4gc2xpZGluZyB0aW1lb3V0LiANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNr
YWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvbGludXgvc3VucnBjL3hw
cnQuaCB8IDEgKw0KPiAgbmV0L3N1bnJwYy94cHJ0LmMgICAgICAgICAgIHwgOSArKysrKysrKysN
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvc3VucnBjL3hwcnQuaA0KPiBiL2luY2x1ZGUvbGludXgvc3VucnBjL3hw
cnQuaA0KPiBpbmRleCBlNjRiZDgyLi5hNjAzZDQ4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3N1bnJwYy94cHJ0LmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oDQo+
IEBAIC0xMDEsNiArMTAxLDcgQEAgc3RydWN0IHJwY19ycXN0IHsNCj4gIAkJCQkJCQkgKiB1c2Vk
IGluIHRoZQ0KPiBzb2Z0aXJxLg0KPiAgCQkJCQkJCSAqLw0KPiAgCXVuc2lnbmVkIGxvbmcJCXJx
X21ham9ydGltZW87CS8qIG1ham9yIHRpbWVvdXQNCj4gYWxhcm0gKi8NCj4gKwl1bnNpZ25lZCBs
b25nCQlycV9taW5vcnRpbWVvOwkvKiBtaW5vciB0aW1lb3V0DQo+IGFsYXJtICovDQo+ICAJdW5z
aWduZWQgbG9uZwkJcnFfdGltZW91dDsJLyogQ3VycmVudCB0aW1lb3V0DQo+IHZhbHVlICovDQo+
ICAJa3RpbWVfdAkJCXJxX3J0dDsJCS8qIHJvdW5kLXRyaXAgdGltZSAqLw0KPiAgCXVuc2lnbmVk
IGludAkJcnFfcmV0cmllczsJLyogIyBvZiByZXRyaWVzICovDQo+IGRpZmYgLS1naXQgYS9uZXQv
c3VucnBjL3hwcnQuYyBiL25ldC9zdW5ycGMveHBydC5jDQo+IGluZGV4IGQ1Y2M1ZGIuLjkyZmM5
ZmQgMTAwNjQ0DQo+IC0tLSBhL25ldC9zdW5ycGMveHBydC5jDQo+ICsrKyBiL25ldC9zdW5ycGMv
eHBydC5jDQo+IEBAIC02MDcsNiArNjA3LDExIEBAIHN0YXRpYyB2b2lkIHhwcnRfcmVzZXRfbWFq
b3J0aW1lbyhzdHJ1Y3QNCj4gcnBjX3Jxc3QgKnJlcSkNCj4gIAlyZXEtPnJxX21ham9ydGltZW8g
Kz0geHBydF9jYWxjX21ham9ydGltZW8ocmVxKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQg
eHBydF9yZXNldF9taW5vcnRpbWVvKHN0cnVjdCBycGNfcnFzdCAqcmVxKQ0KPiArew0KPiArCXJl
cS0+cnFfbWlub3J0aW1lbyA9IGppZmZpZXMgKyByZXEtPnJxX3RpbWVvdXQ7DQoNClNob3VsZG4n
dCB0aGlzIGp1c3QgYmU6IHJlcS0+cnFfbWlub3J0aW1lbyArPSByZXEtPnJxX3RpbWVvdXQ7ID8N
Cg0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCB4cHJ0X2luaXRfbWFqb3J0aW1lbyhzdHJ1Y3Qg
cnBjX3Rhc2sgKnRhc2ssIHN0cnVjdA0KPiBycGNfcnFzdCAqcmVxKQ0KPiAgew0KPiAgCXVuc2ln
bmVkIGxvbmcgdGltZV9pbml0Ow0KPiBAQCAtNjE4LDYgKzYyMyw3IEBAIHN0YXRpYyB2b2lkIHhw
cnRfaW5pdF9tYWpvcnRpbWVvKHN0cnVjdCBycGNfdGFzaw0KPiAqdGFzaywgc3RydWN0IHJwY19y
cXN0ICpyZXEpDQo+ICAJCXRpbWVfaW5pdCA9IHhwcnRfYWJzX2t0aW1lX3RvX2ppZmZpZXModGFz
ay0+dGtfc3RhcnQpOw0KPiAgCXJlcS0+cnFfdGltZW91dCA9IHRhc2stPnRrX2NsaWVudC0+Y2xf
dGltZW91dC0+dG9faW5pdHZhbDsNCj4gIAlyZXEtPnJxX21ham9ydGltZW8gPSB0aW1lX2luaXQg
KyB4cHJ0X2NhbGNfbWFqb3J0aW1lbyhyZXEpOw0KPiArCXJlcS0+cnFfbWlub3J0aW1lbyA9IHRp
bWVfaW5pdCArIHJlcS0+cnFfdGltZW91dDsNCj4gIH0NCj4gIA0KPiAgLyoqDQo+IEBAIC02MzEs
NiArNjM3LDggQEAgaW50IHhwcnRfYWRqdXN0X3RpbWVvdXQoc3RydWN0IHJwY19ycXN0ICpyZXEp
DQo+ICAJY29uc3Qgc3RydWN0IHJwY190aW1lb3V0ICp0byA9IHJlcS0+cnFfdGFzay0+dGtfY2xp
ZW50LQ0KPiA+Y2xfdGltZW91dDsNCj4gIAlpbnQgc3RhdHVzID0gMDsNCj4gIA0KPiArCWlmICh0
aW1lX2JlZm9yZShqaWZmaWVzLCByZXEtPnJxX21pbm9ydGltZW8pKQ0KPiArCQlyZXR1cm4gc3Rh
dHVzOw0KPiAgCWlmICh0aW1lX2JlZm9yZShqaWZmaWVzLCByZXEtPnJxX21ham9ydGltZW8pKSB7
DQo+ICAJCWlmICh0by0+dG9fZXhwb25lbnRpYWwpDQo+ICAJCQlyZXEtPnJxX3RpbWVvdXQgPDw9
IDE7DQo+IEBAIC02NDksNiArNjU3LDcgQEAgaW50IHhwcnRfYWRqdXN0X3RpbWVvdXQoc3RydWN0
IHJwY19ycXN0ICpyZXEpDQo+ICAJCXNwaW5fdW5sb2NrKCZ4cHJ0LT50cmFuc3BvcnRfbG9jayk7
DQo+ICAJCXN0YXR1cyA9IC1FVElNRURPVVQ7DQo+ICAJfQ0KPiArCXhwcnRfcmVzZXRfbWlub3J0
aW1lbyhyZXEpOw0KPiAgDQo+ICAJaWYgKHJlcS0+cnFfdGltZW91dCA9PSAwKSB7DQo+ICAJCXBy
aW50ayhLRVJOX1dBUk5JTkcgInhwcnRfYWRqdXN0X3RpbWVvdXQ6IHJxX3RpbWVvdXQgPQ0KPiAw
IVxuIik7DQoNCk90aGVyd2lzZSBpdCBsb29rcyBnb29kIHRvIG1lLg0KDQotLSANClRyb25kIE15
a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
