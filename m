Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2237149C241
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jan 2022 04:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiAZDpq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 22:45:46 -0500
Received: from mail-dm6nam11on2122.outbound.protection.outlook.com ([40.107.223.122]:19968
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237261AbiAZDpq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 25 Jan 2022 22:45:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5JtvWggKukEHo7XcRiqgbIfJRvkzkkf9afDRdSlBGb6y4D1zYgV8XeO8fmWhbQENWRj5IpPv3G53DYgK8vd9j20iHeLPURDP3V7Y1uB0kWcXT29pi/lcG3hdYOe2vSYCzqCybRDcFZaC/udSP/WgmK+M7vv6YNLd0TRcKASRQfi+3kgaeS6DC2OkHgN4WdFwnxUavOzu884FAlQFslgT8LSQkEC7CPvpRpciOWD/2W0n8VWkPqaaF6X4o2Ta0cfQv4xEDXV7FoyHjiSPojEz2cnnB1gd+B1iohj4pHsnFL2POdZGDp0xYC/8vAHh057kO85+Srl4WLDDinGFYTGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m57TqYpoZiDAnZxNnsbGptCSXM0/sgNKJkUtc4ZvEc=;
 b=CT1a2u5Gvz5wjrNxASZhB3iPGGeMJ6rKCOwbHY79UEkOi9hNw1GzSXCeIOiO7wIq5aLJxJfu3f6IsorLWRjsWTMSg2nimKftcgNJnH5HR44Plx3qUL6om7mmovNGZLBrK5v8itLFi8NR5NHlLUNiKJCWZut0AG0j1Wt6qicsUgB0P/uswVIOiU9TqeCYnAu1uEbEMyFvxWW3PHnCP15eOjs0WAVmB6aey+FqgsfiLOLf9oyaFSN4mZR/EJmDp0vr1oQxIrr1BqJHen8YmWt2D48lwF++uIHObshnfd1Omad8GFEY+Kq/ynXL7GKcsnrGsp7BPXaD5Dv4mZdONgBU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m57TqYpoZiDAnZxNnsbGptCSXM0/sgNKJkUtc4ZvEc=;
 b=GCoYFUQ5ucJgyTLV2pLW4b7/cWBcoltHxMd7swEf6JCY/EYkf1sYy82xvOg0sYBFsZUvRYSmGEPrejbJttl+mc4CBSJ2BI1i2MOJ26PYlDgI1aHT8f8sEo+WMovH0NyBGV8qhVPLe5XQuHy1cLQO6zkV8XogpZ/q/Ayu9hJXpq4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN0PR13MB5197.namprd13.prod.outlook.com (2603:10b6:408:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4; Wed, 26 Jan
 2022 03:45:42 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%5]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 03:45:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "mgorman@suse.de" <mgorman@suse.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 22/23] NFS: swap-out must always use STABLE writes.
Thread-Topic: [PATCH 22/23] NFS: swap-out must always use STABLE writes.
Thread-Index: AQHYENY5ChNfoMKWqESrgjj9Rq8wwax0rLMA
Date:   Wed, 26 Jan 2022 03:45:42 +0000
Message-ID: <e50bf6286a89d60ee0879e55a30b15d84e97d9a4.camel@hammerspace.com>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
         <164299611287.26253.13462969110743208198.stgit@noble.brown>
In-Reply-To: <164299611287.26253.13462969110743208198.stgit@noble.brown>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 324488c5-22fd-4f74-5e8e-08d9e07e53ad
x-ms-traffictypediagnostic: BN0PR13MB5197:EE_
x-microsoft-antispam-prvs: <BN0PR13MB51970896D85B46B55D53492EB8209@BN0PR13MB5197.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJUY/y2NUyHd0euBSp4VEdLK2/mgG+zKvGk3RNtoC+O8vjR74FaPJhdhvEKjdE60hkTvLuLbqrLUpvTnRemRmcDSQj9XsHKvNlb4ss0EItZYHvJNCl9aQwQDidgCdenROFzG3CHbn3miEZDCfwvgi9sK901X//MH5CyG1P1wHyjTQCUl2VnPs4IucPadjp/1GgCxbSxhEGXyPsdeYlw+bWs7409W+mxDfR1bjCRBs9tF7BVn20gt8b565cQTi0IhxdVtpdhvN29UL3UNW8YLigHasmxnhJceRz8/YHHJPl0wNN3u7kQ8lrq83BFTmTgNgnYb3O5vuBwpyysRO7J/bvIANEHuLbvXqFEtIUxbv/C4Vvkc1P0T++ZsBenHiuKyzsuWt6dvg0+QOIVQTf2yqxlyqxoNExWxyvn1Kxn1NkqJmAoKd3UhEmQnaDBKU7Lr0cQMs3GV5Myq8xLDuWppNd1AEpwz2Tqqbxx7E78y4KXBBHIZj4WPx0heJ8IIxQC/wcMybrjjmbQwyS76jzvQ+acyUxrAzGp8PO+IchaHF9JryFSCw1ks2Oe1EiMw2xp6gJGSlrOsLuc3I48QWIyZUrga7Rc1lLj2HAmLl3g0lXNXizRjG1e9aNBitDPQzMrGI3HmAfTdiacuFff9PJYMZV0v4igx/cGAzf+AYltTZqVmy63lKbcr5dl3Y3uI049fzo1aOLeVZWUQPNGc71LGpnpIkDvlUlA+cS4KnnOff7cKnUXR6xI04nlpOswTQCAi3T1rHi09FkIGQH6B3NoA2Jb8PUAg1DUCVliEjuis+Gs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(39850400004)(366004)(136003)(396003)(186003)(26005)(15974865002)(2616005)(122000001)(6486002)(86362001)(2906002)(38100700002)(508600001)(5660300002)(6512007)(66476007)(8676002)(66446008)(64756008)(71200400001)(4326008)(38070700005)(66556008)(8936002)(316002)(66946007)(76116006)(36756003)(7416002)(6506007)(54906003)(83380400001)(110136005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NoYzRSSElMN1FGempUazcvdTFtWXk3ZXhDeWtWdFVMbnJXcXVsd2hlQlZP?=
 =?utf-8?B?Z1FoUW5WV1ExMFlhamtQdG10QUZEcUNRakhycXQ4RFhZK2g0aDhldUppNHc2?=
 =?utf-8?B?OGtUUzRocXVHeEUzWnN2S2NQRDc4NlRVdVRjT1I1Vng0L0x2ZzF3d1RKRjVW?=
 =?utf-8?B?VDBYbzlXUk5Ucm42NS9Ec2s2ZldyYUdxQWFSaVd6YnNTZjFVUXEvMVUwMXVm?=
 =?utf-8?B?Z1dTOG5RajFFK1dRTlhYWTU2S0xDQk5XUllCc1I4bUxBRFRsbzFVL1oza256?=
 =?utf-8?B?ZTQwUWljK0Z6TzZBN01KdU9NTDEraVdHN3hKSzFuejZlQTFjaVRRNEVjejBI?=
 =?utf-8?B?V3Fpb2d5U3UrUkMyanRtVHdJSjNqRnp6TDhkZ0IyZnVKTWdjbGdsSk5FQ0R3?=
 =?utf-8?B?SHFxdzZtWmFqOXpOMXBkTDNRaTlueU5nY2Z0Mlg1c2RjUk16VTlUb2N0QWxQ?=
 =?utf-8?B?cHZaK2ltRlV1NHVwRTJQSzc1RUNsNVluS1pJdnNCQmROM1dnbndkVkRMWlVa?=
 =?utf-8?B?RkR0YjlBM2E0NHhtalgxU2VpNGR6V2I5aXFpVnh3MXg0TXkvQUMrNkVEUHU0?=
 =?utf-8?B?Z3ZaTmJEUnRTRlUwTUFSSmpnMURYMFg0QjM2bEM1T2JPK3cwYXNHb3dmamZo?=
 =?utf-8?B?eUdldGtvdFNxV2tKVWg1cVdCczFWSmJtRDg0TC9xOVJ6VVdaM0hmWHJhMENi?=
 =?utf-8?B?VlptQUhEd1prbEV3MzA0MTJZR2MrMW1wRlpLTjNPampwREhJcUM3RFhRNHVS?=
 =?utf-8?B?UENTZUJxc3FJTGhPNFMwWUFoUlJRUTEwdENyZzlGM1pMMCtObXpuTjhCcGU3?=
 =?utf-8?B?ZjRSVm1JdlhaVlVYYndocHVHQ1Bob2F2eWZlcS9qY2toSUhWMUxWUm1FWDVE?=
 =?utf-8?B?Rnd4RmNLWlF3a1dnM2RPMm5ueDhxcDUrZUU2R0xYQTNZVmV4dkpBcHR0eXkz?=
 =?utf-8?B?TFpTTzdEVWkzbU45RmU5T2lXcFNaSkhMNmFLV0FJR3F4eGdBYjRXSzd3azBO?=
 =?utf-8?B?V0tsMGJMRitES2VvSVVNZ2ZnMjFaZTM0RlpFZ0g5bFpidG5yR2J5aXNkNUxY?=
 =?utf-8?B?SEFMSkhYTXJNQjYzK3pJelhaU09Mc2ZsZS81bFV4SXZ1VnpMeUV1aHpWSlZQ?=
 =?utf-8?B?MnJEbG1BVHlsT2xuNzZXRWRQZ0U0SE1CelJsQ01PVis2Qm5wenVQYzBoUkxV?=
 =?utf-8?B?M294ZFE3SlhQOTNiRWkwYTRuMTFlZG1valN4WnR3Ly81dm80MVVGV0tna2tX?=
 =?utf-8?B?TnZuUUZYRTJXUmpGcjhoMzh3eWUvY0JVamxyMG1qcVJka0F6ZmdUcnplMjI2?=
 =?utf-8?B?b3ZqckVHNWx6TldRMjVlSjIxdzd5ZkxjWHE4MkYyWHoxZWFZWXZUeTlXKzhi?=
 =?utf-8?B?cVJUclFVOG45R2tLelBjSEI3bmFET3huRGwzZDdOOTFMdWJoOVZZbXZHUXlk?=
 =?utf-8?B?ZGN6Ymx5T0JBTmxUYURRcmFXSHNqdklBWDF3VjJjRkxUL00rL3ROVmUyZ0hX?=
 =?utf-8?B?OVQzdzg0OUFlZ3FzUDE5SlVZSlJFNW1MWEtOK3BBeE9adDZvU21WV2JLVzBy?=
 =?utf-8?B?dXFmcElTWGJPUW9FZ3JMT0lhM3BnREtrN3ppdnM5TFZ1bG5ZMmY4azUxZm1J?=
 =?utf-8?B?bHhvdmpqcHFNalJzVTRhMUEwbDdRTWVNSlhVb255alBiRlA5WGh0eU1BSjlN?=
 =?utf-8?B?QU53MUt6MUJHTmdNNTFtQ0lWRTU4WWVkcXFzeGdJWSsrMDV1NkVxamErOExO?=
 =?utf-8?B?czlrWTRIV09PZmY4RkJzcENiOGFKaTFJbUk1U3d3K1JYWG5lOTMrNGVXOVcz?=
 =?utf-8?B?azk2TGk4NHdwUTdNRUp6aVpCL1dmOVNPcHhwdTNNa3R5Ui9JeWVSQUViZlpo?=
 =?utf-8?B?TWJhKzNGcjZRdEZYYm43SVRhZ25RdmllWnZTQVp3WksvaEcrRjhJelZKb2Ra?=
 =?utf-8?B?ZkZFVzl5WGN3TnRaTTdCOVZkc1lCajNHWE5rODZDZURiVGR5MG9NMlVuSW5t?=
 =?utf-8?B?dXgvc1lGcmZPUFJ1bmtQR3hhcW8ybCtVY05lNm5qeGU1V2xlQkViaWhyU2pL?=
 =?utf-8?B?a21wOEtXQ0tjZ0RsNlhDd3diTGc0UzMwcWhPZmxmN2JJK2F2VjRkMS9wS284?=
 =?utf-8?B?MzdGcnRSRGd6b3NwZG1DQzc2RlNqa2x3SnE1ZGFQekcvdWdJM0pHRG10VUY1?=
 =?utf-8?Q?7C2pG2GBeWuYKI/0NsWYJBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3E26FB9D15E7B4688BAE2F5845F1798@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324488c5-22fd-4f74-5e8e-08d9e07e53ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 03:45:42.3226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWpXvAbHBIqXiKE7AFP+tmFl6zIgKnqOI1vjg/PTz/0JYGuDLh6frIgQVnFJgrK0luVPI0luZrVvKB4tQCQBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB5197
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTI0IGF0IDE0OjQ4ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gVGhl
IGNvbW1pdCBoYW5kbGluZyBjb2RlIGlzIG5vdCBzYWZlIGFnYWluc3QgbWVtb3J5LXByZXNzdXJl
Cj4gZGVhZGxvY2tzCj4gd2hlbiB3cml0aW5nIHRvIHN3YXAuwqAgSW4gcGFydGljdWxhciwgbmZz
X2NvbW1pdGRhdGFfYWxsb2MoKSBibG9ja3MKPiBpbmRlZmluaXRlbHkgd2FpdGluZyBmb3IgbWVt
b3J5LCBhbmQgdGhpcyBjYW4gY29uc3VtZSBhbGwgYXZhaWxhYmxlCj4gd29ya3F1ZXVlIHRocmVh
ZHMuCj4gCj4gc3dhcC1vdXQgbW9zdCBsaWtlbHkgdXNlcyBTVEFCTEUgd3JpdGVzIGFueXdheSBh
cyBDT05EX1NUQUJMRQo+IGluZGljYXRlcwo+IHRoYXQgYSBzdGFibGUgd3JpdGUgc2hvdWxkIGJl
IHVzZWQgaWYgdGhlIHdyaXRlIGZpdHMgaW4gYSBzaW5nbGUKPiByZXF1ZXN0LCBhbmQgaXQgbm9y
bWFsbHkgZG9lcy7CoCBIb3dldmVyIGlmIHdlIGV2ZXIgc3dhcCB3aXRoIGEgc21hbGwKPiB3c2l6
ZSwgb3IgZ2F0aGVyIHVudXN1YWxseSBsYXJnZSBudW1iZXJzIG9mIHBhZ2VzIGZvciBhIHNpbmds
ZSB3cml0ZSwKPiB0aGlzIG1pZ2h0IGNoYW5nZS4KPiAKPiBGb3Igc2FmZXR5LCBtYWtlIGl0IGV4
cGxpY2l0IGluIHRoZSBjb2RlIHRoYXQgZGlyZWN0IHdyaXRlcyB1c2VkIGZvcgo+IHN3YXAKPiBt
dXN0IGFsd2F5cyB1c2UgRkxVU0hfQ09ORF9TVEFCTEUuCgpPSy4gWW91ciBleHBsYW5hdGlvbiBh
Ym92ZSBoYXMgbWUgZXh0cmVtZWx5IGNvbmZ1c2VkLgoKSWYgeW91IHdhbnQgdG8gYXZvaWQgY29t
bWl0LCB0aGVuIHlvdSBzaG91bGQgYmUgdXNpbmcgRkxVU0hfU1RBQkxFLApzaW5jZSB0aGF0IGZv
cmNlcyB0aGUgd3JpdGVzIHRvIGJlIHN5bmNocm9ub3VzLiBGTFVTSF9DT05EX1NUQUJMRSBjYW4K
YW5kIHdpbGwgdXNlIHVuc3RhYmxlIHdyaXRlcyBpZiBpdCBzZWVzIHRoYXQgdGhlcmUgYXJlIG1v
cmUgd3JpdGVzIHRvCmNvbWUuCgo+IAo+IFNpZ25lZC1vZmYtYnk6IE5laWxCcm93biA8bmVpbGJA
c3VzZS5kZT4KPiAtLS0KPiDCoGZzL25mcy9kaXJlY3QuYyB8wqDCoMKgIDcgKysrKy0tLQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvZnMvbmZzL2RpcmVjdC5jIGIvZnMvbmZzL2RpcmVjdC5jCj4gaW5kZXggNDNhOTU2
ZDdmZDYyLi4yOWMwMDdiMmExN2EgMTAwNjQ0Cj4gLS0tIGEvZnMvbmZzL2RpcmVjdC5jCj4gKysr
IGIvZnMvbmZzL2RpcmVjdC5jCj4gQEAgLTc5MSw3ICs3OTEsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG5mc19wZ2lvX2NvbXBsZXRpb25fb3BzCj4gbmZzX2RpcmVjdF93cml0ZV9jb21wbGV0aW9u
X29wcyA9IHsKPiDCoCAqLwo+IMKgc3RhdGljIHNzaXplX3QgbmZzX2RpcmVjdF93cml0ZV9zY2hl
ZHVsZV9pb3ZlYyhzdHJ1Y3QgbmZzX2RpcmVjdF9yZXEKPiAqZHJlcSwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2ZmX3QgcG9zKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbG9mZl90IHBvcywgaW50Cj4gaW9mbGFncykKPiDCoHsKPiDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IG5mc19wYWdlaW9fZGVzY3JpcHRvciBkZXNjOwo+IMKgwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZHJlcS0+aW5vZGU7Cj4gQEAgLTc5OSw3ICs3
OTksNyBAQCBzdGF0aWMgc3NpemVfdAo+IG5mc19kaXJlY3Rfd3JpdGVfc2NoZWR1bGVfaW92ZWMo
c3RydWN0IG5mc19kaXJlY3RfcmVxICpkcmVxLAo+IMKgwqDCoMKgwqDCoMKgwqBzaXplX3QgcmVx
dWVzdGVkX2J5dGVzID0gMDsKPiDCoMKgwqDCoMKgwqDCoMKgc2l6ZV90IHdzaXplID0gbWF4X3Qo
c2l6ZV90LCBORlNfU0VSVkVSKGlub2RlKS0+d3NpemUsCj4gUEFHRV9TSVpFKTsKPiDCoAo+IC3C
oMKgwqDCoMKgwqDCoG5mc19wYWdlaW9faW5pdF93cml0ZSgmZGVzYywgaW5vZGUsIEZMVVNIX0NP
TkRfU1RBQkxFLCBmYWxzZSwKPiArwqDCoMKgwqDCoMKgwqBuZnNfcGFnZWlvX2luaXRfd3JpdGUo
JmRlc2MsIGlub2RlLCBpb2ZsYWdzLCBmYWxzZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZuZnNfZGlyZWN0X3dyaXRlX2NvbXBs
ZXRpb25fb3BzKTsKPiDCoMKgwqDCoMKgwqDCoMKgZGVzYy5wZ19kcmVxID0gZHJlcTsKPiDCoMKg
wqDCoMKgwqDCoMKgZ2V0X2RyZXEoZHJlcSk7Cj4gQEAgLTkwNSw2ICs5MDUsNyBAQCBzc2l6ZV90
IG5mc19maWxlX2RpcmVjdF93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsCj4gc3RydWN0IGlvdl9p
dGVyICppdGVyLAo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmZzX2RpcmVjdF9yZXEgKmRyZXE7
Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZnNfbG9ja19jb250ZXh0ICpsX2N0eDsKPiDCoMKg
wqDCoMKgwqDCoMKgbG9mZl90IHBvcywgZW5kOwo+ICvCoMKgwqDCoMKgwqDCoGludCBpb2ZsYWdz
ID0gc3dhcCA/IEZMVVNIX0NPTkRfU1RBQkxFIDogRkxVU0hfU1RBQkxFOwoKVGhpcyBpcyBhbiB1
bmFjY2VwdGFibGUgY2hhbmdlIGluIGJlaGF2aW91ciBmb3IgdGhlIG5vbi1zd2FwIGNhc2UsIHNv
Ck5BQ0suCgo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGRmcHJpbnRrKEZJTEUsICJORlM6IGRpcmVj
dCB3cml0ZSglcEQyLCAlemRAJUxkKVxuIiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGZpbGUsIGlvdl9pdGVyX2NvdW50KGl0ZXIpLCAobG9uZyBsb25nKSBpb2NiLQo+ID5raV9w
b3MpOwo+IEBAIC05NDcsNyArOTQ4LDcgQEAgc3NpemVfdCBuZnNfZmlsZV9kaXJlY3Rfd3JpdGUo
c3RydWN0IGtpb2NiICppb2NiLAo+IHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKPiDCoMKgwqDCoMKg
wqDCoMKgaWYgKCFzd2FwKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzX3N0
YXJ0X2lvX2RpcmVjdChpbm9kZSk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqByZXF1ZXN0ZWQgPSBu
ZnNfZGlyZWN0X3dyaXRlX3NjaGVkdWxlX2lvdmVjKGRyZXEsIGl0ZXIsIHBvcyk7Cj4gK8KgwqDC
oMKgwqDCoMKgcmVxdWVzdGVkID0gbmZzX2RpcmVjdF93cml0ZV9zY2hlZHVsZV9pb3ZlYyhkcmVx
LCBpdGVyLCBwb3MsCj4gaW9mbGFncyk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKG1hcHBp
bmctPm5ycGFnZXMpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludmFsaWRh
dGVfaW5vZGVfcGFnZXMyX3JhbmdlKG1hcHBpbmcsCj4gCj4gCgotLSAKVHJvbmQgTXlrbGVidXN0
CkNUTywgSGFtbWVyc3BhY2UgSW5jCjQ5ODQgRWwgQ2FtaW5vIFJlYWwsIFN1aXRlIDIwOApMb3Mg
QWx0b3MsIENBIDk0MDIyCuKAiwp3d3cuaGFtbWVyLnNwYWNlCgo=
