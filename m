Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9B4AC49E
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiBGP54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 10:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384420AbiBGPxX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 10:53:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87FC0401CC;
        Mon,  7 Feb 2022 07:53:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217De92n008232;
        Mon, 7 Feb 2022 15:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZeH5qhsLKtWw0S/TGg8T2TAQMTffJGtl6r9o+qVtIwE=;
 b=UhqQK5H7qPRwPM2lltx/YZqoQNt/Cw23kmMhkj0YxjfhWuG4t7FFhwU4uHHpVJgdA7iT
 nyXKWWS4BEfO5LLr8MjTACU75Gi0ZHUhoDFTsuVNbICCrEU/ScVzFUhAvVF19x1LljDY
 eY0wTi4QxfEVrxTjoD86w7xYnaBx4FyM6eckTlpOVrcAhMwemO4Sxy/oBfE/BXxiO7Pq
 n32JF1FmhVnpHmKxg7nw0GTlH4nqxTAELu5mul4LW07DqedRzfztQ0HN4GjgoijkOcK8
 WftwFKnJanbNppBd899/tVFo9IY6G+Ej6WCpb4J6W2+Mx6pzNAb4fzXmwV3uKh3TMPX7 IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fu2ppr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 15:53:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217Fk2bo088891;
        Mon, 7 Feb 2022 15:53:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3030.oracle.com with ESMTP id 3e1f9djj4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 15:53:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqEbaKAO2chJBdwbjicMRtZJRUKOTB9STpRkAv87e3Lh0NeX05QoLPPm+WSuDaQWNpuKXNz3u2r9vRwU4WjpTwQ/cr0gBl2lvIewG+Loj49HAMHbVG6RgAgDSDFrUnxtyLtuTL0lyU2luHIXEBWT6kR01JhIFFfZKGjIJWepWwtA1ykAi6Za38t33bVRWEnVcXquAo6G8IQLAV1R4nrWq3ompVzonzloNi5bi5DKwF+Nn73RO3JA3+AMPQsBPkxrXG5pggO66xhB1wRzWqNuD/WQ1byaepqdkoZ3M2G0tSBEJDuE0puzMfa7+XFe92FmbQOegnLeT/m4uIGMxgFqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeH5qhsLKtWw0S/TGg8T2TAQMTffJGtl6r9o+qVtIwE=;
 b=OuECPDXVaFYyHHURzSWcIz8EHcTZjexwlnzG+UWT/O3TlEP44qEcVNIuthu0syf3jeIusDLsXyEd+hTwdG8NLHmtg61XxNQ5CFbosepF0MyI47gSQnv9dNe+qRR6XJGX3GN8G6ptnORZlTKw/Fbimjl/t3j84WioPydInSo/aEskxGOKKxERiZ89KprqFsko0XKmX+rY1MjHnRPpSyx5AJGMQ/JUg9hxJxY687J4NV+vbAlrimrRI6X0Gukh1XWmtBMRgBgt1LeRLtG9ZUAiep/qp2XRTZdNuFTgCO0bZOKxNTTXDGrvzFes5RakH3lE8P+qzXCXuQYESoPM7D/Hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeH5qhsLKtWw0S/TGg8T2TAQMTffJGtl6r9o+qVtIwE=;
 b=Ne740SOYGp1wyS4luFhCNTuugD/iDv+cfSZ5tyDB2ZJEsxCeSMni+dbtB44g6ShpcXrL/oz4ik68HEifQHGOEAsgunFD5bJJhfCPgyreEbnWWErGPSrx4DyELceuDMJxhKtX0eUjWDt2NxxVtYE0ellCKcHNjBCKVAXq57kbFuQ=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by DM6PR10MB3163.namprd10.prod.outlook.com (2603:10b6:5:1a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:53:02 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 15:53:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/21] SUNRPC: improve 'swap' handling: scheduling and
 PF_MEMALLOC
Thread-Topic: [PATCH 17/21] SUNRPC: improve 'swap' handling: scheduling and
 PF_MEMALLOC
Thread-Index: AQHYG94BVCu8bHRAZ0KRlArQjI71z6yIPdWA
Date:   Mon, 7 Feb 2022 15:53:02 +0000
Message-ID: <6E3E6EB3-6235-4498-A8FE-495D9357CEBB@oracle.com>
References: <164420889455.29374.17958998143835612560.stgit@noble.brown>
 <164420916122.29374.8760841832230503670.stgit@noble.brown>
In-Reply-To: <164420916122.29374.8760841832230503670.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae34d280-fc11-4d92-eccc-08d9ea51ec03
x-ms-traffictypediagnostic: DM6PR10MB3163:EE_
x-microsoft-antispam-prvs: <DM6PR10MB316379C156C9DB81DDA42AE4932C9@DM6PR10MB3163.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /r/3FgGt3oJQsUHmM4m15nJuAV++ZFa6W6VPC7CEMlvyCRPDuGE3LehIB9n58gZ+kFQY1qGu+SVSkT9UN5Gawc/3sAztpPZhJMiR8v7XaLXlGVqj/aa5XwTWE9baR/PHFLAckwnpP0IuPALo0X8ErIvYstgGA2Ef2W9mnFVkWRC1+lnNF44qRDH//cjhX4qqQRcmCvt4bShFqWzCvIimrKyY/01+ULnyzuPUxyrsY9RlYsy1+rqq50OKudM5P1v/AL4wPeoG12fJqb0uq02Ty/5RX75LUXQqz60VHGRS4RvqJjaOyPlICAxc0ZNrCiekjNwdQKxhFAgIg7V/7H1BvIKg+VGkKM4RNI7sCR+rDSuVaWlAUlVZUBwEd/7U1N0nEcSFxkDwyQrL7zlUql69fujbJdqa9e2evfJzZcjmRHEEtQQjUAIFhM6y0xIo5I4asf7BQi2mpMCvFOFeyu5tOUuvk3uu4PLGP5VTPhMyLc6OPLFu8G6ymgjSm9w/vJiB4/dUwhBs7EnLNZH1ZdmyfrytP8djW2cLdx4wTPOxb6FPJJQ8G0LcLU4EFVVcXLnY0VhXkZgxfXSmwp4IgNqrn9C8hceY8XQSQELGhwGcFu0b0TX9lavcUsBJfNAjdsSLI/ZM3O2Brrn9+2CJkCMg++tHXV3qSfi3eYDK/CtsEn6eXYBOOXhsiExuKy0VsavAOqtsJLjBIwBGc/iWmy3J1wc4WBrgi1zGsk3pnQ8OTpAZTo7wPA9/73csVUuRt45H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(508600001)(6916009)(36756003)(38100700002)(2906002)(6486002)(76116006)(66476007)(26005)(66946007)(83380400001)(38070700005)(5660300002)(66556008)(122000001)(66446008)(8936002)(4326008)(33656002)(71200400001)(8676002)(2616005)(64756008)(86362001)(53546011)(186003)(7416002)(6506007)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V79Vv9ZFcihklU2hBBzSFzEq+WSHThn2KeFbwoQwQaZs1WccIZgmP7dU4F7n?=
 =?us-ascii?Q?6WzyNvC+j/4XdWJrxnyK4MBtMkYc0KUn2EpgcAfDFCbKnS1DxmEdqbxxYyUf?=
 =?us-ascii?Q?sem/CxPrpCZpKEz3R3+pZZBBM4ZA3hbHmy7edOaUsL7zsSguNPQ9JY4aSrTs?=
 =?us-ascii?Q?ZdB4VOWz6X0qoVglrsw8NpzgXZYWrcZ1Kg/p5ppeBxSaqvdDPPcGXBVVit+B?=
 =?us-ascii?Q?Ci+6uTwm9MHqPtaGvXEPBMiAGisZrnkg0dkVWC8z4qrs7+jD4dDiTnGE9PoG?=
 =?us-ascii?Q?9/37ZbLwIamSTjVA0m+69bmFH09Y4EojE7FUbJQ5pj9WiOgKfkNQCW0C5+fR?=
 =?us-ascii?Q?P9JvM26jtyJA3aDJYsLs+0q4mOAed+a0EhNNiVdiawsFysV85DWi5dOP4Smr?=
 =?us-ascii?Q?tAdwqmEkfERQpiDW058pXdZL7zLF9r3mFuZSQL9jVu1UUN1WYxwH3ItwCIax?=
 =?us-ascii?Q?quUVH/UXvh5zzdwzgw2YTKBm7FhlztRkR2h8pt8PPpWrquXYGq4r4BU449GN?=
 =?us-ascii?Q?VmwZw4MiNJhFCUGlU5kniFjlMgeguJxozRdc0MUQglOsCZ4uLuHkHemh3BAa?=
 =?us-ascii?Q?JEO43fGbsshBXBXddrgvnWWUi+NokX52RWx/pMrSpOOvK9LUby6WJKV8BnQj?=
 =?us-ascii?Q?SXZ+KzFFqIYdMKgX7n5tyBJcXTR37V0jPGF14YDJ3YaSl4Uo1fBYhWwXTs/g?=
 =?us-ascii?Q?fWO2fNuIIwhq9L33gmwJZSrFFbCfmfXfH/YnoQ5Gw+hlaL4GvSZGB50zQDKS?=
 =?us-ascii?Q?VDNOE3W4E1Y5Mfq2cOajUTvNIQrovkxFgLcLaAlkqY/JbRx8yKdFM6+bfO0h?=
 =?us-ascii?Q?nlvCFMLnaoLXFyIfmZFPRtd5yuWQP8eH72Z0rb08iOeUDpRXcEbv4Z+kp5/H?=
 =?us-ascii?Q?nI4dinJaT/ulCsskhrS9ePnyBUcfTyR2uLNU16yLY3dFrLWRJNFyiV3qWxsT?=
 =?us-ascii?Q?2LZhmhZ4ENKedHCaPZlQSqtN2BPo4HuHQk3m4Lz9wXMqFz8RXnsQ4r4Z193y?=
 =?us-ascii?Q?F8wBg7yOXrJPcmhiWm8nCWnrRNmmESqpr67W2kyesJxl69rVc6/zQ9nNund5?=
 =?us-ascii?Q?D7gIIyeDDg2iUPDhpBOLs6l/Mcg/BhayZevy7Hp2OPrxdV3IvAd87lXLgksI?=
 =?us-ascii?Q?lWT3jgsmNbZYOPRlH9X2FzY0Ni0FP7fOPSBRlht1epBRMaBsysELIb87Tw0Z?=
 =?us-ascii?Q?ON3+vEXu+60bt/SbC9V+IwCS6UftWA1Q/YPQBSdGRsIXSIdCyssxPzkqXvOF?=
 =?us-ascii?Q?Zm/GjMsEYTA3DmxAG8okUjnFbGRzMhqT143zUFsGOq4utGed3DWkYT9QArq4?=
 =?us-ascii?Q?sQGBFakc7QeZ7K7BQEJ69G/sNEKJ9Db1d+XkDCHetbR05n1qs5KYs2nOUY9v?=
 =?us-ascii?Q?Fmo45ESegSnNsf6ESeXbpCDDprlETlFFFar5kGMjbUB2wFqrr1557BNDbv1J?=
 =?us-ascii?Q?ng4r6H5H28IMqUIGFspSE8Wzs64Wbp1U90A4lS++SCib1pQMEkKmAzxtPiHV?=
 =?us-ascii?Q?rodbm7OMQk8y00KEGtB86vQu3O4HTGjGnHt3SydsekJ0uk1tdxnJtC0XLlT6?=
 =?us-ascii?Q?TSmiQ97AyGn4iKj/elg9uJw3eYBP3XY7e9x1oMeZUkQZlPNJBKXbjrMIexuc?=
 =?us-ascii?Q?vNmwvw9LF78WfTDiyDeeapc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <289317D10D85214A85766F8E61DE7563@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae34d280-fc11-4d92-eccc-08d9ea51ec03
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 15:53:02.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5y8ZFeWhlsPrATaj5Y93WPa6tYxe5Sora+rfhXaXxuVgyr/IsSfb/1vO6+hJIe9jwx/oXWYEayMmk+F2e7Rdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3163
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070101
X-Proofpoint-ORIG-GUID: r4vY5c2KiqNznBsc5itB_CPbuOYFF5Xm
X-Proofpoint-GUID: r4vY5c2KiqNznBsc5itB_CPbuOYFF5Xm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 6, 2022, at 11:46 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> rpc tasks can be marked as RPC_TASK_SWAPPER.  This causes GFP_MEMALLOC
> to be used for some allocations.  This is needed in some cases, but not
> in all where it is currently provided, and in some where it isn't
> provided.
>=20
> Currently *all* tasks associated with a rpc_client on which swap is
> enabled get the flag and hence some GFP_MEMALLOC support.
>=20
> GFP_MEMALLOC is provided for ->buf_alloc() but only swap-writes need it.
> However xdr_alloc_bvec does not get GFP_MEMALLOC - though it often does
> need it.
>=20
> xdr_alloc_bvec is called while the XPRT_LOCK is held.  If this blocks,
> then it blocks all other queued tasks.  So this allocation needs
> GFP_MEMALLOC for *all* requests, not just writes, when the xprt is used
> for any swap writes.
>=20
> Similarly, if the transport is not connected, that will block all
> requests including swap writes, so memory allocations should get
> GFP_MEMALLOC if swap writes are possible.
>=20
> So with this patch:
> 1/ we ONLY set RPC_TASK_SWAPPER for swap writes.
> 2/ __rpc_execute() sets PF_MEMALLOC while handling any task
>    with RPC_TASK_SWAPPER set, or when handling any task that
>    holds the XPRT_LOCKED lock on an xprt used for swap.
>    This removes the need for the RPC_IS_SWAPPER() test
>    in ->buf_alloc handlers.
> 3/ xprt_prepare_transmit() sets PF_MEMALLOC after locking
>    any task to a swapper xprt.  __rpc_execute() will clear it.
> 3/ PF_MEMALLOC is set for all the connect workers.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Thanks for including xprtrdma in the patch. Those changes
look consistent with the xprtsock hunks.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> fs/nfs/write.c                  |    2 ++
> net/sunrpc/clnt.c               |    2 --
> net/sunrpc/sched.c              |   20 +++++++++++++++++---
> net/sunrpc/xprt.c               |    3 +++
> net/sunrpc/xprtrdma/transport.c |    6 ++++--
> net/sunrpc/xprtsock.c           |    8 ++++++++
> 6 files changed, 34 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 987a187bd39a..9f7176745fef 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1409,6 +1409,8 @@ static void nfs_initiate_write(struct nfs_pgio_head=
er *hdr,
> {
> 	int priority =3D flush_task_priority(how);
>=20
> +	if (IS_SWAPFILE(hdr->inode))
> +		task_setup_data->flags |=3D RPC_TASK_SWAPPER;
> 	task_setup_data->priority =3D priority;
> 	rpc_ops->write_setup(hdr, msg, &task_setup_data->rpc_client);
> 	trace_nfs_initiate_write(hdr);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index d1fb7c0c7685..842366a2fc57 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1085,8 +1085,6 @@ void rpc_task_set_client(struct rpc_task *task, str=
uct rpc_clnt *clnt)
> 		task->tk_flags |=3D RPC_TASK_TIMEOUT;
> 	if (clnt->cl_noretranstimeo)
> 		task->tk_flags |=3D RPC_TASK_NO_RETRANS_TIMEOUT;
> -	if (atomic_read(&clnt->cl_swapper))
> -		task->tk_flags |=3D RPC_TASK_SWAPPER;
> 	/* Add to the client's list of all tasks */
> 	spin_lock(&clnt->cl_lock);
> 	list_add_tail(&task->tk_task, &clnt->cl_tasks);
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index 256302bf6557..9020cedb7c95 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -869,6 +869,15 @@ void rpc_release_calldata(const struct rpc_call_ops =
*ops, void *calldata)
> 		ops->rpc_release(calldata);
> }
>=20
> +static bool xprt_needs_memalloc(struct rpc_xprt *xprt, struct rpc_task *=
tk)
> +{
> +	if (!xprt)
> +		return false;
> +	if (!atomic_read(&xprt->swapper))
> +		return false;
> +	return test_bit(XPRT_LOCKED, &xprt->state) && xprt->snd_task =3D=3D tk;
> +}
> +
> /*
>  * This is the RPC `scheduler' (or rather, the finite state machine).
>  */
> @@ -877,6 +886,7 @@ static void __rpc_execute(struct rpc_task *task)
> 	struct rpc_wait_queue *queue;
> 	int task_is_async =3D RPC_IS_ASYNC(task);
> 	int status =3D 0;
> +	unsigned long pflags =3D current->flags;
>=20
> 	WARN_ON_ONCE(RPC_IS_QUEUED(task));
> 	if (RPC_IS_QUEUED(task))
> @@ -899,6 +909,10 @@ static void __rpc_execute(struct rpc_task *task)
> 		}
> 		if (!do_action)
> 			break;
> +		if (RPC_IS_SWAPPER(task) ||
> +		    xprt_needs_memalloc(task->tk_xprt, task))
> +			current->flags |=3D PF_MEMALLOC;
> +
> 		trace_rpc_task_run_action(task, do_action);
> 		do_action(task);
>=20
> @@ -936,7 +950,7 @@ static void __rpc_execute(struct rpc_task *task)
> 		rpc_clear_running(task);
> 		spin_unlock(&queue->lock);
> 		if (task_is_async)
> -			return;
> +			goto out;
>=20
> 		/* sync task: sleep here */
> 		trace_rpc_task_sync_sleep(task, task->tk_action);
> @@ -960,6 +974,8 @@ static void __rpc_execute(struct rpc_task *task)
>=20
> 	/* Release all resources associated with the task */
> 	rpc_release_task(task);
> +out:
> +	current_restore_flags(pflags, PF_MEMALLOC);
> }
>=20
> /*
> @@ -1018,8 +1034,6 @@ int rpc_malloc(struct rpc_task *task)
>=20
> 	if (RPC_IS_ASYNC(task))
> 		gfp =3D GFP_NOWAIT | __GFP_NOWARN;
> -	if (RPC_IS_SWAPPER(task))
> -		gfp |=3D __GFP_MEMALLOC;
>=20
> 	size +=3D sizeof(struct rpc_buffer);
> 	if (size <=3D RPC_BUFFER_MAXSIZE)
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index a0a2583fe941..0614e7463d4b 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1492,6 +1492,9 @@ bool xprt_prepare_transmit(struct rpc_task *task)
> 		return false;
>=20
> 	}
> +	if (atomic_read(&xprt->swapper))
> +		/* This will be clear in __rpc_execute */
> +		current->flags |=3D PF_MEMALLOC;
> 	return true;
> }
>=20
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transp=
ort.c
> index 923e4b512ee9..6b7e10e5a141 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -235,8 +235,11 @@ xprt_rdma_connect_worker(struct work_struct *work)
> 	struct rpcrdma_xprt *r_xprt =3D container_of(work, struct rpcrdma_xprt,
> 						   rx_connect_worker.work);
> 	struct rpc_xprt *xprt =3D &r_xprt->rx_xprt;
> +	unsigned int pflags =3D current->flags;
> 	int rc;
>=20
> +	if (atomic_read(&xprt->swapper))
> +		current->flags |=3D PF_MEMALLOC;
> 	rc =3D rpcrdma_xprt_connect(r_xprt);
> 	xprt_clear_connecting(xprt);
> 	if (!rc) {
> @@ -250,6 +253,7 @@ xprt_rdma_connect_worker(struct work_struct *work)
> 		rpcrdma_xprt_disconnect(r_xprt);
> 	xprt_unlock_connect(xprt, r_xprt);
> 	xprt_wake_pending_tasks(xprt, rc);
> +	current_restore_flags(pflags, PF_MEMALLOC);
> }
>=20
> /**
> @@ -572,8 +576,6 @@ xprt_rdma_allocate(struct rpc_task *task)
> 	flags =3D RPCRDMA_DEF_GFP;
> 	if (RPC_IS_ASYNC(task))
> 		flags =3D GFP_NOWAIT | __GFP_NOWARN;
> -	if (RPC_IS_SWAPPER(task))
> -		flags |=3D __GFP_MEMALLOC;
>=20
> 	if (!rpcrdma_check_regbuf(r_xprt, req->rl_sendbuf, rqst->rq_callsize,
> 				  flags))
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 69b6ee5a5fd1..c461a0ce9531 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2047,7 +2047,10 @@ static void xs_udp_setup_socket(struct work_struct=
 *work)
> 	struct rpc_xprt *xprt =3D &transport->xprt;
> 	struct socket *sock;
> 	int status =3D -EIO;
> +	unsigned int pflags =3D current->flags;
>=20
> +	if (atomic_read(&xprt->swapper))
> +		current->flags |=3D PF_MEMALLOC;
> 	sock =3D xs_create_sock(xprt, transport,
> 			xs_addr(xprt)->sa_family, SOCK_DGRAM,
> 			IPPROTO_UDP, false);
> @@ -2067,6 +2070,7 @@ static void xs_udp_setup_socket(struct work_struct =
*work)
> 	xprt_clear_connecting(xprt);
> 	xprt_unlock_connect(xprt, transport);
> 	xprt_wake_pending_tasks(xprt, status);
> +	current_restore_flags(pflags, PF_MEMALLOC);
> }
>=20
> /**
> @@ -2226,7 +2230,10 @@ static void xs_tcp_setup_socket(struct work_struct=
 *work)
> 	struct socket *sock =3D transport->sock;
> 	struct rpc_xprt *xprt =3D &transport->xprt;
> 	int status;
> +	unsigned int pflags =3D current->flags;
>=20
> +	if (atomic_read(&xprt->swapper))
> +		current->flags |=3D PF_MEMALLOC;
> 	if (!sock) {
> 		sock =3D xs_create_sock(xprt, transport,
> 				xs_addr(xprt)->sa_family, SOCK_STREAM,
> @@ -2291,6 +2298,7 @@ static void xs_tcp_setup_socket(struct work_struct =
*work)
> 	xprt_clear_connecting(xprt);
> out_unlock:
> 	xprt_unlock_connect(xprt, transport);
> +	current_restore_flags(pflags, PF_MEMALLOC);
> }
>=20
> /**
>=20
>=20

--
Chuck Lever



