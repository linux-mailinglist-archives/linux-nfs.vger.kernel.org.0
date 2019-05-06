Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC95E151C0
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2019 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfEFQgI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 May 2019 12:36:08 -0400
Received: from mail-eopbgr780108.outbound.protection.outlook.com ([40.107.78.108]:53504
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbfEFQgI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 6 May 2019 12:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhIbELF52nOscqOdfdp2Sonoi5w2Mc3BgRbTzOV6pJM=;
 b=shZ0NREFs11g2pp53kelmCVJrCOTZUpirQuwrnZmfxehYbuK7TctiA4t6GP/i/xnr1Nr6mJBW77kZ8hToGPO1Qo6sy5BfXdBtJ9h1HErjQncIHJsCYxMpb7kwzse+eu0KgKEE7HZhTynkQd9yGNE6BieyPkNegv/7h6t7WoTKKo=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2511.namprd13.prod.outlook.com (52.135.95.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.18; Mon, 6 May 2019 16:36:03 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::396d:aed6:eeb4:2511%7]) with mapi id 15.20.1878.019; Mon, 6 May 2019
 16:36:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "smayhew@redhat.com" <smayhew@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSv4: don't mark all open state for recovery when
 handling recallable state revoked flag
Thread-Topic: [PATCH v2] NFSv4: don't mark all open state for recovery when
 handling recallable state revoked flag
Thread-Index: AQHVBCSjCmstJbn8wUKONJRdcwNq86ZeS0iA
Date:   Mon, 6 May 2019 16:36:02 +0000
Message-ID: <f23e72bef69948d6ff5a9e306332deb7c6615e71.camel@hammerspace.com>
References: <20190506155905.16152-1-smayhew@redhat.com>
In-Reply-To: <20190506155905.16152-1-smayhew@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.170.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c3bdc63-dbd1-4ecc-3f37-08d6d240ee1f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR13MB2511;
x-ms-traffictypediagnostic: SN6PR13MB2511:
x-microsoft-antispam-prvs: <SN6PR13MB2511F68BFF2A6107191304A3B8300@SN6PR13MB2511.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(366004)(136003)(396003)(346002)(199004)(189003)(446003)(486006)(2616005)(11346002)(476003)(53936002)(8676002)(3846002)(6512007)(118296001)(6116002)(6436002)(2906002)(6246003)(81166006)(81156014)(99286004)(4326008)(8936002)(68736007)(14454004)(6486002)(316002)(110136005)(2501003)(36756003)(229853002)(7736002)(305945005)(66066001)(25786009)(76176011)(102836004)(26005)(186003)(6506007)(76116006)(14444005)(66446008)(64756008)(73956011)(66476007)(66556008)(256004)(66946007)(91956017)(71200400001)(5660300002)(478600001)(86362001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2511;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rK6gEBxhYUEft5aq2CXma0Iibf/rVqjD9wPh2iVygeKQ0KJDnWl1pGfPqVPK2P5P4lJa1e+vMNkUoS96iAumU46tMUa7Ue2iksAORaAVxVUV04YAgRtpEDKJ68pXcuMLL8R/zt2yw/vxLcRZoypsd44uqScgMv/6gXcs+Tum3UTZ2aNOWnwBeURoX0OHOxTisL0DHNMFkvnPEaFCrUPld27hp43Phd9pZq7Bs2h5wb+LTeJ5rQ1Q0HaMCgno+9j6UB60ssFQYpCV8/+3dj5iwB9LBZwkBnb7+tRA+tPEyqxhBi67ScZ9r0oGMWPz7xGT/yycbanArxghd3l8LnqG4ss7a6CKi50+DT9eSTCDfwrxT4oN4t/gJlzopnEELkQR582GAhznHtAmsj2HAG+o2bp08w4rteV04q3NUf1c7tc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAF245ECB268484C8A8B0E5A4CAB42F0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3bdc63-dbd1-4ecc-3f37-08d6d240ee1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 16:36:03.2260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2511
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTA2IGF0IDExOjU5IC0wNDAwLCBTY290dCBNYXloZXcgd3JvdGU6DQo+
IE9ubHkgZGVsZWdhdGlvbnMgYW5kIGxheW91dHMgY2FuIGJlIHJlY2FsbGVkLCBzbyBpdCBzaG91
bGRuJ3QgYmUNCj4gbmVjZXNzYXJ5IHRvIHJlY292ZXIgYWxsIG9wZW5zIHdoZW4gaGFuZGxpbmcg
dGhlIHN0YXR1cyBiaXQNCj4gU0VRNF9TVEFUVVNfUkVDQUxMQUJMRV9TVEFURV9SRVZPS0VELiAg
V2UnbGwgc3RpbGwgd2luZCB1cCBjYWxsaW5nDQo+IG5mczQxX29wZW5fZXhwaXJlZCgpIHdoZW4g
YSBURVNUX1NUQVRFSUQgcmV0dXJucw0KPiBORlM0RVJSX0RFTEVHX1JFVk9LRUQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBTY290dCBNYXloZXcgPHNtYXloZXdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+
ICBmcy9uZnMvZGVsZWdhdGlvbi5jIHwgMTIgKysrKysrKysrKysrDQo+ICBmcy9uZnMvZGVsZWdh
dGlvbi5oIHwgIDEgKw0KPiAgZnMvbmZzL25mczRzdGF0ZS5jICB8ICAzICstLQ0KPiAgMyBmaWxl
cyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2ZzL25mcy9kZWxlZ2F0aW9uLmMgYi9mcy9uZnMvZGVsZWdhdGlvbi5jDQo+IGluZGV4
IDJmNmI0NDdjZGQ4Mi4uOGI3ODI3NGUzZTU2IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvZGVsZWdh
dGlvbi5jDQo+ICsrKyBiL2ZzL25mcy9kZWxlZ2F0aW9uLmMNCj4gQEAgLTEwMzMsNiArMTAzMywx
OCBAQCB2b2lkDQo+IG5mc19tYXJrX3Rlc3RfZXhwaXJlZF9hbGxfZGVsZWdhdGlvbnMoc3RydWN0
IG5mc19jbGllbnQgKmNscCkNCj4gIAlyY3VfcmVhZF91bmxvY2soKTsNCj4gIH0NCj4gIA0KPiAr
LyoqDQo+ICsgKiBuZnNfdGVzdF9leHBpcmVkX2FsbF9kZWxlZ2F0aW9ucyAtIHRlc3QgYWxsIGRl
bGVnYXRpb25zIGZvciBhDQo+IGNsaWVudA0KPiArICogQGNscDogbmZzX2NsaWVudCB0byBwcm9j
ZXNzDQo+ICsgKg0KPiArICogSGVscGVyIGZvciBoYW5kbGluZyAicmVjYWxsYWJsZSBzdGF0ZSBy
ZXZva2VkIiBzdGF0dXMgZnJvbQ0KPiBzZXJ2ZXIuDQo+ICsgKi8NCj4gK3ZvaWQgbmZzX3Rlc3Rf
ZXhwaXJlZF9hbGxfZGVsZWdhdGlvbnMoc3RydWN0IG5mc19jbGllbnQgKmNscCkNCj4gK3sNCj4g
KwluZnNfbWFya190ZXN0X2V4cGlyZWRfYWxsX2RlbGVnYXRpb25zKGNscCk7DQo+ICsJbmZzNF9z
Y2hlZHVsZV9zdGF0ZV9tYW5hZ2VyKGNscCk7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogbmZz
X3JlYXBfZXhwaXJlZF9kZWxlZ2F0aW9ucyAtIHJlYXAgZXhwaXJlZCBkZWxlZ2F0aW9ucw0KPiAg
ICogQGNscDogbmZzX2NsaWVudCB0byBwcm9jZXNzDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvZGVs
ZWdhdGlvbi5oIGIvZnMvbmZzL2RlbGVnYXRpb24uaA0KPiBpbmRleCAzNWI0YjAyYzFhZTAuLjU3
OTk3NzdkZjVlYyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL2RlbGVnYXRpb24uaA0KPiArKysgYi9m
cy9uZnMvZGVsZWdhdGlvbi5oDQo+IEBAIC01OCw2ICs1OCw3IEBAIHZvaWQgbmZzX2RlbGVnYXRp
b25fbWFya19yZWNsYWltKHN0cnVjdCBuZnNfY2xpZW50DQo+ICpjbHApOw0KPiAgdm9pZCBuZnNf
ZGVsZWdhdGlvbl9yZWFwX3VuY2xhaW1lZChzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwKTsNCj4gIA0K
PiAgdm9pZCBuZnNfbWFya190ZXN0X2V4cGlyZWRfYWxsX2RlbGVnYXRpb25zKHN0cnVjdCBuZnNf
Y2xpZW50ICpjbHApOw0KPiArdm9pZCBuZnNfdGVzdF9leHBpcmVkX2FsbF9kZWxlZ2F0aW9ucyhz
dHJ1Y3QgbmZzX2NsaWVudCAqY2xwKTsNCj4gIHZvaWQgbmZzX3JlYXBfZXhwaXJlZF9kZWxlZ2F0
aW9ucyhzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwKTsNCj4gIA0KPiAgLyogTkZTdjQgZGVsZWdhdGlv
bi1yZWxhdGVkIHByb2NlZHVyZXMgKi8NCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0c3RhdGUu
YyBiL2ZzL25mcy9uZnM0c3RhdGUuYw0KPiBpbmRleCAzZGUzNjQ3OWVkN2EuLjdkMGVlNWEyYWVm
OSAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRzdGF0ZS5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0
c3RhdGUuYw0KPiBAQCAtMjM0Niw4ICsyMzQ2LDcgQEAgc3RhdGljIHZvaWQNCj4gbmZzNDFfaGFu
ZGxlX3JlY2FsbGFibGVfc3RhdGVfcmV2b2tlZChzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwKQ0KPiAg
ew0KPiAgCS8qIEZJWE1FOiBGb3Igbm93LCB3ZSBkZXN0cm95IGFsbCBsYXlvdXRzLiAqLw0KPiAg
CXBuZnNfZGVzdHJveV9hbGxfbGF5b3V0cyhjbHApOw0KPiAtCS8qIEZJWE1FOiBGb3Igbm93LCB3
ZSB0ZXN0IGFsbCBkZWxlZ2F0aW9ucytvcGVuIHN0YXRlK2xvY2tzLiAqLw0KPiAtCW5mczQxX2hh
bmRsZV9zb21lX3N0YXRlX3Jldm9rZWQoY2xwKTsNCj4gKwluZnNfdGVzdF9leHBpcmVkX2FsbF9k
ZWxlZ2F0aW9ucyhjbHApOw0KPiAgCWRwcmludGsoIiVzOiBSZWNhbGxhYmxlIHN0YXRlIHJldm9r
ZWQgb24gc2VydmVyICVzIVxuIiwNCj4gX19mdW5jX18sDQo+ICAJCQljbHAtPmNsX2hvc3RuYW1l
KTsNCj4gIH0NCg0KVGhhbmsgeW91IQ0KDQpSZXZpZXdlZC1ieTogVHJvbmQgTXlrbGVidXN0IDx0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KDQotLSANClRyb25kIE15a2xlYnVzdA0K
TGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
