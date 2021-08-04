Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A863DF8B5
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Aug 2021 02:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhHDAAT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Aug 2021 20:00:19 -0400
Received: from mail-dm6nam10on2102.outbound.protection.outlook.com ([40.107.93.102]:15489
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232641AbhHDAAS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Aug 2021 20:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDuh1d1cBjXNIOwbpNNJqfNsFhCGq1uAH5pWVBXwO5TzNmDtFNTReAGV4J3fMQyPunbpzuf0TCiL8RIpamr9WEvIH9fgSLsXw2OzXkTfbG4H/Vp7HDBOD6pXn3aXpkhqd0LdcokwMBbVx1dWnrzfS96DqslNdyVkf4P117cbSgqrCxPvdkKh9qV3DMqdM4zTnnJG2/OEwFehT4pRXm9hvdIgqGj9fM749WZY8SQhg4JAuO3+LvIDO10EY0vo0ZDbbnHJJDB+ky0K+BxRLkSe24y4IF360f9rnK+zLLQxmGulRU3V/HGRdyQeIsrgLcxTCDxCrKR3aqyyofMa/e06/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6WqSAcqPpXUVA7zvzd6sf4VSryCdQynXgyEQEsyCtc=;
 b=aOBQ1ImysBKDTFPXF4fgRVFsu28ig9RDyuFQ1ptH5h8ksNmB01/9x2Xo3p/PUoP42+ja52CZPbg2VrfHNzpXNKpDIH/iOk0q3hLNMqUqJmjFWJeJypX9C5tLmTDr4f+dax1eovF0jl5BPFsOdu9+pOGHNn9bPe4g4ukqqdgNS4YWYGa+ShEYWB9cQccWz3vkZpPV2StOl6DNZNWWC64p/qWBvV+6Cuw7AX+t+/tH1AWJNl9PvUJ7SWxq+wj3phvF3+aMeXMXwtKYoeVJcNhfdmEhBKffp7UO35RgRzeZ3F9IjdcjveuiTRNRvPW0jb+lQJpKdF89BzdK53T5hEVWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6WqSAcqPpXUVA7zvzd6sf4VSryCdQynXgyEQEsyCtc=;
 b=NOWWSlgXPyqzSseQ1WsDDWEI8xrdWdDqZf2iUcrZgSB7smSH5+GcyYCMc6kUDpW5OfWTa5XQ2LvG7jA1Ia4l9m4ouGMrhn5IcDUGkHHO2z0qPr8nBWwlh97MhLi8ixZjBYyWwW+QWsrZdaf0VxD9l6HLcYoCOnXcFsCOVJOHpVA=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3814.namprd13.prod.outlook.com (2603:10b6:610:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 00:00:04 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::185b:505d:b35c:a3a2%6]) with mapi id 15.20.4394.015; Wed, 4 Aug 2021
 00:00:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "plambri@redhat.com" <plambri@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
Subject: Re: cto changes for v4 atomic open
Thread-Topic: cto changes for v4 atomic open
Thread-Index: AQHXhUZ9owuGm7b0CEqtoxaJkItc06tbmWqAgAao74CAAAokgIAACEIAgAACAoCAACJ2AIAAA5WA
Date:   Wed, 4 Aug 2021 00:00:04 +0000
Message-ID: <08db3d70a6a4799a7f3a6f5227335403f5a148dd.camel@hammerspace.com>
References: <DF3F94B7-F322-4054-952F-90CE02B442FE@redhat.com>   ,
 <ef395e52f3bb8d07dd7a39bb0a6dd6fb64a87a1c.camel@hammerspace.com>       ,
 <20210803203051.GA3043@fieldses.org>   ,
 <3feb71ab232b26df6d63111ee8226f6bb7e8dc36.camel@hammerspace.com>       ,
 <20210803213642.GA4042@fieldses.org>   ,
 <a1934e03e68ada8b7d1abf1744ad1b8f9d784aa4.camel@hammerspace.com>
         <162803443497.32159.4120609262211305187@noble.neil.brown.name>
In-Reply-To: <162803443497.32159.4120609262211305187@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dcdbee3-02ba-4a24-86e0-08d956dad05d
x-ms-traffictypediagnostic: CH2PR13MB3814:
x-microsoft-antispam-prvs: <CH2PR13MB3814C6CBC61D71F091D69E72B8F19@CH2PR13MB3814.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t33Z7kMT9Pyx7sDRkaas/7V7OjZi89pUYpux9vVdgWQ1MA8bJPeD23+fWN5YhwdZdXMOwK6UsBYLY0nW+PA9uqyPIOMRWeExYwL0HVH7DfT/6pHZlhmS0J4n69hsUgPLZsyDrYhn3Dy0J8/Y6DkEaCo2faEL5CeOXxFICHNbU3ePc2P2/5bVS4v9U2zu4LcE1CW+CNm+1RWQxVfD2iXFNqM0fhnIXAWKmkeKe0ZJJbryCfEv66t9G0Mbtr02NdwMsPYdJyFrOfNaHxkLP1Pl8EtJZyylhHXn9gJ52dq86FuNSoMaIXGdR1WcV4qJJFW4w6m8PjF1Nxi9Q7UZhpxpL0Oq+4t3gNvHvPEDqbO62M2ARGi7+YikiGazi/PUzocaqgyuw2PeLdS9r8tE5F2nIh6NNHK4Cj0eYp7Q4UPuEfocPE1PNTcqzTartpMr5U5S/ULLzTZNph1QKLkwzoTTCn0JVH/jI3QmZm0qqmRTlN/LH08RyJTh00xON8Dw52cA1oH6xTQozjv5TURSbQavhwcqOtDfmuCp7Y+xfNaqrld3qKHhxpeQ+PfckA0Ru0ktAYIu+R2T4ckXr2+nUuB0o/n9uPPrr7ApYXirCSFmPQ4x+CVvqy6s1YXtbIDLC0cSkYA1suxsHUk+Gl8F6LF4S/9t0ua4+Vr9PsKE/+flBgpuDBiW7XOFiuxBJn9z52mmUNtLlQ87w6XjQiA7HnW0cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(71200400001)(4326008)(6486002)(86362001)(6512007)(64756008)(66446008)(26005)(38070700005)(508600001)(38100700002)(8676002)(8936002)(5660300002)(6506007)(36756003)(6916009)(83380400001)(316002)(2906002)(66946007)(66556008)(66476007)(2616005)(186003)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGVTeUZ2WXZEdzJLYUJ2Q0RDL2M5NXpBTmNrb1EyVFJxVnlJYXIwYjlkbUtI?=
 =?utf-8?B?QU1XYkw0d21pOVdoRU9qTCtNeU5VSlNhM1hJcjRFOWI4d3FQTmYyQkk3V2xR?=
 =?utf-8?B?NzlsWnNpam5xWlRRK283cmwwbFF3RWc0dWhYWjQvVlZMbGRUZHY5UVJQY0tF?=
 =?utf-8?B?S2dXcEEvMmx5VVA1UTJyb1pOekNlbUN6R0tJT0cyRWlqamdzWWhBdWdRQjdP?=
 =?utf-8?B?Rm56c0VqWSt2WHY2UnQzMndwbGRQYzZObFZta1FMRlV5a2IvcDhnT2tUMjM1?=
 =?utf-8?B?ZlpJckxmQzVLRTdKQTljWC9LbHlYVGphSlkxNmZGQXB4Ujdxd1RkNUx4T2pq?=
 =?utf-8?B?Ykd4VENlVml2MStXeGJJcDEwS0xhMUhRTitCb1BicGkrS1NnV0JBc2ZGMFJr?=
 =?utf-8?B?cDNQaGtVYmR2dHJHR1pUT21wKzR1YnQyZ3JGVlBrWWthQ1c2dWJJcHF6YTVi?=
 =?utf-8?B?c09nRGVhNHVpYjZVUjA1bzRKcUhHNjh4T1dEcEFOQzQ3ekQ0b0h3bzdDTlFX?=
 =?utf-8?B?R09wUTBTU3JYM3dKZE5hRmdYc05temhZV3VJelZ3V0twK0V1eXFDbkhRSEVE?=
 =?utf-8?B?YjJSQTgzQWlZY1d3RzUrY3JVK1NYUU5YSlJrSWtzUWQ0cXZWLzBaSWptYVh5?=
 =?utf-8?B?WkNWYlAvMUlZZVRrSnA5UHVYVnpmQ1Vxb2xRbDVjdFNEVS9nbDUzVHM2bDI4?=
 =?utf-8?B?VmRmVVIyeFdIV2VzQlJKNW16d21sVGxLZWFaK2p1U0IvejJDUUduY0tCZk1B?=
 =?utf-8?B?dXl0U1R6K0hyNXRkZkViTnRZam93SjFMNThkZm1IaXE1L0puaXZLdkxjSXZz?=
 =?utf-8?B?Z2RVV2xRRkZhcGFSWHN4UWo2Rmd6RWVYejY0eGRYay9VTi9ManlPZVF0Nm52?=
 =?utf-8?B?dk9neEJ2K0lsOFNKN1oxZFZ0dEEweUpoV05LdzVLSlQ5TnJZRU1jTDJhYUIy?=
 =?utf-8?B?MHJXV3U2MzAwcXV2MWI0T3hTeXN4SXlUMHJNTmdBMVdYRE5uSEdIRnZzN08v?=
 =?utf-8?B?Zk1hNi9JOVdpc0E0NDlKN0pHc2YraVJsMThGMVFjaUNKWHJ5ek9wSkkxeU1V?=
 =?utf-8?B?V3NaWmlZemNiK1ZzVGNEdWRod2Fpd0dReW9SQU9NVWZOSkRDTzZWckdLd3dT?=
 =?utf-8?B?bEZ4K2pyRTRHZEczeTlMUW9PMEhaRGdidHdaSVdQVkFuMXpLYWFHRFFjaGpt?=
 =?utf-8?B?dThtSjZUMklpVDRtNUxBUk5SYlN1NUdEL3M2akFGRXFVYU51N3dFeXhBK0N0?=
 =?utf-8?B?czdXa0R5TC9iSzlZZXA0T2VhYUVxRnZiZWhWa0pJeEZMVU9HcUxTOTFqelFF?=
 =?utf-8?B?c3FPWFRZUlVHNHJYN3krQU5Mc01ZRnVpaWNWZ3NWY3JEMmlKT29OK2JuNGhP?=
 =?utf-8?B?L1FzWTJxbFMvWlc4S1J1TGQ2TWFrK2JxQUVNWENDQitUelU0emYyU2owdzhR?=
 =?utf-8?B?T0F1Yy9HdDd0Vk9xY05HelJoU3U1SHliMWNMQ0VLWDllRDJtblVXblc5OVBU?=
 =?utf-8?B?a2pEejdVODlESlhaNUFSY0JCV05OWDI5bWJuakJUZ2c1RTBUZ1pFUkhKTmRa?=
 =?utf-8?B?NDF0eFU5N0REc3ZBcmx5K1VEWEE3aEZ1ck1VMitYRlI0V1p3SjVYT3NteThu?=
 =?utf-8?B?OGVlc0g0ZlQvWGJvSHhSTGl4T2F0NTFpYVJkV3ZZalJpYm1zWUtuOERGdnR2?=
 =?utf-8?B?QVU5QVVpZkhXRldsTk5BLy9QYW9QZUk2d1dQYnZFY1NEekZMWXBVWEdYT0lL?=
 =?utf-8?Q?TpgId5lsmRribD7KwwvmxJtg67FglvTi9fMEWgD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DDFF880790E1749B0409A698A36546C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcdbee3-02ba-4a24-86e0-08d956dad05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 00:00:04.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4llyzm2VJi5R23ebpjr+QzSXmzMZJaOLEz6qFKILKnIrm0B4j8SgwGDVfVGK9gc3j8KsNnB0GdoTYdljA5CVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3814
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTA0IGF0IDA5OjQ3ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IE9u
IFdlZCwgMDQgQXVnIDIwMjEsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIw
MjEtMDgtMDMgYXQgMTc6MzYgLTA0MDAsIGJmaWVsZHNAZmllbGRzZXMub3JnwqB3cm90ZToNCj4g
PiA+IE9uIFR1ZSwgQXVnIDAzLCAyMDIxIGF0IDA5OjA3OjExUE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIxLTA4LTAzIGF0IDE2OjMwIC0wNDAwLCBK
LiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCBKdWwgMzAsIDIwMjEgYXQg
MDI6NDg6NDFQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4g
PiA+ID4gPiBPbiBGcmksIDIwMjEtMDctMzAgYXQgMDk6MjUgLTA0MDAsIEJlbmphbWluIENvZGRp
bmd0b24NCj4gPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBJIGhhdmUgc29tZSBmb2xr
cyB1bmhhcHB5IGFib3V0IGJlaGF2aW9yIGNoYW5nZXMgYWZ0ZXI6DQo+ID4gPiA+ID4gPiA+IDQ3
OTIxOTIxOGZiZQ0KPiA+ID4gPiA+ID4gPiBORlM6DQo+ID4gPiA+ID4gPiA+IE9wdGltaXNlIGF3
YXkgdGhlIGNsb3NlLXRvLW9wZW4gR0VUQVRUUiB3aGVuIHdlIGhhdmUNCj4gPiA+ID4gPiA+ID4g
TkZTdjQNCj4gPiA+ID4gPiA+ID4gT1BFTg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
QmVmb3JlIHRoaXMgY2hhbmdlLCBhIGNsaWVudCBob2xkaW5nIGEgUk8gb3BlbiB3b3VsZA0KPiA+
ID4gPiA+ID4gPiBpbnZhbGlkYXRlDQo+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiBw
YWdlY2FjaGUgd2hlbiBkb2luZyBhIHNlY29uZCBSVyBvcGVuLg0KPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gTm93IHRoZSBjbGllbnQgZG9lc24ndCBpbnZhbGlkYXRlIHRoZSBwYWdlY2Fj
aGUsIHRob3VnaA0KPiA+ID4gPiA+ID4gPiB0ZWNobmljYWxseQ0KPiA+ID4gPiA+ID4gPiBpdCBj
b3VsZA0KPiA+ID4gPiA+ID4gPiBiZWNhdXNlIHdlIHNlZSBhIGNoYW5nZWF0dHIgdXBkYXRlIG9u
IHRoZSBSVyBPUEVODQo+ID4gPiA+ID4gPiA+IHJlc3BvbnNlLg0KPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gSSBmZWVsIHRoaXMgaXMgYSBncmV5IGFyZWEgaW4gQ1RPIGlmIHdlJ3JlIGFs
cmVhZHkNCj4gPiA+ID4gPiA+ID4gaG9sZGluZyBhbg0KPiA+ID4gPiA+ID4gPiBvcGVuLsKgDQo+
ID4gPiA+ID4gPiA+IERvIHdlDQo+ID4gPiA+ID4gPiA+IGtub3cgaG93IHRoZSBjbGllbnQgb3Vn
aHQgdG8gYmVoYXZlIGluIHRoaXMgY2FzZT/CoCBTaG91bGQNCj4gPiA+ID4gPiA+ID4gdGhlDQo+
ID4gPiA+ID4gPiA+IGNsaWVudCdzIG9wZW4NCj4gPiA+ID4gPiA+ID4gdXBncmFkZSB0byBSVyBp
bnZhbGlkYXRlIHRoZSBwYWdlY2FjaGU/DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBJdCdzIG5vdCBhICJncmV5IGFyZWEgaW4gY2xvc2UtdG8tb3BlbiIgYXQgYWxs
LiBJdCBpcyB2ZXJ5DQo+ID4gPiA+ID4gPiBjdXQNCj4gPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+
ID4gZHJpZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElmIHlvdSBuZWVkIHRvIGludmFs
aWRhdGUgeW91ciBwYWdlIGNhY2hlIHdoaWxlIHRoZSBmaWxlIGlzDQo+ID4gPiA+ID4gPiBvcGVu
LA0KPiA+ID4gPiA+ID4gdGhlbg0KPiA+ID4gPiA+ID4gYnkgZGVmaW5pdGlvbiB5b3UgYXJlIGlu
IGEgc2l0dWF0aW9uIHdoZXJlIHRoZXJlIGlzIGEgd3JpdGUNCj4gPiA+ID4gPiA+IGJ5DQo+ID4g
PiA+ID4gPiBhbm90aGVyDQo+ID4gPiA+ID4gPiBjbGllbnQgZ29pbmcgb24gd2hpbGUgeW91IGFy
ZSByZWFkaW5nLiBZb3UncmUgY2xlYXJseSBub3QNCj4gPiA+ID4gPiA+IGRvaW5nDQo+ID4gPiA+
ID4gPiBjbG9zZS0NCj4gPiA+ID4gPiA+IHRvLW9wZW4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
RG9jdW1lbnRhdGlvbiBpcyByZWFsbHkgdW5jbGVhciBhYm91dCB0aGlzIGNhc2UuwqAgRXZlcnkN
Cj4gPiA+ID4gPiBkZWZpbml0aW9uIG9mDQo+ID4gPiA+ID4gY2xvc2UtdG8tb3BlbiB0aGF0IEkn
dmUgc2VlbiBzYXlzIHRoYXQgaXQgcmVxdWlyZXMgYSBjYWNoZQ0KPiA+ID4gPiA+IGNvbnNpc3Rl
bmN5DQo+ID4gPiA+ID4gY2hlY2sgb24gZXZlcnkgYXBwbGljYXRpb24gb3Blbi7CoCBJJ3ZlIG5l
dmVyIHNlZW4gb25lIHRoYXQNCj4gPiA+ID4gPiBzYXlzDQo+ID4gPiA+ID4gIm9uDQo+ID4gPiA+
ID4gZXZlcnkgb3BlbiB0aGF0IGRvZXNuJ3Qgb3ZlcmxhcCB3aXRoIGFuIGFscmVhZHktZXhpc3Rp
bmcgb3Blbg0KPiA+ID4gPiA+IG9uDQo+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+IGNsaWVudCIu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhleSAqdXN1YWxseSogYWxzbyBwcmVmYWNlIHRoYXQg
Ynkgc2F5aW5nIHRoYXQgdGhpcyBpcw0KPiA+ID4gPiA+IG1vdGl2YXRlZA0KPiA+ID4gPiA+IGJ5
DQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gdXNlIGNhc2Ugd2hlcmUgb3BlbnMgZG9uJ3Qgb3Zl
cmxhcC7CoCBCdXQgaXQncyBuZXZlciBtYWRlDQo+ID4gPiA+ID4gY2xlYXINCj4gPiA+ID4gPiB0
aGF0DQo+ID4gPiA+ID4gdGhhdCdzIHBhcnQgb2YgdGhlIGRlZmluaXRpb24uDQo+ID4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiBJJ20gbm90IGZvbGxvd2luZyB5b3VyIGxvZ2ljLg0KPiA+ID4g
DQo+ID4gPiBJdCdzIGp1c3QgYSBxdWVzdGlvbiBvZiB3aGF0IGV2ZXJ5IHNvdXJjZSBJIGNhbiBm
aW5kIHNheXMgY2xvc2UtDQo+ID4gPiB0by0NCj4gPiA+IG9wZW4NCj4gPiA+IG1lYW5zLsKgIEUu
Zy4sIE5GUyBJbGx1c3RyYXRlZCwgcC4gMjQ4LCAiQ2xvc2UtdG8tb3BlbiBjb25zaXN0ZW5jeQ0K
PiA+ID4gcHJvdmlkZXMgYSBndWFyYW50ZWUgb2YgY2FjaGUgY29uc2lzdGVuY3kgYXQgdGhlIGxl
dmVsIG9mIGZpbGUNCj4gPiA+IG9wZW5zDQo+ID4gPiBhbmQNCj4gPiA+IGNsb3Nlcy7CoCBXaGVu
IGEgZmlsZSBpcyBjbG9zZWQgYnkgYW4gYXBwbGljYXRpb24sIHRoZSBjbGllbnQNCj4gPiA+IGZs
dXNoZXMNCj4gPiA+IGFueQ0KPiA+ID4gY2FjaGVkIGNoYW5ncyB0byB0aGUgc2VydmVyLsKgIFdo
ZW4gYSBmaWxlIGlzIG9wZW5lZCwgdGhlIGNsaWVudA0KPiA+ID4gaWdub3Jlcw0KPiA+ID4gYW55
IGNhY2hlIHRpbWUgcmVtYWluaW5nIChpZiB0aGUgZmlsZSBkYXRhIGFyZSBjYWNoZWQpIGFuZCBt
YWtlcw0KPiA+ID4gYW4NCj4gPiA+IGV4cGxpY2l0IEdFVEFUVFIgY2FsbCB0byB0aGUgc2VydmVy
IHRvIGNoZWNrIHRoZSBmaWxlDQo+ID4gPiBtb2RpZmljYXRpb24NCj4gPiA+IHRpbWUuIg0KPiA+
ID4gDQo+ID4gPiA+IFRoZSBjbG9zZS10by1vcGVuIG1vZGVsIGFzc3VtZXMgdGhhdCB0aGUgZmls
ZSBpcyBvbmx5IGJlaW5nDQo+ID4gPiA+IG1vZGlmaWVkIGJ5DQo+ID4gPiA+IG9uZSBjbGllbnQg
YXQgYSB0aW1lIGFuZCBpdCBhc3N1bWVzIHRoYXQgZmlsZSBjb250ZW50cyBtYXkgYmUNCj4gPiA+
ID4gY2FjaGVkDQo+ID4gPiA+IHdoaWxlIGFuIGFwcGxpY2F0aW9uIGlzIGhvbGRpbmcgaXQgb3Bl
bi4NCj4gPiA+ID4gVGhlIHBvaW50IGNoZWNrcyBleGlzdCBpbiBvcmRlciB0byBkZXRlY3QgaWYg
dGhlIGZpbGUgaXMgYmVpbmcNCj4gPiA+ID4gY2hhbmdlZA0KPiA+ID4gPiB3aGVuIHRoZSBmaWxl
IGlzIG5vdCBvcGVuLg0KPiA+ID4gPiANCj4gPiA+ID4gTGludXggZG9lcyBub3QgaGF2ZSBhIHBl
ci1hcHBsaWNhdGlvbiBjYWNoZS4gSXQgaGFzIGEgcGFnZQ0KPiA+ID4gPiBjYWNoZQ0KPiA+ID4g
PiB0aGF0DQo+ID4gPiA+IGlzIHNoYXJlZCBhbW9uZyBhbGwgYXBwbGljYXRpb25zLiBJdCBpcyBp
bXBvc3NpYmxlIGZvciB0d28NCj4gPiA+ID4gYXBwbGljYXRpb25zDQo+ID4gPiA+IHRvIG9wZW4g
dGhlIHNhbWUgZmlsZSB1c2luZyBidWZmZXJlZCBJL08sIGFuZCB5ZXQgc2VlIGRpZmZlcmVudA0K
PiA+ID4gPiBjb250ZW50cy4NCj4gPiA+IA0KPiA+ID4gUmlnaHQsIHNvIGJhc2VkIG9uIHRoZSBk
ZXNjcmlwdGlvbnMgbGlrZSB0aGUgb25lIGFib3ZlLCBJIHdvdWxkDQo+ID4gPiBoYXZlDQo+ID4g
PiBleHBlY3RlZCBib3RoIGFwcGxpY2F0aW9ucyB0byBzZWUgbmV3IGRhdGEgYXQgdGhhdCBwb2lu
dC4NCj4gPiANCj4gPiBXaHk/IFRoYXQgd291bGQgYmUgYSBjbGVhciB2aW9sYXRpb24gb2YgdGhl
IGNsb3NlLXRvLW9wZW4gcnVsZSB0aGF0DQo+ID4gbm9ib2R5IGVsc2UgY2FuIHdyaXRlIHRvIHRo
ZSBmaWxlIHdoaWxlIGl0IGlzIG9wZW4uDQo+ID4gDQo+IA0KPiBJcyB0aGUgcnVsZQ0KPiBBIC3C
oCAiaXQgaXMgbm90IHBlcm1pdHRlZCBmb3IgYW55IG90aGVyIGFwcGxpY2F0aW9uL2NsaWVudCB0
byB3cml0ZQ0KPiB0bw0KPiDCoMKgwqDCoMKgIHRoZSBmaWxlIHdoaWxlIGFub3RoZXIgaGFzIGl0
IG9wZW4iDQo+IMKgb3INCj4gQiAtwqAgIml0IGlzIG5vdCBleHBlY3RlZCBmb3IgYW55IG90aGVy
IGFwcGxpY2F0aW9uL2NsaWVudCB0byB3cml0ZSB0bw0KPiDCoMKgwqDCoMKgIHRoZSBmaWxlIHdo
aWxlIGFub3RoZXIgaGFzIGl0IG9wZW4iDQo+IA0KPiBJIHRoaW5rIEIsIGJlY2F1c2UgQSBpcyBj
bGVhcmx5IG5vdCBlbmZvcmNlZC7CoCBUaGF0IHN1Z2dlc3RzIHRoYXQNCj4gdGhlcmUNCj4gaXMg
bm8gKm5lZWQqIHRvIGNoZWNrIGZvciBjaGFuZ2VzLCBidXQgZXF1YWxseSB0aGVyZSBpcyBubyBi
YXJyaWVyIHRvDQo+IGNoZWNraW5nIGZvciBjaGFuZ2VzLsKgIFNvIHRoYXQgZmFjdCB0aGF0IG9u
ZSBhcHBsaWNhdGlvbiBoYXMgdGhlIGZpbGUNCj4gb3BlbiBzaG91bGQgbm90IHByZXZlbnQgYSBj
aGVjayB3aGVuIGFub3RoZXIgYXBwbGljYXRpb24gb3BlbnMgdGhlDQo+IGZpbGUuDQo+IEVxdWFs
bHkgaXQgc2hvdWxkIG5vdCBwcmV2ZW50IGEgZmx1c2ggd2hlbiBzb21lIG90aGVyIGFwcGxpY2F0
aW9uDQo+IGNsb3Nlcw0KPiB0aGUgZmlsZS4NCj4gDQo+IEl0IGlzIHNvbWV3aGF0IHdlaXJkIHRo
YXQgaWYgYW4gYXBwbGljYXRpb24gb24gb25lIGNsaWVudCBtaXNiZWhhdmVzDQo+IGJ5DQo+IGtl
ZXBpbmcgYSBmaWxlIG9wZW4sIHRoYXQgd2lsbCBwcmV2ZW50IG90aGVyIGFwcGxpY2F0aW9ucyBv
biB0aGUgc2FtZQ0KPiBjbGllbnQgZnJvbSBzZWVpbmcgbm9uLWxvY2FsIGNoYW5nZXMsIGJ1dCB3
aWxsIG5vdCBwcmV2ZW50DQo+IGFwcGxpY2F0aW9ucw0KPiBvbiBvdGhlciBjbGllbnRzIGZyb20g
c2VlaW5nIGFueSBjaGFuZ2VzLg0KPiANCj4gTmVpbEJyb3duDQoNCk5vLiBXaGF0IHlvdSBwcm9w
b3NlIGlzIHRvIG9wdGltaXNlIGZvciBhIGZyaW5nZSBjYXNlLCB3aGljaCB3ZSBjYW5ub3QNCmd1
YXJhbnRlZSB3aWxsIHdvcmsgYW55d2F5LiBJJ2QgbXVjaCByYXRoZXIgb3B0aW1pc2UgZm9yIHRo
ZSBjb21tb24NCmNhc2UsIHdoaWNoIGlzIHRoZSBvbmx5IGNhc2Ugd2l0aCBwcmVkaWN0YWJsZSBz
ZW1hbnRpY3MuDQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
