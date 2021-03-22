Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326C23449CB
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Mar 2021 16:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCVPxS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Mar 2021 11:53:18 -0400
Received: from mail-mw2nam10on2098.outbound.protection.outlook.com ([40.107.94.98]:27873
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhCVPxE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Mar 2021 11:53:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2IURvuJGLSi0oTp4UbckvR8LmDFFeF0XDqCqlhfJV27BFBgAwyRbXd37zpC3Nv3RvXBNuKDJpCqiXhcqfJHx15KRpPgAwa5o/9yFGiMWaVKADcaMXMWIm1QzphwipAkiEJBa/FFSAvDsgjPmXni/5QuVKG92OWZaJ9iZ4AkXXUNGkEy/Y1sU4OtGHrOOUeDJ/7I1DLBBko0Riv+4mzUUl/g6vovFC7gvEjT3k3avgAGACVGytqQkul65RndKYqEyrcbGYqcACnoARvjNtQAeIufTo+sHW0I1MS8kNmKutrb/8S7/2vQhicXsOavpfFWdOq9h8cZrcpkVmWqLg5Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SECuJzKOZ66nz1OWQokOkaRs2d2jpBWjQV+FyAEBpKY=;
 b=Kj5JrtllqF7OnRP9qF8ZFsBh8fWkJXMRpNkzy101onN4lwz+5Z3/kZpbmVc+830iQTJjqnw8PdJMvuhbmPPeiW928Rg4F6noXXsQeCspHtfErQogBTuNifp1EGHveeaqMKh+fOLpqt9taSh1isq8ITcNgfDxUNEThL5OAgsW/0kJv3o/is/HrO7QZ45GTSsJ+ZRDYAx4zbp89IdYf2ZowAoclbuTrzGEi5BBVUuDxx+dUAxHMO7RE9LFcAeWOc3vmcKtaxaVudm4ejqQhP3/y5ibS0FUDJ9qazhxxrfoeGrSyds1lWCDt+puWGwpjnc/1YYp6t32EGQar4c70VP9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SECuJzKOZ66nz1OWQokOkaRs2d2jpBWjQV+FyAEBpKY=;
 b=VC1wXTFuphaa8aWYjv54zRsD4UKmfO9z3bVxvxl7s912Etu6xc95hOeHjgJfX/Nsgh6HLxBFFxwDY2mE63t8zEPqnxBf2pPOTrbsCiUGO0hpfQRKX3DSteQK3Hk8gXERK5L5TQlfjupvWBGwvsB7zODxTkASdQ06Compm5wyvEQ=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH0PR13MB4649.namprd13.prod.outlook.com (2603:10b6:610:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9; Mon, 22 Mar
 2021 15:53:02 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3977.024; Mon, 22 Mar 2021
 15:53:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "eguan@linux.alibaba.com" <eguan@linux.alibaba.com>
Subject: Re: [PATCH 1/2] nfs: hornor timeo and retrans option when mounting
 NFSv3
Thread-Topic: [PATCH 1/2] nfs: hornor timeo and retrans option when mounting
 NFSv3
Thread-Index: AQHXHtxw3807BmvDwk25pY3LZ+ZP7qqQKSUA
Date:   Mon, 22 Mar 2021 15:53:01 +0000
Message-ID: <5b0d0bf03b7bcb1562588aa8137df22964a246db.camel@hammerspace.com>
References: <20210322052904.83508-1-eguan@linux.alibaba.com>
In-Reply-To: <20210322052904.83508-1-eguan@linux.alibaba.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1af8c6e3-b448-49cc-cbe4-08d8ed4a92bf
x-ms-traffictypediagnostic: CH0PR13MB4649:
x-microsoft-antispam-prvs: <CH0PR13MB464949BB69C87501787DD2F3B8659@CH0PR13MB4649.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /G62fM28SAWGjBBR+6j67ZgdmQz6iNpIu+7kBx8crOXJ5POpaT3EVui420omU+Me2gnNcGSHst40b+GW3TX8MiMxq0M3ysN/RkSopTcQRjczEXZz12pGmXwIvc77wu2SEfH77zCrBVemBhNt4sa+qqOJF2P9nnaV4aAn3YMFFV9gvaHQ/jrEWbHZEi9ixzp6W9i9mE74mytkXFRG/UyJAbL9qFnXK944Eceuet937ewe4NOYkwrmToKNPGJBRiaYxy8UDMyoiWfDIHvGvvqnetSihFZJp+Io5MhirIqGVMsKe0Z3oyEgoF7rqsLkzAE5aNvwW/nxdw+vXWBiu5mbkx6S7XOWMiF9dsguiktRCIlviiUwaXjHL/LIXBNVF1mADPzby/FxrxhqzA7AR+XvtyjSuzz8oEqBj+uAY6qimUPc5wWllsH/RMCOkTtlWNeiBLeZvGzFjeBUYHQ/BjWm/+hX0+YyxgrvkCwp376ySCmXsTmT1LobDpJRLGGWj0vMGc8eNSWT2OALVDp+vSRTlOQDmfR2XVqjBYKqNPGvCjVML6Zb7TBrmc+UvVPn1H3pZYoTTQV5ZuVEBEyz2U3EiUAv8YUmrUrSXdogpBfFoo3R6OzkTAe+JazhH7y81rtQZAuIG6YLixtVEwr99BMxE87OqGTSZ22fZRkP4uvivfk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39830400003)(396003)(376002)(346002)(2906002)(66946007)(2616005)(66476007)(8676002)(36756003)(83380400001)(6486002)(66556008)(66446008)(64756008)(5660300002)(71200400001)(8936002)(86362001)(186003)(6512007)(76116006)(26005)(110136005)(38100700001)(6506007)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Y3ZxZU5aUmdhQkY4K0k2ZDVtYWFQeHBXQnRaMnVKQzczVTZwdm9ya2xnOGlQ?=
 =?utf-8?B?Y2JRbjBtZ3dVL0ppQjQxMVpzSjNaUzlzT3VOSnFLR1lXaDdpYWdGWTFYTjlQ?=
 =?utf-8?B?WDJRUlhGVnN1L3VLaUo3bENxbUZ6SmF6ZjBXckhrT2NnVEg0dUN6UCtzbXJk?=
 =?utf-8?B?NTZvQjBaQThmTzlsREROeStDY056NzZwSkQvc3pYTjJURnYwYWh3MFVFSEl4?=
 =?utf-8?B?Q1hCclloaHZBMUhBOVJmT3hnU1U1MDJBQUUvZTJ1SHZJaE9lemFwZzlCdi84?=
 =?utf-8?B?c0FwTTJuR0hqVEVud1o1OXljZlpFeHdKMmlyM0tZRnYycC9Sd3FrSGxncXdn?=
 =?utf-8?B?WHZOTFpwNktCcEtOS1NqaG9uWmxmVEttVmJPaU5NUVU0bGF0bmM5bThpdjN1?=
 =?utf-8?B?UnFCS0REUnB3MWE3R0psVGx3YnFkMzhFRk93S2N2Y1VnN1cxWXBDUU44R0Zl?=
 =?utf-8?B?Y3ZRaUF3NitNV3o0RDVicDgvUXhHVEhHaU1JV0cyVjVaQWp6T0tiN29pZTV6?=
 =?utf-8?B?ckFyVmNHWUEzY1d4L1BCbFRZd2JBSDlVUmcxWFFsWGJLSWcySmZZTXFDT1Rh?=
 =?utf-8?B?b0lBeFpEQXRiMzhaTTZWWHpNYnF2bHQrWSttRnVybmNGVDgvWTdGSUdXTGR6?=
 =?utf-8?B?ZGNzYnd5bTFjZmFwRUtMS1pTNmk4MXhSdGgwcHRueG53N1NmdS9zQlN3aUFW?=
 =?utf-8?B?TlBPbUZiWDFXUVMrM0lTdkdoT3B1TDBhZURnRVkwY3ROb0I5OUdHM3FYQVJC?=
 =?utf-8?B?anVTVkZYLzhrRUJWbnVIUHZmT3JlZnRld2J1U1RiZk1yNGVvUGdBVzFjT21B?=
 =?utf-8?B?MFN0dVNXSlFaNnRac0ZTL2FNRkozZHc3Mmx1VTVlQkM0NWc2cEd3MHJnVThH?=
 =?utf-8?B?bHhJWVphUis1OGVRM05HcE5ZWWJnN2dzamF5dVZ4UDQrTVd5T1FSZDJMM3A1?=
 =?utf-8?B?OUg0dmdZYmpQbVJTbDBHN0NJZlJ5SG9XYlZpZGdENG1xS0lKT1FpMlZRWWZO?=
 =?utf-8?B?UEEyODIrUlV6TjZVWnp3TjNRUEV4MnF1VWpLakF1ZlZrMDR2TUxaMHNZc1FH?=
 =?utf-8?B?ellQU2wzc2wwTDYzSjRVYmxKWlkybEpYUkhYbzM2bFdpV3BwZG0yQjMrNjQx?=
 =?utf-8?B?UWZWZ1dncjQxMDlVZTlBdjBBTDZFcGtGODVtUmIzMEt4a3REdlZBVnJiVDRy?=
 =?utf-8?B?YllqZm95M2ljME1QV2F6TDFFRGNQZjNhZ0FrQUlvZWZDTTFpbmIyK3BuN0ow?=
 =?utf-8?B?VnhNTjRuNkpFWi9pbks5YU9YL1MrY0Z0RFhRTnVrZUFGYmlkS0EwdzhiOGNH?=
 =?utf-8?B?cm1oLzZMUVEzNTlIS04wSUl0TlZ0aGVKNll5ai91OXp5SGZRSWlYNzRMUTVT?=
 =?utf-8?B?ZkdOT2NoOWNoeUhQc0kyOVltTzU5UGpUckFkOGlCZzNlV1hZQkxMcHdVNDRv?=
 =?utf-8?B?enJQWlU5VFNvVXl4OXJ5bFpDODhBYTdtQUpKbUs5TlpHMXNXYWh4UFE3RHpM?=
 =?utf-8?B?RDVWblJKdGFLS3paOFJwMzErZzk1ZnAzRGJIc0RxaDBNZGpzOEpjVTBEdXNH?=
 =?utf-8?B?YTZudGZnUXQwaU9YczhiVDk2aG9LemM1aWpMQkJ1VXFnZjdzR3ErMGxoUElZ?=
 =?utf-8?B?ZzdiZ2tDUzNaLys5U1lHcGRNSjVvSWlmajgwQUpLSjBnbzdBTXJJS1lQYjNR?=
 =?utf-8?B?bnNocGx2ckpvQmVmZVdzM1FoV3UrNkV2aHFtQ011TU5UYlUzWWZqa1VFV1gw?=
 =?utf-8?Q?nL7GHIfbKQ6O5d++6yqp1JsdG7uHIs7WDFT761A?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <728CD3DA921F98439F0BF2F52376487E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af8c6e3-b448-49cc-cbe4-08d8ed4a92bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 15:53:01.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3e0IJM0REBkdovjAynK92H1jEKlEfQw1PXItRPkl3rrEAX12HQcT1K4AUTGRg3LjIWg2MxTFWMbDBsoVruUVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4649
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTIyIGF0IDEzOjI5ICswODAwLCBFcnl1IEd1YW4gd3JvdGU6DQo+IE1v
dW50aW5nIE5GU3YzIHVzZXMgZGVmYXVsdCB0aW1lb3V0IHBhcmFtZXRlcnMgc3BlY2lmaWVkIGJ5
IHVuZGVybHlpbmcNCj4gc3VucnBjIHRyYW5zcG9ydCwgYW5kIG1vdW50IG9wdGlvbnMgbGlrZSAn
dGltZW8nIGFuZCAncmV0cmFucycsIHVubGlrZQ0KPiBORlN2NCwgYXJlIG5vdCBob25vcmVkLg0K
PiANCj4gQnV0IHNvbWV0aW1lcyB3ZSB3YW50IHRvIHNldCBub24tZGVmYXVsdCB0aW1lb3V0IHZh
bHVlIHdoZW4gbW91bnRpbmcNCj4gTkZTdjMsIHNvIHBhc3MgJ3RpbWVvJyBhbmQgJ3JldHJhbnMn
IHRvIG5mc19tb3VudCgpIGFuZCBmaWxsIHRoZQ0KPiAndGltZW91dCcgZmllbGQgb2Ygc3RydWN0
IHJwY19jcmVhdGVfYXJncyBiZWZvcmUgY3JlYXRpbmcgUlBDDQo+IGNvbm5lY3Rpb24uIFRoaXMg
aXMgYWxzbyBjb25zaXN0ZW50IHdpdGggTkZTdjQgYmVoYXZpb3IuDQo+IA0KPiBOb3RlIHRoYXQg
dGhpcyBvbmx5IHNldHMgdGhlIHRpbWVvdXQgdmFsdWUgb2YgcnBjIGNvbm5lY3Rpb24gdG8gbW91
bnRkLA0KPiBidXQgdGhlIHRpbWVvdXQgb2YgcnBjYmluZCBjb25uZWN0aW9uIHNob3VsZCBiZSBz
ZXQgYXMgd2VsbC4gQSBsYXRlcg0KPiBwYXRjaCB3aWxsIGZpeCB0aGUgcnBjYmluZCBwYXJ0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRXJ5dSBHdWFuIDxlZ3VhbkBsaW51eC5hbGliYWJhLmNvbT4N
Cj4gLS0tDQo+IMKgZnMvbmZzL2ludGVybmFsLmjCoMKgIHzCoCAyICstDQo+IMKgZnMvbmZzL21v
dW50X2NsbnQuYyB8IDEyICsrKysrKystLS0tLQ0KPiDCoGZzL25mcy9zdXBlci5jwqDCoMKgwqDC
oCB8wqAgMiArLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9pbnRlcm5hbC5oIGIvZnMvbmZzL2lu
dGVybmFsLmgNCj4gaW5kZXggN2I2NDRkNmMwOWU0Li5jZjBkN2RiMjRkNDQgMTAwNjQ0DQo+IC0t
LSBhL2ZzL25mcy9pbnRlcm5hbC5oDQo+ICsrKyBiL2ZzL25mcy9pbnRlcm5hbC5oDQo+IEBAIC0x
ODAsNyArMTgwLDcgQEAgc3RydWN0IG5mc19tb3VudF9yZXF1ZXN0IHsNCj4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBuZXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKm5ldDsNCj4gwqB9Ow0K
PiDCoA0KPiAtZXh0ZXJuIGludCBuZnNfbW91bnQoc3RydWN0IG5mc19tb3VudF9yZXF1ZXN0ICpp
bmZvKTsNCj4gK2V4dGVybiBpbnQgbmZzX21vdW50KHN0cnVjdCBuZnNfbW91bnRfcmVxdWVzdCAq
aW5mbywgaW50IHRpbWVvLCBpbnQNCj4gcmV0cmFucyk7DQo+IMKgZXh0ZXJuIHZvaWQgbmZzX3Vt
b3VudChjb25zdCBzdHJ1Y3QgbmZzX21vdW50X3JlcXVlc3QgKmluZm8pOw0KPiDCoA0KPiDCoC8q
IGNsaWVudC5jICovDQo+IGRpZmYgLS1naXQgYS9mcy9uZnMvbW91bnRfY2xudC5jIGIvZnMvbmZz
L21vdW50X2NsbnQuYw0KPiBpbmRleCBkZGE1YzNlNjVkOGQuLjI0ODMxOTI1NDY3MiAxMDA2NDQN
Cj4gLS0tIGEvZnMvbmZzL21vdW50X2NsbnQuYw0KPiArKysgYi9mcy9uZnMvbW91bnRfY2xudC5j
DQo+IEBAIC0xMzcsMTMgKzEzNywxMyBAQCBzdHJ1Y3QgbW50X2Zoc3RhdHVzIHsNCj4gwqAgKiBu
ZnNfbW91bnQgLSBPYnRhaW4gYW4gTkZTIGZpbGUgaGFuZGxlIGZvciB0aGUgZ2l2ZW4gaG9zdCBh
bmQgcGF0aA0KPiDCoCAqIEBpbmZvOiBwb2ludGVyIHRvIG1vdW50IHJlcXVlc3QgYXJndW1lbnRz
DQo+IMKgICoNCj4gLSAqIFVzZXMgZGVmYXVsdCB0aW1lb3V0IHBhcmFtZXRlcnMgc3BlY2lmaWVk
IGJ5IHVuZGVybHlpbmcgdHJhbnNwb3J0Lg0KPiBPbg0KPiAtICogc3VjY2Vzc2Z1bCByZXR1cm4s
IHRoZSBhdXRoX2ZsYXZzIGxpc3QgYW5kIGF1dGhfZmxhdl9sZW4gd2lsbCBiZQ0KPiBwb3B1bGF0
ZWQNCj4gLSAqIHdpdGggdGhlIGxpc3QgZnJvbSB0aGUgc2VydmVyIG9yIGEgZmFrZWQtdXAgbGlz
dCBpZiB0aGUgc2VydmVyDQo+IGRpZG4ndA0KPiAtICogcHJvdmlkZSBvbmUuDQo+ICsgKiBVc2Vz
IHRpbWVvdXQgcGFyYW1ldGVycyBzcGVjaWZpZWQgYnkgY2FsbGVyLiBPbiBzdWNjZXNzZnVsIHJl
dHVybiwNCj4gdGhlDQo+ICsgKiBhdXRoX2ZsYXZzIGxpc3QgYW5kIGF1dGhfZmxhdl9sZW4gd2ls
bCBiZSBwb3B1bGF0ZWQgd2l0aCB0aGUgbGlzdA0KPiBmcm9tIHRoZQ0KPiArICogc2VydmVyIG9y
IGEgZmFrZWQtdXAgbGlzdCBpZiB0aGUgc2VydmVyIGRpZG4ndCBwcm92aWRlIG9uZS4NCj4gwqAg
Ki8NCj4gLWludCBuZnNfbW91bnQoc3RydWN0IG5mc19tb3VudF9yZXF1ZXN0ICppbmZvKQ0KPiAr
aW50IG5mc19tb3VudChzdHJ1Y3QgbmZzX21vdW50X3JlcXVlc3QgKmluZm8sIGludCB0aW1lbywg
aW50IHJldHJhbnMpDQoNCg0KZnMvbmZzL21vdW50X2NsbnQuYzoxNDU6IHdhcm5pbmc6IEZ1bmN0
aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3RpbWVvJw0Kbm90IGRlc2NyaWJlZCBpbiAnbmZzX21v
dW50Jw0KZnMvbmZzL21vdW50X2NsbnQuYzoxNDU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXINCidyZXRyYW5zJyBub3QgZGVzY3JpYmVkIGluICduZnNfbW91bnQnDQoNCg0K
LS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVy
c3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
