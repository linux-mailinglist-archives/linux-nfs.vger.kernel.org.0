Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2282A30834F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jan 2021 02:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhA2BiI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 20:38:08 -0500
Received: from mail-dm6nam12on2095.outbound.protection.outlook.com ([40.107.243.95]:35393
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231237AbhA2BiE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 Jan 2021 20:38:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrTa+0pew37V6w40mnSSxswe4urhN4/4EmQp5xHYcm7/PK8pcntDvXg9eAmVuCyxO/+cps9LNEfOY+4xGXbZ7w4gu/sKayWTcTbh2DuZ5AwUktRuYLFdcq0lQz7pmYmPfs5bgtcbsBf0IU9jepRKoVqc69d8LywDrfqeH95rcLSOwa6IoovrDjywpZnF/HhtimVFG+MM2tXVIWhtEDcdR2wVR5b8KBK41DvEk6GSRLtk+YwzonLeVft6loQESliUBcELVHWsjq8zuqHsAInOeho3Xmw/o6fU5jcM9ebXBrRKi1KdzP2+SAzRyQGdNegwyB3ymHrgDbtU1HlD0DqbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+gzVHAiTuJv8PVCesvb7KUuDQUw7oa8BZAZOqWGkss=;
 b=GGVZz9WDmEWOsbob5Oi8zrsJSS6oBuXeTF/g1601w2HTh9tkb4WAMjUKRgd7cSE3NdI40loR9askeUIZxydT4XFU3JbOFV52L8bzyhAH2FA8MtptBAKf9bkAi69co4sE9yTIEl8JZMRL/uxswDRyiMtHz3+Mea5p9uVv1T/GblhcOodWxHVq+7XUDOE4goiws1crsLwda4FUAlxeMUghTKb4BTYEMps9dqE8R95jVIYtk69MDFuhcLWVOPJi0B5oMi8z5olxhGP43AXon1CNL7P0Doxrj502tcItZAob5yvQq8nGu0K8fjaAvEEa0Af6Lv+Opn/LgAOM5SYqB/sYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+gzVHAiTuJv8PVCesvb7KUuDQUw7oa8BZAZOqWGkss=;
 b=PmdXCvzEiuqYvimOai9IrCZphzVpVTpsMUx68lMZaeINcfNJgNbAxLiabaGfH40EaQ3gu8q1z3p99BoHuszd5D4wK6Ztz+yZOD56Tpg6swBM3qkUH2F89bvIJaCLw5qDPzBtiGPzDPy/UtMPWbRxXHb/QBTcYy4oLe6QC0RrtmI=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB4473.namprd13.prod.outlook.com (2603:10b6:610:6b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Fri, 29 Jan 2021 01:37:11 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3825.008; Fri, 29 Jan 2021
 01:37:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "guy@vastdata.com" <guy@vastdata.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "schumakeranna@gmail.com" <schumakeranna@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs: we don't support removing system.nfs4_acl
Thread-Topic: [PATCH] nfs: we don't support removing system.nfs4_acl
Thread-Index: AQHW9cYMuXIITkQqQEuvjSotXZGpBqo9sNIAgAAiJoA=
Date:   Fri, 29 Jan 2021 01:37:10 +0000
Message-ID: <cbc7115cc5d5aeb7ffb9e9b3880e453bf54ecbdb.camel@hammerspace.com>
References: <20210128223638.GE29887@fieldses.org>
         <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
In-Reply-To: <95e5f9e4-76d4-08c4-ece3-35a10c06073b@vastdata.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vastdata.com; dkim=none (message not signed)
 header.d=none;vastdata.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bc3a0d7-6a47-4f3b-c730-08d8c3f665e3
x-ms-traffictypediagnostic: CH2PR13MB4473:
x-microsoft-antispam-prvs: <CH2PR13MB44733DDC931C80B0E9C26D1FB8B99@CH2PR13MB4473.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTAgFoOofh1ClSqMIX1OlOKyf9Hdmr4vaX5bn/Fhgwq8+m15eaR5aE3fTZ04/WsNqA/pmY337fnwe0Mrw8POY28/VT/Xw0ZNUe9pmoBlhDpeMvfuif7nQHr1+3UmQLE4bJwPk7mc71kkCXbf6ji1lhPl9KWXx1HyNYSROu2PfAdNfHeNPfMsyeQc0ZeLtDBTL5bFkjdSwQ7N2T/KBG8mER0d+REanaq2Przeq5eDYUWZ7p5xH580dyQYdGUADeEZHB/c83TLnD7D/do6Q2Ldn0we1aamhj8Q5ksjem8ZoAa13yHg6tUU+3nPynlk5QH0HE2N3oS1J/emzRx4V9nBpKulxP0zfjTUJXc56qI1urWHhF4Phs3VN2Pj+t7K3SjRzAPn5nIgBml8pEi22lhHfhkCTkb4Zvz23+H2203BtBeek8RfoN+BHaDv32Ov/EC39CAqAfNUFVkRiCqT+9mMNIz2wOtkfS/RITx8Qduqv1FWQipSSrPcHwLhW1LUsuRUW1qv1vXeSMejYnASTs5w8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39840400004)(396003)(136003)(66556008)(64756008)(26005)(66476007)(2616005)(66946007)(8676002)(5660300002)(316002)(6506007)(76116006)(36756003)(186003)(66446008)(53546011)(110136005)(2906002)(8936002)(6486002)(6512007)(71200400001)(478600001)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RW5ZVHY4RzFVQUtlQzV5WDZNWmV3YjRxMk5NT3VlZjZ3TUt6cXJxMklML1cw?=
 =?utf-8?B?WnBjMEs4dWd5NWZkeU93WTBjRkVpd1puUEYxVEVsUVRCQTUrbXI5N2p3L3Br?=
 =?utf-8?B?NDBvY200SFBoMFJrUzFtaTMzcUZiNUF4NDYzVTAxaGpwbmFpS3kzUmpudU5h?=
 =?utf-8?B?U1M1QjhSN1NPRjZ2SFIzN28rMU1DZFNaZm52b3R4d0VPSjc2OE5CMVJvUWY4?=
 =?utf-8?B?Z2wyK0NCUThkVTllYzV6Y3ZQQTFYeEkrMjdXekpKblVqM09EYk9RRldzVmJY?=
 =?utf-8?B?Qll5cURaSzkzK2EwRGpMUEwwbXpKNVJJaDJjdVh0SVh4OWlFQnFESFNaTndF?=
 =?utf-8?B?Z3hqTW9IUlZzQWlkVlAvSEE0RklSaWtoajRqLzRQbWN6bTdRU0M0U1o0cjVX?=
 =?utf-8?B?dmFyeUpBa2xwQWtuTWZ1SVd0Mlo1RGhsRVhUMVNDYmJwTmVqdWNSTHprblNM?=
 =?utf-8?B?OHB5eHpuUW9XZUw3MWxZcEl2VTh1N2F0ekM5RjZ0bXpsMWF0UFVweDltSTY4?=
 =?utf-8?B?dkpGY3lUUEs3QXFBbDNXWFNna05YYTBqaC9rcXRuQTRybzFndG1kekNVSTNz?=
 =?utf-8?B?cEIvSWxXMUxkbWF0S3RxaFhYWVlxUDZmZjFzKzExVUNGY3dHSUtNclJxNkxB?=
 =?utf-8?B?WGgwZm5RRFJjNnBxaTVRMkFySmhFelRWc2ZWRDlaWElMTlc3U3Y5T2Z3Qmla?=
 =?utf-8?B?RXY1d0dac3RpaXdpSEV3MkpuS0NsT1cwVU9wMWNIK2lhMDNCMFBFOFN2U2dM?=
 =?utf-8?B?b24wQndYTTF4cEZhR1V5cGJLdjY5Z0pPYnRkSWg0Nk10VnNJK1dFU3pvbkhO?=
 =?utf-8?B?amZXNFVva0NEdjFiNHo4VDFzeG5CS01vV3lRbWUwTzQ2VUU3VXlDUm9ZYzll?=
 =?utf-8?B?ekJIREo3R3lwUk45TGxEM21xSkdUMURUdjR3K1pVdWZyQWRmRjN2M3I5YkNO?=
 =?utf-8?B?MU91WWY2cGIycitoNzd6bG0rSFNqUnZ6cGxjd2FhVkdGa0lsNHd2Wmp4TEJ6?=
 =?utf-8?B?d0dlSTRFL3h5RUFFQTd6ckMxNStoaDFnZ1pjaU5qWXFmRXFEZzkzNmtIWUtH?=
 =?utf-8?B?ZzFXVFR6aHhGOTY2MkdVZ2U2TXdVVmMyUGNCTHlLdGg2YU93ZmRaZEt5SHl1?=
 =?utf-8?B?K1JmZFBHaDZMaC9vSWtwZ2xpdlFPSHI0SEcyR3VKUmlHMHo1R3NjSzl6aW9x?=
 =?utf-8?B?ZnUrV1pMbnRVVjdkWWhQd0dFMnZLb0hRSXNLYldtdTViL3pHamlJcTNpbzNI?=
 =?utf-8?B?RXZ2SlA1dGpHejNDOUFnM2VpRi9EOTJFMTZ6cWN4NEhlQnFBNExyemZKWHli?=
 =?utf-8?B?TEdkOGx2ajBZSnVobGF2bW5vc0RKcmFFdmtWd1dpczVqMnJVenE0dFQ4eDda?=
 =?utf-8?B?YWNvRXMvdTNLTjJzS2czSklJUGtZNDFzZmxVVkErZk5XVFFlU093L1RRWnJ6?=
 =?utf-8?B?MFkzNGp0MmRVS2pVbjJhZjJrdm16Y0lreE85Y3pBPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DD9C926B2837846BABF2F08F36DE480@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc3a0d7-6a47-4f3b-c730-08d8c3f665e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 01:37:11.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfwOmETk03TgInl2pVc1KxZRvaY45HVFfvqmrGAasEYdVUCN54tcy9RUmfpmnI5hgr0rl4uFx+zOA2aDwisFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4473
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTI5IGF0IDAxOjM0ICswMjAwLCBndXkga2VyZW4gd3JvdGU6DQo+IE9u
IDEvMjkvMjEgMTI6MzYgQU0sIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gRnJvbTogIkouIEJy
dWNlIEZpZWxkcyIgPGJmaWVsZHNAcmVkaGF0LmNvbT4NCj4gDQo+IFRoZSBORlN2NCBwcm90b2Nv
bCBkb2Vzbid0IGhhdmUgYW55IG5vdGlvbiBvZiByZW9tb3ZpbmcgYW4gYXR0cmlidXRlLA0KPiBz
bw0KPiByZW1vdmV4YXR0cihwYXRoLCJzeXN0ZW0ubmZzNF9hY2wiKSBkb2Vzbid0IG1ha2Ugc2Vu
c2UuDQo+IA0KPiBUaGVyZSdzIG5vIGRvY3VtZW50ZWQgcmV0dXJuIHZhbHVlLiAgQXJndWFibHkg
aXQgY291bGQgYmUgRU9QTk9UU1VQUA0KPiBidXQNCj4gSSdtIGEgbGl0dGxlIHdvcnJpZWQgYW4g
YXBwbGljYXRpb24gbWlnaHQgdGFrZSB0aGF0IHRvIG1lYW4gdGhhdCB3ZQ0KPiBkb24ndCBzdXBw
b3J0IEFDTHMgb3IgeGF0dHJzLiAgSG93IGFib3V0IEVJTlZBTD8NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEouIEJydWNlIEZpZWxkcyA8YmZpZWxkc0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gwqBmcy9u
ZnMvbmZzNHByb2MuYyB8IDMgKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9j
LmMNCj4gaW5kZXggMmY0Njc5YTYyNzEyLi5kNTBkZWE1ZjU3MjMgMTAwNjQ0DQo+IC0tLSBhL2Zz
L25mcy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IEBAIC01ODk1LDYg
KzU4OTUsOSBAQCBzdGF0aWMgaW50IF9fbmZzNF9wcm9jX3NldF9hY2woc3RydWN0IGlub2RlDQo+
ICppbm9kZSwgY29uc3Qgdm9pZCAqYnVmLCBzaXplX3QgYnVmbA0KPiDCoAl1bnNpZ25lZCBpbnQg
bnBhZ2VzID0gRElWX1JPVU5EX1VQKGJ1ZmxlbiwgUEFHRV9TSVpFKTsNCj4gwqAJaW50IHJldCwg
aTsNCj4gwqANCj4gKwkvKiBZb3UgY2FuJ3QgcmVtb3ZlIHN5c3RlbS5uZnM0X2FjbDogKi8NCj4g
KwlpZiAoYnVmbGVuID09IDApDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiDCoAlpZiAoIW5mczRf
c2VydmVyX3N1cHBvcnRzX2FjbHMoc2VydmVyKSkNCj4gwqAJCXJldHVybiAtRU9QTk9UU1VQUDsN
Cj4gwqAJaWYgKG5wYWdlcyA+IEFSUkFZX1NJWkUocGFnZXMpKQ0KPiANCj4gcXVlc3Rpb246IHdo
YXQgaGFwcGVucyBpZiBzb21lb25lIGlzIGF0dGVtcHRpbmcgdG8gY3JlYXRlIGFuIGVtcHR5DQo+
IEFDTCBvbiBhIGZpbGU/IGFzIGZhciBhcyBpIGtub3csIHRoaXMgaXMgbGVnYWwuDQo+IHdvbid0
IHlvdSBhcnJpdmUgaW50byB0aGlzIHBvc2l0aW9uIHdpdGggYSBidWZsZW4gb2YgMD8gaXQgc2hv
dWxkIGJlDQo+IHNpbWlsYXIgdG8gJ2NobW9kIDAgPGZpbGU+Jy4NCj4gDQoNCkFncmVlZC4gSWYg
dGhlIHNlcnZlciBkb2Vzbid0IHN1cHBvcnQgcmVtb3ZpbmcgdGhlIEFDTCB0aGVuIGl0IHNob3Vs
ZA0KYmUgdXAgdG8gaXQgdG8gZW5mb3JjZSB0aGF0IGNvbmRpdGlvbi4gSSBzZWUgbm90aGluZyBp
biB0aGUgTkZTDQpwcm90b2NvbCB0aGF0IHNheXMgaXQgaXMgdXAgdG8gdGhlIE5GUyBjbGllbnQg
dG8gYWN0IGFzIHRoZSBlbmZvcmNlcg0KaGVyZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=
