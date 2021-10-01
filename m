Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71E41F051
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Oct 2021 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354786AbhJAPF4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Oct 2021 11:05:56 -0400
Received: from mail-bn8nam11on2121.outbound.protection.outlook.com ([40.107.236.121]:7744
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354706AbhJAPFz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 Oct 2021 11:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvObGorwCG5d0TpkAh5fTf23d+fUQsRu9FTwPzVq62XzfopjImliurab+itPqU1SYDxeY2PPKnpVE3Uy76uJDQRRnASfaMf1fQbo74Mi9MBKdXFQxj58PC+ei6/Ep/sh/D+xZHKUTLXGBeXtPyL5GGyD84CkwDyXRUi3McEKrtCYT1Rz0dwoAPUTPcHdrXX5VUtCvPR13XHSrCGJ6JyN7RUK3JT0dj+tMv3a8GTQ5JucNgb8dAQKHqyyLVsDzvzCo22Wa1Aemy6ADo3W5eTNAn10yGWD75n7fGwC3iEG8b2appeVn50bxTIwJb59a2UmauvVlU57U86bH/vVMCtjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvMldIxfVOFhizoDlsQ6EC716CoydGaSM8AsU20Gg2I=;
 b=IWYf/Le0g098PBW48uGQo9cdIlAYTuxUBXls6BuHJKCgqiw6UEQnjjx90adOn8608B4y3X8Wchn0iHqLMpWWijg6UEt6BFLOGfJ3K0k0TkmSiQbQ2AmDyuZ0kUptpA+C/AU1aBZ6qZgdz03DoBDE0iNoAKslsrMkq3kdztMwJuFjUoyqKDJBaPTp29C2mDP8LYlgSpcZGu+E0IJEk2W5KXB9bcKxoAub7k9tMXqAlz1/RuD6qu+919+0uqUxXUyn5mvOYgvoyBKJqJ29+b7ZveiCUYF0d0GmGXy9tRaM1ppiQl1QRqTPoXS19COCzHdcpCXht02kjSGY2PPhrMG1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvMldIxfVOFhizoDlsQ6EC716CoydGaSM8AsU20Gg2I=;
 b=YCWHi74fg3hLEppoJVm5euYmddViea8/EkLaBJiRhwlHanVJWnLuC18mWvC8SYdpENjwSZiL4g/rB8IXvTT9DiAnUmwQjvRIYTWw4VClQEq9aI9c38OOMJQRZz/xmDB3yIIPCnvHS9SHA3Uz2F2qQu/WOGOnMp07RhWMkHw1sCI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH0PR13MB4699.namprd13.prod.outlook.com (2603:10b6:610:d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7; Fri, 1 Oct
 2021 15:04:08 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::1533:4550:d876:1486%6]) with mapi id 15.20.4587.011; Fri, 1 Oct 2021
 15:04:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: Can the GFP flags to releasepage() be trusted? -- was Re: [PATCH
 v2 3/8] nfs: Move to using the alternate fallback fscache I/O API
Thread-Topic: Can the GFP flags to releasepage() be trusted? -- was Re: [PATCH
 v2 3/8] nfs: Move to using the alternate fallback fscache I/O API
Thread-Index: AQHXq9VkcJvbs0xlPEq7aMXkSiWnq6u+EpgAgAA3MwCAAAZMAIAAA2YA
Date:   Fri, 1 Oct 2021 15:04:08 +0000
Message-ID: <23033528036059af4633f60b8325e48eab95ac36.camel@hammerspace.com>
References: <97eb17f51c8fd9a89f10d9dd0bf35f1075f6b236.camel@hammerspace.com>
         <163189104510.2509237.10805032055807259087.stgit@warthog.procyon.org.uk>
         <163189108292.2509237.12615909591150927232.stgit@warthog.procyon.org.uk>
         <CALF+zO=165sRYRaxPpDS7DaQCpTe-YOa4FamSoMy5FV2uuG5Yg@mail.gmail.com>
         <81120.1633099916@warthog.procyon.org.uk>
In-Reply-To: <81120.1633099916@warthog.procyon.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e91cadf5-1609-4d1b-da40-08d984ecb81b
x-ms-traffictypediagnostic: CH0PR13MB4699:
x-microsoft-antispam-prvs: <CH0PR13MB4699366B235AE4BD329A2C61B8AB9@CH0PR13MB4699.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGWJ3F2/yJA7nmpKdAv488Wlu3qJ5gG3e0HP42FX4A0uPl4KkyeieTsgsi62ioPJfmer4SOisBD+4IUbIgvpWbpPy27zYyfp+ho4z6OtLTaHghjX1/OexzMHZXfmMhc4sHynmRWhH04puESIWSMuSo7Fc8X+YI+eGrWSU+SeaM2dysPQmQHKmyyKaPaKFKbQ2nbRMq4I24UKpWeaGdkodHNlvOkDWfUtlknizmSVB+GdGgbzUKCofFquh8fCSBrQbqYOaFNOvuJ+jp0hW1411m71UupNSh7lxjNwmaHlPghPeqaQmvr8tIgaT2lgpyvi/jkRDIWdJQwKtvbBx9WPVu7sKzzLAketN7LvZqRM6mbHdpQY3sjf0qMLHZuoyae0fSI6I/WlJTdNVLWu0a5082R4SHjBthIZsim4b/D4MOkjXMJl9VbxkicJq8W5m+S+HuZ/ly1jKFk9bkYJ8FIkplG/DpYX/YBjt5BLW6PvQ/lvHMHhLz8dGm7onUmrhES+LOR9LUAUnMjaCI8xNygmu2IDSp1UqI63Viv7xU767cgAGHbkgT0xS8ayxw9uueHCVjeLi/gXD9TJYhvLVqEUt15mou6QzUmU8HV41zCSf2tl4YGfgaK7aC1zdPp0QOX7n0mYxikcDMeE5nD8BNrg6nGWt/Q3LX330wiTAHWH8O6OS/lHGHXSZ2pxdxjSTLjVy+0vjVnNgIwJ69ea7aWULw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(38100700002)(76116006)(66556008)(66476007)(122000001)(36756003)(38070700005)(6512007)(64756008)(66446008)(66946007)(6506007)(8676002)(26005)(8936002)(4326008)(71200400001)(54906003)(186003)(86362001)(316002)(5660300002)(2906002)(83380400001)(2616005)(6486002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE94cTN1bW1vZ1R2ajhLWVZlbFNaWk9KQ0FXU0FhVFJ1MDhOcjhML1hwNnEx?=
 =?utf-8?B?MjByMllJQmJJL3FnMHIyYngydGJhWlV6NTlta0dKakhUOWVvL3B0L2NDNGJq?=
 =?utf-8?B?V0RjQjFtUWV5Ni8yWGs0eDU5ekJsaXpCTnBaNDREZldEUjZMYjJReGxkR01k?=
 =?utf-8?B?YzY1NGdqMEVGNUJnSXV6WmhGdUNXeENrVWlSdmp5bndoTHVNdE81Q05OOGNr?=
 =?utf-8?B?MkZYM255VUovRmxxdy9wdDQzNXQrb283c1BWSVNUcDg5NnZ4SDF0eTRpYy82?=
 =?utf-8?B?SmhiTzFpVlVIVlMxc2EyR1I3dzhWR1ozeHNzWVRmTzlBYXZNMzAxeFZadXBz?=
 =?utf-8?B?YTRRU0o3a0IrUEtoYTJ5ZkUraUwwZ2VHS3JNeDBGbHkyN3VKMjJJeVgrM2hM?=
 =?utf-8?B?dThSMm9vSkk3K0JhUmJIblVVKzE1Rk5MZ1lNclJueTY5dkFnM2M1WDVQNzJq?=
 =?utf-8?B?eXhaUCtUWkd2d2hHTGR5YVFJWnlIU2VESjB2b0E2ZnEwV0VCYXp5dFJ0RytN?=
 =?utf-8?B?cDlXTFVwTk8rUmlrN3BodXB3U2x0YmxWOXd2QlBnY29oUEpldTBPZ2toUkNq?=
 =?utf-8?B?c01MOW13amUrVEVTOWtsL0ZhVW1WdEhPYW54c0NNM2ppMXREZ0pIV0YxcEp0?=
 =?utf-8?B?SE5zemlISlZEQmFZbjhBVVVnMmpnZkRTekozUVhPR1NiZk5uWENaYkFOZStY?=
 =?utf-8?B?RFpJOFpidDNGaWE2eVg2aGQvUGJsc3pCQy9oUGNsZDJWRjFydUpoK1NGSTc0?=
 =?utf-8?B?ZkQ3TmcrUGpXYTZpMU5xTnVsYlVEendNL2h3TlUrUk1TNXBka0F0TDl4VmYx?=
 =?utf-8?B?R05IRXJoVGRJeHRJb0czNExDZkdPZFM3NjNHYXg3S050a2IwcjBTYkxQSGVr?=
 =?utf-8?B?eVkxL2RCa1NEaHFjK0tYQkZmUXNSa2pZQWZIOVJ5bGo0Y05iNlVDc3NCbTlV?=
 =?utf-8?B?NU1xTUU0ME40bFNtZGdaQWM0Q1lKVzZpamsvYXoxSDZvQ3pOc0FhL0dwR1FI?=
 =?utf-8?B?WGRaVlFKN0lRYnlZUGc1aXIrRFVWbGM3a0w4eU4vcDNCUjFmQjc5b3RqVW1w?=
 =?utf-8?B?RGE0SUp3QlpUODRybWlqTndoZnloTnJsK2taYldBWlhmVjRvR0k4a3IxbndE?=
 =?utf-8?B?QzJ3MFBORmt6VUpRa1AxRnd1dm84SVRQME5peTBxS2tDR0hiZUM3OUNQbVRB?=
 =?utf-8?B?V0lqWFF6ZUFqWWFEdGtzVjBpaUw3Qk9RL25WOG9wVTlvbXN0ZitSc1hWaWFZ?=
 =?utf-8?B?cllGanBmMFNXLzdzdVJwa0l0RU1uUE5oV01FRE96NVlYSUVuZkp6MDBlR09r?=
 =?utf-8?B?WjlVWXd0bTkwV1hiYjRvUHp0TUVxSyt6OVh0RzlGM1JJa0ZvT2htUzRpMkZ4?=
 =?utf-8?B?K3pFUTNuQk5URFlLSXJIczVnMHlQQmtwRXFaR1JzOFcybWh6R295b3VwSEcx?=
 =?utf-8?B?RkJPbVArZmtoWGpzbWVPM3M2c1JtcW1MVjYyYlJ1SVdxbXF4Wm50a200c29P?=
 =?utf-8?B?MjRlNDZTRnduY3lhRzlEWEJ2clI5T2ExMkkrOVYyL3lwZDhiOEZOMHJwckJo?=
 =?utf-8?B?dklqb29qOWNaWFJHM21EMWM0YTc5aFluNWdjZHdxc0kzWXNZSTRPUm0vMlhH?=
 =?utf-8?B?VTBaVmg0SzlrUUFTRVQ0TU53OHdNSWYveEMwRkNzWWFla2FxV1lDbXA5NTN6?=
 =?utf-8?B?WVlSc3o4bE1aNzZxZk9ORVlGWTJSK3NmczVxSnVJYzRJeUlaL2V1bUUyNm5Q?=
 =?utf-8?Q?07u6XOSUVOpQv122h85eDNqHmKnSzC4URxZQA+x?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC8134AF8324AE44BFD581331A8923DA@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91cadf5-1609-4d1b-da40-08d984ecb81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 15:04:08.3506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5/Ew9fehU9RSY4BdNGhntq42ehJxGH4V5pn4d8MK7cfN9mmInLURhVL8RrGzXX3peqEGojOY1dO+dnTEG9/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4699
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTAxIGF0IDE1OjUxICswMTAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gDQo+
ID4gPiA+IEBAIC00MzIsNyArNDMyLDEyIEBAIHN0YXRpYyBpbnQgbmZzX3JlbGVhc2VfcGFnZShz
dHJ1Y3QgcGFnZQ0KPiA+ID4gPiAqcGFnZSwgZ2ZwX3QgZ2ZwKQ0KPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgLyogSWYgUGFnZVByaXZhdGUoKSBpcyBzZXQsIHRoZW4gdGhlIHBhZ2UgaXMgbm90DQo+
ID4gPiA+IGZyZWVhYmxlICovDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAoUGFnZVByaXZh
dGUocGFnZSkpDQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IDA7DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoHJldHVybiBuZnNfZnNjYWNoZV9yZWxlYXNlX3Bh
Z2UocGFnZSwgZ2ZwKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKFBhZ2VGc0NhY2hlKHBh
Z2UpKSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIShnZnAg
JiBfX0dGUF9ESVJFQ1RfUkVDTEFJTSkgfHwgIShnZnAgJg0KPiA+ID4gPiBfX0dGUF9GUykpDQo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIGZhbHNlOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2FpdF9v
bl9wYWdlX2ZzY2FjaGUocGFnZSk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0dXJuIHRydWU7DQo+ID4gPiA+IMKgfQ0KPiA+IA0KPiA+IEkndmUg
Zm91bmQgdGhpcyBnZW5lcmFsbHkgbm90IHRvIGJlIHNhZmUuIFRoZSBWTSBjYWxscyAtDQo+ID4g
PnJlbGVhc2VfcGFnZSgpDQo+ID4gZnJvbSBhIHZhcmlldHkgb2YgY29udGV4dHMsIGFuZCBvZnRl
biBmYWlscyB0byByZXBvcnQgaXQgY29ycmVjdGx5DQo+ID4gaW4NCj4gPiB0aGUgZ2ZwIGZsYWdz
LiBUaGF0J3MgcGFydGljdWxhcmx5IHRydWUgb2YgdGhlIHN0dWZmIGluDQo+ID4gbW0vdm1zY2Fu
LmMuDQo+ID4gVGhpcyBpcyB3aHkgd2UgaGF2ZSB0aGUgY2hlY2sgYWJvdmUgdGhhdCB2ZXRvcyBw
YWdlIHJlbW92YWwgdXBvbg0KPiA+IFBhZ2VQcml2YXRlKCkgYmVpbmcgc2V0Lg0KPiANCj4gW0Fk
ZGluZyBXaWxseSBhbmQgdGhlIG1tIGNyZXcgdG8gdGhlIGNjIGxpc3RdDQo+IA0KPiBJIHdvbmRl
ciBpZiB0aGF0IG1hdHRlcnMgaW4gdGhpcyBjYXNlLsKgIEluIHRoZSB3b3JzdCBjYXNlLCB3ZSds
bCB3YWl0DQo+IGZvciB0aGUNCj4gcGFnZSB0byBjZWFzZSBiZWluZyBETUEnZCAtIGJ1dCB3ZSB3
b24ndCByZXR1cm4gdHJ1ZSBpZiBpdCBpcy4NCj4gDQo+IEJ1dCBpZiB2bXNjYW4gaXMgZ2VuZXJh
dGluZyB0aGUgd3JvbmcgVk0gZmxhZ3MsIHdlIHNob3VsZCBsb29rIGF0DQo+IGZpeGluZyB0aGF0
Lg0KPiANCj4gDQoNClRvIGVsYWJvcmF0ZSBhIGJpdDogd2UgdXNlZCB0byBoYXZlIGNvZGUgaGVy
ZSB0aGF0IHdvdWxkIGNoZWNrIHdoZXRoZXINCnRoZSBwYWdlIGhhZCBiZWVuIGNsZWFuZWQgYnV0
IHdhcyB1bnN0YWJsZSwgYW5kIGlmIGFuIGFyZ3VtZW50IG9mDQpHRlBfS0VSTkVMIG9yIGFib3Zl
IHdhcyBzZXQsIHdlJ2QgdHJ5IHRvIGNhbGwgQ09NTUlUIHRvIGVuc3VyZSB0aGUgcGFnZQ0Kd2Fz
IHN5bmNoZWQgdG8gZGlzayBvbiB0aGUgc2VydmVyIChhbmQgd2UnZCB3YWl0IGZvciB0aGF0IGNh
bGwgdG8NCmNvbXBsZXRlKS4NCg0KVGhhdCBjb2RlIHdvdWxkIGVuZCB1cCBkZWFkbG9ja2luZyBp
biBhbGwgc29ydHMgb2YgaG9ycmlibGUgd2F5cywgc28gd2UNCmVuZGVkIHVwIGhhdmluZyB0byBw
dWxsIGl0Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
