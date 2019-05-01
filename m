Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10081075A
	for <lists+linux-nfs@lfdr.de>; Wed,  1 May 2019 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfEALKT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 May 2019 07:10:19 -0400
Received: from mail-eopbgr680112.outbound.protection.outlook.com ([40.107.68.112]:10210
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfEALKT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 May 2019 07:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ki8TTVXSVgW2vxa+ovcWOV8y80TFyn3wyttzL5ed24=;
 b=YKd19UyRuvCwwL0oW0WdlBbcaEW/n6Fd7cOB9vCVG0yv6VpOhRzcE5L6/g/irmJX6XnILIds9ThzmHiU7KVV6O7xdLvzmQhYXlLfGu2i3HgsKCPqpcaEHeSv4wYPdyB9SBnPx+zHIkKBltPpS/ATMzScvgmf1Nb8wyh1sanR56o=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2301.namprd13.prod.outlook.com (52.135.94.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.4; Wed, 1 May 2019 11:10:15 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511%7]) with mapi id 15.20.1856.008; Wed, 1 May 2019
 11:10:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: question about pnfs logic
Thread-Topic: question about pnfs logic
Thread-Index: AQHU/5tGp7/sDKxt902M4yBulcSYD6ZWHa0A
Date:   Wed, 1 May 2019 11:10:14 +0000
Message-ID: <f0a414683132a3084e6bce1da7c0d6b5bcd80fe6.camel@hammerspace.com>
References: <CAN-5tyG+ueNJapc-JGRsi=Tr5rKY6QxrHrouWgVo=6j8p5BeAA@mail.gmail.com>
In-Reply-To: <CAN-5tyG+ueNJapc-JGRsi=Tr5rKY6QxrHrouWgVo=6j8p5BeAA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8beac2fa-9c1a-47a8-78b5-08d6ce25965d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR13MB2301;
x-ms-traffictypediagnostic: SN6PR13MB2301:
x-microsoft-antispam-prvs: <SN6PR13MB2301B72A1DACE9E68C43648DB83B0@SN6PR13MB2301.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(6916009)(5660300002)(2906002)(6246003)(36756003)(2171002)(229853002)(305945005)(7736002)(68736007)(478600001)(8676002)(5640700003)(102836004)(66066001)(66476007)(256004)(14444005)(53936002)(11346002)(71200400001)(446003)(486006)(71190400001)(186003)(2616005)(476003)(6512007)(118296001)(6486002)(6436002)(2501003)(3480700005)(86362001)(66946007)(99286004)(76176011)(4326008)(66556008)(66446008)(64756008)(26005)(25786009)(2351001)(6116002)(6506007)(1730700003)(3846002)(81166006)(8936002)(81156014)(76116006)(91956017)(14454004)(73956011)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2301;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: un4ItnAQxDqWK2VBA2Biuez5Q+gJqCTXE8wl+eYov+bhjYbxTltTiCftYMqFni6orhhmVSVEq41p1ce2MPXt7UqO3BRtQaOEei5ZhTXIrKJvQNtdgO/8/nIoJfVRHKfkj/DjhyB+uWKcsP89C7bCCI4iiSIjVwnw4SbBOPHbLoFldtINpT0FcNr5cT0paeaPncPvXHodMb9gruDKEvpzyuWBPW6ptofyVVDVB17AUlmDO2xet2/Zfg4LBECVNM8EkAI0PSpUK8mB0Rvjt2XRWlMpkrucA4pYg37uqoQndgizr+515pVo5MTP3V+PzPnWo1kUihXl753AXHq5NEatMKlynUfy5wKUihACTALLSEe/V56O/2oXU4h/edXgbFkUr4noOqHgQw8A4Nf5zHgTk5ljBPSsE8QYq4sTSBoC8VM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1755A5924F82054F92433EC3E52BF47C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8beac2fa-9c1a-47a8-78b5-08d6ce25965d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 11:10:14.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2301
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVHVlLCAyMDE5LTA0LTMwIGF0IDE3OjI1IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBJJ20gdHJ5aW5nIHRvIGZpZ3VyZSBl
eGlzdGluZyBjb2RlIGluIG9yZGVyIHRvIGZpeCBhIHByb2JsZW0uIENhbiB5b3UNCj4gcGxlYXNl
IGhlbHA/DQo+IA0KPiBTYXkgdGhlcmUgd2FzIGFuIElPIHRvIHRoZSBEUyBhbmQgaXQgdGltZW91
dHMuIFBuZnMgY29kZSBpbiB0aGUNCj4gZmlsZWxheW91dF9hc3luY19oYW5kbGVfZXJyb3IoKSBt
YXJrcyB0aGUgZGV2aWNlIHVuYXZhaWxhYmxlIGFuZA0KPiBtYXJrcw0KPiB0aGUgbGF5b3V0IHRv
IGJlIHJldHVybmVkLiBUaW1lZCBvdXQgSU8gaXMgcmV0cmllZCBhZ2FpbnN0IHRoZSBNRFMuDQo+
IFRoZSBuZXcgSU8gdHJpZXMgdG8gZG8gdGhlIHBuZnMgYW5kIGJlY2F1c2UgdGhlIGRldmljZSBp
cyBtYXJrZWQNCj4gdW5hdmFpbGFibGUgKHJldHVybmluZyBFSU5WQUwpIGl0IHByb3BhZ2F0ZXMg
YmFjayBhbGwgdGhlIHdheSB0byB0aGUNCj4gcGdfaW5pdCBzZXR1cCBhbmQgZmFpbHMgdGhlIElP
IHdpdGggRUlOVkFMLiBCdXQgSU8gc2hvdWxkbid0IGZhaWwuDQo+IA0KPiBNeSBxdWVzdGlvbiBp
cyB3aHkgYXJlIHdlIHJldHVybmluZyB0aGUgc3RhdHVzIG9mIHRoZQ0KPiBmaWxlbGF5b3V0X2No
ZWNrX2RldmljZWlkKCksIEkgcHJvcG9zZSB0aGF0IGluc3RlYWQgd2UgYXQgdGhhdCBwb2ludA0K
PiBzZXQgbHNlZz1OVUxMIGFuZCB0aGVuIHRoZSBJTyB3b3VsZCBiZSByZWRpcmVjdGVkIHRvIHRo
ZSBNRFMuDQo+IA0KPiBPciBtYXliZSBJJ20gbWlzc2luZyBzb21ldGhpbmcgZWxzZT8NCj4gDQo+
IE15IHByb3Bvc2VkIGZpeCB3b3VsZCBiZToNCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9maWxlbGF5
b3V0L2ZpbGVsYXlvdXQuYw0KPiBiL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlvdXQuYw0KPiBp
bmRleCA2MWY0NmZhY2IzOWMuLmIzZThiYTNiZDY1NCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2Zp
bGVsYXlvdXQvZmlsZWxheW91dC5jDQo+ICsrKyBiL2ZzL25mcy9maWxlbGF5b3V0L2ZpbGVsYXlv
dXQuYw0KPiBAQCAtOTA0LDcgKzkwNCw3IEBAIGZsX3BuZnNfdXBkYXRlX2xheW91dChzdHJ1Y3Qg
aW5vZGUgKmlubywNCj4gICAgICAgICBzdGF0dXMgPSBmaWxlbGF5b3V0X2NoZWNrX2RldmljZWlk
KGxvLCBmbCwgZ2ZwX2ZsYWdzKTsNCj4gICAgICAgICBpZiAoc3RhdHVzKSB7DQo+ICAgICAgICAg
ICAgICAgICBwbmZzX3B1dF9sc2VnKGxzZWcpOw0KPiAtICAgICAgICAgICAgICAgbHNlZyA9IEVS
Ul9QVFIoc3RhdHVzKTsNCj4gKyAgICAgICAgICAgICAgIGxzZWcgPSBOVUxMOw0KPiAgICAgICAg
IH0NCj4gIG91dDoNCj4gICAgICAgICByZXR1cm4gbHNlZzsNCg0KSSBmdWxseSBhZ3JlZSB3aXRo
IHlvdXIgYXNzZXNzbWVudC4gVGhlIG9iamVjdGl2ZSBvZiB0aGUgY29kZSB0aGVyZQ0Kc2hvdWxk
IGluZGVlZCBiZSB0byBmYWxsIGJhY2sgdG8gZG9pbmcgSS9PIHRocm91Z2ggdGhlIE1EUyByYXRo
ZXIgdGhhbg0KZmFpbGluZyBpdCBhbHRvZ2V0aGVyLg0KDQpHaXZlbiB0aGF0IHRoZSA1LjIgbWVy
Z2Ugd2luZG93IGlzIGxpa2VseSB0byBvcGVuIG5leHQgd2VlaywgYW5kIHRoYXQNCndlIGhhdmVu
J3Qgc2VlbiBhbnkgdXJnZW50IHJlcG9ydHMgb2YgdGhpcyBidWcgYmVmb3JlIG5vdywgSSBzdWdn
ZXN0DQp0aGF0IHlvdSBhZGQgdGhlIHNpZ25lZC1vZmYtYnkgbGluZSB0byB0aGUgYWJvdmUgcGF0
Y2ggYW5kIHNlbmQgaXQgdG8NCkFubmEgZm9yIGluY2x1c2lvbiBpbiB0aGF0IHRyZWUuDQpQbGVh
c2UgYWxzbyBhZGQgYSAnRml4ZXM6JyBsaW5lIHNvIHRoYXQgdGhlIHBhdGNoIGNhbiBiZSBhdXRv
bWF0aWNhbGx5DQpiYWNrcG9ydGVkIHRvIG9sZGVyIGtlcm5lbC4NCg0KQ2hlZXJzDQogIFRyb25k
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
