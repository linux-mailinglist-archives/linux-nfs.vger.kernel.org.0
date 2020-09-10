Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC32264B3A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIJR2F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 13:28:05 -0400
Received: from mail-mw2nam10on2105.outbound.protection.outlook.com ([40.107.94.105]:58848
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbgIJRZY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Sep 2020 13:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2dfaU0Br0v/Skcz+PMhY1AzY4qpJkrUTPwCVROJHrkr3Gr4E8ouf1xy59rjiyHBrw6qzkqzWxYGcEm/ZUOTuqFThGQ59xQ7SL7ezBGKhzIkgNMb0MHI2N+/sYyO4OlMruTV+xiQn9MSdbzdu6DDqkgOAuVcMG+683oRwFn3xh3o5PKo+BQFJU/+uhtrHtgaL/oPFalSJHsEt9RUjjUrQDSW8CKVyl5Lnz5YYKKXsGvN1AR24V/ghIJG1j7cCUMwdhrM+CBHVQ5Gzykn2jkMSwiTzst94d/lv7hfz4B+tEKR0xxeBDVv4de9bNnKwK0CXFGkHzIsh9fzIXcL42S08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MT42/CVLUFF+jAT6vJtircU7zWOVlZULncurt7ZBgE=;
 b=n0yAfJ3Bc05Hp1cmuMzSRrCulDsl1DpLe0ltYj3EnXAvTyZSyTAHa848AKrNbrnX46zJxc5D4AtRHTH2KhLF63HhjWc7WfqNPfd7QXdWc89cn4mv9XO43LR6X7/+9zfRuFsAuhfcrYzPLrR/vjkkxzW9RxG3pJt6Fshfg1tBkAm3znX56esF7nvLmo/1ey6G6a02y2W+4UY4rXMMDapp4sFtftZpNjDWNVujyCTTcJtILg586XMJ3SWN+edNoY2b9VfDkpLKYxlqb1IkuIvDBdZPY2YMF5eFqudcDQa4rcdJW/1enLpuT3ipTOXBB67QkO6vFFsso5PsBS5D9F+D1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MT42/CVLUFF+jAT6vJtircU7zWOVlZULncurt7ZBgE=;
 b=OQ5+ParD5Gh63ZqF6lWpkBKCKt3Bmu09Ss4rrWY38Z/9Ysf1rEOxSm/zC9pZe2svdkO1hrO2w+XSxA29pE3DxhcmG3iDn79aQj0N7QfZeXBwqw6bQnGs0gJ6fsZHrV7mwOVgeRHr5Ss30L1d9P64E036vXoAfJ7C7Fkkavza35I=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4102.namprd13.prod.outlook.com (2603:10b6:208:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Thu, 10 Sep
 2020 17:25:19 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 17:25:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: [PATCH] mountd: Ignore transient and non-fatal filesystem errors
 in nfsd_export
Thread-Topic: [PATCH] mountd: Ignore transient and non-fatal filesystem errors
 in nfsd_export
Thread-Index: AQHWhiYeaToKQHGCSECBYXflsj7LOKliG/0AgAAGaoA=
Date:   Thu, 10 Sep 2020 17:25:19 +0000
Message-ID: <5672634521118539d469018df083d4c5a221d330.camel@hammerspace.com>
References: <20200908211958.38741-1-trondmy@kernel.org>
         <20200910170220.GB28793@fieldses.org>
In-Reply-To: <20200910170220.GB28793@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c69551da-6b3a-4351-e8b7-08d855ae7dbe
x-ms-traffictypediagnostic: MN2PR13MB4102:
x-microsoft-antispam-prvs: <MN2PR13MB4102567A49434944CDB75422B8270@MN2PR13MB4102.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w+sCuoOaLxft82sn6lHtoBCqRs/rSQ+9z8b7RLbTe8CHIZzZbSGbHaBi/QNe6I0JL/naIQnSZzRMg8q0L4pRAMWBWsoBbYkY+HH8usJAxbl6QGcTGvcZZ15MLEku5Fjx/heeiC5ZEO0fH4Yf2WnBS1QMStsNqRMj2alVRqE5T8px+/otrXO/dUal/qd/mapV8GraASzN2H47I8cLiViMT/Z4sldygpDcbysWFUBoF/7sHyuYRsVqJtIaVLLLP0JD5p84tGOn8HCi5ng0qttC7E+osQmPMjX3aafPYsb6QA/FrwhdCAlm+i8xdo0TgHj3tdfQRmg4Qr62qLaw4XAmPQIX723cWkaVoCQUu3eQOcbFSvWeiJOApRS2yqlOv0tICIcogI3qxkQYVmuxqQ5REA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(36756003)(86362001)(6916009)(8936002)(71200400001)(66946007)(91956017)(64756008)(66476007)(76116006)(54906003)(66446008)(2906002)(66556008)(2616005)(5660300002)(6512007)(316002)(4326008)(6486002)(26005)(6506007)(8676002)(186003)(15974865002)(478600001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BNu/EoG83fkM4VD6Ly6rO7GgO2IS53yoESSJzqg4GSjhGFW2BLXLyH66cwjHCSK3yxH0odXogFY4sVEqTFzAfjy43hXPtBPMJKCeLrUMSymCc0GwNfhJsuTk8MusyrMhDwfTHEPHoUPajB8fieO8IzUpIsIzkmaYaQ+PY6694drE1Rh84SjYlfMsIdNYIkT7yDFdhjK+7uNp4fxQweiyOLXBWNDCgUdtduvGW8d+cY5nLmWNA7pV2vASZvSz9g4d0dUPpsF2VRnWpwrgn/cyERRLA9yCe2w5wp2rv/jAvJqjeViQ2+4vHZjUIwHJyCeTTO14k17FmNSBRYrHedqBow4/2+/gsRYlXvj+G1ck8DMGXps0IO69DIf1kkbvz6UnwpBik6vrpo/N8GPCHBtHvmBAYWsRuDW7rgju9U0QRyCXwAE00upTNhxL043JbIcE1cwX0YDG8U6G4vX4xTjYenchXFMJ8k+bM7KyhaJP8ndPtoXMlKTmkJm++lbsSCNVo9c1qZet4ijXkU6TbHFoC5/9MTOao0rmRpCtct7hGyqm249CiBjBvvSChGbzA1OhrAG5Dzj0hm76ZG+n8BvBqOVFRl4llsrp1uD27LemjT7MLNd8XRmy7kQCRnsNRu8LVmTpKwE/Lq4IQOOIYxOEWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB04CE44D255004E82AF3E38039CAE46@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69551da-6b3a-4351-e8b7-08d855ae7dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 17:25:19.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3GL4LmHmr5coWvF1hvZ3MFelKcohNQPl31MgJrU3irtnsr+lbyKbrqkSV6CMFQU6t3ExodyX+d6ilW6+LG1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4102
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDEzOjAyIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgU2VwIDA4LCAyMDIwIGF0IDA1OjE5OjU4UE0gLTA0MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZyB3cm90ZToNCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gDQo+ID4gSWYgdGhlIG1vdW50IHBvaW50IGNoZWNrIGlu
IG5mc2RfZXhwb3J0IGZhaWxzIGR1ZSB0byBhIHRyYW5zaWVudA0KPiA+IGVycm9yLA0KPiA+IHRo
ZW4gaWdub3JlIGl0IHRvIGF2b2lkIHNwdXJpb3VzIE5GU0VSUl9TVEFMRSBlcnJvcnMgYmVpbmcg
cmV0dXJuZWQNCj4gPiBieQ0KPiA+IGtuZnNkLg0KPiANCj4gV2hhdCBzb3J0IG9mIHRyYW5zaWVu
dCBlcnJvcnM/DQo+IA0KPiBJIGd1ZXNzIHRoaXMgbWFrZXMgdGhlIHVwY2FsbCAoYW5kIHRoZSBv
cmlnaW5hbCBycGMpIGV2ZW50dWFsbHkgdGltZQ0KPiBvdXQ/DQoNClRoZSBwb2ludCBoZXJlIGlz
IHRoYXQgaXNfbW91bnRwb2ludCgpIGlzIG1ha2luZyB0aGUgYXNzdW1wdGlvbiB0aGF0DQpfYW55
XyBlcnJvciBmcm9tIHN0YXQoKSBjYW4gYmUgdXNlZCB0byBpbmZlciB0aGF0IHRoZXJlIGlzIG5v
dGhpbmcNCm1vdW50ZWQuIEluIHJlYWxpdHksIG9ubHkgYSBzdWJzZXQgb2YgZXJyb3JzIGFsbG93
IGl0IHRvIG1ha2UgdGhhdA0KYXNzdW1wdGlvbiAoc3BlY2lmaWNhbGx5IHRoZSBlcnJvcnMgRUxP
T1AsIEVOQU1FVE9PTE9ORywgRU5PRU5ULCBhbmQNCkVOT1RESVIpLg0KDQpJbiBvdXIgY2FzZSwg
d2UncmUgc2VlaW5nIGEgcHJvYmxlbSB3aGVuIHRoZSB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0gaXMg
YQ0Kc29mdCBtb3VudGVkIE5GU3Y0LjIgY2xpZW50IChpLmUuIHdlJ3JlIHJ1bm5pbmcgb3VyIEhh
bW1lcnNwYWNlIHVzZQ0KY2FzZSBvZiBwcm94eWluZyBORlN2NC4yIHRvIGxlZ2FjeSBORlN2MyBj
bGllbnRzKSBhbmQgdGhhdCBORlM0LjIgbW91bnQNCnRpbWVzIG91dCBkdWUgdG8gYSByZWJvb3Qg
b2YgdGhlIHVuZGVybHlpbmcgc2VydmVyLCBmb3IgaW5zdGFuY2UuDQoNClNvLCB5ZXMsIGluIHRo
YXQgY2FzZSB3ZSB3YW50IHRoZSB1cGNhbGwgdG8gdGltZSBvdXQgaW5zdGVhZCBvZiBwb2tpbmcN
CmtuZnNkIGludG8gZGVjbGFyaW5nIHRoYXQgdGhlIGRpcmVjdG9yeSBpcyBzdGFsZS4NCg0KDQo+
IA0KPiAtLWIuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15a2xlYnVzdCA8dHJvbmQu
bXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiAtLS0NCj4gPiAgdXRpbHMvbW91bnRkL2Nh
Y2hlLmMgfCAxMCArKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3V0aWxzL21vdW50ZC9j
YWNoZS5jIGIvdXRpbHMvbW91bnRkL2NhY2hlLmMNCj4gPiBpbmRleCA2Y2JhMjg4MzAyNmYuLjkz
ZTg2ODM0MWQxNSAxMDA2NDQNCj4gPiAtLS0gYS91dGlscy9tb3VudGQvY2FjaGUuYw0KPiA+ICsr
KyBiL3V0aWxzL21vdW50ZC9jYWNoZS5jDQo+ID4gQEAgLTE0MTEsNyArMTQxMSwxMCBAQCBzdGF0
aWMgdm9pZCBuZnNkX2V4cG9ydChpbnQgZikNCj4gPiAgDQo+ID4gIAkJaWYgKG1wICYmICEqbXAp
DQo+ID4gIAkJCW1wID0gZm91bmQtPm1fZXhwb3J0LmVfcGF0aDsNCj4gPiAtCQlpZiAobXAgJiYg
IWlzX21vdW50cG9pbnQobXApKQ0KPiA+ICsJCWVycm5vID0gMDsNCj4gPiArCQlpZiAobXAgJiYg
IWlzX21vdW50cG9pbnQobXApKSB7DQo+ID4gKwkJCWlmIChlcnJubyAhPSAwICYmICFwYXRoX2xv
b2t1cF9lcnJvcihlcnJubykpDQo+ID4gKwkJCQlnb3RvIG91dDsNCj4gPiAgCQkJLyogRXhwb3J0
cG9pbnQgaXMgbm90IG1vdW50ZWQsIHNvIHRlbGwga2VybmVsDQo+ID4gaXQgaXMNCj4gPiAgCQkJ
ICogbm90IGF2YWlsYWJsZS4NCj4gPiAgCQkJICogVGhpcyB3aWxsIGNhdXNlIGl0IG5vdCB0byBh
cHBlYXIgaW4gdGhlIFY0DQo+ID4gUHNldWRvLXJvb3QNCj4gPiBAQCAtMTQyMCw5ICsxNDIzLDEy
IEBAIHN0YXRpYyB2b2lkIG5mc2RfZXhwb3J0KGludCBmKQ0KPiA+ICAJCQkgKiBBbmQgZmlsZWhh
bmRsZSBmb3IgdGhpcyBtb3VudHBvaW50IGZyb20gYW4NCj4gPiBlYXJsaWVyDQo+ID4gIAkJCSAq
IG1vdW50IHdpbGwgYmxvY2sgaW4gbmZzZC5maCBsb29rdXAuDQo+ID4gIAkJCSAqLw0KPiA+ICsJ
CQl4bG9nKExfV0FSTklORywNCj4gPiArCQkJICAgICAiQ2Fubm90IGV4cG9ydCBwYXRoICclcyc6
IG5vdCBhDQo+ID4gbW91bnRwb2ludCIsDQo+ID4gKwkJCSAgICAgcGF0aCk7DQo+ID4gIAkJCWR1
bXBfdG9fY2FjaGUoZiwgYnVmLCBzaXplb2YoYnVmKSwgZG9tLCBwYXRoLA0KPiA+ICAJCQkJICAg
ICAgTlVMTCwgNjApOw0KPiA+IC0JCWVsc2UgaWYgKGR1bXBfdG9fY2FjaGUoZiwgYnVmLCBzaXpl
b2YoYnVmKSwgZG9tLCBwYXRoLA0KPiA+ICsJCX0gZWxzZSBpZiAoZHVtcF90b19jYWNoZShmLCBi
dWYsIHNpemVvZihidWYpLCBkb20sDQo+ID4gcGF0aCwNCj4gPiAgCQkJCQkgJmZvdW5kLT5tX2V4
cG9ydCwgMCkgPCAwKSB7DQo+ID4gIAkJCXhsb2coTF9XQVJOSU5HLA0KPiA+ICAJCQkgICAgICJD
YW5ub3QgZXhwb3J0ICVzLCBwb3NzaWJseSB1bnN1cHBvcnRlZA0KPiA+IGZpbGVzeXN0ZW0iDQo+
ID4gLS0gDQo+ID4gMi4yNi4yDQotLSANClRyb25kIE15a2xlYnVzdA0KQ1RPLCBIYW1tZXJzcGFj
ZSBJbmMNCjQ5ODQgRWwgQ2FtaW5vIFJlYWwsIFN1aXRlIDIwOA0KTG9zIEFsdG9zLCBDQSA5NDAy
Mg0Kd3d3LmhhbW1lci5zcGFjZQ0KDQo=
