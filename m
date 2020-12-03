Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3F62CDD59
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 19:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbgLCSYS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:18 -0500
Received: from mail-eopbgr770113.outbound.protection.outlook.com ([40.107.77.113]:29378
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387833AbgLCSYR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 13:24:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhFKGmMkpqN41LI9W5fcyabgx+TGLSvKfRoQd8unYK87WkUaJz9M580tzpfWOZnaujn/YB8YnrEk7kxcT7Cdar2R3drtxr1PMhxvSFzdd9qUtsQMKWH9MEY09a5GNGTsHXBhgJFck/Tg1ycxTB1lGC/x1qWJ0NbCOavH4oT7+j6opME5E/DCYDYF4DgW/4Ld0bbZEMf2RDesbEhjM4MnKGRtXey1M8tngvZEipVCkBc1knA8o/ytuVDetDU4UfxHz/ys9DhpC2up2oWBwL0n9Qegn3m28MYVFamqio8NHW0UquS+Qmi2ECTQhB7nWu2cAn7agBQdBRkDPOrDtHpcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9FK4QlG1l/X2DBo6Gucp//usQDbhQeB6qQSyUlI5zg=;
 b=eeJx8fGWkFxxIjWVqZLYqr4c82PZp6c5cdg0IU8k5fI3NWO7rTdc0tUKBgDzyB400TMvxehzMZMB8gLYOm+oO1crSPejb4A1dEsW28CovM/mkKUqL5olA2JN8QaXQT2Fzv9g+AbMMiLK4Sm3iSvAR62DEROEbpQ/Abyj/bT244SdN7GDuQfIq0eeEq8XQkW/chfheZBGXx6hTKMVv4CP7gdzpA7WVI9sI9Uovw14KzBx8bpVocv8dDw9WvYKJ/wyibglg+SlR+s/Jt2HARo7GmNdeP5Tkjt7/slIxyk4uhQ3TyR61DkDWb1NcskhgRNXvI+4ytUcUb/VGhKHLwsGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9FK4QlG1l/X2DBo6Gucp//usQDbhQeB6qQSyUlI5zg=;
 b=ad+XAQytfEVbH3tL/oKJChUJ9J5zv0AZ9j/Ap4OCli1KFOgUzLVtFz+bp5T/o6v2Iqd7J9NLTLP9NyK2nK+ZftTnFN1JsHcC6YddpjUYMAsfoZonCsi1uhWToi+4MTmuU/4vc4tHctXwU/OIE9CeD8Mvxudy3zC1CM7+/GdT9os=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3976.namprd13.prod.outlook.com (2603:10b6:208:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5; Thu, 3 Dec
 2020 18:23:24 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 18:23:24 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>
CC:     "tigran.mkrtchyan@desy.de" <tigran.mkrtchyan@desy.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Kernel OPS when using xattr
Thread-Topic: Kernel OPS when using xattr
Thread-Index: Gy/PzTaHdY6Ui5eV5iBg9axQHgH8es3zcbcAgCc3dgv/2OuegIAACaaAgAAJ4YA=
Date:   Thu, 3 Dec 2020 18:23:24 +0000
Message-ID: <43574879eae405b934fa4c37a482b004adbb2aa9.camel@hammerspace.com>
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
         <3e8c5334cca58c92e92d7ac2af95cf4e5141df08.camel@hammerspace.com>
         <305212825.2047189.1607011487661.JavaMail.zimbra@desy.de>
         <3b6276e9afe5e2dc2fa9c1f11b607bc031071554.camel@hammerspace.com>
         <20201203174757.GA2605@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
In-Reply-To: <20201203174757.GA2605@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 758901dd-3c1f-464f-91d3-08d897b885bb
x-ms-traffictypediagnostic: MN2PR13MB3976:
x-microsoft-antispam-prvs: <MN2PR13MB3976062DC9089F173FFE7961B8F20@MN2PR13MB3976.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eA9jcfsA80yybxJny4jbhnSqW2f+k0fvHwlylroo7i7s0CWW6zWHjtN0M/numodLKwPJC6ZOajQjv4EEg4+fYenawzsduTEkY2BekIu7Q329UCqbJcP1oOoeC1o/p6MIl6ofF6lpFKP85XZ9r5Js7FRsBldaGcHxwFCHpcynpxjyWQca9FwxZ0xwweCr3o+LpsZXlCqjs/jsAyjnPK1shz5aCLxv8AfQhH8Dv/MzhTBePCMfpdg56cWGlcLH5n4aqH2zv/GJOxDYDqW+5+F5LhoEUr4kz8lJs8yMljM+9yuLAjLQczTCq5i4I5iEdnDuaDPQ9tiZRIHPN8ueO/d7L9iZxj0vPTdhz+I6NYWOKrfrY0KSGJSvxQEPccpXRtjp1KpP7pG0DH34jSOymvsCKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(346002)(136003)(366004)(396003)(966005)(6512007)(2616005)(76116006)(91956017)(6506007)(5660300002)(6916009)(86362001)(66556008)(66446008)(4326008)(53546011)(36756003)(64756008)(2906002)(66476007)(8676002)(8936002)(478600001)(6486002)(71200400001)(54906003)(83380400001)(66946007)(316002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RU9tbVFwZlJ2OHVxMmh6VGVZNC9QMDRueE5NV1U2M2kzUzBwOURZTEZaOXBW?=
 =?utf-8?B?TXZGR3g5UTFrU0FnTzh2REpUQ0dtaVJBWVRHT1FLR2hIWTQvc2FZRHNFTWtt?=
 =?utf-8?B?SlEvNHB0YmhDWUhmZk94NG1ldFdQYW8vVUk4aE9ZMUFoVTA2bEo5WWhRNW1R?=
 =?utf-8?B?K1Y2L1ByRGl1MGNnRHlCL0ZvT29rUkg0bjY4eTFiUEppajNrRVhLbnFTRWVZ?=
 =?utf-8?B?MFNYNUFxd2xta25Dd3U3aGxFK21uYWFBNzdaV082QzRZeXc3QnJBQzJ0SUlk?=
 =?utf-8?B?QUc4Mjl5MzdsN0gvOEgrZnA1VWZiS3hRWjVSTE5Qd3pZR3Zyc0l3OVRVT01u?=
 =?utf-8?B?eGlneG0vSTloMkFUSmdLb2R4Nk45YVlIK3pmZWMwUXltL3FoS0xDZFlmaFow?=
 =?utf-8?B?UDUzUlVpT2RUUDM3K0txZlRudGp0dDl0eGpXb3JJcVJ2NXlGQVdNWkZFT2dt?=
 =?utf-8?B?Qk01cCt1eXVzUHJKYUg2aGc0YVFIaUcyU25YNTcrUXRoeTFXeTlWeHh5ZE5p?=
 =?utf-8?B?MmdPWURHUWNJVWlMRmRmcVh5azVmSzdvS3dvckNIQit3Qk9uUjJlY0FmK0tZ?=
 =?utf-8?B?azNQcHRPY1QweVF1bTIrb0RtcTVhZ20rZGFueUxUbFh6Z214N1RQd3FLNFVL?=
 =?utf-8?B?a2Z3Zy9iSm1SRkNsVHNMdTlhRkY5MXhoOUlOVkFxSTVaMFIyRWY4bXJxdHRM?=
 =?utf-8?B?c1llQTVsSno2TlhnMUpRMmVOUlZ5aHVKU3NBc2g0bnZYWHpTbDlxMkNEYTdj?=
 =?utf-8?B?RDU5cEoyMm9hTHRsZ0dFWkVuak5ibzlUQzdQWVlHcWo1dS9tZlFhelYrcHVQ?=
 =?utf-8?B?NEpRUUVxQzFwb1FKbFBDYTBJeWdTUUNpU3lQYjFMckpTdjF5bFBqSml4OFJO?=
 =?utf-8?B?UkZ1cjEvU04rRFFoMlQyRUc2NG04UmVHNUhObzZJeE9jMmdQb2FFN05tVzAy?=
 =?utf-8?B?MlFxbDBCZG9uNUpGb05LTy9pMmJ2NUJZYmRtSkFjRnpWUVVsVG5SRTVlQ2Vl?=
 =?utf-8?B?dW1nOTBySU5ZaUNjWlBadVVIY1dMNklDMFBkN0FOalR2ZGorbTRzRDNMRDlV?=
 =?utf-8?B?dUhDeGw4QXpwMVBsZkFiOFNFUjdoSzljNnJIQkoxSjJCeFEyNU5PamFVYnVj?=
 =?utf-8?B?RTVPVlpMckRJcEhLcWkxMS9yZFhWUmNaZmJtMU1GbW16UkZrV2hXUTJiZVRL?=
 =?utf-8?B?WG5ZWHFsdHZwSHozdWZYdGFHUEJiR1BMRWFkOFdXaUtDV21WL1cxK1k3ZnMw?=
 =?utf-8?B?VmlUU1NnWTY5VFk5T0trak9FVGdhdDBCbUYzYWtHM3VDS2dmRnM3STJZL0dp?=
 =?utf-8?Q?G02y1SdY8TeXckT9Ur6mwDkP+2DiUNfnaP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B22A5D0C0D7D043BFCA869358D25ED7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758901dd-3c1f-464f-91d3-08d897b885bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 18:23:24.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k91xxojOsCe1lxpxWnstSP2GTTfC1o7tGhBqwA7uH77QLfYHJDoeqfSef7EWOQ61L8SmxEKZDuYKW3xAioKxhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3976
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE3OjQ3ICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gT24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMDU6MTM6MjZQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiBbLi4uXQ0KPiA+IFlvdSBwcm9iYWJseSBuZWVkIHRoaXMgb25l
IGluIGFkZGl0aW9uIHRvIHRoZSBmaXJzdCBwYXRjaC4NCj4gPiA4PC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBGcm9tIGZlYzc3NDY5ZjM3
M2ZiY2NiMjkyYzJkNTIyZjJlYmVlM2I5MDExYTggTW9uIFNlcCAxNyAwMDowMDowMA0KPiA+IDIw
MDENCj4gPiBGcm9tOiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFj
ZS5jb20+DQo+ID4gRGF0ZTogVGh1LCAzIERlYyAyMDIwIDEyOjA0OjUxIC0wNTAwDQo+ID4gU3Vi
amVjdDogW1BBVENIXSBORlN2NC4yOiBGaXggdXAgdGhlIGdldC9saXN0eGF0dHIgY2FsbHMgdG8N
Cj4gPiDCoHJwY19wcmVwYXJlX3JlcGx5X3BhZ2VzKCkNCj4gPiANCj4gPiBFbnN1cmUgdGhhdCBi
b3RoIGdldHhhdHRyIGFuZCBsaXN0eGF0dHIgcGFnZSBhcnJheSBhcmUgY29ycmVjdGx5DQo+ID4g
YWxpZ25lZCwgYW5kIHRoYXQgZ2V0eGF0dHIgY29ycmVjdGx5IGFjY291bnRzIGZvciB0aGUgcGFn
ZSBwYWRkaW5nDQo+ID4gd29yZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWts
ZWJ1c3QgPHRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+ID4gLS0tDQo+ID4gwqBm
cy9uZnMvbmZzNDJ4ZHIuYyB8IDEyICsrKysrKystLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZnMvbmZzL25mczQyeGRyLmMgYi9mcy9uZnMvbmZzNDJ4ZHIuYw0KPiA+IGluZGV4IDg0MzJiZDZi
OTVmMC4uMTAzOTc4ZmY3NmM5IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9uZnM0Mnhkci5jDQo+
ID4gKysrIGIvZnMvbmZzL25mczQyeGRyLmMNCj4gPiBAQCAtMTkxLDcgKzE5MSw3IEBADQo+ID4g
DQo+ID4gwqAjZGVmaW5lIGVuY29kZV9nZXR4YXR0cl9tYXhzesKgwqAgKG9wX2VuY29kZV9oZHJf
bWF4c3ogKyAxICsgXA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzNF94YXR0cl9uYW1lX21heHN6KQ0KPiA+IC0j
ZGVmaW5lIGRlY29kZV9nZXR4YXR0cl9tYXhzesKgwqAgKG9wX2RlY29kZV9oZHJfbWF4c3ogKyAx
ICsgMSkNCj4gPiArI2RlZmluZSBkZWNvZGVfZ2V0eGF0dHJfbWF4c3rCoMKgIChvcF9kZWNvZGVf
aGRyX21heHN6ICsgMSArDQo+ID4gcGFnZXBhZF9tYXhzeikNCj4gPiDCoCNkZWZpbmUgZW5jb2Rl
X3NldHhhdHRyX21heHN6wqDCoCAob3BfZW5jb2RlX2hkcl9tYXhzeiArIFwNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IDEgKyBuZnM0X3hhdHRyX25hbWVfbWF4c3ogKyAxKQ0KPiA+IMKgI2RlZmluZSBkZWNvZGVfc2V0
eGF0dHJfbWF4c3rCoMKgIChvcF9kZWNvZGVfaGRyX21heHN6ICsNCj4gPiBkZWNvZGVfY2hhbmdl
X2luZm9fbWF4c3opDQo+ID4gQEAgLTE0NzYsMTcgKzE0NzYsMTggQEAgc3RhdGljIHZvaWQgbmZz
NF94ZHJfZW5jX2dldHhhdHRyKHN0cnVjdA0KPiA+IHJwY19ycXN0ICpyZXEsIHN0cnVjdCB4ZHJf
c3RyZWFtICp4ZHIsDQo+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGNvbXBvdW5kX2hkciBoZHIg
PSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5taW5vcnZlcnNpb24gPSBu
ZnM0X3hkcl9taW5vcnZlcnNpb24oJmFyZ3MtDQo+ID4gPiBzZXFfYXJncyksDQo+ID4gwqDCoMKg
wqDCoMKgwqAgfTsNCj4gPiArwqDCoMKgwqDCoMKgIHVpbnQzMl90IHJlcGxlbjsNCj4gPiDCoMKg
wqDCoMKgwqDCoCBzaXplX3QgcGxlbjsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoCBlbmNvZGVf
Y29tcG91bmRfaGRyKHhkciwgcmVxLCAmaGRyKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBlbmNvZGVf
c2VxdWVuY2UoeGRyLCAmYXJncy0+c2VxX2FyZ3MsICZoZHIpOw0KPiA+IMKgwqDCoMKgwqDCoMKg
IGVuY29kZV9wdXRmaCh4ZHIsIGFyZ3MtPmZoLCAmaGRyKTsNCj4gPiArwqDCoMKgwqDCoMKgIHJl
cGxlbiA9IGhkci5yZXBsZW4gKyBvcF9kZWNvZGVfaGRyX21heHN6ICsgMTsNCj4gPiDCoMKgwqDC
oMKgwqDCoCBlbmNvZGVfZ2V0eGF0dHIoeGRyLCBhcmdzLT54YXR0cl9uYW1lLCAmaGRyKTsNCj4g
PiANCj4gPiDCoMKgwqDCoMKgwqDCoCBwbGVuID0gYXJncy0+eGF0dHJfbGVuID8gYXJncy0+eGF0
dHJfbGVuIDogWEFUVFJfU0laRV9NQVg7DQo+ID4gDQo+ID4gLcKgwqDCoMKgwqDCoCBycGNfcHJl
cGFyZV9yZXBseV9wYWdlcyhyZXEsIGFyZ3MtPnhhdHRyX3BhZ2VzLCAwLCBwbGVuLA0KPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoCBoZHIucmVwbGVuKTsNCj4gPiArwqDCoMKgwqDCoMKgIHJwY19w
cmVwYXJlX3JlcGx5X3BhZ2VzKHJlcSwgYXJncy0+eGF0dHJfcGFnZXMsIDAsIHBsZW4sDQo+ID4g
cmVwbGVuKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCByZXEtPnJxX3Jjdl9idWYuZmxhZ3MgfD0gWERS
QlVGX1NQQVJTRV9QQUdFUzsNCj4gPiANCj4gPiDCoMKgwqDCoMKgwqDCoCBlbmNvZGVfbm9wcygm
aGRyKTsNCj4gPiBAQCAtMTUyMCwxNCArMTUyMSwxNSBAQCBzdGF0aWMgdm9pZCBuZnM0X3hkcl9l
bmNfbGlzdHhhdHRycyhzdHJ1Y3QNCj4gPiBycGNfcnFzdCAqcmVxLA0KPiA+IMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCBjb21wb3VuZF9oZHIgaGRyID0gew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAubWlub3J2ZXJzaW9uID0gbmZzNF94ZHJfbWlub3J2ZXJzaW9uKCZhcmdzLQ0K
PiA+ID4gc2VxX2FyZ3MpLA0KPiA+IMKgwqDCoMKgwqDCoMKgIH07DQo+ID4gK8KgwqDCoMKgwqDC
oCB1aW50MzJfdCByZXBsZW47DQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgZW5jb2RlX2NvbXBv
dW5kX2hkcih4ZHIsIHJlcSwgJmhkcik7DQo+ID4gwqDCoMKgwqDCoMKgwqAgZW5jb2RlX3NlcXVl
bmNlKHhkciwgJmFyZ3MtPnNlcV9hcmdzLCAmaGRyKTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBlbmNv
ZGVfcHV0ZmgoeGRyLCBhcmdzLT5maCwgJmhkcik7DQo+ID4gK8KgwqDCoMKgwqDCoCByZXBsZW4g
PSBoZHIucmVwbGVuICsgb3BfZGVjb2RlX2hkcl9tYXhzeiArIDIgKyAxOw0KPiA+IMKgwqDCoMKg
wqDCoMKgIGVuY29kZV9saXN0eGF0dHJzKHhkciwgYXJncywgJmhkcik7DQo+ID4gDQo+ID4gLcKg
wqDCoMKgwqDCoCBycGNfcHJlcGFyZV9yZXBseV9wYWdlcyhyZXEsIGFyZ3MtPnhhdHRyX3BhZ2Vz
LCAwLCBhcmdzLQ0KPiA+ID4gY291bnQsDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIGhkci5y
ZXBsZW4pOw0KPiA+ICvCoMKgwqDCoMKgwqAgcnBjX3ByZXBhcmVfcmVwbHlfcGFnZXMocmVxLCBh
cmdzLT54YXR0cl9wYWdlcywgMCwgYXJncy0NCj4gPiA+IGNvdW50LCByZXBsZW4pOw0KPiA+IA0K
PiA+IMKgwqDCoMKgwqDCoMKgIGVuY29kZV9ub3BzKCZoZHIpOw0KPiA+IMKgfQ0KPiA+IC0tDQo+
ID4gMi4yOC4wDQo+IA0KPiBIbS4uIHRoYXQgZG9lc24ndCBzZWVtIHRvIG1hdGNoIG90aGVyLCBz
aW1pbGFyIGZ1bmN0aW9uYWxpdHkuDQo+IFdoeSBpcyB0aGUgYWRkaXRpb25hbCBwYWRkaW5nIGFu
ZCBvcF9kZWNvZGVfaGRyX21heHN6IG5lZWRlZD8NCj4gDQoNCkl0IGlzbid0IGV4dHJhIHBhZGRp
bmcuIEl0IGlzIHRoZSBzYW1lIHBhZGRpbmcsIGJ1dCBhZnRlciB0aGUgY2xlYW51cA0KdGhhdCBy
ZW1vdmVzIHRoZSBjb25mdXNpbmcgYmVoYXZpb3VyIG9mIHJwY19wcmVwYXJlX3JlcGx5X3BhZ2Vz
KCksIHRoZQ0KY2FsbGVyIGlzIHN1cHBvc2VkIHRvIHN1cHBseSB0aGUgYWN0dWFsIG9mZnNldCBm
b3IgdGhlIGJlZ2lubmluZyBvZiB0aGUNCnBhZ2UgZGF0YSBpbnN0ZWFkIG9mIGFkZGluZyB0aGUg
cGFkZGluZyB0byB0aGF0IG9mZnNldDoNCmh0dHBzOi8vZ2l0LmxpbnV4LW5mcy5vcmcvP3A9dHJv
bmRteS9saW51eC1uZnMuZ2l0O2E9Y29tbWl0ZGlmZjtoPTllZDVhZjI2OGU4OGY2ZTViNjUzNzZi
ZTk4ZDY1MmIzN2NiMjBkN2INCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
