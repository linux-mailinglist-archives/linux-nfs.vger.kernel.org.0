Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DFE2CC59
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfE1QoI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 12:44:08 -0400
Received: from mail-eopbgr820139.outbound.protection.outlook.com ([40.107.82.139]:21195
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfE1QoH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 May 2019 12:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dRrMc1caIf11GnIVc/llpKNdepCWxfI430/ZUJiPCc=;
 b=fMchV/JytsL9TnAeT13cqsLyqa1v/97xzfZiUpltO6WHAttoYNTo2Q6ZvCBYpFzZJMpy1TuVakM8/NJqUHcr2RpYhJ/85Aj/0UbYsbOur8i7AWmmI/GoNuvHrco34tJa6oDBa68J0HH4cqZIm2MeR90YazG8TaqmLg6zIvlf2ZU=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1291.namprd13.prod.outlook.com (10.168.120.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.8; Tue, 28 May 2019 16:44:03 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1943.016; Tue, 28 May 2019
 16:44:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Topic: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Index: AQHVD9OY0U3UwvcYW0a/WB0ITGDVLKZ12MoAgAAKagCAAA2iAIAADnwAgAq0IACAABYAAA==
Date:   Tue, 28 May 2019 16:44:03 +0000
Message-ID: <c7a5f97693c56ee0a7dd5a9c0848ee97ab3d2a9e.camel@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
         <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
         <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
         <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
         <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
         <3503ff03-2895-ae1f-7fed-f30d08b0abfb@RedHat.com>
In-Reply-To: <3503ff03-2895-ae1f-7fed-f30d08b0abfb@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.124.247.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 415ec35d-2bcf-4e69-9120-08d6e38bb153
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1291;
x-ms-traffictypediagnostic: DM5PR13MB1291:
x-microsoft-antispam-prvs: <DM5PR13MB1291CBC44D57756D482B49FAB81E0@DM5PR13MB1291.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39830400003)(376002)(136003)(199004)(189003)(51444003)(25786009)(110136005)(66946007)(66476007)(66446008)(64756008)(66556008)(73956011)(36756003)(7736002)(14454004)(305945005)(229853002)(5024004)(14444005)(256004)(6116002)(186003)(68736007)(71200400001)(76176011)(76116006)(71190400001)(478600001)(3846002)(4326008)(6486002)(2906002)(118296001)(6512007)(6506007)(316002)(446003)(53936002)(11346002)(81166006)(6246003)(486006)(2616005)(102836004)(66066001)(6436002)(476003)(86362001)(2501003)(8676002)(53546011)(81156014)(99286004)(8936002)(5660300002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1291;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gva1zpVXIb7tApp+K/N5nFSUUeReSfjl0fZSUo9mSfmpqUJPzdtU5snzqHoyj94Ve0TRGAjk3VeWB1Ws60vmP19AnzwuFmrKUoaiFMXQq57I+6zgT2pwdL4bCyE1xka9PPHvDx5/Z7VWj/Ctj+IZzZdJnq3BqV7ZNXEwXfywDHIocCalz+IK2xOzXg1yp5KNU61e3erTJND+2iTk0uvMhR7FND2NwyLV2D680GjZwe2F8sM+QVkRCCapHKPIqDM6a8Zf7bXS0gqM4CjAP1MqogI3umNCPs1FDLM9De9tG5uhQrpi9O0BYQMqcrZTgqGJioxyZvqbzcKQ+vL51bTWvsqIgQRROlMKstEe6HVJWc9yaIrYtdQsWJ8VtPBmNwMUp4Oa7LulEQgTLVp7i7G6+8XecwQ+bNJgZs0Gh4jMqd4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD1D776F9ED26C4B87D8341619422C03@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415ec35d-2bcf-4e69-9120-08d6e38bb153
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 16:44:03.3516
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

T24gVHVlLCAyMDE5LTA1LTI4IGF0IDExOjI1IC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gT24gNS8yMS8xOSAzOjU4IFBNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gT24g
VHVlLCAyMDE5LTA1LTIxIGF0IDE1OjA2IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gPiA+
ID4gT24gTWF5IDIxLCAyMDE5LCBhdCAyOjE3IFBNLCBUcm9uZCBNeWtsZWJ1c3QgPA0KPiA+ID4g
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBU
dWUsIDIwMTktMDUtMjEgYXQgMTM6NDAgLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPiA+ID4g
PiA+IEhpIFRyb25kIC0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIE1heSAyMSwgMjAxOSwg
YXQgODo0NiBBTSwgVHJvbmQgTXlrbGVidXN0IDwNCj4gPiA+ID4gPiA+IHRyb25kbXlAZ21haWwu
Y29tDQo+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIGZv
bGxvd2luZyBwYXRjaHNldCBhZGRzIHN1cHBvcnQgZm9yIHRoZSAncm9vdF9kaXInDQo+ID4gPiA+
ID4gPiBjb25maWd1cmF0aW9uDQo+ID4gPiA+ID4gPiBvcHRpb24gZm9yIG5mc2QgaW4gbmZzLmNv
bmYuIElmIGEgdXNlciBzZXRzIHRoaXMgb3B0aW9uIHRvDQo+ID4gPiA+ID4gPiBhDQo+ID4gPiA+
ID4gPiB2YWxpZA0KPiA+ID4gPiA+ID4gZGlyZWN0b3J5IHBhdGgsIHRoZW4gbmZzZCB3aWxsIGFj
dCBhcyBpZiBpdCBpcyBjb25maW5lZCB0bw0KPiA+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+ID4gY2hy
b290DQo+ID4gPiA+ID4gPiBqYWlsIGJhc2VkIG9uIHRoYXQgZGlyZWN0b3J5LiBBbGwgcGF0aHMg
aW4gL2V0Yy9leHBvcmZzIGFuZA0KPiA+ID4gPiA+ID4gZnJvbQ0KPiA+ID4gPiA+ID4gZXhwb3J0
ZnMgYXJlIHRoZW4gcmVzb2x2ZWQgcmVsYXRpdmUgdG8gdGhhdCBkaXJlY3RvcnkuDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gV2hhdCBhYm91dCBmaWxlcyB1bmRlciAvcHJvYyB0aGF0IG1vdW50ZCBt
aWdodCBhY2Nlc3M/IEkNCj4gPiA+ID4gPiBhc3N1bWUNCj4gPiA+ID4gPiB0aGVzZQ0KPiA+ID4g
PiA+IHBhdGhuYW1lcyBhcmUgbm90IGFmZmVjdGVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiBUaGF0
J3Mgd2h5IHdlIGhhdmUgMiB0aHJlYWRzLiBPbmUgdGhyZWFkIGlzIHJvb3QgamFpbGVkIHVzaW5n
DQo+ID4gPiA+IGNocm9vdCwNCj4gPiA+ID4gYW5kIGlzIHVzZWQgdG8gdGFsayB0byBrbmZzZC4g
VGhlIG90aGVyIHRocmVhZCBpcyBub3Qgcm9vdA0KPiA+ID4gPiBqYWlsZWQNCj4gPiA+ID4gKG9y
DQo+ID4gPiA+IGF0IGxlYXN0IG5vdCBieSByb290X2RpcikgYW5kIHNvIGhhcyBmdWxsIGFjY2Vz
cyB0byAvZXRjLA0KPiA+ID4gPiAvcHJvYywNCj4gPiA+ID4gL3ZhciwNCj4gPiA+ID4gLi4uDQo+
ID4gPiA+IA0KPiA+ID4gPiA+IEFyZW4ndCB0aGVyZSBhbHNvIG9uZSBvciB0d28gb3RoZXIgZmls
ZXMgdGhhdCBtYWludGFpbiBleHBvcnQNCj4gPiA+ID4gPiBzdGF0ZQ0KPiA+ID4gPiA+IGxpa2Ug
L3Zhci9saWIvbmZzL3JtdGFiPyBBcmUgdGhvc2UgYWZmZWN0ZWQ/DQo+ID4gPiA+IA0KPiA+ID4g
PiBTZWUgYWJvdmUuIFRoZXkgYXJlIG5vdCBhZmZlY3RlZC4NCj4gPiA+ID4gDQo+ID4gPiA+ID4g
SU1ITyBpdCBjb3VsZCBiZSBsZXNzIGNvbmZ1c2luZyB0byBhZG1pbmlzdHJhdG9ycyB0byBtYWtl
DQo+ID4gPiA+ID4gcm9vdF9kaXIgYW4NCj4gPiA+ID4gPiBbZXhwb3J0ZnNdIG9wdGlvbiBpbnN0
ZWFkIG9mIGEgW21vdW50ZF0gb3B0aW9uLCBpZiB0aGlzIGlzDQo+ID4gPiA+ID4gbm90IGENCj4g
PiA+ID4gPiB0cnVlDQo+ID4gPiA+ID4gY2hyb290IG9mIG1vdW50ZC4NCj4gPiA+ID4gDQo+ID4g
PiA+IEl0IGlzIG5laXRoZXIuIEkgbWFkZSBpbiBhIFtuZnNkXSBvcHRpb24sIHNpbmNlIGl0IGdv
dmVybnMgdGhlDQo+ID4gPiA+IHdheQ0KPiA+ID4gPiB0aGF0DQo+ID4gPiA+IGJvdGggZXhwb3J0
ZnMgYW5kIG1vdW50ZCB0YWxrIHRvIG5mc2QuDQo+ID4gPiANCj4gPiA+IE15IHBvaW50IGlzIG5v
dCBhYm91dCBpbXBsZW1lbnRhdGlvbiwgaXQncyBhYm91dCBob3cgdGhpcw0KPiA+ID4gZnVuY3Rp
b25hbGl0eQ0KPiA+ID4gaXMgcHJlc2VudGVkIHRvIGFkbWluaXN0cmF0b3JzLg0KPiA+ID4gDQo+
ID4gPiBJbiBuZnMuY29uZiwgW25mc2RdIGxvb2tzIGxpa2UgaXQgY29udHJvbHMgd2hhdCBvcHRp
b25zIGFyZQ0KPiA+ID4gcGFzc2VkDQo+ID4gPiB2aWENCj4gPiA+IHJwYy5uZnNkLiBUaGF0IHN0
aWxsIHNlZW1zIGxpa2UgYSBjb25mdXNpbmcgYWRtaW4gaW50ZXJmYWNlLg0KPiA+ID4gDQo+ID4g
PiBJTU8gYWRtaW5zIHdvbid0IGNhcmUgYWJvdXQgd2hvIGlzIHRhbGtpbmcgdG8gd2hvbS4gVGhl
eSB3aWxsDQo+ID4gPiBjYXJlDQo+ID4gPiBhYm91dA0KPiA+ID4gaG93IHRoZSBleHBvcnQgcGF0
aG5hbWVzIGFyZSBpbnRlcnByZXRlZC4gVGhhdCBzZWVtcyBsaWtlIGl0DQo+ID4gPiBiZWxvbmdz
DQo+ID4gPiBzcXVhcmVseSB3aXRoIHRoZSBleHBvcnRmcyBpbnRlcmZhY2UuDQo+ID4gPiANCj4g
PiANCj4gPiBXaXRoIHRoZSBleHBvcnRmcyBpbnRlcmZhY2UsIHllcy4gSG93ZXZlciBpdCBpcyBu
b3Qgc3BlY2lmaWMgdG8gdGhlDQo+ID4gZXhwb3J0ZnMgdXRpbGl0eSwgc28gdG8gbWUgW2V4cG9y
dGZzXSBpcyBtb3JlIGNvbmZ1c2luZyB0aGFuIHdoYXQNCj4gPiBleGlzdHMgbm93Lg0KPiA+IA0K
PiA+IE9LLCBzbyB3aGF0IGlmIHdlIHB1dCBpdCBpbiBbZ2VuZXJhbF0gaW5zdGVhZCwgYW5kIHBl
cmhhcHMgcmVuYW1lDQo+ID4gaXQNCj4gPiAiZXhwb3J0X3Jvb3RkaXIiPw0KPiA+IA0KPiBJJ20g
anVzdCBjYXRjaGluZyB1cC4uLiBteSBhcG9sb2dpZXMgdGFydG5lc3MuLi4NCj4gDQo+IFNvIHNl
dHRpbmcgcm9vdF9kaXIgZWZmZWN0cyAqYWxsKiBleHBvcnRzIGluIC9ldGMvZXhwb3J0cz8gDQo+
IElmIHRoYXQgaXMgdGhlIGNhc2UsIHRoYXQgb25lIHZhcmlhYmxlIGNhbiBjaGFuZ2UgaHVuZHJl
ZHMNCj4gb2YgZXhwb3J0Li4uIGlzIHRoYXQgd2hhdCB3ZSByZWFsbHkgd2FudD8NCj4gDQo+IFdv
dWxkbid0IGJlIGJldHRlciB0byBoYXZlIGEgbGl0dGxlIG1vcmUgZ3JhbnVsYXJpdHk/IA0KDQpD
YW4geW91IGV4cGxhaW4gd2hhdCB5b3UgbWVhbj8gVGhlIGludGVudGlvbiBoZXJlIGlzIHRoYXQg
aWYgeW91IGhhdmUNCmFsbCB5b3VyIGV4cG9ydGVkIGZpbGVzeXN0ZW1zIHNldCB1cCBpbiBhIHN1
YnRyZWUgdW5kZXINCi9tbnQvbXkvZXhwb3J0cywgdGhlbiB5b3UgY2FuIHJlbW92ZSB0aGF0IHVu
bmVjZXNzYXJ5IHByZWZpeC4NCg0KU28sIGZvciBpbnN0YW5jZSwgaWYgSSdtIHRyeWluZyB0byBl
eHBvcnQgL21udC9teS9leHBvcnRzL2ZvbyBhbmQNCi9tbnQvbXkvZXhwb3J0cy9iYXIsIHRoZW4g
SSBjYW4gbWFrZSB0aG9zZSB0d28gZmlsZXN5c3RlbXMgYXBwZWFyIGFzDQovZm9vLCBhbmQgL2Jh
ciB0byB0aGUgcmVtb3RlIGNsaWVudHMuDQoNCklmIGFuIGFkbWluIHdhbnRzIHRvIHJlYXJyYW5n
ZSBhbGwgdGhlIHBhdGhzIGluIC9ldGMvZXhwb3J0cywgYW5kIG1ha2UNCmEgY3VzdG9tIG5hbWVz
cGFjZSwgdGhlbiB0aGF0IGlzIHBvc3NpYmxlIHVzaW5nIGJpbmQgbW91bnRzOiBqdXN0DQpjcmVh
dGUgYSBkaXJlY3RvcnkgL215X2V4cG9ydHMsIGFuZCB1c2UgbW91bnQgLS1iaW5kIHRvIGF0dGFj
aCB0aGUNCm5lY2Vzc2FyeSBtb3VudHBvaW50cyBpbnRvIHRoZSByaWdodCBzcG90cyBpbiAvbXlf
ZXhwb3J0cywgdGhlbiB1c2UNCmV4cG9ydF9yb290ZGlyIHRvIHJlbW92ZSB0aGUgL215X2V4cG9y
dHMgcHJlZml4Lg0KDQo+IEFzIGZvciB3aGVyZSByb290X2RpciBzaG91bGQgZ28sIEkgdGhpbmsg
aXQgbWFrZXMgc2Vuc2VzDQo+IHRvIGNyZWF0ZSBhIG5ldyBbZXhwb3J0ZnNdIHNlY3Rpb24gYW5k
IGhhdmUgbW91bnRkIHJlYWQgaXQNCj4gZnJvbSB0aGVyZS4gSSB0aGluayB0aGF0IHdvdWxkIGJl
IG1vcmUgc3RyYWlnaHRmb3J3YXJkIGlmDQo+IHdlIGNvbnRpbnVlIHdpdGggdGhlIGJpZyBoYW1t
ZXIgYXBwcm9hY2ggd2hlcmUgYW55IGFuZCBhbGwNCj4gZXhwb3J0cyBhcmUgZWZmZWN0ZWQuIA0K
PiANCg0KRmFpciBlbm91Z2gsIEkgY2FuIGFkZCB0aGUgW2V4cG9ydHNdIHNlY3Rpb24gaWYgeW91
IGFsbCBhZ3JlZSB0aGF0IGlzDQphbiBhcHByb3ByaWF0ZSBwbGFjZS4NCg0KLS0gDQpUcm9uZCBN
eWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25k
Lm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
