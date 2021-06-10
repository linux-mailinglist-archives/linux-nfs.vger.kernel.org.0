Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF53A2F54
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jun 2021 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhFJPcD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Jun 2021 11:32:03 -0400
Received: from mail-dm6nam10on2095.outbound.protection.outlook.com ([40.107.93.95]:53473
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231365AbhFJPcB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 10 Jun 2021 11:32:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ4k4L7lWHjmG2cy94aNmTxbRC1DIXel282e5B0MKsXROQuNhh8N/frmQSST+52fOC86+XIC8hujNDr5aD4MkuY7z0rdvRKlv/gvcI7ZR1lqSbhAkEgi6ir8DhxMqAjY/Nzo+hjTbYwLnp+h5fnZPQEwRfWpqAyinXkAJw5MR1akZLokiy4+B110+/h4IAQUgpBWVcrRzYur15Ql/oXkqrj+v/T3Nku4ffR3Zv8aGZmOjvTgQfUvWqTyJpEv3LsPDgC9JbyPqddkOlgLZ2f6s7IiNs+dLrl+lefjQrgmS4vRYwrR808IOqXzFLMS64paDCNGGEC87zlvDi0E9lIbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcmsepjvLAMf80nstYIhooxRlFzB8Lb9w1EAAgsMXmM=;
 b=nHUuXpCy5GYuojTOf2VLlkRMaxYbYn8D5CN2UuyM0/qP9JFKd0spVgUmieNeg+HhXAC/WgeE85qMl8rcfs30AxJNhvY7IJvt/+tGV1S2ZFVu9Pa/d/RxxaY1snsl2Nhon1rBjkwMR3kbeb68Tq2VMv9UKaXPT0OV/HgrDV9DHCAZ+dTVh82jOr6SuirCw6OAlP/r5jfPj8PcuyhE1nYGSR0yC9/uM255mV+ZzpfrF9BqwdkHgSoZlxWpykomlxMC+weuTRipF5EkJuPEKYZJxIJ9QmzBaCPt72VhqPPtUsn7H/p9kPTlac8fWswthTPjdv+7Tbfg7tfVNSSZjs0nSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcmsepjvLAMf80nstYIhooxRlFzB8Lb9w1EAAgsMXmM=;
 b=J7TBW0ZNfT1k97N1SFKmb3fQfQiVwJNJGlVS8Jg6GP/Dxl9rDuxROQ5cO4XPh3G+StfoHhzqzKRgR2JTc0FMBx0UOyX7SCUUtSQCgcJpLGHia/Y8kH08kKhvST6mIjS78MKFyA1jclsmeOgmh/Lap+ZUSqIqMfjlHhBx5+s2QRg=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9; Thu, 10 Jun
 2021 15:30:02 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4242.012; Thu, 10 Jun 2021
 15:30:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Topic: [PATCH v2 2/3] NFSv4 introduce max_connect mount options
Thread-Index: AQHXXXnh3WIMdJRfJ0KF+q50bEsARasNPoYAgAABKgCAAAY7AIAACRaAgAAGNoCAAALogIAAB+AA
Date:   Thu, 10 Jun 2021 15:30:02 +0000
Message-ID: <ccd48bfd2ccf9b2978d578963609ff03bcce8bee.camel@hammerspace.com>
References: <20210609215319.5518-1-olga.kornievskaia@gmail.com>
         <20210609215319.5518-3-olga.kornievskaia@gmail.com>
         <6C64456A-931F-4CAD-A559-412A12F0F741@oracle.com>
         <6bca80de292b5aa36734e7d942d0e9f53430903b.camel@hammerspace.com>
         <83D9342E-FDAF-4B2C-A518-20BF0A9AD073@oracle.com>
         <CAN-5tyGKiT9NESQUq_PxUonf565jw7ENJUa=KmQDDiNGVB1ekg@mail.gmail.com>
         <1902AFD9-76B8-44F2-928C-C830CDFAA33B@oracle.com>
         <CAN-5tyEFtOa97+vdCeCyHtdub8n5zHSP8sv7Zv2CCnd_duv5fg@mail.gmail.com>
In-Reply-To: <CAN-5tyEFtOa97+vdCeCyHtdub8n5zHSP8sv7Zv2CCnd_duv5fg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe2b726a-986d-426f-596a-08d92c249dc3
x-ms-traffictypediagnostic: DS7PR13MB4733:
x-microsoft-antispam-prvs: <DS7PR13MB47333D324DB5672B205E7943B8359@DS7PR13MB4733.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Atn0zWJNycbO9boSQ+uIVE2RGm3sGv4xvXYn4Kia98P+oEbUUMmCVkWHQN7PQ/aX4imFBQsORIBw6SWR/RBImUzT59jZY4IMegChOK7pnBtMkUeEcw3YRDEH3gvY2qfuM1Nauy8m8i4/m0kBzh9gJXZW8PLCA/4QWvognWDQtdCoGnWZuLlylEAF57sf7F82EzCFzmbPwi9TiKoNrqfJwgUqsFbLVAuOeZk3wdV5iHscXJpX5PDlrUdx1bUrVrNIkQ6Kj6bveiNxSLfS/mOxwY5Ou79ACThirYMMR3HZ33VqL/I0gwilvhE6QXUoj2iidkVCgEcDH1eGQlUCdT40JmagJKgDHdQqkNEhkoAhGe3QWab3xKqjRWf+4SS0sPP8VHI6fjhYrW9frNxackhYLybaqi4r3AoL0sit2zrgKsQhMdcZI0xWNrRvPeqpwtXNR2pfWEwNB+Ebp4R7yKvtELqA1zmsLPc9oZqn1mgnMDolOTPVMEc0NXrkFwANGBjRwiquNHeqpfWGohqxu4CPjdrZE+6RMCw752JPdm1AQof/pN0YUwMZ2WLDBIMHM6RpmCnJVC4x2dJYxYtN+GtX256GspzFvFxrUuT9WWsjU6s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(76116006)(8936002)(122000001)(66476007)(8676002)(66446008)(64756008)(54906003)(26005)(66556008)(36756003)(110136005)(91956017)(66946007)(38100700002)(6486002)(498600001)(6506007)(2906002)(4326008)(53546011)(83380400001)(5660300002)(2616005)(186003)(6512007)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STNVWWJqU3hVdzJrSDFpNWhHYkNsQk41bEoraXhYL3AyanlYaE5XdjBCclN6?=
 =?utf-8?B?REMwa21DSksrL3ZIODVwQlUwM3gzUlZTckoyNXgxZ2NPdEhEM3AzZTBBb0ty?=
 =?utf-8?B?cmhkUk9PcTFDaUR2L3hBUEdqZmR1dXpkS1hodlVuS3lvMFFnTXdSaVc5THgx?=
 =?utf-8?B?Z1llMm9wT3BoNFhpSGp1RGh1dHQ2TW03N0hnTkV6VWhmMitnbUNINGhOejZY?=
 =?utf-8?B?M0pMZ0VpbG1YR2p5ZXRXaXVBdGdUSTh4ODh5WmFUNGJHeWZOU0laamhuZUNF?=
 =?utf-8?B?NDZWSjFNVSsrT2tBSThuYlpkYTA2ZkE5WGtncmRUTHZTSVR4UjRTdEdMRk9Y?=
 =?utf-8?B?eUFqNWFqQVIxbE52ZlZDMkdKQXdycDVUZHBsY0tlVUZmaWhlYW83Z09JdnVj?=
 =?utf-8?B?Rjhmd3RGSU0rRTRsbFpPZ1dhOGxTQThaWjQ5OXArRDlPTis5REpQTENoMDFK?=
 =?utf-8?B?Um4wM2lzWkptb29MUVlXV3c0NW45M3ZrU2g4NitndTkvRnovNHh5R1IyYlFt?=
 =?utf-8?B?djRZeHYrOG1XVjdJRk1RWlR1UVBYNTBMZ0RkUEc5anIxZlh0SGhkbEVPQ3Vo?=
 =?utf-8?B?Tk9NQVMvSXYvTElsNkRleTROakpkZXRsRzk0K0VzdU9XL2tjTnF1b1NnVUpX?=
 =?utf-8?B?NHo4L0NMMG1YdmFRVEk3N0FkNXlQWlpMc2t0ek94bVBXbFdjVWo3T1lFMXZz?=
 =?utf-8?B?NnlDRGtYTmJQSWt5Tk9FMGtNOWlBUGk1Qjg2SUxwZGs4M0xYSCtqa1lGNVk0?=
 =?utf-8?B?amQyejQ5dXArVkJGQWthOE1yQ1p3R3FCTkZXOVA4cW5CRkdnaXVaMHZ3OVEw?=
 =?utf-8?B?bUZWNmxCUGYzd083VFFVQzdZSmYvcWxlei9JTmFtSFlSRjhiZi81MmI4NUhz?=
 =?utf-8?B?c0IxcFdiWFptd3E5ZlZMQUpWOEhocDBOM0VtbVBOb1VMZmhtOWpJbHBUc00x?=
 =?utf-8?B?RVhtUyswSk1LT1QvVVYvZlkyaUpjYTBJdk1NV3lLeDVnMFJJa0k1Z1h3d0RT?=
 =?utf-8?B?RWZaS3IrQkthUTBDS3lyTFJHTXJRWE1CVFFoWVNGTVk2MUNLQlNjNy9id29F?=
 =?utf-8?B?eGpyRHN3dEJEWFVqdWdNZXFud0hKaVhFN2F6bEZZZDg1R2RBcDd3Z2lScG9Z?=
 =?utf-8?B?UElYTkFMMDEzNlh5bkMyV3NkV3ZtUjZyNEIyRko5clFxVUJuVmR3NTRiT1h6?=
 =?utf-8?B?QXZCY2RyZ1FzaVV4MktLcjBPK011SzgzZXJoWUpNZTUxNnBJNTdBenZYbVlh?=
 =?utf-8?B?NnpwMFBHMVliMDdTTEJPM2tnUlltUURnY0QyeTRyVE9FZEsxamU3Ti9MVVZL?=
 =?utf-8?B?M1FmUEhqRk1pNUgxcDRIQ0oxdnAvY2d4MXFadXlkODhtdi9MRzF5TmQ1Umw3?=
 =?utf-8?B?UEVHVUY2T1JZd0FpUnI4Ym9xOWR2c2c5YkpuS0h1WDB0enEybG8vZXZkeTJy?=
 =?utf-8?B?eGhycFVUY2lQZU1La3dYYXF1Uzg5aWVEdGJPamNhbVRjZnRVQU9MWVdNeTVL?=
 =?utf-8?B?V1Vjc1RjcmFGUEdSVjNUbm9mbHZVS1haeXBXVlZxdW1IWEVXUzJjbzNTaUJE?=
 =?utf-8?B?QXMxUVNLdkhQQWxmc3M0VGI4ZTVkYVRjNmxiVjJYc2VsWS9PUlFGdmRVcFZh?=
 =?utf-8?B?MjAyb3EvaVc2YlhQMlNKTXUwZzltVEZ5S2I5dFpyZ09lL0VSTHNWdngydzk1?=
 =?utf-8?B?SjA3eGRmbEMvTW9vN3RaT0xvdjFFOUVCT1hEYVR4WTJFaEtSaUJ4dWJ3T0Yv?=
 =?utf-8?Q?WeTkIloR6JKL69b/aArVNDJEsT12sdOOLhrYu3A?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E67CD7BB4EAC6B45B7CE7FFBBFE16143@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b726a-986d-426f-596a-08d92c249dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 15:30:02.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hhw9JLNRBvddV6SCInu3v8V/mPjubQGpssSGwhKJeJywtKDEUVe2ezXVy9ywuSfCZoXE7XvKF4DyMaSNuCLJuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4733
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTEwIGF0IDExOjAxIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMTAsIDIwMjEgYXQgMTA6NTEgQU0gQ2h1Y2sgTGV2ZXIgSUlJIDwN
Cj4gY2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4g
PiBPbiBKdW4gMTAsIDIwMjEsIGF0IDEwOjI5IEFNLCBPbGdhIEtvcm5pZXZza2FpYSA8DQo+ID4g
PiBvbGdhLmtvcm5pZXZza2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBU
aHUsIEp1biAxMCwgMjAyMSBhdCA5OjU2IEFNIENodWNrIExldmVyIElJSSA8DQo+ID4gPiBjaHVj
ay5sZXZlckBvcmFjbGUuY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAN
Cj4gPiA+ID4gPiBPbiBKdW4gMTAsIDIwMjEsIGF0IDk6MzQgQU0sIFRyb25kIE15a2xlYnVzdCA8
DQo+ID4gPiA+ID4gdHJvbmRteUBoYW1tZXJzcGFjZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IE9uIFRodSwgMjAyMS0wNi0xMCBhdCAxMzozMCArMDAwMCwgQ2h1Y2sgTGV2ZXIg
SUlJIHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24g
SnVuIDksIDIwMjEsIGF0IDU6NTMgUE0sIE9sZ2EgS29ybmlldnNrYWlhIDwNCj4gPiA+ID4gPiA+
ID4gb2xnYS5rb3JuaWV2c2thaWFAZ21haWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0K
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhpcyBvcHRpb24gd2lsbCBjb250cm9sIHVw
IHRvIGhvdyBtYW55IHhwcnRzIGNhbiB0aGUNCj4gPiA+ID4gPiA+ID4gY2xpZW50DQo+ID4gPiA+
ID4gPiA+IGVzdGFibGlzaCB0byB0aGUgc2VydmVyLiBUaGlzIHBhdGNoIHBhcnNlcyB0aGUgdmFs
dWUgYW5kDQo+ID4gPiA+ID4gPiA+IHNldHMNCj4gPiA+ID4gPiA+ID4gdXAgc3RydWN0dXJlcyB0
aGF0IGtlZXAgdHJhY2sgb2YgbWF4X2Nvbm5lY3QuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4N
Cj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+IGZzL25mcy9jbGllbnQuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gPiA+ID4gPiA+ID4gZnMvbmZzL2ZzX2NvbnRleHQuY8Kg
wqDCoMKgwqDCoCB8wqAgOCArKysrKysrKw0KPiA+ID4gPiA+ID4gPiBmcy9uZnMvaW50ZXJuYWwu
aMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKysNCj4gPiA+ID4gPiA+ID4gZnMvbmZzL25mczRjbGll
bnQuY8KgwqDCoMKgwqDCoCB8IDEyICsrKysrKysrKystLQ0KPiA+ID4gPiA+ID4gPiBmcy9uZnMv
c3VwZXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKysNCj4gPiA+ID4gPiA+ID4gaW5j
bHVkZS9saW51eC9uZnNfZnNfc2IuaCB8wqAgMSArDQo+ID4gPiA+ID4gPiA+IDYgZmlsZXMgY2hh
bmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9mcy9uZnMvY2xpZW50LmMgYi9mcy9uZnMvY2xpZW50
LmMNCj4gPiA+ID4gPiA+ID4gaW5kZXggMzMwZjY1NzI3YzQ1Li40ODZkZWM1OTk3MmIgMTAwNjQ0
DQo+ID4gPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9jbGllbnQuYw0KPiA+ID4gPiA+ID4gPiArKysg
Yi9mcy9uZnMvY2xpZW50LmMNCj4gPiA+ID4gPiA+ID4gQEAgLTE3OSw2ICsxNzksNyBAQCBzdHJ1
Y3QgbmZzX2NsaWVudA0KPiA+ID4gPiA+ID4gPiAqbmZzX2FsbG9jX2NsaWVudChjb25zdA0KPiA+
ID4gPiA+ID4gPiBzdHJ1Y3QgbmZzX2NsaWVudF9pbml0ZGF0YSAqY2xfaW5pdCkNCj4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCBjbHAtPmNsX3Byb3RvID0gY2xfaW5p
dC0+cHJvdG87DQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCBjbHAtPmNsX25jb25uZWN0ID0g
Y2xfaW5pdC0+bmNvbm5lY3Q7DQo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgY2xwLT5jbF9t
YXhfY29ubmVjdCA9IGNsX2luaXQtPm1heF9jb25uZWN0ID8NCj4gPiA+ID4gPiA+ID4gY2xfaW5p
dC0NCj4gPiA+ID4gPiA+ID4gPiBtYXhfY29ubmVjdCA6IDE7DQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IFNvLCAxIGlzIHRoZSBkZWZhdWx0IHNldHRpbmcsIG1lYW5pbmcgdGhlICJhZGQgYW5v
dGhlcg0KPiA+ID4gPiA+ID4gdHJhbnNwb3J0Ig0KPiA+ID4gPiA+ID4gZmFjaWxpdHkgaXMgZGlz
YWJsZWQgYnkgZGVmYXVsdC4gV291bGQgaXQgYmUgbGVzcw0KPiA+ID4gPiA+ID4gc3VycHJpc2lu
ZyBmb3INCj4gPiA+ID4gPiA+IGFuIGFkbWluIHRvIGFsbG93IHNvbWUgZXh0cmEgY29ubmVjdGlv
bnMgYnkgZGVmYXVsdD8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoCBjbHAtPmNsX25ldCA9IGdldF9uZXQoY2xfaW5pdC0+bmV0KTsNCj4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoCBjbHAtPmNsX3ByaW5jaXBhbCA9
ICIqIjsNCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9mc19jb250ZXh0LmMgYi9m
cy9uZnMvZnNfY29udGV4dC5jDQo+ID4gPiA+ID4gPiA+IGluZGV4IGQ5NWM5YTM5YmM3MC4uY2Zi
ZmY3MDk4ZjhlIDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9mcy9uZnMvZnNfY29udGV4dC5j
DQo+ID4gPiA+ID4gPiA+ICsrKyBiL2ZzL25mcy9mc19jb250ZXh0LmMNCj4gPiA+ID4gPiA+ID4g
QEAgLTI5LDYgKzI5LDcgQEANCj4gPiA+ID4gPiA+ID4gI2VuZGlmDQo+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiAjZGVmaW5lIE5GU19NQVhfQ09OTkVDVElPTlMgMTYNCj4gPiA+ID4gPiA+
ID4gKyNkZWZpbmUgTkZTX01BWF9UUkFOU1BPUlRTIDEyOA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBUaGlzIG1heGltdW0gc2VlbXMgZXhjZXNzaXZlLi4uIGFnYWluLCB0aGVyZSBhcmUNCj4g
PiA+ID4gPiA+IGRpbWluaXNoaW5nDQo+ID4gPiA+ID4gPiByZXR1cm5zIHRvIGFkZGluZyBtb3Jl
IGNvbm5lY3Rpb25zIHRvIHRoZSBzYW1lIHNlcnZlci4NCj4gPiA+ID4gPiA+IHdoYXQncw0KPiA+
ID4gPiA+ID4gd3Jvbmcgd2l0aCByZS11c2luZyBORlNfTUFYX0NPTk5FQ1RJT05TIGZvciB0aGUg
bWF4aW11bT8NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQXMgYWx3YXlzLCBJJ20gYSBsaXR0
bGUgcXVlYXN5IGFib3V0IGFkZGluZyB5ZXQgYW5vdGhlcg0KPiA+ID4gPiA+ID4gbW91bnQNCj4g
PiA+ID4gPiA+IG9wdGlvbi4gQXJlIHRoZXJlIHJlYWwgdXNlIGNhc2VzIHdoZXJlIGEgd2hvbGUt
Y2xpZW50DQo+ID4gPiA+ID4gPiBzZXR0aW5nDQo+ID4gPiA+ID4gPiAobGlrZSBhIHN5c2ZzIGF0
dHJpYnV0ZSkgd291bGQgYmUgaW5hZGVxdWF0ZT8gSXMgdGhlcmUgYQ0KPiA+ID4gPiA+ID4gd2F5
DQo+ID4gPiA+ID4gPiB0aGUgY2xpZW50IGNvdWxkIGZpZ3VyZSBvdXQgYSByZWFzb25hYmxlIG1h
eGltdW0gd2l0aG91dCBhDQo+ID4gPiA+ID4gPiBodW1hbiBpbnRlcnZlbnRpb24sIHNheSwgYnkg
Y291bnRpbmcgdGhlIG51bWJlciBvZiBOSUNzIG9uDQo+ID4gPiA+ID4gPiB0aGUgc3lzdGVtPw0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9oLCBoZWxsIG5vISBXZSdyZSBub3QgdHlpbmcgYW55dGhp
bmcgdG8gdGhlIG51bWJlciBvZg0KPiA+ID4gPiA+IE5JQ3MuLi4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoYXQncyBhIGJpdCBvZiBhbiBvdmVyLXJlYWN0aW9uLiA6LSkgQSBsaXR0bGUgbW9yZSBleHBs
YW5hdGlvbg0KPiA+ID4gPiB3b3VsZCBiZSB3ZWxjb21lLiBJIG1lYW4sIGRvbid0IHlvdSBleHBl
Y3Qgc29tZW9uZSB0byBhc2sgIkhvdw0KPiA+ID4gPiBkbyBJIHBpY2sgYSBnb29kIHZhbHVlPyIg
YW5kIHNvbWVvbmUgbWlnaHQgcmVhc29uYWJseSBhbnN3ZXINCj4gPiA+ID4gIldlbGwsIHN0YXJ0
IHdpdGggdGhlIG51bWJlciBvZiBOSUNzIG9uIHlvdXIgY2xpZW50IHRpbWVzIDMiIG9yDQo+ID4g
PiA+IHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ID4gPiANCj4gPiA+IFRoYXQncyB3aGF0IEkgd2Fz
IHRoaW5raW5nIGFuZCB0aGFuayB5b3UgZm9yIGF0IGxlYXN0IGNvbnNpZGVyaW5nDQo+ID4gPiB0
aGF0DQo+ID4gPiBpdCdzIGEgcmVhc29uYWJsZSBhbnN3ZXIuDQo+ID4gPiANCj4gPiA+ID4gSU1P
IHdlJ3JlIGFib3V0IHRvIGFkZCBhbm90aGVyIGFkbWluIHNldHRpbmcgd2l0aG91dA0KPiA+ID4g
PiB1bmRlcnN0YW5kaW5nDQo+ID4gPiA+IGhvdyBpdCB3aWxsIGJlIHVzZWQsIGhvdyB0byBzZWxl
Y3QgYSBnb29kIG1heGltdW0gdmFsdWUsIG9yDQo+ID4gPiA+IGV2ZW4NCj4gPiA+ID4gd2hldGhl
ciB0aGlzIG1heGltdW0gbmVlZHMgdG8gYmUgYWRqdXN0YWJsZS4gSW4gYSBwcmV2aW91cyBlLQ0K
PiA+ID4gPiBtYWlsDQo+ID4gPiA+IE9sZ2EgaGFzIGFscmVhZHkgZGVtb25zdHJhdGVkIHRoYXQg
aXQgd2lsbCBiZSBkaWZmaWN1bHQgdG8NCj4gPiA+ID4gZXhwbGFpbg0KPiA+ID4gPiBob3cgdG8g
dXNlIHRoaXMgc2V0dGluZyB3aXRoIG5jb25uZWN0PS4NCj4gPiA+IA0KPiA+ID4gSSBhZ3JlZSB0
aGF0IHVuZGVyc3RhbmRpbmcgb24gaG93IGl0IHdpbGwgYmUgdXNlZCBpcyB1bmtub3duIG9yDQo+
ID4gPiB1bmRlcnN0b29kIGJ1dCBJIHRoaW5rIG5jb25uZWN0IGFuZCBtYXhfY29ubmVjdCByZXBy
ZXNlbnQNCj4gPiA+IGRpZmZlcmVudA0KPiA+ID4gY2FwYWJpbGl0aWVzLiBJIGFncmVlIHRoYXQg
YWRkaW5nIG5jb25uZWN0IHRyYW5zcG9ydHMgbGVhZHMgdG8NCj4gPiA+IGRpbWluaXNoaW5nIHJl
dHVybnMgYWZ0ZXIgYSBjZXJ0YWluIChyZWxhdGl2ZWx5IGxvdykgbnVtYmVyLg0KPiA+ID4gSG93
ZXZlciwNCj4gPiA+IEkgZG9uJ3QgYmVsaWV2ZSB0aGUgc2FtZSBob2xkcyBmb3Igd2hlbiB4cHJ0
cyBhcmUgZ29pbmcgb3Zlcg0KPiA+ID4gZGlmZmVyZW50DQo+ID4gPiBOSUNzLiBUaGVyZWZvcmUg
SSBkaWRuJ3QgdGhpbmsgbWF4X2Nvbm5lY3Qgc2hvdWxkIGhhdmUgYmVlbiBib3VuZA0KPiA+ID4g
YnkNCj4gPiA+IHRoZSBzYW1lIG51bWJlcnMgYXMgbmNvbm5lY3QuDQo+ID4gDQo+ID4gVGhhbmtz
IGZvciByZW1pbmRpbmcgbWUsIEkgaGFkIGZvcmdvdHRlbiB0aGUgZGlzdGluY3Rpb24gYmV0d2Vl
bg0KPiA+IHRoZSB0d28gbW91bnQgb3B0aW9ucy4NCj4gPiANCj4gPiBJIHRoaW5rIHRoZXJlJ3Mg
bW9yZSBnb2luZyBvbiB0aGFuIGp1c3QgdGhlIE5JQyAtLSBsb2NrIGNvbnRlbnRpb24NCj4gPiBv
biB0aGUgY2xpZW50IHdpbGwgYWxzbyBiZSBhIHNvbWV3aGF0IGxpbWl0aW5nIGZhY3RvciwgYXMg
d2lsbCB0aGUNCj4gPiBudW1iZXIgb2YgbG9jYWwgQ1BVcyBhbmQgbWVtb3J5IGJhbmR3aWR0aC4g
QW5kIGFzIFRyb25kIHBvaW50cyBvdXQsDQo+ID4gdGhlIG5ldHdvcmsgdG9wb2xvZ3kgYmV0d2Vl
biB0aGUgY2xpZW50IGFuZCBzZXJ2ZXIgd2lsbCBhbHNvIGhhdmUNCj4gPiBzb21lIGltcGFjdC4N
Cj4gPiANCj4gPiBBbmQgSSdtIHRyeWluZyB0byB1bmRlcnN0YW5kIHdoeSBhbiBhZG1pbiB3b3Vs
ZCB3YW50IHRvIHR1cm4gb2ZmDQo+ID4gdGhlICJhZGQgYW5vdGhlciB4cHJ0IiBtZWNoYW5pc20g
LS0gaWUsIHRoZSBsb3dlciBib3VuZC4gV2h5IGlzDQo+ID4gdGhlIGRlZmF1bHQgc2V0dGluZyAx
Pw0KPiANCj4gSSB0aGluayB0aGUgcmVhc29uIGZvciBoYXZpbmcgZGVmYXVsdCBhcyAxIHdhcyB0
byBhZGRyZXNzIFRyb25kJ3MNCj4gY29tbWVudCB0aGF0IHNvbWUgc2VydmVycyBhcmUgc3RydWdn
bGluZyB0byBzdXBwb3J0IG5jb25uZWN0LiBTbyBJJ20NCj4gdHJ5aW5nIG5vdCB0byBmb3JjZSBh
bnkgY3VycmVudCBzZXR1cCB0byBuZWVkaW5nIHRvIGNoYW5nZSB0aGVpcg0KPiBtb3VudA0KPiBz
ZXR1cCB0byBzcGVjaWZpY2FsbHkgc2F5ICJtYXhfY29ubmVjdD0xIi4gSSB3YW50IGVudmlyb25t
ZW50cyB0aGF0DQo+IGNhbiBzdXBwb3J0IHRydW5raW5nIHNwZWNpZmljYWxseSBhbGxvdyBmb3Ig
dHJ1bmtpbmcgYnkgYWRkaW5nIGEgbmV3DQo+IG1vdW50IG9wdGlvbiB0byBpbmNyZWFzZSB0aGUg
bGltaXQuDQo+IA0KPiBJZiB0aGlzIGlzIG5vdCBhIGNvbmNlcm4gdGhlbiBtYXhfY29ubmVjdCdz
IGRlZmF1bHQgY2FuIGp1c3QgYmUgdGhlDQo+IHdoYXRldmVyIGRlZmF1bHQgdmFsdWUgd2UgcGlj
ayBmb3IgdGhlIGl0Lg0KPiANCg0KVGhlIGRlZmF1bHQgbmVlZHMgdG8gcHJlc2VydmUgZXhpc3Rp
bmcgYmVoYXZpb3VyLCBzbyBtYXhfY29ubmVjdD0xIGlzDQpjb3JyZWN0Lg0KDQotLSANClRyb25k
IE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJv
bmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
