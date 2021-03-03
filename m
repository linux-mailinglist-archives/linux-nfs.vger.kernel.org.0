Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3632C68C
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355498AbhCDA3M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:12 -0500
Received: from mail-mw2nam12on2125.outbound.protection.outlook.com ([40.107.244.125]:9889
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344042AbhCCNZu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Mar 2021 08:25:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvIWDbcfm8MFJjR3LCRSb4LxS466Fw82hVstJOU2jie5GWz+XrMt+Xbr/YvQ0Z8sRTCyy9Uhbaw8sl4IawjMDgub69FqgbiIG24QAHOkpSGnIxBz3/lhCVoMoC8+3O/zSqVGL+v7vBuvzjBxwkh5UZG+Chd3YX9RKWtL+ec4ptqfqVF8+wlrzD36o6XAfZy/lVB92mJvIsH+xjOr/sPHy3dU0MViizM1vUcIB54ns1Uo+jMYcyFXLN03gcBLmOVx3W+AMLZqoC5mZXt0KzyawpXgvxeuF25uL+B85oxpWSDliZbl1ZMUETZecNq/kyPQ+3sS5CZOMY4+V7oNAzelKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1801AXg/xaY2PC7OxKBVghVhHL/Iz0UiXhHZVdMuhvE=;
 b=TqPE46HefdTDFVFOcisn261RIbifAd6CYWX7YoQZPpOuxBppLJOJqesGnCUCE2Xh/zjMyAvdbPfm1jNQOmnXMqsKAZsNItcDpny1hLJuodrRaXDRD54yJwFgW6J01QY+WeFmKeKPMjPdQmGlTaaiFKF29UwpMbUIhWbc5+yYx1QrddIvUlMJ+USQmNq+jtmIVTW6tA4a0LbYAv0mNjOpv7Rn+5H3F8iIikh64uhT7ys7GmarO381OJNQ5kfOCbVXgAxxHs9+zla2aRCcVd2uZaWfSyXGrvnHUgYvxyFNlPyG0YWRcaDpGvPb9jTLq489LXcb1dpGtiCgyiqW5EtVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1801AXg/xaY2PC7OxKBVghVhHL/Iz0UiXhHZVdMuhvE=;
 b=OGGSHtxo6l+iGWeunjubGPN19mtxdDAkwtXIqaY/sc3SeLAzitvo1CwXOuVWMJIbjeARqgeu8gjFatQJUTpcuvxGJ884GO+oSlLmlAsUuJS9n8qtiLuYVJAkzyeODWtlx5HIb/R72U3O0TIwJyCkLxJMQGmvaIQ3oWmKDres35k=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4649.namprd13.prod.outlook.com (2603:10b6:610:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.10; Wed, 3 Mar
 2021 13:23:41 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3912.016; Wed, 3 Mar 2021
 13:23:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: memalloc_nofs_save() only on async
Thread-Topic: memalloc_nofs_save() only on async
Thread-Index: AQHXEC6i5XW+alclukmIT4ymQLjje6pyQHuA
Date:   Wed, 3 Mar 2021 13:23:41 +0000
Message-ID: <84e6e28e376bd0857023ca9658625d04e3712276.camel@hammerspace.com>
References: <F9ECC07B-62B5-4242-8A93-DA4FD3FEE1C6@redhat.com>
In-Reply-To: <F9ECC07B-62B5-4242-8A93-DA4FD3FEE1C6@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6410ce07-a2fd-481c-ecd6-08d8de47900f
x-ms-traffictypediagnostic: CH0PR13MB4649:
x-microsoft-antispam-prvs: <CH0PR13MB46493643085A8189D13AC86FB8989@CH0PR13MB4649.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J1CGlWtayKYmayIVeHqz1V5rH4fs0CMOgbgWi6TndyOKA//+Qr2Q12gyCFLa3FtLN7ekcVXtjMMaEJPvaMsJYu8ofCEojhd4dwI6sfKJeWbjbijvrRFLfrVzeQW/9+aOVGXilIp26Hs2H0Ef5ftagQXEIlaK9E42QsiI2Zd8m0dxl3y+ZWjTiP5YtL4aC5OARH6bflo356KXj9wuNxiwf2nSUwS8SZwXOeS+SfqvJe6gu5tWvQO8P7Mth6fOB8MEVxRUmflLWTdObpDIEY9sGcgGkQtFDmHMhRkYuCcPBeHBcNOTF1tg3sYLJbWS/pbg9GJXl7UmiOeRqwwDO6Ac/MSO8avxpgOcevUItVZiWiFPmKuP6NRvSvZvijCmJLLjWol6pIZDIqDtHUJqjP31u71fmUGsNYD1RyxGP6g8gPcBQT7ZkPcKLwf1AViD0nVqqZup/fKFD53E4zYNsAxZK3RpsytrFirzQoO03e1F1UyCC61JTom7q0GgHn/v07T9fF5oNqJ5qb47bwmx3DDN0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(396003)(136003)(366004)(376002)(2616005)(86362001)(8676002)(4326008)(316002)(26005)(6486002)(83380400001)(6506007)(5660300002)(478600001)(36756003)(8936002)(76116006)(6512007)(66556008)(64756008)(66446008)(66946007)(6916009)(66476007)(71200400001)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTQveUIxemdIc2txR0dDQmNUMGh6VTVrbGZLTDExVjFDSm9mdkxKR21ZRUJC?=
 =?utf-8?B?aG1DZHgrVVh2blorNkVJR1A1clR4ck92TTZsWEdMZFlZeTcra0lPak5MWmVQ?=
 =?utf-8?B?QVdGeTNzNitUSnJyWVBUUFp2b3RXa20xYzdraVdqNGN4Z0NXQzNPT3NhTDhE?=
 =?utf-8?B?L1VYaGxvUm94M242UFlTSTFvK0xrTXVVZDk4K05IOFg3RjVQdDh2dmJxa0JW?=
 =?utf-8?B?Skp2VXpjQjd4ek5wWGh3KzJnNHkyTi93dFZObUdFc0FSQUpuVjJKNFp3eEpH?=
 =?utf-8?B?cWxjbG13bjliS0VZZDRBeUJKVENXNlZNU2xyL3pZdlFsUW90TkRoZ1YyZjhF?=
 =?utf-8?B?dkxNMkZFM0ZzR2k0U3BBOGhaSmxJdEc4WEMrWUhPYVV2TXZzcXhVMHNsekMz?=
 =?utf-8?B?bXpqbU9HRE9CSTQrbXpCaFYzMVcySnBWMlVnNy9pd01HSHpDYUpyOXBWd2V0?=
 =?utf-8?B?eGo1RUFoZ0NyQXBXQlZURDViMnpqZ25ud0hHeXoraldJNlI0WmQ0OFVDQTJm?=
 =?utf-8?B?SU1xQ3A4YWR0OWFxMHRJUHNlQ29JbGhKeHVWZHE3YWZzdldwV3JBdFlLSFkw?=
 =?utf-8?B?T2l1T3FvSWx2UHp6VnpWK2cwUWgxbjcxd0pCNTZtY2lnZHQyKzBQQjRKTnJX?=
 =?utf-8?B?WVQvSzIwTHo1NHE3WUJ0dFpLZWxJbHhtY3FMTHYzN0xSclVlTCs5UVJ3VFdQ?=
 =?utf-8?B?QUtvQ1dadWFsVUxuWWRseTdCYkhWVW01NndidzNTWDAwN2RpNXFaT2Y4OVEr?=
 =?utf-8?B?a0IraXpnRE4xWk05YkozaWhLakNPMFFIV1Y3Z3FkR2Y0ZzdOckNmdVMzaXN0?=
 =?utf-8?B?UXFpd3k4RityaXJUUE1qZitISHRDWUprbGMyeU1YcEtUUHhpcSt3TWhXakQ0?=
 =?utf-8?B?MEExbTBHNjBLZUgrQmgxcE53ZDVCSWV4SUl4UkZoTVQzaXBGSDJFUVJPVWw1?=
 =?utf-8?B?K3gvU0s3a1VBUmc4NWR0TkNvdldxc05IaDA3ZEhRaVhJOWx5SUNFV0J5bHRC?=
 =?utf-8?B?VjRpM2UvcmlhSHBUMGJmME1tVDhoWnJqSElWRHd5Qkx3VmFiKzdtYWlWODl6?=
 =?utf-8?B?N1RqVnJyRmlwV254bGM3ZmpFaUUzV2JoVmpVaEcwMEVjbGZXTlo2Y2dRMmdU?=
 =?utf-8?B?L0htMG5nL05nT0xSWXB4L1lzMjZHZDlyd2czZVhvTkFJcy96NWt4WjVRUjFW?=
 =?utf-8?B?bkRJWERsVlhNMHVNMkRqUGpoMDFmcE9NOHlGZHFlVkROOTZnTzBsRVIzQjF1?=
 =?utf-8?B?azVpT2U1WXd5MlB1NnhvVURhRnk0bjkrdUJtdGx4TlRDdTZMaEYrOTBReVNr?=
 =?utf-8?B?MjMrQ1BlcTVFZGovK2JyT21TM0VxR3JBWnVzNlJlZHozSzRTQkY3YVozWmwz?=
 =?utf-8?B?NUhyd25hamRTcVk3OGJSTUtieGh2R2JQSUp5aWMwN0U5M0FOWHBZakpVclNP?=
 =?utf-8?B?UWlaRnVOd0lyLzRHSkg4YVFlYmNLL3NMdWxJOEhOTXJabXRUOXVHNEFJZWwr?=
 =?utf-8?B?S3hnRHJ6aURYdFFEWUhpbjZKRXJBakVJVEc1dUczdm82STZGSEFaaGVSNnBF?=
 =?utf-8?B?SVFkSGhPbG4vZHJJczFGMWU0bVpMeWhNdEVGR2JJT0p0TEg5UlBIdXNPZnZq?=
 =?utf-8?B?TEswZTh1VTZ3eGtVaDR3VFk4dXYrTzZKMVN2ZVlwWXhZNEUvOEx6Sjg4bzZV?=
 =?utf-8?B?dmQ2L3hONk1DM3prWm1wQS9kU0FXd1dFRElJR1RpZnh5bjcrU21QUDJRY0U4?=
 =?utf-8?Q?ChuA75IxPEzpU0svjpjjOY/womJaIRtcPBxoLv3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7602A243B67C84418A2AB517CC1012C6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6410ce07-a2fd-481c-ecd6-08d8de47900f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 13:23:41.2623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmvBQ2KidQ3btc1cA4pAltRkBbcvpfbR1/2mTiy7INCCZDoeqD2+ydAYx89nY6OSooy+FB5SiLfRiPhs2Dw6/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4649
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTAzIGF0IDA4OjEwIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBIaSBUcm9uZCwNCj4gDQo+IEknZCBsaWtlIHRvIGdvIGJhY2sgdG8gc2V0dGluZyBz
ay0+c2tfYWxsb2NhdGlvbiA9IEdGUF9OT0lPIChzZWUNCj4gYTEyMzFmZGE3ZTk0KS4gVGhhdCB3
b3VsZCBjb3ZlciBzeW5jIHRhc2tzIGFzIHdlbGwgYXMgYXN5bmMsIGJ1dCBJJ20NCj4gbm90DQo+
IHN1cmUgd2hhdCBtZW1hbGxvY19ub2ZzX3NhdmUvcmVzdG9yZSBnaXZlcyB1cyBhbmQgaWYgd2Ug
c2hvdWxkIGp1c3QNCj4gdHJ5IA0KPiB0bw0KPiBhcHBseSB0aGF0IHRvIGFsbCB0YXNrcy4NCj4g
DQo+IFdlJ3JlIGdldHRpbmcgc29tZSBmb2xrcyBkZWFkbG9ja2VkIG9uIHRoZSB4cHJ0X3NlbmRp
bmcgcXVldWUgd2l0aCANCj4gc3RhY2tzIGxpa2U6DQo+IA0KPiDCoCAjMCBbZmZmZmFjYWI0NWYx
NzEwOF0gX19zY2hlZHVsZSBhdCBmZmZmZmZmZmFlNGQxODI2DQo+IMKgICMxIFtmZmZmYWNhYjQ1
ZjE3MWEwXSBzY2hlZHVsZSBhdCBmZmZmZmZmZmFlNGQxY2I4DQo+IMKgICMyIFtmZmZmYWNhYjQ1
ZjE3MWIwXSBycGNfd2FpdF9iaXRfa2lsbGFibGUgYXQgZmZmZmZmZmZjMDY3ZDQ0ZSANCj4gW3N1
bnJwY10NCj4gwqAgIzMgW2ZmZmZhY2FiNDVmMTcxYzhdIF9fd2FpdF9vbl9iaXQgYXQgZmZmZmZm
ZmZhZTRkMjE2Yw0KPiDCoCAjNCBbZmZmZmFjYWI0NWYxNzIwMF0gb3V0X29mX2xpbmVfd2FpdF9v
bl9iaXQgYXQgZmZmZmZmZmZhZTRkMjIxMQ0KPiDCoCAjNSBbZmZmZmFjYWI0NWYxNzI1MF0gX19y
cGNfZXhlY3V0ZSBhdCBmZmZmZmZmZmMwNjdmM2ZjIFtzdW5ycGNdDQo+IMKgICM2IFtmZmZmYWNh
YjQ1ZjE3MmE4XSBycGNfcnVuX3Rhc2sgYXQgZmZmZmZmZmZjMDY3MzJjNCBbc3VucnBjXQ0KPiDC
oCAjNyBbZmZmZmFjYWI0NWYxNzJlOF0gbmZzNF9wcm9jX2xheW91dHJldHVybiBhdCBmZmZmZmZm
ZmMwOGY1ZDQ0IA0KPiBbbmZzdjRdDQo+IMKgICM4IFtmZmZmYWNhYjQ1ZjE3Mzg4XSBwbmZzX3Nl
bmRfbGF5b3V0cmV0dXJuIGF0IGZmZmZmZmZmYzA5MTk0NmUgDQo+IFtuZnN2NF0NCj4gwqAgIzkg
W2ZmZmZhY2FiNDVmMTczZDhdIF9wbmZzX3JldHVybl9sYXlvdXQgYXQgZmZmZmZmZmZjMDkxYmE4
Yg0KPiBbbmZzdjRdDQo+ICMxMCBbZmZmZmFjYWI0NWYxNzQ1MF0gbmZzNF9ldmljdF9pbm9kZSBh
dCBmZmZmZmZmZmMwOTA2YTA1IFtuZnN2NF0NCj4gIzExIFtmZmZmYWNhYjQ1ZjE3NDYwXSBldmlj
dCBhdCBmZmZmZmZmZmFkZWY4NTkyDQo+ICMxMiBbZmZmZmFjYWI0NWYxNzQ4MF0gZGlzcG9zZV9s
aXN0IGF0IGZmZmZmZmZmYWRlZjg2YTgNCj4gIzEzIFtmZmZmYWNhYjQ1ZjE3NGEwXSBwcnVuZV9p
Y2FjaGVfc2IgYXQgZmZmZmZmZmZhZGVmOTlhMg0KPiAjMTQgW2ZmZmZhY2FiNDVmMTc0YzhdIHN1
cGVyX2NhY2hlX3NjYW4gYXQgZmZmZmZmZmZhZGVkZTE4Mw0KPiAjMTUgW2ZmZmZhY2FiNDVmMTc1
MThdIGRvX3Nocmlua19zbGFiIGF0IGZmZmZmZmZmYWRlM2Q1ZDgNCj4gIzE2IFtmZmZmYWNhYjQ1
ZjE3NTg4XSBzaHJpbmtfc2xhYiBhdCBmZmZmZmZmZmFkZTNkYWI1DQo+ICMxNyBbZmZmZmFjYWI0
NWYxNzYwOF0gc2hyaW5rX25vZGUgYXQgZmZmZmZmZmZhZGU0MmE4Yw0KPiAjMTggW2ZmZmZhY2Fi
NDVmMTc2NzhdIGRvX3RyeV90b19mcmVlX3BhZ2VzIGF0IGZmZmZmZmZmYWRlNDJlNDMNCj4gIzE5
IFtmZmZmYWNhYjQ1ZjE3NmM4XSB0cnlfdG9fZnJlZV9wYWdlcyBhdCBmZmZmZmZmZmFkZTQzMWM4
DQo+ICMyMCBbZmZmZmFjYWI0NWYxNzc2OF0gX19hbGxvY19wYWdlc19zbG93cGF0aCBhdCBmZmZm
ZmZmZmFkZTgxOTgxDQo+ICMyMSBbZmZmZmFjYWI0NWYxNzg2OF0gX19hbGxvY19wYWdlc19ub2Rl
bWFzayBhdCBmZmZmZmZmZmFkZTgyNTU1DQo+ICMyMiBbZmZmZmFjYWI0NWYxNzhjOF0gc2tiX3Bh
Z2VfZnJhZ19yZWZpbGwgYXQgZmZmZmZmZmZhZTMxYmVhNw0KPiAjMjMgW2ZmZmZhY2FiNDVmMTc4
ZTBdIHNrX3BhZ2VfZnJhZ19yZWZpbGwgYXQgZmZmZmZmZmZhZTMxYzcxZA0KPiAjMjQgW2ZmZmZh
Y2FiNDVmMTc4ZjhdIHRjcF9zZW5kbXNnX2xvY2tlZCBhdCBmZmZmZmZmZmFlM2NiZTY1DQo+ICMy
NSBbZmZmZmFjYWI0NWYxNzlhMF0gdGNwX3NlbmRtc2cgYXQgZmZmZmZmZmZhZTNjYzhmNw0KPiAj
MjYgW2ZmZmZhY2FiNDVmMTc5YzBdIHNvY2tfc2VuZG1zZyBhdCBmZmZmZmZmZmFlMzE3Y2NlDQo+
ICMyNyBbZmZmZmFjYWI0NWYxNzlkOF0geHNfc2VuZHBhZ2VzIGF0IGZmZmZmZmZmYzA2Nzk3NDEg
W3N1bnJwY10NCj4gIzI4IFtmZmZmYWNhYjQ1ZjE3YWM4XSB4c190Y3Bfc2VuZF9yZXF1ZXN0IGF0
IGZmZmZmZmZmYzA2N2FkYjQNCj4gW3N1bnJwY10NCj4gIzI5IFtmZmZmYWNhYjQ1ZjE3YjIwXSB4
cHJ0X3RyYW5zbWl0IGF0IGZmZmZmZmZmYzA2NzY3NGMgW3N1bnJwY10NCj4gIzMwIFtmZmZmYWNh
YjQ1ZjE3YjkwXSBjYWxsX3RyYW5zbWl0IGF0IGZmZmZmZmZmYzA2NzIwNjQgW3N1bnJwY10NCj4g
IzMxIFtmZmZmYWNhYjQ1ZjE3YmEwXSBfX3JwY19leGVjdXRlIGF0IGZmZmZmZmZmYzA2N2YzNjUg
W3N1bnJwY10NCj4gIzMyIFtmZmZmYWNhYjQ1ZjE3YmY4XSBycGNfcnVuX3Rhc2sgYXQgZmZmZmZm
ZmZjMDY3MzJjNCBbc3VucnBjXQ0KPiAjMzMgW2ZmZmZhY2FiNDVmMTdjMzhdIG5mczRfY2FsbF9z
eW5jX2N1c3RvbSBhdCBmZmZmZmZmZmMwOGU1MGJiDQo+IFtuZnN2NF0NCj4gIzM0IFtmZmZmYWNh
YjQ1ZjE3YzQ4XSBuZnM0X2NhbGxfc3luY19zZXF1ZW5jZSBhdCBmZmZmZmZmZmMwOGU1MTQzIA0K
PiBbbmZzdjRdDQo+ICMzNSBbZmZmZmFjYWI0NWYxN2NiOF0gX25mczRfcHJvY19nZXRhdHRyIGF0
IGZmZmZmZmZmYzA4ZTdmMDggW25mc3Y0XQ0KPiAjMzYgW2ZmZmZhY2FiNDVmMTdkNzhdIG5mczRf
cHJvY19nZXRhdHRyIGF0IGZmZmZmZmZmYzA4ZjIwMGEgW25mc3Y0XQ0KPiAjMzcgW2ZmZmZhY2Fi
NDVmMTdkZThdIF9fbmZzX3JldmFsaWRhdGVfaW5vZGUgYXQgZmZmZmZmZmZjMDg3NDFkNw0KPiBb
bmZzXQ0KPiAjMzggW2ZmZmZhY2FiNDVmMTdlMThdIG5mc19nZXRhdHRyIGF0IGZmZmZmZmZmYzA4
NzQ0NTggW25mc10NCj4gIzM5IFtmZmZmYWNhYjQ1ZjE3ZTYwXSB2ZnNfc3RhdHhfZmQgYXQgZmZm
ZmZmZmZhZGVkZjhhNA0KPiAjNDAgW2ZmZmZhY2FiNDVmMTdlOThdIF9fZG9fc3lzX25ld2ZzdGF0
IGF0IGZmZmZmZmZmYWRlZGZlZGQNCj4gIzQxIFtmZmZmYWNhYjQ1ZjE3ZjM4XSBkb19zeXNjYWxs
XzY0IGF0IGZmZmZmZmZmYWRjMDQxOWINCj4gIzQyIFtmZmZmYWNhYjQ1ZjE3ZjUwXSBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUgYXQgDQo+IGZmZmZmZmZmYWU2MDAwYWQNCj4gwqDCoMKg
wqAgUklQOiAwMDAwN2Y3MjFkZGNkZDM3wqAgUlNQOiAwMDAwN2ZmYzBkNTRjYWI4wqAgUkZMQUdT
OiAwMDAwMDI0Ng0KPiDCoMKgwqDCoCBSQVg6IGZmZmZmZmZmZmZmZmZmZGHCoCBSQlg6IDAwMDA3
ZjcyMWUwOWIzYzDCoCBSQ1g6DQo+IDAwMDA3ZjcyMWRkY2RkMzcNCj4gwqDCoMKgwqAgUkRYOiAw
MDAwN2ZmYzBkNTRjYWMwwqAgUlNJOiAwMDAwN2ZmYzBkNTRjYWMwwqAgUkRJOg0KPiAwMDAwMDAw
MDAwMDAwMDAxDQo+IMKgwqDCoMKgIFJCUDogMDAwMDdmNzIxZTA5ZjZjMMKgwqAgUjg6IDAwMDA3
ZjcyMWY4N2NmMDDCoMKgIFI5Og0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+IMKgwqDCoMKgIFIxMDog
MDAwMDdmZmMwZDU0YTMyYcKgIFIxMTogMDAwMDAwMDAwMDAwMDI0NsKgIFIxMjoNCj4gMDAwMDdm
NzIxZTA5YjNjMA0KPiDCoMKgwqDCoCBSMTM6IDAwMDA1NTYwNmI4MTM3NmXCoCBSMTQ6IDAwMDAw
MDAwMDAwMDAwMTPCoCBSMTU6DQo+IDAwMDA3ZjcyMWUwOWIzYzANCj4gwqDCoMKgwqAgT1JJR19S
QVg6IDAwMDAwMDAwMDAwMDAwMDXCoCBDUzogMDAzM8KgIFNTOiAwMDJiDQo+IA0KPiBCZW4NCj4g
DQoNClBsZWFzZSBqdXN0IHdyYXAgdGhhdCBjYWxsIHRvIF9fcnBjX2V4ZWN1dGUoKSBpbiBycGNf
ZXhlY3V0ZSgpIHdpdGggYQ0KbWVtYWxsb2Nfbm9mc19zYXZlKCkvbWVtYWxsb2Nfbm9mc19yZXN0
b3JlKCkgcGFpci4gVGhhdCBzaG91bGQgY2F1c2UNCnRoZSBtbSBsYXllciB0byBkbyB0aGUgY29y
cmVjdCB0aGluZyBoZXJlLCBhbmQgcHJldmVudCByZS1lbnRyeSBpbnRvDQp0aGUgTkZTIGNvZGUu
DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhh
bW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
