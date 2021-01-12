Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F922F32F9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Jan 2021 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbhALOcH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Jan 2021 09:32:07 -0500
Received: from mail-mw2nam12on2128.outbound.protection.outlook.com ([40.107.244.128]:42368
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727033AbhALOcG (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 12 Jan 2021 09:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEYJdK5w0kgNl1kY/iLlxJTaOYZyKbu1KkDwaFYTt1co4dINoeLfmKSd0BSqnHwSbLgzEuYQuRzMAUprohUoYy6hbOL54CDM+bsMzxR10nLoPSubM3HDxFa8A1TLkMBGt6AuE3Ya1N7a4o8SLySKRTiX/emAWRWjgClveuNjluFbT4djCE27qyEtm194C6gCuRgogo8qcuN4pofWe0H0U5z4iz0ulLdKx6zCxbA8kCeRtjhF5c8m+yNyDnMigbDJ05DLwy38wIKTb4c7JubDUQchCLQBnjKDIA/1GW9qBJU0ZcROXUERYzr0nZek4Z9XJtMyTSrAxGS8ihcd3C8fLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l14Ui8t721gegBJNbZ3A5xzu9QaTAI7fspg/+qopT3Q=;
 b=OlRT/rSF53YNag9V07bKYrHKbyiPhgU1W9bLMlYLFxLiRAC/ZlVZnPB1mr2BDwq20nAXZhKlw1emBOt5oWP33GlzAgYMrQ5u0ROHPgLbalTfjAc9imaBMLW44LDmowssIg22ZOk27scfNUimcxu6jTEty++kdqlLZyg76xCVW3HHWb4bbt86rD04BOvlFx1rvN563bBFw+f50eHalIYTv+JwnPtyRhu4pJCoXiRUOBVrXDz8FAKdEtoQvDPfLQfdMs/S/qrMqIbffAgVBCNqsDR5/n49BYuVYUqTbA0doYpd9YPeaEZV5kVEQ8y2sgELm1eQEFlaUHHmaSy1s9BgtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l14Ui8t721gegBJNbZ3A5xzu9QaTAI7fspg/+qopT3Q=;
 b=c+C5RnBQAwFHC3q2NkC46uVv9iW8r+0GnPTHUz6OWwSW2/Gl1v1HDx0VyPHZjS2HQRh37Zrtu+zFn7lyec0TT17Xhu8ahJbNN712XmJ9FW1e6lY5xw0uc77GfF6uXoYr1FkfoT+GfF9eCxwAShIY+E+WIV+NEIiiVLujgZe2ZG4=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3784.namprd13.prod.outlook.com (2603:10b6:610:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.6; Tue, 12 Jan
 2021 14:31:12 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc%6]) with mapi id 15.20.3763.009; Tue, 12 Jan 2021
 14:31:12 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHW6O+T968aSUv5BEuskih09s91eQ==
Date:   Tue, 12 Jan 2021 14:31:12 +0000
Message-ID: <6c2dd95f73b0fcb9715e985bdde7dfb640ce8795.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0cff9d3-1880-4bc7-3dbd-08d8b706b61b
x-ms-traffictypediagnostic: CH2PR13MB3784:
x-microsoft-antispam-prvs: <CH2PR13MB37840036B55B007F74142E90B8AA0@CH2PR13MB3784.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzYvLn4Ts2D3ojQlrSfRYgn+61oYehfLGjGxHy7e2DMSs5EB+FCnKLAQ3ZIvvJZmXKHfAiAgxm46JMC61BLT3CHwk6JebCkmbJ+DxEJAgNAssmMngVLL3P6haom3Ex4MFlWz6A7r3VoM9OMGrZTKHNgKv8pcVs+fst1pXbToyt3fnqxwJy/PzcxBH2v2kaEj8ouIeq393S0mUaItmJl71EsiR6d/BAiEzLVpnNk+IXyuoayJbyuFfw+7R6k7br6aklPGTjt5LZ3hgfjjaunB0VQg8u+jUe0d82rZQgHHbrgFkVm8SkYynkRsnIIjDvtc6cLFIwSMLQbll7ayTXy+pc8dCdj2P7TP5SmpZkW5TKfw8bsFVb7HJPNXSafDDgYUfTJM4pQFngQhhD/iuy42kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(366004)(39840400004)(5660300002)(54906003)(26005)(478600001)(66446008)(6486002)(76116006)(2906002)(316002)(66556008)(6916009)(86362001)(64756008)(6512007)(66476007)(66946007)(8676002)(6506007)(83380400001)(4326008)(71200400001)(186003)(8936002)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UU5sblJJLzJXL0ZNTzM1OGFSaEJpOFlkWGhTM1hpTjNrWXpTS3hXS1VEbUIz?=
 =?utf-8?B?ckJxalJIcXRpZVdrZUxnaWcxZDlOdHlaNlV1QkxhV2h4UmVwOVdXUWVPcUU0?=
 =?utf-8?B?TmtobUpJVHpHY3lSZTQ5b1QwZU1pWEpCSnlZV25NdXhvZWJVWXNzWGRYRkhV?=
 =?utf-8?B?Y0RzdjNFUGs4K2FLWFY0bTlXR0NpeHRtaEk3WVgvZ0VBcEl1R2d1VDRXbWVy?=
 =?utf-8?B?THRleFl4bzlvODFwNHl2SFNoQzFYMzdueXlZTmpwdi9EcXl3WFIwSXJ5clh2?=
 =?utf-8?B?ZlVqV1NpaUh6UU93VXE2VGtZR1FzQndVN0tnaWdubXRJWXgvTklqMXpvRnpo?=
 =?utf-8?B?Vk5rQWg4QkRRWmJwZzBSemFnM01SMDBsT0V5R3d2L2VHTkN6TWtSeDZVSXE3?=
 =?utf-8?B?NjIzOWlPZ0svVlVXVGJSOGJndkxXS1JXUlFCSVdhditNUXQrbTlxZ2lZSmxW?=
 =?utf-8?B?OHN0RWZWMm45NWNSRHorRHMxVW9ESDQ2MHAraHBtR3FaeVFFL3pvOE9FR0xn?=
 =?utf-8?B?Si8wSCtsQ0swMVBhMnVTVWdoSDdla0tvSUJDRVVORUR3Rml4MWx5ZGdqSlZu?=
 =?utf-8?B?eXVnODg5elFTaE1HUlF4eXhxYVBaMnREek1maG1PMGhRMjJmLzcvR3c3SE5B?=
 =?utf-8?B?WTMxMjU3dlFOQjVsVFFzUlVBd3ljelZXLzRXZ1dZZExOWEg5QzNlN2psMGd0?=
 =?utf-8?B?cHl2NDNyVXFobzMxUGxUbWFLcVl0Wis3RHZXTjNMc3pMRnBNSlk5VE8rNkk4?=
 =?utf-8?B?QkxaSjFEdVY1Z0ovcG5iWGR3K3ZFM0RUVGhpWms5Z3VXUzcyQzB4VDFXMlk2?=
 =?utf-8?B?c1gvWlJtOCtRYkg0RWY0RmlOYTFIY1IzWUdWclRVcitrNnQ5Z0V1aW5rSytm?=
 =?utf-8?B?S1A3cVlBOGFOMGlQMW9oL3h2Sy80aWk0WU1qVndUUlJ1a09DNm9GeURSRGZW?=
 =?utf-8?B?dkRyZW8wTXdFdFZvUXVORklWWExWRFAxNmVFdG8zdHExUTB6Y0tWMnp5RUdh?=
 =?utf-8?B?bjFFaW9hSEFob1J4UEdoTWx0emphVWt1Z1pJeEx6Nzc0TjVxRjVEbzdoT1Yx?=
 =?utf-8?B?OVlCVDFvUmtqRWc3R3hpVFdsUzdqUkRlTUxQUFY1U05jL1VZZXpKdGJOWDVl?=
 =?utf-8?B?c3RCRlhTMHRPYmcvem12TktVS0F2d3I3Zk1ITDc0dDUzVEN6RXhISWh1Mkh0?=
 =?utf-8?B?OWxmNjI5eTV4M01sWC9JNG5BMGhGQUFYV1IrSGt1RDY5WWV4aGNxNGxlUkd2?=
 =?utf-8?B?YW1oMEx4Rk1HU1lpSXpIenpxWHdGKzRNYXNUSU95aTJ6T2h3Y1RTaVpURkdM?=
 =?utf-8?Q?R7P2x8zg0MGY7AGgF+OCrZ6dit2qBeruDA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <28FFE11BF964DB43907413F65B18EBAE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cff9d3-1880-4bc7-3dbd-08d8b706b61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 14:31:12.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxvFSsjxoon1rsJy+lZ2z2JANqisDhETfBo7rjkw0Rwx8AgCHErjOvuhoWG3ynVHSBo8ewi+nwydsBDrfzz76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3784
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZTcxYmE5NDUy
ZjBiNWIyZThkYzhhYTU0NDUxOThjZDkyMTRhNmE2MjoNCg0KICBMaW51eCA1LjExLXJjMiAoMjAy
MS0wMS0wMyAxNTo1NTozMCAtMDgwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvdHJvbmRteS9s
aW51eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci01LjExLTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIDg5NjU2N2VlN2YxN2E4YTczNmNkYThhMjhjYzk4NzIyODQxMGEyYWM6DQoNCiAg
TkZTOiBuZnNfaWdyYWJfYW5kX2FjdGl2ZSBtdXN0IGZpcnN0IHJlZmVyZW5jZSB0aGUgc3VwZXJi
bG9jayAoMjAyMS0wMS0xMCAxNjoyOToyOCAtMDUwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZTIGNsaWVudCBi
dWdmaXhlcyBmb3IgTGludXggNS4xMQ0KDQpIaWdobGlnaHRzIGluY2x1ZGU6DQoNCkJ1Z2ZpeGVz
Og0KLSBGaXggcGFyc2luZyBvZiBsaW5rLWxvY2FsIElQdjYgYWRkcmVzc2VzDQotIEZpeCBjb25m
dXNpbmcgbG9nZ2luZyBvZiBtb3VudCBlcnJvcnMgdGhhdCB3YXMgaW50cm9kdWNlZCBieSB0aGUN
CiAgZnNvcGVuKCkgcGF0Y2hzZXQuDQotIEZpeCBhIHRyYWNpbmcgdXNlIGFmdGVyIGZyZWUgaW4g
X25mczRfZG9fc2V0bGsoKQ0KLSBMYXlvdXQgcmV0dXJuLW9uLWNsb3NlIGZpeGVzIHdoZW4gY2Fs
bGVkIGZyb20gbmZzNF9ldmljdF9pbm9kZSgpDQotIExheW91dCBzZWdtZW50cyB3ZXJlIGJlaW5n
IGxlYWtlZCBpbiBwbmZzX2dlbmVyaWNfY2xlYXJfcmVxdWVzdF9jb21taXQoKQ0KLSBEb24ndCBs
ZWFrIERTIGNvbW1pdHMgaW4gcG5mc19nZW5lcmljX3JldHJ5X2NvbW1pdCgpDQotIEZpeCBhbiBP
b3BzYWJsZSB1c2UtYWZ0ZXItZnJlZSB3aGVuIG5mc19kZWxlZ2F0aW9uX2ZpbmRfaW5vZGVfc2Vy
dmVyKCkNCiAgY2FsbHMgaXB1dCgpIG9uIGFuIGlub2RlIGFmdGVyIHRoZSBzdXBlciBibG9jayBo
YXMgZ29uZSBhd2F5Lg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpEYXZlIFd5c29jaGFuc2tpICgxKToNCiAgICAgIE5G
UzQ6IEZpeCB1c2UtYWZ0ZXItZnJlZSBpbiB0cmFjZV9ldmVudF9yYXdfZXZlbnRfbmZzNF9zZXRf
bG9jaw0KDQpTY290dCBNYXloZXcgKDEpOg0KICAgICAgTkZTOiBBZGp1c3QgZnNfY29udGV4dCBl
cnJvciBsb2dnaW5nDQoNClRyb25kIE15a2xlYnVzdCAoOSk6DQogICAgICBwTkZTOiBNYXJrIGxh
eW91dCBmb3IgcmV0dXJuIGlmIHJldHVybi1vbi1jbG9zZSB3YXMgbm90IHNlbnQNCiAgICAgIHBO
RlM6IFdlIHdhbnQgcmV0dXJuLW9uLWNsb3NlIHRvIGNvbXBsZXRlIHdoZW4gZXZpY3RpbmcgdGhl
IGlub2RlDQogICAgICBwTkZTOiBDbGVhbiB1cCBwbmZzX2xheW91dHJldHVybl9mcmVlX2xzZWdz
KCkNCiAgICAgIHBORlM6IFN0cmljdGVyIG9yZGVyaW5nIG9mIGxheW91dGdldCBhbmQgbGF5b3V0
cmV0dXJuDQogICAgICBORlMvcE5GUzogRG9uJ3QgY2FsbCBwbmZzX2ZyZWVfYnVja2V0X2xzZWco
KSBiZWZvcmUgcmVtb3ZpbmcgdGhlIHJlcXVlc3QNCiAgICAgIE5GUy9wTkZTOiBEb24ndCBsZWFr
IERTIGNvbW1pdHMgaW4gcG5mc19nZW5lcmljX3JldHJ5X2NvbW1pdCgpDQogICAgICBORlMvcE5G
UzogRml4IGEgbGVhayBvZiB0aGUgbGF5b3V0ICdwbGhfb3V0c3RhbmRpbmcnIGNvdW50ZXINCiAg
ICAgIE5GUzogbmZzX2RlbGVnYXRpb25fZmluZF9pbm9kZV9zZXJ2ZXIgbXVzdCBmaXJzdCByZWZl
cmVuY2UgdGhlIHN1cGVyYmxvY2sNCiAgICAgIE5GUzogbmZzX2lncmFiX2FuZF9hY3RpdmUgbXVz
dCBmaXJzdCByZWZlcmVuY2UgdGhlIHN1cGVyYmxvY2sNCg0Kai5uaXhkb3JmQGF2bS5kZSAoMSk6
DQogICAgICBuZXQ6IHN1bnJwYzogaW50ZXJwcmV0IHRoZSByZXR1cm4gdmFsdWUgb2Yga3N0cnRv
dTMyIGNvcnJlY3RseQ0KDQogZnMvbmZzL2RlbGVnYXRpb24uYyB8IDEyICsrKysrKy0tLS0NCiBm
cy9uZnMvaW50ZXJuYWwuaCAgIHwgMzggKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQog
ZnMvbmZzL25mczRwcm9jLmMgICB8IDI4ICsrKysrKysrKy0tLS0tLS0tLS0tLS0NCiBmcy9uZnMv
bmZzNHN1cGVyLmMgIHwgIDQgKystLQ0KIGZzL25mcy9wbmZzLmMgICAgICAgfCA2NyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGZzL25mcy9w
bmZzLmggICAgICAgfCAgOCArKystLS0tDQogZnMvbmZzL3BuZnNfbmZzLmMgICB8IDIyICsrKysr
KysrLS0tLS0tLS0tLQ0KIG5ldC9zdW5ycGMvYWRkci5jICAgfCAgMiArLQ0KIDggZmlsZXMgY2hh
bmdlZCwgOTkgaW5zZXJ0aW9ucygrKSwgODIgZGVsZXRpb25zKC0pDQoNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
