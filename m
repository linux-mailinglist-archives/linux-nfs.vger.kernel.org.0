Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CC121E81
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 23:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLPWlK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 17:41:10 -0500
Received: from mail-mw2nam10on2110.outbound.protection.outlook.com ([40.107.94.110]:32224
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbfLPWlK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Dec 2019 17:41:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVdS4cybScKTmSVZmaAmsqNVQC6P84gipN+1eXat1IT0oyQ1IHk3qxh4T+Hv+EHcd23RRziZZ9ynMWiRoUkmlw756vcek+PNeQ+FKsIzguZLf4KLUNAxOSb36ez9egUgFSVWSEocux0j6YCWry1/atVKXPsHv+8OJUHV3tAoyq2/r35tJJsxsoiRpURHhPdbYPMvhmtsgk5zzpGG0SHlu4xQLi/2I+RB6YuMNebPhtOCjZ6z+1KikCD2hC84AeguBi35sOAO5BEyFHQS9YCfJ118YqZ8hyn+msq7UMhOC6HzxpTF2RlsaR+Dy/zy2ELClOMaJPf91xdApdAYKlNZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YQScnyfcWtdJBTr3o33EL/GwqAbqaedo9+6agzFCB4=;
 b=YYSr7pqVRKLMN6bwqrQiGEBZVxBrT1lIqg2caCUs7rjh8PnZb+dq1FvUUgbiaBtYO6mC6cwovszJHdqucoDw+vcrRpfEXIJwwxGdczUn24UXyxg2UUXxd2lawLJ/nkWBe3MB7PWUVWyNxIqNxEW/8op5Pe+h16kSjq/bfhSNNVHeMqWFhSmNPA1Q2kypTtBQGAszycxzIzaobfwW/dNqQ9Q7OaPYx4FzThxbe0nqpCLmkdvz99soGlK4BuRzZzGZn8L9Z3aZvAn45BVt9/Vt+2F/WU8Hmmdio8enbbFhXezkFZCEMavp4MfWsmWQhQXdHddef6rurxJbryK9KCgbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YQScnyfcWtdJBTr3o33EL/GwqAbqaedo9+6agzFCB4=;
 b=YreU4C/mtmeiJhTP35KqMQyhgxvGVUph+adsOei0Dt6tuJnQl8+MUf0S2n8rG7xV+wj1CtaEKGoi+ZWybUuieQvyFfKJgIxmkdaKQ0ZEeH2x6saFDLRXL9pVZ3Rbdy4+6Emr4X7liKQR9kftnMEO/vg8JZOGewyduBOhcqXeJvM=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2060.namprd13.prod.outlook.com (10.174.186.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.8; Mon, 16 Dec 2019 22:41:06 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Mon, 16 Dec 2019
 22:41:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.x recover from pre-mature loss of openstateid
Thread-Topic: [PATCH 1/1] NFSv4.x recover from pre-mature loss of openstateid
Thread-Index: AQHVtF4L2RSoRaNV9E+17SH0cN1qIKe9WxGA
Date:   Mon, 16 Dec 2019 22:41:06 +0000
Message-ID: <a20cf13748a95479ab47a3ccac06e929559c2193.camel@hammerspace.com>
References: <20191216221304.25782-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20191216221304.25782-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddd246dd-60d0-4e7d-5b57-08d782790a00
x-ms-traffictypediagnostic: DM5PR1301MB2060:
x-microsoft-antispam-prvs: <DM5PR1301MB2060EB32A4506E74FF7BAF11B8510@DM5PR1301MB2060.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39840400004)(366004)(199004)(189003)(186003)(8676002)(6506007)(86362001)(2616005)(5660300002)(508600001)(4326008)(6486002)(81156014)(91956017)(8936002)(316002)(76116006)(110136005)(26005)(66946007)(4001150100001)(64756008)(66446008)(66556008)(66476007)(36756003)(6512007)(71200400001)(2906002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2060;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nt05fO+uKDQymjomEICuDggEN1aQNW5OfrQZIRleqyq3aSLz5VWXbz6v7JPn107BEdfdtld7CryMquGn19baPhNmK7k146N92QzA5OWsg5kJRInYEBhmVlzaUONHyyoyXV93F0rz/nagMsGetxlM+RAzMQLK3btN9y3KOYlAp/8E8kPynZciJCgi/1Si3Bnf5oqYY9oeQQdh3S1R1sDHQgFGHcSwfJ1X7jQtil1Z77N/oY7iC066y2MzynbzzMXAQTpcfOp35oOBXeaqDLsxIHB5MttQhMYhvS/p5JJj+gb9Tc4Q6bnyiAxQmV7R6F6r9x0DRuO8FojHAUWvReFWWrEs6d88JESF5q8iLL2VAGRd89jIDMc+AaErlklGer8w2x7WJWB4E0qKJhxljYOawGTtrBPMgT0gpOlwTeSKDvu6HEohRmqmBpPVPxJ5fhyY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B77B84B60885A04BB83BB814ABA1FAC0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd246dd-60d0-4e7d-5b57-08d782790a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 22:41:06.5944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEtDybnvl7Fuw+JnMQNVgK3+tVdzt1HNcBFDE9yZRSk18wrovdMxRXspgqzCv3J+b0C9oe4nDtLRyB247vvjtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2060
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBNb24sIDIwMTktMTItMTYgYXQgMTc6MTMgLTA1MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNv
bT4NCj4gDQo+IEV2ZXIgc2luY2UgdGhlIGNvbW1pdCAwZTBjYjM1YjQxN2YsIGl0J3MgcG9zc2li
bGUgdG8gbG9zZSBhbiBvcGVuDQo+IHN0YXRlaWQNCj4gd2hpbGUgcmV0cnlpbmcgYSBDTE9TRSBk
dWUgdG8gRVJSX09MRF9TVEFURUlELiBPbmNlIHRoYXQgaGFwcGVucywNCj4gb3BlcmF0aW9ucyB0
aGF0IHJlcXVpcmUgb3BlbnN0YXRlaWQgZmFpbCB3aXRoIEVBR0FJTiB3aGljaCBpcw0KPiBwcm9w
YWdhdGVkDQo+IHRvIHRoZSBhcHBsaWNhdGlvbiB0aGVuIHRlc3RzIGxpa2UgZ2VuZXJpYy80NDYg
YW5kIGdlbmVyaWMvMTY4IGZhaWwNCj4gd2l0aA0KPiAiUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5h
dmFpbGFibGUiLg0KPiANCj4gSW5zdGVhZCBvZiByZXR1cm5pbmcgdGhpcyBlcnJvciwgaW5pdGlh
dGUgc3RhdGUgcmVjb3Zlcnkgd2hlbg0KPiBwb3NzaWJsZSB0bw0KPiByZWNvdmVyIHRoZSBvcGVu
IHN0YXRlaWQgYW5kIHRoZW4gdHJ5IGNhbGxpbmcNCj4gbmZzNF9zZWxlY3Rfcndfc3RhdGVpZCgp
DQo+IGFnYWluLg0KPiANCj4gRml4ZXM6IDBlMGNiMzViNDE3ZiAoIk5GU3Y0OiBIYW5kbGUgTkZT
NEVSUl9PTERfU1RBVEVJRCBpbg0KPiBDTE9TRS9PUEVOX0RPV05HUkFERSIpDQo+IFNpZ25lZC1v
ZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiAtLS0NCj4gIGZz
L25mcy9uZnM0cHJvYy5jICB8IDMgKysrDQo+ICBmcy9uZnMvbmZzNHN0YXRlLmMgfCAyICstDQo+
ICBmcy9uZnMvcG5mcy5jICAgICAgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNHBy
b2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IGluZGV4IDc2ZDM3MTYxNDA5YS4uNjZmOTYzMWJh
MDEyIDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiArKysgYi9mcy9uZnMvbmZz
NHByb2MuYw0KPiBAQCAtMzIzOSw2ICszMjM5LDggQEAgc3RhdGljIGludCBfbmZzNF9kb19zZXRh
dHRyKHN0cnVjdCBpbm9kZQ0KPiAqaW5vZGUsDQo+ICAJCW5mc19wdXRfbG9ja19jb250ZXh0KGxf
Y3R4KTsNCj4gIAkJaWYgKHN0YXR1cyA9PSAtRUlPKQ0KPiAgCQkJcmV0dXJuIC1FQkFERjsNCj4g
KwkJZWxzZSBpZiAoc3RhdHVzKQ0KPiArCQkJZ290byBvdXQ7DQo+ICAJfSBlbHNlIHsNCj4gIHpl
cm9fc3RhdGVpZDoNCj4gIAkJbmZzNF9zdGF0ZWlkX2NvcHkoJmFyZy0+c3RhdGVpZCwgJnplcm9f
c3RhdGVpZCk7DQo+IEBAIC0zMjUxLDYgKzMyNTMsNyBAQCBzdGF0aWMgaW50IF9uZnM0X2RvX3Nl
dGF0dHIoc3RydWN0IGlub2RlDQo+ICppbm9kZSwNCj4gIAlwdXRfY3JlZChkZWxlZ2F0aW9uX2Ny
ZWQpOw0KPiAgCWlmIChzdGF0dXMgPT0gMCAmJiBjdHggIT0gTlVMTCkNCj4gIAkJcmVuZXdfbGVh
c2Uoc2VydmVyLCB0aW1lc3RhbXApOw0KPiArb3V0Og0KPiAgCXRyYWNlX25mczRfc2V0YXR0cihp
bm9kZSwgJmFyZy0+c3RhdGVpZCwgc3RhdHVzKTsNCj4gIAlyZXR1cm4gc3RhdHVzOw0KPiAgfQ0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRzdGF0ZS5jIGIvZnMvbmZzL25mczRzdGF0ZS5jDQo+
IGluZGV4IDM0NTUyMzI5MjMzZC4uODY4NjQ1MTg5M2E2IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMv
bmZzNHN0YXRlLmMNCj4gKysrIGIvZnMvbmZzL25mczRzdGF0ZS5jDQo+IEBAIC0xMDY0LDcgKzEw
NjQsNyBAQCBpbnQgbmZzNF9zZWxlY3Rfcndfc3RhdGVpZChzdHJ1Y3QgbmZzNF9zdGF0ZQ0KPiAq
c3RhdGUsDQo+ICAJCSAqIGNob29zZSB0byB1c2UuDQo+ICAJCSAqLw0KPiAgCQlnb3RvIG91dDsN
Cj4gLQlyZXQgPSBuZnM0X2NvcHlfb3Blbl9zdGF0ZWlkKGRzdCwgc3RhdGUpID8gMCA6IC1FQUdB
SU47DQo+ICsJcmV0ID0gbmZzNF9jb3B5X29wZW5fc3RhdGVpZChkc3QsIHN0YXRlKSA/IDAgOg0K
PiAtTkZTNEVSUl9CQURfU1RBVEVJRDsNCg0KVGhpcyBpcyBub3QgYWNjZXB0YWJsZS4gV2UgY2Fu
J3QgcmV0dXJuIE5GU3Y0IGVycm9yIHZhbHVlcyB0byBmdW5jdGlvbnMNCnRoYXQgZXhwZWN0IFBP
U0lYIGVycm9ycy4NCg0KRm9yIGluc3RhbmNlIHBuZnNfdXBkYXRlX2xheW91dCgpIHRyaWVzIHRv
IGFwcGx5IEVSUl9QVFIoKSB0byB0aGlzDQpyZXR1cm4gdmFsdWUsIHdoaWNoIGJyZWFrcyBiYWRs
eSBmb3Igbm9uLVBPU0lYIGVycm9ycyAoaXQgcmV0dXJucyBhbg0KaW52YWxpZCBwb2ludGVyIHRo
YXQgZmFpbHMgdGhlIElTX0VSUigpIHRlc3QpLg0KDQo+ICBvdXQ6DQo+ICAJaWYgKG5mc19zZXJ2
ZXJfY2FwYWJsZShzdGF0ZS0+aW5vZGUsIE5GU19DQVBfU1RBVEVJRF9ORlNWNDEpKQ0KPiAgCQlk
c3QtPnNlcWlkID0gMDsNCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9wbmZzLmMgYi9mcy9uZnMvcG5m
cy5jDQo+IGluZGV4IGNlYzMwNzBhYjU3Ny4uMTFkNjQ2YmJkMmNiIDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnMvcG5mcy5jDQo+ICsrKyBiL2ZzL25mcy9wbmZzLmMNCj4gQEAgLTE5OTgsNyArMTk5OCw3
IEBAIHBuZnNfdXBkYXRlX2xheW91dChzdHJ1Y3QgaW5vZGUgKmlubywNCj4gIAkJCXRyYWNlX3Bu
ZnNfdXBkYXRlX2xheW91dChpbm8sIHBvcywgY291bnQsDQo+ICAJCQkJCWlvbW9kZSwgbG8sIGxz
ZWcsDQo+ICAJCQkJCVBORlNfVVBEQVRFX0xBWU9VVF9JTlZBTElEX09QRU4NCj4gKTsNCj4gLQkJ
CWlmIChzdGF0dXMgIT0gLUVBR0FJTikNCj4gKwkJCWlmIChzdGF0dXMgIT0gLUVBR0FJTiAmJiBz
dGF0dXMgIT0NCj4gLU5GUzRFUlJfQkFEX1NUQVRFSUQpDQo+ICAJCQkJZ290byBvdXRfdW5sb2Nr
Ow0KPiAgCQkJc3Bpbl91bmxvY2soJmluby0+aV9sb2NrKTsNCj4gIAkJCW5mczRfc2NoZWR1bGVf
c3RhdGVpZF9yZWNvdmVyeShzZXJ2ZXIsIGN0eC0NCj4gPnN0YXRlKTsNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
