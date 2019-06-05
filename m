Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E1136726
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jun 2019 00:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEWBb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jun 2019 18:01:31 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:7424
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFEWBb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jun 2019 18:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxsh0mFd9DxICKRVd10vj+pn6CgljJOhdl8qycp6ymY=;
 b=XadPnF3lSKno0Nb/uiLxRdorooSjwypCkfSvQVREqD03BWxXEjsI6hrZIit+Rxg1QqpqVBi994YFBCqr5FwELtINmipnkHyQ//RdDU1f6mXgBcYlXwpyCIuyUffBkaoFNFb7VQ1vKtrHsBnHmjQiLzdknrdeReWVQjDbnE/JCDw=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1515.namprd13.prod.outlook.com (10.175.111.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.10; Wed, 5 Jun 2019 22:01:28 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Wed, 5 Jun 2019
 22:01:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [REGRESSION v5.2-rc] SUNRPC: Declare RPC timers as
 TIMER_DEFERRABLE (431235818bc3)
Thread-Topic: [REGRESSION v5.2-rc] SUNRPC: Declare RPC timers as
 TIMER_DEFERRABLE (431235818bc3)
Thread-Index: AQHVG3ptgDGJmWeu5EadxrXgYxKzpKaNnXkA
Date:   Wed, 5 Jun 2019 22:01:27 +0000
Message-ID: <b2c142996bc25aff51a197db52015bf9222139fe.camel@hammerspace.com>
References: <c54db63b-0d5d-2012-162a-cb08cf32245a@nvidia.com>
In-Reply-To: <c54db63b-0d5d-2012-162a-cb08cf32245a@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2643ce45-7c49-467d-c65b-08d6ea015c4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1515;
x-ms-traffictypediagnostic: DM5PR13MB1515:
x-microsoft-antispam-prvs: <DM5PR13MB1515CF2C78BE57DACBA96FAEB8160@DM5PR13MB1515.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(376002)(136003)(366004)(478694002)(189003)(199004)(8676002)(4326008)(81156014)(81166006)(6246003)(486006)(25786009)(186003)(53936002)(476003)(6506007)(305945005)(110136005)(76176011)(54906003)(76116006)(102836004)(7736002)(256004)(8936002)(6116002)(99286004)(86362001)(6512007)(3846002)(26005)(14444005)(11346002)(446003)(229853002)(2616005)(2906002)(6486002)(66476007)(2501003)(316002)(6436002)(14454004)(5660300002)(66946007)(73956011)(71200400001)(66556008)(66446008)(71190400001)(64756008)(66066001)(68736007)(118296001)(36756003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1515;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NuqycRp/AABO9gJ7el6DKPdi0Oi7wcT+xASfE9Ad8EL6jjf7WQ+UNYgP8lH79iBIIFkfbqAreoTj5aoMPwLcDRss7z5Ir8Drmjlva0FbivB0ShiwYziZPNsEXboijf7rAq59/pQ02Dh1pqR51xqGU8oT7qoFB8/iyNmcBbct6vHH7LDQawAhzA9GRiudCBfaNYbKzMtzM/3kMp+s0nZJnUCy//KIoSdd4OaSnzyjzBHgK4Zdp7akE6KLQbzoNdmbx1/itIGy35Zj3CGakedXG1Bz0aREIKTOkUKFWyST0+Y+RnYPto7t3Q/urxS9r5p1bnKcFNfVgWta2SdiWkRBx0usmclqijI5Hz8+Sf9ZC98oQmNNxyaqUW7m6jUBbDZnwKc1qmKdlVyORQM34QllOHebFp8IVTzIFtbkK3FyoeQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15B0F964811F204BAC1EDC62C81B84E6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2643ce45-7c49-467d-c65b-08d6ea015c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 22:01:28.2269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1515
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTA1IGF0IDA5OjQwICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBI
aSBUcm9uZCwNCj4gDQo+IEkgaGF2ZSBiZWVuIG5vdGljaW5nIGludGVybWl0dGVudCBmYWlsdXJl
cyB3aXRoIGEgc3lzdGVtIHN1c3BlbmQgdGVzdA0KPiBvbg0KPiBzb21lIG9mIG91ciBtYWNoaW5l
cyB0aGF0IGhhdmUgYSBORlMgbW91bnRlZCByb290IGZpbGUtc3lzdGVtLg0KPiBCaXNlY3RpbmcN
Cj4gdGhpcyBpc3N1ZSBwb2ludHMgdG8geW91ciBjb21taXQgNDMxMjM1ODE4YmMzICgiU1VOUlBD
OiBEZWNsYXJlIFJQQw0KPiB0aW1lcnMgYXMgVElNRVJfREVGRVJSQUJMRSIpIGFuZCByZXZlcnRp
bmcgdGhpcyBvbiB0b3Agb2YgdjUuMi1yYzMNCj4gZG9lcw0KPiBhcHBlYXIgdG8gcmVzb2x2ZSB0
aGUgcHJvYmxlbS4NCj4gDQo+IFRoZSBjYXVzZSBvZiB0aGUgc3VzcGVuZCBmYWlsdXJlIGFwcGVh
cnMgdG8gYmUgYSBsb25nIGRlbGF5IG9ic2VydmVkDQo+IHNvbWV0aW1lcyB3aGVuIHJlc3VtaW5n
IGZyb20gc3VzcGVuZCwgYW5kIHRoaXMgaXMgY2F1c2luZyBvdXIgdGVzdCB0bw0KPiB0aW1lb3V0
LiBGb3IgZXhhbXBsZSwgaW4gYSBmYWlsaW5nIGNhc2UgSSBzZWUgc29tZXRoaW5nIGxpa2UgdGhl
DQo+IGZvbGxvd2luZyAuLi4NCj4gDQo+IFsgICA2OS42NjczODVdIFBNOiBzdXNwZW5kIGVudHJ5
IChkZWVwKQ0KPiANCj4gWyAgIDY5LjY3NTY0Ml0gRmlsZXN5c3RlbXMgc3luYzogMC4wMDAgc2Vj
b25kcw0KPiANCj4gWyAgIDY5LjY4NDk4M10gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMg
Li4uIChlbGFwc2VkIDAuMDAxDQo+IHNlY29uZHMpIGRvbmUuDQo+IA0KPiBbICAgNjkuNjk3ODgw
XSBPT00ga2lsbGVyIGRpc2FibGVkLg0KPiANCj4gWyAgIDY5LjcwNTY3MF0gRnJlZXppbmcgcmVt
YWluaW5nIGZyZWV6YWJsZSB0YXNrcyAuLi4gKGVsYXBzZWQgMC4wMDENCj4gc2Vjb25kcykgZG9u
ZS4NCj4gDQo+IFsgICA2OS43MTkwNDNdIHByaW50azogU3VzcGVuZGluZyBjb25zb2xlKHMpICh1
c2Ugbm9fY29uc29sZV9zdXNwZW5kDQo+IHRvIGRlYnVnKQ0KPiANCj4gWyAgIDY5Ljc1ODkxMV0g
RGlzYWJsaW5nIG5vbi1ib290IENQVXMgLi4uDQo+IA0KPiBbICAgNjkuNzYxODc1XSBJUlEgMTc6
IG5vIGxvbmdlciBhZmZpbmUgdG8gQ1BVMw0KPiANCj4gWyAgIDY5Ljc2MjYwOV0gRW50ZXJpbmcg
c3VzcGVuZCBzdGF0ZSBMUDENCj4gDQo+IFsgICA2OS43NjI2MzZdIEVuYWJsaW5nIG5vbi1ib290
IENQVXMgLi4uDQo+IA0KPiBbICAgNjkuNzYzNjAwXSBDUFUxIGlzIHVwDQo+IA0KPiBbICAgNjku
NzY0NTE3XSBDUFUyIGlzIHVwDQo+IA0KPiBbICAgNjkuNzY1NTMyXSBDUFUzIGlzIHVwDQo+IA0K
PiBbICAgNjkuODQ1ODMyXSBtbWMxOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4ODAgKDUw
IGJ5dGVzKQ0KPiANCj4gWyAgIDY5Ljg1NDIyM10gbW1jMTogcXVldWluZyB1bmtub3duIENJUyB0
dXBsZSAweDgwICg3IGJ5dGVzKQ0KPiANCj4gWyAgIDY5Ljg1NzIzOF0gbW1jMTogcXVldWluZyB1
bmtub3duIENJUyB0dXBsZSAweDgwICg3IGJ5dGVzKQ0KPiANCj4gWyAgIDY5Ljg5MjcwMF0gbW1j
MTogcXVldWluZyB1bmtub3duIENJUyB0dXBsZSAweDAyICgxIGJ5dGVzKQ0KPiANCj4gWyAgIDcw
LjQwNzI4Nl0gT09NIGtpbGxlciBlbmFibGVkLg0KPiANCj4gWyAgIDcwLjQxNDY3NF0gUmVzdGFy
dGluZyB0YXNrcyAuLi4gZG9uZS4NCj4gDQo+IFsgICA3MC40MjMyMzJdIFBNOiBzdXNwZW5kIGV4
aXQNCj4gDQo+IFsgICA3My41MzMyNTJdIGFzaXggMS0xOjEuMCBldGgwOiBsaW5rIHVwLCAxMDBN
YnBzLCBmdWxsLWR1cGxleCwgbHBhDQo+IDB4Q0RFMQ0KPiANCj4gWyAgMTA1LjQ2MTg1Ml0gbmZz
OiBzZXJ2ZXIgMTkyLjE2OC45OS4xIG5vdCByZXNwb25kaW5nLCBzdGlsbCB0cnlpbmcNCj4gDQo+
IFsgIDEwNS40NjIzNDddIG5mczogc2VydmVyIDE5Mi4xNjguOTkuMSBub3QgcmVzcG9uZGluZywg
c3RpbGwgdHJ5aW5nDQo+IA0KPiBbICAxMDUuNDg0ODA5XSBuZnM6IHNlcnZlciAxOTIuMTY4Ljk5
LjEgT0sNCj4gDQo+IFsgIDEwNS40ODY0NTRdIG5mczogc2VydmVyIDE5Mi4xNjguOTkuMSBPSw0K
PiANCj4gDQo+IFNvIGl0IHdvdWxkIGFwcGVhciB0aGF0IG1ha2luZyB0aGVzZSB0aW1lcnMgZGVm
ZXJyYWJsZSBpcyBoYXZpbmcgYW4NCj4gaW1wYWN0DQo+IHdoZW4gcmVzdW1pbmcgZnJvbSBzdXNw
ZW5kLiBEbyB5b3UgaGF2ZSBhbnkgdGhvdWdodHMgb24gdGhpcz8NCj4gDQoNCkknZCBiZSBPSyB3
aXRoIGp1c3QgcmV2ZXJ0aW5nIHRoaXMgcGF0Y2ggaWYgaXQgaXMgY2F1c2luZyBhIHBlcmZvcm1h
bmNlDQppc3N1ZS4NCg0KQW5uYT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBj
bGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20NCg0KDQo=
