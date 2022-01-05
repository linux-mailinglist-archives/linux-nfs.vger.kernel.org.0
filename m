Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC148553D
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Jan 2022 16:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiAEPCl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Jan 2022 10:02:41 -0500
Received: from mail-bn1nam07on2112.outbound.protection.outlook.com ([40.107.212.112]:21319
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241175AbiAEPCj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Jan 2022 10:02:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnCQ7/DnUOkYiTAYHDpx4do/HSaldo+XIyPE8k7imXXINRWq30KJpBtRAGLFy8cfn+pGEmIe/tnVgY7j7rWZlp0gLpfpHRNxLj0sU7b3MJBnAV3jpKHtGrwJPMl8pBs8Wkd8XKg6IvA17DAQWeMcfmeB27Uiv1s7l8WgwuNJ5WWlBp2r942Vu9R7j6dFLGESoUKDzZa+SFAMmiGo3xI3wVhmC8/dVQZ2oman4DoaMZqzskAE0/omN77tI2vAfaSOspKRC9gqRdhWQSRJuz8ob08Hb/A2DN+SDlGG4Rl/CK9p43IbN4zHbKvwONlIsIwNIrpD/QcKtyRzU5oUGwN96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1104itNxq9Q4C9QCLzuoAw0hCsEuVK+qouS5slfrfAk=;
 b=Ck4AJZBLnI0MiRBw3BX4+5v0nJQ0TYyHTEFoAKsEJog9mNX5nznj5SMx32VBAmlyaQ3XIHfvgA9tOaXQpsMAwGdYJbh12jSGR0ITRCbm94bZFeWInZb3SpnSaOr1KvguDmL6HDfvwa0xEzyz5u0aAWRL0Fx77UIq6f1oDpQmQU3KdaF2GfxKhm80jo64v6Ywdt9dRgIUUikLh5NojaZgZDG2WMd+Cd/K53WMCc5skqrvkX8BxTHkCiPrcWs3FoRXZzMUbKou60xepubOMqAphAk4NzdOVMi65I9eODl29UW2fkfCYwRu4/o1csuxLWLjF59yVT6SRgrts/FAM0E7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1104itNxq9Q4C9QCLzuoAw0hCsEuVK+qouS5slfrfAk=;
 b=dFZcLuFi6G6GqjjZhauFHe/5O/bgSf1bSSQZnAnP96z7XAhdOgFxJjWhZTqGGZ9270wd1X8gTcqtNi0DEtDTvxoDb7tGY2wJgFnNbSOnWT7tgbEC7Jbi3RwCabK20qqehxXffePFJPws9w1b7e5vAsp58UxmV997XqQ4JrEBQB8=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BN6PR13MB1842.namprd13.prod.outlook.com (2603:10b6:404:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.4; Wed, 5 Jan
 2022 15:02:34 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%4]) with mapi id 15.20.4867.007; Wed, 5 Jan 2022
 15:02:34 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel
 panic
Thread-Topic: [PATCH] RDMA: null pointer in __ib_umem_release causes kernel
 panic
Thread-Index: AQHYAkVETpS/mIA74kSyVJLZ8d1qQw==
Date:   Wed, 5 Jan 2022 15:02:34 +0000
Message-ID: <3b74b8f4481ec27debad500e53facc56f9b388cd.camel@hammerspace.com>
References: <20220105141841.411197-1-trondmy@kernel.org>
         <20220105143705.GS2328285@nvidia.com>
In-Reply-To: <20220105143705.GS2328285@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d33d32-41a1-42e4-e766-08d9d05c6782
x-ms-traffictypediagnostic: BN6PR13MB1842:EE_
x-microsoft-antispam-prvs: <BN6PR13MB18420439DFF829E573079D14B84B9@BN6PR13MB1842.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBNq9kDjjaj5zWCrm5Sh18+51Kape6B48LNIH99qWZKSsj8NP1yUSTa+GKZTHXyf/cgVBoBurfHlgq0RpbIdzQTin1h9Pgoepl/wZk3vgUWkhR+PG6+bDG5MlbZlrPA5lOzkX2lI/jTFmot0EivyMOHLGDpoc8M0HDHF+ERVYQjesLAR3YxwPM+jb9AJhSB1a5HoMqjsyON4kGHbtlIfvMdH3L0WfORMDflkihNmogpLXr+LF34CZqDF6laYnwEyoL9IKWMaxfoWxj/SNjes0AIyG52Sq4kxxIsX8onouGqm6gihHNVTD9CoKq/7xUh23HwogtvphOLnQV44OPUDRbeKPKp7upkSllAs/aLLPbt0VgFbh91nLkecfLcO9/wMtlbHRqVlOPfgx0mqStI6ISeDNkJd8ntRyD4DTxH0QuWkIaG3wgryPXMcfVO2jY5gBpga2PVx7HisNW586o1KFWvTFAhZsrUO0yZJ75K2ScwKd5lRWySeNRSSj6CgJDJWYBPCa1wJmKhFp/xC5PC7979OKzRmaKoAFzkCEN6zEcIhKCQjQ7dAEPxIJCFix2GuYprYswc6/36eBJS1v8glkpsJNw3ZOBe+ivPnsinjgShnf+ffLjVMYxlSsbVQh5J58wZ0EQqKE9gi4aPdnd27wn4dLQHv/+sKJr0G64Ps5oOWhrUtuoSPPttVKqcbb6mQJHZI9LtDnLzBNk49OgUURA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(396003)(39830400003)(136003)(366004)(64756008)(66556008)(66476007)(66946007)(4326008)(38070700005)(83380400001)(8936002)(66446008)(8676002)(86362001)(6486002)(508600001)(110136005)(54906003)(36756003)(76116006)(316002)(5660300002)(38100700002)(2906002)(26005)(186003)(2616005)(71200400001)(122000001)(6506007)(6512007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE9IZnJTU3RNcWlEZHlYWEJ5SUdtWU5idGsyN0NYUWRibm5YTC9aaW9FOUxj?=
 =?utf-8?B?SEkwaHVCeUNtQ01US1NLRW9UY0J5dGVSNVhxbDRjcHdQY09UZDZaV0NzQUxM?=
 =?utf-8?B?Um1wbVNUcjN5NzBnSTVaRDUzU3BQb1VEUWtwSkMwYk1TeWdzM3lpdGd2bDlC?=
 =?utf-8?B?MTlmamJ3a0pEbUZHWUlBdjNYdFlrcHI3amJOT3ZlcXhMSVYzLzh1Uy9Fb3oy?=
 =?utf-8?B?VUw2ekIremQ3ZHJkYkVuV21jSzZZeG1DeUVVOFhFaDR2dks1aFNubVBZMEtZ?=
 =?utf-8?B?QjIvV3lzSnhUd2IvM1l6VUVIaS9WWXZPWDhsV3lpblBwUDZUTmxqMGl2OHIv?=
 =?utf-8?B?c1d4T0JNN3lTWmt0cTl0eGFmdW5jSVJFcGNGeVFiNnFlems3ZkM4a2tZNEJC?=
 =?utf-8?B?WmJkNjd5UnpkTWJya3V1eHc1TXVYMEVkQ3JkUnQ5Tk1mUFlwSk5HZ3FYL2Y1?=
 =?utf-8?B?T1ZuZE02dU5BeUFDeDB0Z2VWbjdxWElXSE9sdTlGb2hoTGJOZ3dMK2dlaERp?=
 =?utf-8?B?YmlxTTdyRWpQNHhvZC9QaXZObWlOaXBGeHVBektZWkhUdWZZWldxdXNSM1Ur?=
 =?utf-8?B?NG91cXdMdS9sNitMY2RzRW9uVm5aNTRwbmRXZ0hjeTM1aXRqcUpUeXZwQ1E2?=
 =?utf-8?B?R0JSQ3ZESEhzbmhrMit5b1NUd3JwMU1TL2Fpb0dCaHFTSU8xVEMyekFrUGE0?=
 =?utf-8?B?SnZKL3VRckt4YXFRaUlCSjJmMDRCNzJybmhnVnhDVWN6aXVaTmN2dWdQY2U5?=
 =?utf-8?B?S29XS2hQS3RsTVpSQzBoNG5VbmVibUx0NTNWUThzOGxPZmU3TDR4am5aNkNx?=
 =?utf-8?B?SXFERFlzVG1zTmZhQk5naXViLzZuUWtMZjd0Y3pmSWxzSDFvcWpNU2hSek84?=
 =?utf-8?B?MEZuWUhRVGxBUlhldWkrcGFCV1MvUEZnWDVZQW96VTlMcVNLbXBjcFN2bmMx?=
 =?utf-8?B?azd2bWVQcnJ2OVlPeXRTL0phTy9wc2FMdnhVaTJTUTROYnU1Wjl4SVpGbHd1?=
 =?utf-8?B?bkVCKzhWRC9zUUl0UExaZlZFTk5vNlg5TW9wclVCdlZ0aEU3T01jK3VFeDEw?=
 =?utf-8?B?cDM1aVY0VHpTSkpUY2dpZ1prU2YwSThlc2hGRmdUQjhISXNVL1B6NnFWUXQr?=
 =?utf-8?B?K09QOXNWRnlCTjhSYnNudEcrOG1CZnFxNVNIcHNKWjBIV2ZtRGx3MlFUZWhF?=
 =?utf-8?B?eXNQd2doUTlYbHBnMktaSVl6QXJBNFFZcWdydDRZSzMyMDlXaTVUZkgrakpX?=
 =?utf-8?B?Y043MWVoaDFMYS83UzYrZWIvVSs2cjhIM3ZHa3p4aDNLZGQ5dlBkZEQvQjdq?=
 =?utf-8?B?a25wakN6d01RVDNTdzl6OXN3eTVNSVhEa3h0MG1wRG83ZHZkMUpBNHIxRElq?=
 =?utf-8?B?Y2kxUmJ3eFVIbU9DYlRRY3orbTFBSExleDFIYWtOQmEvRTloL0c2QjVWOGZ5?=
 =?utf-8?B?dkhwaVd1TzUvT1ZBZUdhakdaLzVnWnhnU1ZSZ0RNTjd5ekRlWEZ1TXNNRVNY?=
 =?utf-8?B?YzVlY0xNamtNZUVjS2hFRUhpNTZWNUg3eDJWaVRRT3grbzkxbUZQVUpPM29t?=
 =?utf-8?B?OFRESWIxSEx3NjNBU2VWamJlb3ZHRld5aFRxTGRZemhwWUhadjFveWE0R3Ro?=
 =?utf-8?B?YkpFRFFiWjh5VUZLd2JEWEQ3VG90MS9janVoYXhiRXp4K2N1LzNMYklRdU1z?=
 =?utf-8?B?eTlzVHR0OUxjYmZPNCsyNEZRZVJVKzFva29MajljMXhXWWYyRU11NXhVZHVa?=
 =?utf-8?B?YWNGajJFNFNjUFpsUWhlQ3c4K3UxYUtsMlB2Q3ZJejBKTU1leFhudW1ROEtp?=
 =?utf-8?B?cTR6bGdxUUQyckdBbUlucFd0MDB4Rmt6RENSSVRLcTFPOThPMUZ3NzVCaGJM?=
 =?utf-8?B?enZrODJPZXVYVDVJUlB0NVQ1bG1BSkZhc2ZUd0Qxc1NTK0d6VmVVU3cwYXNS?=
 =?utf-8?B?Y0xXTHhKbmpSUUl1YjYxeEJpbmVLTVNSY09wOFIwN2J6NkVINnFxOC9WZFNT?=
 =?utf-8?B?ckNqcFh3TVBSeXNmcmNqSlFaTm5xS3N1d0h6QXB5SW5uUzEvTGdkOURUNHNv?=
 =?utf-8?B?THd4SDdTZjZjelVxVksyRGVQTXg3UFBES2xwRVJnYzIzM2tJb0cxYWV4R3Bl?=
 =?utf-8?B?eW5vNzUvc01GTWVOdXhTeStNL3MrV1hUUndnRFA0NVY2bm1HYm11SHZzamxJ?=
 =?utf-8?Q?x2FKLUdFFX9jK3kOAMsYJuU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9386A5A85C9FE24D9CEB99253394D537@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d33d32-41a1-42e4-e766-08d9d05c6782
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 15:02:34.0791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iA+YK5GVEj1Z1gQX8bYeJ+hUJa3g3ij1Zn84k2rOReOqDFHjrrbhXp41RfjB6Pbykb/5KGscn+M5mFa+SGg4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1842
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTA1IGF0IDEwOjM3IC0wNDAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIFdlZCwgSmFuIDA1LCAyMDIyIGF0IDA5OjE4OjQxQU0gLTA1MDAsIHRyb25kbXlAa2Vy
bmVsLm9yZ8Kgd3JvdGU6DQo+ID4gRnJvbTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1
c3RAaGFtbWVyc3BhY2UuY29tPg0KPiA+IA0KPiA+IFdoZW4gZG9pbmcgUlBDL1JETUEsIHdlJ3Jl
IHNlZWluZyBhIGtlcm5lbCBwYW5pYyB3aGVuDQo+ID4gX19pYl91bWVtX3JlbGVhc2UoKQ0KPiA+
IGl0ZXJhdGVzIG92ZXIgdGhlIHNjYXR0ZXIgZ2F0aGVyIGxpc3QgYW5kIGhpdHMgTlVMTCBwYWdl
cy4NCj4gPiANCj4gPiBJdCB0dXJucyBvdXQgdGhhdCBjb21taXQgNzlmYmQzZTEyNDFjIGVuZGVk
IHVwIGNoYW5naW5nIHRoZQ0KPiA+IGl0ZXJhdGlvbg0KPiA+IGZyb20gYmVpbmcgb3ZlciBvbmx5
IHRoZSBtYXBwZWQgZW50cmllcyB0byBiZWluZyBvdmVyIHRoZSBvcmlnaW5hbA0KPiA+IGxpc3QN
Cj4gPiBzaXplLg0KPiANCj4gWW91IG1lYW4gdGhpcz8NCj4gDQo+IC3CoMKgwqDCoMKgwqAgZm9y
X2VhY2hfc2codW1lbS0+c2dfaGVhZC5zZ2wsIHNnLCB1bWVtLT5zZ19uZW50cywgaSkNCj4gK8Kg
wqDCoMKgwqDCoCBmb3JfZWFjaF9zZ3RhYmxlX3NnKCZ1bWVtLT5zZ3RfYXBwZW5kLnNndCwgc2cs
IGkpDQo+IA0KPiBJIGRvbid0IHNlZSB3aGF0IGNoYW5nZWQgdGhlcmU/IFRoZSBpbnZhcmllbnQg
c2hvdWxkIGJlIHRoYXQNCj4gDQo+IMKgIHVtZW0tPnNnX25lbnRzID09IHNndC0+b3JpZ19uZW50
cw0KPiANCj4gPiBAQCAtNTUsNyArNTUsNyBAQCBzdGF0aWMgdm9pZCBfX2liX3VtZW1fcmVsZWFz
ZShzdHJ1Y3QgaWJfZGV2aWNlDQo+ID4gKmRldiwgc3RydWN0IGliX3VtZW0gKnVtZW0sIGludCBk
DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpYl9kbWFfdW5tYXBfc2d0YWJs
ZV9hdHRycyhkZXYsICZ1bWVtLQ0KPiA+ID5zZ3RfYXBwZW5kLnNndCwNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgRE1BX0JJRElSRUNUSU9OQUwsIDApOw0KPiA+IMKgDQo+ID4gLcKg
wqDCoMKgwqDCoMKgZm9yX2VhY2hfc2d0YWJsZV9zZygmdW1lbS0+c2d0X2FwcGVuZC5zZ3QsIHNn
LCBpKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoGZvcl9lYWNoX3NndGFibGVfZG1hX3NnKCZ1bWVtLT5z
Z3RfYXBwZW5kLnNndCwgc2csIGkpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB1bnBpbl91c2VyX3BhZ2VfcmFuZ2VfZGlydHlfbG9jayhzZ19wYWdlKHNnKSwNCj4gDQo+IENh
bGxpbmcgc2dfcGFnZSgpIGZyb20gdW5kZXIgYSBkbWFfc2cgaXRlcmF0b3IgaXMgdW5jb25kaXRp
b25hbGx5DQo+IHdyb25nLi4NCj4gDQo+IE1vcmUgbGlrZWx5IHlvdXIgY2FzZSBpcyBzb21ldGhp
bmcgaGFzIGdvbmUgd3Jvbmcgd2hlbiB0aGUgc2d0YWJsZQ0KPiB3YXMNCj4gY3JlYXRlZCBhbmQg
aXQgaGFzIHRoZSB3cm9uZyB2YWx1ZSBpbiBvcmlnX25lbnRzLi4NCg0KQ2FuIHlvdSBkZWZpbmUg
Indyb25nIHZhbHVlIiBpbiB0aGlzIGNhc2U/IENodWNrJ3MgUlBDL1JETUEgY29kZQ0KYXBwZWFy
cyB0byBjYWxsIGliX2FsbG9jX21yKCkgd2l0aCBhbiAnZXhwZWN0ZWQgbWF4aW11bSBudW1iZXIg
b2YNCmVudHJpZXMnIChkZXB0aCkgaW4gbmV0L3N1bnJwYy94cHJ0cmRtYS9mcndyX29wcy5jOmZy
d3JfbXJfaW5pdCgpLg0KDQpJdCB0aGVuIGZpbGxzIHRoYXQgdGFibGUgd2l0aCBhIHNldCBvZiBu
IDw9IGRlcHRoIHBhZ2VzIGluDQpuZXQvc3VucnBjL3hwcnRyZG1hL2Zyd3Jfb3BzLmM6ZnJ3cl9t
YXAoKSBhbmQgY2FsbHMgaWJfZG1hX21hcF9zZygpIHRvDQptYXAgdGhlbSwgYW5kIHRoZW4gYWRq
dXN0cyB0aGUgc2d0YWJsZSB3aXRoIGEgY2FsbCB0byBpYl9tYXBfbXJfc2coKS4NCg0KDQpXaGF0
IHBhcnQgb2YgdGhhdCBzZXF1ZW5jZSBvZiBvcGVyYXRpb25zIGlzIGluY29ycmVjdD8NCj4gDQo+
IEphc29uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
