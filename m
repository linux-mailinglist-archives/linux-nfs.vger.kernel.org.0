Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8432CC9C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 18:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfE1Que (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 12:50:34 -0400
Received: from mail-eopbgr690123.outbound.protection.outlook.com ([40.107.69.123]:53985
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfE1Que (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 12:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrbXh2DIO6oWwZOV4Smnd89gQxzIKslDjt9zzSsvWEo=;
 b=G0PmQp7XU2FMvMwEgIoMBplg+pZhhRAHqNKP/xHvAgbIzWPGRH9rKmzUnJZyBpohmdTq/KNuhZ3foP+DpR3TPPttzrYvV2LhzLZrVXdO1izXHBsSoOcJK3WvCiei0smoSsFyW5prIDVDoDPh3iinpFj+vjG8/QDqswvRCAbHOHY=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1291.namprd13.prod.outlook.com (10.168.120.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.8; Tue, 28 May 2019 16:50:30 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Tue, 28 May 2019
 16:50:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Topic: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Index: AQHVD9OY0U3UwvcYW0a/WB0ITGDVLKZ12MoAgAAKagCAAA2iAIAADnwAgAq0IACAABYAAIAAAQyAgAAAwYA=
Date:   Tue, 28 May 2019 16:50:30 +0000
Message-ID: <e70e3818bf70c45803372e17dd5f158b9c906e6e.camel@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
         <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
         <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
         <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
         <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
         <3503ff03-2895-ae1f-7fed-f30d08b0abfb@RedHat.com>
         <c7a5f97693c56ee0a7dd5a9c0848ee97ab3d2a9e.camel@hammerspace.com>
         <F2801C3F-558A-4176-A0B0-ECD737D4332D@gmail.com>
In-Reply-To: <F2801C3F-558A-4176-A0B0-ECD737D4332D@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66a1317e-6ce8-4f76-8423-08d6e38c980c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1291;
x-ms-traffictypediagnostic: DM5PR13MB1291:
x-microsoft-antispam-prvs: <DM5PR13MB129176BFFC5FF43BEE88A757B81E0@DM5PR13MB1291.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39830400003)(376002)(136003)(199004)(189003)(25786009)(66946007)(66476007)(66446008)(64756008)(66556008)(73956011)(36756003)(7736002)(14454004)(305945005)(229853002)(1361003)(5024004)(14444005)(256004)(6116002)(186003)(68736007)(71200400001)(76176011)(54906003)(76116006)(71190400001)(478600001)(3846002)(4326008)(6486002)(2906002)(118296001)(6916009)(6512007)(6506007)(2351001)(316002)(446003)(53936002)(11346002)(81166006)(6246003)(486006)(2616005)(102836004)(66066001)(6436002)(476003)(86362001)(1730700003)(2501003)(8676002)(53546011)(81156014)(99286004)(8936002)(1411001)(5660300002)(26005)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1291;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ns/UlqH+JGZpV6yEKPrB+FQeKI9YcTJsD+rvOPBYiYRqXK7Jqux3bOLypZFTXPWjZvu03PfV7VlvrRCfGPAQghCPO7KbeBMsGsJrjCy+clhu1vUQaEzJn/ZFGB2Opfe+6iYnW+t5noO9WAVWDPHlVYJ3bpsW32p/La/bEp1cYLTzAHyj6oaiyrXBh72BbMphZv9hbM4xGUerssjMTWwiQs9k7nOhFsa2Tm0S0hLHyZQT57UzMAWPjcEsHAHGMLJUgm6zq529RLbT2TsYjonmEMGcFgo3CD2D7sbrDErbY3qqPEYMqYLz/xMs/8e1fz8aSg20nMh/zs/OXSYFtMJzDOcIgkAy3YVYfFdydKWP20loKDTFadcHqFdQjPC3XXV6E+BgZwc4sYwnCm9dnG6lMqmkTf6LTMFCchm0e1z4gNo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C1B7CA6AEE9734A9EA7E847664C5E2E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a1317e-6ce8-4f76-8423-08d6e38c980c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 16:50:30.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1291
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTI4IGF0IDEyOjQ3IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBNYXkgMjgsIDIwMTksIGF0IDEyOjQ0IFBNLCBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+IHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMTktMDUt
MjggYXQgMTE6MjUgLTA0MDAsIFN0ZXZlIERpY2tzb24gd3JvdGU6DQo+ID4gPiBPbiA1LzIxLzE5
IDM6NTggUE0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDE5LTA1
LTIxIGF0IDE1OjA2IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIE1h
eSAyMSwgMjAxOSwgYXQgMjoxNyBQTSwgVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+ID4gPiA+IHRy
b25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
T24gVHVlLCAyMDE5LTA1LTIxIGF0IDEzOjQwIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiA+ID4gPiA+ID4gSGkgVHJvbmQgLQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBP
biBNYXkgMjEsIDIwMTksIGF0IDg6NDYgQU0sIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gPiA+ID4g
PiA+ID4gdHJvbmRteUBnbWFpbC5jb20NCj4gPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBUaGUgZm9sbG93aW5nIHBhdGNoc2V0IGFkZHMgc3Vw
cG9ydCBmb3IgdGhlICdyb290X2RpcicNCj4gPiA+ID4gPiA+ID4gPiBjb25maWd1cmF0aW9uDQo+
ID4gPiA+ID4gPiA+ID4gb3B0aW9uIGZvciBuZnNkIGluIG5mcy5jb25mLiBJZiBhIHVzZXIgc2V0
cyB0aGlzIG9wdGlvbg0KPiA+ID4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiA+ID4gYQ0KPiA+
ID4gPiA+ID4gPiA+IHZhbGlkDQo+ID4gPiA+ID4gPiA+ID4gZGlyZWN0b3J5IHBhdGgsIHRoZW4g
bmZzZCB3aWxsIGFjdCBhcyBpZiBpdCBpcyBjb25maW5lZA0KPiA+ID4gPiA+ID4gPiA+IHRvDQo+
ID4gPiA+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+ID4gPiA+IGNocm9vdA0KPiA+ID4gPiA+ID4gPiA+
IGphaWwgYmFzZWQgb24gdGhhdCBkaXJlY3RvcnkuIEFsbCBwYXRocyBpbiAvZXRjL2V4cG9yZnMN
Cj4gPiA+ID4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiA+ID4gPiBmcm9tDQo+ID4gPiA+ID4gPiA+
ID4gZXhwb3J0ZnMgYXJlIHRoZW4gcmVzb2x2ZWQgcmVsYXRpdmUgdG8gdGhhdCBkaXJlY3Rvcnku
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBXaGF0IGFib3V0IGZpbGVzIHVuZGVyIC9w
cm9jIHRoYXQgbW91bnRkIG1pZ2h0IGFjY2Vzcz8gSQ0KPiA+ID4gPiA+ID4gPiBhc3N1bWUNCj4g
PiA+ID4gPiA+ID4gdGhlc2UNCj4gPiA+ID4gPiA+ID4gcGF0aG5hbWVzIGFyZSBub3QgYWZmZWN0
ZWQuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhhdCdzIHdoeSB3ZSBoYXZlIDIgdGhy
ZWFkcy4gT25lIHRocmVhZCBpcyByb290IGphaWxlZA0KPiA+ID4gPiA+ID4gdXNpbmcNCj4gPiA+
ID4gPiA+IGNocm9vdCwNCj4gPiA+ID4gPiA+IGFuZCBpcyB1c2VkIHRvIHRhbGsgdG8ga25mc2Qu
IFRoZSBvdGhlciB0aHJlYWQgaXMgbm90IHJvb3QNCj4gPiA+ID4gPiA+IGphaWxlZA0KPiA+ID4g
PiA+ID4gKG9yDQo+ID4gPiA+ID4gPiBhdCBsZWFzdCBub3QgYnkgcm9vdF9kaXIpIGFuZCBzbyBo
YXMgZnVsbCBhY2Nlc3MgdG8gL2V0YywNCj4gPiA+ID4gPiA+IC9wcm9jLA0KPiA+ID4gPiA+ID4g
L3ZhciwNCj4gPiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IEFyZW4n
dCB0aGVyZSBhbHNvIG9uZSBvciB0d28gb3RoZXIgZmlsZXMgdGhhdCBtYWludGFpbg0KPiA+ID4g
PiA+ID4gPiBleHBvcnQNCj4gPiA+ID4gPiA+ID4gc3RhdGUNCj4gPiA+ID4gPiA+ID4gbGlrZSAv
dmFyL2xpYi9uZnMvcm10YWI/IEFyZSB0aG9zZSBhZmZlY3RlZD8NCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gU2VlIGFib3ZlLiBUaGV5IGFyZSBub3QgYWZmZWN0ZWQuDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gSU1ITyBpdCBjb3VsZCBiZSBsZXNzIGNvbmZ1c2luZyB0byBhZG1pbmlz
dHJhdG9ycyB0byBtYWtlDQo+ID4gPiA+ID4gPiA+IHJvb3RfZGlyIGFuDQo+ID4gPiA+ID4gPiA+
IFtleHBvcnRmc10gb3B0aW9uIGluc3RlYWQgb2YgYSBbbW91bnRkXSBvcHRpb24sIGlmIHRoaXMN
Cj4gPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4gbm90IGENCj4gPiA+ID4gPiA+ID4gdHJ1
ZQ0KPiA+ID4gPiA+ID4gPiBjaHJvb3Qgb2YgbW91bnRkLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBJdCBpcyBuZWl0aGVyLiBJIG1hZGUgaW4gYSBbbmZzZF0gb3B0aW9uLCBzaW5jZSBpdCBn
b3Zlcm5zDQo+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiA+IHdheQ0KPiA+ID4gPiA+ID4gdGhh
dA0KPiA+ID4gPiA+ID4gYm90aCBleHBvcnRmcyBhbmQgbW91bnRkIHRhbGsgdG8gbmZzZC4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBNeSBwb2ludCBpcyBub3QgYWJvdXQgaW1wbGVtZW50YXRpb24s
IGl0J3MgYWJvdXQgaG93IHRoaXMNCj4gPiA+ID4gPiBmdW5jdGlvbmFsaXR5DQo+ID4gPiA+ID4g
aXMgcHJlc2VudGVkIHRvIGFkbWluaXN0cmF0b3JzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IElu
IG5mcy5jb25mLCBbbmZzZF0gbG9va3MgbGlrZSBpdCBjb250cm9scyB3aGF0IG9wdGlvbnMgYXJl
DQo+ID4gPiA+ID4gcGFzc2VkDQo+ID4gPiA+ID4gdmlhDQo+ID4gPiA+ID4gcnBjLm5mc2QuIFRo
YXQgc3RpbGwgc2VlbXMgbGlrZSBhIGNvbmZ1c2luZyBhZG1pbiBpbnRlcmZhY2UuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gSU1PIGFkbWlucyB3b24ndCBjYXJlIGFib3V0IHdobyBpcyB0YWxraW5n
IHRvIHdob20uIFRoZXkgd2lsbA0KPiA+ID4gPiA+IGNhcmUNCj4gPiA+ID4gPiBhYm91dA0KPiA+
ID4gPiA+IGhvdyB0aGUgZXhwb3J0IHBhdGhuYW1lcyBhcmUgaW50ZXJwcmV0ZWQuIFRoYXQgc2Vl
bXMgbGlrZSBpdA0KPiA+ID4gPiA+IGJlbG9uZ3MNCj4gPiA+ID4gPiBzcXVhcmVseSB3aXRoIHRo
ZSBleHBvcnRmcyBpbnRlcmZhY2UuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBXaXRo
IHRoZSBleHBvcnRmcyBpbnRlcmZhY2UsIHllcy4gSG93ZXZlciBpdCBpcyBub3Qgc3BlY2lmaWMg
dG8NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGV4cG9ydGZzIHV0aWxpdHksIHNvIHRvIG1lIFtleHBv
cnRmc10gaXMgbW9yZSBjb25mdXNpbmcgdGhhbg0KPiA+ID4gPiB3aGF0DQo+ID4gPiA+IGV4aXN0
cyBub3cuDQo+ID4gPiA+IA0KPiA+ID4gPiBPSywgc28gd2hhdCBpZiB3ZSBwdXQgaXQgaW4gW2dl
bmVyYWxdIGluc3RlYWQsIGFuZCBwZXJoYXBzDQo+ID4gPiA+IHJlbmFtZQ0KPiA+ID4gPiBpdA0K
PiA+ID4gPiAiZXhwb3J0X3Jvb3RkaXIiPw0KPiA+ID4gPiANCj4gPiA+IEknbSBqdXN0IGNhdGNo
aW5nIHVwLi4uIG15IGFwb2xvZ2llcyB0YXJ0bmVzcy4uLg0KPiA+ID4gDQo+ID4gPiBTbyBzZXR0
aW5nIHJvb3RfZGlyIGVmZmVjdHMgKmFsbCogZXhwb3J0cyBpbiAvZXRjL2V4cG9ydHM/IA0KPiA+
ID4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgdGhhdCBvbmUgdmFyaWFibGUgY2FuIGNoYW5nZSBodW5k
cmVkcw0KPiA+ID4gb2YgZXhwb3J0Li4uIGlzIHRoYXQgd2hhdCB3ZSByZWFsbHkgd2FudD8NCj4g
PiA+IA0KPiA+ID4gV291bGRuJ3QgYmUgYmV0dGVyIHRvIGhhdmUgYSBsaXR0bGUgbW9yZSBncmFu
dWxhcml0eT8gDQo+ID4gDQo+ID4gQ2FuIHlvdSBleHBsYWluIHdoYXQgeW91IG1lYW4/IFRoZSBp
bnRlbnRpb24gaGVyZSBpcyB0aGF0IGlmIHlvdQ0KPiA+IGhhdmUNCj4gPiBhbGwgeW91ciBleHBv
cnRlZCBmaWxlc3lzdGVtcyBzZXQgdXAgaW4gYSBzdWJ0cmVlIHVuZGVyDQo+ID4gL21udC9teS9l
eHBvcnRzLCB0aGVuIHlvdSBjYW4gcmVtb3ZlIHRoYXQgdW5uZWNlc3NhcnkgcHJlZml4Lg0KPiA+
IA0KPiA+IFNvLCBmb3IgaW5zdGFuY2UsIGlmIEknbSB0cnlpbmcgdG8gZXhwb3J0IC9tbnQvbXkv
ZXhwb3J0cy9mb28gYW5kDQo+ID4gL21udC9teS9leHBvcnRzL2JhciwgdGhlbiBJIGNhbiBtYWtl
IHRob3NlIHR3byBmaWxlc3lzdGVtcyBhcHBlYXINCj4gPiBhcw0KPiA+IC9mb28sIGFuZCAvYmFy
IHRvIHRoZSByZW1vdGUgY2xpZW50cy4NCj4gPiANCj4gPiBJZiBhbiBhZG1pbiB3YW50cyB0byBy
ZWFycmFuZ2UgYWxsIHRoZSBwYXRocyBpbiAvZXRjL2V4cG9ydHMsIGFuZA0KPiA+IG1ha2UNCj4g
PiBhIGN1c3RvbSBuYW1lc3BhY2UsIHRoZW4gdGhhdCBpcyBwb3NzaWJsZSB1c2luZyBiaW5kIG1v
dW50czoganVzdA0KPiA+IGNyZWF0ZSBhIGRpcmVjdG9yeSAvbXlfZXhwb3J0cywgYW5kIHVzZSBt
b3VudCAtLWJpbmQgdG8gYXR0YWNoIHRoZQ0KPiA+IG5lY2Vzc2FyeSBtb3VudHBvaW50cyBpbnRv
IHRoZSByaWdodCBzcG90cyBpbiAvbXlfZXhwb3J0cywgdGhlbiB1c2UNCj4gPiBleHBvcnRfcm9v
dGRpciB0byByZW1vdmUgdGhlIC9teV9leHBvcnRzIHByZWZpeC4NCj4gDQo+IEp1c3QgdG8gYmUg
Y2xlYXIsIGRvIHlvdSBleHBlY3QgdGhhdCBlYWNoIG1vdW50IG5hbWVzcGFjZSBvbiBhDQo+IExp
bnV4IE5GUyBzZXJ2ZXIgd291bGQgaGF2ZSBpdHMgb3duIC9ldGMvZXhwb3J0cyBhbmQgL2V0Yy9u
ZnMuY29uZiA/DQo+IA0KPiBNYXliZSB5b3Ugc3RhdGVkIHRoYXQgYmVmb3JlLCBhbmQgSSBtaXNz
ZWQgaXQuDQoNClllcywgaWYgeW91IGFyZSBydW5uaW5nIGluIGEgY29udGFpbmVyaXNlZCBlbnZp
cm9ubWVudCwgdGhlbiB5b3Ugd2lsbA0KaGF2ZSB5b3VyIG93biAvZXRjL2V4cG9ydHMsIC9ldGMv
bmZzLmNvbmYsIGV0Yy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
