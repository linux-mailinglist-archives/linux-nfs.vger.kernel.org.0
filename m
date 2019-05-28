Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C12CE5D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfE1STQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:19:16 -0400
Received: from mail-eopbgr760107.outbound.protection.outlook.com ([40.107.76.107]:31947
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbfE1STQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 14:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irS6EBq4Y0rMmyXhZfIk39hXAI7PxXLgORL/Tqb3sYc=;
 b=CdIgPSfnI1LZDHrczVmKRAOKWmL/P2bZk5CJDJCSVGWebzTJ6zRwMN5M2Oun7KvJ1LbKlvsBJ1GqVl4ltD0HwiPFm4D3LLV4Lta7Elmfcb2CaXnVV5KIY4mbLBHHmtkOpeb6QcKe/xGsxytQlpvQeA1pr83i/NDSvKdT8bvHJQI=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1530.namprd13.prod.outlook.com (10.175.110.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.13; Tue, 28 May 2019 18:19:12 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Tue, 28 May 2019
 18:19:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Topic: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Index: AQHVD9OY0U3UwvcYW0a/WB0ITGDVLKZ12MoAgAAKagCAAA2iAIAADnwAgAq0IACAABYAAIAAD+CAgAAKtoA=
Date:   Tue, 28 May 2019 18:19:11 +0000
Message-ID: <af4e638f44baa4344c5a3b826cc1cbd28253bf1e.camel@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
         <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
         <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
         <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
         <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
         <3503ff03-2895-ae1f-7fed-f30d08b0abfb@RedHat.com>
         <c7a5f97693c56ee0a7dd5a9c0848ee97ab3d2a9e.camel@hammerspace.com>
         <0b65f710-f06a-cfd3-a30e-577db8267d5b@RedHat.com>
In-Reply-To: <0b65f710-f06a-cfd3-a30e-577db8267d5b@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e03ce7ec-6dea-4333-c148-08d6e398fbf6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1530;
x-ms-traffictypediagnostic: DM5PR13MB1530:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR13MB1530FD69BF3D5126597BFF82B81E0@DM5PR13MB1530.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(136003)(396003)(366004)(346002)(199004)(189003)(51444003)(25786009)(4326008)(99286004)(118296001)(86362001)(446003)(2616005)(486006)(5660300002)(110136005)(76176011)(66066001)(6506007)(53546011)(6246003)(476003)(26005)(2501003)(186003)(11346002)(102836004)(316002)(256004)(5024004)(14444005)(68736007)(6116002)(8676002)(81156014)(81166006)(3846002)(2906002)(66946007)(53936002)(7736002)(66446008)(64756008)(73956011)(66476007)(229853002)(305945005)(66556008)(76116006)(71190400001)(36756003)(71200400001)(478600001)(14454004)(8936002)(15974865002)(6436002)(6486002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1530;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FQX1ShhA8wCfZlvd3t7Gdv9uu14ry+m/cGPq7PUv+zy+Q/lABD3brreGDu8hE9d9xDoLSmBnr/RU9oGzEBhtvbYUraMDWuYiGZeNOxSZf0+tUJYKb7t3mlT1176EVLKtILP6+K3E8oXdHfuv/GBRn+rJUNti+nIe7Lo0VxaA1ehbMFca3Fgdv6dZxbxdad+dXwjMOZpHXvbxa/MPHt6BH8oItRQFaXJ2i2dl+siQg43sDznPhJvsImTIx5QS/Dq/gO+W+/E8pNzs0mYjg+XH+O2J10kieDmmC5IEthwbXHZI6za3uGRwT0kIvFAdC/x42Y407iqiDyX4zgXT50VRCn7rTRbDMMCzFM4/W8GczluNJPISnTqgBq5WyWeFqSKbXPUOQEPZLgYglDl0YN6O/ebSuwOBC8Qtt6uWZ74BQq0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE7806D845148B4A8FBA82C88EB15EBF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03ce7ec-6dea-4333-c148-08d6e398fbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 18:19:11.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1530
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTI4IGF0IDEzOjQwIC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gT24gNS8yOC8xOSAxMjo0NCBQTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjAxOS0wNS0yOCBhdCAxMToyNSAtMDQwMCwgU3RldmUgRGlja3NvbiB3cm90ZToNCj4g
PiA+IE9uIDUvMjEvMTkgMzo1OCBQTSwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBP
biBUdWUsIDIwMTktMDUtMjEgYXQgMTU6MDYgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+
ID4gPiA+ID4gT24gTWF5IDIxLCAyMDE5LCBhdCAyOjE3IFBNLCBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiA+ID4gPiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiBPbiBUdWUsIDIwMTktMDUtMjEgYXQgMTM6NDAgLTA0MDAsIENodWNrIExl
dmVyIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBIaSBUcm9uZCAtDQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IE9uIE1heSAyMSwgMjAxOSwgYXQgODo0NiBBTSwgVHJvbmQgTXlrbGVidXN0
IDwNCj4gPiA+ID4gPiA+ID4gPiB0cm9uZG15QGdtYWlsLmNvbQ0KPiA+ID4gPiA+ID4gPiA+IHdy
b3RlOg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFRoZSBmb2xsb3dpbmcgcGF0
Y2hzZXQgYWRkcyBzdXBwb3J0IGZvciB0aGUgJ3Jvb3RfZGlyJw0KPiA+ID4gPiA+ID4gPiA+IGNv
bmZpZ3VyYXRpb24NCj4gPiA+ID4gPiA+ID4gPiBvcHRpb24gZm9yIG5mc2QgaW4gbmZzLmNvbmYu
IElmIGEgdXNlciBzZXRzIHRoaXMgb3B0aW9uDQo+ID4gPiA+ID4gPiA+ID4gdG8NCj4gPiA+ID4g
PiA+ID4gPiBhDQo+ID4gPiA+ID4gPiA+ID4gdmFsaWQNCj4gPiA+ID4gPiA+ID4gPiBkaXJlY3Rv
cnkgcGF0aCwgdGhlbiBuZnNkIHdpbGwgYWN0IGFzIGlmIGl0IGlzIGNvbmZpbmVkDQo+ID4gPiA+
ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiA+ID4gPiBhDQo+ID4gPiA+ID4gPiA+ID4gY2hyb290DQo+
ID4gPiA+ID4gPiA+ID4gamFpbCBiYXNlZCBvbiB0aGF0IGRpcmVjdG9yeS4gQWxsIHBhdGhzIGlu
IC9ldGMvZXhwb3Jmcw0KPiA+ID4gPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+ID4gPiA+IGZyb20N
Cj4gPiA+ID4gPiA+ID4gPiBleHBvcnRmcyBhcmUgdGhlbiByZXNvbHZlZCByZWxhdGl2ZSB0byB0
aGF0IGRpcmVjdG9yeS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFdoYXQgYWJvdXQg
ZmlsZXMgdW5kZXIgL3Byb2MgdGhhdCBtb3VudGQgbWlnaHQgYWNjZXNzPyBJDQo+ID4gPiA+ID4g
PiA+IGFzc3VtZQ0KPiA+ID4gPiA+ID4gPiB0aGVzZQ0KPiA+ID4gPiA+ID4gPiBwYXRobmFtZXMg
YXJlIG5vdCBhZmZlY3RlZC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGF0J3Mgd2h5
IHdlIGhhdmUgMiB0aHJlYWRzLiBPbmUgdGhyZWFkIGlzIHJvb3QgamFpbGVkDQo+ID4gPiA+ID4g
PiB1c2luZw0KPiA+ID4gPiA+ID4gY2hyb290LA0KPiA+ID4gPiA+ID4gYW5kIGlzIHVzZWQgdG8g
dGFsayB0byBrbmZzZC4gVGhlIG90aGVyIHRocmVhZCBpcyBub3Qgcm9vdA0KPiA+ID4gPiA+ID4g
amFpbGVkDQo+ID4gPiA+ID4gPiAob3INCj4gPiA+ID4gPiA+IGF0IGxlYXN0IG5vdCBieSByb290
X2RpcikgYW5kIHNvIGhhcyBmdWxsIGFjY2VzcyB0byAvZXRjLA0KPiA+ID4gPiA+ID4gL3Byb2Ms
DQo+ID4gPiA+ID4gPiAvdmFyLA0KPiA+ID4gPiA+ID4gLi4uDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gQXJlbid0IHRoZXJlIGFsc28gb25lIG9yIHR3byBvdGhlciBmaWxlcyB0aGF0IG1h
aW50YWluDQo+ID4gPiA+ID4gPiA+IGV4cG9ydA0KPiA+ID4gPiA+ID4gPiBzdGF0ZQ0KPiA+ID4g
PiA+ID4gPiBsaWtlIC92YXIvbGliL25mcy9ybXRhYj8gQXJlIHRob3NlIGFmZmVjdGVkPw0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTZWUgYWJvdmUuIFRoZXkgYXJlIG5vdCBhZmZlY3RlZC4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJTUhPIGl0IGNvdWxkIGJlIGxlc3MgY29uZnVz
aW5nIHRvIGFkbWluaXN0cmF0b3JzIHRvIG1ha2UNCj4gPiA+ID4gPiA+ID4gcm9vdF9kaXIgYW4N
Cj4gPiA+ID4gPiA+ID4gW2V4cG9ydGZzXSBvcHRpb24gaW5zdGVhZCBvZiBhIFttb3VudGRdIG9w
dGlvbiwgaWYgdGhpcw0KPiA+ID4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+ID4gPiBub3QgYQ0KPiA+
ID4gPiA+ID4gPiB0cnVlDQo+ID4gPiA+ID4gPiA+IGNocm9vdCBvZiBtb3VudGQuDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IEl0IGlzIG5laXRoZXIuIEkgbWFkZSBpbiBhIFtuZnNkXSBvcHRp
b24sIHNpbmNlIGl0IGdvdmVybnMNCj4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gd2F5DQo+
ID4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gPiBib3RoIGV4cG9ydGZzIGFuZCBtb3VudGQgdGFs
ayB0byBuZnNkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE15IHBvaW50IGlzIG5vdCBhYm91dCBp
bXBsZW1lbnRhdGlvbiwgaXQncyBhYm91dCBob3cgdGhpcw0KPiA+ID4gPiA+IGZ1bmN0aW9uYWxp
dHkNCj4gPiA+ID4gPiBpcyBwcmVzZW50ZWQgdG8gYWRtaW5pc3RyYXRvcnMuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gSW4gbmZzLmNvbmYsIFtuZnNkXSBsb29rcyBsaWtlIGl0IGNvbnRyb2xzIHdo
YXQgb3B0aW9ucyBhcmUNCj4gPiA+ID4gPiBwYXNzZWQNCj4gPiA+ID4gPiB2aWENCj4gPiA+ID4g
PiBycGMubmZzZC4gVGhhdCBzdGlsbCBzZWVtcyBsaWtlIGEgY29uZnVzaW5nIGFkbWluIGludGVy
ZmFjZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJTU8gYWRtaW5zIHdvbid0IGNhcmUgYWJvdXQg
d2hvIGlzIHRhbGtpbmcgdG8gd2hvbS4gVGhleSB3aWxsDQo+ID4gPiA+ID4gY2FyZQ0KPiA+ID4g
PiA+IGFib3V0DQo+ID4gPiA+ID4gaG93IHRoZSBleHBvcnQgcGF0aG5hbWVzIGFyZSBpbnRlcnBy
ZXRlZC4gVGhhdCBzZWVtcyBsaWtlIGl0DQo+ID4gPiA+ID4gYmVsb25ncw0KPiA+ID4gPiA+IHNx
dWFyZWx5IHdpdGggdGhlIGV4cG9ydGZzIGludGVyZmFjZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
DQo+ID4gPiA+IFdpdGggdGhlIGV4cG9ydGZzIGludGVyZmFjZSwgeWVzLiBIb3dldmVyIGl0IGlz
IG5vdCBzcGVjaWZpYyB0bw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gZXhwb3J0ZnMgdXRpbGl0eSwg
c28gdG8gbWUgW2V4cG9ydGZzXSBpcyBtb3JlIGNvbmZ1c2luZyB0aGFuDQo+ID4gPiA+IHdoYXQN
Cj4gPiA+ID4gZXhpc3RzIG5vdy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9LLCBzbyB3aGF0IGlmIHdl
IHB1dCBpdCBpbiBbZ2VuZXJhbF0gaW5zdGVhZCwgYW5kIHBlcmhhcHMNCj4gPiA+ID4gcmVuYW1l
DQo+ID4gPiA+IGl0DQo+ID4gPiA+ICJleHBvcnRfcm9vdGRpciI/DQo+ID4gPiA+IA0KPiA+ID4g
SSdtIGp1c3QgY2F0Y2hpbmcgdXAuLi4gbXkgYXBvbG9naWVzIHRhcnRuZXNzLi4uDQo+ID4gPiAN
Cj4gPiA+IFNvIHNldHRpbmcgcm9vdF9kaXIgZWZmZWN0cyAqYWxsKiBleHBvcnRzIGluIC9ldGMv
ZXhwb3J0cz8gDQo+ID4gPiBJZiB0aGF0IGlzIHRoZSBjYXNlLCB0aGF0IG9uZSB2YXJpYWJsZSBj
YW4gY2hhbmdlIGh1bmRyZWRzDQo+ID4gPiBvZiBleHBvcnQuLi4gaXMgdGhhdCB3aGF0IHdlIHJl
YWxseSB3YW50Pw0KPiA+ID4gDQo+ID4gPiBXb3VsZG4ndCBiZSBiZXR0ZXIgdG8gaGF2ZSBhIGxp
dHRsZSBtb3JlIGdyYW51bGFyaXR5PyANCj4gPiANCj4gPiBDYW4geW91IGV4cGxhaW4gd2hhdCB5
b3UgbWVhbj8gVGhlIGludGVudGlvbiBoZXJlIGlzIHRoYXQgaWYgeW91DQo+ID4gaGF2ZQ0KPiA+
IGFsbCB5b3VyIGV4cG9ydGVkIGZpbGVzeXN0ZW1zIHNldCB1cCBpbiBhIHN1YnRyZWUgdW5kZXIN
Cj4gPiAvbW50L215L2V4cG9ydHMsIHRoZW4geW91IGNhbiByZW1vdmUgdGhhdCB1bm5lY2Vzc2Fy
eSBwcmVmaXguDQo+ID4gDQo+ID4gU28sIGZvciBpbnN0YW5jZSwgaWYgSSdtIHRyeWluZyB0byBl
eHBvcnQgL21udC9teS9leHBvcnRzL2ZvbyBhbmQNCj4gPiAvbW50L215L2V4cG9ydHMvYmFyLCB0
aGVuIEkgY2FuIG1ha2UgdGhvc2UgdHdvIGZpbGVzeXN0ZW1zIGFwcGVhcg0KPiA+IGFzDQo+ID4g
L2ZvbywgYW5kIC9iYXIgdG8gdGhlIHJlbW90ZSBjbGllbnRzLg0KPiBCeSBncmFudWxhcml0eSBJ
IG1lYW50IGhhdmUgZGlmZmVyZW50IHJvb3RzIGZvciBkaWZmZXJlbnQgZXhwb3J0cy4NCj4gTWVh
bmluZyAvbW50L2Zvby9leHBvcnRzL2ZvbyBhbmQgL21udC9iYXIvZXhwb3J0cy9iYXINCj4gd291
bGQgc3RpbGwgYXBwZWFyIGFzIC9mb28gYW5kIC9iYXINCg0KTm8uIFRoYXQgc2hvdWxkIGJlIGRv
bmUgdXNpbmcgYmluZCBtb3VudHMuIE90aGVyd2lzZSB3ZSBlbmQgdXAgd2l0aA0KL2V0Yy9uZnMu
Y29uZiBhbmQgL2V0Yy9leHBvcnRzIGRlcGVuZGluZyBvbiBiZWluZyBtdXR1YWxseSBjb25zaXN0
ZW50Lg0KVGhhdCB3b3VsZCBiZSBhd2t3YXJkLg0KDQo+IEFzIHlvdSBleHBsYWluIGxhdGVyIGlu
IHRoaXMgdGhyZWFkLCB0aGVyZSBpcyBnb2luZyB0byBiZSBhIG5mcy5jb25mDQo+IGFuZCBleHBv
cnRzIGZvciBlYWNoIGNvbnRhaW5lciBzbyBtYXliZSB0aGlzIGlzIG5vdCBuZWNlc3Nhcnk/PyAN
Cj4gDQo+IE1heWJlIEknbSBtaXN1bmRlcnN0YW5kaW5nIGhvdyB0aGlzIGZlYXR1cmUgc2hvdWxk
L3dpbGwgYmUgdXNlZC4NCg0KQXMgSSd2ZSBhbHJlYWR5IHNhaWQsIGl0IGNhbiBiZSB1c2VkIHRv
IGRvIHdoYXQgeW91IGFyZSBwcm9wb3NpbmcsIGJ1dA0Kb25seSBpbiBjb25qdW5jdGlvbiB3aXRo
IGJpbmQgbW91bnRzLg0KDQo+IA0KPiA+IElmIGFuIGFkbWluIHdhbnRzIHRvIHJlYXJyYW5nZSBh
bGwgdGhlIHBhdGhzIGluIC9ldGMvZXhwb3J0cywgYW5kDQo+ID4gbWFrZQ0KPiA+IGEgY3VzdG9t
IG5hbWVzcGFjZSwgdGhlbiB0aGF0IGlzIHBvc3NpYmxlIHVzaW5nIGJpbmQgbW91bnRzOiBqdXN0
DQo+ID4gY3JlYXRlIGEgZGlyZWN0b3J5IC9teV9leHBvcnRzLCBhbmQgdXNlIG1vdW50IC0tYmlu
ZCB0byBhdHRhY2ggdGhlDQo+ID4gbmVjZXNzYXJ5IG1vdW50cG9pbnRzIGludG8gdGhlIHJpZ2h0
IHNwb3RzIGluIC9teV9leHBvcnRzLCB0aGVuIHVzZQ0KPiA+IGV4cG9ydF9yb290ZGlyIHRvIHJl
bW92ZSB0aGUgL215X2V4cG9ydHMgcHJlZml4Lg0KPiA+IA0KPiA+ID4gQXMgZm9yIHdoZXJlIHJv
b3RfZGlyIHNob3VsZCBnbywgSSB0aGluayBpdCBtYWtlcyBzZW5zZXMNCj4gPiA+IHRvIGNyZWF0
ZSBhIG5ldyBbZXhwb3J0ZnNdIHNlY3Rpb24gYW5kIGhhdmUgbW91bnRkIHJlYWQgaXQNCj4gPiA+
IGZyb20gdGhlcmUuIEkgdGhpbmsgdGhhdCB3b3VsZCBiZSBtb3JlIHN0cmFpZ2h0Zm9yd2FyZCBp
Zg0KPiA+ID4gd2UgY29udGludWUgd2l0aCB0aGUgYmlnIGhhbW1lciBhcHByb2FjaCB3aGVyZSBh
bnkgYW5kIGFsbA0KPiA+ID4gZXhwb3J0cyBhcmUgZWZmZWN0ZWQuIA0KPiA+ID4gDQo+ID4gDQo+
ID4gRmFpciBlbm91Z2gsIEkgY2FuIGFkZCB0aGUgW2V4cG9ydHNdIHNlY3Rpb24gaWYgeW91IGFs
bCBhZ3JlZSB0aGF0DQo+ID4gaXMNCj4gPiBhbiBhcHByb3ByaWF0ZSBwbGFjZS4NCj4gPiANCj4g
SSB0aGluayBhIG5ldyBleHBvcnRzIHNlY3Rpb25zIHdpdGggYSByb290ZGlyIHZhcmlhYmxlIG1h
a2VzIHNlbnNlLg0KPiBJdCBpcyBjaGFuZ2luZyB0aGUgcm9vdCBvZiB0aGUgZXhwb3J0cy4uLiAN
Cj4gDQo+IEJ1dCBJIGNvdWxkIGFsc28gbGl2ZSB3aXRoIGEgZXhwb3J0X3Jvb3RkaXIgaW4gdGhl
IGdlbmVyYWwgc2VjdGlvbi4NCj4gDQo+IFF1ZXN0aW9uOg0KPiBIb3cgaXMgdGhpcyBkaWZmZXJl
bnQgdGhhbiBwc2V1ZG8gcm9vdD8gDQo+IA0KPiBJc24ndCB0aGlzIGJhc2ljYWxseSBhIHdheSB0
byBzZXQgdGhlIHBzZXVkbyBmb3IgdjM/IA0KDQpTb3J0IG9mLCB5ZXMuDQoNCj4gV2hhdCBpcyBn
b2luZyB0byBvdmVycmlkZSB3aG9tPyBNZWFuaW5nIGlmIGJvdGggDQo+IGZzaWQ9L21udC9mb28g
YW5kIHJvb3RkaXI9L21udC9iYXIgd2hpY2ggb25lIHdpbGwgYmUgdXNlZD8NCj4gDQo+IA0KQm90
aC4gSG93ZXZlciB0aGUgZW50cnkgaW4gL2V0Yy9leHBvcnRzIHdpbGwgYmUgcmVsYXRpdmUgdG8g
L21udC9iYXIuDQpJbiBvdGhlciB3b3JkcywgdGhlIE5GU3Y0IHJvb3Qgd291bGQgYmUgZnNpZD0v
bW50L2Zvbywgd2hpY2ggdHJhbnNsYXRlcw0KYXMgL21udC9iYXIvbW50L2ZvbyBpbiB0aGUgJ2lu
aXQnIG5hbWVzcGFjZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkNUTywgSGFtbWVyc3BhY2Ug
SW5jDQo0MzAwIEVsIENhbWlubyBSZWFsLCBTdWl0ZSAxMDUNCkxvcyBBbHRvcywgQ0EgOTQwMjIN
Cnd3dy5oYW1tZXIuc3BhY2UNCg0KDQo=
