Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F683505CF
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhCaRwz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 13:52:55 -0400
Received: from mail-mw2nam10on2095.outbound.protection.outlook.com ([40.107.94.95]:36064
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234694AbhCaRwf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 13:52:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdMFQgmpTDG6rT18efQBMVgpuM4nzsGyrb9OWA2ZkUB43/Jsob6JEvYGfOvmXRldH0vBai8w+xN8pE89ZXG7WKJz1YuGA7hbOLjiRkMR86m/r9kVO6gaHcF+xT0M/Fy4VQ1uQGUO5UdGUaPBAavAkedjs3UB1khKFhsmOx1H6mWMudwXmqN7N5sAPSCCC+M8mJrVTOieDN3A5uXZJJDp1w+52hLfgArjIdhF8DddxsgSi+v/R4o6zIrjREd7MwHTeyIgv+kGLvKZB/WUdkxp1WgWMDZ6WLwBVjh7rDs7zrMlVqYy/9qAq9OwE3sUGb8D2+9YV7Zv7IAgHn6LYXLQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drat7ZvtrOxvzN5BZtGKueEvFaWiAqE3UpA4lnlFytY=;
 b=mph3dJAyl1G9xjraOZ6EhH9rjBethy6St1QOYTj0wnypldixqSuCOyLtyQeUJYop3DtfPlqJa0fwSOvyM1KO/FlObKNPaHdmecn6pQOtmZyokFhE3a+hz0V9HKeTrdZ4ZPUzWH2AIwXvXFIbYTniT9D7BtZIg785E/Qv9kXEs1msphJXBDA+wNjXKpASleZKA6+p5bUX+dXv1OP03f8wHXWuL69Q2UHiRrQ01K3pwtTRfokCZDb0HiNKZdIbgaSF2omNzmXOhyjFO0utGO1Nx2ggKCgNC4GERyT2vsLRF/7JkPTdgs3VzrCo5ol205OYHoPeGhtZc2WU3h/eNwUQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drat7ZvtrOxvzN5BZtGKueEvFaWiAqE3UpA4lnlFytY=;
 b=Jl27kPrUgMsV/b3QrZJs/f+5Mlzq6hPHm+rMXWkZH23+WIdU0Ju9JIxsvUw2Wh3m1UOkdoj3ubJiHFOl7kpxqaaARSYo8OzZ1HJO40N2C/GANm1lXVUgHeCnAx2mg6r0NdQ/D89mKUzl1M/U5s8qFYjwlYqMyPU7Xpcx3lvRUEc=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3302.namprd13.prod.outlook.com (2603:10b6:610:25::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16; Wed, 31 Mar
 2021 17:52:33 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::69bf:b8e4:7fa0:ae74%7]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 17:52:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] SUNRPC: Fix trace_xprt_transmit_queued()
Thread-Topic: [PATCH 2/3] SUNRPC: Fix trace_xprt_transmit_queued()
Thread-Index: AQHXJlJr4/C7px77KUOZnxnvppLO8qqeYJmA
Date:   Wed, 31 Mar 2021 17:52:32 +0000
Message-ID: <0901650f31a528a21eb6962bdc13698bfff7bd50.camel@hammerspace.com>
References: <161721133412.515091.3634995666026759187.stgit@manet.1015granger.net>
         <161721134086.515091.16531400209127881709.stgit@manet.1015granger.net>
In-Reply-To: <161721134086.515091.16531400209127881709.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 662cbc50-472d-494b-15d4-08d8f46dc2c7
x-ms-traffictypediagnostic: CH2PR13MB3302:
x-microsoft-antispam-prvs: <CH2PR13MB3302C24B67991F565962F3B8B87C9@CH2PR13MB3302.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TgBKGsgxMI964AtgzR7uE8ezFoUMjyBSnAl692/xy0IftqlA1mq6uLJmtfAL1qfA9rel+P1RMqFN/k21ZwzRu7R3bBeV/SPE6TZU5fjYQoGKXnhY+yT+7S3y9paQt8YQZ2OVpnWOfwVFEqJvQ7+qpr+46cT0hTpW+HEGtuK9jfOFRyUWLAN+ytBN5Uq2kAfBHEtFicvhtHK4eY65dO1giTPbqKQhgDwS99Zf9VN0PzoSANxG7TpgDUwuvuwRDXvY6Fck/nEsXpZQTc+qthwSF8ddJ+Cq8xBYPmhqgnPEXmFXcfd1djLrMT1CEM+NanpzKUDwNNf0pbsgOc9bY0anzUyGyy5Bi/4uWcw3V8lHksbu7fgizcAAhffuRwWnZIluEaUVLME2RbSrca3lJZwXjDPB3gTvsFVQSVxfBnSbfoAoadHuahrqlGrsv+wEasdlH8wlIgT83IAL5UXS7UuPOqAFLZn4VPgUnfDoPXP0od6NuNueC5Ra0FK02Fp3YXmEuqbkoqeDcvJNycsffzV7U592uydqLyiDS8PTyQtVSCH15rntQIUeejG8bMgHx7f0h8T30fywbDpIPbTSKqLq7sTgpYpiowGUm4NG7lDbft1teuF9/k69ptVgCfKqc38cbpbMEKkVdgDWNZtTuEpz89Jet3Sz/oIU7g9pJfmR3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39830400003)(376002)(346002)(136003)(478600001)(8936002)(8676002)(110136005)(6512007)(83380400001)(66556008)(76116006)(36756003)(66476007)(66446008)(64756008)(66946007)(316002)(38100700001)(86362001)(6486002)(6506007)(5660300002)(2906002)(4326008)(26005)(186003)(2616005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dkJ3N3BicVhEcC9QdDRPTFFNQ0h4dWVxamtvdWwwdTdUQlBpYTJUd1gwT2h0?=
 =?utf-8?B?Rk4reEZ1TzZJM211NVE4eC94VThUY2VsNCtTd1ZuZ3VxKzNPQ3M3ZnFaUk9x?=
 =?utf-8?B?T0sxWGd6YmttUzZ0Y2hXL1dQaG1IU0E4SGtveEhZODBFeEFZMFp2RjdvOVFw?=
 =?utf-8?B?NkdrYmFZbGN6K2F4Zm9GRnNOUjVNOUtqb0Q1RFBaV3lDcENEUXFqVnVLSHB1?=
 =?utf-8?B?Y2JTNi9VMUhncXlwa2xnVzRtVWdsN0tWcFRWZVd5b0RTRkZRREwrc3htOTQ1?=
 =?utf-8?B?Z2RSOGNxVjZxVTZLQkhBQjcySjZZaUxMbGdoSnNEQzVNdUJGbkNoZ2FtSFky?=
 =?utf-8?B?eDl4QW1iMXdPTTNwSUxuNkxJcytYb3B1NStlTXVQVFh0K25UMk9mZ3FyNGJs?=
 =?utf-8?B?M0NKSFZpSXdZa3BVTDZtT0pUWVc5ajN5U3BGM0czbm96V1BLaWpXdXEyOUZL?=
 =?utf-8?B?dVViOE9ibmRzR3Z0Qi9XYWcyVlovK2ZoaVV1M0xocWdYUjhoNit4amZnR1A0?=
 =?utf-8?B?R0FFVjlFbmdaMG1SMXNjK2dqWThwa01KRnpxOEIwRzNYbWExNkI5MVM5bFB2?=
 =?utf-8?B?U2lLZUpkdjE1TmpUTUd1eFB2OHlqb1hBRnJXRXpndTN1WnZWT0xpa0lsQnhn?=
 =?utf-8?B?OHRRbEtlbm1samM0Tk0xTHdnVkJtUUJlejgvNHo5b1NqOUh0a3FvbWo4b0Vp?=
 =?utf-8?B?cURjN2NmNFJEb2Q4TUJINURERnFpRWtWS1o3ZGV0d1hKaFk2N3JMQ3FFUEZz?=
 =?utf-8?B?OE5JdzBJZks3bkVGd040bmV4OGJXSVV0bGJpNGF6WHdpa3ZsOUo5UTg5bGta?=
 =?utf-8?B?SzkwVVRmUkVlYmNCd1ZHNXEyemxwOTR1Tm1sbnNlTVc3SXF6T0kvbldzUm84?=
 =?utf-8?B?d0pqNkRhUEQ4QUhadllYbTQvSmNqMGxZZCtWZ2pZUWpWSFJSRTZwTEx2MHNI?=
 =?utf-8?B?c0cvTGRIcTNuQXpibVEwU1YzbVdHcnJDYnRkZkR2eVRCWXg2cCtyK2FwNFU5?=
 =?utf-8?B?NEVzZndtaytlT0dMbWwwcnA2cTJyL3R3Z2QrTE5OQkREL0ZWem0xaDlmZmNN?=
 =?utf-8?B?bFYvaS8wR1p0c0MzMlMyemsvTWlQbTA4bWFhQjlUTkNBMy94T0Z6RUkvOVpN?=
 =?utf-8?B?TG01N1NUamVROUFvcTQrczhaUnYxb3d2RTYrWUNKazBqRjNha1FNdm9KYTJ4?=
 =?utf-8?B?eEkvWlFpaWtCRks1Y3Y0c2d1anlNOXhKVXhCV2hnU0lHRTlrRE1WUlR2TUpQ?=
 =?utf-8?B?MDZBRUZPTjlacVdkM3hQdjZVSUFDYVdHVmhZVWlkL1R6T0x2cmxadUo2ekMw?=
 =?utf-8?B?VjU1aWRqUHcyT3dRMXllY3V5RlpmVWlTN3JLK0U1OHl6eUEzd2JBaDV2NDI2?=
 =?utf-8?B?eFl6WjVMMjkyaXdMaVJoWU5WVWxqTEkvU3RoMmJhYjVCcElGd0E1L0pmU29n?=
 =?utf-8?B?ZnMvdTlpZlFkQUdxQUtscm0xR012ZlRFQnlRT2N4ZDVUWlVJWUlaVmw1SFpl?=
 =?utf-8?B?Uk4vYjBVU2pjMGs2TzhZUjBqQlBPNTR5cTJFLzByR0NLT2kxeGZjUktXTEJs?=
 =?utf-8?B?NzJjMVVualBPellvV0cvTm1TMlJON3BBeUdld1RQZmI4cUJZZGZieW9LMkM3?=
 =?utf-8?B?b1huNm5wR3RGZk0yN05YQytwakFGR2YvcGE5ay91VGNJbFJUcEJKZnYzQnM4?=
 =?utf-8?B?TjY1L1VPTXQ0VGw3cDQxVXlPUVgzZ01vcXdYcU9IU3U1L2c0UjlKU1lkMkow?=
 =?utf-8?Q?xx849KpaChwlByqGWJSuIvEZypOBo9Tvh6iSBCq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A248EF68DE58C498DAD4CBFECC8705A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662cbc50-472d-494b-15d4-08d8f46dc2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 17:52:32.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z6PhVTBVsBEQKRb5WjGupa4n+sOImbyU4sp9xps31hwYu0H2uMwU71TgBweZq2xqnRtc3qMPmB17/0yxUvB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3302
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTMxIGF0IDEzOjIyIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
VGhpcyB0cmFjZXBvaW50IGNhbiBjcmFzaCB3aGVuIGRlcmVmZXJlbmNpbmcgc25kX3Rhc2sgYmVj
YXVzZQ0KPiB3aGVuIHNvbWUgdHJhbnNwb3J0cyBjb25uZWN0LCB0aGV5IHB1dCBhIGNvb2tpZSBp
biB0aGF0IGZpZWxkDQo+IGluc3RlYWQgb2YgYSBwb2ludGVyIHRvIGFuIHJwY190YXNrLg0KPiAN
Cj4gQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4NCj4gdHJhY2VfZXZlbnRfcmF3X2V2ZW50
X3hwcnRfd3JpdGVsb2NrX2V2ZW50KzB4MTQxLzB4MThlIFtzdW5ycGNdDQo+IFJlYWQgb2Ygc2l6
ZSAyIGF0IGFkZHIgZmZmZjg4ODFhODNiZDNhMCBieSB0YXNrIGdpdC8zMzE4NzINCj4gDQo+IENQ
VTogMTEgUElEOiAzMzE4NzIgQ29tbTogZ2l0IFRhaW50ZWQ6IEcgU8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA1LjEyLjAtcmMyLQ0KPiAwMDAwNy1nM2FiNmU1ODVhN2Y5ICMxNDUzDQo+
IEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8gU1lTLTYwMjhSLVQvWDEwRFJpLCBCSU9TIDEuMWEg
MTAvMTYvMjAxNQ0KPiBDYWxsIFRyYWNlOg0KPiDCoGR1bXBfc3RhY2srMHg5Yy8weGNmDQo+IMKg
cHJpbnRfYWRkcmVzc19kZXNjcmlwdGlvbi5jb25zdHByb3AuMCsweDE4LzB4MjM5DQo+IMKga2Fz
YW5fcmVwb3J0KzB4MTc0LzB4MWIwDQo+IMKgdHJhY2VfZXZlbnRfcmF3X2V2ZW50X3hwcnRfd3Jp
dGVsb2NrX2V2ZW50KzB4MTQxLzB4MThlIFtzdW5ycGNdDQo+IMKgeHBydF9wcmVwYXJlX3RyYW5z
bWl0KzB4OGUvMHhjMSBbc3VucnBjXQ0KPiDCoGNhbGxfdHJhbnNtaXQrMHg0ZC8weGM2IFtzdW5y
cGNdDQo+IA0KPiBGaXhlczogOWNlMDdhZTVlYjFkICgiU1VOUlBDOiBSZXBsYWNlIGRwcmludGso
KSBjYWxsIHNpdGUgaW4NCj4geHBydF9wcmVwYXJlX3RyYW5zbWl0IikNCj4gU2lnbmVkLW9mZi1i
eTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiDCoGluY2x1
ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oIHzCoMKgIDM1DQo+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+IMKgbmV0L3N1bnJwYy94cHJ0LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqDCoCAyICstDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZlbnRz
L3N1bnJwYy5oDQo+IGIvaW5jbHVkZS90cmFjZS9ldmVudHMvc3VucnBjLmgNCj4gaW5kZXggMDM2
ZWIxZjVjMTMzLi42OTA5ODg1MzBkNjAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZl
bnRzL3N1bnJwYy5oDQo+ICsrKyBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3N1bnJwYy5oDQo+IEBA
IC0xMTQxLDcgKzExNDEsNDAgQEAgREVDTEFSRV9FVkVOVF9DTEFTUyh4cHJ0X3dyaXRlbG9ja19l
dmVudCwNCj4gwqANCj4gwqBERUZJTkVfV1JJVEVMT0NLX0VWRU5UKHJlc2VydmVfeHBydCk7DQo+
IMKgREVGSU5FX1dSSVRFTE9DS19FVkVOVChyZWxlYXNlX3hwcnQpOw0KPiAtREVGSU5FX1dSSVRF
TE9DS19FVkVOVCh0cmFuc21pdF9xdWV1ZWQpOw0KPiArDQo+ICtUUkFDRV9FVkVOVCh4cHJ0X3Ry
YW5zbWl0X3F1ZXVlZCwNCj4gK8KgwqDCoMKgwqDCoMKgVFBfUFJPVE8oDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2sNCj4gK8KgwqDC
oMKgwqDCoMKgKSwNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBUUF9BUkdTKHRhc2spLA0KPiArDQo+
ICvCoMKgwqDCoMKgwqDCoFRQX1NUUlVDVF9fZW50cnkoDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBfX2ZpZWxkKHVuc2lnbmVkIGludCwgdGFza19pZCkNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoF9fZmllbGQodW5zaWduZWQgaW50LCBjbGllbnRfaWQpDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZpZWxkKHVuc2lnbmVkIGxvbmcsIHJ1bnN0
YXRlKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19maWVsZCh1MzIsIHhpZCkN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZmllbGQoaW50LCBzdGF0dXMpDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2ZpZWxkKHVuc2lnbmVkIHNob3J0LCBm
bGFncykNCj4gK8KgwqDCoMKgwqDCoMKgKSwNCj4gKw0KPiArwqDCoMKgwqDCoMKgwqBUUF9mYXN0
X2Fzc2lnbigNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZW50cnktPnRhc2tf
aWQgPSB0YXNrLT50a19waWQ7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2Vu
dHJ5LT5jbGllbnRfaWQgPQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHRhc2stPnRrX2NsaWVudCA/IHRhc2stPnRrX2NsaWVudC0+Y2xfY2xpZCA6DQo+
IC0xOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19lbnRyeS0+cnVuc3RhdGUg
PSB0YXNrLT50a19ydW5zdGF0ZTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9f
ZW50cnktPnhpZCA9IGJlMzJfdG9fY3B1KHRhc2stPnRrX3Jxc3RwLT5ycV94aWQpOw0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19lbnRyeS0+c3RhdHVzID0gdGFzay0+dGtfc3Rh
dHVzOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19lbnRyeS0+ZmxhZ3MgPSB0
YXNrLT50a19mbGFnczsNCj4gK8KgwqDCoMKgwqDCoMKgKSwNCj4gKw0KPiArwqDCoMKgwqDCoMKg
wqBUUF9wcmludGsoInRhc2s6JXVAJXUgeGlkPTB4JTA4eCBmbGFncz0lcyBydW5zdGF0ZT0lcw0K
PiBzdGF0dXM9JWQiLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgX19lbnRyeS0+
dGFza19pZCwgX19lbnRyeS0+Y2xpZW50X2lkLCBfX2VudHJ5LT54aWQsDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBycGNfc2hvd190YXNrX2ZsYWdzKF9fZW50cnktPmZsYWdzKSwN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJwY19zaG93X3J1bnN0YXRlKF9fZW50
cnktPnJ1bnN0YXRlKSwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoF9fZW50cnkt
PnN0YXR1cw0KPiArwqDCoMKgwqDCoMKgwqApDQo+ICspOw0KPiDCoA0KPiDCoERFQ0xBUkVfRVZF
TlRfQ0xBU1MoeHBydF9jb25nX2V2ZW50LA0KPiDCoMKgwqDCoMKgwqDCoMKgVFBfUFJPVE8oDQo+
IGRpZmYgLS1naXQgYS9uZXQvc3VucnBjL3hwcnQuYyBiL25ldC9zdW5ycGMveHBydC5jDQo+IGlu
ZGV4IGQ2MTZiOTM3NTFkOC4uYjY5NGFmNDUwNGM0IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBj
L3hwcnQuYw0KPiArKysgYi9uZXQvc3VucnBjL3hwcnQuYw0KPiBAQCAtMTQ2OSw3ICsxNDY5LDcg
QEAgYm9vbCB4cHJ0X3ByZXBhcmVfdHJhbnNtaXQoc3RydWN0IHJwY190YXNrDQo+ICp0YXNrKQ0K
PiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJwY194cHJ0wqAqeHBydCA9IHJlcS0+cnFfeHBydDsN
Cj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGlmICgheHBydF9sb2NrX3dyaXRlKHhwcnQsIHRhc2sp
KSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0cmFjZV94cHJ0X3RyYW5zbWl0
X3F1ZXVlZCh4cHJ0LCB0YXNrKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRy
YWNlX3hwcnRfdHJhbnNtaXRfcXVldWVkKHRhc2spOw0KDQpXaHkgZG8gd2UgbmVlZCB0aGlzIHRy
YWNlcG9pbnQ/IFRoZSBldmVudCB3ZSdyZSBsb2dnaW5nIGlzIGp1c3QNCiJncmFiYmluZyB0aGUg
dHJhbnNwb3J0IHdyaXRlIGxvY2sgZmFpbGVkIGR1ZSB0byBleHRlcm5hbA0KY2lyY3Vtc3RhbmNl
cyIuDQrCoA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFJhY2UgYnJlYWtl
cjogc29tZW9uZSBtYXkgaGF2ZSB0cmFuc21pdHRlZCB1cyAqLw0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmICghdGVzdF9iaXQoUlBDX1RBU0tfTkVFRF9YTUlULCAmdGFzay0N
Cj4gPnRrX3J1bnN0YXRlKSkNCj4gDQo+IA0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==
