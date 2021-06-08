Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEBA3A0752
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 00:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhFHW77 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 18:59:59 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:35040
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230250AbhFHW77 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 8 Jun 2021 18:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhD82mljsgkw/Wq7UuwgCsmJ96h5hVFF8vjLfB9eE+LGQIo/03N8CNSjSQYDD3c0jRScVJ58vnpKP7P36pcXx5LG7lLXo4WQJuL6gtFBnQMnqq+q2iEzSlhp0ScOirjRHRgen70LzPb7Mk3PfuCGLu90qKUSYYrkoM6twbTuA+i77isKIQh2Y3Nm+qdhIWF+0hKaXZ4cDktqjX9Ico9eQBjxWGfiUcFbxTJsptjoQPF3Vwdq4ceE/knkr3akPDUYd745SmgvAlOPQs8NxtTI4Fpy4mjR7FzShBf9GdI+ItT2Xp46HlzAlxamiwAwQxrYSHC9eJ2yV8nH03ZA9LCxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2x/ddev5sZYqeO/aD1m/BDBpFz3RaosWwFLA1cKvaE=;
 b=iXe/ZRGeHHLeCXfoCKyOG8AQNqh1Fs/c+/0e/LiT0KCADE8njbOuOWRN3EwSd6d5Bsjc9QnYl6dK84D6ww+QT2hE55V09h/zK6lkuBFWr59d6FhomEYmv4lxnzJhSXaNP/exWsn8J/2k0dJIufpoZKO/Nuh6ftBPxc88kkAWnYcgR8RNgr5fsHEBrK4MohRQjIByXHMzfGp/W9DSuJh7QaBVuu7H0FvquGv8awgEZJM8o19WphQrmrGE3YZdb9JgPwtDT6sj/GNULBdcaoSwvsINO8wIT4JZTqX+J+wsaPjhKFFGwHxy0h+jzFLI8np44X6fDz//TkI9pPQXDK+t0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2x/ddev5sZYqeO/aD1m/BDBpFz3RaosWwFLA1cKvaE=;
 b=AaD4GojIniL7TM/uU/BDcnwMCbiEfUOzt9jquYsm0ww93DIRZCU9wLeRYDOAUP5YqyiKkM5gDz12L0rhHAhFvjCTn1oGgLecnVGK2ouHKrwmoxUvQCJBrOy+0XDKIxA4q7aIanDI5LgrWG1xiFiVTg8GZuDYfRCa/T8GdiH7CTc=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB1148.namprd13.prod.outlook.com (2603:10b6:3:34::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.17; Tue, 8 Jun 2021 22:58:03 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 22:58:03 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Topic: [PATCH 1/1] NFSv4.1+ add trunking when server trunking detected
Thread-Index: AQHXXJZ2q4Fg/jBv8EW7vOhaPbIm9asKlDaAgAAEKoCAAALKAIAACWKAgAAJNoCAAAGBAIAAAp2AgAAC9wCAAAVuAA==
Date:   Tue, 8 Jun 2021 22:58:02 +0000
Message-ID: <ac256c1da7e78510f96c0d84f632a8fbd0ed70ee.camel@hammerspace.com>
References: <20210608184527.87018-1-olga.kornievskaia@gmail.com>
         <C9C7FA2C-1913-4332-91EA-B51F8E104728@oracle.com>
         <CAN-5tyFYyxYr4joR6uPR7zoFToYMmntNdkUkNWV=g33OVXFuOw@mail.gmail.com>
         <29835A59-A523-49FD-8D28-06CDC2F0E94C@oracle.com>
         <CAN-5tyGP7UtcWcWzNiE9k+=Er+BhjO3dMJAe484htUOSry9gow@mail.gmail.com>
         <4c73319e5b826a8f3c9a29b085c42e181150d08c.camel@hammerspace.com>
         <CAN-5tyFrhpyT9_Gfz0CRDv_-ecKRGE7ma0+WUWQot0qgS38wxg@mail.gmail.com>
         <358d1ea7b7e9cd59fb01470e0ac978520788c013.camel@hammerspace.com>
         <CAN-5tyF1pp9pzXp01zaP06BynqK6uW0CMUdSQoWrywJHy1_x_w@mail.gmail.com>
In-Reply-To: <CAN-5tyF1pp9pzXp01zaP06BynqK6uW0CMUdSQoWrywJHy1_x_w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2ecbc0c-883f-451d-4bb0-08d92ad0dee0
x-ms-traffictypediagnostic: DM5PR13MB1148:
x-microsoft-antispam-prvs: <DM5PR13MB11485E1073FA6F71D69EC7C9B8379@DM5PR13MB1148.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsfJDCiR4hu50IM89IXff03qeoQ4srf5msoDYamaxZhT6lRCT7CBw5hecuAscLknK5u4aAPeW5EmDQC85JaQ18QhSaC6PIx8o579+IpwVVyahLbB9nNntypmum0Y3W7p5MB33/FKxwXbUY5XTBIV82gurDC09Q4ull/HPtgjGTWPTAyadf9i4UD/xY5jKzBBag3VmInCaiy421AMSfPATUitpg8T3LgL9qXBVut4IFQZAdjezBG0l2lgk1Cobh3bc2x1DLbxMJKdwYI1uhlLQkVuCdgOtOozKlyZFaFnmY+HJ/qXmLNJufwtqIAOluPxQULOeh8XP6myQwLFD7XNfyIZwQ3OphhduQuzA/cd71s4yilvlvjcU56aR+ziGzIpuahnUZkWFvQgJ577/fAUAel25SMerM1eWtP0OUlinV7/TjJg5wQdZhj8yiS7xUHz8VzB3DxQwQxMb4kTsqcb8NUyjem1Nov4zhjQunG9ZebYXHJtu1Bq4BtQkjcEzWSl3MspRNL/M8I2P89HoOcChWWbNQV6Sf8j6DxMvM3eylSB6YyNi6Qtn4fiuCJxFCaj9YWt+l/BBoqoQFSKgn46j0tPYy5waAKaVidJd3PVdxI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(2906002)(36756003)(38100700002)(64756008)(86362001)(26005)(76116006)(66476007)(66556008)(5660300002)(91956017)(6486002)(8676002)(66946007)(54906003)(4326008)(6916009)(83380400001)(66446008)(186003)(2616005)(71200400001)(53546011)(6512007)(498600001)(8936002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0x6NVpQRjNXeDhjY3VjWGlFR2NxZWRTS1BCR3BXT01Yd0F3eklPZklicnVO?=
 =?utf-8?B?czd2V2hnK1Mwa3NnMXdnSk5TSkxoK1B0WWtnMHllV0RieFY5Nk9FWnBJck15?=
 =?utf-8?B?RnN3UHhJSEdMdnFybDJrTm5VemZFdVZmZDZYZlFBL2NDNGNVazRsQUoySzUv?=
 =?utf-8?B?ZGxhcmlOc1prZkpLS25mQTEyeHFjRVU4Um5WekdOWE8yMVU1ODYvNE1ETEtt?=
 =?utf-8?B?QXp6WUxqSFljTEI2UmxCa05vS2kwUVJQL1hTU05IMHkzaDgvZDQrN0VacW1F?=
 =?utf-8?B?R0hkekFHeTJ4U09DbzJZMk96eWovMit0cDhIVDlTWXZrL1kvQU1yUFFYb1Qr?=
 =?utf-8?B?aDcvb0NqUmxUNUx5QzgxMUkrOXVDOHlYZFlBbEIvckNLb3VVOWJxazgzVHho?=
 =?utf-8?B?ZDVoSWh0TUFyMXR5TlkyTmg0c0o4TGJ5bUlUZEJMdzVvcjJUWllweGRjSGly?=
 =?utf-8?B?dVdOV2tkdkhSMTB4d3BhNWNRRm1ScXR1dFYxT002U1FIa1Z1WFdJRzhjZXBj?=
 =?utf-8?B?azVrZEhoOVRsRnFVeUZkVlJwbXMzNXFGbmZ0WHZHVnVWOGV6Sm9DNDFVdFBC?=
 =?utf-8?B?cC9USlYzWEFMcHZEV0lCR3FmaytJbGQ3UWVFbGdQRmh5cEdRazM0R0lRYTVD?=
 =?utf-8?B?cG93d2ZTN0hIVitRd2RvL0Vydm5USHFSY3hZbTNVc0gvUE5zUkVxQ3NBOUpG?=
 =?utf-8?B?bWxGdVVTSTRNWnBUYnM1QmlSekR6Vnlob2ZtTzE3eUZFclBsMmlmT0VYU09B?=
 =?utf-8?B?UnVaRGpJVnRKUFk5dGxQSlpxWHNIb0FMS09BdEp1U3h3ZkkxMzRtdFExRTc5?=
 =?utf-8?B?cnBSc0tHa2pqM25FeWJiZDR1ZmlJVEIxczRObmMvUjJvb3FLaDI2NVBIY1R4?=
 =?utf-8?B?RFVwbG9sOEp5Sm50dktDM2YxWjFKOUU3bWN5YUx1TG5CKytSSVBjb0E2d0Y5?=
 =?utf-8?B?RVJoNGxCMnVwNVBzRFFGeEZxVDhnT01pbE4wQXd3dmQzTlFMNDYrdjF3d3RJ?=
 =?utf-8?B?RlNsalZXNjVzU2MwMnozVkxJeEd0aHR1ejFZakllUGxKbTI5c3JVMjN0Q0M3?=
 =?utf-8?B?djFlRFNzby9qbUZzak5MMU9idWVwZDk3N08zRitDYmxKZU94MkhLVXNqNk9Z?=
 =?utf-8?B?RndvemFHS1d2L0t4R3RnYUVpK3dNSlJWWXBzcFdNTEhPNjkzUUMwYlN5WjBU?=
 =?utf-8?B?N21uUVlOMXQwM0pNRHkxbHFpbi9PS241UTI0L2RRMFdIak9mUE9zOUJjMnJB?=
 =?utf-8?B?bGJSaXo2bFhwVWxCdEJONjdoV1lic3dVb2M5dVQ0WFZjd2RBSEE0OWgxZmdE?=
 =?utf-8?B?UThaMWpaQ0JubTlUQ3dFdDA2K3hLUW9QZlcwNkFmWFJRc3BJRGExZXdaQTRp?=
 =?utf-8?B?WHNweWx2a040QVYxWXpwUk9jSE9VYlFubXhCVE00M1JCVHBRSlpCaFRicDhZ?=
 =?utf-8?B?dWZ2WHJ1QkUzYzQ2MW9XSjdONlU5TTllOGM1NU5xelI1SFhJRnhUNFZueURp?=
 =?utf-8?B?eG8xWTNrRHY2aUdTTzRpWGNLNmJkR1lhdTdNK2lQWGMyL2ZLR1FCa0ZEeWVQ?=
 =?utf-8?B?SkVYdTR5c01NNEVEMkkxMkFRc0pCV1VaRFRUL0Q0QVRWZmtYK2NZbTRvcytk?=
 =?utf-8?B?d3FkdU41YnZrbm1SL2k2b1dnUnpSTzI3S3Fma25la1Fnb2VuNjFtVGVtWVVI?=
 =?utf-8?B?TlpTTUgzUG80WS9UQUJ6V1NkR1FqZ3cwWVVRK3cyZWRQejVjMzdYcjJrQjQ5?=
 =?utf-8?Q?hy+Y2M0W9M0xx3+p6r0YdNuc3LS3cuk8JPbfJQy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D94280D572700348AF730684C7F5F0C4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ecbc0c-883f-451d-4bb0-08d92ad0dee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 22:58:02.9166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shDD/Cz1dg/v4ljhB7eUfWXC+/FlMq25I4z1xuPlF8iuuOrOTLPvupZtkvG7aVxGtATexKUoRCcNoQzu/OUSKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1148
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTA4IGF0IDE4OjM4IC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBKdW4gOCwgMjAyMSBhdCA2OjI4IFBNIFRyb25kIE15a2xlYnVzdCA8DQo+
IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjEt
MDYtMDggYXQgMTg6MTggLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4gT24g
VHVlLCBKdW4gOCwgMjAyMSBhdCA2OjEzIFBNIFRyb25kIE15a2xlYnVzdCA8DQo+ID4gPiB0cm9u
ZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBUdWUsIDIw
MjEtMDYtMDggYXQgMTc6NDAgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdyb3RlOg0KPiA+ID4g
PiA+IE9uIFR1ZSwgSnVuIDgsIDIwMjEgYXQgNTowNiBQTSBDaHVjayBMZXZlciBJSUkgPA0KPiA+
ID4gPiA+IGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBPbiBKdW4gOCwgMjAyMSwgYXQg
NDo1NiBQTSwgT2xnYSBLb3JuaWV2c2thaWEgPA0KPiA+ID4gPiA+ID4gPiBvbGdhLmtvcm5pZXZz
a2FpYUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gT24g
VHVlLCBKdW4gOCwgMjAyMSBhdCA0OjQxIFBNIENodWNrIExldmVyIElJSSA8DQo+ID4gPiA+ID4g
PiA+IGNodWNrLmxldmVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gT24gSnVu
IDgsIDIwMjEsIGF0IDI6NDUgUE0sIE9sZ2EgS29ybmlldnNrYWlhIDwNCj4gPiA+ID4gPiA+ID4g
PiA+IG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gPiA+IEZyb206IE9sZ2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRh
cHAuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBBZnRlciB0cnVu
a2luZyBpcyBkaXNjb3ZlcmVkIGluDQo+ID4gPiA+ID4gPiA+ID4gPiBuZnM0X2Rpc2NvdmVyX3Nl
cnZlcl90cnVua2luZygpLA0KPiA+ID4gPiA+ID4gPiA+ID4gYWRkIHRoZSB0cmFuc3BvcnQgdG8g
dGhlIG9sZCBjbGllbnQgc3RydWN0dXJlIGJlZm9yZQ0KPiA+ID4gPiA+ID4gPiA+ID4gZGVzdHJv
eWluZw0KPiA+ID4gPiA+ID4gPiA+ID4gdGhlIG5ldyBjbGllbnQgc3RydWN0dXJlIChhbG9uZyB3
aXRoIGl0cyB0cmFuc3BvcnQpLg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBPbGdhIEtvcm5pZXZza2FpYSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4g
PiA+ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+ID4gZnMvbmZzL25mczRjbGllbnQu
YyB8IDQwDQo+ID4gPiA+ID4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiA+ID4gPiA+ID4gPiAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZnMvbmZzL25mczRjbGllbnQuYw0KPiA+ID4gPiA+ID4gPiA+ID4gYi9mcy9uZnMvbmZzNGNsaWVu
dC5jDQo+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA0MjcxOTM4NGUyNWYuLjk4NGM4NTE4NDRkOCAx
MDA2NDQNCj4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+
ID4gPiA+ID4gPiA+ICsrKyBiL2ZzL25mcy9uZnM0Y2xpZW50LmMNCj4gPiA+ID4gPiA+ID4gPiA+
IEBAIC0zNjEsNiArMzYxLDQ0IEBAIHN0YXRpYyBpbnQNCj4gPiA+ID4gPiA+ID4gPiA+IG5mczRf
aW5pdF9jbGllbnRfbWlub3JfdmVyc2lvbihzdHJ1Y3QgbmZzX2NsaWVudA0KPiA+ID4gPiA+ID4g
PiA+ID4gKmNscCkNCj4gPiA+ID4gPiA+ID4gPiA+IMKgwqDCoMKgIHJldHVybiBuZnM0X2luaXRf
Y2FsbGJhY2soY2xwKTsNCj4gPiA+ID4gPiA+ID4gPiA+IH0NCj4gPiA+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIG5mczRfYWRkX3RydW5rKHN0cnVjdCBuZnNf
Y2xpZW50ICpjbHAsDQo+ID4gPiA+ID4gPiA+ID4gPiBzdHJ1Y3QNCj4gPiA+ID4gPiA+ID4gPiA+
IG5mc19jbGllbnQgKm9sZCkNCj4gPiA+ID4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiA+ID4g
PiArwqDCoMKgwqAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgY2xwX2FkZHIsIG9sZF9hZGRyOw0K
PiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBzb2NrYWRkciAqY2xwX3NhcCA9IChz
dHJ1Y3Qgc29ja2FkZHINCj4gPiA+ID4gPiA+ID4gPiA+ICopJmNscF9hZGRyOw0KPiA+ID4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBzb2NrYWRkciAqb2xkX3NhcCA9IChzdHJ1Y3Qgc29j
a2FkZHINCj4gPiA+ID4gPiA+ID4gPiA+ICopJm9sZF9hZGRyOw0KPiA+ID4gPiA+ID4gPiA+ID4g
K8KgwqDCoMKgIHNpemVfdCBjbHBfc2FsZW4sIG9sZF9zYWxlbjsNCj4gPiA+ID4gPiA+ID4gPiA+
ICvCoMKgwqDCoCBzdHJ1Y3QgeHBydF9jcmVhdGUgeHBydF9hcmdzID0gew0KPiA+ID4gPiA+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuaWRlbnQgPSBvbGQtPmNsX3Byb3RvLA0K
PiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAubmV0ID0gb2xkLT5j
bF9uZXQsDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zZXJ2
ZXJuYW1lID0gb2xkLT5jbF9ob3N0bmFtZSwNCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCB9
Ow0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHN0cnVjdCBuZnM0X2FkZF94cHJ0X2RhdGEg
eHBydGRhdGEgPSB7DQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC5jbHAgPSBvbGQsDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgfTsNCj4gPiA+ID4gPiA+
ID4gPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgcnBjX2FkZF94cHJ0X3Rlc3QgcnBjZGF0YSA9IHsNCj4g
PiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmFkZF94cHJ0X3Rlc3Qg
PSBvbGQtPmNsX212b3BzLQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBzZXNzaW9uX3RydW5rLA0KPiA+
ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuZGF0YSA9ICZ4cHJ0ZGF0
YSwNCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCB9Ow0KPiA+ID4gPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGlmIChjbHAtPmNsX3Byb3RvICE9IG9sZC0+Y2xf
cHJvdG8pDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
bjsNCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoCBjbHBfc2FsZW4gPSBycGNfcGVlcmFkZHIo
Y2xwLT5jbF9ycGNjbGllbnQsDQo+ID4gPiA+ID4gPiA+ID4gPiBjbHBfc2FwLA0KPiA+ID4gPiA+
ID4gPiA+ID4gc2l6ZW9mKGNscF9hZGRyKSk7DQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqAg
b2xkX3NhbGVuID0gcnBjX3BlZXJhZGRyKG9sZC0+Y2xfcnBjY2xpZW50LA0KPiA+ID4gPiA+ID4g
PiA+ID4gb2xkX3NhcCwNCj4gPiA+ID4gPiA+ID4gPiA+IHNpemVvZihvbGRfYWRkcikpOw0KPiA+
ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIGlmIChjbHBfYWRk
ci5zc19mYW1pbHkgIT0gb2xkX2FkZHIuc3NfZmFtaWx5KQ0KPiA+ID4gPiA+ID4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gPiA+ID4gPiArwqDCoMKgwqAgeHBydF9hcmdzLmRzdGFkZHIgPSBjbHBfc2FwOw0KPiA+
ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRfYXJncy5hZGRybGVuID0gY2xwX3NhbGVuOw0K
PiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgIHhwcnRkYXRh
LmNyZWQgPSBuZnM0X2dldF9jbGlkX2NyZWQob2xkKTsNCj4gPiA+ID4gPiA+ID4gPiA+ICvCoMKg
wqDCoCBycGNfY2xudF9hZGRfeHBydChvbGQtPmNsX3JwY2NsaWVudCwNCj4gPiA+ID4gPiA+ID4g
PiA+ICZ4cHJ0X2FyZ3MsDQo+ID4gPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+ID4gPiA+ID4gPiA+IHJwY19jbG50X3NldHVw
X3Rlc3RfYW5kX2FkZF94cHJ0LA0KPiA+ID4gPiA+ID4gPiA+ID4gJnJwY2RhdGEpOw0KPiA+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IElzIHRoZXJlIGFuIHVwcGVyIGJvdW5kIG9uIHRo
ZSBudW1iZXIgb2YgdHJhbnNwb3J0cw0KPiA+ID4gPiA+ID4gPiA+IHRoYXQNCj4gPiA+ID4gPiA+
ID4gPiBhcmUgYWRkZWQgdG8gdGhlIE5GUyBjbGllbnQncyBzd2l0Y2g/DQo+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiBJIGRvbid0IGJlbGlldmUgYW55IGxpbWl0cyBleGlzdCByaWdodCBu
b3cuIFdoeSBzaG91bGQNCj4gPiA+ID4gPiA+ID4gdGhlcmUNCj4gPiA+ID4gPiA+ID4gYmUgYQ0K
PiA+ID4gPiA+ID4gPiBsaW1pdD8gQXJlIHlvdSBzYXlpbmcgdGhhdCB0aGUgY2xpZW50IHNob3Vs
ZCBsaW1pdA0KPiA+ID4gPiA+ID4gPiB0cnVua2luZz8NCj4gPiA+ID4gPiA+ID4gV2hpbGUNCj4g
PiA+ID4gPiA+ID4gdGhpcyBpcyBub3Qgd2hhdCdzIGhhcHBlbmluZyBoZXJlLCBidXQgc2F5IEZT
X0xPQ0FUSU9ODQo+ID4gPiA+ID4gPiA+IHJldHVybmVkDQo+ID4gPiA+ID4gPiA+IDEwMA0KPiA+
ID4gPiA+ID4gPiBpcHMgZm9yIHRoZSBzZXJ2ZXIuIEFyZSB5b3Ugc2F5aW5nIHRoZSBjbGllbnQg
c2hvdWxkIGJlDQo+ID4gPiA+ID4gPiA+IGxpbWl0aW5nDQo+ID4gPiA+ID4gPiA+IGhvdw0KPiA+
ID4gPiA+ID4gPiBtYW55IHRydW5rYWJsZSBjb25uZWN0aW9ucyBpdCB3b3VsZCBiZSBlc3RhYmxp
c2hpbmcgYW5kDQo+ID4gPiA+ID4gPiA+IHBpY2tpbmcNCj4gPiA+ID4gPiA+ID4ganVzdCBhDQo+
ID4gPiA+ID4gPiA+IGZldyBhZGRyZXNzZXMgdG8gdHJ5PyBXaGF0J3MgaGFwcGVuaW5nIHdpdGgg
dGhpcyBwYXRjaCBpcw0KPiA+ID4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gPiA+IHNheQ0KPiA+
ID4gPiA+ID4gPiB0aGVyZSBhcmUgMTAwbW91bnRzIHRvIDEwMCBpcHMgKGVhY2ggcmVwcmVzZW50
aW5nIHRoZQ0KPiA+ID4gPiA+ID4gPiBzYW1lDQo+ID4gPiA+ID4gPiA+IHNlcnZlcg0KPiA+ID4g
PiA+ID4gPiBvcg0KPiA+ID4gPiA+ID4gPiB0cnVua2FibGUgc2VydmVyKHMpKSwgd2l0aG91dCB0
aGlzIHBhdGNoIGEgc2luZ2xlDQo+ID4gPiA+ID4gPiA+IGNvbm5lY3Rpb24NCj4gPiA+ID4gPiA+
ID4gaXMNCj4gPiA+ID4gPiA+ID4ga2VwdCwNCj4gPiA+ID4gPiA+ID4gd2l0aCB0aGlzIHBhdGNo
IHdlJ2xsIGhhdmUgMTAwIGNvbm5lY3Rpb25zLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBU
aGUgcGF0Y2ggZGVzY3JpcHRpb24gbmVlZHMgdG8gbWFrZSB0aGlzIGJlaGF2aW9yIG1vcmUNCj4g
PiA+ID4gPiA+IGNsZWFyLg0KPiA+ID4gPiA+ID4gSXQNCj4gPiA+ID4gPiA+IG5lZWRzIHRvIGV4
cGxhaW4gIndoeSIgLS0gdGhlIGJvZHkgb2YgdGhlIHBhdGNoIGFscmVhZHkNCj4gPiA+ID4gPiA+
IGV4cGxhaW5zDQo+ID4gPiA+ID4gPiAid2hhdCIuIENhbiB5b3UgaW5jbHVkZSB5b3VyIGxhc3Qg
c2VudGVuY2UgaW4gdGhlDQo+ID4gPiA+ID4gPiBkZXNjcmlwdGlvbg0KPiA+ID4gPiA+ID4gYXMN
Cj4gPiA+ID4gPiA+IGEgdXNlIGNhc2U/DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSBzdXJlIGNh
bi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEFzIGZvciB0aGUgYmVoYXZpb3IuLi4gU2VlbXMg
dG8gbWUgdGhhdCB0aGVyZSBhcmUgZ29pbmcgdG8NCj4gPiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4g
PiBvbmx5DQo+ID4gPiA+ID4gPiBpbmZpbml0ZXNpbWFsIGdhaW5zIGFmdGVyIHRoZSBmaXJzdCBm
ZXcgY29ubmVjdGlvbnMsIGFuZA0KPiA+ID4gPiA+ID4gYWZ0ZXINCj4gPiA+ID4gPiA+IHRoYXQs
IGl0J3MgZ29pbmcgdG8gYmUgYSBsb3QgZm9yIGJvdGggc2lkZXMgdG8gbWFuYWdlIGZvcg0KPiA+
ID4gPiA+ID4gbm8NCj4gPiA+ID4gPiA+IHJlYWwNCj4gPiA+ID4gPiA+IGdhaW4uIEkgdGhpbmsg
eW91IGRvIHdhbnQgdG8gY2FwIHRoZSB0b3RhbCBudW1iZXIgb2YNCj4gPiA+ID4gPiA+IGNvbm5l
Y3Rpb25zDQo+ID4gPiA+ID4gPiBhdCBhIHJlYXNvbmFibGUgbnVtYmVyLCBldmVuIGluIHRoZSBG
U19MT0NBVElPTlMgY2FzZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEbyB5b3Ugd2FudCB0byBj
YXAgaXQgYXQgMTYgbGlrZSB3ZSBkbyBmb3IgbmNvbm5lY3Q/IEknbSBvaw0KPiA+ID4gPiA+IHdp
dGgNCj4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gZm9yIG5vdy4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IGEgc2V0dXAgd2hlcmUgdGhlcmUgWCBOSUNzIG9u
IGVhY2gNCj4gPiA+ID4gPiBzaWRlDQo+ID4gPiA+ID4gKGNsaWVudC9zZXJ2ZXIpIGFuZCBYIG1v
dW50cyBhcmUgZG9uZSwgdGhlcmUgd29uJ3QgYmUNCj4gPiA+ID4gPiB0aHJvdWdocHV0DQo+ID4g
PiA+ID4gb2YNCj4gPiA+ID4gPiBjbG9zZSB0byBYICogdGhyb3VnaHB1dCBvZiBhIHNpbmdsZSBO
SUMuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0IHN0aWxsIGRvZXMgbm90IG1ha2UgdGhlIHBhdGNo
IGFjY2VwdGFibGUuIFRoZXJlIGFyZQ0KPiA+ID4gPiBhbHJlYWR5DQo+ID4gPiA+IHNlcnZlcg0K
PiA+ID4gPiB2ZW5kb3JzIHNlZWluZyBwcm9ibGVtcyB3aXRoIHN1cHBvcnRpbmcgbmNvbm5lY3Qg
Zm9yIHZhcmlvdXMNCj4gPiA+ID4gcmVhc29ucy4NCj4gPiA+IA0KPiA+ID4gV2h5IGFyZSB0aGVy
ZSBzZXJ2ZXJzIHByZXNlbnRpbmcgbXVsdGlwbGUgSVAgYWRkcmVzc2VzIGFuZA0KPiA+ID4gcmV0
dXJuaW5nDQo+ID4gPiB0aGUgc2FtZSBzZXJ2ZXIgaWRlbnRpdHkgaWYgdGhleSBjYW4gbm90IHN1
cHBvcnQgdHJ1bmtpbmc/IFRoYXQNCj4gPiA+IHNlZW1zDQo+ID4gPiB0byBiZSBnb2luZyBhZ2Fp
bnN0IHRoZSBzcGVjPw0KPiA+IA0KPiA+IFRoYXQncyBub3QgYSBxdWVzdGlvbiBJIGNhbiBhbnN3
ZXIsIGJ1dCBJJ20gbm90IHRoaW5raW5nIG9mIG91cg0KPiA+IHNlcnZlcg0KPiA+IG9yIHRoZSBM
aW51eCBzZXJ2ZXIuDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gVGhlcmUgbmVlZHMgdG8gYmUgYSB3
YXkgdG8gZW5zdXJlIHRoYXQgd2UgY2FuIGtlZXAgdGhlIGN1cnJlbnQNCj4gPiA+ID4gY2xpZW50
DQo+ID4gPiA+IGJlaGF2aW91ciB3aXRob3V0IHJlcXVpcmluZyBjaGFuZ2VzIHRvIHNlcnZlciBE
TlMgZW50cmllcywgZXRjLg0KPiA+ID4gDQo+ID4gPiBPaywgaG93IGFib3V0IHdlIGludHJvZHVj
ZSBhIG1vdW50IG9wdGlvbiwgImVuYWJsZV90cnVua2luZyIsIGFuZA0KPiA+ID4gaWYNCj4gPiA+
IHRoYXQncyBwcmVzZW50IHdlIHdvdWxkIG5vdCBjb2xsYXBzZSB0cmFuc3BvcnRzPw0KPiA+IA0K
PiA+IEknZCBzdWdnZXN0IG1ha2luZyBpdCAnbWF4X2Nvbm5lY3Q9WCcgc28gdGhhdCB3ZSBjYW4g
YWN0dWFsbHkgc2V0IGENCj4gPiBsaW1pdCBsaWtlIHdlIGRvIGZvciBuY29ubmVjdC4gVGhhdCBs
aW1pdCBwcm9iYWJseSBuZWVkcyB0byBiZQ0KPiA+IGxvd2VyDQo+ID4gYm91bmRlZCBieSB0aGUg
dmFsdWUgb2YgbmNvbm5lY3QuDQo+IA0KPiBTdXJlIEkgY2FuIGRvIHRoYXQuIEJ1dCB3b3VsZG4n
dCB0aGF0IGJlIGNvbmZ1c2luZyBzaW5jZSB3ZSBhbHJlYWR5DQo+IGhhdmUgbmNvbm5lY3Qgb3B0
aW9uPyBIb3cgYWJvdXQgIm1heF90cnVua2luZz1YIj8gVGhlIGxhY2sgb2YgdGhlDQo+IHNldHRp
bmcgb3IgbWF4X3RydW5raW5nPTEsIHdvdWxkIHJlc3VsdCBpbiBhbGwgdHJhbnNwb3J0cyBjb2xs
YXBzZWQsDQo+IG90aGVyIHZhbHVlcyB3b3VsZCByZXN1bHQgaW4gYWxsIGFkZGl0aW9ucyBvZiB0
cnVua2FibGUgdHJhbnNwb3J0cy4NCj4gDQo+IA0KDQpJJ20gbm90IGNvbWZvcnRhYmxlIHVzaW5n
IHRoZSB3b3JkICd0cnVua2luZycgaW4gdGhlIG1vdW50IEFQSS4NCg0KVGhlIE5GUyBjb21tdW5p
dHkgdXNlcyAndHJ1bmtpbmcnIHRvIG1lYW4gc29tZXRoaW5nIHZlcnkgZGlmZmVyZW50IGZyb20N
CndoYXQgdGhlIG5ldHdvcmtpbmcgY29tbXVuaXR5IGRvZXMuIFlvdSdyZSBvbmx5IHRhbGtpbmcg
YWJvdXQgc2Vzc2lvbg0KdHJ1bmtpbmcgaGVyZSwgYW5kIG5vdCBjbGllbnRpZCB0cnVua2luZywg
c28gSSBzdWdnZXN0IHdlIHN0aWNrIHdpdGggYQ0KdGVybWlub2xvZ3kgdGhhdCByZW1pbmRzIHVz
IHRoaXMgaXMgY29ubmVjdGlvbiByZWxhdGVkLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
