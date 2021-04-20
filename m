Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F0366107
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhDTUgV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 16:36:21 -0400
Received: from mail-bn8nam12on2095.outbound.protection.outlook.com ([40.107.237.95]:58753
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233950AbhDTUgU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Apr 2021 16:36:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TP03iBNscBngLs8l50S/lul19tZjXMfZT5u7RBORbuZsve9KKaN30dsNrChXDC7FuR3FO3siNEccCRu9sBve5/Y6NwBBOBMYxAu45Q171GzbJYnEIxnkLkTALqvMR5HLAs/KLcW5aTC0Z/fRF7uKOEd/P9JqkyfLx7NOQ/Kr2XnwlG7Bu9DUuGUdkSDYJyJI+8mQjS5WnkXF/zwKT099WJXd1U7ny/rxij5idUas1oEQ0CckShinZli098lmpQZqJ8gvZiQGDFjr0/6P1IrjcE7Hxd3vWrT9EaxUx9D96teCAo5fr3wU+5YOqG26rdjHfYxSjq1FB1V0ZN2SD1vp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpJ24ovtbe6YXIHi0sPnMQ4Fr7/ve9nJaGxkpUE7JIY=;
 b=JgU4+Jrs1G4JzNn+tUBVb0lBXRiBe58GsPyzOtvx9iI+VSwaVhtEhuDMkLk+wGHwi0uth5dLx6yxNiOWkF3EkaKKBE9n41kIrTiDP9T2HpKs41+BlFXXL/n+ms6dkku4B4RkWMh/aLrqhLlzyJ2/aijPat/N0eCsge+1XAAAJWi2z8PeXjO8vRUep/G5qaVFgsGprGvuEOerNDdJijmcWhmrz7H0KgFuCU/zB4LRvvLb3DFsL3IhmIZOYdYRd3/5S27AmeJ89qeUEEYlbGFXeRFGARgrzhCLsl8ABX9Sok9fs5C+D9EuPA4l9dRzSwRQLPeG5SDi3BoQtb3GqYMI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpJ24ovtbe6YXIHi0sPnMQ4Fr7/ve9nJaGxkpUE7JIY=;
 b=KTRtUTJ4TvVTyvkw0WPBssVqIuN7ml6iNwfhqWPo30LjAwnaG14/Cg6b0CvvxNixx09QjdAhzHla9OjV1PeWhTTXmgAaCRU4rfyBg5jVovJX9fX6gZUTNYcmLXClmx/le1SaKbpETQ9IlXGemWwRzBezadDfBwaZtbM4Tr0OVfU=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6; Tue, 20 Apr
 2021 20:35:46 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 20:35:46 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2: Remove ifdef CONFIG_NFSD_V4 from nfsV4.2
 client SSC code.
Thread-Topic: [PATCH 1/1] NFSv4.2: Remove ifdef CONFIG_NFSD_V4 from nfsV4.2
 client SSC code.
Thread-Index: AQHXNggVcXO8e1qQr0KAjck11BVlWaq93WgA
Date:   Tue, 20 Apr 2021 20:35:45 +0000
Message-ID: <fe9d3a9b00709b1ad6a09487535c73a9d233ba5d.camel@hammerspace.com>
References: <20210420171026.103588-1-dai.ngo@oracle.com>
In-Reply-To: <20210420171026.103588-1-dai.ngo@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4326812-4044-449c-04be-08d9043be032
x-ms-traffictypediagnostic: DS7PR13MB4733:
x-microsoft-antispam-prvs: <DS7PR13MB4733DFF80414ECDB5B74D948B8489@DS7PR13MB4733.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /OSJvcGk6M9cyz7POdv7vKhyxuSDdJkEJZDSXuhFfA3Lqu+RtyoQ75V9lPgsTZc9XU5dNCpX6b8jHKsWS85Bb+CsZY/S9oMuQcGo5t/g3fi790bGxsoGTO3tSIiqzb5rxpbRNuCj3WCpeP9nnPmBaGEItdtUE1LgUMDK1iBrktPqmjaw4hRsCIQjpq8VS2C/wGopLSjqMmwyO2NDEggx7PGWne+MtrsoIIBoKEp4TOgdncnP0Y2XwF5ZFXykWWC4jd3r6F+fFIm1mBV+Hvl24UNt0J+lUoJxNIHNvjy1uae+g1t0JHvjIsIOE/EiZ2Hlrj/1j0oLz940jqNKx82caB0BiObpyiP+eqE2yQDsVSNrGm9I2gWGh4MveHEmU54BcUwKjFoyTCU+vTgx/gTN58UqkIYGvekShUV+yaoVCCxA+7ePNBtADq+GZwxphEaQhRO61L7MfGYG/X7yVLmKHff6ihf4+tVCW2dLDUwic/fArqtN2MWttpwm5iW+MEvLyg+Y7VV8kxgDHGDShQhgo8yO1OzJqz9MFaFE32vKGCA4i4tWnqAl7nYf9NihSi2wmRHtPtHWId1hNe/CFG3tKdkK5TW9zzIMYYwEvYsneJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39840400004)(76116006)(478600001)(6916009)(316002)(8936002)(66446008)(64756008)(91956017)(66476007)(8676002)(5660300002)(83380400001)(122000001)(38100700002)(2616005)(66556008)(2906002)(66946007)(86362001)(4326008)(6512007)(36756003)(26005)(6506007)(6486002)(71200400001)(54906003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MUVIZ3daV3dzYlFYNmRRNXNINXE2RUpwWVVqMXdiSHVkcmE4Yzlsck05aGVT?=
 =?utf-8?B?cjB0bHpFcWI3TTk0VWtJOFVOeUxYbFhtY1NNcmUzZkxaK1VTSWVSUExneml2?=
 =?utf-8?B?YUdxa3hSTElIc1FXdmhQRExaY3ZFSXEyR3JOamJJT1NEUHVmRndvdWhzclpt?=
 =?utf-8?B?cUdsd2ozUXp2dmFvRmp5UGlKdGhFRDkvK0JPakF6WVRyRktyUjQ2TldWUUk1?=
 =?utf-8?B?UCs0WnVPTU1HYTI5MHZWNHFQQWwxOGhzK2hFZzY4d2gvTllTYS91Y2U4dS9o?=
 =?utf-8?B?SWNRR1JoQ0UxWnVMcTRicXBvblZZWnh0MmU2c25FNDlDU2dxcWJUVCsvY1ZK?=
 =?utf-8?B?d0crdzlpWU05TzZYL3hhNHlJdzlDTllEQnV6QmhMWjNKVm8yN0phT1plZW1x?=
 =?utf-8?B?UU1KU2lZR2p0QTRmRHJUVjVtbC8yL1JENFEzUTlENGlOM2ttUDZSVzBkYkZX?=
 =?utf-8?B?YjQ0dUU4VVA3MTBZa2k0cUluTGJBOWpSWDUwcExLVlprK3FuWWxDUHBKbFgy?=
 =?utf-8?B?OWpGdkMxQ3laMTFOaVRPaXk4cmJ4WDlHUkhaendWVWVqSEhTUndNZzZzWGpx?=
 =?utf-8?B?UWFGOWN0WHFFQ2RjMW1uekVWTS9VQ3JiaUNURHZIclB3bm9XRUhQRDhseW9O?=
 =?utf-8?B?N2IwWG5BMG8vVU5qSEJob1pBQ0RZVDhkaEJGbmdIN09ydW1tdGRUcC9hNmZs?=
 =?utf-8?B?eGl3OTZndVdzSUZyS2tERy85UkNJMjVrS1NITVhydjNsbFV3QUtqVlltem1L?=
 =?utf-8?B?c3g1SXN3SVJ1M0dnSkVoTG55U0lOUk1qU0dZRVlzUlRvKzZ3RzdIU203a2Uv?=
 =?utf-8?B?L0IxSTdZZTB3Ymg0TUxQYjFsaVExR0dKaEZNNXlXRjFLL1lpY21jVEZLL0F2?=
 =?utf-8?B?R25tNTdKemJMdXRDblNoMjd5bVNaYVZMSE84ZUc0a2NScVNHc3lub0piOHZm?=
 =?utf-8?B?akxhWnFOcUpsWi93Y0toUGk5WWRHWjI2MWEwWG5MY1VQR2pvRUtkdVBuS0N5?=
 =?utf-8?B?anNpVnBQdUFhcVU0ZWlMK3E1YjY5OFVDcThzL3ZhTFNjK0d2VjJJTm5BZzds?=
 =?utf-8?B?eFlGTktVa3FHYXlRTTVPV3JNZHdWdU45YTFMUGdlVEhWKzhHY3FJb2VxYjEw?=
 =?utf-8?B?Z2lkTkxPYWg5cmpsc2dMR3I4RnlORDNTbUR4cndtNE9aV2ZyeTZiQkFEbmsr?=
 =?utf-8?B?SVo5aHEycERwODVRZ1pWY1dXOFJOcThEQ3dZWW4vaTlmbU9jdk9VcDBrZm0x?=
 =?utf-8?B?VUhrTEtIdC94R3pyNmtiRHpCYjJtOUcyd1JHVkpVVEpVTWlXT3FjcUxlTmgz?=
 =?utf-8?B?alFRZytUd096ZU5lYlFFbSttdDhBUm50cjd1eVR3Q3V6Ung4UWxWZ3ppR1N2?=
 =?utf-8?B?VHQ1QXI1U3ZrbnRDZGVnTXVLalN1V2w0aStWNHNEU0VWaVROL09jZmw1cjdM?=
 =?utf-8?B?M1lFek5FeXdHOXFzUWFQRElIMUh5bkFqQ2s4RUE4eE5LaTg1MlhYcXNtQkpz?=
 =?utf-8?B?U0pDbXRwOEpPeVV2dG5zVGtLL0VHY1JjZmhQMUErYUczMEV4ZUNEeFpkek9N?=
 =?utf-8?B?dzJFSUtxQlFnSGI4WWJzaW1RaWRuQjh0d2FubDNpbitkaWEyU0E1ZkZCb0lR?=
 =?utf-8?B?TFA2NzRCNG93UURyTHJPRHU5M2J1OUU5WWJSc1FYdUdaRCtWdUs4Y2NKSzNj?=
 =?utf-8?B?YVZ1RTFiUVRKSXBtMVY4WFJTM3dRZGpoRm9CUGZaZjJyeGZPYlVCOVhObkg0?=
 =?utf-8?Q?eYPMiUUN7zmXWsY0LCzqi0XAyItkRXwkYAmK66S?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB29AA11A96FE34AA28A099F91DD22A5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4326812-4044-449c-04be-08d9043be032
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 20:35:46.0273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeYROtVeRybycE4kSXe4XSPN6QgUWgxLagbsakIiDq4TrXDuGKwlDEL8rUtHimlruQUfI4rsKoRU63iEVeMTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4733
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA0LTIwIGF0IDEzOjEwIC0wNDAwLCBEYWkgTmdvIHdyb3RlOg0KPiBUaGUg
Y2xpZW50IFNTQyBjb2RlIHNob3VsZCBub3QgZGVwZW5kIG9uIGFueSBvZiB0aGUgQ09ORklHX05G
U0QgY29uZmlnLg0KPiBSZXBsYWNlZCBDT05GSUdfTkZTRF9WNCB3aXRoIENPTkZJR19ORlNfVjRf
Ml9TU0NfSEVMUEVSIGluIG5mczRmaWxlLmMNCj4gYW5kIHN1cGVyLmMuIFRoaXMgcGF0Y2ggYWxz
byBmaXhlcyB0aGUgY29tcGlsZXIgd2FybmluZyBvZiB1bnVzZWQNCj4gdmFyaWFibGVzIHdoZW4g
TkZTX1Y0XzIgaXMgY29uZmlndXJlZCBhbmQgTkZTRF9WNCBpcyBub3QuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNsZS5jb20+DQo+IC0tLQ0KPiDCoGZzL25mcy9u
ZnM0ZmlsZS5jIHwgNiArKysrLS0NCj4gwqBmcy9uZnMvc3VwZXIuY8KgwqDCoCB8IDYgKysrLS0t
DQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRmaWxlLmMgYi9mcy9uZnMvbmZzNGZpbGUuYw0K
PiBpbmRleCA0NDFhMmZhMDczYzguLjA0MjY2OGYwNmFkYyAxMDA2NDQNCj4gLS0tIGEvZnMvbmZz
L25mczRmaWxlLmMNCj4gKysrIGIvZnMvbmZzL25mczRmaWxlLmMNCj4gQEAgLTMxMyw2ICszMTMs
NyBAQCBzdGF0aWMgbG9mZl90IG5mczQyX3JlbWFwX2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUNCj4g
KnNyY19maWxlLCBsb2ZmX3Qgc3JjX29mZiwNCj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQg
PCAwID8gcmV0IDogY291bnQ7DQo+IMKgfQ0KPiDCoA0KPiArI2lmZGVmIENPTkZJR19ORlNfVjRf
Ml9TU0NfSEVMUEVSDQo+IMKgc3RhdGljIGludCByZWFkX25hbWVfZ2VuID0gMTsNCj4gwqAjZGVm
aW5lIFNTQ19SRUFEX05BTUVfQk9EWSAic3NjX3JlYWRfJWQiDQo+IMKgDQo+IEBAIC00MTEsNiAr
NDEyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBuZnM0X3NzY19jbGllbnRfb3BzDQo+IG5mczRf
c3NjX2NsbnRfb3BzX3RibCA9IHsNCj4gwqDCoMKgwqDCoMKgwqDCoC5zY29fb3BlbiA9IF9fbmZz
NDJfc3NjX29wZW4sDQo+IMKgwqDCoMKgwqDCoMKgwqAuc2NvX2Nsb3NlID0gX19uZnM0Ml9zc2Nf
Y2xvc2UsDQo+IMKgfTsNCj4gKyNlbmRpZsKgLyogQ09ORklHX05GU19WNF8yX1NTQ19IRUxQRVIg
Ki8NCj4gwqANCj4gwqAvKioNCj4gwqAgKiBuZnM0Ml9zc2NfcmVnaXN0ZXJfb3BzIC0gV3JhcHBl
ciB0byByZWdpc3RlciBORlNfVjQgb3BzIGluDQo+IG5mc19jb21tb24NCj4gQEAgLTQyMCw3ICs0
MjIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG5mczRfc3NjX2NsaWVudF9vcHMNCj4gbmZzNF9z
c2NfY2xudF9vcHNfdGJsID0gew0KPiDCoCAqLw0KPiDCoHZvaWQgbmZzNDJfc3NjX3JlZ2lzdGVy
X29wcyh2b2lkKQ0KPiDCoHsNCj4gLSNpZmRlZiBDT05GSUdfTkZTRF9WNA0KPiArI2lmZGVmIENP
TkZJR19ORlNfVjRfMl9TU0NfSEVMUEVSDQo+IMKgwqDCoMKgwqDCoMKgwqBuZnM0Ml9zc2NfcmVn
aXN0ZXIoJm5mczRfc3NjX2NsbnRfb3BzX3RibCk7DQo+IMKgI2VuZGlmDQo+IMKgfQ0KPiBAQCAt
NDMzLDcgKzQzNSw3IEBAIHZvaWQgbmZzNDJfc3NjX3JlZ2lzdGVyX29wcyh2b2lkKQ0KPiDCoCAq
Lw0KPiDCoHZvaWQgbmZzNDJfc3NjX3VucmVnaXN0ZXJfb3BzKHZvaWQpDQo+IMKgew0KPiAtI2lm
ZGVmIENPTkZJR19ORlNEX1Y0DQo+ICsjaWZkZWYgQ09ORklHX05GU19WNF8yX1NTQ19IRUxQRVIN
Cj4gwqDCoMKgwqDCoMKgwqDCoG5mczQyX3NzY191bnJlZ2lzdGVyKCZuZnM0X3NzY19jbG50X29w
c190YmwpOw0KPiDCoCNlbmRpZg0KPiDCoH0NCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9zdXBlci5j
IGIvZnMvbmZzL3N1cGVyLmMNCj4gaW5kZXggOTQ4ODVjNmY4ZjU0Li5kZjE3ZTBkZGJjNGQgMTAw
NjQ0DQo+IC0tLSBhL2ZzL25mcy9zdXBlci5jDQo+ICsrKyBiL2ZzL25mcy9zdXBlci5jDQo+IEBA
IC04Niw3ICs4Niw3IEBAIGNvbnN0IHN0cnVjdCBzdXBlcl9vcGVyYXRpb25zIG5mc19zb3BzID0g
ew0KPiDCoH07DQo+IMKgRVhQT1JUX1NZTUJPTF9HUEwobmZzX3NvcHMpOw0KPiDCoA0KPiAtI2lm
ZGVmIENPTkZJR19ORlNfVjRfMg0KPiArI2lmZGVmIENPTkZJR19ORlNfVjRfMl9TU0NfSEVMUEVS
DQo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBuZnNfc3NjX2NsaWVudF9vcHMgbmZzX3NzY19jbG50
X29wc190YmwgPSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAuc2NvX3NiX2RlYWN0aXZlID0gbmZzX3Ni
X2RlYWN0aXZlLA0KPiDCoH07DQo+IEBAIC0xMTYsMTQgKzExNiwxNCBAQCBzdGF0aWMgdm9pZCB1
bnJlZ2lzdGVyX25mczRfZnModm9pZCkNCj4gwqAjaWZkZWYgQ09ORklHX05GU19WNF8yDQo+IMKg
c3RhdGljIHZvaWQgbmZzX3NzY19yZWdpc3Rlcl9vcHModm9pZCkNCj4gwqB7DQo+IC0jaWZkZWYg
Q09ORklHX05GU0RfVjQNCj4gKyNpZmRlZiBDT05GSUdfTkZTX1Y0XzJfU1NDX0hFTFBFUg0KPiDC
oMKgwqDCoMKgwqDCoMKgbmZzX3NzY19yZWdpc3RlcigmbmZzX3NzY19jbG50X29wc190YmwpOw0K
PiDCoCNlbmRpZg0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgdm9pZCBuZnNfc3NjX3VucmVnaXN0
ZXJfb3BzKHZvaWQpDQo+IMKgew0KPiAtI2lmZGVmIENPTkZJR19ORlNEX1Y0DQo+ICsjaWZkZWYg
Q09ORklHX05GU19WNF8yX1NTQ19IRUxQRVINCj4gwqDCoMKgwqDCoMKgwqDCoG5mc19zc2NfdW5y
ZWdpc3RlcigmbmZzX3NzY19jbG50X29wc190YmwpOw0KPiDCoCNlbmRpZg0KPiDCoH0NCg0KDQpP
Sy4gVGhpcyBsb29rcyBiZXR0ZXIsIGFuZCBnaXZlcyB1cyBhIG1vcmUgZGlyZWN0IGRlcGVuZGVu
Y3kuDQpIb3dldmVyIGxvb2tpbmcgaW5kZXBlbmRlbnRseSBhdCBmcy9LY29uZmlnLCBJJ20gc2Vl
aW5nDQoNCmNvbmZpZyBORlNfVjRfMl9TU0NfSEVMUEVSDQogICAgICAgIHRyaXN0YXRlDQogICAg
ICAgIGRlZmF1bHQgeSBpZiBORlNfVjQ9eSB8fCBORlNfRlM9eQ0KDQpTaG91bGRuJ3QgdGhhdCBy
YXRoZXIgYmU6DQoNCmNvbmZpZyBORlNfVjRfMl9TU0NfSEVMUEVSDQoJYm9vbA0KCWRlZmF1bHQg
eSBpZiBORlNfVjRfMiB8fCBORlNEX1Y0XzJfSU5URVJfU1NDDQoNCi4uLnRvIGFsbG93IHVzIHRv
IGdldCByaWQgb2YgdGhlc2UgQ09ORklHX05GU19WNF8yX1NTQ19IRUxQRVIgI2lmZGVmcw0KaW4g
ZnMvbmZzPyBJIHN1c3BlY3QgdGhlIGFib3ZlIHdvdWxkIGFsc28gYWxsb3cgdXMgdG8gc2ltcGxp
ZnkgdGhlDQpkZXBlbmRlbmNpZXMgaW4gZnMvbmZzZC9LY29uZmlnIGZvciBORlNEX1Y0XzJfSU5U
RVJfU1NDIHRvby4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
