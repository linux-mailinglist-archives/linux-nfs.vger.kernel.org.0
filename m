Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B072CF5E0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 21:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgLDUxt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Dec 2020 15:53:49 -0500
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:13440
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbgLDUxs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 4 Dec 2020 15:53:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI62EP3bzgeepbWCq07hB4ETbgFNWjzP3I4k9cL+5o8j9Xpy6Sif5xFzdpKjKz7KI1j5LVc1cJ0DUrGpn9HGnUqPNvk2rQPlLIeNDvVH0aWYRSP8Ak2UJCOoUxuwgvTckprDb7XTy3y9f143QmDedSEFpuh8og6jYYIFZSsuIcu+nvR4Eo+HZzWSaDslxgDTknRHJ7dO+V8zUzxxGoBdVbDt4bzQtqr3Yw1LqUR+6fa0kTx1tyZSv50uRlr7PIjInLZTo1pd7PZXc+f07QrkJPc6ok3EhfmvbsX661z0GPv8llPaIuGwDKjSni/xmqdPcsdJckJHNQFdreVi6oN0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc3Xje0czN6gUa2qHlL+q18axMMgF0k4H68S8eWzroA=;
 b=UKNwxJwyRrGvBj2a/XeOua4Z+w4jtyjFMuPEHWIq0tsbS+cP7b1O7lzix6YTLTh4I3vOmtdhE59VvOd7w78Lz8w9sJH+7IMRMkQRaxTITuTOYKMoSZCvakCXZLj7uCLO6vscLnxTjD8LBb1IHIGi/6PNZaPlHk6Zx5GCWUz2C6gwm6Ryx18emO6zd4UXHcPOgH1V3ERhjinnTRtRsZ9tQLZZIK+DISDKqkz219SOXaxKf+SnbvkgcwZKBhsY0fla0438hQtHYaJKFIo20OLS+BdCBM2BBGtEAFnq5awDNg387x1PnjPd/fQRcrWkgVEAJUCZYGLVTQGX5Tiu7WC2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc3Xje0czN6gUa2qHlL+q18axMMgF0k4H68S8eWzroA=;
 b=HuxyRHixOFbU+dAgnJutPd7v9VcFE0xWZKrbXnMR5FEmRLXzs7Ine2ppRoQ1vQxBZqos7tvZz7nsyORgjnl8iT7f0hbr7RJnLHhNFvr27c0Rc3d59kRod3NrRE93YABpIijhRFkOFZgv1qMrkXtIJyByrzHjWGAw6TVv6Z4Y9xs=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3231.namprd13.prod.outlook.com (2603:10b6:208:135::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Fri, 4 Dec
 2020 20:52:55 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3654.009; Fri, 4 Dec 2020
 20:52:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dan@kernelim.com" <dan@kernelim.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] sunrpc: fix xs_read_xdr_buf for partial pages receive
Thread-Topic: [PATCH] sunrpc: fix xs_read_xdr_buf for partial pages receive
Thread-Index: AQHWymwYmrmKbI/UwECKVXQvJqiCDqnnagaA
Date:   Fri, 4 Dec 2020 20:52:55 +0000
Message-ID: <528fd4a869f0757e0a60e9c733d4625067693588.camel@hammerspace.com>
References: <20201204183419.1532347-1-dan@kernelim.com>
In-Reply-To: <20201204183419.1532347-1-dan@kernelim.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernelim.com; dkim=none (message not signed)
 header.d=none;kernelim.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a79b1117-9b2f-48c3-777b-08d898969320
x-ms-traffictypediagnostic: MN2PR13MB3231:
x-microsoft-antispam-prvs: <MN2PR13MB3231BE325E31D755300B6329B8F10@MN2PR13MB3231.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xCfTzqrgvhrzpih88Row0pQbMbg61cr7OzWc9AcJeac1YExhmOceE1Ae4usFmZPtD48gVAY/oBZEXd1qS4bh/0OoxOxZIY6cahY0lmMuea3X4jJ3GPKXvfVrz8PSOf3XYswSkia4WPkpU3u05WXK/ON4Mnhkkvf1OEYDa36wb0D0D1QPL4SnwxShxdC4z+HzWbESO57tVouQsP9LeVb2HyE0GfXmDjlluVTBc2xq2H/dBx4+aLsHIVQsf2TMg5pDRJjMqr4QRZseyT/vxt6DgkUyku0vuoBBXjfnGLaHam99OVj4yYKN4RRkkdsZsKVxl2jEnMi6C03T56lii7jPGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39840400004)(346002)(136003)(36756003)(6512007)(110136005)(6506007)(26005)(2906002)(186003)(8676002)(86362001)(5660300002)(316002)(66476007)(71200400001)(8936002)(66446008)(64756008)(6486002)(91956017)(2616005)(66556008)(76116006)(83380400001)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZUtsTXlaV3p3djNZakpPWlVDZWpSZ045OHRmSHpDdmlJOEs1MWNNQUx6NCtZ?=
 =?utf-8?B?R0J1TkloenFqeHJ6dWNXZEMrRm1DeWl3VGtxSm5xcHMzMzNjeWxlbjk4QVVh?=
 =?utf-8?B?R2lXTHNzaDIyaklQWksyWmkxdWZGZXlYc1VuVzduQ0JLRHRqdFBCenZ6TFEw?=
 =?utf-8?B?MzVtTVJENTNRMkhucitzNzR3SU16T0prQVhWMFBTSkVGY3BqRmVibFY4WThP?=
 =?utf-8?B?WFcwQ1gyK25IY0RtY011WXZvd2NnZXNHVG1SaldTdHNvRjhCVFg1Nk03VXor?=
 =?utf-8?B?R1FpR2Y2d1FoOUNObHNZSFU3U1lwMU1EZTlBWUJOMCtNZGJBZEovWHAyU0dO?=
 =?utf-8?B?dzRkVmdCbjdOZWVlREJFMWJVNVpZVGUrVFNHczhUWWxlRVZtNmdoL0N6Nkxi?=
 =?utf-8?B?eVdvd0QwUU03YS9UTElhdDdwMlZlOUtFVTJVZllKdGRObThWSlpuelNmcGV3?=
 =?utf-8?B?aGVGMDhvOFlSa1FkcnNjWkErQnJWOVVJVEtnd0xCbm9qQWd0RENHM0s5RVpH?=
 =?utf-8?B?MWs5bko1anJnY0czeFFMNGFldVFiMnpiRWZ5bFowNElIQ2NWczRsZkpyenov?=
 =?utf-8?B?SmM3NEF3c3lYK1p0MUxsZXB3OU93c205QlBSNVM0MmNvaENpY015L3g3aisx?=
 =?utf-8?B?RUNuYWRHUnoyNHg3Mmx2ekI0UTM3eTdPY05XMmJZeVRqS2RjY2piSElqVGR2?=
 =?utf-8?B?MW0vdWFtd2VTZDlad2YwdmJEdWF4MmhPSTNpQml0MmY3UFBjV0lWOE1EeVhG?=
 =?utf-8?B?ZStwU0Rld2tZUWVWdjk0eDZSS3htZzdzQmdraWhadXB5ekdjWU9XUk1sOGh1?=
 =?utf-8?B?a201ZWoyNUtEZjN2WHZ1T2tHVElGdEt1em0ydGs4VVFNYm44MXo4eEl5V3Jm?=
 =?utf-8?B?M1FHcW5yay9GVkdSNFJ6Y1NaelhRS0JoOStRTWdRY0wySHpTREdMNFJRWnl2?=
 =?utf-8?B?QWxzeDhnOEp5Nmh1VUdpMmdrNUhqcEVTTlFRMHJmVXVxTFVvQzN2aDVEZVhO?=
 =?utf-8?B?M0owTW50SU4wb3dlR3NPMlhUcFhkUUJMb1RSOUQzYm5zZUgyWGtHOWRQdit4?=
 =?utf-8?B?SS8vYUtDdUtoUTZkNVdwc1dYVG9JQ21Ob0M0UHYvMkRrcXU4aWY1NTdjUlRI?=
 =?utf-8?B?NmZydUdIaVJFUjl6UVRtTnlXYXFJQzVRRWtESjc5UXI5ZmlHQmhzZjF4cXNC?=
 =?utf-8?B?K3k4blg2dXdWaDFJZVl5T210d2hCeURBcW95VkN2R3hBTitaR3kyUFFVOE1O?=
 =?utf-8?B?OFhlSUc4bnZGQ1lseVBjTWRETk1ucnBkSDRGczdQZkR6ZXdpV2hzNlZZMHJ1?=
 =?utf-8?Q?tNuqqjqP++UITsVhR/xu9neV4Lz3JJh1kH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBA1177B5EA1534CA49E45B1EBE50202@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79b1117-9b2f-48c3-777b-08d898969320
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 20:52:55.1888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mJrDDIOUTIDNr0CEBny11tBIo75JpcEC/QJ4zswOnKlGjfTqzGoaygxK4BJdPnM8xaSOacr2hAaJx33cuDPlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3231
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDIwOjM0ICswMjAwLCBEYW4gQWxvbmkgd3JvdGU6DQo+IFdo
ZW4gcmVjZWl2aW5nIHBhZ2VzIGRhdGEsIHJldHVybiB2YWx1ZSAncmV0JyB3aGVuIHBvc2l0aXZl
IGluY2x1ZGVzDQo+IGBidWYtPnBhZ2VfYmFzZWAsIHNvIHdlIHNob3VsZCBzdWJ0cmFjdCBpdCBz
aW1pbGFybHkgdG8gaG93IGl0IGlzDQo+IGRvbmUNCj4gZm9yIGBvZmZzZXRgLg0KPiANCj4gVGhp
cyB3YXMgZGlzY292ZXJlZCBvbiB0aGUgdmVyeSByYXJlIGNhc2VzIHdoZXJlIHRoZSBzZXJ2ZXIg
cmV0dXJuZWQNCj4gYQ0KPiBjaHVuayBvZiBieXRlcyB0aGF0IHdoZW4gYWRkZWQgdG8gdGhlIGFs
cmVhZHkgcmVjZWl2ZWQgYW1vdW50IG9mDQo+IGJ5dGVzDQo+IGZvciB0aGUgcGFnZXMgaGFwcGVu
ZWQgdG8gbWF0Y2ggdGhlIGN1cnJlbnQgYHJlY3YubGVuYCwgZm9yIGV4YW1wbGUNCj4gb24gdGhp
cyBjYXNlOg0KPiANCj4gwqDCoMKgwqAgYnVmLT5wYWdlX2Jhc2UgOiAyNTgzNTYNCj4gwqDCoMKg
wqAgYWN0dWFsbHkgcmVjZWl2ZWQgZnJvbSBzb2NrZXQ6IDE3NDANCj4gwqDCoMKgwqAgcmV0IDog
MjYwMDk2DQo+IMKgwqDCoMKgIHdhbnQgOiAyNjAwOTYNCj4gDQo+IEluIHRoaXMgY2FzZSBuZWl0
aGVyIG9mIHRoZSB0d28gJ2lmIC4uLiBnb3RvIG91dCcgdHJpZ2dlciwgYW5kIHdlDQo+IGNvbnRp
bnVlIHRvIHRhaWwgcGFyc2luZy4NCj4gDQo+IFdvcnRoIHRvIG1lbnRpb24gdGhhdCB0aGUgZW5z
dWluZyBFTVNHU0laRSBmcm9tIHRoZSBjb250aW51ZWQNCj4gZXhlY3V0aW9uIG9mDQo+IGB4c19y
ZWFkX3hkcl9idWZgIG1heSBiZSBvYnNlcnZlZCBieSBhbiBhcHBsaWNhdGlvbiBkdWUgdG8gNA0K
PiBzdXBlcmZsdW91cw0KPiBieXRlcyBiZWluZyBhZGRlZCB0byB0aGUgcGFnZXMgZGF0YS4NCj4g
DQo+IEZpeGVzOiAyNzdlNGFiN2Q1MyAoIlNVTlJQQzogU2ltcGxpZnkgVENQIHJlY2VpdmUgY29k
ZSBieSBzd2l0Y2hpbmcNCj4gdG8NCj4gdXNpbmcgaXRlcmF0b3JzIikNCj4gU2lnbmVkLW9mZi1i
eTogRGFuIEFsb25pIDxkYW5Aa2VybmVsaW0uY29tPg0KPiAtLS0NCj4gwqBuZXQvc3VucnBjL3hw
cnRzb2NrLmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94cHJ0c29jay5jIGIvbmV0
L3N1bnJwYy94cHJ0c29jay5jDQo+IGluZGV4IDcwOTBiYmVlMGVjNS4uNDJiNjgwYTYwZDM4IDEw
MDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hwcnRzb2NrLmMNCj4gKysrIGIvbmV0L3N1bnJwYy94
cHJ0c29jay5jDQo+IEBAIC00MzYsNyArNDM2LDcgQEAgeHNfcmVhZF94ZHJfYnVmKHN0cnVjdCBz
b2NrZXQgKnNvY2ssIHN0cnVjdA0KPiBtc2doZHIgKm1zZywgaW50IGZsYWdzLA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG9mZnNldCArPSByZXQgLSBidWYtPnBhZ2VfYmFzZTsN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAob2Zmc2V0ID09IGNvdW50IHx8
IG1zZy0+bXNnX2ZsYWdzICYNCj4gKE1TR19FT1J8TVNHX1RSVU5DKSkNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7DQo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0ICE9IHdhbnQpDQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0IC0gYnVmLT5wYWdlX2Jhc2UgIT0gd2FudCkNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXQ7DQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2VlayA9IDA7DQo+IMKgwqDCoMKgwqDC
oMKgwqB9IGVsc2Ugew0KDQpPdWNoLi4uIFdlbGwgc3BvdHRlZCENCg0KSG1tLi4uIEkgdGhpbmsg
d2Ugd2FudCB0byBqdXN0IHN1YnRyYWN0IG91dCB0aGUgYnVmLT5wYWdlX2Jhc2UgZnJvbSB0aGUN
CnZhbHVlIG9mICdyZXQnIGFmdGVyIHdlIGNhbGwgeHNfZmx1c2hfYnZlYygpIGFuZCB0aGVuIGFk
anVzdCB0aGUNCmNhbGN1bGF0aW9uIG9mICdvZmZzZXQnIGluIHRoZSBuZXh0IGxpbmUuIFRoYXQn
cyBtb3JlIGVmZmljaWVudC4NCg0KQ2FuIHlvdSBwbGVhc2UgcmVzZW5kIHdpdGggdGhhdCBjaGFu
Z2U/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIs
IEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
