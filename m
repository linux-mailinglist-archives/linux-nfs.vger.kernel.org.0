Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E63DBB08
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jul 2021 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhG3Ost (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jul 2021 10:48:49 -0400
Received: from mail-bn7nam10on2134.outbound.protection.outlook.com ([40.107.92.134]:56416
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239200AbhG3Ost (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Jul 2021 10:48:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkXqss0SZ47WuFxJqyAToNqod8MjGLTd+toO7U7cDRPS4HgpJnG1IYmkLegz1HJahymTUDckWeyJZCXFAe2iUT9Kz2f8jzMlLKtDfe1KkyXvozeMm/YLSYmfH/mb+VZbkP1ZVx4Ia+Kt4hRmXGybMBRe30yO5PtHQHCl81Yvv7IS8fbTBhLGmQr0Un5O/Q5DsjJ3Nw7eTRwE7vG534xmRj5e3owD68TX+foHPau4P/Ja+1LLv36d+WUyWyLw8BzfdB+/kDnvX5crnBJvS1hLKx729x4xSu+iQJBvepRU0jK52RKnUNgI++kUNtpVd+saK8WlSR+g5rimlLYdlDIuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOtDzZlDJNZtRjFvOFGLv0MgyLZu9aOeiROMytDjLBE=;
 b=Io/9kyaVdVobIPVLdTv8n9TjNqSsVnaQ2wJyVzzEd8oiWaC37zjX7thDSa0zbsR3FT4pOBRZPUYmvQkvxPcmooWa5nNmJ5PhFfSjZ9+CgUFwCD9/epNo7hHt+B0s2FRTa5LHzAPlymPbJEJHJRppD5RJVG4kPO4krMaiArdPiZHaN2Dk8HmIpGGP979cQ+BEOU0eF4pv8+eIpcHER/ElBkFED+akZv4+oV5CHMLee+Q3qL5WezTGBZ12WsloNgGE/r8wS9a3nhB3+sgWHiUcRqywx2owXR8FMI9kCVeZemBanq7lTiD4Nqe1TyW/HghXxnc6jcDzW3ukHi9bKSm2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOtDzZlDJNZtRjFvOFGLv0MgyLZu9aOeiROMytDjLBE=;
 b=NW83CLAxaVJ2gCuCZF63FE/EkF6ni2563vIsNqgnZDfgwBIUXvs2Zkx4q9xOl69ZEQD/O70I2JecQtR/QF6CxxqSBa/cVakAXxIuGsiuG16GXC43zuOBa/MTV1QfGVGEBp/kP+dWd7Q0Eps+7NvXINES3XkmVZrApMKb39x7kds=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3430.namprd13.prod.outlook.com (2603:10b6:610:23::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.16; Fri, 30 Jul
 2021 14:48:41 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4373.018; Fri, 30 Jul 2021
 14:48:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "plambri@redhat.com" <plambri@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqA
Date:   Fri, 30 Jul 2021 14:48:41 +0000
Message-ID: <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
In-Reply-To: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214189a4-004f-4960-8bfa-08d953691f78
x-ms-traffictypediagnostic: CH2PR13MB3430:
x-microsoft-antispam-prvs: <CH2PR13MB34305E52DD905647C425A683B8EC9@CH2PR13MB3430.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMCwzcDmC71rUfGxk7iOTRqguDd7P1c/IO+fgZD5oH88J/6zBCh46bjx0+tOroitY72XkQ/p/k2uV4Cqqlnb4zmiw1jI3dLssrAE+OfnG3lSY9ej04KJece4ZCJ5CwVF+e+8EhUWHgBf8lMFTRd+vQ2nKfFqpCuGepH3JPueEaNwB07MLN1E7UQ4UGUIQPGGijoLiB+YzworEby7Tqt/r3ond2eNfulli9++z1JOSgnfy4e6I2vZkRn2Cygme4rkovmV2BmkjmKFzQhUajNF+q8wy9OJgExNuWCTi8mLggM01VjkJw0oWZLQlVcan08duUxvd/c7MiGoBEP4yqipQDI8QAHXKP+1brq//DBR+aADGhuZfQpNUTTbVXys5ycpu1muoNoKnAgpjZCY1O+s2VNEymegfWPKmk5ZB50r1jLnCwahw3YPq71x9H7I/VFjsZLXJ+DCzWczqS4p0EZDKCeTXsZc8gr4qKVNZroEMPZrCgO7jP1SpI94Dip6JTYc49JIg46CtNrjxJkqPylmnN+tG6M/pWN++79vonyj6WUoWU0rWljmjUS66i3F8Z9tn6pxEIYuo+oybzxm/ruVecwxQulyf0b08w3E96wOOUiMW8rQxIpuLjpaK/AOiIZSw67ipo4nDbxpUEbmHdrFDdCYrXLqu4Ssb+B0JYiUikqVIwHf1mnHzgCSpUzT7z7YVq3Iea+VNfz6B3Lqu9FTXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39830400003)(136003)(376002)(346002)(316002)(6506007)(6486002)(66476007)(66556008)(5660300002)(26005)(6512007)(71200400001)(8676002)(86362001)(2616005)(8936002)(36756003)(66446008)(2906002)(76116006)(83380400001)(66946007)(64756008)(38100700002)(478600001)(122000001)(4326008)(38070700005)(186003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW1UcUdZTURJNk5yNUgxaUtLNmRiU2RaTW82WGFHL0orOEZYczY1eXdHTUFW?=
 =?utf-8?B?TWJqazNZc2hJamR5U2xnSWQ0UTl4YTVTQnlFa3lxaXVIbThENFNXNmdWa2g1?=
 =?utf-8?B?ZWU5cmRXOUpwRjNBdGtDUDdoOEJiVUlzejNHMkRmZm9rb2ZZN0lXUmJYNHpj?=
 =?utf-8?B?dUtuWVYycVJxdHhlN3pDMWRueEdCeVI3YVc0aDJ4WG50SEwwS0NTdzFmYk9H?=
 =?utf-8?B?Q3ovdDcxLy9UZ3JUR1Jqa2hNUU9WT25LcTdrR2dLRGo3QklxUnZXR2c1Rlkw?=
 =?utf-8?B?UWFzT1pZSGNBVnF2ZE9NYlA3QWJCd1QzOVNpTlVmcHVGWkx6Z0t2a2lZKzdS?=
 =?utf-8?B?WFY0UU9sZlZEL3ZpdmdhUVBFcWlzNkp1UWFCWWFUeFNuNkI3NXVYaVQ1dmZH?=
 =?utf-8?B?ckl6ZStUWmo5dU1oRHRwS053SXV4MWhuMHVQS1BYQzVNQnhaeEZESmdCQ250?=
 =?utf-8?B?aFMrcmIwVnE2T0w1aEpDQkF6K25Eb2h3eEhVVXlEVm93dmRJd3V3bTlKbW5l?=
 =?utf-8?B?aHNNKytLUU9CL1IreEpzU0tmdGd5NEU2VVVyRm96a0d2eXRnSmVDdHlmbnVB?=
 =?utf-8?B?MW55ZmtqcmpJekVCK0ZCS05wbTZoWE9VUmI2bm51VVdLcWh3dzR2WXl0TlNj?=
 =?utf-8?B?dnBObldZSGdOQTJHbzdIWENTVFRyTzlhRTFVcjZVY01UbU5IVkFYMWFuc3ln?=
 =?utf-8?B?U1Zjck43V1FRZElhTEtVMFZZMGdZNkY3emUxd3hFV2dBNGZ6ZDhMa08zbVY0?=
 =?utf-8?B?eWdzSzJ3K1BWa3Q0cVdTbGRwVXZYeTJOb09xRjc0WER2N2FrU1Z2ZUw5Ri9N?=
 =?utf-8?B?V3AvTkJoZmV5aWw4cVlIdlNmU3BiZ0pGaEltcWNuOXBmZlo4L25pM29LTHpx?=
 =?utf-8?B?L3h1RTFsQkhYZUVaNjMzdnNHeXBMVENwczVlOWFrNWRIb3dVcDB6VkZwcHMw?=
 =?utf-8?B?cTZKUjdlKzhramZRNFFDcS9yY1VpNkNWbHl3RyttdGNqNXJBbGNJcUh6M01p?=
 =?utf-8?B?RTc5TURNQkY1dlNDNVB1bEJlbkQ0eVVxeEE0VEo2WE9abzB5bm1IS1R6T1Nw?=
 =?utf-8?B?T1JZMWN4OFNISmtZczRZUE9IVmpneUNVc0RTN2RXMXU0Z1hlUWVIMkZRNE1q?=
 =?utf-8?B?VHAzUXNxWis2OEtJOEQwdUNGbEphbmZEbkM4VjJ2cjRTeHRvVjlEc2VFK25P?=
 =?utf-8?B?d3JrUjlwb3k0QkNua1pmR2FsdU1WYjd2cXBiRU04L1Y3MUEwQVY2UnlQU1pj?=
 =?utf-8?B?N0oyejRiM0VWRHZNcHk5bnFsMkxiZCtxVzJmUTN2dlNPYjNsbVlGVlpzQ3lT?=
 =?utf-8?B?bUU1KzNyWjVRclBvUHdwV2R0dlhpdmpIVk5jU3BEendwZDBhbTJDZ2V0OWlF?=
 =?utf-8?B?akhFV3hIRG1iOWhPeUNIN2Y2STY3dXZpUlp0S0hNbUdybVFIZnJzcjduc0FC?=
 =?utf-8?B?dDFWOTQ5MnBuYjdMeWxGUDZrQjFOZTJ1d3NzMXNIWVJ6ajBZM01ScFZiRXkv?=
 =?utf-8?B?NTA2eG1TQXQ0VlhDcmFDd24zbnBrUHh2bkVDMko3QnhaRFZGcWhqdmpSUW5D?=
 =?utf-8?B?cE00c0NGTFBEV2xLUFRReEdUaFYweHI1aWJWUnltUExIWmhpMWVpQ2VYazdC?=
 =?utf-8?B?em5XaTlzejZSNGFoaWs3VXJ6L3RVdHV3N0FQQzd3QmpZZHpwWjQybHBrK0xk?=
 =?utf-8?B?NjRrSjV6Ky9ZdVp0dUtYTWRIZ1kwdE9zd0krbmx1ekVwT1I3RW83Ty9hU0M5?=
 =?utf-8?Q?IHZVIfh9NJTAGmI7iEWimTUyaSEDs5myj4Y+Uh5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <71713E8CAF6B084AA4951B8E52EEDCE5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214189a4-004f-4960-8bfa-08d953691f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2021 14:48:41.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7VOSoIuB3zDth3MTKFMYaPh9Mhhug4zrIaFGtfxDojHOJSKc26YFupVHfDVRiVmRO2xRBCh4EOLiL8jVhvGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3430
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA3LTMwIGF0IDA5OjI1IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBJIGhhdmUgc29tZSBmb2xrcyB1bmhhcHB5IGFib3V0IGJlaGF2aW9yIGNoYW5nZXMg
YWZ0ZXI6IDQ3OTIxOTIxOGZiZQ0KPiBORlM6DQo+IE9wdGltaXNlIGF3YXkgdGhlIGNsb3NlLXRv
LW9wZW4gR0VUQVRUUiB3aGVuIHdlIGhhdmUgTkZTdjQgT1BFTg0KPiANCj4gQmVmb3JlIHRoaXMg
Y2hhbmdlLCBhIGNsaWVudCBob2xkaW5nIGEgUk8gb3BlbiB3b3VsZCBpbnZhbGlkYXRlIHRoZQ0K
PiBwYWdlY2FjaGUgd2hlbiBkb2luZyBhIHNlY29uZCBSVyBvcGVuLg0KPiANCj4gTm93IHRoZSBj
bGllbnQgZG9lc24ndCBpbnZhbGlkYXRlIHRoZSBwYWdlY2FjaGUsIHRob3VnaCB0ZWNobmljYWxs
eQ0KPiBpdCBjb3VsZA0KPiBiZWNhdXNlIHdlIHNlZSBhIGNoYW5nZWF0dHIgdXBkYXRlIG9uIHRo
ZSBSVyBPUEVOIHJlc3BvbnNlLg0KPiANCj4gSSBmZWVsIHRoaXMgaXMgYSBncmV5IGFyZWEgaW4g
Q1RPIGlmIHdlJ3JlIGFscmVhZHkgaG9sZGluZyBhbiBvcGVuLsKgDQo+IERvIHdlDQo+IGtub3cg
aG93IHRoZSBjbGllbnQgb3VnaHQgdG8gYmVoYXZlIGluIHRoaXMgY2FzZT/CoCBTaG91bGQgdGhl
DQo+IGNsaWVudCdzIG9wZW4NCj4gdXBncmFkZSB0byBSVyBpbnZhbGlkYXRlIHRoZSBwYWdlY2Fj
aGU/DQo+IA0KDQpJdCdzIG5vdCBhICJncmV5IGFyZWEgaW4gY2xvc2UtdG8tb3BlbiIgYXQgYWxs
LiBJdCBpcyB2ZXJ5IGN1dCBhbmQNCmRyaWVkLg0KDQpJZiB5b3UgbmVlZCB0byBpbnZhbGlkYXRl
IHlvdXIgcGFnZSBjYWNoZSB3aGlsZSB0aGUgZmlsZSBpcyBvcGVuLCB0aGVuDQpieSBkZWZpbml0
aW9uIHlvdSBhcmUgaW4gYSBzaXR1YXRpb24gd2hlcmUgdGhlcmUgaXMgYSB3cml0ZSBieSBhbm90
aGVyDQpjbGllbnQgZ29pbmcgb24gd2hpbGUgeW91IGFyZSByZWFkaW5nLiBZb3UncmUgY2xlYXJs
eSBub3QgZG9pbmcgY2xvc2UtDQp0by1vcGVuLg0KDQpUaGUgcGVvcGxlIHdobyBhcmUgZG9pbmcg
dGhpcyBzaG91bGQgYmUgdXNpbmcgdW5jYWNoZWQgSS9PLg0KDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
