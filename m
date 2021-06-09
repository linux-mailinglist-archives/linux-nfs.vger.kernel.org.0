Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF673A0CB1
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Jun 2021 08:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhFIGsr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Jun 2021 02:48:47 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:36577
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233490AbhFIGsl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Jun 2021 02:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcRDEmrwaBXQhTSTYrK4UB5B2QAggAm9GoYCnYyMBFVSxu5qSPRhQ2NR9/D+aD9buoPRo98FtsQT48ukwoKH9IDdlmoECPq7ouiLnpzmzft7CKwPBerscqpjK1T/qDaQbiWOnLj+MgtTYVrGWL/67PSBgn6kCANIwOIbDpR3yO7e5WmHyGbCsJG5QbkqNe/WRUuFsjkDzJNnHRfDHkZfzTZbfufJUw/gY1gXkfY00Z/bQCeHLQ5tO2Du9Bi8dv6xEI9wLY7g+p33+3Uz2bEqEg8if+wmXcdOvn7Fg5RgSSOIk082L33SdQegRMwdoFxyO8/u0zql2ifbYMsCZDO6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPXRGYbUQY4ovzuQqcEzjWLpMTL0+XgTRAM9qNwPJDI=;
 b=F9eklbl63E8d6b9xUL42Hg7+XRbQrLR3LmF5/Bop/tH6TzBdq6IAhfKa5SE090cF5mEmA4RxehOqOEGYDrBn4A4awxRQvgiTOhhP3tMx0vtB+LHWT1w3PS13EAWRM/MCQMGSKqHcLiOZqvTmxSpkgMF32o5yA8KbAGNE/3YoCB7UKwO5va+ZM1jAZU8v9DDdHq/BCpJee9YQ8P07juS8v2deuNwa3h7n5aV/2ouCgalmDotA1ZQXQ4S+j5A33Z5r6Fit4aEPgzeV+yAGUF8/P0AOWkj3LABqKsqzyCEb0PDMwoYMDzWFGWa4BiNswN4wazgjDovh7IFcrxbv6aRNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPXRGYbUQY4ovzuQqcEzjWLpMTL0+XgTRAM9qNwPJDI=;
 b=QM0a9kqNfQYqiPnvN2wt324xh+OSTVPnk08P/Ctlrv3G2fgr37ZdqkXK+CUHuGxgVmtSe0jQF/jyuEp7YDz/RDuLtjKmN3E/hGqktsCONVFDGhp677GGu8cdJ3i3GzCbNBlYCcYrCdBTIhCFnIU+/OVrOY3wuYP45bYArar5vfU=
Received: from CO1PR05MB7925.namprd05.prod.outlook.com (2603:10b6:303:f1::22)
 by CO6PR05MB7619.namprd05.prod.outlook.com (2603:10b6:5:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Wed, 9 Jun
 2021 06:46:46 +0000
Received: from CO1PR05MB7925.namprd05.prod.outlook.com
 ([fe80::5d82:70cd:f77c:d9a9]) by CO1PR05MB7925.namprd05.prod.outlook.com
 ([fe80::5d82:70cd:f77c:d9a9%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 06:46:45 +0000
From:   Alex Romanenko <alex@vmware.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Michael Wakabayashi <mwakabayashi@vmware.com>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: RE: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Topic: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
Thread-Index: AQHXSrzxNwU+/2izAUaNQrMQbCMgXKrrMRoAgAGJKICAAZPoloAADT6AgAAH7wqAABF6AIAAETsAgAAJXACAG0yW/4AAkD6AgADyf0A=
Date:   Wed, 9 Jun 2021 06:46:45 +0000
Message-ID: <CO1PR05MB792588AF847096C601A215DCBF369@CO1PR05MB7925.namprd05.prod.outlook.com>
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com>
 <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com>
 <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
In-Reply-To: <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b6ae572-aef1-4f62-00ec-08d92b125973
x-ms-traffictypediagnostic: CO6PR05MB7619:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR05MB7619C561503E4CBBC1D84B72BF369@CO6PR05MB7619.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +lEbpl51ls9WSY03OCOsmSbnxw7NJ0qh+fI0Y1pl6yrrX37nPKV/5c01K7388oKvf5H2tBG9QDaPp4FUIsPZ+rRTrvB6VEVTTiFuHtVVQKIEUlqSpMAzbmecVPTSuEmDIJ9swWrF1CvO7EGTnhtJv2u+vCRp+ymCSObEdMzSZM54n2PH9+RVjgFqeXu6g7LgPn6CJkAL6qpn6hhpRlZA0kEg/ck6XIqtG2MfoHtKIASqy2rgqbTbPrw4IXivaHbui1nP7cpBsEcLqhYB8ZgwoRtqd5uVGQgsAp/0IZGCss+UBkxH2wF+9xd+T9ywJhhvYg8Sm2TCnrsNjED6tDP9hFmQQRJY9hIqiwpS7o3JpNYcgVbbgZI2RZzZDISRXR3kho10dkC7VyYLMWL+heWrwp2+HPgLLpL+vnXdoY7avT14UuNNjq2oPWjP74NiHw/TG6OGi223y2IhmL1s4MYI578u+n/aHv7TbIdeWqb6faocE/WW/vh48qYvBLE+1TohQkmzIVVvCAtOIdzCIer7VO7C4xyMfp7ge1LnIXgcZyl7PEX2vRdeUY7X/u89diit/ATSxEHDNP1VEZbSC1l6w0oj4UHc2ULs5ZOPJ6Lt+SQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR05MB7925.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(122000001)(52536014)(71200400001)(478600001)(66556008)(76116006)(66946007)(8936002)(8676002)(66446008)(5660300002)(66476007)(38100700002)(83380400001)(64756008)(4744005)(4326008)(54906003)(2906002)(316002)(6506007)(9686003)(55016002)(110136005)(186003)(86362001)(26005)(33656002)(7696005)(6636002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWJublhVVFBYU3d0RWtEVlJyTUVmVG84SnlDLzh6a050N3U3eVAxSmRjY1o3?=
 =?utf-8?B?MS9QUEdDOXV1aEJjZVdaZUdKSnlRS21nVGx2ZGRaV2xJUEpvYVIzWjZYZHdU?=
 =?utf-8?B?OEN3Ynd4dlMzeG5mY2ViK1B5emdFZE1UMmRvYzBvOEIwSE9HcUpraGs3Q3VN?=
 =?utf-8?B?K0Q5WTNTc3JKeC9lWWEyVnc1S0x4VTVRVVJKU3ZSaHBTSFVWSkxGZmp2K0hY?=
 =?utf-8?B?UGc4REYyalFjWlFXNWNDdmpvblJ2Y1hDaFowQUd4M2tKZFpabnRlNzVWbVkx?=
 =?utf-8?B?Qm50QThlSE43YnB0K0t3d09kbFlOU1Fjb2lMREpRTEFWN0lhcDMxdjF4WFUx?=
 =?utf-8?B?MGFTWmdNZTBiNnpHQTF0S3V3OW0zcDVEN2hOTFQ1WFNiRkVwYmZPOHJnRHB6?=
 =?utf-8?B?V0tRdUNPWklUM0o3bHRCYXV4WkRIN3psUTRkL3NrbzArWTE4UVQ1dXkyZ3h5?=
 =?utf-8?B?WEpNc1VneUxHMVZseWxLMzYrdFh3RzVvK3dtUXNtVlZLU2xabk11dkJZekZ3?=
 =?utf-8?B?Z0d6U1FqZWVKVTh2WHNyZVYxQ0liMDhiUkV1dE4ycmZRRGhzWE5kYm5iU1BT?=
 =?utf-8?B?ZTFFb3FSd0xWY0ZHZEt4d1BlZzQxejVDSndmRWZxdVcrMkhSY0paR0F4UXV3?=
 =?utf-8?B?Y3hrWG5mb1hMTG9HdFhPeURaQjJtZHgyQUgxSjFET2YvQzM1RjB3citLRHEz?=
 =?utf-8?B?VGEvemN3Q2hMWVJBRTllVElxaTRlUmNuNGxJK2pRK3NualB0bDRFMFFSbm9D?=
 =?utf-8?B?REJQQXVzc0tCVEVDM0xUeXU4eldESmdybnVuRUdERDhTazVxTmJuSFZQclNs?=
 =?utf-8?B?RW43aDRiZG9QUno0V2RIS0lCZnI4QlVxRitYeG16UGJ6bXM1cjFhUVB3OCtr?=
 =?utf-8?B?Mm5KWFZpMHl2Si9wVnpMWW1SR0I2UTJGZHJzd25PNXJQT2U1VEUvcElKdHg3?=
 =?utf-8?B?MDRBeHBucjMvR2hDbmp4M01ZUnZZRDVwQWFmbnVyckJ0VmtGd3U0LzdBWkpV?=
 =?utf-8?B?ZUwxbnNkK2s0eWxzbVhNZHczamY0Q2x2NmpvVmNwdzlzZjRrZ2RydlNpNHJ3?=
 =?utf-8?B?SXhOR2J4QlhjNEVIaGdKclllci9nYzVIVDJTdzJvNjFHaWo4cFRKaVU1SEIy?=
 =?utf-8?B?SHZORHZad3BTKy9rK2pvT1Z5Q3lmMkorWUUybE9mWVA2UTVkYllva0FKYy8v?=
 =?utf-8?B?ZXpoaDlPUURxeDBkWHl1c3pwaERheUUwTXhiT2M3TzNkZ0hLKzVta2lhbDJN?=
 =?utf-8?B?YmRXcjBFOUUybHpOL1lodXpzd05wY2F2YVQ4N2c1UUgxWmRiQnd3KzV6TWVJ?=
 =?utf-8?B?TjkwVm80bGNFMk9EYmpDRHc4M3RVS0srM20weitlcFZsSEk1QW8xU2JDY1pj?=
 =?utf-8?B?dTAxcDhpV3dCSnFjMXBWNFJCbjQwVEFuYmlwb2xhWGp5ZlRqbHIyZHJtb2ZX?=
 =?utf-8?B?anJvVXpQc1FSMk1rRHpHT1A3KzBDc29yd1prZ1c5bTVqYnEyWWZmYVd5UktH?=
 =?utf-8?B?U1FRODFDQWVOQlhMVVlZVXcxVHF1SUI4NGs5WnFHY3IzY1BZWnlqYnlvTWpa?=
 =?utf-8?B?NE0vbEtpcE9Ed01LVUoyTjhTbnBDSTlCVWIyRHZ2eVFNdVBjVFdsMTAxQnN6?=
 =?utf-8?B?K3hOQy9UWlY1M1IvSEhFNUNYWExLbmpONkV5dzl5SXFwWlQ5ZWRFVXptSkIw?=
 =?utf-8?B?eklRRzNBQTJ2OVNibVBDRWRRb0gzZDA3elJsK1lqMXRtUE5GSHNUeHE3WjRU?=
 =?utf-8?Q?IjHnvgJtcwUAlV3uao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR05MB7925.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6ae572-aef1-4f62-00ec-08d92b125973
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 06:46:45.8187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUsYNYQArNVEFPaGMeIfwRxzQ1xbjjXEszLzBP9zXBwPR/npdaL8+gJuKDEh1g/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7619
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

PiBTZW5kaW5nIGEgU1lOIHdpbGwgb25seSBoYXBwZW4gZHVyaW5nIHRoZSB0aW1lIHRoYXQgY2xp
ZW50IGhhZCBhIHZhbGlkDQo+IEFSUCBlbnRyeSBpbiBpdHMgY2FjaGUgZnJvbSBhIHByZXZpb3Vz
IGNvbm5lY3Rpb24uIEFzIHNvb24gYXMgdGhlIEFSUA0KPiBjYWNoZSBpcyBpbnZhbGlkYXRlZC91
cGRhdGVkIGFuZCB0aGVyZSBpcyBubyB2YWx1ZSBhZGRyZXNzIHRvIHJlc29sdmUNCj4gdGhlICdi
YWQnIG1vdW50IHdvdWxkIGJlIHRpbWUgb3V0IGZhc3RlciAodGhhdCdzIHdoZW4gYWxsIHRoZSBv
dGhlcg0KPiBtb3VudHMgd291bGQgYmUgdW5ibG9ja2VkIGJ1dCB0aGUgaGFuZ2luZyBtb3VudCB3
b3VsZCB0YWtlIGxvbmdlciB0bw0KPiByZXRyeSBhIG51bWJlciBvZiB0aW1lcykuDQoNCkluIGFk
ZGl0aW9uIHRvIHdoYXQgTWljaGFlbCBXYWthYmF5YXNoaSBhbHJlYWR5IHNhaWQsIEkgd291bGQg
bGlrZSB0byBwb2ludCBvdXQNCnRoYXQgaWYgdGhlIE5GUyBjbGllbnQgaXMgbm90IGluIHRoZSBz
YW1lIHN1Ym5ldCBhcyB0aGUgTkZTIHNlcnZlciwgdGhlbiB0aGUgY2xpZW50DQp3b3VsZCBuZXZl
ciBoYXZlIGFuIEFSUCBlbnRyeSBmb3IgdGhlIE5GUyBzZXJ2ZXIuIEluc3RlYWQsIHRoZSBjbGll
bnQgd291bGQgaGF2ZQ0KdGhlIEFSUCBlbnRyeSBmb3IgdGhlIGRlZmF1bHQgZ2F0ZXdheSBvZiBp
dHMgc3VibmV0IHdoZXJlIGl0IHdvdWxkIGhhcHBpbHkgc2VuZCBhIFNZTi4NClRoaXMgaXMgZXhh
Y3RseSB3aHkgd2UgYXJlIGFza2luZyB5b3UgdG8gcmUtY3JlYXRlIHRoZSBpc3N1ZSB3aXRoIHRo
ZSBleGFjdCBjb21tYW5kDQp0aGF0IE1pY2hhZWwgV2FrYWJheWFzaGkgaGFzIHByb3ZpZGVkLCBh
cyB3ZSBiZWxpZXZlIHRoYXQgZmFrZSBJUCBvZiAyLjIuMi4yIHdvdWxkIGJlDQpvdXRzaWRlIG9m
IHlvdXIgTkZTIGNsaWVudCdzIHN1Ym5ldCByYW5nZS4NCg0KVGhhbmtzLg0KLUFsZXgNCg==
