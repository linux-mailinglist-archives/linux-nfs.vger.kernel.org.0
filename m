Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076D831124D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 21:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhBESkR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 13:40:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39724 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhBESiz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Feb 2021 13:38:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KJgrb126034;
        Fri, 5 Feb 2021 20:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=E5dJt4MALTlht7cr5Jok+Dz/lvxbuNqNsnRV22fpKR0=;
 b=sU2ycM7Tv5TViqkmbwmZDoIlFiSkLE5ofD8zm98ewPsKhBHVz63wFfx7jbOUDbDZjtf+
 /LCLJBH3xpdlCtjTSvdlZp9grmPBpKI178/rLshVatesE26mdcz48J5rw8k423OpZK+M
 eLWCaYesGxESinF0ZeexqMLvX2oTo9qRujzsszAPMsaNVE8uhnjubtHCPcfyXFccWte8
 1JW3Z4Pfe1gsC5PWgDdnRHT9S3XPVHDeWYL0BrtnTN9NKdGXX+urc3fILrCj6iyvkx7h
 ji8YrjRD3I0NU+5HORklVfwS5HcnXCefcTRzUFXQarB2oTl3wyduFQWMVI3NftE+YM58 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36gfw8u4d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:20:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KFlYs001108;
        Fri, 5 Feb 2021 20:20:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 36dh1udu4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRTrWKJ3fqQNdj2kV9+YWmaYKPvjFtrEabhqn4DlykXIJCq+lCJRO0ILAOn0cturAwM/woiBA5XHvJeTTktb1Pm1L+wEmmD2hJuVGwFAxtbKHakhNTVC/exAwg4iocSPCvodCX+3Fsf7l8ejwqQwqTT0X8FaC2by0aAhg5kPXaAzTF606DZZLHSXD8hOectkn34DwQ6UyDmfAAJp7A3Tik8uSIxtuEwFb0B4VStouL23QKFE6N/H0va9D0q+2u8hS7PDTi7MOJB59q3XFN2Tln6ksumT/yDbSazvCIWWth39q+uXEQ9GK2obt7/cZw7OG37UsA4Faee4QvJL4RrQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5dJt4MALTlht7cr5Jok+Dz/lvxbuNqNsnRV22fpKR0=;
 b=b8aLAtvkA+JIrkP2mHQfdDXdjWcHqqW3gflz48jl2luWJgcb83BeWJfNJ0frgcGePIK2U1Y0fb0oySzOEDNV63gAUWeEv50NndH1M9wYKdJfbJ6T7Q6wNC3K0atUfuQ4nqzMXoo7Lx43EIX0u8pKv+xZ1ITtcbwrbPeUzKvZs0SownN7rrNuRWfKvwjgSxFYl2nmoWP8oJ+5Ger+/ifHiLa/m/yNsXr/1E0KMOvYZRzkjInLOscEg5ZR9KcdaB5/IbdSvYVSTx8s+g7lJkogUhLgT3+7OoiwSHW1lyu0h1IX8Rz3kniKSf+oUVdLguvPa23OqecUEitVLBHRk2UTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5dJt4MALTlht7cr5Jok+Dz/lvxbuNqNsnRV22fpKR0=;
 b=F8PkRMpNwcVbi/9czMV1fBUlCne07MIly3bnU7plLA7iCeBlq3ecX7AgxkzW8PCoDFFa7y8atFgwK3fbFQKMf3Y8V5cKiJx7wnQE1ocqc/H+C4Sg5oqkmgfxNUgsopMXgmiiGEYlSckJAc8bxfvhKGe3nyIZIeWWKPLPV/eesG8=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2439.namprd10.prod.outlook.com (2603:10b6:a02:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 20:20:28 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3825.024; Fri, 5 Feb 2021
 20:20:28 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: releasing result pages in svc_xprt_release()
Thread-Topic: releasing result pages in svc_xprt_release()
Thread-Index: AQHW9lp7CEvfS3Emm06zTXNJoADK66o/M5eAgAAGcQCAAy+VgIAACaAAgAGDpoCABhUWgA==
Date:   Fri, 5 Feb 2021 20:20:28 +0000
Message-ID: <9FC8FB98-2DD7-4B78-BD72-918F91FA11D9@oracle.com>
References: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
 <87im7ffjp0.fsf@notabene.neil.brown.name>
 <597824E7-3942-4F11-958F-A6E247330A9E@oracle.com>
 <878s88fz6s.fsf@notabene.neil.brown.name>
 <700333BB-0928-4772-ADFB-77D92CCE169C@oracle.com>
 <87wnvre5cy.fsf@notabene.neil.brown.name>
In-Reply-To: <87wnvre5cy.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdb6c8b5-3090-4855-91c1-08d8ca137a91
x-ms-traffictypediagnostic: BYAPR10MB2439:
x-microsoft-antispam-prvs: <BYAPR10MB2439D3E4A50B7BA815F0D9FE93B29@BYAPR10MB2439.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMw4VnmdmyPh5BEbQtq0kF3F5cEl/lY95uWkYVZtnUcN1EWpdJ6CzrxchiaLMh6tZCC/1yMKmryFwSfb2ksH2L073CbZrN1wmQ7tQNv5Oj2cVQrE0JgIV0ZHketbqLW7wolvojHjvfoRjM6ixnsMNWZt+vrcDlmzNIWpvA6QqqE/WfJgFo2B9yiUlQB//0lVX9SZeL/e9b8RbcFge83wyYfG5j0YR01xbWE8bo1jmA7hJywqJupf4+JccWgfZ+PoqO1rL1d7TfLqg+ylWb2RqdU3ML2lWCVvDLRLin1YdAy5l+CR+bHZrpZdQiWJfzrnxrMdTgzpqOc929c9w9Lr5dmnl3hXvpm2rF6sCXpmzTVrSORe/VbVp4hC8BpfXLEeUFbQzU/u/1dr3ml2GGlZ9zf8BbJMAXdQO9CiPV1MasBKLhG7+YVHd35/BHz9MUX+rAwNCzC3e9M9KVOxSN0pNuOzkLZ/JCRyLSr2gRV8lpE7ZyTlrTRDEY6v3ByqpMlKssqhFmj6/Rrxlc9bUnskb6Ydb62siX2mPPbxmKPmumlY64/iCXCa69HBEAS0104Zoc7ltDyalg01qIJFrq7YHH8FldxY5FZ1FouSt9qlbiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(6486002)(6916009)(83380400001)(66946007)(2906002)(2616005)(6512007)(71200400001)(86362001)(44832011)(6506007)(5660300002)(26005)(36756003)(186003)(53546011)(8936002)(4326008)(33656002)(478600001)(66556008)(8676002)(91956017)(64756008)(66446008)(66476007)(76116006)(316002)(219204002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bWqvUmbsAZ5q/9YXGZ4gqMp9vEiqiDzXUMY2defxg+2hloMIz+pXGyxpoepc?=
 =?us-ascii?Q?fG9ksCEnzLkmK2wNUiK6tCaaP8KDMEgAgA+c0kqzxtX0fmRlxV5MuaVcFQPn?=
 =?us-ascii?Q?tphpvLEO2XCsgA6FZD70tCbjfnyLZsnymItUxLEkj+TLyVLeCqVjqZ3eaS6T?=
 =?us-ascii?Q?zB6s9QeqJTy0oIXp3iTJjbBFcf2dBtZVCQkZDcMv/TyyGAfOZwDx54jy1DSo?=
 =?us-ascii?Q?r5OpuB5GeHdohVwQgT3GeSD4zuXqUhR09cbCqndVS/xF7D+O9kIzc9VLJp8C?=
 =?us-ascii?Q?UrJ4FNwF8dUDdQj2CBVRYP+HgnjWPA+RUS+OkbPg0W9AhkjtAeKTZOHSQzPX?=
 =?us-ascii?Q?Kp0x+pvxJXJ0s50CUxCygegj9juTuyH2IhIWtQqD1k/SzX9CgCKweMbS8OMH?=
 =?us-ascii?Q?3F6LVnkOaP8PNu89SMwABHO2G1sR2m+8cude6rkWcDKaijBTGP2YKh+PKolN?=
 =?us-ascii?Q?OSxvZPL50bPHqNSkoVYkSDkgNiCPMuUDyMDuhaGfNIv8fUc/L3aN+egVjc4O?=
 =?us-ascii?Q?sGwZCf6avS8APIZjkiNXyDsJF4iV9te6vOrOZoddv14/co8Um+rP7+r1WUlF?=
 =?us-ascii?Q?O7Zcxe/2BCcbKwVwbp2Gd9g1zMWTPo/7SJOViKIlk8Vm+Bx6c/p6F/tF8Bnb?=
 =?us-ascii?Q?/iMcnQAq8EKkp2WlpsIZdoi80s6gY613s1W/r3cW8YP2v7C+3V7U48xcIzgp?=
 =?us-ascii?Q?wxSVUlL2UIchIT/SbDeJnkwklDRedOluCSZD0NVljI7CHaXE00jfh1rZWj7T?=
 =?us-ascii?Q?VWBULQt16eTds/0xTCeb76P9I1eqUxLA3lmtYgv2fL8AxdWDHaFw3Xt6ACb2?=
 =?us-ascii?Q?SlTpOFEXejtIUsLAbv20WU9NVKkcE1CZlmJVNe93M5gYcMnzgFrLbDIyAFJX?=
 =?us-ascii?Q?4edt/0GWMcJhs0b6W+Y9w54apDax8sQ2ONMBo40YaqiRtYUooL7v809Q9d2p?=
 =?us-ascii?Q?gd5Adr1HqFfv5ByoI9s/uvpac5UzoDmbnde4NwCc18DqApCb1YPH5msq5FFs?=
 =?us-ascii?Q?6sXurI6JwchM0VUTnj8Ko/JEWFMVqbVQg0+U6S5B4iPqVm8Tbqz3ugHo9dw+?=
 =?us-ascii?Q?WucG+x0/Ym1n8tntL4gC4s0xs5zxutTI9+aOrKDngLuawonB1mWcnEz8ocK7?=
 =?us-ascii?Q?I4iyE8CEvbrXx/gTrVFIRnITcr99aiwPtw6InZB1IJJgraywnbd7FED80h7w?=
 =?us-ascii?Q?ViKSSaUmr/FXC9sgnOj7oI9bSA07cfNNapUr62qSSHk80Witw3TEkS8Pgf9R?=
 =?us-ascii?Q?5a+FG8Fq4Wu9PgXGfnxiwYBnW6bWqa/LadJgSo2drGcb07sJ96mf1Y+wAIU8?=
 =?us-ascii?Q?SpjyCRnWJkVRFvoWj6tfy6US?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBED451A4FF02E42BDC223D1253BB556@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb6c8b5-3090-4855-91c1-08d8ca137a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 20:20:28.1220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrf5+rPx0zdFaxIuc3b6T1n7K+0i8ZQnR+SXAyzM9WKJ1+grp8QRJyKE0KmSBZHBiDjjVY0d46R99oyg0EQtDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2439
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050126
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 1, 2021, at 6:27 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Mon, Feb 01 2021, Chuck Lever wrote:
>=20
>>> On Jan 31, 2021, at 6:45 PM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Fri, Jan 29 2021, Chuck Lever wrote:
>>>>=20
>>>> What's your opinion?
>>>=20
>>> To form a coherent opinion, I would need to know what that problem is.
>>> I certainly accept that there could be performance problems in releasin=
g
>>> and re-allocating pages which might be resolved by batching, or by copy=
ing,
>>> or by better tracking.  But without knowing what hot-spot you want to
>>> cool down, I cannot think about how that fits into the big picture.
>>> So: what exactly is the problem that you see?
>>=20
>> The problem is that each 1MB NFS READ, for example, hands 257 pages
>> back to the page allocator, then allocates another 257 pages. One page
>> is not terrible, but 510+ allocator calls for every RPC begins to get
>> costly.
>>=20
>> Also, remember that both allocating and freeing a page means an irqsave
>> spin lock -- that will serialize all other page allocations, including
>> allocation done by other nfsd threads.
>>=20
>> So I'd like to lower page allocator contention and the rate at which
>> IRQs are disabled and enabled when the NFS server becomes busy, as it
>> might with several 25 GbE NICs, for instance.
>>=20
>> Holding onto the same pages means we can make better use of TLB
>> entries -- fewer TLB flushes is always a good thing.
>>=20
>> I know that the network folks at Red Hat have been staring hard at
>> reducing memory allocation in the stack for several years. I recall
>> that Matthew Wilcox recently made similar improvements to the block
>> layer.
>>=20
>> With the advent of 100GbE and Optane-like durable storage, the balance
>> of memory allocation cost to device latency has shifted so that
>> superfluous memory allocation is noticeable.
>>=20
>>=20
>> At first I thought of creating a page allocator API that could grab
>> or free an array of pages while taking the allocator locks once. But
>> now I wonder if there are opportunities to reduce the amount of page
>> allocator traffic.
>=20
> Thanks.  This helps me a lot.
>=20
> I wonder if there is some low-hanging fruit here.
>=20
> If I read the code correctly (which is not certain, but what I see does
> seem to agree with vague memories of how it all works), we currently do
> a lot of wasted alloc/frees for zero-copy reads.
>=20
> We allocate lots of pages and store the pointers in ->rq_respages
> (i.e. ->rq_pages)
> Then nfsd_splice_actor frees many of those pages and
> replaces the pointers with pointers to page-cache pages.  Then we release
> those page-cache pages.
>=20
> We need to have allocated them, but we don't need to free them.
> We can add some new array for storing them, have nfsd_splice_actor move
> them to that array, and have svc_alloc_arg() move pages back from the
> store rather than re-allocating them.
>=20
> Or maybe something even more sophisticated where we only move them out
> of the store when we actually need them.
>=20
> Having the RDMA layer return pages when they are finished with might
> help.  You might even be able to use atomics (cmpxchg) to handle the
> contention.  But I'm not convinced it would be worth it.
>=20
> I *really* like your idea of a batch-API for page-alloc and page-free.
> This would likely be useful for other users, and it would be worth
> writing more code to get peak performance - things such as per-cpu
> queues of returned pages and so-forth (which presumably already exist).

Baby steps.

Because I'm perverse I started with bulk page freeing. In the course
of trying to invent a new API, I discovered there already is a batch
free_page() function called release_pages().

It seems to work as advertised for pages that are truly no longer
in use (ie RPC/RDMA pages) but not for pages that are still in flight
but released (ie TCP pages).

release_pages() chains the pages in the passed-in array onto a list
by their page->lru fields. This seems to be a problem if a page
is still in use.


> I cannot be sure that the batch-API would be better than a focused API
> just for RDMA -> NFSD.  But my guess is that it would be at least nearly
> as good, and would likely get a lot more eyes on the code.
>=20
> NeilBrown

--
Chuck Lever



