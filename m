Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6B1217F5
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLPSj6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:39:58 -0500
Received: from mail-bn8nam11on2106.outbound.protection.outlook.com ([40.107.236.106]:64481
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728573AbfLPSj5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Dec 2019 13:39:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8RhgzTR924PUQ1cxG/uBGYn6xXM7Xa+p9gi8JOiUgb3YKGULxKY8vhHlAs5xlreyKNiaUJh0+IHED66CDIZWbDvipzyvBw1+EVeAKfUkszRpauiZp2V4v6DC6+DgpPBWoTuQyUdzlG5vCkiCK3ewlTYj/cdzpSCe0xm1hObqU4znaOne4yvIdFCsZEcUZoVk1T52WjQYEGfQ2hn+Cxv4eOETR/99CA6Mcq94xss9Ldw4ifG9zA8IYf+syvx6Ag8jwBKewhhk6MbOEBn8ufZMXccocgVwOQaleK7gvM6SJgnY/SVwwE8XGS0aosfkvuhm6CyYN+O9i2urJLvHi4rQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q7iahBq2iGGum5ooO/j+ZDnIq3Ccr2edUU4jWzI6RQ=;
 b=miP90Y/uLP5dkhh4vzIUqu+67emJ7WqwMn7DbA4fEmHEeD05ocTAcnY9SN+MIx3h73WIbH/79dvJZaCPYCAB5pL6tnMt7ScU0kBjDJL+ke2h/NFy+vpSuii/Bo+5Ei21euEzRHmWHZ8qhhcMfVxbqu+UvToGqNn8Xc20fnjNYbVSGgujZP6m2pbb05YG/z7yn5G8UvJtYPeb5O3fUOMnW3wpDY2I2YyjJ+QE9WjNIXeS/uleirj2FZ0ELYsg+hsWsXJewk5fZls0XYr1CXtOR9+JAmcwpON9ADUbNRyjWBG3HckBojMVtwIJwBqnoa+DXZmi8M2BETUD3VN3l5rruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q7iahBq2iGGum5ooO/j+ZDnIq3Ccr2edUU4jWzI6RQ=;
 b=Yd/3ebVhN/HY22GqgZg9pFKnrDYfsZq4++LcoCZWrmak/KwWaL7jFfs0coHxEQYoPiZqPuGyD1SH1GvzFdxhqMjrEkXfF1I/L5SOzBeJCpW5MxpLLa2SVRawi6uvPS0H4jWIZo4FsP0HwdwRsmLQ6rZE5Q6XFsf9MqZRKn0bAPY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2169.namprd13.prod.outlook.com (10.174.185.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.11; Mon, 16 Dec 2019 18:39:54 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Mon, 16 Dec 2019
 18:39:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmilkowski@gmail.com" <rmilkowski@gmail.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: open() should try lease recovery on
 NFS4ERR_EXPIRED
Thread-Topic: [PATCH] NFSv4: open() should try lease recovery on
 NFS4ERR_EXPIRED
Thread-Index: AdW0MuhLiOKK2wGRQLycz+SVs0XJrQADUuoA
Date:   Mon, 16 Dec 2019 18:39:54 +0000
Message-ID: <4876605a6f7387d04986a16f2f16c4014c49c734.camel@hammerspace.com>
References: <05c201d5b439$d99083c0$8cb18b40$@gmail.com>
In-Reply-To: <05c201d5b439$d99083c0$8cb18b40$@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c31f7bf-8a67-48e1-e0a9-08d7825757e0
x-ms-traffictypediagnostic: DM5PR1301MB2169:
x-microsoft-antispam-prvs: <DM5PR1301MB2169354E2E9AB5AE91FB0BE1B8510@DM5PR1301MB2169.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39830400003)(396003)(199004)(189003)(2906002)(4326008)(86362001)(6506007)(26005)(64756008)(66476007)(71200400001)(8676002)(6512007)(8936002)(6486002)(508600001)(2616005)(316002)(54906003)(81166006)(186003)(81156014)(110136005)(5660300002)(66946007)(66556008)(76116006)(4001150100001)(66446008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2169;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d1mXCSMmZT5mmLiMMvsz/nUq+rWBS4vI6N9f6SLA21tTAQkkMYzXwKEmibft7WBSdqxq3SHzbn1yJ2m+9tEbfpLDKrPZ+aZOb1+2hM+ht+HlmoW3AfHGkCzvATYUnq4yBo154gmOA6UJ0FhPG4gKwPvg3XjU6ex0+AgFw98G8yRDozz7RXfmv4zZidI05+WJOvOIbLW7T357nFbKD62j6RQUqcvZVJZfmUOCUR1VN2AraQRDXg95ifVKxZQusavR0f6GAaGXsNiq2mMUOH5humAiKCf5t+qFZVGWwuSB2yXLIQAKG0oidEVCeNP0lsvpDjNCap1FsZqjsUc1hYHzvyCrzhobQXlEdyeSLYn1VsLO8BtcUJVwRtApXnln5Lqm2aOwn2O1sHmwhcde2QW118IW0+fnYXenYPtzFX8LlTOCAsdkv12l1JTRgWWX7SzA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D55A472813BDC4B81E5835EC0F5AC87@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c31f7bf-8a67-48e1-e0a9-08d7825757e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 18:39:54.2356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8oSLAw1ijarW/SZwh7x6R0hjRmH6zzrNYY81KuuNqSvWWJAdI+KuQ9J/acHaFLTNPOL0oFw/XRWTUfNxi0lSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2169
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTE2IGF0IDE3OjU0ICswMDAwLCBSb2JlcnQgTWlsa293c2tpIHdyb3Rl
Og0KPiBGcm9tOiBSb2JlcnQgTWlsa293c2tpIDxybWlsa293c2tpQGdtYWlsLmNvbT4NCj4gDQo+
IEN1cnJlbnRseSwgaWYgYW4gbmZzIHNlcnZlciByZXR1cm5zIE5GUzRFUlJfRVhQSVJFRCB0byBv
cGVuLA0KPiB3ZSByZXR1cm4gRUlPIHRvIGFwcGxpY2F0aW9ucyB3aXRob3V0IGV2ZW4gdHJ5aW5n
IHRvIHJlY292ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgTWlsa293c2tpIDxybWls
a293c2tpQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHByb2MuYyB8IDQgKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Zz
L25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gaW5kZXggYWFkNjVkZC4uMDRl
NmExMyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gKysrIGIvZnMvbmZzL25m
czRwcm9jLmMNCj4gQEAgLTQ4MSw2ICs0ODEsMTAgQEAgc3RhdGljIGludCBuZnM0X2RvX2hhbmRs
ZV9leGNlcHRpb24oc3RydWN0DQo+IG5mc19zZXJ2ZXINCj4gKnNlcnZlciwNCj4gIAkJCQkJCXN0
YXRlaWQpOw0KPiAgCQkJCWdvdG8gd2FpdF9vbl9yZWNvdmVyeTsNCj4gIAkJCX0NCj4gKwkJCWlm
IChzdGF0ZSA9PSBOVUxMKSB7DQo+ICsJCQkJbmZzNF9zY2hlZHVsZV9sZWFzZV9yZWNvdmVyeShj
bHApOw0KPiArCQkJCWdvdG8gd2FpdF9vbl9yZWNvdmVyeTsNCj4gKwkJCX0NCj4gIAkJCS8qIEZh
bGwgdGhyb3VnaCAqLw0KPiAgCQljYXNlIC1ORlM0RVJSX09QRU5NT0RFOg0KPiAgCQkJaWYgKGlu
b2RlKSB7DQoNClVnaC4gSWYgd2UgbmVlZCBhIHN0YXRlPT1OVUxMIGZvciBORlN2NC4wLCB0aGVu
IGxldCdzIGdldCByaWQgb2YgdGhlDQpzd2l0Y2goKSBmYWxsIHRocm91Z2ggaW4gdGhlIGFib3Zl
IGNhc2UsIGFuZCByYXRoZXIgYWRkIGEgZGVsZWdhdGlvbg0KcmV0dXJuIHRvIHRoZSBFWFBJUkVE
IGhhbmRsaW5nLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
