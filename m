Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE981215D2
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfLPSYq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:24:46 -0500
Received: from mail-eopbgr700101.outbound.protection.outlook.com ([40.107.70.101]:5344
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732052AbfLPSYo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 16 Dec 2019 13:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHujkp7CVVUQ8P3v7tV3AFFHghGlqfYv6Q05yNJPDnjtXzMp3kfxyhvw2sg9fNlj4obtYg+KOc2yyi6Vjnc1UtDERxdnEpnVhm8Zs60DwfPP8/d/2cw2D+BOFOvWbQsCOX1M/V2sSos38hz0ppx4z6HYqnan8w28GsNiWWKGnoof5zI70CVYIhhU11Q+ivUxxdThW/V5vVNT+Nh2nFXeadUFfyQ3OYs2/T6KYWtHH64urNLLOzZ/DLxaNtgwAYZdBE7GauMQzFd1CKEXkUGGXVIxYSNkjgzg69gW0LjoKXho3ggLhas1xuKOVkXOTCK44vVIHqheKdJ47jaxflMhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0fhl52scLtKcu/Z3lmmF87F0BKFSk7u7oqP+jP2hss=;
 b=IgAgf57RhOgg9uPLhFQiXJ7Ky6S6Ddhxg0IQ9KFuG2jPYMvEqCOM/Zbg7Qyt79JTv4Oy2jDadgvFcg1D2SHWAS/8gLhrtfKpih5oVwo42Q3cWpEmmQt4g8mTRGvQhxkwzzGupKhamyZFjbNYMA2skKCIKem54EkVLaDD1FQsDBZ6bGb3z7b3XdzjAJ7rB48V4+In+7Fq9bVEyOR0JmSLJSHJCws8xo73w2B+fCJPR7zwk7+IXGJa7CwP8fkoCyewXvribMRKJgrFbzmtycN6SGEfEeE2LhGjcEXL48yc7d6Tk7GZ39g6UCwJVfd034un3b5Zsex+EHWDBHcsSE0PUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0fhl52scLtKcu/Z3lmmF87F0BKFSk7u7oqP+jP2hss=;
 b=d6zgnrFu9bwcow02H/COZ92NZvqNya/fszdSOjb/wT8B9BLx4kHH5yK1UlMkZ2bTlbbeLEray3j3uso6KhIpsci/Y/A4XkPfo1WiDsAxWZng1nBMaeJg0Dw9D9VUEUKJvm0LQFR3dOnPIBONl7eOSHwKtKMSZfktFcjWDYt7Jcc=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2060.namprd13.prod.outlook.com (10.174.186.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.8; Mon, 16 Dec 2019 18:24:40 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Mon, 16 Dec 2019
 18:24:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmilkowski@gmail.com" <rmilkowski@gmail.com>
CC:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease
 renewals
Thread-Topic: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease
 renewals
Thread-Index: AdW0MytZJzbanD9yTZ+e0zLvCdtxJAACuc6A
Date:   Mon, 16 Dec 2019 18:24:39 +0000
Message-ID: <dea30ea3f0fc31e40b311c4d110c26cf40658dca.camel@hammerspace.com>
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com>
In-Reply-To: <056501d5b437$91f1c6c0$b5d55440$@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da240dad-5650-4da3-4458-08d78255369f
x-ms-traffictypediagnostic: DM5PR1301MB2060:
x-microsoft-antispam-prvs: <DM5PR1301MB206066E3505DC18C6523B300B8510@DM5PR1301MB2060.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(136003)(396003)(346002)(376002)(189003)(199004)(66946007)(64756008)(66446008)(4001150100001)(6512007)(66556008)(66476007)(36756003)(76116006)(316002)(54906003)(110136005)(71200400001)(2906002)(81166006)(6506007)(2616005)(86362001)(5660300002)(186003)(8676002)(4326008)(6486002)(81156014)(8936002)(508600001)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2060;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5vR7QDjBEe6tY4bm4B+qWigmsw+/P9qzKlnfM+BnZKXc2IP58IesYE6DhmKaV0N4GUl+8tWQ38TJ9mYT+/xTuCnblJF44hUL79dIKxlX1qXlQKc2eGrf5+vPAcnfpP8hHJizZ3Q7NT5pLShVaFLlBbWYrtSJSQlIjZy6f+Lhj8SzAu1GMjiRTyGn5Oj7243tHrODGne56X+cXaSFsSrzoSrsx6HRSSELc1FOvr0BYzSIGLh+bumfDjdV+xu9kiCSXCnOJkPocqxKC5xIzuA0zC6+gsd7j57k89YWcYeWCYfOXz9fXNrQlZjCoi7dZ6T6y2YiG1ucdTpvSrev5ZfNpUqftd4EHIvHD1s8kE2VZ8wZWmjuiii9OjGogdCpxFaK1t7ROHCV4f+yU/79axBPea1mIFCyNTtyEFzO9Ch0JaYTorCH7gAiPQ27g3VR1yyA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5778E02CA2275C47AE02D3E15C6799A9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da240dad-5650-4da3-4458-08d78255369f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 18:24:39.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGZ7oru2Q8L9bxpTRJsaob7+q9vzNl+cuLHvqoglhgoT0KCopsPgxepA6f9tU0h0fc6kU/el73ThrXvFF5b1bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2060
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTE2IGF0IDE3OjM4ICswMDAwLCBSb2JlcnQgTWlsa293c2tpIHdyb3Rl
Og0KPiBGcm9tOiBSb2JlcnQgTWlsa293c2tpIDxybWlsa293c2tpQGdtYWlsLmNvbT4NCj4gDQo+
IEN1cnJlbnRseSwgZWFjaCB0aW1lIG5mczRfZG9fZnNpbmZvKCkgaXMgY2FsbGVkIGl0IHdpbGwg
ZG8gYW4NCj4gaW1wbGljaXQNCj4gTkZTNCBsZWFzZSByZW5ld2FsLCB3aGljaCBpcyBub3QgY29t
cGxpYW50IHdpdGggdGhlIE5GUzQNCj4gc3BlY2lmaWNhdGlvbi4NCj4gVGhpcyBjYW4gcmVzdWx0
IGluIGEgbGVhc2UgYmVpbmcgZXhwaXJlZCBieSBORlMgc2VydmVyIHdoaWNoIHdpbGwNCj4gdGhl
bg0KPiByZXR1cm4gTkZTNEVSUl9FWFBJUkVEIG9yIE5GUzRFUlJfU1RBTEVfQ0xJRU5USUQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgTWlsa293c2tpIDxybWlsa293c2tpQGdtYWlsLmNv
bT4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHByb2MuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9uZnMvbmZzNHByb2MuYyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IGluZGV4IDc2ZDM3MTYu
LmFhZDY1ZGQgMTAwNjQ0DQo+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25m
cy9uZnM0cHJvYy5jDQo+IEBAIC01MDE5LDE2ICs1MDE5LDE5IEBAIHN0YXRpYyBpbnQgbmZzNF9k
b19mc2luZm8oc3RydWN0IG5mc19zZXJ2ZXINCj4gKnNlcnZlciwNCj4gc3RydWN0IG5mc19maCAq
ZmhhbmRsZSwgc3RyDQo+ICAJc3RydWN0IG5mczRfZXhjZXB0aW9uIGV4Y2VwdGlvbiA9IHsNCj4g
IAkJLmludGVycnVwdGlibGUgPSB0cnVlLA0KPiAgCX07DQo+IC0JdW5zaWduZWQgbG9uZyBub3cg
PSBqaWZmaWVzOw0KPiArCXVuc2lnbmVkIGxvbmcgbGFzdF9yZW5ld2FsID0gamlmZmllczsNCj4g
IAlpbnQgZXJyOw0KPiAgDQo+ICAJZG8gew0KPiAgCQllcnIgPSBfbmZzNF9kb19mc2luZm8oc2Vy
dmVyLCBmaGFuZGxlLCBmc2luZm8pOw0KPiAgCQl0cmFjZV9uZnM0X2ZzaW5mbyhzZXJ2ZXIsIGZo
YW5kbGUsIGZzaW5mby0+ZmF0dHIsIGVycik7DQo+ICAJCWlmIChlcnIgPT0gMCkgew0KPiArCQkJ
Lyogbm8gaW1wbGljaXQgbGVhc2UgcmVuZXdhbCBhbGxvd2VkIGhlcmUgKi8NCj4gKwkJCWlmIChz
ZXJ2ZXItPm5mc19jbGllbnQtPmNsX2xhc3RfcmVuZXdhbCAhPSAwKQ0KPiArCQkJCWxhc3RfcmVu
ZXdhbCA9DQo+IHNlcnZlci0+bmZzX2NsaWVudC0+Y2xfbGFzdF9yZW5ld2FsOw0KPiAgCQkJbmZz
NF9zZXRfbGVhc2VfcGVyaW9kKHNlcnZlci0+bmZzX2NsaWVudCwNCj4gIAkJCQkJZnNpbmZvLT5s
ZWFzZV90aW1lICogSFosDQo+IC0JCQkJCW5vdyk7DQo+ICsJCQkJCWxhc3RfcmVuZXdhbCk7DQo+
ICAJCQlicmVhazsNCj4gIAkJfQ0KPiAgCQllcnIgPSBuZnM0X2hhbmRsZV9leGNlcHRpb24oc2Vy
dmVyLCBlcnIsICZleGNlcHRpb24pOw0KDQpOQUNLLiBUaGUgYWJvdmUgYXJndW1lbnQgb25seSBh
cHBsaWVzIHRvIGxlZ2FjeSBtaW5vciB2ZXJzaW9uIDAgc2V0dXBzLA0KYW5kIGRvZXMgbm90IGFw
cGx5IHRvIE5GU3Y0LjEgb3IgbmV3ZXIuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
