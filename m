Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB562FC482
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 00:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbhASXLE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 18:11:04 -0500
Received: from mail-dm6nam08on2103.outbound.protection.outlook.com ([40.107.102.103]:52385
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728190AbhASXKt (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 19 Jan 2021 18:10:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNjvh02ZM3le9mEAlYGffK4FTBh1daAxtGmgV8Psrq00WhWowXzbfA98/jWgyCmKnWZ+TsqZf9XMH5qrCFKSRUa9PxCJDFGZlaPujUEjsvey/sMAVgpxLWEsyx0MtHE11shV81NFtG0keDB4SX+SIW2K41tX6MJQVpCQwlCaQwzoEROvHQM81SNfl9soW8y5rPl8sXlILoU8EwGs79HQMLi2d5rvhpUhQsS6YYZdz272Mvz1AfjMdBxvOLpnyBaN5YG5E3FoijrE8F4KNTG1OcmiyCSqYpWa7BkTKbUFJKNMmY06f3KXOPOoMuebQYwzOw60nfo5k+d4gPceWhwNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbyWL0PJHd5SziiGwmyBp4oXEcS4gcxxmAZPE+Ati5w=;
 b=PC97IC8j/roYhZKwti1OrFXdlseo1UjhAjiv55kgdVi4z4du2qq+YNGfL0eEPbEUvuCNIkd1G/QK21Urd+G+/SOGI8QYr7r74z1mmFdw4jMowqd3qSsoys2DdZnnWPK5v4AXl5H08SSHjDk3BqrPJv7zsEjS8VKe6N9ubp6jCatJd01RaUjPrKCAj0/kE10AWdnixyRqviIOVCUL+WmcLjcs/3enGnJREt3WN+qzaU9VFSjauK7v3cFbdr5QOzfUXUfLXkkJk8m5tRgnhuIehi9P7yKjGG38kG19DFOkeTusd8UDxjulWa4mmJ7gO3aQTsuWqAT8WO2n8iMoQVWCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbyWL0PJHd5SziiGwmyBp4oXEcS4gcxxmAZPE+Ati5w=;
 b=UpXK6lXKLPb85rZuv3lMyzhESC2xO+kX9hgMeEa9JctL7fFXcHO+Aax4aB6Hq6GwxsNBEkjpWOBgS7/VpWf8pVpxu09YHbWqUppjG+hZ9+zbmTVZt+eUX2GOvjqiKtDWeARFHqq8y+lbG8Vj1d2yVS0e4wbriRDZthCHwm2TJqI=
Received: from (2603:10b6:610:21::29) by
 CH2PR13MB3830.namprd13.prod.outlook.com (2603:10b6:610:9e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.9; Tue, 19 Jan 2021 23:09:55 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3784.010; Tue, 19 Jan 2021
 23:09:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "fsorenso@redhat.com" <fsorenso@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "jshivers@redhat.com" <jshivers@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHWm/NG4ET1NagHX0mhv4Iw/L0dZKmK9/iAgAAkV4CAACp7AIAAuvkAgAAYugCAAA3yAIAABV0AgAAC94CAAB7QAIAADG0AgKPPPoCAAA08gA==
Date:   Tue, 19 Jan 2021 23:09:55 +0000
Message-ID: <2d77534fb8be557c6883c8c386ebf4175f64454a.camel@hammerspace.com>
References: <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
         <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
         <20201007001814.GA5138@fieldses.org>
         <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
         <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
         <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
         <20201007140502.GC23452@fieldses.org>
         <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
         <20201007160556.GE23452@fieldses.org>
         <e06c31e4211cefda52091c7710d871f44dc9160e.camel@hammerspace.com>
         <20210119222229.GA29488@fieldses.org>
In-Reply-To: <20210119222229.GA29488@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e77ebaf2-0d0c-4695-2f52-08d8bccf55df
x-ms-traffictypediagnostic: CH2PR13MB3830:
x-microsoft-antispam-prvs: <CH2PR13MB383008BC862ADBEDE58C935AB8A39@CH2PR13MB3830.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcQ/e6NUELvN1ooYDhyAcM0qOQLUPxPxGfuk3YMnA7ZmvXgC3ZExFbpqXkaG8izbIIziBf0Iv/kVouXgKDElrBgdl6Bc8Z10wGM3InbRG4lwUAtugCDKABhRMdcNOM1zLOUiQAlq/5v/mqrPt0UB1Ftc6KaziV1hnTKRYCKQ8UNz04cRABFNJ4WQwkGHJUc8FiEaw8DpABZQ+p6OletnU37TXt9p5x6nbob5OZ9E65g6WiXRV+c/L3nr/LfAR/P5Zfs13ng0KdAXz0kvvcI76FmD7LTrzA38Fjexbj87QoBquKNiLewhDYdQAzwTdKqYMOKhxWysNqRZqC1bow7wLedlp2686T7vNXpK/tdrQFRXzBETx9qx5jyZ5Upr2RYeBlPsWuEkgqW6CFh6NgiBzyUK/Cn3ZSXA74XqKSR79yWxyK6Bs31ZU5dh26M5wdU5fVa05l0mOn4iRLKnOBmuy154XzvSiEx38qYPXAsz0YpmscGeNNlGZ7x0KUAGda+9Z9H5HHN9MlGYlaSu8wKp7NgNSKg+eRyL+2Z/QeFlXtOzy8UdoUWfyZVSqlCo/OoORNWh0729v1+ZGtR/iqvjS1OTkhiqemQzMzVU4BaxSno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(346002)(39840400004)(8936002)(76116006)(2906002)(478600001)(966005)(6916009)(8676002)(54906003)(2616005)(316002)(66556008)(66446008)(6506007)(6512007)(66946007)(36756003)(4326008)(64756008)(66476007)(5660300002)(86362001)(6486002)(186003)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RDhUdVNZN0tILzR4cWJqbzN4NHhqWlBTZlJtTE83dG1wYjgxYXZxblQrclpT?=
 =?utf-8?B?RlBVRUUybHN1bjFJWHZqbmptVDB5KzZzWVRKdWVEeTg5dDdoZ1U4cE82UjBl?=
 =?utf-8?B?eDBFNXlvRkhiOHE4c3lJdUhZcGtmcVRxa0c1Vnp4Qi90L3FWT09oRXJTRTBa?=
 =?utf-8?B?Y1RaK3gvd0EzcDh2cVltS1BvMjY3M1Ztb1dTYStOVjdnT2UvUm1iQUJFZnlE?=
 =?utf-8?B?Y3oyNVZLcElBSTJhM3ZzN1EwaGhqdkVVVTFBUUxacS9KY3N2UkVMcW8wNDRz?=
 =?utf-8?B?bDlJUHRFZ2dKcEpPaVRFYi94Z3ZxbUxvNVJvTHI0cjFkT0FNYnMxcndMa1Jr?=
 =?utf-8?B?UFphRWQ3ZWN6M3JlcE5tRi9BRTFWclVnVFQzT1dSMmdhUGtTS08zRGFDM2Mr?=
 =?utf-8?B?b3dOMVhJaDJ4TmVsazg2YzVQVWdFNWEyQktENzlISm16dlB4Sk01bEJlRGlv?=
 =?utf-8?B?ZzRqS0p3cHVMREtqRkxQZUZpcFZoUWpMaFlKL0Vsbk5zSW9ZNkFYZEFBY29t?=
 =?utf-8?B?NEVSbU5EMzlNdkhOcE80WFhBMlB3NFE2VngzQ1RZUUNhTnVvTUpRUUkyR0FF?=
 =?utf-8?B?VlE1RE5ZbFIyWVNwZmFXUDBCcVBKeDlycHNOMUdpZERGWE1oODVtRFJaWW5y?=
 =?utf-8?B?MDJzMUlOZDNCdVZkM3BPTEs3S0oyMUk2TldsUlg1R0t5eFBlQW9UbUlZY2t4?=
 =?utf-8?B?ZlZGNGRQbjJtd1prcUpzWWtlVnBISE50ZkZkQUhFcFRIaHBTazQ0bWpmMG9V?=
 =?utf-8?B?eGtpUXRGVHVTQUtkTGJvbkxDT2diTFdxbU4xTVJqK25YK2FMMWNaL3JsWkYv?=
 =?utf-8?B?YmgwWVQvTW1EQ3A3UEVoWm9Wb2M5SStCYnBqN3E0RmtCSStTcHBldlhWZG9F?=
 =?utf-8?B?N2k1REI1THZqaFNIQ1RBVXlLanIzeHY3YVJRQUdOZWZzTVYrSGNYRzRsYlFJ?=
 =?utf-8?B?NTkzSkJzOG5JaGhCck10aE9RY2NqRkhtUWlheTlITFNWMmJwTmZyVlJYNCtS?=
 =?utf-8?B?Y3BJUzdUYmw2cXlwMUc3d2hWa0tVakNTUG9LZWJ3ckNQQms2QlRzUWI5NHRF?=
 =?utf-8?B?STBncG5vZC9pQTFBaWkwdXg5QUM3SmJ5ZHRWb3MreHAyVXo2M0V2S2dWWlpG?=
 =?utf-8?B?TGxJWVcrTDdaYnR0RlRrVUMrL0wwUFBLdTREUFRWQllZc1N2S3ZHdFFia29y?=
 =?utf-8?B?djlmdWcwOTBHWDVFZWx3WjlyRUUrY25NYko4WTZRd3J1Rkd4M01aZVd3Vm9M?=
 =?utf-8?B?VzZqM0pIRC9aeGo0Nm85NkszVHB2VWJlbnF4bi9IamhKRHdrWjJmV1ZUQUFJ?=
 =?utf-8?Q?DDzedOi91U6MWCrNVeTt6u6Gu661YbxDcD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <600E76E35EB3AA41BBFB34516528CF94@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ebaf2-0d0c-4695-2f52-08d8bccf55df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 23:09:55.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJ9LTAW6O9JWsp2rkpySPQaw7mJJM0TeDmzMZOpxrjrXhohcNAnOyF0Pd+DH0+BtDbXp0eZecM6MxBv/Nisagg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3830
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTE5IGF0IDE3OjIyIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gV2VkLCBPY3QgMDcsIDIwMjAgYXQgMDQ6NTA6MjZQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IEFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGlzIHRocmVhZCBz
dGFydGVkIHdpdGggYSBjb21wbGFpbnQgdGhhdA0KPiA+IHBlcmZvcm1hbmNlIHN1ZmZlcnMgd2hl
biB3ZSBkb24ndCBhbGxvdyBzZXR1cHMgdGhhdCBoYWNrIHRoZSBjbGllbnQNCj4gPiBieQ0KPiA+
IHByZXRlbmRpbmcgdGhhdCBhIG11bHRpLWhvbWVkIHNlcnZlciBpcyBhY3R1YWxseSBtdWx0aXBs
ZSBkaWZmZXJlbnQNCj4gPiBzZXJ2ZXJzLg0KPiA+IA0KPiA+IEFGQUlDUyBUb20gVGFscGV5J3Mg
cXVlc3Rpb24gaXMgdGhlIHJlbGV2YW50IG9uZS4gV2h5IGlzIHRoZXJlIGENCj4gPiBwZXJmb3Jt
YW5jZSByZWdyZXNzaW9uIGJlaW5nIHNlZW4gYnkgdGhlc2Ugc2V0dXBzIHdoZW4gdGhleSBzaGFy
ZQ0KPiA+IHRoZQ0KPiA+IHNhbWUgY29ubmVjdGlvbj8gSXMgaXQgcmVhbGx5IHRoZSBjb25uZWN0
aW9uLCBvciBpcyBpdCB0aGUgZmFjdA0KPiA+IHRoYXQNCj4gPiB0aGV5IGFsbCBzaGFyZSB0aGUg
c2FtZSBmaXhlZC1zbG90IHNlc3Npb24/DQo+ID4gDQo+ID4gSSBkaWQgc2VlIElnb3IncyBjbGFp
bSB0aGF0IHRoZXJlIGlzIGEgUW9TIGlzc3VlICh3aGljaCBhZmFpY3MNCj4gPiB3b3VsZA0KPiA+
IGFsc28gYWZmZWN0IE5GU3YzKSwgYnV0IHdoeSBkbyBJIGNhcmUgYWJvdXQgUW9TIGFzIGEgcGVy
LW1vdW50cG9pbnQNCj4gPiBmZWF0dXJlPw0KPiANCj4gU29ycnkgZm9yIGJlaW5nIHNsb3cgdG8g
Z2V0IGJhY2sgdG8gdGhpcy4NCj4gDQo+IFNvbWUgbW9yZSBkZXRhaWxzOg0KPiANCj4gU2F5IGFu
IE5GUyBzZXJ2ZXIgZXhwb3J0cyAvZGF0YTEgYW5kIC9kYXRhMi4NCj4gDQo+IEEgY2xpZW50IG1v
dW50cyBib3RoLsKgIFByb2Nlc3MgJ2xhcmdlJyBzdGFydHMgY3JlYXRpbmcgMTBHKyBmaWxlcyBp
bg0KPiAvZGF0YTEsIHF1ZXVpbmcgdXAgYSBsb3Qgb2YgbmZzIFdSSVRFIHJwY190YXNrcy4NCj4g
DQo+IFByb2Nlc3MgJ3NtYWxsJyBjcmVhdGVzIGEgbG90IG9mIHNtYWxsIGZpbGVzIGluIC9kYXRh
Miwgd2hpY2gNCj4gcmVxdWlyZXMgYQ0KPiBsb3Qgb2Ygc3luY2hyb25vdXMgcnBjX3Rhc2tzLCBl
YWNoIG9mIHdoaWNoIHdhaXQgaW4gbGluZSB3aXRoIHRoZQ0KPiBsYXJnZQ0KPiBXUklURSB0YXNr
cy4NCj4gDQo+IFRoZSAnc21hbGwnIHByb2Nlc3MgbWFrZXMgcGFpbmZ1bGx5IHNsb3cgcHJvZ3Jl
c3MuDQo+IA0KPiBUaGUgY3VzdG9tZXIgcHJldmlvdXNseSBtYWRlIHRoaW5ncyB3b3JrIGZvciB0
aGVtIGJ5IG1vdW50aW5nIHR3bw0KPiBkaWZmZXJlbnQgc2VydmVyIElQIGFkZHJlc3Nlcywgc28g
dGhlICJzbWFsbCIgYW5kICJsYXJnZSIgcHJvY2Vzc2VzDQo+IGVmZmVjdGl2ZWx5IGVuZCB1cCB3
aXRoIHRoZWlyIG93biBxdWV1ZXMuDQo+IA0KPiBGcmFuayBTb3JlbnNvbiBoYXMgYSB0ZXN0IHNo
b3dpbmcgdGhlIGRpZmZlcmVuY2U7IHNlZQ0KPiANCj4gwqDCoMKgwqDCoMKgwqDCoGh0dHBzOi8v
YnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTcwMzg1MCNjNDINCj4gwqDCoMKg
wqDCoMKgwqDCoGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTcw
Mzg1MCNjNDMNCj4gDQo+IEluIHRoYXQgdGVzdCwgdGhlICJzbWFsbCIgcHJvY2VzcyBjcmVhdGVz
IGZpbGVzIGF0IGEgcmF0ZSB0aG91c2FuZHMNCj4gb2YNCj4gdGltZXMgc2xvd2VyIHdoZW4gdGhl
ICJsYXJnZSIgcHJvY2VzcyBpcyBhbHNvIHJ1bm5pbmcuDQo+IA0KPiBBbnkgc3VnZ2VzdGlvbnM/
DQo+IA0KDQpJIGRvbid0IHNlZSBob3cgdGhpcyBhbnN3ZXJzIG15IHF1ZXN0aW9ucyBhYm92ZT8N
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
