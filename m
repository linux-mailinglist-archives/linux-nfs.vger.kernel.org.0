Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4293A2D21
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhFJNg1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 09:36:27 -0400
Received: from mail-bn8nam08on2119.outbound.protection.outlook.com ([40.107.100.119]:4960
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230435AbhFJNgZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Jun 2021 09:36:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNODdh7vZQdVNPD2PPyyDKeG1jvowhgklkmXmxPnSyuG2pMKWdp1bMdVHZj4UFAi9/d3xDLKa0hCrno8om3N5PtBwX3LW1MwYnicXw+ilPQuyyWKFsjIMIfEjtRiIzL3zDrY8XosRhz27zuYC/YiXSfRFdL2EHnWIm1svt0EpxXBG9tbSF2V4dhzSnCsZEtUoaqccX2iMPztIeDbMukzoXYdPscTJ6SVtGB02LkA0gDtL8lscRrdw86usB6/Kwt7COtZjBL46Zcutkmt6n6Xe25Q8sFhqOcGP0HyRSCPIsUhhcv7o+fzV8jGPLtbjCsIt8Tg4hnU6NvJXVYKU90Svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiiK2ZEBoVI5Z6ekn1fs7LDjfgIUeVi+kJPMtkz8oDk=;
 b=UxTH+RwkHZ0sRgCPO1hvkl2fF/kYUGA4DDKt1Z2bNMZC+wIrbadMLcgbdAz0HkFfslh/nvg31ilHSEVYBC1W11jNojTHY/IL5V8S2T9weXMfUcwKZroFA+mQAYRY7YsbXKYGjU8UAs32FJEV1Fxrja6QcDwot3n5T2zNyMVxbyqDKZDj9S2uIFheTdUqxD4brgDRDG7sCWojtrIFGxerpPIX2ebWgw26WRX0cKV/OBJW328ZaOCs1S9tghcLbgyCqSiY2oJTntarVSv/YvoOXpi7XPz7mIBMunJGZYWJgevynwQOEmQNTyQcO8LjFHzRoCYoXufMyHxQlKzQlPO6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiiK2ZEBoVI5Z6ekn1fs7LDjfgIUeVi+kJPMtkz8oDk=;
 b=UfFYvgA2SIgO/2Mdyd6OBKapKNc1igyv8m5LvT7bqHA4+xfENhXh2iVVlH51dC8/FUcg5R9cyGV0xIoZaUdilWur5oRBkbDwrz6l40fhAOYdD5h2szocCo4WNschcWCDPpm/bbPptMX3vhk2+SBli0Ir2wxLWXWJFhTcgqKU3MM=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB0921.namprd13.prod.outlook.com (2603:10b6:3:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.17; Thu, 10 Jun
 2021 13:34:23 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.012; Thu, 10 Jun 2021
 13:34:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXnh3WIMdJRfJ0KF+q50bEsARasNPoYAgAABKgA=
Date:   Thu, 10 Jun 2021 13:34:23 +0000
Message-ID: <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
         <20210609215319.5518-3-olga.kornievskaia@gmail.com>
         <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
In-Reply-To: <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37374733-79fe-4c70-c951-08d92c1475bc
x-ms-traffictypediagnostic: DM5PR13MB0921:
x-microsoft-antispam-prvs: <DM5PR13MB092101CF170D32C097FE0DBEB8359@DM5PR13MB0921.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vw0aMKmqP25TWYeBaQl7CFI9xhb8h0Zki9jVav3S6xl2Ep70KhWecDpmO0ZNXGNZaUuEDzDH5Shtnq370614xOpMltahMrxQH3N3cEn1j8OjRQFmDjH7IF8rdz1Qu5XYM5KUi27FH+yUsODaqLa50TqZ0kMumXS7txNkdADYotD8nHxTC0fU21gJYRiIZScni+ClFDgnC1P6EpI+NGqwRv8ouNmuuZCKfocK7PLG0rjH3C6YB+91qW5woYL7KQycm3AG9QK4xeLU5lScakLlpMJczVT9SkOZs8Nn+mZfxOLH782mzDFqMb3438crBTvtXYlpMKP4+27IG7QL8ZYgnSmQi2fSEVw6PBAC/a9thNMKpYB0y+ol6z49dQCr3U1ULh7wBfqEnP/oLLkZhKz3U9WSWPjXLl4sGDqcmte5m4Z9+xYUWz/TAPGcYr7Bv7KUPwr9ebNQibBq1YYwfYz4SibKr+Gvo9IE5rQIwvs4sOYes5DHMYm0h/hrvdAdy+B2mgpgZQaPhgve1ycf2ai8wJRB/YD7SzAkpMi35gTOZP51/iv/w0y75ezCXcp0ygzcj3DJLyomkQTVye5HJRGX7u+MYF43gY2Gp8zxt3fBK8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39830400003)(136003)(366004)(66446008)(53546011)(71200400001)(76116006)(8676002)(6506007)(2616005)(38100700002)(122000001)(66946007)(5660300002)(8936002)(4326008)(6486002)(26005)(2906002)(6512007)(36756003)(66556008)(64756008)(186003)(83380400001)(316002)(91956017)(54906003)(86362001)(478600001)(110136005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjZxTUJsdW1zVFFIUnRCOXg2Rm1jM0dvKzR1NWU1czBodmpNdHY4SDllaldy?=
 =?utf-8?B?Q0VoYXFrbk1RbFhzYnpDVnJSZFFxUENITkpKSTJoeVo2bzNUNEdDTWN3WjVO?=
 =?utf-8?B?R2loV25JTTU4THlIT2REMDl1aVRVRlVIakw0QkhVbkV2d3UreDU4V0ZlZHg3?=
 =?utf-8?B?dHpzcTlSZmNYeE1DNW9pYWZ5TjVzT3FEbWRCWWdRdEZuNlowaEdCcmMvdlIr?=
 =?utf-8?B?T1g4TW1DMG9oYnkyaTgwWmpiWkpibnVxM1hUUHIvdkpBS1VHb2xQeWQ4NEJX?=
 =?utf-8?B?SmhvWWtRZ0J2cXBlbWZpNy83NWJXSGdCYnVzSXlxT2g0bG1VNVdOS0NtSkRW?=
 =?utf-8?B?YUpFL2JqMTY1cmRmczFsaEttN1lRUzNmQU5Cc2Q1RnliQW1qNXhhWG84MGpr?=
 =?utf-8?B?c2dLMlJac0JlaHRIV0pFS1Z5NXNGMkhLNHEwNkNYSDRoR0hQT3lNejV4RTFR?=
 =?utf-8?B?eWxiN2x6dkRXUmVNRWQ3SlZFQUpGRXRHN1RKMDRBZm1zdDJqNTNENlQ0dGkw?=
 =?utf-8?B?NG9jMm9OVkFsWG5oNEd6ZnNVSU9wejI4NGVkZGRqQlk1VDl3U1VLMjg3U3Z5?=
 =?utf-8?B?ZkwyVXdxWUw2L2ZuaktJb1dzM2YzMUNOYVhUOHRXRXZKV0x4bnpwL3ZMeEMy?=
 =?utf-8?B?TWpBbnJiZ0VpdmtaN1NFcHVKdTZYS2ZZS3lhdGRQcVFYLzU3N2FuamNTZnlt?=
 =?utf-8?B?c1d1ZXExbFlLalNYS3pnUXZPVHNueU4welZBMWhtSTFDYkpkMGlMdkZPVW9C?=
 =?utf-8?B?N2h5V1RDYW8zWVIvWHNRTCtDRFFjaVdWQTI1RUNmZXlHNEw3a0VpazhJNE5W?=
 =?utf-8?B?cVhGdXVRK3hwSitxZGdLNzlTN2JEWXlaYnFsdURxYkQxVW5KRSs3aTR4K1pw?=
 =?utf-8?B?emhCLzlLRUxlWjdsSzBHdFZKd01yZXpDa21VK01odTlTdVpwQkk0dVdOcWtI?=
 =?utf-8?B?S3N1d2dOYzIwNFRJTDJwczBLcEY2Y2JDRWdsMm55R2J5TkdoQUw3MGVkUW9M?=
 =?utf-8?B?KzcvRjBlYm1sc3M5R25EWWFqendhSjJleGUwL3dWVVJ1RDJJRWhlZ3dDc0Fa?=
 =?utf-8?B?VzhCT2FzOE1GWXBkV0UwTGcwOVRYQWNFTWJJTDh4aXZBVnZVT3JGZkRHNytt?=
 =?utf-8?B?L0E2RW0wS0U5NkpSTzFFUEtvU2RDWTN0SDZrWkNRMnhBT0N1QVpyckdscUhN?=
 =?utf-8?B?VGJzVG1oRGtTMXI0WEpIQmw1Nm0yV0s1Zk96cXAwN1EvVlF6MGNScE5GdUhE?=
 =?utf-8?B?eFFXT1Rmdi9mY2J1bEprZ2RaRHJXeVBzREFxYkp3WDhsQldVS1d2c0NNT0hY?=
 =?utf-8?B?V2lBOGJWaGFzL1lVWWJlZ3R0YWliSHhnRGpINGJlckRXeVBHM2FHUXR6SFRt?=
 =?utf-8?B?VGliU29ZV01neDQ5RHAyQ0t3aDNCa204TkpQa0wwa01BREJHbFV0Vjh2RGl4?=
 =?utf-8?B?MkVvOVZMVGZKbzZmTUhyQmZ5Umh1RkE5UlBRMGpORFdQem5WM1Rnd3NiWXpQ?=
 =?utf-8?B?NVB5ajJMbkVlZUwzT2tBbE1iM3BVUlNBUkxiS05tSU1IZGlPZ2lWckNGSEI0?=
 =?utf-8?B?VXNhdUVwalgzWU4vcVd2UXRUNE5GSFdOK2wvbFZiNXVva21EUDFrRG1hSVRK?=
 =?utf-8?B?Y3g3Sk1yRUsxbm10M1ZGa2VQWVBCbmxsOE1HdzRWM05XZGtUM0RUd0V6UEpr?=
 =?utf-8?B?WGY5V2M0YjV2R0pmcTdXK05MMzVUNFJlQUxlZk9xT2hOWnpwMlZreFJuTDY1?=
 =?utf-8?Q?e1EWA8eliThqWaSoluv7cDB+vbr0xREC6NSH00/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC4B053403FC3E47BA236C2A4AD1F138@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37374733-79fe-4c70-c951-08d92c1475bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 13:34:23.3550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4cNsCGF7NaLePCZnOhGmOxNECu/yaKYR8zvN6YxJMDXMTjn+WRkKi0EX0frwPzvbLVHsnh8r7RKgd76IHAGSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0921
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTEwIGF0IDEzOjMwICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6
DQo+IA0KPiANCj4gPiBPbiBKdW4gOSwgMjAyMSwgYXQgNTo1MyBQTSwgT2xnYSBLb3JuaWV2c2th
aWEgPCANCj4gPiBvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+IA0KPiA+IFRo
aXMgb3B0aW9uIHdpbGwgY29udHJvbCB1cCB0byBob3cgbWFueSB4cHJ0cyBjYW4gdGhlIGNsaWVu
dA0KPiA+IGVzdGFibGlzaCB0byB0aGUgc2VydmVyLiBUaGlzIHBhdGNoIHBhcnNlcyB0aGUgdmFs
dWUgYW5kIHNldHMNCj4gPiB1cCBzdHJ1Y3R1cmVzIHRoYXQga2VlcCB0cmFjayBvZiBtYXhfY29u
bmVjdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FA
bmV0YXBwLmNvbT4NCj4gPiAtLS0NCj4gPiBmcy9uZnMvY2xpZW50LmPCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgMSArDQo+ID4gZnMvbmZzL2ZzX2NvbnRleHQuY8KgwqDCoMKgwqDCoCB8wqAgOCAr
KysrKysrKw0KPiA+IGZzL25mcy9pbnRlcm5hbC5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArKw0K
PiA+IGZzL25mcy9uZnM0Y2xpZW50LmPCoMKgwqDCoMKgwqAgfCAxMiArKysrKysrKysrLS0NCj4g
PiBmcy9uZnMvc3VwZXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKysNCj4gPiBpbmNs
dWRlL2xpbnV4L25mc19mc19zYi5oIHzCoCAxICsNCj4gPiA2IGZpbGVzIGNoYW5nZWQsIDI0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9jbGllbnQuYyBiL2ZzL25mcy9jbGllbnQuYw0KPiA+IGluZGV4IDMzMGY2NTcyN2M0NS4uNDg2
ZGVjNTk5NzJiIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9jbGllbnQuYw0KPiA+ICsrKyBiL2Zz
L25mcy9jbGllbnQuYw0KPiA+IEBAIC0xNzksNiArMTc5LDcgQEAgc3RydWN0IG5mc19jbGllbnQg
Km5mc19hbGxvY19jbGllbnQoY29uc3QNCj4gPiBzdHJ1Y3QgbmZzX2NsaWVudF9pbml0ZGF0YSAq
Y2xfaW5pdCkNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgY2xwLT5jbF9wcm90byA9IGNsX2lu
aXQtPnByb3RvOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBjbHAtPmNsX25jb25uZWN0ID0gY2xfaW5p
dC0+bmNvbm5lY3Q7DQo+ID4gK8KgwqDCoMKgwqDCoMKgY2xwLT5jbF9tYXhfY29ubmVjdCA9IGNs
X2luaXQtPm1heF9jb25uZWN0ID8gY2xfaW5pdC0NCj4gPiA+bWF4X2Nvbm5lY3QgOiAxOw0KPiAN
Cj4gU28sIDEgaXMgdGhlIGRlZmF1bHQgc2V0dGluZywgbWVhbmluZyB0aGUgImFkZCBhbm90aGVy
IHRyYW5zcG9ydCINCj4gZmFjaWxpdHkgaXMgZGlzYWJsZWQgYnkgZGVmYXVsdC4gV291bGQgaXQg
YmUgbGVzcyBzdXJwcmlzaW5nIGZvcg0KPiBhbiBhZG1pbiB0byBhbGxvdyBzb21lIGV4dHJhIGNv
bm5lY3Rpb25zIGJ5IGRlZmF1bHQ/DQo+IA0KPiANCj4gPiDCoMKgwqDCoMKgwqDCoMKgY2xwLT5j
bF9uZXQgPSBnZXRfbmV0KGNsX2luaXQtPm5ldCk7DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqDC
oGNscC0+Y2xfcHJpbmNpcGFsID0gIioiOw0KPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvZnNfY29u
dGV4dC5jIGIvZnMvbmZzL2ZzX2NvbnRleHQuYw0KPiA+IGluZGV4IGQ5NWM5YTM5YmM3MC4uY2Zi
ZmY3MDk4ZjhlIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gPiArKysg
Yi9mcy9uZnMvZnNfY29udGV4dC5jDQo+ID4gQEAgLTI5LDYgKzI5LDcgQEANCj4gPiAjZW5kaWYN
Cj4gPiANCj4gPiAjZGVmaW5lIE5GU19NQVhfQ09OTkVDVElPTlMgMTYNCj4gPiArI2RlZmluZSBO
RlNfTUFYX1RSQU5TUE9SVFMgMTI4DQo+IA0KPiBUaGlzIG1heGltdW0gc2VlbXMgZXhjZXNzaXZl
Li4uIGFnYWluLCB0aGVyZSBhcmUgZGltaW5pc2hpbmcNCj4gcmV0dXJucyB0byBhZGRpbmcgbW9y
ZSBjb25uZWN0aW9ucyB0byB0aGUgc2FtZSBzZXJ2ZXIuIHdoYXQncw0KPiB3cm9uZyB3aXRoIHJl
LXVzaW5nIE5GU19NQVhfQ09OTkVDVElPTlMgZm9yIHRoZSBtYXhpbXVtPw0KPiANCj4gQXMgYWx3
YXlzLCBJJ20gYSBsaXR0bGUgcXVlYXN5IGFib3V0IGFkZGluZyB5ZXQgYW5vdGhlciBtb3VudA0K
PiBvcHRpb24uIEFyZSB0aGVyZSByZWFsIHVzZSBjYXNlcyB3aGVyZSBhIHdob2xlLWNsaWVudCBz
ZXR0aW5nDQo+IChsaWtlIGEgc3lzZnMgYXR0cmlidXRlKSB3b3VsZCBiZSBpbmFkZXF1YXRlPyBJ
cyB0aGVyZSBhIHdheQ0KPiB0aGUgY2xpZW50IGNvdWxkIGZpZ3VyZSBvdXQgYSByZWFzb25hYmxl
IG1heGltdW0gd2l0aG91dCBhDQo+IGh1bWFuIGludGVydmVudGlvbiwgc2F5LCBieSBjb3VudGlu
ZyB0aGUgbnVtYmVyIG9mIE5JQ3Mgb24NCj4gdGhlIHN5c3RlbT8NCg0KT2gsIGhlbGwgbm8hIFdl
J3JlIG5vdCB0eWluZyBhbnl0aGluZyB0byB0aGUgbnVtYmVyIG9mIE5JQ3MuLi4NCg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
