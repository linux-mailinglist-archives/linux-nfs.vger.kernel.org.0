Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9C2CE4B0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Dec 2020 02:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgLDBDP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 20:03:15 -0500
Received: from mail-dm6nam11on2139.outbound.protection.outlook.com ([40.107.223.139]:35105
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728282AbgLDBDP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 20:03:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwKKGqNiCMpTf11d+ljQxQ4v61gy0RYNKQCtgChAIU1JDCUywKc1F+B6bz06cvOFPIEAi5z9KXWS9DtgotZ3ZeYq8CM6lpwIQT16IjuBhke1UUms53N2Gm0l0oJEjDCnlzsBiJcH7EshaviXLNTv+qEJn2nQxLMbykwEwxD7dRdFBTKiJ+j/26LI/onwOmqtLnYwJqCLSqEhGF8d8Jdo6qYH9dTFd0TQ/KLW2ZWUsSJf4BtqCCKpAsw+Ie5p34rGQId8bR0u21i/dwrtIirXx7gsN6L1+CYNVidwQhClm0pTrMpYbNgJhREANjZE8vs6jP1JPM62PYBBiZKpol8m/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f52MgLCwFW1TaGyNQpJjFKHCsKIHWhrvb/Kg/bbBZZE=;
 b=njYiE7AJY+lqmZLuV1CPfJ56sQ5eCOQziznGCLVMegcSVU2QTYuHVfpooDF1kdLWxwu92nSG0B3qlxSxz/obK4DB6tWa8Qez1/B+wyW5H4LMhxHVGWRc+/ps1MqXsH+0hI1npRHpQNoRd1Dk8IvKeBEtlw7gOc+dJALwPIak3acixN/F0MK47LhAvyDgxYZQLa6BqLFOH+5WuAXKl682caclX/qsojhiyKRy4CO8No62XA0NaLks3BkInX0SQuPONa0Mr9EpNQOPMsfEPBdphYWJZDtovxUeeZN9msB535cMuXcW9FMLpAj1V0T/D27FwmbJmkdd4McCeSSyVFLsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f52MgLCwFW1TaGyNQpJjFKHCsKIHWhrvb/Kg/bbBZZE=;
 b=WvXT+8rSbaBQPtKs/TIKg8z4lZpIXQyCqnx9jCorakbK5iSn9vKoOqykpzz1KZRQb/UhUIRANF/Chy5On3vCv7AYigJo9yIijO8c0S61d/RHIvnn4vwanIHQ5pmDxX16bCk3RRYCuMq6nfyK1jFTieCoT3FGe9Y7awZyNx3jhQw=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3661.namprd13.prod.outlook.com (2603:10b6:208:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Fri, 4 Dec
 2020 01:02:20 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Fri, 4 Dec 2020
 01:02:20 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVGiQL7pUtKchSdvFeTqNAIAEhEYAgBNavQCAAAtBAIABTyGAgAxAb4CAAG0ggIAAGvSAgAAMzwCAAAXZAIAAE9IAgAACQQCAAAaSgIAAHXOA
Date:   Fri, 4 Dec 2020 01:02:20 +0000
Message-ID: <136e9c309ad962cb247b9e696633484db76d1f3b.camel@hammerspace.com>
References: <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
         <20201124211522.GC7173@fieldses.org>
         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
         <20201203185109.GB27931@fieldses.org>
         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
         <20201203211328.GC27931@fieldses.org>
         <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
         <20201203224520.GG27931@fieldses.org>
         <d88c69f90820bf631908cbe3d3ce34343ec672f1.camel@hammerspace.com>
         <20201203231655.GH27931@fieldses.org>
In-Reply-To: <20201203231655.GH27931@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ca2c09f-95a7-43fb-aa16-08d897f04099
x-ms-traffictypediagnostic: MN2PR13MB3661:
x-microsoft-antispam-prvs: <MN2PR13MB36610A6CCECAEB58C06E5B8EB8F10@MN2PR13MB3661.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j8PeVy9TsPDVm3QNNP0M/JRjndkRc36jTrA8gMQ++iNd7IG+RcCyB4OoQ2hHxB0xS8xDU9QIZPo9gLLhIbsSxqYCVKr5Clhkj6hjLBwMQKcji7xvKVCuWkjc6WLXkK9XD0PA1vSVC1u0TAy97DwVj4pspAUw/9bv7MuC/Qoq5+ppwWU8yEv/8f8uMGxwwmakfemgs1viPhuxREABcd0bIBKi9t+1hfCxFZ5Emh4DP8+ZMOBAgdkUIIqrArsYJ3QUNNMgpnnrD8Aj8K7st6HvtrSvV+CkTqVR8jfZBY83GEXRXQDGgTLw5jEpd7W0QBs8rdOAS82X3JZIuGB8gDCJcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39840400004)(396003)(366004)(136003)(64756008)(2906002)(91956017)(54906003)(76116006)(5660300002)(2616005)(66446008)(6916009)(66476007)(71200400001)(316002)(6512007)(8936002)(66556008)(86362001)(66946007)(186003)(26005)(8676002)(83380400001)(4326008)(478600001)(6486002)(36756003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TzFkZ2NISWlKaWlsWUlyTklKTHVlbnZHSG1ZOFlsbWhEOXN0TFBrOUh6emh1?=
 =?utf-8?B?aUFWUldZcUNkaFJZVnlnVTlBTkM0NDdZV2dPU2pqUVUvR1liMFdPMUpDNW9h?=
 =?utf-8?B?SGhvUEZYTnc1K3daRXdzZmVnUGc1V3p5OEdXMFVVK0VPUGVxZmhBL2NqMjRk?=
 =?utf-8?B?d1ZqN0NYK0hDdnp1NnlNNXl1djY5aTcxUzNLWHkvQUxMLzBwcmxEY051S2ls?=
 =?utf-8?B?cTdGVGlSZTFjem1oMWlnaDFqVmc5bDNUMlJKYXJMdFBBa3VCdnJZRGdjYmQr?=
 =?utf-8?B?VUkyNkJVcWlUNXV1V001blZreHFJcnVRYVlLdlRVYk9Rb1l3Tmp3b0hYR2Jn?=
 =?utf-8?B?S2FmS1U5WVU3dXlpZkMzMGIxdENwa3AxU3krek5lYVBycVlWOE5uV3hEdVlS?=
 =?utf-8?B?Zk1xUjE1c0hOUEpBUCt4cmZISk5aWk5mVkgvUUw0ZUo2OTNDZXp3bkx2OVo3?=
 =?utf-8?B?L25sVUNzK0NtT0dLRGhYcS92VXJURWQwelJTWnBmNGRIUndkbmhkbTFnSUlC?=
 =?utf-8?B?MTJUOFZKck1iSnduM3NyRzFab2R5SjFUNCt1OXpqL1ZrbjVOMEVhbjJVTjJt?=
 =?utf-8?B?cnVOUU51dGlDNC9LS05kT1BjMURjUjJHNUd1dUI0azZpV3JNNTBJRDRPQW1s?=
 =?utf-8?B?aFBST1NzTnZVMGZYNHVIcmVjM3hpS25JQzdxMXBFaXkvV3ErOTRQbS9ZVmUv?=
 =?utf-8?B?Q1hnTHNUSEIreUptR1lCalhWY1R2ZXVOSGRSVUhxMkY5TjlhQTliRGdtM2k1?=
 =?utf-8?B?WVY3S1ZxcmpJZUw0cW5pZkZ6UnI3a2QyQXJLNWE1d1BROFhENGEzYmxHYWFY?=
 =?utf-8?B?dVZzRVEyTjVWRHBwWmxnL0w0VXV3T281S293cDBhMnIwckRyNjYveGFhV1BW?=
 =?utf-8?B?Z0lvR2JCa29zL2paWnc5LzJSNjQwc0llcGEvb1FuRFNpZUROSGdUb3d0ZzRD?=
 =?utf-8?B?WmpPaDlObjZ5RzMxbDEvOGhFSEprTXRTK25iSHRNeW9jeUZhKzlqQmk0NGpM?=
 =?utf-8?B?UHZyVU0relN4SDNvTVI3a0NicmQ2NU9JYU1kU0ppWXQ2UCtnUUlrL2lFWC9X?=
 =?utf-8?B?Tnh6Nkszb3ZUK3hCUEJubFpLVk8wNnZkMi9OTVhWd0N1TktZdVVFU01rSTd1?=
 =?utf-8?B?ZWluSGljQUx3MlBmMUtsMUtld1NlWUhiMWJUYUdwbDNidEdlQS82c2kvMnBn?=
 =?utf-8?B?VXRsVzhhRldBck9WcW9JM2h4akxZVURQR3lPSUU0YlUyQTJoakdEYTJQWHFH?=
 =?utf-8?B?di8rdnNNY2xjc01Ncm9SQ2RwYkpYRk5kQ3g3d0FqTkFHZVZHWHBranRWd3Yx?=
 =?utf-8?Q?GF23ogQwUszCETa5ur1cWfbjkX+y23gQqx?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D936D568442E94781D378587D387304@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca2c09f-95a7-43fb-aa16-08d897f04099
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 01:02:20.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjMV1yGohh3yPmhwMirhxadRkNKuvxSnvj//srCfrHHX3g1RaTf1yjUmaI89SlxObiLuvHlVy1hOT81GNvHpYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3661
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE4OjE2IC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMTA6NTM6MjZQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0xMi0wMyBhdCAxNzo0NSAtMDUwMCwg
YmZpZWxkc0BmaWVsZHNlcy5vcmfCoHdyb3RlOg0KPiA+ID4gT24gVGh1LCBEZWMgMDMsIDIwMjAg
YXQgMDk6MzQ6MjZQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBJJ3Zl
IGJlZW4gd2FudGluZyBzdWNoIGEgZnVuY3Rpb24gZm9yIHF1aXRlIGEgd2hpbGUgYW55d2F5IGlu
DQo+ID4gPiA+IG9yZGVyIHRvIGFsbG93IHRoZSBjbGllbnQgdG8gZGV0ZWN0IHN0YXRlIGxlYWtz
IChlaXRoZXIgZHVlIHRvDQo+ID4gPiA+IHNvZnQgdGltZW91dHMsIG9yIGR1ZSB0byByZW9yZGVy
ZWQgY2xvc2Uvb3BlbiBvcGVyYXRpb25zKS4NCj4gPiA+IA0KPiA+ID4gT25lIHN1cmUgd2F5IHRv
IGZpeCBhbnkgc3RhdGUgbGVha3MgaXMgdG8gcmVib290IHRoZSBzZXJ2ZXIuwqAgVGhlDQo+ID4g
PiBzZXJ2ZXIgdGhyb3dzIGV2ZXJ5dGhpbmcgYXdheSwgdGhlIGNsaWVudHMgcmVjbGFpbSwgYWxs
IHRoYXQncw0KPiA+ID4gbGVmdA0KPiA+ID4gaXMgc3R1ZmYgdGhleSBzdGlsbCBhY3R1YWxseSBj
YXJlIGFib3V0Lg0KPiA+ID4gDQo+ID4gPiBJdCdzIHZlcnkgZGlzcnVwdGl2ZS4NCj4gPiA+IA0K
PiA+ID4gQnV0IHlvdSBjb3VsZCBkbyBhIGxpbWl0ZWQgdmVyc2lvbiBvZiB0aGF0OiB0aGUgc2Vy
dmVyIHRocm93cw0KPiA+ID4gYXdheQ0KPiA+ID4gdGhlIHN0YXRlIGZyb20gb25lIGNsaWVudCAo
a2VlcGluZyB0aGUgdW5kZXJseWluZyBsb2NrcyBvbiB0aGUNCj4gPiA+IGV4cG9ydGVkIGZpbGVz
eXN0ZW0pLCBsZXRzIHRoZSBjbGllbnQgZ28gdGhyb3VnaCBpdHMgbm9ybWFsDQo+ID4gPiByZWNs
YWltDQo+ID4gPiBwcm9jZXNzLCBhdCB0aGUgZW5kIG9mIHRoYXQgdGhyb3dzIGF3YXkgYW55dGhp
bmcgdGhhdCB3YXNuJ3QNCj4gPiA+IHJlY2xhaW1lZC7CoCBUaGUgb25seSBkZWxheSBpcyB0byBh
bnlvbmUgdHJ5aW5nIHRvIGFjcXVpcmUgbmV3DQo+ID4gPiBsb2Nrcw0KPiA+ID4gdGhhdCBjb25m
bGljdCB3aXRoIHRoYXQgc2V0IG9mIGxvY2tzLCBhbmQgb25seSBmb3IgYXMgbG9uZyBhcyBpdA0K
PiA+ID4gdGFrZXMgZm9yIHRoZSBvbmUgY2xpZW50IHRvIHJlY2xhaW0uDQo+ID4gDQo+ID4gT25l
IGNvdWxkIGRvIHRoYXQsIGJ1dCB0aGF0IHJlcXVpcmVzIHRoZSBleGlzdGVuY2Ugb2YgYSBxdWll
c2NlbnQNCj4gPiBwZXJpb2Qgd2hlcmUgdGhlIGNsaWVudCBob2xkcyBubyBzdGF0ZSBhdCBhbGwg
b24gdGhlIHNlcnZlci4NCj4gDQo+IE5vLCBhcyBJIHNhaWQsIHRoZSBjbGllbnQgcGVyZm9ybXMg
cmVib290IHJlY292ZXJ5IGZvciBhbnkgc3RhdGUgdGhhdA0KPiBpdA0KPiBob2xkcyB3aGVuIHdl
IGRvIHRoaXMuDQo+IA0KDQpIbW0uLi4gU28gaG93IGRvIHRoZSBjbGllbnQgYW5kIHNlcnZlciBj
b29yZGluYXRlIHdoYXQgY2FuIGFuZCBjYW5ub3QNCmJlIHJlY2xhaW1lZD8gVGhlIGlzc3VlIGlz
IHRoYXQgcmFjZXMgY2FuIHdvcmsgYm90aCB3YXlzLCB3aXRoIHRoZQ0KY2xpZW50IHNvbWV0aW1l
cyBiZWxpZXZpbmcgdGhhdCBpdCBob2xkcyBhIGxheW91dCBvciBhIGRlbGVnYXRpb24gdGhhdA0K
dGhlIHNlcnZlciB0aGlua3MgaXQgaGFzIHJldHVybmVkLiBJZiB0aGUgc2VydmVyIGFsbG93cyBh
IHJlY2xhaW0gb2YNCnN1Y2ggYSBkZWxlZ2F0aW9uLCB0aGVuIHRoYXQgY291bGQgYmUgcHJvYmxl
bWF0aWMgKGJlY2F1c2UgaXQgYnJlYWtzDQpsb2NrIGF0b21pY2l0eSBvbiB0aGUgY2xpZW50IGFu
ZCBiZWNhdXNlIGl0IG1heSBjYXVzZSBjb25mbGljdHMpLg0KDQpCeSB0aGUgd2F5LCB0aGUgb3Ro
ZXIgdGhpbmcgdGhhdCBJJ2QgbGlrZSB0byBhZGQgdG8gbXkgd2lzaGxpc3QgaXMgYQ0KY2FsbGJh
Y2sgdGhhdCBhbGxvd3MgdGhlIHNlcnZlciB0byBhc2sgdGhlIGNsaWVudCBpZiBpdCBzdGlsbCBo
b2xkcyBhDQpnaXZlbiBvcGVuIG9yIGxvY2sgc3RhdGVpZC4gQSBzZXJ2ZXIgY2FuIHJlY2FsbCBh
IGRlbGVnYXRpb24gb3IgYQ0KbGF5b3V0LCBzbyBpdCBjYW4gZml4IHVwIGxlYWtzIG9mIHRob3Nl
LCBob3dldmVyIGl0IGhhcyBubyByZW1lZHkgaWYNCnRoZSBjbGllbnQgbG9zZXMgYW4gb3BlbiBv
ciBsb2NrIHN0YXRlaWQgb3RoZXIgdGhhbiB0byBwb3NzaWJseQ0KZm9yY2libHkgcmV2b2tlIHN0
YXRlLiBUaGF0IGNvdWxkIGNhdXNlIGFwcGxpY2F0aW9uIGNyYXNoZXMgaWYgdGhlDQpzZXJ2ZXIg
bWFrZXMgYSBtaXN0YWtlIGFuZCByZXZva2VzIGEgbG9jayB0aGF0IGlzIGFjdHVhbGx5IGluIHVz
ZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
