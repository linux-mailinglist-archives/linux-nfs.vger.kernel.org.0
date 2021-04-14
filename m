Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB035F9B9
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhDNRYT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 13:24:19 -0400
Received: from mail-bn7nam10on2123.outbound.protection.outlook.com ([40.107.92.123]:6753
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233864AbhDNRYS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 13:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiSyJW4rB+GvXgvIeh+2YyR3N3bCB9TkvfUyi1I9MCOGE4d8jsJ9ZMa69NBxFCQcbiISd7Aq11gskWcqk+GHyaTrIo3YI17zNrvKDXpV07li7vwnsJa2S6hBz98rilo/HSwy6tGcAhAVh95+a/C2kUObXYItJNrhSkLA+mOOXo7Y+VPPqz5OQ5+tTcWMWnJ/Fhy4PXwf4QpzCfXpJjY8a15+uiEtYa68yLZjpt8J2SWrgGymWNslye/V1p0a8AT70vwSw3y1GKIFTb18+YuYMI+Z075nTxG1Si4540+NE9sQPsBcKwOntGHsEI8WPU3EeyY7FrQ4AY+IleKJbeR7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx/qKsZehme6RzXUcEX12vNXFRlxyH6hG6IHG0bvWrA=;
 b=hM4/16qbgLSDvounEWv4rxzpPNiQf/OUQ6TgjwZ/ILtPP2XjVLkPGteQ0My+FXPejm0IpSBnYqiTTWNTOo+zpzTpoVDoIzzFhNVcE6QLdVus8NfO/iJ7IwWkMcQBMlXfV7DKfpnviVzUQIoEabhTQ3q52UIwE5efRZk2lAtFVBwndDTJdHsurGAIxyvNzxjfcpmeOeOqRYtTsRuW+5VN2M9qZQCSkEyYEkaEuhxZm9qk/XLo7M6cTqefYWtC48ZoMW9ShXGqaSgWpS+ISuNZBNendHmtoyCWMUqCDSumRlWbHdF4mz9iS75c/N0VsOOm5odJ8XkU8mx/eQLGrs1V6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx/qKsZehme6RzXUcEX12vNXFRlxyH6hG6IHG0bvWrA=;
 b=fGsLcMrqn+3drpmjBEkYoZEeYz/QVkAXDx0VUoLIA5hu+sS4OxNa3gpYN/WDqcurRkituhKYS9LjniqNQr7hAIMhWuA/F7Q6Z1Rpm226DeIG6z3cvYclr7fxNJMG4bm8otYRsyES03bkEKgL9t9NR2HudaVfkCWG/kplNkcq3fo=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB4347.namprd13.prod.outlook.com (2603:10b6:5:16a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.10; Wed, 14 Apr
 2021 17:23:53 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4065.006; Wed, 14 Apr 2021
 17:23:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "kolga@netapp.com" <kolga@netapp.com>,
        "bfields@redhat.com" <bfields@redhat.com>
Subject: Re: [PATCH 2/2] NFSv42: Don't force attribute revalidation of the
 copy offload source
Thread-Topic: [PATCH 2/2] NFSv42: Don't force attribute revalidation of the
 copy offload source
Thread-Index: AQHXMTruiEuct/6LkEG0d3KFr5/RFKq0FcmAgAAoc4CAAAUuAA==
Date:   Wed, 14 Apr 2021 17:23:53 +0000
Message-ID: <608b1babd125f72517a5116c4ed1e39e8104ae52.camel@hammerspace.com>
References: <20210414143138.15192-1-trondmy@kernel.org>
         <20210414143138.15192-2-trondmy@kernel.org>
         <20210414144033.GC16800@fieldses.org> <20210414170519.GD16800@fieldses.org>
In-Reply-To: <20210414170519.GD16800@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 748e19a5-7564-405f-29a7-08d8ff6a13d9
x-ms-traffictypediagnostic: DM6PR13MB4347:
x-microsoft-antispam-prvs: <DM6PR13MB43475222FD0F5C0009F5BE3BB84E9@DM6PR13MB4347.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eo9McWVqFm+Sl8nQFoVqy58d0hzUjn+0PPpwP4ws1fG6i0EVmZN/n/Drc2oLipTLw31kW6ElUOw2ho3FLdAJucp4J3vNEm0kiku+eCPVVROhQTGKQY6AB6O4Oz3Z+mz9AkeKMb39f44XUJjcmfAt4p7AwajcmM4yZvacUngiPVFVfxH2d7PnZWI/X3VMJdtcYnwytPt054a6IZHoNqnMRbggrPlZnibxfeIrh/aFM+sZS5ZgFvSyCakWufNpCsE90FL74k5891jfZktOdWZDCI6NC/MRiIAULeSNu480zg6F9SwsVPuHkGrLdIwnpU4+KfuMTTS1NiS2gxJGGT7gvDBlBEwxH/CNJ5/NmNCcnpkyvbL0g9JR+rHCixwwpuWwumleXhrn3pBYKCsfSy6FuVc7tkzCOkPrE+vIdFbHt98ErhwDmyfm6gxv6cKvPAOqR6ZtT40IAPL+PC55JaGWfVIBCY9Y3u17VXDgv/dU5wuoC5bIGBEXOGIr3G6y/AfGAnfnUy8Ao+z/EXQai+bfqdLdGdlr4ItpvaFdvJwbtagsDZhOJYjBlOGr3fptmhs/MH1GTp7rfj+ZZJelLk6KtYELawVOVNIxp3t9AYmyVvo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(396003)(136003)(376002)(346002)(86362001)(8676002)(478600001)(110136005)(6506007)(26005)(8936002)(122000001)(2616005)(4326008)(83380400001)(5660300002)(6486002)(91956017)(2906002)(54906003)(76116006)(186003)(66946007)(316002)(36756003)(71200400001)(66556008)(66446008)(66476007)(64756008)(38100700002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c01EMis3WjRGMzdXblVVeW5JazUvTjZkSmtJVVorN3lWK05iN09HS3NQdzYx?=
 =?utf-8?B?MTMycVgwZitUSE5ScHcvSU5uUE14bFJUM3JzR1ZXVjA3ZnRVTndUb0x2ZVRL?=
 =?utf-8?B?Mk9TNkF4aCs5c2h0R1FSNGdkZmhaSWE4ZmpaZ2tMSDdCeUxDR05oTmhpWGdQ?=
 =?utf-8?B?bDlMZnhkVEV3akQ2Rm55cXdNOW1ady9zZDU4VktaYzR4b1N1bE9IR1BPdmxU?=
 =?utf-8?B?VUxpS1FHTkVzL3B4R1czWUNPY01vMS9KR2xicjJlMVpmMXBkMjRONVZ2aG52?=
 =?utf-8?B?UUJnVWhFNjg2WnFONlJMN1I4T2FVeVNjeVFjVmlyektiaDczdFFQUE5LaTRB?=
 =?utf-8?B?T3hVc0hzWUJqU2thMS8zK3paOXRTeEVIZ1Rrc0oxQzF2YU5JRjF2Qk1saGcx?=
 =?utf-8?B?eCtEOFJTUWt0L2dGZ3ArVDhsOGl1OHJzaG92L0gwYUhxV25HZHgvNkZBWTdT?=
 =?utf-8?B?VE9OdnRROWZGWlEvVVA0ZHduRzMzQytVZ2FLUGkzUnYzMjl1dEVJNG8vNzJV?=
 =?utf-8?B?TlRsK3NSa0s3V094eHl5WGhnY241RXBrMUhJa1l5WVR4MDhyVkFSUS9TeUg0?=
 =?utf-8?B?RExac0VGRnZaL0wyc25XQWtnTjhic3Juc3AvbWRqS3NyRFBFWlhhN1NUV1Nw?=
 =?utf-8?B?ZTVJS0J4OU1UaHh4My9TTG5ocm5ZbEx6V050UzBORmhrcXRPUmJkMnpRaEdD?=
 =?utf-8?B?My9kNHhSVVFxRmRadnN3VDRJYS9IRDdCcVk0YzV6UVRtamVBN09vcDFFQVo5?=
 =?utf-8?B?bkR4RHRlV011WVdtb2Y1N3V6aEE5NE9ZbTBiL2ZTMllSZ3RvY1NyaFdXVmQw?=
 =?utf-8?B?ZlJzaU9zNzIzMC9OK1JRS0E1U2xmNmtmUW1DeDNHZGZIdkhaLzNINHh1VUxp?=
 =?utf-8?B?R3F5MTk4UXpKM0djRHIxRkdMQmhLNVN2SGhQYUxDUkFUcWxEK1lvYXkxVkR4?=
 =?utf-8?B?UVFkWnpqVWYzeE5MK1psV3VBZU4yY2FhMEVGS0VhbTlkUjMvMkxBNkdaTSsz?=
 =?utf-8?B?R3dTZURkQWc5bzQwaDVzaVpUOXBGN0hka1RSdTRSNVV0cFVKeFlWVU5oMlpa?=
 =?utf-8?B?SCt1S2hGOU1LZlBMZzdRdWJWMmVRT2MybWFNcVRocW5pbHp1ajBlbzFNejdJ?=
 =?utf-8?B?V24zbzBsQ2NiUkVFclFRYlR1TUlGLzJ4ZzkwZ3RGbElHMmI2b1BzVjBLR1FL?=
 =?utf-8?B?WitXWE9CQ0FRTkJ5Tnlha2pZbTFRUmNsMHA1Rm96MFRNdTY5c1lZVGFHMEF0?=
 =?utf-8?B?Mnp1K3lTN09yUHRTM01kYnM3emNXQ2hsbG1Lcy81eFl6K0hJNzJhY05qTzQv?=
 =?utf-8?B?Ni9YcUd3NDc4QnAwQUJSMmpJVms4YjlyR0hWQi85eExBRjVicHc0dWxjSVVK?=
 =?utf-8?B?a3YvRTBhSDM5TFhqd1BweTZSRzJ2RlhXRGptaU04dm1EYW9BaDhNVnhHemp0?=
 =?utf-8?B?RGNuOHU4SUZXY1Z1cHpzV1R5RWtGSDBUSUhyOE85SjhocUpoNVc1VWFzeGN2?=
 =?utf-8?B?VTl4MlhxeElhdzlkU0VObFlUQVFqUnA0SUpJeU1jbGxYeXU4RFBqSGx6OUor?=
 =?utf-8?B?amJFbml6cDlvMjQ1dVFoTEMwUzkxU0lLa1FPZUtRazJaTU05UnhLdjYwK2Uw?=
 =?utf-8?B?dmVEWVpSSFEySlBMTVU0Y0l3QzNvdTB3Tm9VZWRPUzBXZitHMWZxdi9HVTVV?=
 =?utf-8?B?d3VFeDA3N0x4Q1hzUHE1RFVuUzdBeTBsN0FiN3FuTWVOQXQ1b2RzSzhhUUh4?=
 =?utf-8?Q?zz9Xa1NuEloPAFzHnS1waWQtGO5ZPf/rtaNfmeJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F737AF5ED95EC94CAECAEF8A80A76746@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748e19a5-7564-405f-29a7-08d8ff6a13d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 17:23:53.6305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2Nt4e/jX0+eE3cisZasQeGo+YX15Fd77iaVxZsVOWnB4Pbtt0NrD9CILv9L0sO7vfAxAlLvrrBihrfhFbzuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4347
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA0LTE0IGF0IDEzOjA1IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFdlZCwgQXByIDE0LCAyMDIxIGF0IDEwOjQwOjMzQU0gLTA0MDAsIGJmaWVsZHMgd3Jv
dGU6DQo+ID4gVGhhbmtzIcKgIFRlc3RpbmcuLi4uDQo+IA0KPiAuLi4gYW5kLCB0ZXN0IHJlc3Vs
dHMgYmFjayB3aXRoIHRoZXNlIHR3byBwYXRjaGVzIGFwcGxpZWQsIGxvb2tzDQo+IGdvb2QhDQoN
ClNvLCBqdXN0IG91dCBvZiBjdXJpb3NpdHkuIFdpdGggd2hpY2ggYmFja2luZyBmaWxlc3lzdGVt
IHdlcmUgeW91DQp0ZXN0aW5nPyBJZiBpdCB3YXMgWEZTLCB0aGVuIG5vdGUgdGhhdCB5b3UgbWF5
IGhhdmUgYmVlbiB0ZXN0aW5nIHRoZQ0KQ0xPTkUgZnVuY3Rpb25hbGl0eSBpbnN0ZWFkIG9mIGNv
cHkgb2ZmbG9hZC4gQXMgeW91IHNhdywgSSBhZGRlZCB0aGUNCnNhbWUgZml4IGZvciBib3RoIGNs
b25lIGFuZCBjb3B5IG9mZmxvYWQgYmVjYXVzZSB0aGV5IGhhdmUgdGhlIHNhbWUNCnJlcXVpcmVt
ZW50cyBmb3IgaG93IHRoZSBwYWdlIGFuZCBhdHRyaWJ1dGUgY2FjaGVzIGFyZSBoYW5kbGVkLCBz
byB0aGUNCmVuZCByZXN1bHQgc2hvdWxkIGJlIHRoZSBzYW1lLiBIb3dldmVyIHRoZSB1bnBhdGNo
ZWQgY29kZSBpcyB2ZXJ5DQpkaWZmZXJlbnQgZm9yIHRoZSB0d28gbWV0aG9kcywgYW5kIGNsb25l
IG1heSBoYXZlIGJlZW4gbWlzc2luZyBtb3JlDQpmdW5jdGlvbmFsaXR5IHRoYW4gdGhlIGFjdHVh
bCBjb3B5LW9mZmxvYWQgd2FzLg0KDQo+IA0KPiAtLWIuDQo+IA0KPiA+IA0KPiA+IC0tYi4NCj4g
PiANCj4gPiBPbiBXZWQsIEFwciAxNCwgMjAyMSBhdCAxMDozMTozOEFNIC0wNDAwLCB0cm9uZG15
QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gDQo+ID4gPiBXaGVuIGEgY29weSBvZmZs
b2FkIGlzIHBlcmZvcm1lZCwgd2UgZG8gbm90IGV4cGVjdCB0aGUgc291cmNlDQo+ID4gPiBmaWxl
IHRvDQo+ID4gPiBjaGFuZ2Ugb3RoZXIgdGhhbiBwZXJoYXBzIHRvIHNlZSB0aGUgYXRpbWUgYmUg
dXBkYXRlZC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGZzL25m
cy9uZnM0MnByb2MuYyB8IDcgKy0tLS0tLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDYgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9mcy9u
ZnMvbmZzNDJwcm9jLmMgYi9mcy9uZnMvbmZzNDJwcm9jLmMNCj4gPiA+IGluZGV4IDM4NzUxMjBl
ZjNlZi4uYTI0MzQ5NTEyZmZlIDEwMDY0NA0KPiA+ID4gLS0tIGEvZnMvbmZzL25mczQycHJvYy5j
DQo+ID4gPiArKysgYi9mcy9uZnMvbmZzNDJwcm9jLmMNCj4gPiA+IEBAIC0zOTAsMTIgKzM5MCw3
IEBAIHN0YXRpYyBzc2l6ZV90IF9uZnM0Ml9wcm9jX2NvcHkoc3RydWN0IGZpbGUNCj4gPiA+ICpz
cmMsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgfQ0KPiA+ID4gwqANCj4gPiA+IMKgwqDCoMKgwqDC
oMKgwqBuZnM0Ml9jb3B5X2Rlc3RfZG9uZShkc3RfaW5vZGUsIHBvc19kc3QsIHJlcy0NCj4gPiA+
ID53cml0ZV9yZXMuY291bnQpOw0KPiA+ID4gLQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgc3Bpbl9s
b2NrKCZzcmNfaW5vZGUtPmlfbG9jayk7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqBuZnNfc2V0X2Nh
Y2hlX2ludmFsaWQoc3JjX2lub2RlLCBORlNfSU5PX1JFVkFMX1BBR0VDQUNIRQ0KPiA+ID4gfA0K
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+IE5GU19J
Tk9fUkVWQUxfRk9SQ0VEIHwNCj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgDQo+ID4gPiBORlNfSU5PX0lOVkFMSURfQVRJTUUpOw0KPiA+ID4gLcKgwqDCoMKgwqDC
oMKgc3Bpbl91bmxvY2soJnNyY19pbm9kZS0+aV9sb2NrKTsNCj4gPiA+ICvCoMKgwqDCoMKgwqDC
oG5mc19pbnZhbGlkYXRlX2F0aW1lKHNyY19pbm9kZSk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
c3RhdHVzID0gcmVzLT53cml0ZV9yZXMuY291bnQ7DQo+ID4gPiDCoG91dDoNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqBpZiAoYXJncy0+c3luYykNCj4gPiA+IC0tIA0KPiA+ID4gMi4zMC4yDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
