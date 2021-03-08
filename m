Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E8331A11
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Mar 2021 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCHWPp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Mar 2021 17:15:45 -0500
Received: from mail-dm6nam11on2113.outbound.protection.outlook.com ([40.107.223.113]:62689
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230327AbhCHWPk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Mar 2021 17:15:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHqQw/cMe1OKVP9DD39W7Cxi/Ii3rF2PVZ5d4xkZxfBq+9LwAmDoJqEiFnfZ/ooots1jQmvabSRrJEA9XwnMMdy+2ld3iIIDZR4co5PRCVU6oGRhGIj8oTgCfI9LRaVx7WwHVqS3ihSSrkj2/PQLtaW9yjIFvNpKmcDvKdRj2XiCrkVAufu5bq5c8+1k8lfAoSwXMal2olgNTtG8dMSQ/tSGic8a5mW3l6HlqOPaxYmL87xcwEddjTs1YllAo9fjkaZzhFjCNgKpIlDk2e+XyhxGn5yb5Fm7iEnXo9UsiALJNHRLqaB1gASYK41yh3y0jmZrMFuRjw8MtaaPEUDXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AC1/p0GX0bRdI20nERpwuDRpeJtD0Vz9SzJJ6FfQq0=;
 b=h9hyW69dOh1+wzndLw6qdoFDptEUDqukNlz1m5JJbd5u4FQLG8rycp33643VHBNTm9k7HaLvvDOdaOHW45+tVSE085IJj6lMyQxkDXOMRMtAwLCnUCZD7BVYBvVpkjh0xuqJMH4f/TnN6sZJxxrKgEE6GbJrr/4GiTTQ6XLz9xm4J/JxBTzmq3xjxLy2ojfOtP2Gc77mnKUDipH+HzUQYCtUIPztdW3pejXnqGuRxLfENr+78ZkWlcUtjNGdQHsWppCRlKjsKbKD9ZUHhpBlIjvvQq71EGZmSS7jN5CKtzUMZImGd/a9p3YOZb27uuu1SO9ntE5PPY2tpcWq+dShUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AC1/p0GX0bRdI20nERpwuDRpeJtD0Vz9SzJJ6FfQq0=;
 b=JSVIVfZ2P8zgRTNk2gZO6Vj5GlMDlldIKDvM82zWf9pXfXM0yfUWIyCnhwfyBlN90i31pfem2Ts5XXi4fQJkT7HeliQ1ZgGVOokBWA6dfY0kJlzkUx9CgBC8gTuk01YaxcqBYDcDowY3IZVqc10zQmBsst0sVlhIy/cYOhTHbXA=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB4475.namprd13.prod.outlook.com (2603:10b6:610:62::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Mon, 8 Mar
 2021 22:15:33 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 22:15:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jbreitman@tildenparkcapital.com" <jbreitman@tildenparkcapital.com>
Subject: Re: NFS Mount Hangs
Thread-Topic: NFS Mount Hangs
Thread-Index: AQHXFEdAEEEnx0TTDkaf/2qq9DT53qp6qIoA
Date:   Mon, 8 Mar 2021 22:15:33 +0000
Message-ID: <2b13577bb30faf3b475d2d602be57aa135023a53.camel@hammerspace.com>
References: <C643BB9C-6B61-4DAC-8CF9-CE04EA7292D0@tildenparkcapital.com>
         <5E3B228F-5CFC-4EDF-B52E-1CDB947ADC00@tildenparkcapital.com>
In-Reply-To: <5E3B228F-5CFC-4EDF-B52E-1CDB947ADC00@tildenparkcapital.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [50.124.244.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17d2b44c-51a8-484b-7cab-08d8e27fb13a
x-ms-traffictypediagnostic: CH2PR13MB4475:
x-microsoft-antispam-prvs: <CH2PR13MB4475F7491DCDD08211586579B8939@CH2PR13MB4475.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xSh71gbQYGLElD5NGEdlkfoPdlMbSjbj7DEa6lnCNwdQsac0zOhkcoHdWJqsNuGQic5fbCMKqhk+y53pZjUATVq8NoPwAWfYkb2SRZnL9gbdpCuhSw/oXfUNQqeNlP2H4LCPMxofDoumII9bBjIkpfqhLBVOiF5zr51021VB8IHh2xAAwRxIK6pU9pwYeyJJeag5VXWh9ajCmtb7tr+KV4pmhmnvgg9ayLx5/jOpf5uW87c+KXkGDZtys+qpFbx0lK21wdP/nbv+ehbIXxHL2w0IaDkiQY6i+j7EACM/zjE0GNEYPDpXgdGNKV/lwrYwncAvoQrXzkGMRxcxQsYZeEnSItuJyBz6YqxzW+skdD61dAweDxIX0LXN6YVJExGQk3jxgduOJC/QHn2IFGGMYYLSIgwPBlKCXwDgyxCG99W6/oOmbHt3ehXY+sa2PSqQqI7QoZ2HN8no2rT4E5p1kf/APMzzXB9wjmlA/S8DpmVYc0BBgPTiZWvF8bmxUTAS9n0336lNBNGuiZ/vvMljhRCJnBkEGdsG3tDRm3wqZ0nozT8XIfBLUgDJIM3dYgz+Zik6gpM86YPG+nDlruWFHcsoMYSt2ibQoMZffM9qa9A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(366004)(396003)(346002)(376002)(66946007)(2906002)(6506007)(7116003)(71200400001)(6486002)(5660300002)(26005)(316002)(2616005)(110136005)(186003)(36756003)(3480700007)(66476007)(6512007)(66556008)(966005)(66446008)(83380400001)(8676002)(64756008)(76116006)(86362001)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UXJoU0FZZDBSMmhLVkFxSTQ4S3BNOHZRUVM1cmZNZ3FTNkRPNnBrNEZhU3FY?=
 =?utf-8?B?czFIR1loQzBJZU5iZVQ4VjhRc0twZ0tSR05CeElkY2V6aEN2azRVTW5md1Aw?=
 =?utf-8?B?a1h3VG04ZU1uaEhsQlBacTRRWWRJMFVHWmcycndyaWt2V0ZTaE55TjZaUVVV?=
 =?utf-8?B?K043blFxeTZXNDNvbHltWUNQRE55dG1YVWxGNm9QbFdtSkV5amp4SC9KamtV?=
 =?utf-8?B?TkordTZvNFFIalM4TFJ1cnZQTnFqUXhuSCtrNDhiaWNzcFA1OFhTT1FMbklu?=
 =?utf-8?B?SnhCenNmNVozYXcwNmFxbE9leWlvV1MwY2EyK2FESUlYQ0hPTTlGdkc5N3Bl?=
 =?utf-8?B?TG5pY2h5NzdLMk5yQ0NuSC90SmIvUm1LRjhDakNweFZVOXBWblo2RXQ4SmdJ?=
 =?utf-8?B?OVhPNklZUnhXZkF3djVLWkdUU2Q3SFVIL0RYdFBXRU5FU1c2VmpCTFFjY0JL?=
 =?utf-8?B?Qjg0ODRxWGRJeUY4N1RvUmpjV3dHS1plN1ZqOWhyMUJUVkRCM0EybGRBaVVS?=
 =?utf-8?B?Z3o4MkZjZGxEallwcHVMZFVZT1B2blBuNWNTbjlhZ2swOHFqMDgzRUdBRjcz?=
 =?utf-8?B?ZXc2alNOTmFYUnovcmtVMDFUSWVxY2pIcmZlSXpVYnJ4ckVPSE5acnVKL2Q0?=
 =?utf-8?B?YW9JU3lSdk5OYmFob1VicWZCSXNnZ2tPSnU0L2NMU3lzUHVrN0RESytkQUMr?=
 =?utf-8?B?bVhsZlcxdlVaWW5PUWdiSTQ1Wmc0cXZ1UmFFVWd4SEw0QVUwVTVnWnJVZy9m?=
 =?utf-8?B?Tk5xL25MaUtheVB6bzdaTWRHWFZacDBsS0hyaHVVNURLdm5ZSC9kZjJTQWxI?=
 =?utf-8?B?V0xEU2JmZHJxQ0RUQmdyRWQ5VGJMdWY0Ymd1eE9uWEhzaE9LVjVUdEE0NElP?=
 =?utf-8?B?WFcxM3VCRDM3K2k5TzNRQjlyQkpEdzhwaGFqUTlFWUpQRmNEWEtVc1d4dGt2?=
 =?utf-8?B?WmlyZ3dDdDdRTWsxUHo0ck5HMC9YdVA3VGlEeGZxMzQ5NFZ0clorNkVvNVg4?=
 =?utf-8?B?SkpNbnY2eStsRlNFMnE0VXBRU0FyNDR6d25jTDJ1NWN4SjkrMmV5aEpjdEo4?=
 =?utf-8?B?eTFYT0QvS3hGMzUyMlRDK0d1dG9sK3ZOdVVFUVBaeWNDWmp1VEtyWVpDTndI?=
 =?utf-8?B?VVdkSE5pVXVhb2o2WSs1dU9LdUVhUUpFcTVmdS9qcEVGUU1NNEh2R2V6RlNZ?=
 =?utf-8?B?d1ZDQjdUV0dyTlFUNlJ4aU5rTmJ2d0xtcE9VZXJxVDJ3RDU2N2prUUMvbUN0?=
 =?utf-8?B?ZFNPakFPUm45TDBvaC9tc0xKL3pQc2Z4dU83QUU4K252cVV4akpIcjBybDhm?=
 =?utf-8?B?aWhhSWloTjRrY3BWRE5zNjBxMWJvYXY3ZDJxdjFZUWxvNkovczNDdFlhbXhF?=
 =?utf-8?B?dzk4bXBRZ1lONWtSejFTOG90S05RSzhSZFNGaUxJYjVYNUZObFB1dGdmTkcv?=
 =?utf-8?B?ZkJNQ3I0ekNIdldqUFgydjlWYks1NHNZanNCVGI2ek9JUWl0SGFwdkhxalJJ?=
 =?utf-8?B?Sjl0RWI2YjVDd1ZVOEIvQ0VGTEllZ0pwelRTNWxxbzcrMnJmckhwenkxU3BQ?=
 =?utf-8?B?Vk53TGtBaWFZRGV2VkxFMWZCbG1FSkhWdTE3VHVDT25yZjRjNHB6bmFoek9R?=
 =?utf-8?B?ZFVDQndXclQ5aVNzUHZBTjhNbWppME1WNzZxKy9LcWMzRnFwRHlxcXdRK25R?=
 =?utf-8?B?SzFIc29YMHlhemJ4bEpKZzZUbjZ0Smd1K2dJRUVxNEIvZWV2a0U5c1RzbGhT?=
 =?utf-8?B?c2JROVZQWVRlM2xrcXVYNVIyQ2ljMDY5a2dmRnZ6bXNlUUZmSW9mczVZdklh?=
 =?utf-8?B?MXYxQzJhQTVtYktKNzRHQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <240F84187ABA334A8015B2E39B9EAB31@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d2b44c-51a8-484b-7cab-08d8e27fb13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 22:15:33.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxQA3KJ+OloOhyejUZ4i6DmTPx0AwDA+Lsc2z5xVY9oSxo6eZElmvKNrsNKTrCKnrOsRUe+DCQNxMj9lLkcWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4475
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTA4IGF0IDEzOjE2IC0wNTAwLCBKYXNvbiBCcmVpdG1hbiB3cm90ZToN
Cj4gSXNzdWUNCj4gTkZTdjQgbW91bnRzIHBlcmlvZGljYWxseSBoYW5nIG9uIHRoZSBORlMgQ2xp
ZW50Lg0KPiANCj4gRHVyaW5nIHRoaXMgdGltZSwgaXQgaXMgcG9zc2libGUgdG8gbWFudWFsbHkg
bW91bnQgZnJvbSBhbm90aGVyIE5GUw0KPiBTZXJ2ZXIgb24gdGhlIE5GUyBDbGllbnQgaGF2aW5n
IGlzc3Vlcy4NCj4gQWxzbywgb3RoZXIgTkZTIENsaWVudHMgYXJlIHN1Y2Nlc3NmdWxseSBtb3Vu
dGluZyBmcm9tIHRoZSBORlMgU2VydmVyDQo+IGluIHF1ZXN0aW9uLg0KPiBSZWJvb3RpbmcgdGhl
IE5GUyBDbGllbnQgYXBwZWFycyB0byBiZSB0aGUgb25seSBzb2x1dGlvbi4NCj4gDQo+IEkgYmVs
aWV2ZSB0aGlzIGlzc3VlIGhhcyBiZWVuIGRpc2N1c3NlZCBpbiB0aGUgcGFzdCBzbyBJIGluY2x1
ZGVkIGFuDQo+IGFydGljbGUgdGhhdCBtYXRjaGVkIG15IHN5bXB0b21zLg0KPiBJIGRvIG5vdCBz
ZWUgYSBjYXNlIHN0YXRlbWVudCBmb3IgRklOX1dBSVQyIGF0DQo+IGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y0LjE5LjE3MS9zb3VyY2UvbmV0L3N1bnJwYy94cHJ0c29jay5jDQo+
IC4NCj4gDQo+IE5GUyBDbGllbnQNCj4gT1M6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBEZWJp
YW4gQnVzdGVyIDEwLjgNCj4gS2VybmVsOsKgNC4xOS4xNzEtMg0KPiBQcm90b2NvbDrCoMKgwqDC
oMKgwqDCoE5GU3Y0IHdpdGggS2VyYmVyb3MgU2VjdXJpdHkNCj4gTW91bnQgT3B0aW9uczrCoMKg
bmZzLQ0KPiBzZXJ2ZXIuZG9tYWluLmNvbTovZGF0YcKgwqDCoMKgwqAvbW50L2RhdGHCoMKgwqDC
oMKgwqDCoG5mczTCoMKgwqDCoGxvb2t1cGNhY2hlPXBvcyxuDQo+IG9yZXN2cG9ydCxzZWM9a3Ji
NSxoYXJkLHJzaXplPTEwNDg1NzYsd3NpemU9MTA0ODU3NsKgwqDCoMKgMDANCj4gDQo+IE91dHB1
dCBmcm9tIHRoZSBORlMgQ2xpZW50IHdoZW4gdGhlIGlzc3VlIG9jY3Vycw0KPiAjIG5ldHN0YXQg
LWFuIHwgZ3JlcCBORlMuU2VydmVyLklQLlgNCj4gdGNwwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKg
wqAgMCBORlMuQ2xpZW50LklQLlg6NDY4OTbCoMKgwqDCoMKgDQo+IE5GUy5TZXJ2ZXIuSVAuWDoy
MDQ5wqDCoMKgwqDCoMKgIEZJTl9XQUlUMg0KPiANCg0KWW91ciBjbGllbnQgaGFzIGNsb3NlZCB0
aGUgY29ubmVjdGlvbiwgYW5kIGlzIHdhaXRpbmcgZm9yIHRoZSBzZXJ2ZXIgdG8NCmNsb3NlIHRo
ZSBjb25uZWN0aW9uIG9uIGl0cyBzaWRlLg0KDQpJJ2Qgc3VnZ2VzdCB1c2luZyBhIG5ld2VyIGtl
cm5lbCwgb3IgZWxzZSBnZXR0aW5nIHNvbWVvbmUgaW4gdGhlIERlYmlhbg0KcHJvamVjdCB0byBm
aXggdGhlaXJzLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
