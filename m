Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE33D96096
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfHTNlz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 09:41:55 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:42254
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730494AbfHTNly (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Aug 2019 09:41:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXShUz5Opx7tAnsDZz8Nir1cHxMigpAAV4Ue8u7twcLGIZLWRyb6DMJCyIJzIjrDTQSNmRfaCz+RTLCckolhc/kNGW3zUA6V5oaiVxQZEJpbLlVj22ep44i7s+mQwG6+kbnNGkeoswX5TkAUlyMaoOOo2SWt/TjwDJVT2rnwuddYrflXrpUqgvqrO2TCHsXChgNHxZMnfU1sk8f8Id8fthAPRdyGX/C2EoUJQxt+cgtrY33yIxQXDKxIOrycbky+q/Sfup5AOLtpoTzjOuO9aHCeSErBeFbJKHgJ0m872x50v6tQps9ptr5RgXKVmKXWxM1OwPc99iHwPCiFLh/EtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsbfFxHe6+zkm1OW6WYTPMnhRsnO+go+MVCK3VvS5xA=;
 b=iV4k+QtcVbqjK0oMHD0YK7IDppRg2AesMu8W+jDX/l2Ysv28QYZL0gchTnpqY8ixDGwwGOiZB5Cga2f27d/+GQ2Qr11LuIBp8JqYeoH5s20wDMTbdOkbEMTtMzEJpKdi685wzPFfaCW6I5puCnNoEdVq6cgpLGiDPg0zGcPa08AtJyjuCWMnHJn7mP7dLxRblf/BSR5ltGHU3cXFM7MSdQ1ilrkzS/X/1ddKjSUm9AZciFLhTrK+EX7n+6OrjfzpW90v1eLOtj4rILu/Y6hqY5ursdsCe4y4kaAXV5bbX3I+tfN7Qy4nOfLfW+HDMfTgMV1TYB5vqoHGyz9KcQ9z5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsbfFxHe6+zkm1OW6WYTPMnhRsnO+go+MVCK3VvS5xA=;
 b=hnL2+OrIxuMubvUWpb58INHFfrcK5Sp21UDHX/BpPLPaylpvqCSoRhkS6eFSkryOvi3brQXJTVTgsMn2ycvRovlqKYiBJ0LpAyImmgTNVXt9qWc1+gtZz7RRow+6gDP/VZf65UNlbFz/ciRHq9c+LV5a4LygT183gqYi5UUC4Tg=
Received: from CY4PR06MB3479.namprd06.prod.outlook.com (10.175.117.23) by
 CY4PR06MB3189.namprd06.prod.outlook.com (10.171.249.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Tue, 20 Aug 2019 13:41:51 +0000
Received: from CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::b0fc:fa55:aefa:2df2]) by CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::b0fc:fa55:aefa:2df2%7]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 13:41:51 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "wenwen@cs.uga.edu" <wenwen@cs.uga.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH] NFSv4: Fix a memory leak bug
Thread-Topic: [PATCH] NFSv4: Fix a memory leak bug
Thread-Index: AQHVVyyHiHYO1iTzCEO7R0t7VsKtAKcEC7AA
Date:   Tue, 20 Aug 2019 13:41:51 +0000
Message-ID: <bf426508041337ff4059ca2cf02022a151134e5a.camel@netapp.com>
References: <1566287651-11386-1-git-send-email-wenwen@cs.uga.edu>
In-Reply-To: <1566287651-11386-1-git-send-email-wenwen@cs.uga.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.4 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 398c6b4d-566d-4a69-4680-08d72574282e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR06MB3189;
x-ms-traffictypediagnostic: CY4PR06MB3189:
x-microsoft-antispam-prvs: <CY4PR06MB3189E79AFEA7CD9196FE9016F8AB0@CY4PR06MB3189.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(51914003)(99286004)(76176011)(478600001)(6916009)(6512007)(5640700003)(6486002)(54906003)(58126008)(66946007)(229853002)(6436002)(296002)(2501003)(66476007)(76116006)(316002)(91956017)(64756008)(66556008)(66066001)(66446008)(305945005)(486006)(7736002)(36756003)(6246003)(2171002)(14444005)(256004)(11346002)(3846002)(81166006)(8676002)(5660300002)(81156014)(14454004)(2616005)(476003)(1730700003)(118296001)(6116002)(446003)(2351001)(4326008)(186003)(8936002)(86362001)(6506007)(102836004)(25786009)(53936002)(2906002)(26005)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB3189;H:CY4PR06MB3479.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zXFfv7oFlgnxvB8bLcrxyRDTZfDiiafDhvZ4uEpSNY9czfcnMdVhQkA8hbQ1oy+9tbw3qAjAQM6PIZ9dbKxBnbjBU4fiCKDl30C1jsLDETEx+2dW/u2gwDVC3OxA/DARUmbSnFsaaIU1g9eK8H+HdllhzhGxTrYV/v9eE0GUZBKk40A1Q6UEyL6KzapzpqHrNMlbgPdjZUkRDsEM/yZvJ5S8tAV4sQQMXPnN5mUsi8pFcPPcJTIutPN9kb4H2XTZ9KdXYf85UA0Q3bu27xiNFyhj0cifoiSo9XtdSYCU59gme+ddKUugxlL0wGdWFMdwK12WU4qJ2P7rh/wG7QnfzmlBqvkZBWpVImgA0mhLz4lNvHRi8wcLBaabH0IK3lYXzfmk0m0gPNxKotQUA6WEAntaYZZCP5JOli2HQCjFmfU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A02B07109F39949B8772C40D1CD68AF@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c6b4d-566d-4a69-4680-08d72574282e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 13:41:51.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6Chl+ayliSg76Vc+gMcKNVcXNtmRvrhheBVl0OE5Nj9F05LWofaE1DSFFvcNQgbqFGdlI3qlGXAFOjRPBMpMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB3189
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgV2Vud2VuLA0KDQpPbiBUdWUsIDIwMTktMDgtMjAgYXQgMDI6NTQgLTA1MDAsIFdlbndlbiBX
YW5nIHdyb3RlOg0KPiBJbiBuZnM0X3RyeV9taWdyYXRpb24oKSwgaWYgbmZzNF9iZWdpbl9kcmFp
bl9zZXNzaW9uKCkgZmFpbHMsIHRoZQ0KPiBwcmV2aW91c2x5IGFsbG9jYXRlZCAncGFnZScgYW5k
ICdsb2NhdGlvbnMnIGFyZSBub3QgZGVhbGxvY2F0ZWQsDQo+IGxlYWRpbmcgdG8NCj4gbWVtb3J5
IGxlYWtzLiBUbyBmaXggdGhpcyBpc3N1ZSwgZnJlZSAncGFnZScgYW5kICdsb2NhdGlvbnMnIGJl
Zm9yZQ0KPiByZXR1cm5pbmcgdGhlIGVycm9yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2Vud2Vu
IFdhbmcgPHdlbndlbkBjcy51Z2EuZWR1Pg0KPiAtLS0NCj4gIGZzL25mcy9uZnM0c3RhdGUuYyB8
IDYgKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRzdGF0ZS5jIGIvZnMvbmZzL25mczRz
dGF0ZS5jDQo+IGluZGV4IGNhZDRlMDYuLjM3ODIzZGMgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9u
ZnM0c3RhdGUuYw0KPiArKysgYi9mcy9uZnMvbmZzNHN0YXRlLmMNCj4gQEAgLTIwOTUsOCArMjA5
NSwxMiBAQCBzdGF0aWMgaW50IG5mczRfdHJ5X21pZ3JhdGlvbihzdHJ1Y3QNCj4gbmZzX3NlcnZl
ciAqc2VydmVyLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZA0KPiAgICAgICAgIH0NCj4gDQo+ICAg
ICAgICAgc3RhdHVzID0gbmZzNF9iZWdpbl9kcmFpbl9zZXNzaW9uKGNscCk7DQo+IC0gICAgICAg
aWYgKHN0YXR1cyAhPSAwKQ0KPiArICAgICAgIGlmIChzdGF0dXMgIT0gMCkgew0KPiArICAgICAg
ICAgICAgICAgaWYgKHBhZ2UgIT0gTlVMTCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgX19m
cmVlX3BhZ2UocGFnZSk7DQo+ICsgICAgICAgICAgICAgICBrZnJlZShsb2NhdGlvbnMpOw0KPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsNCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlv
biEgSSB0aGluayBhIGJldHRlciBvcHRpb24gd291bGQgYmUgdG8gc3dpdGNoDQp0aGUgInJldHVy
biBzdGF0dXMiIGludG8gYSAiZ290byBvdXQiIHNvIHdlIGNhbiBrZWVwIGFsbCBvdXIgY2xlYW51
cA0KY29kZSBpbiBhIHNpbmdsZSBwbGFjZSBpbiBjYXNlIHdlIGV2ZXIgbmVlZCB0byBjaGFuZ2Ug
aXQgaW4gdGhlIGZ1dHVyZS4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQpBbm5hDQoNCj4gKyAgICAg
ICB9DQo+IA0KPiAgICAgICAgIHN0YXR1cyA9IG5mczRfcmVwbGFjZV90cmFuc3BvcnQoc2VydmVy
LCBsb2NhdGlvbnMpOw0KPiAgICAgICAgIGlmIChzdGF0dXMgIT0gMCkgew0KPiAtLQ0KPiAyLjcu
NA0KPiANCg==
