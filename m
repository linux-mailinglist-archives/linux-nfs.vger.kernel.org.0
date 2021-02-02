Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABF30CECF
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 23:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhBBW0v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 17:26:51 -0500
Received: from mail-dm6nam10on2092.outbound.protection.outlook.com ([40.107.93.92]:45965
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235135AbhBBWZe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Feb 2021 17:25:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHUPexZfNwqtGEKP4jOOd6m5CmP6jSf1cQpEQR61CphOArqS+/nMmf9BGsP+ODUli5zHi5peKxcr1McNCvvtKE682p3KfnCLdBoTswRiWE5YnhWjdQXPHWk/X6ygR8JBeB9Vak3QPzD/kBU40VTWr8W+Y5qCSHxHyBGqhuvEfScvTUOLwtLHvV+cnwZtPy/KhY79FjvY/ujz3bKifXSjSwhu24uVJ6Z9gaYbyet4DusvhiXtuC2wAomRfFGtWG1boL+M8KLP4ZXBiVWXbeZO9198X/U32bGPhOGx8n5WMPjPQyHNk/P7wKYEgmi4hVgNtmy96UFzw/rlzgoojy8vGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbuciMOjyLWWciyT7DEl3ecENY1f+5JI5VcOlx9wk30=;
 b=iwFeRaIx14+O1yj+cdcgzaiK2HbCft1PhQIwj2+Eo9Go0v7dPReX+PcfncX7b/UUfEhQozAYL4NW0SFpey0DnORLK/FNOU707Ug6Fose+93rHKl1b0h5niq2LqG/nvFXeYwA9Cc/g0NpvoPrMOH3KYr2w7fGQc3JPwybLfyuWeN01aldiDob78TBhdqEWyUfqtQgTEe9mx5XvdvZQbApbwSCwRjV/NIQ/CHp/Dgzv8D08RsxJ+UoQu7xxqMv0oQbLEFspcoxIWK6nVNdWqt6glEaPXCJjJcfST61FSyw7CzgYbkDnKdlmEcgzukKKyY450t9e2TRdqBbUEzNL2mRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbuciMOjyLWWciyT7DEl3ecENY1f+5JI5VcOlx9wk30=;
 b=e7wu1RU9sZfxyylPtDnb8tA5neynZUtnChs8N7jZhE0La0OzGoBbZrpwY+5hhySSIhFWzE8CzxN+R+eZ3SgRBhcBTurYHuqwZJmDiAVr+2oycUcMkIjIOP4RBPcYSes+E6pNpfIkXzTW/xMq2p+eh66nCRBmTqKN+RotnbdswAA=
Received: from (2603:10b6:610:21::29) by
 CH0PR13MB4620.namprd13.prod.outlook.com (2603:10b6:610:c4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.8; Tue, 2 Feb 2021 22:24:39 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f453:2dd2:675:d063%3]) with mapi id 15.20.3825.019; Tue, 2 Feb 2021
 22:24:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "dan@kernelim.com" <dan@kernelim.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Subject: Re: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Topic: [PATCH v2 0/5] SUNRPC: Create sysfs files for changing IP
Thread-Index: AQHW+ZOgOm5dsTpDO0+RCMzuTmcxr6pFNttlgAAH/ICAAAcVAIAAKWWAgAAA/YCAAADpgA==
Date:   Tue, 2 Feb 2021 22:24:39 +0000
Message-ID: <f78d47587d548933598a044d8094ed496400cea2.camel@hammerspace.com>
References: <20210202184244.288898-1-Anna.Schumaker@Netapp.com>
         <75F3F315-84AA-41A0-A43A-C531042A9C47@oracle.com>
         <CAFX2JfktYGe4vDtXogFHurdyz4TJx5APj9pb-J5HmsDGC99kaA@mail.gmail.com>
         <20210202192417.ug32gmuc2uciik54@gmail.com>
         <8A686173-B3FF-4122-990C-6E8795D35161@redhat.com>
         <7dfd7e3b9fb39da71f1654347ca2f2feba4fc04d.camel@hammerspace.com>
         <102D99DF-30C7-4360-9A84-D5A4DA77FE1C@oracle.com>
In-Reply-To: <102D99DF-30C7-4360-9A84-D5A4DA77FE1C@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a9a782e-f92b-4c6e-2291-08d8c7c9548c
x-ms-traffictypediagnostic: CH0PR13MB4620:
x-microsoft-antispam-prvs: <CH0PR13MB46204742E6BA8D1736B566E5B8B59@CH0PR13MB4620.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LcuztZJxLZaeNroHHl568ERW/w33r/wx9Hq9e+3o0Gn0pRDIufvi/7h+Gbr7vKnThnhO+VCkA124xXaM10gCsh34wWq7QVZb161oINv70f6FPmjrxfrGyB+fusB+uODnkUfkTH2Cq/PgWgBuoKIfRl51WcAKMcUb4z8FrdiO68h5/8rxxNULHy6wW6OJPEn5TdWAjWMGp6jb5yHODGFKU3o7BzydZ30H5MylnWLZ1eCv9eIpBY5d/f2S5axa0+a7alyKklBMSAlthAtv/Sh8URlpc6JTTt4r5SFE2symvcloqOKmwkQLpDQGQYhmIn0rSGxlfuqM3sYP/UaW5DJksE1qDGP4W4KvmFVafvCJY7pHsLh2AKbF3gmmv2drRKkfOgIBCD+TSV8MAURS4aNYBcbRcAkgMU8LxfyJg1cbZzvUGACepWPXAHquV4J6b0gf1NNOFUF3hX23K4yWJ2oLOOw3FtfBzIBKUOxfF6wybmWzjxh5g3kWDYtfEHjgM6r8FYhAnMgeWHiV2evIDLU5Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(346002)(136003)(366004)(186003)(8936002)(316002)(71200400001)(4326008)(53546011)(6506007)(76116006)(8676002)(2906002)(66556008)(54906003)(2616005)(36756003)(83380400001)(26005)(5660300002)(86362001)(64756008)(6512007)(66446008)(66476007)(6916009)(478600001)(6486002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?amltL1J0S0k1d1RhTmVFbGNRa0ZmdysrTFF6eDlEWVI2eHZnelJOSWJDY2Rw?=
 =?utf-8?B?SGtkY1NCYkp4TnI5NVVNNFM3N2JwQ0JEYUYvb21XbXRDb1pDZGVyQ0VPWS9m?=
 =?utf-8?B?eTFWYk1EOXcydkNGcmVDZ0lKeUE1bU03ZGEzZGFieHg0UWVQcUZKMlVQUXk3?=
 =?utf-8?B?SVJmK3lCUnh3VEw4R2pUL28xY0pidnhXZTVIQVFuQURzUDFsRm5UY2lvcWpF?=
 =?utf-8?B?cGJLR2dCNUl1eEtCa3R0TFhGMks3Y0VWY1hUZFJ5MkFwemVTc3diR1V0MjhV?=
 =?utf-8?B?TlRZd1BscU1sSFBtSVpqTFRBdSt2b2lCdDRXOTBWdHVtMGtHTUExSFlEK093?=
 =?utf-8?B?SDV1OGZUQVdvTmx0dTc4RDF0cFpGS3dYdTQvZmNHTkVrZmhiK3dlUlRVTG0r?=
 =?utf-8?B?eE1yaHZReEdsY2N1amkyV2RCU1ZTYVlhVTNiS1VuT29tSFN6WW5SU09rd1FD?=
 =?utf-8?B?Vk1URzNJRTBjbFphcURwam5ZWVpjUUkyTEFBOVNCc3dSS1BkY2JBM3UvRzFX?=
 =?utf-8?B?UkNJaE9RMnpRSGNINEZreUdoZ3Q3cTVrazRpWmw1cnBUK00waHF3LzFZZUE2?=
 =?utf-8?B?UlQyWFVnQUdLRC91bDQzQkh3ODUrK3cvcW1nbkJFaTNPUDVjNWp1UTdBZmt5?=
 =?utf-8?B?V21WYkdmUVV1eUpPK2NHK1hSaUs2RllRVm9kMVp1aUVzZVJ4V2plK1JiSndH?=
 =?utf-8?B?Z3ZxMllIVEJGOWF4dVd5d2R0cTBSKzVvUkdQNDM5WjRHdUFZSzZLYk9xTzc5?=
 =?utf-8?B?a0hoMDhSK2pRcG05Z3RpT3NEQklSSFdZa05hWlJ0WGx0b1ByZGkwNnZOaFFZ?=
 =?utf-8?B?dnJBR2ZOS1A0ZDcrVTR0KzVOdlRESUdPak16SC9KUW4wUXRKbEJ5dVFhZUdQ?=
 =?utf-8?B?RHV0MXpaVWZrVlIvMU84bzl0cWQwYUVVZ0FjTldGWnNzSWlJVTRGRDVVTWZX?=
 =?utf-8?B?dWM1a2dTUGpjUlVPNER6b0M5R2wxZXh0UGFPVWQ5bXl6SmoxNlIxc3ZoOGlv?=
 =?utf-8?B?MjBtM214N0cxOUZuZnpRVlc4eHF4MC90MWU3dXRJbDBpaCtwbkZ3Y011MzRR?=
 =?utf-8?B?blBPRCtGVktDMmd0VldMWjZ0Y0R5WDlmL2xrQ2VneTF2cXFIT1F5SFlVVlA4?=
 =?utf-8?B?cGZRSXJkRFYxa3JxelBZR205aE0rcGpJU1JlT2VsbFN3WmhoM3RhMDl4cjQz?=
 =?utf-8?B?SSt4TmZ6cXNYbFNjTzlhdVliczVjM1dtTy81RVdibWlSdThBWjUzTzRhdjVl?=
 =?utf-8?B?WE9UdXdYZDdBZlM4aG1XaGdwZnpnaVora3ZtdUoxWkFaUWxQZDJIcG4vZ3Ur?=
 =?utf-8?B?Yno1TFZRUVQrYnlhQjZHMzNsWURMVUpRVkVnTElhL0pLWWYwRTFqeTFBaERF?=
 =?utf-8?B?dEFNenVaTXlTeUlWeVo5cVVyd09wWjlzM1RJZ1hOTkNxLzg2SmRSU0kvTTZk?=
 =?utf-8?B?R0VvL3d3Q1lkK211R3I1RlJjeVZiY21salg0Yi9nPT0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF1147A65BA3BC438A1D67EA8E62C219@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9a782e-f92b-4c6e-2291-08d8c7c9548c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 22:24:39.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G32Qb9DM6na+2ay9zP3nj9SpUtK2disKrWnVh7o2TcnH+jsKhTFF+PHm7OwZNbNwXdf+YrH4MMR8Z6wry5NJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB4620
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTAyLTAyIGF0IDIyOjIxICswMDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
DQo+IA0KPiA+IE9uIEZlYiAyLCAyMDIxLCBhdCA1OjE3IFBNLCBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiA+IHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIw
MjEtMDItMDIgYXQgMTQ6NDkgLTA1MDAsIEJlbmphbWluIENvZGRpbmd0b24gd3JvdGU6DQo+ID4g
PiBPbiAyIEZlYiAyMDIxLCBhdCAxNDoyNCwgRGFuIEFsb25pIHdyb3RlOg0KPiA+ID4gDQo+ID4g
PiA+IE9uIFR1ZSwgRmViIDAyLCAyMDIxIGF0IDAxOjUyOjEwUE0gLTA1MDAsIEFubmEgU2NodW1h
a2VyIHdyb3RlOg0KPiA+ID4gPiA+IFlvdSdyZSB3ZWxjb21lISBJJ2xsIHRyeSB0byByZW1lbWJl
ciB0byBDQyBoaW0gb24gZnV0dXJlDQo+ID4gPiA+ID4gdmVyc2lvbnMNCj4gPiA+ID4gPiBPbiBU
dWUsIEZlYiAyLCAyMDIxIGF0IDE6NTEgUE0gQ2h1Y2sgTGV2ZXINCj4gPiA+ID4gPiA8Y2h1Y2su
bGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgd2Fu
dCB0byBlbnN1cmUgRGFuIGlzIGF3YXJlIG9mIHRoaXMgd29yay4gVGhhbmtzIGZvcg0KPiA+ID4g
PiA+ID4gcG9zdGluZywNCj4gPiA+ID4gPiA+IEFubmEhDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFu
a3MgQW5uYSBhbmQgQ2h1Y2suIEknbSBhY2Nlc3NpbmcgYW5kIG1vbml0b3JpbmcgdGhlIG1haWxp
bmcNCj4gPiA+ID4gbGlzdCB2aWENCj4gPiA+ID4gTk5UUCBhbmQgSSdtIGFsc28gb24gI2xpbnV4
LW5mcyBmb3IgY2hhdHRpbmcgKGRhLXgpLg0KPiA+ID4gPiANCj4gPiA+ID4gSSBzZWUgc3JjYWRk
ciB3YXMgYWxyZWFkeSBkaXNjdXNzZWQsIHNvIHRoZSBwYXRjaGVzIEknbQ0KPiA+ID4gPiBwbGFu
bmluZyB0bw0KPiA+ID4gPiBzZW5kDQo+ID4gPiA+IG5leHQgd2lsbCBiZSBiYXNlZCBvbiB0aGUg
bGF0ZXN0IHZlcnNpb24gb2YgeW91ciBwYXRjaHNldCBhbmQNCj4gPiA+ID4gY29uY2Vybg0KPiA+
ID4gPiBtdWx0aXBhdGguDQo+ID4gPiA+IA0KPiA+ID4gPiBXaGF0IEknbSBnb2luZyBmb3IgaXMg
dGhlIGZvbGxvd2luZzoNCj4gPiA+ID4gDQo+ID4gPiA+IC0gRXhwb3NlIHRyYW5zcG9ydHMgdGhh
dCBhcmUgcmVhY2hhYmxlIGZyb20geHBydG11bHRpcGF0aC4gRWFjaA0KPiA+ID4gPiBpbg0KPiA+
ID4gPiBpdHMNCj4gPiA+ID4gwqAgb3duIHN1Yi1kaXJlY3RvcnksIHdpdGggYW4gaW50ZXJmYWNl
IGFuZCBzdGF0dXMNCj4gPiA+ID4gcmVwcmVzZW50YXRpb24NCj4gPiA+ID4gc2ltaWxhcg0KPiA+
ID4gPiDCoCB0byB0aGUgdG9wIGRpcmVjdG9yeS4NCj4gPiA+ID4gLSBBIHdheSB0byBhZGQvcmVt
b3ZlIHRyYW5zcG9ydHMuDQo+ID4gPiA+IC0gSW5zcGlyYXRpb24gZm9yIGNvZGluZyB0aGlzIGlz
IHZhcmlvdXMgb3RoZXIgdGhpbmdzIGluIHRoZQ0KPiA+ID4gPiBrZXJuZWwNCj4gPiA+ID4gdGhh
dA0KPiA+ID4gPiDCoCB1c2UgY29uZmlnZnMsIHBlcmhhcHMgaXQgY2FuIGJlIHVzZWQgaGVyZSB0
b28uDQo+ID4gPiA+IA0KPiA+ID4gPiBBbHNvLCB3aGF0IGRvIHlvdSB0aGluayB3b3VsZCBiZSBh
IHN0cmFpZ2h0Zm9yd2FyZCB3YXkgZm9yIGENCj4gPiA+ID4gdXNlcnNwYWNlDQo+ID4gPiA+IHBy
b2dyYW0gdG8gZmluZCB3aGF0IHN1bnJwYyBjbGllbnQgaWQgc2VydmVzIGEgbW91bnRwb2ludD8g
SWYNCj4gPiA+ID4gd2UNCj4gPiA+ID4gYWRkIGFuDQo+ID4gPiA+IGlvY3RsIGZvciB0aGUgbW91
bnRkaXIgQUZBSUsgaXQgd291bGQgYmUgdGhlIGZpcnN0IG9uZSB0aGF0IHRoZQ0KPiA+ID4gPiBO
RlMNCj4gPiA+ID4gY2xpZW50IHN1cHBvcnRzLCBzbyBJIHdvbmRlciBpZiB0aGVyZSdzIGEgYmV0
dGVyIGludGVyZmFjZSB0aGF0DQo+ID4gPiA+IGNhbg0KPiA+ID4gPiB3b3JrDQo+ID4gPiA+IGZv
ciB0aGF0Lg0KPiA+ID4gDQo+ID4gPiBJJ20gYSBmYW4gb2YgYWRkaW5nIGFuIGlvY3RsIGludGVy
ZmFjZSBmb3IgdXNlcnNwYWNlLCBidXQgSSB0aGluaw0KPiA+ID4gd2UnZA0KPiA+ID4gYmV0dGVy
IGF2b2lkIHVzaW5nIE5GUyBpdHNlbGYgYmVjYXVzZSBpdCB3b3VsZCBiZSBuaWNlIHRvIHNvbWVk
YXkNCj4gPiA+IGltcGxlbWVudA0KPiA+ID4gYW4gTkZTICJzaHV0ZG93biIgZm9yIG5vbi1yZXNw
b25zaXZlIHNlcnZlcnMsIGJ1dCBzZW5kaW5nIGFueQ0KPiA+ID4gaW9jdGwNCj4gPiA+IHRvIHRo
ZQ0KPiA+ID4gbW91bnRwb2ludCBjb3VsZCByZXZhbGlkYXRlIGl0LCBhbmQgd2UnZCBoYW5nIG9u
IHRoZSBHRVRBVFRSLg0KPiA+ID4gDQo+ID4gPiBNYXliZSB3ZSBjYW4gZmlndXJlIG91dCBhIHdh
eSB0byBleHBvc2UgdGhlIHN1cGVyYmxvY2sgdmlhIHN5c2ZzDQo+ID4gPiBmb3INCj4gPiA+IGVh
Y2gNCj4gPiA+IG1vdW50Lg0KPiA+IA0KPiA+IFJpZ2h0LiBUaGVyZSBpcyBwb3RlbnRpYWwgZnVu
Y3Rpb25hbGl0eSBoZXJlIHRoYXQgd2UgZG8gbm90IG5lZWQgb3INCj4gPiBldmVuIHdhbnQgdG8g
ZXhwb3NlIHZpYSB0aGUgbW91bnQgaW50ZXJmYWNlLiBCZWluZyBhYmxlIHRvIGNhbmNlbA0KPiA+
IGFsbA0KPiA+IHRoZSBodW5nIFJQQyBjYWxscyBpbiBhbiBSUEMgcXVldWUsIGZvciBpbnN0YW5j
ZSwgaXMgbm90IHNvbWV0aGluZw0KPiA+IHlvdQ0KPiA+IHdhbnQgdG8gZG8gdGhyb3VnaCBmc29w
ZW4oKSBhbmQgZnJpZW5kcy4NCj4gDQo+IEkgdGhvdWdodCB3ZSB3ZXJlIHRhbGtpbmcgb25seSBh
Ym91dCBhbiBpb2N0bCBvciBmc29wZW4gY21kIHRoYXQNCj4gaWRlbnRpZmllcyB0aGUgdHJhbnNw
b3J0cyB0aGF0IGFyZSBhc3NvY2lhdGVkIHdpdGggYW4gTkZTIG1vdW50Lg0KPiANCj4gT3N0ZW5z
aWJseSBhIHJlYWQtb25seSB1c2Ugb2YgdGhhdCBBUEkuDQo+IA0KDQpJJ2xsIGxldCBBbm5hIGNo
aW1lIGluIHdpdGggdGhlIGRldGFpbHMgb2YgaGVyIHVzZSBjYXNlLCBidXQgbXkNCnVuZGVyc3Rh
bmRpbmcgaGFzIGFsd2F5cyBiZWVuIHRoYXQgdGhpcyB3b3VsZCBiZSBhIHJlYWQvd3JpdGUgaW50
ZXJmYWNlDQpmb3IgY2hhbmdpbmcgdGhlIHByb3BlcnRpZXMgb2YgdGhvc2UgdHJhbnNwb3J0cyBv
biB0aGUgZmx5Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
