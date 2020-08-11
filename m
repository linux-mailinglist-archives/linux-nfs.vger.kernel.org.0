Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53E241C18
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Aug 2020 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgHKOIz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Aug 2020 10:08:55 -0400
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com ([40.107.237.109]:35072
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728516AbgHKOIy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 11 Aug 2020 10:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTzafLkgcN7gIxb6jkl8NVQwrXUXe8Q2uQ2oG2/8T+cT4EWxjvESRGHVDvSovgROxWsKo5ApCwrcl1eOWWGuZ5s4+zecu1pG6cIyQzgn5te5/gxqR6KA3ZDd+AWkad20i6CkEBZS2BgqfFarlOpu5ONycn13o8fwnjfV6YDyIne4wPAIyUIlxOpfHzWEyEem4wdNSi7MMhHgtr4xEZYsdxbXlCngmUQbptgv1S0eg8ajaa4ViroX6OvlrgfvQ3oVNp2s2+Q1ChkziBh+oA8sOLWu1Bd5qWGCvBYudp27Xd+xEqgED0w9qT4Y0KScGdkoYOiNfEgc3XwqNByX0XYEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQHAAoye2HqK7tjQF7N8UVGVSv/bY5VUtCwTq93pQw=;
 b=fcdgFlnkhrJAkC68iNRo05rRBqRkB8J4z98u2Ko73z5zZGx9Nq1lHiJtPrABhS0dBX+9rtRE10UgKm+3757ssPUZMzC71iSl+ofWCt0MQEPSNhJ2hV4fpOXvbA/o/rSm/QeUlV6R8JcmQKX4c0VGDSQWj4HjdAnHBzHXYCKR2te2P8gTU07aNu0u8fVh8Yt6kvg0ajuV0ENxLQPaGujdUG/YJnrZNIwDbcMxjkU/6iOroXjYR9C4ZlxPN5CWwwZTbX9uWBe5zDOGA/2S5wA5JaEDAeG8uYLCRN/kuCL5TGAgzveiVhkIZAZn0C0/+/MrNjjeDyk8DFR171tIymdUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVQHAAoye2HqK7tjQF7N8UVGVSv/bY5VUtCwTq93pQw=;
 b=b5qU5rXKa+yQknUzRpsJ+9yHrRAb4rSc4S2vUaChMEcw2/xx5awnyvJm+c27ZnZ9SyRru82JyLL3w75Jq3n7OfaGxe94gbZ/jfN+gGJhDc4ht8nrztXY+4Cxfgz/wHLEKZSsJjMwCNeCD3ZUMvfJtK/FY6U/Ma3CgWSxI4dOFdI=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3879.namprd13.prod.outlook.com (2603:10b6:610:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.11; Tue, 11 Aug
 2020 14:08:51 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::403c:2a29:ba13:7756%3]) with mapi id 15.20.3283.015; Tue, 11 Aug 2020
 14:08:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jeffrey.mitchell@starlab.io" <jeffrey.mitchell@starlab.io>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs: Fix getxattr kernel panic and memory overflow
Thread-Topic: [PATCH] nfs: Fix getxattr kernel panic and memory overflow
Thread-Index: AQHWa01EofftYhU/gkSiMLa8WGYG/aky+0OA
Date:   Tue, 11 Aug 2020 14:08:51 +0000
Message-ID: <0f8054d4b1e510cfdbccdb1355574c3e09ba30e4.camel@hammerspace.com>
References: <20200805172319.12633-1-jeffrey.mitchell@starlab.io>
         <20200805172319.12633-2-jeffrey.mitchell@starlab.io>
In-Reply-To: <20200805172319.12633-2-jeffrey.mitchell@starlab.io>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: starlab.io; dkim=none (message not signed)
 header.d=none;starlab.io; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67af3a74-6c43-4417-0e45-08d83e001342
x-ms-traffictypediagnostic: CH2PR13MB3879:
x-microsoft-antispam-prvs: <CH2PR13MB38790ABF921DF92603A3C0EDB8450@CH2PR13MB3879.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K4cPbUeKBYFiQXBLnL85aufC4pZl9sIFQurhyneZ9pPaKPj2Y7X9jAo/I94ur/0IRW2Tt4PePY8BkmmLcqOVbdCoNNGfcRiuRWLpVm2ChdGcVVvSz7IwhVRqtdQirkfjWldIYxbHnsSxs12q8yM8a/tIzJCrE7CC3i+9OIsx4ndqm8bMGGgoX8R58s04o/bj7yyQmVaDRsRACzsk8ukbdD63cgNyqOQvA7TPWIbYX/vmC2ak64laPfOuTbXUc5+r3RERJtMez15hoLBp1q2ulZvoDeOXdw3+BxTYxYquNY+PNrYgiBDfQCzWAO8MVMnMzazIZjoRxw6fPvMphHV0/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39840400004)(76116006)(66446008)(66476007)(66556008)(64756008)(478600001)(5660300002)(71200400001)(54906003)(110136005)(316002)(2616005)(8936002)(66946007)(6512007)(36756003)(2906002)(4326008)(86362001)(186003)(83380400001)(8676002)(26005)(6486002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BoutRpuH/dWSFZnf+PvXDQaMZ5wYPUi5y9npskinGTpscY8toXS57FLxKBO64xD6VIYbaAjI2hxOkwuQCBqCtDde26B0skfJGqR9tv/SJCloSJ4UmLzpvvpPMpzs4rJlKxHH3tz4S6yKUXweuRL57j+TPtJrw1o4/yprMpmb7AiVi82uzs4fDZIkMo380yXSfeMNUV+YN4EdC4P0gzyIDRxdO4oa91hnNTYjVgXf23SZHmlPNLLum+/+CaO32xtaewoU0nD6cXhX5v0ZpqTTxVRavjSq2n3SgfxQoUEf0IRUTfIT4YW5uxwfRumL/Qc7kMgAokupjuuUKlauy7rJce3q6RdpTSjhKN5n55hzkDvPcB7BpzuXIk8ufqxMxRlfnlHhb66/zlCvl9Q45PN2CP37H2wt4aNEBVZq6t/e1C4GRwl8MKVKuJFsw6x49tjSc7YNGkSkIH8UatOiq2N1z14f7Xjak39C1IiMs59yNtVXCqqKwTAqCAmdMAqHQUtbLCJF8POpcewxM2Cy1Z+8rINUviR4F0igUdBVlEp1uP2zplcxkrz2SlM07T7O6FBE4ddwDlsdLh94axdv/Gd6j/ctEq7psPigmMoboc5Wtr8HRb6XjHP9zkpBJCiYeXO8QRQB3Vou5+e6IsmBp4Wmow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8D022339B807C49A67F0AC2E8D7CBF7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3398.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67af3a74-6c43-4417-0e45-08d83e001342
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 14:08:51.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bGXtWpkJ+h4YwoLiOQz4/x628DM7X2ZV/C2iSaEYZAcb2Lw5TljMB2Q1rnSyQNFA9C4sKes/azTd2RXyJX68g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3879
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTA1IGF0IDEyOjIzIC0wNTAwLCBKZWZmcmV5IE1pdGNoZWxsIHdyb3Rl
Og0KPiBNb3ZlIHRoZSBidWZmZXIgc2l6ZSBjaGVjayB0byBkZWNvZGVfYXR0cl9zZWN1cml0eV9s
YWJlbCgpIGJlZm9yZQ0KPiBtZW1jcHkoKQ0KPiBPbmx5IGNhbGwgbWVtY3B5KCkgaWYgdGhlIGJ1
ZmZlciBpcyBsYXJnZSBlbm91Z2gNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplZmZyZXkgTWl0Y2hl
bGwgPGplZmZyZXkubWl0Y2hlbGxAc3RhcmxhYi5pbz4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHBy
b2MuYyB8IDIgLS0NCj4gIGZzL25mcy9uZnM0eGRyLmMgIHwgNSArKysrLQ0KPiAgMiBmaWxlcyBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBpbmRleCAyZTJkYWMy
OWE5ZTkuLjQ1ZTA1ODVlMDY2NyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4g
KysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gQEAgLTU4NDUsOCArNTg0NSw2IEBAIHN0YXRpYyBp
bnQgX25mczRfZ2V0X3NlY3VyaXR5X2xhYmVsKHN0cnVjdA0KPiBpbm9kZSAqaW5vZGUsIHZvaWQg
KmJ1ZiwNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAlpZiAoIShmYXR0ci52YWxpZCAmIE5GU19BVFRS
X0ZBVFRSX1Y0X1NFQ1VSSVRZX0xBQkVMKSkNCj4gIAkJcmV0dXJuIC1FTk9FTlQ7DQo+IC0JaWYg
KGJ1ZmxlbiA8IGxhYmVsLmxlbikNCj4gLQkJcmV0dXJuIC1FUkFOR0U7DQo+ICAJcmV0dXJuIDA7
DQo+ICB9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0eGRyLmMgYi9mcy9uZnMvbmZz
NHhkci5jDQo+IGluZGV4IDQ3ODE3ZWYwYWFkYi4uNTAxNjJlMGE5NTljIDEwMDY0NA0KPiAtLS0g
YS9mcy9uZnMvbmZzNHhkci5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0eGRyLmMNCj4gQEAgLTQxNjYs
NyArNDE2NiwxMCBAQCBzdGF0aWMgaW50IGRlY29kZV9hdHRyX3NlY3VyaXR5X2xhYmVsKHN0cnVj
dA0KPiB4ZHJfc3RyZWFtICp4ZHIsIHVpbnQzMl90ICpiaXRtYXAsDQo+ICAJCQlyZXR1cm4gLUVJ
TzsNCj4gIAkJaWYgKGxlbiA8IE5GUzRfTUFYTEFCRUxMRU4pIHsNCj4gIAkJCWlmIChsYWJlbCkg
ew0KPiAtCQkJCW1lbWNweShsYWJlbC0+bGFiZWwsIHAsIGxlbik7DQo+ICsJCQkJaWYgKGxhYmVs
LT5sZW4gJiYgbGFiZWwtPmxlbiA8IGxlbikNCj4gKwkJCQkJcmV0dXJuIC1FUkFOR0U7DQo+ICsJ
CQkJaWYgKGxhYmVsLT5sZW4pDQo+ICsJCQkJCW1lbWNweShsYWJlbC0+bGFiZWwsIHAsIGxlbik7
DQoNCkp1c3QgYSBoZWFkcyB1cCB0aGF0IEkgZml4ZWQgdGhpcyB0byBhdm9pZCB0aGUgZHVwbGlj
YXRlIHRlc3Qgb2YgbGFiZWwtDQo+bGVuICE9IDAgYW5kIEkgYWRkZWQgYSBGaXhlczogYmVmb3Jl
IGFwcGx5aW5nLg0KDQo+ICAJCQkJbGFiZWwtPmxlbiA9IGxlbjsNCj4gIAkJCQlsYWJlbC0+cGkg
PSBwaTsNCj4gIAkJCQlsYWJlbC0+bGZzID0gbGZzOw0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=
