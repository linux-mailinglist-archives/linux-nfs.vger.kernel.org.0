Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7237000A
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Apr 2021 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhD3R5K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Apr 2021 13:57:10 -0400
Received: from mail-bn8nam12on2133.outbound.protection.outlook.com ([40.107.237.133]:3329
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229954AbhD3R5J (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Apr 2021 13:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4K6JMSCHM0vygHgUZO8xBd6GCN0oegG8ELU7n7x3Qjm9jXgP88RI+RKf3KL+X1gdES8tibQHD281P4H+5NycdPiZTVoGqN5ZgDq0nt65a4GmIq3lf+KhUhZcKaGzZj17OvcFvKiG8rLjX8c9gmHNAKzEp7wd0oF9TzBi2czfrOQySpOjnA9WMHdMIGg8wh5nxp8GwS1PN0Ceayg1c8nE3bOsZhKmKCOlND6wPRJk6qhgQuMW7nqTSEFlvVW7fsE9PDYbH1jwZwvXECRFse39PYnsd9kFcoF+Fwj+8DlfUSzQkcOXeeKykLx/qHNxkaSx9gEm88o6JJ6LyaG8FEyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C74mE9KaPNrcXLOKq5bFsUJE1ZX9T5fTIxUlAmxGMek=;
 b=U+uus+OqqtD3E7dT6yBM2LELxmmzlcToRe6UfTrEiNDSo8/QfE6k0C8tErcuJhKSsiNnaJMrRpPU1zGqjhb1RpUUOiS+Ytlzh/L5I6MCM0AkOAUmYRJdBmA5qsxdwnoyQs9dXiwD1EWgKb8EhRMAZrqL06XYSmcX2KlQ7Wo8ugHjbcq5h0ltdJFCcHE5EdWnpgt1Sm8vBnFsu/LDThnLW+aFvlW/X2QQYubSo3+OGVpTiMJW9A1w4+qXushBpLYdYlN1jF5B8G8JIkq3unJQBm8MJimkp/0Xq2/cjaObyojGCsrEhMfNgBMku8cPQ+Si7iMrKK1jaC2DxtRcQM9R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C74mE9KaPNrcXLOKq5bFsUJE1ZX9T5fTIxUlAmxGMek=;
 b=Gpf5bvBtiKa/rH8euc8IuhcsT3BPuknmdh/QqGuDRKBMG1Zb30taPznfUS980oZ8QJMUcyvK/YOvRPXmA3RiSy7/+fLYy55I54RTlqFwNdnRzKo+bsg5YTDAe2OQa90ICin22olcwFZ5w/gXYyVUrV5zc2hqOlpFxJhCxsQV8bA=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB1146.namprd13.prod.outlook.com (2603:10b6:3:27::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.16; Fri, 30 Apr
 2021 17:56:18 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4108.015; Fri, 30 Apr 2021
 17:56:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4: can_open_cached needs to be called with
 so_lock
Thread-Topic: [PATCH 1/1] NFSv4: can_open_cached needs to be called with
 so_lock
Thread-Index: AQHXPX71UYnllJQ790m1s7wNeL9eS6rNAaoAgABOnICAAAj4gA==
Date:   Fri, 30 Apr 2021 17:56:18 +0000
Message-ID: <87e0aec1dcc3fb03474734db5699b4d7dba9944f.camel@hammerspace.com>
References: <20210430050900.106851-1-dai.ngo@oracle.com>
         <8fadf7c12b188eacf5c2bb577a2fbf938e51ebaa.camel@hammerspace.com>
         <6ecdca6f-85a8-87d5-a5ce-069b98533a10@oracle.com>
In-Reply-To: <6ecdca6f-85a8-87d5-a5ce-069b98533a10@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9de8d45f-5a7e-4dfa-35da-08d90c014170
x-ms-traffictypediagnostic: DM5PR13MB1146:
x-microsoft-antispam-prvs: <DM5PR13MB11467337FD718A57D00BCD90B85E9@DM5PR13MB1146.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKQLD/c8mwZqs3aQ9+YCIwBiuilq8oFAFUImfKJitNN8t6Or7EvLwseXgnzFsnJl7YqnAXpWJ40yNOJSeOIRGPfQMuR0+m+NmxFSlHdQ23WGDRzT/Iy9RNHarB9evt7RDGfod/MVheEaubJUqITFMv12Xi8/AFV4jH3wFmjfrGE7vr0C1aYrVZhDo0k51lUBfs3quqP+tJGfilUSy/N75SnYanaaiLCKSLV6J/Qi9y8fMP14y6gnbFQIBvaghy+Ev1I6yTQWPwVIRYaKx89ZUYjdOVwB4Q9/NffmG1JKJaWprELtHhucQvHgy496IFtDQWCy1FUQ7g0u53QHyhfP89HBRbrztx6A7aqvdnRqDqxThpmX++IT+R4o+gcot0dxI5pj6VFIuqhZmTY4Pl7s63XqwDTQ/EJguUfbYfqMXEnDnDehRms9yo+oogITiSQh9N2uQ4n0RyDBkqctbIxfwb9QF9eMXI06jf7EOZ/0P/JOu9S90QKhBnD87OPc/dRvD2RxBDkCsvIU15+yNsVv8SFrz0c2JvLCtvXaD34vUomlnSe8kwMxBsBrpy/nwJmgFNUWIlh1pwl6K5q/uoaSq9ejSJlg9Q3+kfgl5iqJtj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39840400004)(376002)(136003)(366004)(6512007)(6916009)(2906002)(6486002)(86362001)(2616005)(4326008)(8936002)(316002)(8676002)(83380400001)(71200400001)(6506007)(76116006)(36756003)(186003)(26005)(478600001)(53546011)(38100700002)(91956017)(122000001)(5660300002)(64756008)(66446008)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGlNTkZhR2FFUERMU3ZsRVNMWTEzYi9aWVJrd0FjVGRaeWQwK3VFZXAzQzNO?=
 =?utf-8?B?Y1RkaGJSQk1MRUsxN21IRTNBWEF3ejIxT0t6UnZMRVFiR08yUVdFVVdDSVla?=
 =?utf-8?B?dHJzbDZFTUNTNzNIT3ZuL293M1o0U2ZrZzY0a25zRHE4bXdTV0NvMTZpWExF?=
 =?utf-8?B?VFlCQnRLUzFvVGxMQ29raWlxeHdWSHJER21UajBsczZIN2VTMWZYOE00QlNy?=
 =?utf-8?B?OXhFZnRVT1A1am1VVTBhK2xsZDhoeno0cHZVZGxpaUJ2ZG1KNTBRdmZoQ3lN?=
 =?utf-8?B?Qk5QcmhkS2VLS3dERkprVFZjN0NXVFZaTmlQNVc1bFVUcm94dnlvOHZaZkJ2?=
 =?utf-8?B?YnlHSHN3Q2RzcVh2OUQvQ281Zi9uNHo5NndnZzNsRWowM1NsZmJPT0lzWWtR?=
 =?utf-8?B?c2doUk5peGF6anVoWU1Uc0xYN1pRR1dMbnhFMmFTeDdSUzJ2WjQrVGhqY28y?=
 =?utf-8?B?eHFrd3d5VDlRR2JkYmNvVzZZdm5PNE54NnJtaE40RWxGZVY3U21YMkdxeE13?=
 =?utf-8?B?cm1lUzdmMVVFQ3A4L21vaXRKNVc4NzdUekh3ZURvMmc0KzVNQXJmOTRlWDZz?=
 =?utf-8?B?QWc3Z2RkZFJLaHgwbEYraUptRFg4U2xaSitRR3BHemRxbFMwa2FJVVJLMWti?=
 =?utf-8?B?ZnBaT1hNVHRkTHgxRlRRZjVuN1hlZisyVkhhZWV1TjlaWnEzT2h4KzUrdVZM?=
 =?utf-8?B?OWQxclZyUXNwNmlsb3JralIrVDFtbkJBdkMxUVdMem94MEtDUWtZVmNmaVF1?=
 =?utf-8?B?U1UwY05DQ0E3Tkt0N2FGYjRLZVhqTjBIc0w5YWpQMkw4RVQ1ODZTYS9yQmh3?=
 =?utf-8?B?UzhaTWpQeG81Zk9rQVI1VW9mSElsTDhNSUlqdDZNNE1lMzFPTE54K2JNYnMv?=
 =?utf-8?B?V1Faa3pQRzdBRCtRbS90cFpFeU5HWG95THVGaGpJcFNpbExCWm93bU5UVFQx?=
 =?utf-8?B?cnZ2TDBmNzhOMUZJWGVrRGErMEtKWlc1RXpodHVUcGZNR0ZLNW9NcTVXMDhK?=
 =?utf-8?B?cVJpVlZUU3JPOS84eDdwOFRvKzlMblg0aThqTjVoTWtrdmF2V2xwRGhDbzU2?=
 =?utf-8?B?aFpOVmk4R0NRUjlzdG1rMlpLazc4MUJhUlFickVLQURobURremZ5SENMQ3RU?=
 =?utf-8?B?SDFyOXQyNE52Mll4SE5zV2l5US81SU5WMTZhaVJMY3N5R082SmhWZmd6SmFL?=
 =?utf-8?B?SlNiZWVpU1Y2VXcxNXdWY0M2bkRCdWlNbWY2bFZyMU9mTUdXeUV3bUlOdTRN?=
 =?utf-8?B?UlhzTHhJaUxXTmMxbUJZaXNyMXdOUzU3SGpyY2dsM0Y4eWdmSzU2YjRlUDV1?=
 =?utf-8?B?RDdsN0dZY3ZFVnROZ1ZaNlVrZE4zVTJIWEQ3VXZ2aUJ5RzNkb0RFN1Exb1F0?=
 =?utf-8?B?Q3BJYzlnZDdHNkprU3pnV1JQcnBobUJ0WVo5Q3ZYZUxJcWVPaGUwcUREdVIz?=
 =?utf-8?B?Q2hpbkxEZTI3ZHBaeXVseWkrTkRXWlRLRkhhQ0I1OXZNeFhoK1U2b3JqeHBu?=
 =?utf-8?B?RlVxY1FSVDRoTVdGcUoyQm5CTk1GZDl6R2tSUk9USjl6RVozbkJrS0dtQ3Vm?=
 =?utf-8?B?QWRNRWUvTTZEU0FRSFIxM3pOWklXZEJicWlBQlRsZi8zeTg1bFJoNW14eEVk?=
 =?utf-8?B?bHg4a0JFUmZPRVdlZVRkaXBWdEVlTlIzc3hnazZKdWNXTjUwejhjaGU1VlIv?=
 =?utf-8?B?eXJIK1dUMHlTNktXQWlLSUlMWUN0Y1VYUUNTVGpYWTRVMHJORVFJUVN1WkMr?=
 =?utf-8?Q?8gqJeDdoHtD3lO/2I7z4qvuirarhotNl9WtF5RZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <71CE85647DA8DA4E9A22EE3875DC1596@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de8d45f-5a7e-4dfa-35da-08d90c014170
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 17:56:18.0406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3Phc3IOAWhCdeTN+6bfcE30DRRHrYniZkdTKK68lsxBm+n6QfUpjkMM6HuLsF5zX7n9kceIIqcHJfiux3Nkcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1146
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTMwIGF0IDEwOjI0IC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3Jv
dGU6DQo+IEhpIFRyb25kLA0KPiANCj4gSSBoYXZlIGEgcXVlc3Rpb24gYmVsb3c6DQo+IA0KPiBP
biA0LzMwLzIxIDU6NDIgQU0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBGcmksIDIw
MjEtMDQtMzAgYXQgMDE6MDkgLTA0MDAsIERhaSBOZ28gd3JvdGU6DQo+ID4gPiBDdXJyZW50bHkg
Y2FuX29wZW5fY2FjaGVkIGFjY2Vzc2VzIHRoZSBvcGVuc3RhdGUncyBmbGFncyB3aXRob3V0DQo+
ID4gPiB0aGUNCj4gPiA+IHNvX2xvY2sgYW5kIGFsc28gZG9lcyBub3QgdXBkYXRlIHRoZSBmbGFn
cyBvZiB0aGUgY2FjaGVkIHN0YXRlLg0KPiA+ID4gVGhpcw0KPiA+ID4gcmVzdWx0cyBpbiB0aGUg
b3BlbnN0YXRlJ3MgZmxhZ3MgYmUgb3V0IG9mIHN5bmMgd2hpY2ggY2FuIGNhdXNlDQo+ID4gPiB0
aGUNCj4gPiA+IGZpbGUgdG8gYmUgY2xvc2VkIHByZW1hdHVyZWx5Lg0KPiA+ID4gDQo+ID4gPiBU
aGlzIHBhdGNoIGFkZHMgdGhlIG1pc3Npbmcgc29fbG9jayBhcm91bmQgdGhlIGNhbGwgdG8NCj4g
PiA+IGNhbl9vcGVuX2NhY2hlZA0KPiA+ID4gYW5kIGFsc28gdXBkYXRlcyB0aGUgb3BlbnN0YXRl
J3MgZmxhZ3MgaWYgdGhlIGNhY2hlZCBvcGVuc3RhdGUgaXMNCj4gPiA+IHVzZWQuDQo+ID4gPiAN
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhaSBOZ28gPGRhaS5uZ29Ab3JhY2xlLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gwqDCoGZzL25mcy9uZnM0cHJvYy5jIHwgOCArKysrKysrLQ0KPiA+ID4gwqDC
oDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0K
PiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMN
Cj4gPiA+IGluZGV4IGM2NWM0YjQxZTJjMS4uMjQ2NGU3N2M1MWY5IDEwMDY0NA0KPiA+ID4gLS0t
IGEvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4g
PiBAQCAtMjQxMCw5ICsyNDEwLDE1IEBAIHN0YXRpYyB2b2lkIG5mczRfb3Blbl9wcmVwYXJlKHN0
cnVjdA0KPiA+ID4gcnBjX3Rhc2sNCj4gPiA+ICp0YXNrLCB2b2lkICpjYWxsZGF0YSkNCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoGlmIChkYXRhLT5zdGF0ZSAhPSBOVUxMKSB7DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG5mc19kZWxlZ2F0aW9uICpkZWxl
Z2F0aW9uOw0KPiA+ID4gwqAgDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
c3Bpbl9sb2NrKCZkYXRhLT5zdGF0ZS0+b3duZXItPnNvX2xvY2spOw0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChjYW5fb3Blbl9jYWNoZWQoZGF0YS0+c3RhdGUs
IGRhdGEtDQo+ID4gPiA+b19hcmcuZm1vZGUsDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZGF0YS0+b19hcmcub3Blbl9mbGFncywNCj4gPiA+IGNsYWltKSkNCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRhdGEt
Pm9fYXJnLm9wZW5fZmxhZ3MsIGNsYWltKSkgew0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1cGRhdGVfb3Blbl9zdGF0ZWZsYWdzKGRhdGEtPnN0
YXRlLCBkYXRhLQ0KPiA+ID4gPiBvX2FyZy5mbW9kZSk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNwaW5fdW5sb2NrKCZkYXRhLT5zdGF0ZS0+
b3duZXItDQo+ID4gPiA+c29fbG9jayk7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X25vX2FjdGlvbjsNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9DQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3Bpbl91bmxvY2soJmRhdGEtPnN0YXRlLT5vd25lci0+c29fbG9jayk7DQo+ID4g
PiArDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmN1X3JlYWRfbG9j
aygpOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRlbGVnYXRpb24g
PSBuZnM0X2dldF92YWxpZF9kZWxlZ2F0aW9uKGRhdGEtDQo+ID4gPiA+c3RhdGUtDQo+ID4gPiA+
IGlub2RlKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoY2Fu
X29wZW5fZGVsZWdhdGVkKGRlbGVnYXRpb24sIGRhdGEtDQo+ID4gPiA+b19hcmcuZm1vZGUsDQo+
ID4gPiBjbGFpbSkpDQo+ID4gVGhpcyBpcyBnb2luZyB0byBpbnRyb2R1Y2Ugc3RhdGVpZCBsZWFr
cy4gVGhlIGFjdHVhbCB1cGRhdGUgb2YgdGhlDQo+ID4gb3Blbg0KPiA+IHN0YXRlIGZsYWdzIGhh
cHBlbnMgaW4gbmZzNF90cnlfb3Blbl9jYWNoZWQoKSwgd2hpY2ggaXMgY2FsbGVkIGZyb20NCj4g
PiBuZnM0X29wZW5kYXRhX3RvX25mczRfc3RhdGUoKS4NCj4gPiANCj4gPiBXaGlsZSB3ZSBjb3Vs
ZCBwdXQgc3BpbmxvY2tzIGFyb3VuZCB0aGUgY2FsbCB0byBjYW5fb3Blbl9jYWNoZWQoKQ0KPiA+
IGhlcmUsDQo+ID4gdGhlcmUgaXMgbGl0dGxlIHBvaW50IGluIGRvaW5nIHNvLCBzaW5jZSB0aGlz
IGlzIGp1c3QgYSByZWFkLW9ubHkNCj4gPiBhZHZpc29yeSBjaGVjay4gVGhlIHJlYWwgY2hlY2sg
aXMgcGVyZm9ybWVkLCBhcyBJIHNhaWQsIGluDQo+ID4gbmZzNF90cnlfb3Blbl9jYWNoZWQoKS4N
Cj4gDQo+IElmIHdlIHdhaXQgdG8gdXBkYXRlIHRoZSBmbGFncyBpbiBfbmZzNF9vcGVuZGF0YV90
b19uZnM0X3N0YXRlIGFmdGVyDQo+IHRoZQ0KPiBSUEMgdGhyZWFkIGRlY2lkZXMgdG8gdXNlIHRo
ZSBjYWNoZWQgc3RhdGUsIHRoZSBmaWxlIGNvdWxkIGJlIGNsb3NlZA0KPiBieQ0KPiBhbm90aGVy
IHRocmVhZCBiZWZvcmUgX25mczRfb3BlbmRhdGFfdG9fbmZzNF9zdGF0ZSBpcyBjYWxsZWQgYnkN
Cj4gYW5vdGhlcg0KPiB0aHJlYWQuIFRoZSBjbGllbnQgaW4gdGhpcyBjYXNlIHdpbGwgcmV0cnkg
dGhlIG9wZW4gZnJvbSBuZnM0X2RvX29wZW4NCj4gYW5kDQo+IGV2ZXJ5dGhpbmcgaXMgb2suDQo+
IA0KPiBIb3dldmVyLCBpZiB3ZSB1cGRhdGUgdGhlIGZsYWdzIG5mczRfb3Blbl9wcmVwYXJlIHRo
ZW4gaXQgd2lsbA0KPiBwcmV2ZW50DQo+IHRoZSBmaWxlIGZyb20gYmVpbmcgY2xvc2VkIGFuZCB0
aGlzIHNhdmVzIG9uZSBDTE9TRSBhbmQgb25lIE9QRU4gcnBjDQo+IHJlcXVlc3QgdG8gdGhlIHNl
cnZlci7CoCBJcyB0aGlzIGNvcnJlY3QgYW5kIGlzIGl0IHdvcnRoIGl0IHRvDQo+IGNvbnNpZGVy
DQo+IGRvaW5nIGFueXRoaW5nIHNpbmNlIHRoaXMgaXMgYSByYXJlIHNjZW5hcmlvPw0KPiA+IA0K
DQpJZiB5b3UncmUgaW4gYSBzY2VuYXJpbyB3aGVyZSBzZXZlcmFsIHByb2Nlc3NlcyBhcmUgYWNj
ZXNzaW5nIHRoZSBzYW1lDQpmaWxlIG9uIHRoZSBzYW1lIE5GUyBjbGllbnQsIHlvdSBwcm9iYWJs
eSB3YW50IHRvIHNlZSB0aGUgc2VydmVyIGhhbmQNCm91dCBhIGRlbGVnYXRpb24gZm9yIHRoYXQg
ZmlsZSByYXRoZXIgdGhhbiBrZWVwIHJlbHlpbmcgb24gT1BFTi9DTE9TRS4NClRoYXQncyBhY3R1
YWxseSB3aHkgd2Ugc3RhcnRlZCB1c2luZyBuZnM0X3RyeV9vcGVuX2NhY2hlZCgpLiBUaGUNCmlu
dGVudGlvbiB3YXMgdGhhdCBpdCBtYWlubHkgbWFuYWdlcyB0aGUgZGVsZWdhdGVkIG9wZW4gY2Fz
ZS4gV2UgdGhlbg0KYWRkZWQgc3VwcG9ydCBmb3IgdGhlIG5vbi1kZWxlZ2F0ZWQgY2FzZSBtYWlu
bHkgYmVjYXVzZSB0aGUgTGludXgNCnNlcnZlciBkb2Vzbid0IHN1cHBvcnQgd3JpdGUgZGVsZWdh
dGlvbnMgYW5kIGJlY2F1c2UgdGhlcmUgd2VyZSBjb3JuZXINCmNhc2VzIHdoZXJlIGZpbGVzIHdl
cmUgYmVpbmcgb3BlbmVkL2Nsb3NlZCBieSBtdWx0aXBsZSBwcm9jZXNzZXMNCndpdGhvdXQgYSBk
ZWxlZ2F0aW9uLg0KDQpTbyB3aGF0IEknbSBzYXlpbmcgaXMgdGhhdCBpZGVhbGx5IHdlIHJlYWxs
eSB3YW50IHRvIGNvbmNlbnRyYXRlIG9uDQpmaXhpbmcgdGhlIExpbnV4IHNlcnZlciB0byBzdXBw
b3J0IHdyaXRlIGRlbGVnYXRpb25zIHNvIHRoYXQgd2UgY2FuDQpyZWxlZ2F0ZSBtb3N0IG9mIHRo
aXMgY29kZSB0byBoYW5kbGluZyBjb3JuZXIgY2FzZXMuDQoNCk1ha2Ugc2Vuc2U/DQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
