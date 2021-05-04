Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11FA373209
	for <lists+linux-nfs@lfdr.de>; Tue,  4 May 2021 23:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhEDVth (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 May 2021 17:49:37 -0400
Received: from mail-bn8nam11on2132.outbound.protection.outlook.com ([40.107.236.132]:2913
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231478AbhEDVth (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 May 2021 17:49:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJF/ykeHAAmrpZ+6teofM01S1Hl7E59Q7GKY1jLAP7bkQOlZUbSUmQ850qiXWDpUOJDAFDmmYEhXuYMOZ5xFeGDOzka9ZX2SCpgHfDGPu+KcmUkcLaCOsxEXsVL94CaFMBevo1IzXE9isRKoVTxdWduFFPBh36YbTaut6EAoV13/ifaKtH6MBM2GmNfFMfmm8x9ugOgxAp6S+uFrB4Av4i11Dw0FjSitImXJhm2fRHyU2SQacBG5KJN6QNLFY+7HQRdHEZ5aV7nGFcl3TvF0JckyDOS6pp+NPGOtEoHlQdsXfiVCY8vZEtqHQo0q7v1oPiVfQOnYDb49yZQl4DFN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjnNmWxfNYmQy/EKB3fs35wIbHlV6ZBVnNa6qc77BS4=;
 b=hqpyGIiJQsBVaI7eMc/MafKfgf7xavf2tV8E+21M/NPDJ4FN5FTvYjliyc6C2Bp+thgoikjrx8sKjJY0WkoZvF8X5QDrHaAPB7coOai0sOYRmOif2+gm6597RtKha7ziYH7qrn18vQSlCYnnxz6++0lMJl4KWTc5A7+TVRtFNjpzcC56sT6USOY6nYgF5PdTCwz7uqrnHwXK/jaMqxKVCVo5yB5VG2pyCghSdgiQaDpiAT3HJN/pvADMcA1euviTkElrSpFmN6GRqhbOqo73V5FYBvbsJzHzXPNm1K1M0xR9k2clC9bgSEnnJVZDeePz3kJG348tPtyXZGmLU7AjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjnNmWxfNYmQy/EKB3fs35wIbHlV6ZBVnNa6qc77BS4=;
 b=WEdGbFmQaA76U+8Z0rPSNtoeEc+lxK9WbZz6b2r6gPBWWN9HwcJe9HaBDAyos3TGj8Hb1kqxfPW/8mFV36tcaCiVYjWSEG2oYpGs4Bh0zGnJ/QhKTGezwU7UsZBb8XbeVEay/EbU83fxxrEKeL6lGFJHE1KEeQEoABMgqPCOH8c=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DS7PR13MB4573.namprd13.prod.outlook.com (2603:10b6:5:3a5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8; Tue, 4 May
 2021 21:48:39 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4108.025; Tue, 4 May 2021
 21:48:39 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "daire@dneg.com" <daire@dneg.com>
CC:     "fsorenso@redhat.com" <fsorenso@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>, "neilb@suse.de" <neilb@suse.de>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "jshivers@redhat.com" <jshivers@redhat.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHXQS0DWZUx7XJl40Wa7JAyuJnZ3KrT3CAA
Date:   Tue, 4 May 2021 21:48:39 +0000
Message-ID: <5bd2516e41f7a6b35ea9772a56a7dfdec52b83a9.camel@hammerspace.com>
References: <20201007140502.GC23452@fieldses.org>
         <20210119222229.GA29488@fieldses.org>
         <2d77534fb8be557c6883c8c386ebf4175f64454a.camel@hammerspace.com>
         <20210120150737.GA17548@fieldses.org> <20210503200952.GB18779@fieldses.org>
         <162009412979.28954.17703105649506010394@noble.neil.brown.name>
         <4033e1e8b52c27503abe5855f81b7d12b2e46eec.camel@hammerspace.com>
         <20210504165120.GA18746@fieldses.org>
         <1449034832.11389942.1620163955863.JavaMail.zimbra@dneg.com>
In-Reply-To: <1449034832.11389942.1620163955863.JavaMail.zimbra@dneg.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a653c93e-5278-49c5-c250-08d90f4660b3
x-ms-traffictypediagnostic: DS7PR13MB4573:
x-microsoft-antispam-prvs: <DS7PR13MB457345B8EE2BD4BE5662C1DCB85A9@DS7PR13MB4573.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXfXx0HzMsh2HWuB0eSLbuy/+t6Zof96B+yLQl5E8a/i/qkqUvA7j11+/ErC1R686PrpivtJrlaMdBISPKjEn4wN5hbIlzc2tCnWxH7PJPKtAdp8wSeRK0QQtd2rWKIOmPmRtHm/AMsRnvtpekxtO2jtmITYFzq511eKv2Q21PSiVb9EIYAqWM7pXHB9B1p03q0Z5cOrBNhuQViRz0xgsQUMcUfwkhynZZPPyK3y/epqXN3AG9mNyEalRwDGkXiQn6MPD7BPMjjXgU0jmfF7ABPbwXTvGWzsMCRmpaY2X7xNT77UXSVEAHVxHuO3AvfGS5+4z7/C9HaO0FDKcMnANqiJfroP1u0MpPO8LXxw0KXYCmbhczM9YLiyP9GQIZxEMFFZLZ2ScHfzBVu3RM/3qYFljoRHKoD/4H2Rdzlze0yiy5F79iW6BRxSCqcK6RKnEYq4qSGYK7PYhcK4V0hvvwy/p1eOpwd9vShrUFj9fqhSkKluFZYtwHCdnUa7o35gY1MYZp+6R676kT/mWWcs/Iejv4PoS0vj8/wLhPOSG6P2lgfEjiB0c0/4djuIi5YIGAhsM96jxrJtNInW5vIGlDUFnzwIoqMNY4/SmwfHLkhYtIpofuLVB4p1/bm96xO/S1gDH9amoZ/ZzPY866c1Z9eb6euV2AaVl7G0gcFRxz2JR6ymMAPyh8wwRI8p4OTDCkCZ/52/amCIHVB+yxepCR89KaXBycMpRdz72UaEJn0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39830400003)(346002)(376002)(966005)(26005)(83380400001)(6486002)(8936002)(186003)(2616005)(8676002)(54906003)(36756003)(6506007)(66476007)(66556008)(5660300002)(6512007)(64756008)(66446008)(76116006)(122000001)(4326008)(71200400001)(86362001)(38100700002)(91956017)(66946007)(110136005)(2906002)(316002)(478600001)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?M0R0OFVySWZyQW43VjlORHFaRG5oUzlTUGxJQ1A2R242VDBuNGtKY2tBRWVv?=
 =?utf-8?B?TUlDQUQrU2g1M2FWUHlQZ2R3alRkY0pialBRQzBUUTFaUlVvclhpU1dENDB3?=
 =?utf-8?B?TUhPSmJtUXdtOUVIME1JbmNsdW1sSDhWeWV5UUgxV3JLQkpVWXZKeFFlcjFs?=
 =?utf-8?B?Z3V4eTBXbmpoQjUwMzRmSTR5blliajFobXdqRmhBYS9MNENVV1pJK2xPRXF0?=
 =?utf-8?B?L0FVdEVVQlNuNWNzUkxOVVNpMWUrQU5NeGVOTDJmM2YzRkt2Z0Z2SGtNaUZW?=
 =?utf-8?B?Y3NZUHJ4V1Era3JGckVqWlM5VTYrMDd1alJ1b2dhRVZQVHZUUjJGd01QUjkx?=
 =?utf-8?B?cmFsOWJuMnJmNnQ1QUVOMTcwWnZ2M0hqaWFHQkJFZ01rKzBGaXhFK0JSY2dw?=
 =?utf-8?B?bk1VSmUvcnNiR3lyNUkrRE43K09CZzM5dTNNenFsbW5UWTZOZ3I3T0lYTXhV?=
 =?utf-8?B?ZmVJOXdXN2tZNkdBOUlVRW9aL0RHM3puMGJBNXRDaVdBOTBEWWJQUnlPcUZn?=
 =?utf-8?B?MSt5Y0xFS3h1dkRMdnhsanM0ZFc4WmoxTUxkMW5KMHpqUkRJV2xFY0tuaUdi?=
 =?utf-8?B?SDRQMkprSjZMZUtkRHV5VkxyTUN6WjFHNjhZVDNwZDRtYXlIdGdJMU5VMTNn?=
 =?utf-8?B?MDk0cGt3VlJNYkZ5WFhkWTVMTFhUR0pDOUV1Tmd6cUgrK01IMWJzUjZSVnUw?=
 =?utf-8?B?d2JFZE9mV0NTdm04elR2YVlacmpZVVdTTndOQWJ5d3o2ZEQyM3Nxd3RRNUhl?=
 =?utf-8?B?eExmaUZBYmRGVFVYZ04vVnQ3MkhVaXlmR3MyMytPY01ocVFSemFQZzJpbmR3?=
 =?utf-8?B?TGlGUWM0aU8rNmM3RkNkcTZvM1FFWkUrM2VTWVlpTXNYa0c1OUlYVlRlb2Uw?=
 =?utf-8?B?WWxXZTFhRFJSR3U0SkxYSGp6L3ZqcEIxR1FaQzkwR0NuVnZxS21Fd3FOSE04?=
 =?utf-8?B?S1BHeER0Y3F0ZzlVQjV6RS92YW9aQ3NoZ1BWWW96YjdLZURtVlBlRTY3ZUQv?=
 =?utf-8?B?aUNKUnM3TmlIN3crSVljL01WQU5IQ0ZhTU1CV1VXWnc4bm1Ld3h5TW0vVUsv?=
 =?utf-8?B?cFM4VitnaWU5Tno1S1ZlbERkSnE3YnRiNTRMM0NmMUVBZkxwK21BRXBnUzZv?=
 =?utf-8?B?WUR5ZHVXTlNkTXRjMm9UT05oZnN1WFdjemFGRG1hSXlGY0NOaEs4ZDgwSHgz?=
 =?utf-8?B?dzBINDA0aGYydEhYNUZQcU5RbFYxdW0zUThOMjFNdTFZUTFzM1FxaGlzS25T?=
 =?utf-8?B?cGkxUTczS09KWjc3UnF4Z0xKTHQ3M29CVmVSS1JZWHZpc2tGWGU2QWp1SjVL?=
 =?utf-8?B?TFNOY3I0KzhZVFkrNHdNaUkvWFVOZTRTQjJBNFhEbWh1VDJncjFJb1JxZHIr?=
 =?utf-8?B?eDRRSHhWNzhENUNaNXlKOTMraS9saDM4NUN1NUFJUjcrVkQ4Y2hrempJKzEy?=
 =?utf-8?B?dk11N2NITnJNMFhjS3oxVU5LMFdSQ0RHckRrOW9mUGJ6NmJ4ZmJEMWRtQjIw?=
 =?utf-8?B?WWo5Rk81emRiVkt2ZmtzUk5hdm9IT3dqaHAramRtMU15Rm12Y0I0Ynk4c1Jy?=
 =?utf-8?B?SGVhTTFvNlIyS2hxc29La0V4a3puSzlPTXlUYk42UStsT2s1TXUzVytjNGRY?=
 =?utf-8?B?N0p5bnFlVHp6bGN1N1ZIL1lRbzZrTDRKMXBMZ0tPTjhqK29nWEtPN0VySHRj?=
 =?utf-8?B?cTY4Wkl2R1VmNFRqdXlBd1JVWU81eDZudUxJcjQ4VS94SVhCYWFpVjF0NzJ6?=
 =?utf-8?Q?D+E0F8+g22pFEmXAUGRPobiN5R11W3le/kaG3F9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1011A4D20207334892827128D4EDD383@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a653c93e-5278-49c5-c250-08d90f4660b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 21:48:39.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxuma/xIfY/by7azUu0CwaNSOf21Lr8ZutKwSjs1uSIw1X62Sw7Wz7FIPfP+L+odFE1gbhnQxloPuSXxp6wWUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4573
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTA0IGF0IDIyOjMyICswMTAwLCBEYWlyZSBCeXJuZSB3cm90ZToNCj4g
SGksDQo+IA0KPiBGb3Igd2hhdCBpdCdzIHdvcnRoLCBJIG1lbnRpb25lZCB0aGlzIG9uIHRoZSBh
c3NvY2lhdGVkIHJlZGhhdA0KPiBidWd6aWxsYSBidXQgSSdsbCByZXBsaWNhdGUgaXQgaGVyZSAt
IEkgKnRoaW5rKiB0aGlzIGlzc3VlIChidWxrDQo+IHJlYWRzL3dyaXRlcyBzdGFydmluZyBnZXRh
dHRycyBldGMpIGlzIG9uZSBvZiB0aGUgaXNzdWVzIEkgd2FzIHRyeWluZw0KPiB0byBkZXNjcmli
ZSBpbiBteSByZS1leHBvcnQgdGhyZWFkOg0KPiANCj4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGlu
dXgtbmZzJm09MTYwMDc3Nzg3OTAxOTg3Jnc9NA0KPiANCj4gTG9uZyBzdG9yeSBzaG9ydCwgd2hl
biB3ZSBoYXZlIGFscmVhZHkgcmVhZCBsb3RzIG9mIGRhdGEgaW50byBhDQo+IGNsaWVudCdzIHBh
Z2VjYWNoZSAob3IgZnNjYWNoZS9jYWNoZWZpbGVzKSwgeW91IGNhbid0IHJldXNlIGl0IGFnYWlu
DQo+IGxhdGVyIHVudGlsIHlvdSBkbyBzb21lIG1ldGFkYXRhIGxvb2t1cHMgdG8gcmUtdmFsaWRh
dGUuIEJ1dCBpZiB3ZQ0KPiBhcmUgYWxzbyBjb250aW51YWxseSBmaWxsaW5nIHRoZSBjbGllbnQg
Y2FjaGUgd2l0aCBuZXcgZGF0YSAobG90cyBvZg0KPiByZWFkcykgYXMgZmFzdCBhcyBwb3NzaWJs
ZSwgd2Ugc3RhcnZlIHRoZSBvdGhlciBwcm9jZXNzZXMgKGluIG15IGNhc2UNCj4gLSBrbmZzZCBy
ZS1leHBvcnQgdGhyZWFkcykgZnJvbSBwcm9jZXNzaW5nIHRoZSByZS12YWxpZGF0ZQ0KPiBsb29r
dXBzL2dldGF0dHJzIGluIGEgdGltZWx5IG1hbm5lci4NCj4gDQo+IFdlIGhhdmUgbG90cyBvZiBw
cmV2aW91c2x5IGNhY2hlZCBkYXRhIGJ1dCB3ZSBjYW4ndCB1c2UgaXQgZm9yIGEgbG9uZw0KPiB0
aW1lIGJlY2F1c2Ugd2UgY2FuJ3QgZ2V0IHRoZSBnZXRhdHRycyBvdXQgYW5kIHJlcGxpZWQgdG8g
cXVpY2tseS4NCj4gDQo+IFdoZW4gSSB3YXMgdGVzdGluZyB0aGUgY2xpZW50IGJlaGF2aW91ciwg
aXQgZGlkbid0IHNlZW0gbGlrZSBuY29ubmVjdA0KPiBvciBORlN2My9ORlN2NC4yIG1hZGUgbXVj
aCBkaWZmZXJlbmNlIHRvIHRoZSBiZWhhdmlvdXIgLSBtZXRhZGF0YQ0KPiBsb29rdXBzIGZyb20g
YW5vdGhlciBjbGllbnQgcHJvY2VzcyB0byB0aGUgc2FtZSBtb3VudHBvaW50IHNsb3dlZCB0bw0K
PiBhIGNyYXdsIHdoZW4gYSBwcm9jZXNzIGhhZCByZWFkcyBkb21pbmF0aW5nIHRoZSBuZXR3b3Jr
IHBpcGUuDQo+IA0KPiBJIGFsc28gZm91bmQgdGhhdCBtYXhpbmcgb3V0IHRoZSBjbGllbnQncyBu
ZXR3b3JrIGJhbmR3aWR0aCByZWFsbHkNCj4gc2hvd2VkIHRoaXMgZWZmZWN0IGJlc3QuIEVpdGhl
ciBieSBzYXR1cmF0aW5nIGEgY2xpZW50J3MgcGh5c2ljYWwNCj4gbmV0d29yayBsaW5rIG9yLCBp
biB0aGUgY2FzZSBvZiByZWFkcywgdXNpbmcgYW4gaW5ncmVzcyBxZGlzYyArIGh0Yg0KPiBvbiB0
aGUgY2xpZW50IHRvIHNpbXVsYXRlIGEgc2F0dXJhdGVkIGxvdyBzcGVlZCBuZXR3b3JrLg0KPiAN
Cj4gSW4gYWxsIGNhc2VzIHdoZXJlIHRoZSBjbGllbnQncyBuZXR3b3JrIGlzIChyZWFkKSBzYXR1
cmF0ZWQNCj4gKHBoeXNpY2FsbHkgb3IgdXNpbmcgYSBxZGlzYyksIHRoZSBtZXRhZGF0YSBwZXJm
b3JtYW5jZSBmcm9tIGFub3RoZXINCj4gcHJvY2VzcyBiZWNvbWVzIHJlYWxseSBwb29yLiBJZiBJ
IG1vdW50IGEgY29tcGxldGVseSBkaWZmZXJlbnQgc2VydmVyDQo+IG9uIHRoZSBzYW1lIGNsaWVu
dCwgdGhlIG1ldGFkYXRhIHBlcmZvcm1hbmNlIHRvIHRoYXQgbmV3IHNlY29uZA0KPiBzZXJ2ZXIg
aXMgbXVjaCBiZXR0ZXIgZGVzcGl0ZSB0aGUgb25nb2luZyBuZXR3b3JrIHNhdHVyYXRpb24gY2F1
c2VkDQo+IGJ5IHRoZSBjb250aW51aW5nIHJlYWRzIGZyb20gdGhlIGZpcnN0IHNlcnZlci4NCj4g
DQo+IEkgZG9uJ3Qga25vdyBpZiB0aGF0IGhlbHBzIG11Y2gsIGJ1dCBpdCB3YXMgbXkgb2JzZXJ2
YXRpb24gd2hlbiBJDQo+IGxhc3QgbG9va2VkIGF0IHRoaXMuDQo+IA0KPiBJJ2QgcmVhbGx5IGxv
dmUgdG8gc2VlIGFueSBraW5kIG9mIGltcHJvdmVtZW50IHRvIHRoaXMgYmVoYXZpb3VyIGFzDQo+
IGl0J3MgYSByZWFsIHNoYW1lIHdlIGNhbid0IHNlcnZlIGNhY2hlZCBkYXRhIHF1aWNrbHkgd2hl
biBhbGwgdGhlDQo+IGNhY2hlIHJlLXZhbGlkYXRpb25zIChnZXRhdHRycykgYXJlIHN0dWNrIGJl
aGluZCBidWxrIElPIHRoYXQganVzdA0KPiBzZWVtcyB0byBwbG93IHRocm91Z2ggZXZlcnl0aGlu
ZyBlbHNlLg0KDQpJZiB5b3UgdXNlIHN0YXR4KCkgaW5zdGVhZCBvZiB0aGUgcmVndWxhciBzdGF0
IGNhbGwsIGFuZCB5b3UNCnNwZWNpZmljYWxseSBkb24ndCByZXF1ZXN0IHRoZSBjdGltZSBhbmQg
bXRpbWUsIHRoZW4gdGhlIGN1cnJlbnQga2VybmVsDQpzaG91bGQgc2tpcCB0aGUgd3JpdGViYWNr
Lg0KDQpPdGhlcndpc2UsIHlvdSdyZSBnb2luZyB0byBoYXZlIHRvIHdhaXQgZm9yIHRoZSBORlN2
NC4yIHByb3RvY29sDQpjaGFuZ2VzIHRoYXQgd2UncmUgdHJ5aW5nIHRvIHB1c2ggdGhyb3VnaCB0
aGUgSUVURiB0byBhbGxvdyB0aGUgY2xpZW50DQp0byBiZSBhdXRob3JpdGF0aXZlIGZvciB0aGUg
Y3RpbWUvbXRpbWUgd2hlbiBpdCBob2xkcyBhIHdyaXRlDQpkZWxlZ2F0aW9uLg0KPiA+IA0KDQoN
Ci0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1l
cnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
