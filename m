Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF7183AAD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 21:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCLUg3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 16:36:29 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:6231
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbgCLUg3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Mar 2020 16:36:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYkYZ0u+J3s+gT3BQVNRd6qPgS5PaLaMXnJLYmfugrSLGaQmtXGEmkL5L0UWETR+D80dHrMqS9cXn+v+l5dUcBamYTt7euD8fDp+rm1OUpanOlnwAIbjCRP5pyB69pwK0QG/tB0u2lyty8VXnk5yHqU3Av8bzXKSNV52P4MQERhJilQBY/i8KjFfQpLimvCMRfOflKb8dH7jQsy7jEJ3hufsTznVmBL66eSQEy0aISCJ5GyXGsqrXNDzePSL5bTejGSwBa4vEvr/KvB/L7uofWSLeEG3/zk1nTNe+gWq/Mc4CUj0gKNswHO6n3lMYcRsQ/FEE3Z3Qt1Zs8XpxfWZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw90TXLFrCJdNpPffrLqpVOS5O0EfB/Q2QWVGBOqTgs=;
 b=XEhc37ocKqtb/5zsHt+26gk4lO3aGlK3xarB8EcAt7SVHa6fn8hjpygnItjm9S+I3HLnb3Ro8QneNZ4sKRtxNuZlf1SPhWR4BGAY9r9OXnOKUp3Is0IkBtfb6VK4IrmtA7O8rFrLYcs+pEbJquILd6l2JGBK39BJtaLpdlKNc/SgdA/yEhgqQ9l97dE+KwR/+zW+gcZzJrbSEC9LgBb8dblpsnV/loYRbZTke0lUHo0tw9fQLm+es4T2IT98nYXFp1SGyZZbgM61jVUcn+s9jV2f8Q2XFV0pKb6lBy65nxAlzDyMZUMmhXZEDUrJa+DNDJzStWl6fGhxD3M7tySL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw90TXLFrCJdNpPffrLqpVOS5O0EfB/Q2QWVGBOqTgs=;
 b=OC0XNOoaH5yq1LMjRHw1/HuRblN3Fwr6fMiU8W3ZmTrpOVXN2EIREt7b0VZbP/Jm1p/P8kOiu2EWfu8Nm0utRr458PaqJRtt9E/COdJl0wdlGY1ufRIO9m+uaIjtd/4oQYOSVQl1QaYTeK/HNVqr1kUVXuJYPqN55mpRTmTYniI=
Received: from DM6PR06MB6617.namprd06.prod.outlook.com (2603:10b6:5:25f::14)
 by DM6PR06MB4521.namprd06.prod.outlook.com (2603:10b6:5:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 12 Mar
 2020 20:36:26 +0000
Received: from DM6PR06MB6617.namprd06.prod.outlook.com
 ([fe80::f1d5:1417:3acd:c3be]) by DM6PR06MB6617.namprd06.prod.outlook.com
 ([fe80::f1d5:1417:3acd:c3be%6]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 20:36:26 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 10/13] nfs: make the buf_to_pages_noslab function
 available to the nfs code
Thread-Topic: [PATCH 10/13] nfs: make the buf_to_pages_noslab function
 available to the nfs code
Thread-Index: AQHV998pEDbrRzB8RUmZ+wYW40s+4KhFbA4A
Date:   Thu, 12 Mar 2020 20:36:26 +0000
Message-ID: <a1259afffdbdf820e64daa4346aeac689cc7b55f.camel@netapp.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
         <20200311195613.26108-11-fllinden@amazon.com>
In-Reply-To: <20200311195613.26108-11-fllinden@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.0 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dffe9f4b-fe23-47cd-7bb5-08d7c6c5099d
x-ms-traffictypediagnostic: DM6PR06MB4521:
x-microsoft-antispam-prvs: <DM6PR06MB4521F880CB519938899CF6F8F8FD0@DM6PR06MB4521.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(316002)(2616005)(36756003)(5660300002)(64756008)(91956017)(66476007)(71200400001)(26005)(76116006)(186003)(6486002)(8676002)(6506007)(66446008)(478600001)(81166006)(66946007)(66556008)(81156014)(8936002)(110136005)(6512007)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4521;H:DM6PR06MB6617.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: on6hL3KbdHnq2v1jU1bJIaWt+5FdRZ9uNL7xOqSuHXP8yQ/e7TMRuHtjxWHa0n/ku90LCcado2mdhzteuF3RORDGpA1vcZBibEr//USkDAjBHSDDntBboVzioJvOp1XqIdcYGAm0shToawtNpLIlWa4BcpVfon8xiBnY/aFZP1YiXOeNdNJvIC3tajzTNeZ8HM06O/vOmAFvH9VmUiIfAIcQ3iKDxRVdpgqL6qrmSr0h3IOeI+MQNnmEnVbHFvinn5BIOueqZsLXQnCSeNxZlNqRfiOV3/9F0RDtGfs8bvFzguHbJo7G4gaUTXpQqTHB4DfSkV+YkbYZOq5apFCF+YM4UYXr/M74Jn+ZBuoYEOl4HKTAMCD2ZDLk2m7iGtU9FYqt/bQnsCyrrTBirlBbcnBZB/GGpDdUGEG53rh2ykJOFsJnXiYjGHxCJZBX1XzA
x-ms-exchange-antispam-messagedata: GVnsY++UWkPCiYuYbCollIzObpg2C86OUX/k462ujZzMR4ei32yrraFJdKMmGAcK8wsPKmOjj9RRHWZcMcZa7DG2PwDqoRkC6c+cqnOW5bgC0j4ZWLKcQ+dMZz0x+M72WTZ7BwbQkuIL9TpkQiFk+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DBCAD595D14C743872E8E868209AE45@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffe9f4b-fe23-47cd-7bb5-08d7c6c5099d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 20:36:26.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5P8Y5vKC8zgReAj5mdvA353sl/6f0x5QjYslS/ChD1ykjJPKTi1wIn5uLvvMnHZVmxcg98Nro+rFHtp+qA4jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4521
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRnJhbmssDQoNCk9uIFdlZCwgMjAyMC0wMy0xMSBhdCAxOTo1NiArMDAwMCwgRnJhbmsgdmFu
IGRlciBMaW5kZW4gd3JvdGU6DQo+IE1ha2UgdGhlIGJ1Zl90b19wYWdlc19ub3NsYWIgZnVuY3Rp
b24gYXZhaWxhYmxlIHRvIHRoZSByZXN0IG9mIHRoZSBORlMNCj4gY29kZS4gUmVuYW1lIGl0IHRv
IG5mczRfYnVmX3RvX3BhZ2VzX25vc2xhYiB0byBiZSBjb25zaXN0ZW50Lg0KPiANCj4gVGhpcyB3
aWxsIGJlIHVzZWQgbGF0ZXIgaW4gdGhlIE5GU3Y0LjIgeGF0dHIgY29kZS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEZyYW5rIHZhbiBkZXIgTGluZGVuIDxmbGxpbmRlbkBhbWF6b24uY29tPg0KPiAt
LS0NCj4gIGZzL25mcy9pbnRlcm5hbC5oIHwgMyArKysNCj4gIGZzL25mcy9uZnM0cHJvYy5jIHwg
NCArKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvaW50ZXJuYWwuaCBiL2ZzL25mcy9pbnRlcm5h
bC5oDQo+IGluZGV4IDY4ZjIzNWE1NzFlMS4uMWUzYTdlMTE5YzkzIDEwMDY0NA0KPiAtLS0gYS9m
cy9uZnMvaW50ZXJuYWwuaA0KPiArKysgYi9mcy9uZnMvaW50ZXJuYWwuaA0KPiBAQCAtMzE3LDYg
KzMxNyw5IEBAIGV4dGVybiBjb25zdCB1MzIgbmZzNDJfbWF4bGlzdHhhdHRyc19vdmVyaGVhZDsN
Cj4gIGV4dGVybiBjb25zdCBzdHJ1Y3QgcnBjX3Byb2NpbmZvIG5mczRfcHJvY2VkdXJlc1tdOw0K
PiAgI2VuZGlmDQo+ICANCj4gK2V4dGVybiBpbnQgbmZzNF9idWZfdG9fcGFnZXNfbm9zbGFiKGNv
bnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGJ1ZmxlbiwNCj4gKwkJCQkgICAgc3RydWN0IHBhZ2UgKipw
YWdlcyk7DQo+ICsNCg0KUGxlYXNlIHB1dCB0aGlzIGluIG5mczRfZnMuaCwgYXMgaXRzIG9ubHkg
Y2FsbGVycyBhcmUgbmZzNHByb2MuYyBhbmQgbmZzNDJwcm9jLmMNCg0KVGhhbmtzLA0KQW5uYQ0K
DQo+ICAjaWZkZWYgQ09ORklHX05GU19WNF9TRUNVUklUWV9MQUJFTA0KPiAgZXh0ZXJuIHN0cnVj
dCBuZnM0X2xhYmVsICpuZnM0X2xhYmVsX2FsbG9jKHN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIs
IGdmcF90DQo+IGZsYWdzKTsNCj4gIHN0YXRpYyBpbmxpbmUgc3RydWN0IG5mczRfbGFiZWwgKg0K
PiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBp
bmRleCA3MjVhZTY0ZjYyZjcuLmFlZTNhMWM5N2RlZiAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25m
czRwcm9jLmMNCj4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTU1NTMsNyArNTU1Myw3
IEBAIHN0YXRpYyBpbmxpbmUgaW50IG5mczRfc2VydmVyX3N1cHBvcnRzX2FjbHMoc3RydWN0DQo+
IG5mc19zZXJ2ZXIgKnNlcnZlcikNCj4gICAqLw0KPiAgI2RlZmluZSBORlM0QUNMX01BWFBBR0VT
IERJVl9ST1VORF9VUChYQVRUUl9TSVpFX01BWCwgUEFHRV9TSVpFKQ0KPiAgDQo+IC1zdGF0aWMg
aW50IGJ1Zl90b19wYWdlc19ub3NsYWIoY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgYnVmbGVuLA0K
PiAraW50IG5mczRfYnVmX3RvX3BhZ2VzX25vc2xhYihjb25zdCB2b2lkICpidWYsIHNpemVfdCBi
dWZsZW4sDQo+ICAJCXN0cnVjdCBwYWdlICoqcGFnZXMpDQo+ICB7DQo+ICAJc3RydWN0IHBhZ2Ug
Km5ld3BhZ2UsICoqc3BhZ2VzOw0KPiBAQCAtNTc5NSw3ICs1Nzk1LDcgQEAgc3RhdGljIGludCBf
X25mczRfcHJvY19zZXRfYWNsKHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+IGNvbnN0IHZvaWQgKmJ1
Ziwgc2l6ZV90IGJ1ZmwNCj4gIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiAgCWlmIChucGFnZXMg
PiBBUlJBWV9TSVpFKHBhZ2VzKSkNCj4gIAkJcmV0dXJuIC1FUkFOR0U7DQo+IC0JaSA9IGJ1Zl90
b19wYWdlc19ub3NsYWIoYnVmLCBidWZsZW4sIGFyZy5hY2xfcGFnZXMpOw0KPiArCWkgPSBuZnM0
X2J1Zl90b19wYWdlc19ub3NsYWIoYnVmLCBidWZsZW4sIGFyZy5hY2xfcGFnZXMpOw0KPiAgCWlm
IChpIDwgMCkNCj4gIAkJcmV0dXJuIGk7DQo+ICAJbmZzNF9pbm9kZV9tYWtlX3dyaXRlYWJsZShp
bm9kZSk7DQo=
