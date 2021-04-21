Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A9A366A9B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Apr 2021 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhDUMSj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 08:18:39 -0400
Received: from mail-eopbgr680127.outbound.protection.outlook.com ([40.107.68.127]:59521
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238595AbhDUMSi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 21 Apr 2021 08:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xijc+jv0sgrkUCJiGLllgjPoor8AlyWlwxKlg4U5ike3zZcp/VQ+qTbTSsxz49guab0HdO/GycPKnri9OaRQUDwDrICDJzcZcRdPD2C2dPOqmsmbi9PcgLbZasSCzcQeNPbRHZB8KDGcpODSlN328M617iiMwjeA0cRmaawTjItqjuHKr1qtaLbo+KWH6w0GkAejPgTf8CX0s0GXmLM8e89YgzcddCx+mhUNb8Fzj9wO0OLTTZGWpsCCXyHFHlnTIptGiu3mT5HG4ublSSR9DoD3gFkW3VlPXQ4ER5+Zhoq+OwSorFb6LSZ4YjNSRJD82fLWJmr0r3VvUP2ICKWbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsIYNTjMqOX8TQo/s9THzPIS0ukrb1lalkUUfo+Eqrg=;
 b=E1FgnICeP4KmgruLUOAdMwhkB+CeXef5/abDMvfujFtNWhabWIU5rxx5IrXAdUvFbA0xEGS165jhexwnQr7/9SWcFVNJIpxjtR0cOHMHn8p8vVFJdUIkk+BkPrp0Cw7OMhcaEm8CHcINwml5Q4pCtw0tK7+3H7lh3zS62rhi39qF3kx993lGTBC8wQgIx4YmbmDamRS5sUleIJmsfpXVNhbvovPiQmwmnUTXB+Zv5YoAWm4Uubd7yRHOyR0+oHcPzBTyRlXOSYGT1WkOSNE6gTV+a5O59O4u+eOKxp9c83guXh3Tg52uNV2g8bsN0yZcfE8HvGLsJJHa6adb2Gm53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsIYNTjMqOX8TQo/s9THzPIS0ukrb1lalkUUfo+Eqrg=;
 b=Sm5y5s9gW87kDkWpsnQWhhgXCZ1zzrm+LNG43TWNtkqvtVf8VWVNc2BUQcFg+eVXG/E+RXXUOyX0T5i84L52NN2has0RzwJ8qVDzd6d9GnhPvIBe6HgxWGKzF0T6Cr6u+ZidWnSJhscn23GqPmY0opoEA/Yyv9ZBIwc6TG4L8hc=
Received: from BN0PR13MB4725.namprd13.prod.outlook.com (2603:10b6:408:121::8)
 by BN6PR13MB1585.namprd13.prod.outlook.com (2603:10b6:404:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8; Wed, 21 Apr
 2021 12:18:03 +0000
Received: from BN0PR13MB4725.namprd13.prod.outlook.com
 ([fe80::8de6:fcd7:c82d:c86a]) by BN0PR13MB4725.namprd13.prod.outlook.com
 ([fe80::8de6:fcd7:c82d:c86a%3]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 12:18:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "guy@vastdata.com" <guy@vastdata.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Linux NFS4.1 client's "server trunking" seems to do the opposite
 of what the name implies
Thread-Topic: Linux NFS4.1 client's "server trunking" seems to do the opposite
 of what the name implies
Thread-Index: AQHXNigL6herFL3BZEiI6aoxx5X6Iqq+l2MAgABNDAA=
Date:   Wed, 21 Apr 2021 12:18:03 +0000
Message-ID: <2b8ca2ac6e43acaf604eb1c0efdd45ca7a917038.camel@hammerspace.com>
References: <061a976c-2082-bb86-91ec-f0f97a73e1ac@vastdata.com>
         <ee933f9d-21fd-9bc7-cdce-8da2d43b30a1@vastdata.com>
In-Reply-To: <ee933f9d-21fd-9bc7-cdce-8da2d43b30a1@vastdata.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vastdata.com; dkim=none (message not signed)
 header.d=none;vastdata.com; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64cc70b-43f7-4c3e-ea0a-08d904bf834c
x-ms-traffictypediagnostic: BN6PR13MB1585:
x-microsoft-antispam-prvs: <BN6PR13MB15853ACD0105F2E6AF4B752AB8479@BN6PR13MB1585.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDeivZn13zFkIptEnRwqIDtprLq2Hq7oS+LQkHBq41mNCI+UrrXMvXtkCaceXQnsZP8T/ZY/WLvY/F3hXAVt3im4KW94J29x2C1ZG03HYJ9ErccJ4SKdPQCW+uoLrwhZtMaKsDSoaSZtRCq5OEcy/UJWKsDSLhkxHYdJgejWqjJsXCuVBQ9S7EIARMGBmai54/58QTY25JaLYWaVsK2MLJdLU8uu7PdGPR4kvUIzZUwk01zdT4+i/wiNAVg0j76lGcPbXjFUZWts1qRuQE6uoguGieEhIGSt0kzySX9OXY/foLKxGSREuXaiW5015j21qWJxLBJJdoeYDrDruDs3TAzzqdZVGmha9+45a/EmnteiZLlsa1WSGTdFGdhQuigqC1Rhg397GDru81Y+IBwA8mGPKFhhGJdPCAwTRcj79y0cAJ8muWVVX3EZQwsY1LSpR/mnDZCEmtGhc1Ruk4rmNnZm+ilOoamPvUf+Vm1SOsX3gA7yPoL3riBan8v9+BGl/VFZabL9ku+jenYH+8lBaA2dmuL0dhU5N0VLFPy4bfwcNqAvQur/m+raVAjV2pHSuZwQSLqoGK8/2BoVd+UWrecaAmlLxQyaHeRwq6Omy+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB4725.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(346002)(136003)(396003)(366004)(8936002)(2616005)(122000001)(36756003)(38100700002)(6512007)(91956017)(316002)(86362001)(71200400001)(2906002)(478600001)(66476007)(64756008)(66446008)(66556008)(6486002)(76116006)(8676002)(26005)(66946007)(110136005)(53546011)(6506007)(186003)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MmJtSjVIM0VYSnM0bXlLLzR1bWMzck5IaXloZ1NoQm4wenEwbTk2emRQQ1cy?=
 =?utf-8?B?RklZRVJrNnZZa0tXenIxcTNHMVJZU1Y2NVFZTjV3UklZUzF5U1huQ3ArSEdT?=
 =?utf-8?B?eFo2UXZvTW41aGp3QUtYQmJaYUYzcWdOdWdMSHl1OGxWK3dkdUhGR0xOOEhQ?=
 =?utf-8?B?dFhGZDF2bUNheUpXQm0yMTdGOWJKbmtGNk83ckNaTzMxbFRzbUJWMVgxcnpY?=
 =?utf-8?B?U096Q3pvNDJIREZ5L0hyWmJ3WXd6ZEtTckxwYWo2MWdpVFdMdFppK2w4VEUy?=
 =?utf-8?B?SkhMOWd3NFVrU1ZDU2VMQXZjYlVEdDdGQWRQS3EyN2Y0dS80Y1hWWldYYVRI?=
 =?utf-8?B?TG96MWRtMkd4MmpKaEx0Q2hiZEVuNERZMURQQ2U3MWN4WmU1SnlhOFZvZHR2?=
 =?utf-8?B?VHQxck5ZT1p0NVJ5cVVtQ1VENHlhZWRGSmsxSTdIUDdDM1ppRW9BbW1DbExr?=
 =?utf-8?B?WDc0Z2lEbmRoMThGcU1vUzlEUndZZm1OejZMektCa1MwUCtFRjZxMjhtOG9p?=
 =?utf-8?B?ZDdTS003dXpvZDRsa01NVlFQSjllTmltaFRTSmZtcmtaS1NEREV3ZFdGU0ky?=
 =?utf-8?B?Tm9idTF0ejVwMUdDaUtkalRsRk1rRlNNZFhLSnZLZUpHMVdubjhFbG53dExM?=
 =?utf-8?B?NEwwMUdIc3dvYTJmUzBvWStsa2pIMUw0Y255SDFiVzlVcUVkMkFjV01VUmJ4?=
 =?utf-8?B?VG5qR1pBME9VMjVXRHp0OEtMb1hiN3NJWVlhSmEyczR1M0tWaUlTV0Vndll6?=
 =?utf-8?B?R2RGblFDUVp1c3dEeC8rQVF3NHFZR1lkSTh3QjFhNmZlWHZTZkRmWGtFYTFk?=
 =?utf-8?B?RFN0T3RuelBRVzBmYVlvRVloWE1kQUtQRmRUZFBlZEpsS0ZEN2VxT285VjZl?=
 =?utf-8?B?U0UrMFNmZk5zaTE3eVQ1SGgvcWRaWnArejlqcEd3L2Q4QjE3L3h5QUFtdzNo?=
 =?utf-8?B?aDVPOVhjZU1qdEp3Q25MMHgvd1BEczJ3Rm1FaTJ6SGFYcHpObFBBbnNEWmQv?=
 =?utf-8?B?TDJacE5VdmVobUpieXc1MzNZL3o0SmJCNHl5L1lxOG5ObmtWUUtLaTBVZ1F0?=
 =?utf-8?B?UE5SRWtsR2lCOWpqZ2dpSldZWVJ6TGlFcGZGczA4aG5EWTlPdlY2a09NRmND?=
 =?utf-8?B?L2RXK2wyLzJwSXIyTkNHSzNsNjhBcHo3Qk1uYUZhYnNrTXBXbkV5MjNzdjFt?=
 =?utf-8?B?cTNMR1dtWWlydmpqZWFLTkNkQjg1Nkk4T3A0OEl5OU16V1hodFFqdCtmall1?=
 =?utf-8?B?ZVlXSXkxNXVPNmh1VnBGNmZ6YlRiR29VU1BodnhZNVBla1crMDFZa3VYR2tv?=
 =?utf-8?B?WWVYS0FZR0lPa0ZXaTdjNmMwS2FXYmpubE5tTStFZG5HaFdmZFBGaWZuaDBw?=
 =?utf-8?B?cWNLVXlZRTdRYUFWOWJaNmhDcUJCOTZuSHRJZEpqZFYrWXNSaXpDZEtOaEc1?=
 =?utf-8?B?c1FlcnRrTUpVMzkvTVlwaHMydkEvVDFpUzErNlBCbDF3dzdCbGFxR1RpeWh0?=
 =?utf-8?B?VytTblhlUEZTOWkwdmxhQTZ2Qm5JN0hPSllJb1FjVE11aC80NnkrTzQyc3Zq?=
 =?utf-8?B?ZlJmdVVUUHZhdjBtWXVqbHdPdTNVR2kwYkZrTDI1Zm9UN2xETDBpeE1ySlZI?=
 =?utf-8?B?eURXUVJSOThKTEV6M256Q3BTRjdQQnQxb3dVamR6MkZUcHRFdkZPVm82ZGEr?=
 =?utf-8?B?dUVzeGJ0c2dJRnVGOUFYZjdPY2k5enJWMWxuUENWWTdWbjMzeGMvSkJmd1J0?=
 =?utf-8?Q?xFdBEQzLMlHr3YeVxXSFtS8BqvvhqTUmNkRUfwd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5302D6D3A4DE23428572B45FE8ED78CE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB4725.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64cc70b-43f7-4c3e-ea0a-08d904bf834c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 12:18:03.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgqnosqmh+UVUMsCAti5RqJVLcAPTZrubjdGYyRxvXAC0B+L0SAlELIpH4MyfiARn981eDbpCItLiexhydrQ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1585
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA0LTIxIGF0IDEwOjQyICswMzAwLCBndXkga2VyZW4gd3JvdGU6DQo+IGhp
IE9sZ2EsIHRoYW5rcyBmb3IgdGhlIHJlc3BvbnNlLiBtb3JlIGNvbW1lbnRzL3F1ZXN0aW9ucyBi
ZWxvdzoNCj4gDQo+IE9uIDQvMjEvMjEgMjoyOCBBTSwgT2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6
DQo+IMKgPiBPbiBUdWUsIEFwciAyMCwgMjAyMSBhdCA0OjU5IFBNIGd1eSBrZXJlbiA8Z3V5QHZh
c3RkYXRhLmNvbT4NCj4gd3JvdGU6DQo+IMKgPj4gSGksDQo+IMKgPj4NCj4gwqA+PiB3aGVuIGF0
dGVtcHRpbmcgdG8gbWFrZSB0d28gTkZTIDQuMSBtb3VudHMgZnJvbSBhIGxpbnV4IE5GUw0KPiBj
bGllbnQsIHRvDQo+IMKgPj4gdHdvIElQIGFkZHJlc3NlcyBiZWxvbmdpbmcgdG8gdHdvIGRpZmZl
cmVudCBob3N0cyBpbiB0aGUgc2FtZQ0KPiBjbHVzdGVyDQo+IMKgPj4gKGkuZS4gdGhlIHNlcnZl
ciBtYWpvciBpZCBpbiB0aGUgRVhDSEFOR0VfSUQgcmVzcG9uc2UgaXMgdGhlDQo+IHNhbWUpIC0g
dGhlDQo+IMKgPj4gbGludXggTkZTNC4xIGNsaWVudCBkaXNjYXJkcyB0aGUgbmV3IFRDUCBjb25u
ZWN0aW9uICh0byB0aGUgMm5kDQo+IElQKSBhbmQNCj4gwqA+PiBpbnN0ZWFkIGRlY2lkZXMgdG8g
dXNlIHRoZSBmaXJzdCBjbGllbnQgY29ubmVjdGlvbiBmb3IgYm90aA0KPiBtb3VudHMuIHRoaXMN
Cj4gwqA+PiBzZWVtcyB0byBiZSBoYW5kbGVkIGluIGEgaGFyZC1jb2RlZCBpbnNpZGUgdGhlIGZ1
bmN0aW9uIG5hbWVkDQo+IMKgPj4gIm5mczQxX2Rpc2NvdmVyX3NlcnZlcl90cnVua2luZyIsIGFu
ZCBsZWFkcyB0byByZWR1Y2VkDQo+IHBlcmZvcm1hbmNlLA0KPiDCoD4+IHJlbGF0aXZlIHRvIHVz
aW5nIE5GUzMgKHdoaWNoIHdpbGwgdXNlIHR3byBkaWZmZXJlbnQgVENQDQo+IGNvbm5lY3Rpb25z
IHRvDQo+IMKgPj4gdGhlIHR3byBkaWZmZXJlbnQgaG9zdHMgaW4gdGhlIHN0b3JhZ2UgY2x1c3Rl
cikuDQo+IMKgPj4NCj4gwqA+PiBpIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IChjbGll
bnRfaWQpIHRydW5raW5nIGlzIHN1cHBvc2VkDQo+IHRvDQo+IMKgPj4gYWxsb3cgdG8gbXVsdGlw
bGV4IGNvbW1hbmRzIG92ZXIgbXVsdGlwbGUgVENQIGNvbm5lY3Rpb25zIC0gbm90DQo+IHRvDQo+
IMKgPj4gY29uc29saWRhdGUgZGlmZmVyZW50IHdvcmtsb2FkcyBvbnRvIHRoZSBzYW1lIFRDUCBj
b25uZWN0aW9uLg0KPiDCoD4+DQo+IMKgPj4gaXMgdGhlcmUgYSB3YXkgdG8gYXZvaWQgdGhpcyBi
ZWhhdmlvdXIsIG90aGVyIHRoZW4gZmFraW5nIHRoYXQNCj4gdGhlDQo+IMKgPj4gInNlcnZlciBt
YWpvciBpZCIgaXMgZGlmZmVyZW50IG9uIGVhY2ggbm9kZSBpbiB0aGUgY2x1c3Rlcj8gKHRoaXMN
Cj4gaXMNCj4gwqA+PiB3aGF0IGFwcGVhcnMgdG8gYmUgZG9uZSBieSBOZXRBcHAsIGZvciBpbnN0
YW5jZSkuDQo+IMKgPiBIaSBHdXksDQo+IMKgPg0KPiDCoD4gQ3VycmVudCBpbXBsZW1lbnRhdGlv
biBvZiB0aGUgbGludXggY2xpZW50IGRvZXMgbm90IHN1cHBvcnQNCj4gc2Vzc2lvbg0KPiDCoD4g
dHJ1bmtpbmcgdG8gdGhlIE1EUyAobm9yIGRvZXMgaXQgc3VwcG9ydCBjbGllbnQgaWQgdHJ1bmtp
bmcpLiBJJ20NCj4gwqA+IGhvcGluZyBzZXNzaW9uIHRydW5raW5nIHN1cHBvcnQgY29tZXMgaW4g
dGhlIG5lYXIgZnV0dXJlLiBDbGllbnRpZA0KPiDCoD4gdHJ1bmtpbmcgbWlnaHQgbm90IGJlIHNv
bWV0aGluZyB0aGF0J3Mgc3VwcG9ydGVkIHVubGVzcyB3ZSdsbCBoYXZlDQo+IGENCj4gwqA+IGNs
dXN0ZXJlZCBORlMgc2VydmVyIG91dCB0aGVyZSB0aGF0IGNhbiB1dGlsaXplIHRoYXQgYmVoYXZp
b3VyLg0KPiANCj4gaSBzZWUuDQo+IA0KPiDCoD4gQnR3IHlvdSBjYW4gZG8gbXVsdGlwYXRoIE5G
UyBmbG93cyBieSB1c2luZyB0aGUgY29tYmluYXRpb24gb2YNCj4gwqA+IG5jb25uZWN0IGFuZCB0
aGUgbmV3bHkgcHJvcG9zZWQgc3lzZnMgaW50ZXJmYWNlIChzdGlsbCBpbiByZXZpZXcpDQo+IHRo
YXQNCj4gwqA+IGNhbiBtYW5pcHVsYXRlIHNlcnZlciBlbmRwb2ludHMuDQo+IA0KPiB0aGUgcHJv
YmxlbSB3aXRoIG5jb25uZWN0IGlzIHRoYXQgYWx0aG91Z2ggd2Ugd2lsbCBoYXZlIG11bHRpcGxl
IFRDUCANCj4gcmVxdWVzdHMgcGFyYWxsZWxpc20gdGhhdCBjYW4gYmUgYWNoaWV2ZWQgKHNpbmNl
IHRoZSBzbG90IHRhYmxlIHNpemUNCj4gaXMgDQo+IHRoZSBsaW1pdGluZyBmYWN0b3IgZm9yIHRo
ZSBudW1iZXIgb2YgaW4tZmxpZ2h0IGNvbW1hbmRzKS4NCj4gDQo+IHRoZSBzYW1lIHByb2JsZW0g
d2lsbCBhbHNvIGV4aXN0IHdpdGggc2Vzc2lvbiB0cnVua2luZyAtIHdoaWxlIHdoZW4gDQo+IGNv
bm5lY3Rpb24pIC0gdGhlIG51bWJlciBvZiBpbi1mbGlnaHQgY29tbWFuZHMgY2FuIGJlIGluY3Jl
YXNlZA0KPiBsaW5lYXJseSANCj4gdG8gdGhlIG51bWJlciBvZiBUQ1AgY29ubmVjdGlvbnMuDQo+
IA0KPiBpcyB0aGVyZSBhbnkgd2F5IHRvIHdvcmsgYXJvdW5kIHRoYXQ/DQo+IA0KPiANCg0KVGhl
IExpbnV4IE5GUyBjbGllbnQgYWxyZWFkeSBzdXBwb3J0cyBkeW5hbWljIHNsb3QgYWxsb2NhdGlv
biwgYW5kIHdpbGwNCmFkanVzdCBpdHMgc2xvdCB0YWJsZSBzaXplIHRvIG1hdGNoIHRoZSB2YWx1
ZXMgb2Ygc3JfaGlnaGVzdF9zbG90aWQgYW5kDQpzcl90YXJnZXRfaGlnaGVzdF9zbG90aWQuIFlv
dSBjYW4gYWxzbyByZWNhbGwgc2xvdHMgdXNpbmcNCkNCX1JFQ0FMTF9TTE9UIGluIG9yZGVyIHRv
IHNocmluayB0aGUgdGFibGUgc2l6ZS4NCg0KV2UgY29uc2lkZXIgdGhpcyB0byBiZSB0aGUgcmln
aHQgc29sdXRpb24gZm9yIHNjYWxpbmcgdGhlIG51bWJlciBvZg0Kc2Vzc2lvbiBzbG90cywgYW5k
IGFyZSBub3QgY29uc2lkZXJpbmcgaW1wbGVtZW50aW5nIGNsaWVudCBpZCB0cnVua2luZy4NClRo
ZSBsYXR0ZXIgaXMgYSBsb3QgbW9yZSBvbmVyb3VzIHRvIG1hbmFnZSBmb3IgdGhlIGNsaWVudCBh
bmQgZG9lcyBub3QNCmhlbHAgc29sdmUgdGhlIHByb2JsZW0gb2YgZmxvdyBjb250cm9sLg0KDQou
Li5hbmQgbm8sIG5vYm9keSBwcm9taXNlZCBhbnlvbmUgdGhhdCBwZXJmb3JtaW5nIGEgbmV3IG1v
dW50IHdvdWxkDQptYWdpY2FsbHkgaW5jcmVhc2UgdGhlIG51bWJlciBvZiBUQ1AgY29ubmVjdGlv
bnMgYXZhaWxhYmxlIHRvIGV4aXN0aW5nDQpORlN2NCBtb3VudHMuIFRoYXQncyB0aGUgcmVhc29u
IHdoeSB3ZSdyZSBsb29raW5nIGF0IE9sZ2EncyBzeXNmcw0Kc29sdXRpb24gdG8gYWRkIGEgcHJv
cGVyIGNvbnRyb2wgbWVjaGFuaXNtIHRvIGFsbG93IGR5bmFtaWMNCm1hbmlwdWxhdGlvbiBvZiB0
aGUgdHJhbnNwb3J0cy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
