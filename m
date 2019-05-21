Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB71A25887
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEUT6D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 15:58:03 -0400
Received: from mail-eopbgr790101.outbound.protection.outlook.com ([40.107.79.101]:6170
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbfEUT6D (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 15:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CKYlRLv33V9E+J/AdheEBpZ1Y3Cut0Cci7q6CJ9f7Y=;
 b=QA0/VgRUqXV06dAMYiOuZz5/POLna7xORnzOhhMVRtgQRWbzmdA3RfFKIV9RzIY8Y3VhcjgvDY9FVEOUk0mbS6d0y6y4/UobPSLk+hzdHeldzlIs+vTUgNrzYYpUb12DMDlGrKuHZg9LQkediQkhhUud2TjVBMMP3y6NLBfgK8w=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1724.namprd13.prod.outlook.com (10.171.156.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.13; Tue, 21 May 2019 19:58:00 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 19:58:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Topic: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Index: AQHVD9OY0U3UwvcYW0a/WB0ITGDVLKZ12MoAgAAKagCAAA2iAIAADnwA
Date:   Tue, 21 May 2019 19:58:00 +0000
Message-ID: <501262c68530acbce21f39e0015e76805dedfe48.camel@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
         <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
         <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
         <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
In-Reply-To: <1BB55244-E893-47A2-B4CB-36CA991A84B0@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc8dbc5b-b716-440d-5879-08d6de26a09b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR13MB1724;
x-ms-traffictypediagnostic: DM5PR13MB1724:
x-microsoft-antispam-prvs: <DM5PR13MB1724A15C7A4D56DD2D95FF24B8070@DM5PR13MB1724.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(76176011)(6512007)(36756003)(486006)(2616005)(118296001)(476003)(68736007)(1411001)(3846002)(6116002)(316002)(5660300002)(102836004)(1361003)(66446008)(66556008)(66476007)(86362001)(64756008)(66946007)(2351001)(478600001)(73956011)(6506007)(53546011)(76116006)(6486002)(7736002)(2906002)(5640700003)(6246003)(71190400001)(71200400001)(66066001)(186003)(305945005)(26005)(6916009)(6436002)(2501003)(14444005)(53936002)(4326008)(229853002)(8676002)(99286004)(54906003)(8936002)(25786009)(11346002)(256004)(81166006)(81156014)(1730700003)(14454004)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1724;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /r+ckO+E3sl07L3gss0ei6M0dc0tfdhZj0VcjM8iXcuHp7mQoGleZrPawzFWvlU6LlwLbZbSVuMf02Xi8js2tr7M/WQsgZdn2NuDcNNWk6RTaG2WLmSj3orEgGYGRAD1fGnBLsGtKmGlktq30uU9yR0IRQletvFQ4dR9FJvtKIayUpEHKCokAcirxeGoLXyqg1YVwh/010N8JTWRhLAVoAk3MidFTS0IZW35iHvn8ssMYwl84LBhIUUka3M/sV3Y8+dIkmswMavuo1cT+IqkTaqE7y26kT4cdEL6/FL1dOKijlveG1ApbjfBXB90Dfd6h7UeJ6WX8FMi1EEwYe01koK59bTLntUHAOL1wcLZb4qNmuv1cucFrEb6w5BWVozhxl/7/a89IWvfz8LyZblk9wNVQJ/XV0vNR4s17ZQnXow=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3787320CFFA3E24B87709C43A1C98624@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8dbc5b-b716-440d-5879-08d6de26a09b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 19:58:00.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1724
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDE1OjA2IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBNYXkgMjEsIDIwMTksIGF0IDI6MTcgUE0sIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gdHJv
bmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFR1ZSwgMjAxOS0wNS0y
MSBhdCAxMzo0MCAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+ID4gPiBIaSBUcm9uZCAtDQo+
ID4gPiANCj4gPiA+ID4gT24gTWF5IDIxLCAyMDE5LCBhdCA4OjQ2IEFNLCBUcm9uZCBNeWtsZWJ1
c3QgPHRyb25kbXlAZ21haWwuY29tDQo+ID4gPiA+ID4NCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+
IA0KPiA+ID4gPiBUaGUgZm9sbG93aW5nIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlICdy
b290X2RpcicNCj4gPiA+ID4gY29uZmlndXJhdGlvbg0KPiA+ID4gPiBvcHRpb24gZm9yIG5mc2Qg
aW4gbmZzLmNvbmYuIElmIGEgdXNlciBzZXRzIHRoaXMgb3B0aW9uIHRvIGENCj4gPiA+ID4gdmFs
aWQNCj4gPiA+ID4gZGlyZWN0b3J5IHBhdGgsIHRoZW4gbmZzZCB3aWxsIGFjdCBhcyBpZiBpdCBp
cyBjb25maW5lZCB0byBhDQo+ID4gPiA+IGNocm9vdA0KPiA+ID4gPiBqYWlsIGJhc2VkIG9uIHRo
YXQgZGlyZWN0b3J5LiBBbGwgcGF0aHMgaW4gL2V0Yy9leHBvcmZzIGFuZA0KPiA+ID4gPiBmcm9t
DQo+ID4gPiA+IGV4cG9ydGZzIGFyZSB0aGVuIHJlc29sdmVkIHJlbGF0aXZlIHRvIHRoYXQgZGly
ZWN0b3J5Lg0KPiA+ID4gDQo+ID4gPiBXaGF0IGFib3V0IGZpbGVzIHVuZGVyIC9wcm9jIHRoYXQg
bW91bnRkIG1pZ2h0IGFjY2Vzcz8gSSBhc3N1bWUNCj4gPiA+IHRoZXNlDQo+ID4gPiBwYXRobmFt
ZXMgYXJlIG5vdCBhZmZlY3RlZC4NCj4gPiA+IA0KPiA+IFRoYXQncyB3aHkgd2UgaGF2ZSAyIHRo
cmVhZHMuIE9uZSB0aHJlYWQgaXMgcm9vdCBqYWlsZWQgdXNpbmcNCj4gPiBjaHJvb3QsDQo+ID4g
YW5kIGlzIHVzZWQgdG8gdGFsayB0byBrbmZzZC4gVGhlIG90aGVyIHRocmVhZCBpcyBub3Qgcm9v
dCBqYWlsZWQNCj4gPiAob3INCj4gPiBhdCBsZWFzdCBub3QgYnkgcm9vdF9kaXIpIGFuZCBzbyBo
YXMgZnVsbCBhY2Nlc3MgdG8gL2V0YywgL3Byb2MsDQo+ID4gL3ZhciwNCj4gPiAuLi4NCj4gPiAN
Cj4gPiA+IEFyZW4ndCB0aGVyZSBhbHNvIG9uZSBvciB0d28gb3RoZXIgZmlsZXMgdGhhdCBtYWlu
dGFpbiBleHBvcnQNCj4gPiA+IHN0YXRlDQo+ID4gPiBsaWtlIC92YXIvbGliL25mcy9ybXRhYj8g
QXJlIHRob3NlIGFmZmVjdGVkPw0KPiA+IA0KPiA+IFNlZSBhYm92ZS4gVGhleSBhcmUgbm90IGFm
ZmVjdGVkLg0KPiA+IA0KPiA+ID4gSU1ITyBpdCBjb3VsZCBiZSBsZXNzIGNvbmZ1c2luZyB0byBh
ZG1pbmlzdHJhdG9ycyB0byBtYWtlDQo+ID4gPiByb290X2RpciBhbg0KPiA+ID4gW2V4cG9ydGZz
XSBvcHRpb24gaW5zdGVhZCBvZiBhIFttb3VudGRdIG9wdGlvbiwgaWYgdGhpcyBpcyBub3QgYQ0K
PiA+ID4gdHJ1ZQ0KPiA+ID4gY2hyb290IG9mIG1vdW50ZC4NCj4gPiANCj4gPiBJdCBpcyBuZWl0
aGVyLiBJIG1hZGUgaW4gYSBbbmZzZF0gb3B0aW9uLCBzaW5jZSBpdCBnb3Zlcm5zIHRoZSB3YXkN
Cj4gPiB0aGF0DQo+ID4gYm90aCBleHBvcnRmcyBhbmQgbW91bnRkIHRhbGsgdG8gbmZzZC4NCj4g
DQo+IE15IHBvaW50IGlzIG5vdCBhYm91dCBpbXBsZW1lbnRhdGlvbiwgaXQncyBhYm91dCBob3cg
dGhpcw0KPiBmdW5jdGlvbmFsaXR5DQo+IGlzIHByZXNlbnRlZCB0byBhZG1pbmlzdHJhdG9ycy4N
Cj4gDQo+IEluIG5mcy5jb25mLCBbbmZzZF0gbG9va3MgbGlrZSBpdCBjb250cm9scyB3aGF0IG9w
dGlvbnMgYXJlIHBhc3NlZA0KPiB2aWENCj4gcnBjLm5mc2QuIFRoYXQgc3RpbGwgc2VlbXMgbGlr
ZSBhIGNvbmZ1c2luZyBhZG1pbiBpbnRlcmZhY2UuDQo+IA0KPiBJTU8gYWRtaW5zIHdvbid0IGNh
cmUgYWJvdXQgd2hvIGlzIHRhbGtpbmcgdG8gd2hvbS4gVGhleSB3aWxsIGNhcmUNCj4gYWJvdXQN
Cj4gaG93IHRoZSBleHBvcnQgcGF0aG5hbWVzIGFyZSBpbnRlcnByZXRlZC4gVGhhdCBzZWVtcyBs
aWtlIGl0IGJlbG9uZ3MNCj4gc3F1YXJlbHkgd2l0aCB0aGUgZXhwb3J0ZnMgaW50ZXJmYWNlLg0K
PiANCg0KV2l0aCB0aGUgZXhwb3J0ZnMgaW50ZXJmYWNlLCB5ZXMuIEhvd2V2ZXIgaXQgaXMgbm90
IHNwZWNpZmljIHRvIHRoZQ0KZXhwb3J0ZnMgdXRpbGl0eSwgc28gdG8gbWUgW2V4cG9ydGZzXSBp
cyBtb3JlIGNvbmZ1c2luZyB0aGFuIHdoYXQNCmV4aXN0cyBub3cuDQoNCk9LLCBzbyB3aGF0IGlm
IHdlIHB1dCBpdCBpbiBbZ2VuZXJhbF0gaW5zdGVhZCwgYW5kIHBlcmhhcHMgcmVuYW1lIGl0DQoi
ZXhwb3J0X3Jvb3RkaXIiPw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==
