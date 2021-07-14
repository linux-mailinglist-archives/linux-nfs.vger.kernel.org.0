Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE13C8839
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jul 2021 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhGNQCL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jul 2021 12:02:11 -0400
Received: from mail-mw2nam08on2123.outbound.protection.outlook.com ([40.107.101.123]:29473
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232409AbhGNQCL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Jul 2021 12:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf+JkJ8xVpfAdWxDBt644muKyTthrjPjkpc6WYq3KtyBCeaKYTghC2Fvg9gLijLevkHGS7eWMWnIlC6p3pI6unNpjIx5gooUuHl4Y1aIf7pkpz0RXVdsjV86rzFjUJUcBXjY6KMWO+CMJjwoO1VqJEwePDyFiAtjz18LVTu9MQ1H7SSzSvPy74R++StmqsIOXJANEVvRYZjey8a0TD6+fZWqB6CEX+ZCt+WNUi5LaS4mvz+PDUwBhRQtecq67y3FhUPCGHhMm51/DeHcYvzMLRxwy4zAcnq0g8PE//pVsWngtFbKYRcF89+wmx3NveM+oQD9A+5EsPyyrkZavbi+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFnwAcbfUyna38MB1sIzj7r6qfuRBls3guk2B88x0XE=;
 b=bePUkkP5JvIdjYN7rlI1zlwdDBhmrcdOnkLaTtgw/T0D54oQohNgTWoewqAa4hjVRK0b2zteDG5HKVh/WSd94zQ4VaBtsmWVNxBcZ4KoLobKGareAj/7Pdh+eZ2HKf6gViaATkAsYiQ7piVMUX6g6hhdWAkOgTdhknAmbPWO+3F4Zbp4G+1ogI9NK5yJuO1MoMidjSO6auvGvwNz1YMSoq6NfM4jSAfCp+fKvy+KL2uqEtKKi4roGe9w9T7BxrywKoiALaysYNloAy7SMX85IoNilsuY9ZfwX2XhFduxcaTsWRwOlKXHusR1vImV5f0wNmLr8Zj8pa5AyuqH60XyYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFnwAcbfUyna38MB1sIzj7r6qfuRBls3guk2B88x0XE=;
 b=bsXHGAlRY0V89REH8/YP3S88sXlkMJCXBG0ODQwMpxN6wmNcqcw6p80K1Zg2A9uSJw27X8BeM+eQj7/149oqlaDI0mvpG34zcuPBgmh1Jc65Z7awBfUMX/ltt9AeNuzj5bU+ZcceLcSfQQfLjnKJJyiAGzBg4LI00klZ+EgEMsc=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3848.namprd13.prod.outlook.com (2603:10b6:610:9d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.12; Wed, 14 Jul
 2021 15:59:17 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f427:dd84:789e:6c57%4]) with mapi id 15.20.4352.009; Wed, 14 Jul 2021
 15:59:17 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC 2/4] NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for
 session/clientid destruction
Thread-Topic: [PATCH RFC 2/4] NFS: Unset RPC_TASK_NO_RETRANS_TIMEOUT for
 session/clientid destruction
Thread-Index: AQHXeMf5cUp6E062nkSZEZtey6WpNqtCoNIA
Date:   Wed, 14 Jul 2021 15:59:16 +0000
Message-ID: <f0081f402653adf5113febf9b8c5aad04b7f1f61.camel@hammerspace.com>
References: <162627611661.1294.9189768423517916152.stgit@manet.1015granger.net>
         <162627782362.1294.9395366920293772038.stgit@manet.1015granger.net>
In-Reply-To: <162627782362.1294.9395366920293772038.stgit@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0712e4ac-65ed-4cc2-93e6-08d946e0558a
x-ms-traffictypediagnostic: CH2PR13MB3848:
x-microsoft-antispam-prvs: <CH2PR13MB38489AC9E8313EBD73EEF41EB8139@CH2PR13MB3848.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LyYUnb84haICt1zAkOQEimNe27PO6C7JYuxEJ2WOD3KWgLWEsDn2EEOzfatgx17HUWmG9VQcHspSl8cxGxJNL1q322h1Fz4qWyNEmRzPM9HQsYPw9xFOHFqf+/JYPLT3s7HV5SmN4v5UGy9rcxV/De3Xsb22JWcV3c9A+AFnZM2mndhiAYzo1NZeju/JSNrOl5gszRtygYmgDdbz8Rj5hJuui4tXDQLUPR917LJh5S9yZXZntHB9rMNDn9+fLfieAlKzy03UTUo9XKykV1v9NmyjEOrRT81crFnw3o0+w0ukpT/N1v+ETmthGmriMphFAciVmoYnfMzxfMFc9JoaxB1e02THgS21d5ZqRLHdin6hBL8M+j+HJH1aAGCNQX1X8cAb1CuL6obePV35PNg+0kKDaosy7U3sNi96mVro2XaEFXmBDgATdgAGxlQ76CUVLnOL4ePlwkYUbsTfLz/HpRj3EYuG7xNl5Oxuhyht1SvC6BjGm7SAKxl+Md5SCXP8JxR0jG+YuvDylz2u9Qi7na3pybmEgSYr7SqwfIGFtxJf4PNuf3h9Qa93z5aNtnHh/nuhWI5/Ch9a59Me0tZpaXaKTUdxgcxhn2WDMHL5/M5xVv5cVyOddUmtqZ7ssznRPhCBYHobSningojoMQuyYa90I0HX8YkIYmBBNX5OOWnY3z5DjsX7XCm6FmSvS+i7fCoTJK4bnI5wsVsE1upnJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39830400003)(396003)(66946007)(64756008)(66556008)(71200400001)(66476007)(478600001)(36756003)(38100700002)(316002)(8676002)(66446008)(26005)(76116006)(110136005)(186003)(6486002)(2616005)(8936002)(5660300002)(122000001)(6512007)(86362001)(6506007)(2906002)(83380400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlYZFFMRkRmdWN5aUtwaFJvT3crTEhCZ1duVVBRTkFJZGt3VVR1TFBCeTho?=
 =?utf-8?B?NUdHdlpkVjkzY1RmV0tBbmdoUGFNbCt4QkJPbVkwQk14Qzd2WDE1NHpVU2RJ?=
 =?utf-8?B?aXFSbnlib3pLNHlWcHFpN1M1RHJURTZQQjgvb2JsWUVUN2hIQ1hGREMyaklG?=
 =?utf-8?B?c2M2MmdOYUY4WDNrZHJkSkpxbCtuOGZFdU1rSVhFL3phemd0alcxc2M4OStR?=
 =?utf-8?B?Um9CUXovSkkxekNFQ3J2ZFJkVC9iVkdkRWhDNFB0UHhKRFB2Z1ZvWUE1azl4?=
 =?utf-8?B?bXhRc3JBMGozamNLNlVON1BzY3p0R3BUWXlzcElhVnRMV2tZSGxhbU1BeDdo?=
 =?utf-8?B?OUsydUZRSU9IN282VlU2UGM3c3dXbDhzZVpLa3U1SFArQjNneDdPMnNPcDVH?=
 =?utf-8?B?Yy9YdTBjV2RONXFyRXpKR2VlSEVMM2MwVktUSDFSWjhoSU5jSDA4NDA4MWlM?=
 =?utf-8?B?a3pnVGRVVi9UdXl4emRrR1lNbFhEUzZtM0RlaVluY1hOWkV4TXRuS2Z2WmVH?=
 =?utf-8?B?dUlIaXEzVlBoRkRyU1NrMkNicU9mMElhRytMaks5K0ZSWkhtSzlsd2ZsUjFX?=
 =?utf-8?B?NGthYXRqT1RXRVFRQzdmbEZ0ZEppb0NFR1Z1RW5RV1ZkSUJaZVJHZUpGOGRu?=
 =?utf-8?B?SHk4MGdVK0l4Z2h2T3hqeDlaNzlUMi9NUnJWcm9pUUFLa2lmcGM2NnF4Q09K?=
 =?utf-8?B?YkJhbEhVK1QvSXdWZU8xMHpHcmRuN0FTUkN5TDczN2xMa3pCUmY1K0lCTDJW?=
 =?utf-8?B?VDB1R1VSSXVrbDAyeC9COXpHdm1qUXJKNlc0c1dVTnVoWHRBa2ZmZ0UzVHM5?=
 =?utf-8?B?YzY5K0U2eGtJckpTK2xpL2RXQ1B6cVR3eXA0ay9TWXJFdjViQjM4OGJJZ3pY?=
 =?utf-8?B?Wi96emlKQ05qSXU0WnZkY2JhdUhvUm4zaDJUeldPMEM4TEVKVml2ekQvcCtD?=
 =?utf-8?B?S00xcXpiZzNncGpzbUQ0SmtpN3UwbE5acGg5STdVNG1yRXZvVTJ5a2YzeWpv?=
 =?utf-8?B?Nm1zSUJnUWNQRDNjYi84aHZtNC96VVFWQ0Z1cFVKcFBkdUI0RFZ4SlNBZ2xR?=
 =?utf-8?B?bHBCMnZJclkwRTNlVmthdFBCc0pHQ1JPVjNJMzFkQzNXUjV6NHpacjQ2alI2?=
 =?utf-8?B?Sk1SdnZDQkJqTE9pWXBFa3lHZWNGNTFYN3l2ZGRiVjlRckJ0WFZvSjFyOTRy?=
 =?utf-8?B?RnBmaVlYc1g0dlNFUDVLTWJpNG56czlKcmFVb2xxOFNvQjBDVkxVanZGUGl6?=
 =?utf-8?B?bUZIajVnOFBwcFNtT0dPSU1wSXF3T0hkZm1YYlpML09uV3VWV04wNlFzamdW?=
 =?utf-8?B?THZSNGJoTUlhQ1BOcVZNd2l6SXJ3SDZZcEVlYXNKWHBpa09VUGhHUzhmOXJD?=
 =?utf-8?B?YmR4bGMrZmtlSFRGWExkb1MySVQ0bXpOaWRHTi9oYU9Hb1lBSWREREdTR05u?=
 =?utf-8?B?Y3BRRWtydE9NQUtqWU83NTJyZklDWk9Fd29QckNOUkpzbW9VaHFTaFNNMHVF?=
 =?utf-8?B?TTYvTElSK2VhTy8zU0NsS214SEVyN1hsZWRGUHNWK1BZSnorQkdpY3JURjdZ?=
 =?utf-8?B?WGJWL1pyeVpmVVBXSC82TlNaTk5NNjBLWU1GYXVsNzEwSmw5cGNDOTVKYzZj?=
 =?utf-8?B?OHVLOGdoYmx0REZjRlB1OVRINmQxaWVsRG9DcitkOXJKM21CTTFZb05OWjhT?=
 =?utf-8?B?VFJzSi9ZYmxPVDlsclBqazF3cWVYcmdCcXpPYUJhYmo5QVVtSFJuaDNhYVRR?=
 =?utf-8?Q?Js8j/Mw7OP+TboaqN6x3VoeOwG1+jv6VAiQYC80?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <10614CDFB8E7A14C820FD9F1BCD45D4A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0712e4ac-65ed-4cc2-93e6-08d946e0558a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 15:59:17.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qd/0RT8MVsbDoCcmj4m+tZxMAL772LqWIS42SvEuG4Q4l3NINB3Heh3BwkyiF57mgsBQDtWDUv7YnMT43f2TcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3848
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTE0IGF0IDExOjUwIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SW4gc29tZSByYXJlIGZhaWx1cmUgbW9kZXMsIHRoZSBzZXJ2ZXIgaXMgYWN0dWFsbHkgcmVhZGlu
ZyB0aGUNCj4gdHJhbnNwb3J0LCBidXQgdGhlbiBqdXN0IGRyb3BwaW5nIHRoZSByZXF1ZXN0cyBv
biB0aGUgZmxvb3IuDQo+IFRDUF9VU0VSX1RJTUVPVVQgY2Fubm90IGRldGVjdCB0aGF0IGNhc2Uu
DQo+IA0KPiBQcmV2ZW50IHN1Y2ggYSBzdHVjayBzZXJ2ZXIgZnJvbSBwaW5uaW5nIGNsaWVudCBy
ZXNvdXJjZXMNCj4gaW5kZWZpbml0ZWx5IGJ5IGVuc3VyaW5nIHRoYXQgc2Vzc2lvbiBhbmQgY2xp
ZW50IElEIGNsZWFuLXVwIGNhbg0KPiB0aW1lIG91dCBldmVuIGlmIHRoZSBjb25uZWN0aW9uIGlz
IHN0aWxsIG9wZXJhdGlvbmFsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNo
dWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiDCoGZzL25mcy9uZnM0Y2xpZW50LmMgfMKg
wqDCoCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9mcy9uZnMvbmZzNGNsaWVudC5jIGIvZnMvbmZzL25mczRjbGllbnQuYw0KPiBpbmRl
eCAyODQzMWFjZDEyMzAuLmM1MDMyZjc4NGFjMCAxMDA2NDQNCj4gLS0tIGEvZnMvbmZzL25mczRj
bGllbnQuYw0KPiArKysgYi9mcy9uZnMvbmZzNGNsaWVudC5jDQo+IEBAIC0yODEsNiArMjgxLDcg
QEAgc3RhdGljIHZvaWQgbmZzNF9kZXN0cm95X2NhbGxiYWNrKHN0cnVjdA0KPiBuZnNfY2xpZW50
ICpjbHApDQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgbmZzNF9zaHV0ZG93bl9jbGllbnQoc3RydWN0
IG5mc19jbGllbnQgKmNscCkNCj4gwqB7DQo+ICvCoMKgwqDCoMKgwqDCoGNscC0+Y2xfcnBjY2xp
ZW50LT5jbF9ub3JldHJhbnN0aW1lbyA9IDA7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoX190ZXN0
X2FuZF9jbGVhcl9iaXQoTkZTX0NTX1JFTkVXRCwgJmNscC0+Y2xfcmVzX3N0YXRlKSkNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZnM0X2tpbGxfcmVuZXdkKGNscCk7DQo+IMKg
wqDCoMKgwqDCoMKgwqBjbHAtPmNsX212b3BzLT5zaHV0ZG93bl9jbGllbnQoY2xwKTsNCj4gDQo+
IA0KDQpJIGNhbid0IHNlZSBob3cgdGhpcyB3aWxsIGhlbHAuIEFnYWluLCBJIHN1Z2dlc3Qgd2Ug
cmF0aGVyIHR1cm4gb2ZmIHRoZQ0KcmV0cmFuc21pc3Npb24gZGVmYXVsdCBmb3IgdGhlIFJQQyBj
YWxscyB3aGVyZSB0aGUgc2VydmVyIGNhbiBkcm9wDQpzdHVmZiBvbiB0aGUgZmxvb3IuIFRoYXQn
cyByZWFsbHkgb25seSB0aGUgUlBDU0VDX0dTUyBjb250cm9sDQptZXNzYWdlcy7CoA0KDQpBbnl0
aGluZyBlbHNlIGlzIGNvdmVyZWQgYnkgdGhlIE5GU3Y0IGJsYW5rZXQgYmFuIG9uIGRyb3BwaW5n
IFJQQw0KY2FsbHMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
