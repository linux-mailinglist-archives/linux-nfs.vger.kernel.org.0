Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D872B0D6A
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 20:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKLTEc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 14:04:32 -0500
Received: from mail-mw2nam12on2139.outbound.protection.outlook.com ([40.107.244.139]:55529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgKLTEb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Nov 2020 14:04:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMqhU/fctrVmtBn4NrykRnO09PYSMCTO1T/K8Pni/cFpTl9CNuUBwSiofwXU+oMxV73lHASldsI9wEYCoBvITZnaC2/oBzGweQL5FewJNVUgYSiiWLycRdLdAxmdpAD/AjSTXWsF4M94ZMIbGB2x7N2sdw9IpyCKNDLuJZXB048zHFzrrtxcXkfncLXDHGjS8kP485hMBCyuW7OQECCJXqFjQvS8twZAG/vOlps/im8ExkpHtYXrT3KFikDvuC+cGqz7TzcYzQcWGDJoHXL2atCKqDB6LqhORVdfRqDOCbtCx0xn2mGq5Lpvr70cOhxQ9kQl9eBFyr8BE6+s6Fp/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbXlfJxsAKLBNJrykK2xMLoHnQeaT/lPOmCvX87XIxg=;
 b=FUhIfig60Nv70JyJuetTCI921mJwH6K9Tx/g/g0u4++aHYM3VSmyCeD24I7AjNPfa2eAGU7FTdYuwrWsO3A8VpwZ6kpX6I9q9tJNvPpVUtgVnr7I1/X61+YFBw2xZ/5ef3sIV6SiXH552mT+6d7BU/1bnEIaLbf20DHD0UVFWAaeJTuszZjy7d4/QnY5r0vTqnUgCCfkPANOMGqT8aY2al7e3AJmqRnuUdafptoudPLfXKd38KS0xweVxorrE3jFz8beFysC3QKKrT2fxNdzGgWM/YW+nrQKlelWIdjGxOxXO9ilFHIHHPlqEzdyTyMqk/OHX6J3nhvan4e+xAhlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbXlfJxsAKLBNJrykK2xMLoHnQeaT/lPOmCvX87XIxg=;
 b=czg36bT8ZQKKExWYMLFcWcFPHLzxzsKGoLJb8rZyWq2e/Xdz6Kq+3k5Jqs39LAU7nmnBSbNJerV7B+fFJUnI2IR9QcfbkquERlyKdBQDpov2ehMKUwEvlJtU90QP69Ves4iynqrcIYLCks7LQCILxTsku8rynARDK22IbCZ5+yg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3376.namprd13.prod.outlook.com (2603:10b6:208:167::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13; Thu, 12 Nov
 2020 19:04:28 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Thu, 12 Nov 2020
 19:04:28 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: [PATCH v5 00/22] Readdir enhancements
Thread-Topic: [PATCH v5 00/22] Readdir enhancements
Thread-Index: AQHWt6smlycN3byFeUCu4hbFFYYhUqnDgPIAgADhS4CAAFZvgIAAGp0AgAADjoCAAAcaAA==
Date:   Thu, 12 Nov 2020 19:04:27 +0000
Message-ID: <6eed4c13be095a979b31b98668bf64f60ad0be51.camel@hammerspace.com>
References: <20201110213741.860745-1-trondmy@kernel.org>
         <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
         <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
         <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com>
         <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
         <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com>
In-Reply-To: <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2db4fa9c-3b80-428d-81a3-08d8873dc758
x-ms-traffictypediagnostic: MN2PR13MB3376:
x-microsoft-antispam-prvs: <MN2PR13MB3376037BC2C0728599AA66F3B8E70@MN2PR13MB3376.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQd7681/27FmiUbwMPlK+VNYP+lXN4Tlo4zNlh3y8epMw6zw6k19+QhaMhdE6E9YInER925FYfj+N7r8jpuOZ103aqmsMbX/KrwXE7MZl+A1On3l5ocmlBT1EOHZHkATuy0t8uDpaJBXOkWFaitjAbtvgZfcU5ZKNLWufuUxXBj0tnw/u3q5VB4TP8vGTnVSN5SVnhUMxjhbAO/8eROoTQ/2vXIq8ZzM/q9DIaK4tgV43QRV0FLjS6y6HE1bNmwveeSH/Mi/EWk7wLsVj2iknDDBiEtyQ4B3eySS5V9vgFxie9K2OnmVQZiIiLRKGlxLQgeG7rVIK4F+66QLYuyYvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(136003)(376002)(366004)(396003)(346002)(316002)(36756003)(2616005)(83380400001)(91956017)(76116006)(186003)(54906003)(8676002)(66476007)(4326008)(2906002)(66946007)(6486002)(66446008)(26005)(64756008)(66556008)(6506007)(478600001)(53546011)(6512007)(86362001)(71200400001)(8936002)(5660300002)(4001150100001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AXZgZP8TMOsI8iBA5QaVM8AeJnCMXvlUKQHcJ7Jf8BJeWuoo5uagyWwloizlXC17Ydvmazfpgt1k/Lg9LJlwvYPh5JflElI+/ZHmfizreTeUFyw8qRLhAt2FO1z4Pz2YQoxeof+cFbdM1Vk8r3ksy1l9A9SegzQ2yzoGWz8atMOjFeSP6G5TMSoaFKnzfd5Q3r9UNcax3alNj+TJwXGU0pDbupt+dXGqoeHTji2rifbI/x0uS3J9dN7hBY/9goq5TrcQlJVaTGFsk2QoliC+q7ASUcy40iIMm5gxveAOsWdqE8VdQa8ja9d8rCOpGr/wpEiU2mpOsG36gm8Nkf97IcDYBhqYP+DgP7Rx7Kcxh5WI8MRC4qAjNwg5ZpOirpILJou8RB/ssS7FXZS6Y02p+k5vxXaWl8e79pPKLiQd5dkEaXVeS54aO+fGX1X2rzRB9OQfUvBaGjrrFXEyUh7Eb3ZJ+JUxNjQHmnMZ5luwUZ+Ym6uzVOZFMjlsxPq4rGDu1Z4A0KNyDXh+3SF8ut1kZPfeyVacRQvXe3dV8nNDWwpyhYuJPatvbS35cOqVuRMeHr1yZV5LxR+Klcm5SJ9i1X7Qapmh7B1JVTQTf9Emx+t0hTGaOUbqtNFmUeCfl9pzIiSAhRbrWQq3KOrWGhhnSg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <06B54919C391594C82697DFD47EA0A72@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db4fa9c-3b80-428d-81a3-08d8873dc758
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 19:04:27.8145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjhyrLKZ5iYuSVZ1NEqljeqQvGj2bUCE+Vur0VXr62SSuRWmZJx5MdvDZU0UqR/D/csceqwt5FPqj+scmFleWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3376
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTEyIGF0IDEzOjM5IC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiANCj4gDQo+IE9uIDEyIE5vdiAyMDIwLCBhdCAxMzoyNiwgVHJvbmQgTXlrbGVidXN0
IHdyb3RlOg0KPiANCj4gPiBPbiBUaHUsIDIwMjAtMTEtMTIgYXQgMTY6NTEgKzAwMDAsIFRyb25k
IE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gSSB3YXMgZ29pbmcgdG8gYXNrIHlvdSBp
ZiBwZXJoYXBzIHJldmVydGluZyBTY290dCdzIGNvbW1pdA0KPiA+ID4gMDdiNWNlOGVmMmQ4DQo+
ID4gPiAoIk5GUzogTWFrZSBuZnNfcmVhZGRpciByZXZhbGlkYXRlIGxlc3Mgb2Z0ZW4iKSBtaWdo
dCBoZWxwIGhlcmU/DQo+ID4gPiBNeSB0aGlua2luZyBpcyB0aGF0IHdpbGwgdHJpZ2dlciBtb3Jl
IGNhY2hlIGludmFsaWRhdGlvbnMgd2hlbg0KPiA+ID4gdGhlDQo+ID4gPiBkaXJlY3RvcnkgaXMg
Y2hhbmdpbmcgdW5kZXJuZWF0aCB1cywgYW5kIHdpbGwgbm93IHRyaWdnZXINCj4gPiA+IHVuY2Fj
aGVkDQo+ID4gPiByZWFkZGlyIGluIHRob3NlIHNpdHVhdGlvbnMuDQo+ID4gPiANCj4gPiA+ID4g
DQo+ID4gDQo+ID4gSU9XLCB0aGUgc3VnZ2VzdGlvbiB3b3VsZCBiZSB0byBhcHBseSBzb21ldGhp
bmcgbGlrZSB0aGUgZm9sbG93aW5nDQo+ID4gb24NCj4gPiB0b3Agb2YgdGhlIGV4aXN0aW5nIHJl
YWRkaXIgcGF0Y2hzZXQ6DQo+IA0KPiBJJ20gYWxsIGZvciB0aGlzIGFwcHJvYWNoLCBidXQgLSBJ
J20gcmFyZWx5IHNlZWluZyB0aGUgbWFwcGluZy0NCj4gPm5ycGFnZXMgPT0gMA0KPiBzaW5jZSB0
aGUgY2FjaGUgaXMgZHJvcHBlZCBieSBhIHByb2Nlc3MgaW4gbmZzX3JlYWRkaXIoKSB0aGF0DQo+
IGltbWVkaWF0ZWx5DQo+IHN0YXJ0cyBmaWxsaW5nIHRoZSBjYWNoZSBhZ2Fpbi4NCg0KVGhhdCdz
IHdoeSBJIG1vdmVkIHRoZSBjaGVjayBpbiByZWFkZGlyX3NlYXJjaF9wYWdlY2FjaGUuIFVubGVz
cyB0aGF0DQpwcm9jZXNzIGhhcyBzZXQgZGVzYy0+ZGlyX2Nvb2tpZSA9PSAwLCB0aGVuIHRoYXQg
c2hvdWxkIHByZXZlbnQgdGhlDQpyZWZpbGxpbmcuDQoNCj4gSXQgd291bGQgbWFrZSBhIGxvdCBt
b3JlIHNlbnNlIHRvIG1lIGlmIHdlIGNvdWxkIGRvIHNvbWV0aGluZyBsaWtlDQo+IHN0YXNoDQo+
IGRlc2MtPnBhZ2VfaW5kZXggPDwgUEFHRV9TSElGVCBpbiBmX3BvcyBhZnRlciBlYWNoIG5mc19y
ZWFkZGlyLCB0aGVuDQo+IHRoZQ0KPiBodWVyaXN0aWMgY291bGQgY2hlY2sgZl9wb3MgPj4gUEFH
RV9TSElGVCA+IG5ycGFnZXMuDQo+IA0KPiBZZXMsIGZfcG9zIGlzIGdyb3dpbmcgbWFueSBkaWZm
ZXJlbnQgbWVhbmluZ3MgaW4gTkZTIGRpcmVjdG9yaWVzLA0KPiBtYXliZSB3ZQ0KPiBjYW4gc3Rh
c2ggaXQgb24gdGhlIGRpcmVjdG9yeSBjb250ZXh0Lg0KPiANCj4gQmVuDQo+IA0KPiA+IA0KPiA+
IC0tLQ0KPiA+IMKgZnMvbmZzL2Rpci5jIHwgMTQgKysrKysrLS0tLS0tLS0NCj4gPiDCoDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiA+IGluZGV4IDNmNzA2OTc3
MjlkOC4uMzg0YTQ2NjNmNzQyIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+ICsr
KyBiL2ZzL25mcy9kaXIuYw0KPiA+IEBAIC05NTYsMTAgKzk1NiwxMCBAQCBzdGF0aWMgaW50IHJl
YWRkaXJfc2VhcmNoX3BhZ2VjYWNoZShzdHJ1Y3QNCj4gPiBuZnNfcmVhZGRpcl9kZXNjcmlwdG9y
ICpkZXNjKQ0KPiA+IMKgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmVzOw0KPiA+IA0KPiA+
IC3CoMKgwqDCoMKgwqDCoGlmIChuZnNfcmVhZGRpcl9kb250X3NlYXJjaF9jYWNoZShkZXNjKSkN
Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FQkFEQ09PS0lFOw0K
PiA+IC0NCj4gPiDCoMKgwqDCoMKgwqDCoMKgZG8gew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpZiAobmZzX3JlYWRkaXJfZG9udF9zZWFyY2hfY2FjaGUoZGVzYykpDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVC
QURDT09LSUU7DQo+ID4gKw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KGRlc2MtPnBhZ2VfaW5kZXggPT0gMCkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlc2MtPmN1cnJlbnRfaW5kZXggPSAwOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlc2MtPnByZXZfaW5k
ZXggPSAwOw0KPiA+IEBAIC0xMDgyLDExICsxMDgyLDkgQEAgc3RhdGljIGludCBuZnNfcmVhZGRp
cihzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4gPiBzdHJ1Y3QNCj4gPiBkaXJfY29udGV4dCAqY3R4KQ0K
PiA+IMKgwqDCoMKgwqDCoMKgwqAgKiB0byBlaXRoZXIgZmluZCB0aGUgZW50cnkgd2l0aCB0aGUg
YXBwcm9wcmlhdGUgbnVtYmVyIG9yDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIHJldmFsaWRhdGUg
dGhlIGNvb2tpZS4NCj4gPiDCoMKgwqDCoMKgwqDCoMKgICovDQo+ID4gLcKgwqDCoMKgwqDCoMKg
aWYgKGN0eC0+cG9zID09IDAgfHwgbmZzX2F0dHJpYnV0ZV9jYWNoZV9leHBpcmVkKGlub2RlKSkg
ew0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXMgPSBuZnNfcmV2YWxpZGF0
ZV9tYXBwaW5nKGlub2RlLCBmaWxlLQ0KPiA+ID5mX21hcHBpbmcpOw0KPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmVzIDwgMCkNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Ow0KPiA+IC3CoMKgwqDCoMKgwqDC
oH0NCj4gPiArwqDCoMKgwqDCoMKgwqByZXMgPSBuZnNfcmV2YWxpZGF0ZV9tYXBwaW5nKGlub2Rl
LCBmaWxlLT5mX21hcHBpbmcpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXMgPCAwKQ0KPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsNCj4gPiANCj4gPiDCoMKg
wqDCoMKgwqDCoMKgcmVzID0gLUVOT01FTTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVzYyA9IGt6
YWxsb2Moc2l6ZW9mKCpkZXNjKSwgR0ZQX0tFUk5FTCk7DQo+ID4gDQo+ID4gDQo+ID4gLS0gDQo+
ID4gVHJvbmQgTXlrbGVidXN0DQo+ID4gTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KPiA+IHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCj4gDQoNCi0tIA0K
VHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNl
DQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
