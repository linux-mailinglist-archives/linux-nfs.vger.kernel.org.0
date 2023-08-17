Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE477F972
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbjHQOm6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352233AbjHQOm4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 10:42:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CBB3AB5
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 07:42:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCOGd8004079;
        Thu, 17 Aug 2023 14:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+he6FwE8im2UigXqJtnWFYrAMZBy0P+eJvTsWDNQJPE=;
 b=AHRvWiHfgA4HA4tdhd/Phb9TAx9tXg/YR4CKeI+/vw4RS8Y/fVfIzckvKzUMCPfw6/Uh
 gcXQyUnm98wmlUa8I9WGe3ly714HD0Hsv5XeVGzsy5hoINQ8v4HKjzZi7bi2HnDzqhZJ
 HhPpNAHPV244G7g7mtZmii0AGQ3CCUVAyyBncfSn6Qi3R8LKdDyvP1aDKRvnVDc+aiu7
 WBU4FHMbTxYXYyb39Zs4POXXjm6pyJUCCI8C+XKJA63lVSdcMpo99SfpEWSiWC2J/74b
 kM1V3US8odXSyl1xlVuCbL31imF5xYLkoJEYfW766DxT6H/4tmNt0LBoJukOhzSWOD1e xg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y31qe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:41:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HDvAjc003884;
        Thu, 17 Aug 2023 14:41:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexympxqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 14:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSJGeDYsZTIOV1UEfWPMHyRJMt4AkZkAdHKtYzTrvm+GSoGnpUgvgaTJhKVirVFfK5V9f079iHPekRXaD/lTLwc90q+RqJ7FB55KFA7xXsgtAVXImH/xAXE8nE9pnm7NobSUi91Jb9bn18PYKDaf4Zy/ZF16FfMjBjp3SdBdVbdD+hxJd9KXraLgXdmjnfLzyV5E0qcIEmq3IH6GbGKzPhvixyajdoqbzavjdmIwKnPixfyKq/4Fg7iwHUr/uSs/Br8TxcElXxwIMPLhDrZvpXOdQYScduD3j+D88FX5/bqfJlngbMzHdBoIzvr6Cl9Oc8jil2q/MZcdVIqxCaJVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+he6FwE8im2UigXqJtnWFYrAMZBy0P+eJvTsWDNQJPE=;
 b=K1Wp77Yc43s/gTsOdcxScICA5X7KalnWrVpL+qHynNVapm3PDqZAEdHmNrEzsmwsAAbSLZNqZqybjxo2YD3YVNegiSPkQYl/5Hp0hXUEkRh7zTCCpN2WlXGCsdl3kn48quSCydm/QNcO4CZbCFvSi5EnPQHptNYiCR+1jGenDul5NOWtjB5f/yLovuIvYAex87EsauX5CPYCLVrJWgCu/23FOncO8MZLX3zb+BESNf0otjz95x8ox1VEfJJgGwkxfp+k2APw2qNE1y3N57PwYAH94ui6+cNcqlWrJalHPP40CMItpIcFFEfUcpPN7t2toKHzL7G+dwExo/VeZaDDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+he6FwE8im2UigXqJtnWFYrAMZBy0P+eJvTsWDNQJPE=;
 b=on+9VFP52vyjR/FFzr3gr8Dq2Gx5sFUNrbQ+9+utUgdgP1Ob/e0nPss58PRm6YfM9nDZ/HLZncLMb/oUlr3Ml08uOB/eYbrpe27Pebh3Bo/r8qDZ54hkVMdcVLqJgGdCaeiNRcIkhE+fJOjAPnhbP0GDC+hzcQuQyPbvZRaW1wE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 14:41:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:41:06 +0000
Date:   Thu, 17 Aug 2023 10:41:04 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/10] SUNRPC/svc: add light-weight queuing mechanism.
Message-ID: <ZN4xgOjEIDe0rX3i@tissot.1015granger.net>
References: <20230815015426.5091-1-neilb@suse.de>
 <20230815015426.5091-7-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815015426.5091-7-neilb@suse.de>
X-ClientProxiedBy: CH2PR19CA0007.namprd19.prod.outlook.com
 (2603:10b6:610:4d::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 55560743-9c21-4097-0aad-08db9f2ffd52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qZ1PySHktpBcn/46nZfjlHtRAMjvpOb5w71DtkA8klb/1XsWDVdC3xrUjPBMUur07Zaut9BcFosdQJLaE/MHDntcncNng1knvQc43ZNAwvPS76h84JTA9QW0fsUhHVPPKhpy2UsdvQiY/vLBqHYzud2hqV8bt+CY//sRhiJFGT/nhYDAOae31cvvIQPt2+WxbefQgNHBQ27n3W7mhJr3Z8IUZS2oSEzUg42jlO8Xds5csRSXP4N9+RMKx3MUc65F23p+DbtwZfxE2aZ+SAnp/KodNw77CuS5yzHM2efageFPlUyHM7hFtxmaByHWt9bGsnojSwM5GDhzphFeurhU/8+wOsVJc5ZcIuU2KcCOuuIhb+zMZCREuVh24kRiljt+Jm46Vs6Aeda+06Tt23ECw1na7wkhN1lsmKvn2C54iSAozhNyE0Ec4e53hK87jSo5QdBVaazgiFwnW5WI8BcB4dZcwQ9C0o/+7/awxYTo2vjupJw8MC55dHz12lj1GCRNGyMxgKx9wtNiY1CToYVp72hu0zcEiHY3DmPHzKvEqcB+oWG5HkNODPtpkGHHijdhoLRPe2DoO1sqeUnnzSDZpuQYYVdie3AFVU7nQ2LEdS+kKSyBg3zvp32N9bvdUFt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6486002)(6512007)(9686003)(44832011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(38100700002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FxX3T84d4HiHlzASGdu1s94A+GD4QDWX/XjG4bX+vMKzO8/cwqSxiN0VwOgU?=
 =?us-ascii?Q?PE4Z7vz1VkzJ5OHlDs/TScwjjX8tjw0aUh1r4qkuk6g74S7o1AArB7I5oV5Z?=
 =?us-ascii?Q?I9a9NwyZYPY/uVyQLYRQKLsa6C6hYwVsIZs49PalyIEjQymuH/EI+5pz9Ife?=
 =?us-ascii?Q?WWSj3Hd8vXnx1BeLzAAtEyh20Y28pb0hb0mBQBC63F2Oj7EKY7AaRLbdeNyd?=
 =?us-ascii?Q?tCBp8LxUQQp2s9h/yvwan+PtOPTNkSmu0ZwJ6Ljs3mu2YqpMxm43V7aIHPex?=
 =?us-ascii?Q?4B3ynj2LqSSgIEPzPbK1SWRyaA482qyI6Hy6RCt0HpTwLp4TO3LY3XbmuR1x?=
 =?us-ascii?Q?fwsl3IqOLwqFJpiDVa5QfbmtpHR0Sm2SIFpWTrEL7vtpdquO/BJgjnV5F2ot?=
 =?us-ascii?Q?87ciLlv6v5zBXzOWl1lJ/5hcB2OzavwShShgiVIFNPemfh25LWLF79rWvPY/?=
 =?us-ascii?Q?ckX6V9G70/WgTPE6CM1YWNy9276hOJr07krOMwRtkrzSFfSui2FyX9ESpT10?=
 =?us-ascii?Q?IhgCDXf5J5/tMvs6jF8C0ZTnsUmTIgTIb+ioj8hn3vGWIFEphs8YMnFJZOaX?=
 =?us-ascii?Q?TTihuAZqgS8kKTuPNdWbp7KrNKFmTTdY+vHJmmZW/krx9+5NbRlgs9Wr3oKV?=
 =?us-ascii?Q?BJhguYSoSU6s8n0jyqVzN8BKQhrbkgT5yiQ2bJjugL2t/a+p7EY3I3GneOxe?=
 =?us-ascii?Q?/B0FETDBdxx3pdeQvU70iCsaxeTj9nWXj1qLOaAbZiAwUPS4kQ37AlhPIdXO?=
 =?us-ascii?Q?qIbbeQDMfWNO6YgyF9GggXYbf6Me7C8ujav5LHTYDuHVamle2/BX284vk4C4?=
 =?us-ascii?Q?tyLxq8ZywwLKiTd9qyodgwMbhxS0jFyoHOpWKIn0zwXlemgzAbV/oFx7wn9b?=
 =?us-ascii?Q?qiWI96RHFiiRcV5PwwQa+KXU0LJXtPBvp5jL/auizsyYOjOpuEiXbAmf/zoy?=
 =?us-ascii?Q?Owv75Y/Hzx5mlLFjo93tH9ijymhNN9Zs0yIzQuSBaEVJ5b5lTHj21w6nVbML?=
 =?us-ascii?Q?L1VJsZtlGtnTgakK3PXTYd4zHLPTR0kDluITxPeBzcgnumy8PDda64DsQh8z?=
 =?us-ascii?Q?r9ho+BpEGNCazz3GVAgHc5AUBQGVabANWHgRJ1TZqcXm3OW8/QoObVNOoI29?=
 =?us-ascii?Q?emyUCQ2UnxILxQZGc1P0O9FODk5RWc+G1YxgjjZ5TcTE41RkmeoqxuVSOL+S?=
 =?us-ascii?Q?0+aHFc/PTtPlylvVMl1bAhavZyBmEgn6sAuGn8TtQpG28m0yorPxETMD18OP?=
 =?us-ascii?Q?wo7shWm1v6ieCA3erYCjCtHXtbmwb42FLcWSB8igcfSk8Kh2VXcgF7BBPirW?=
 =?us-ascii?Q?nl0fwUOK+taJOwzblqSw8HVlWlB+7INuuIvRuhi2Ml22cQenmY+63fTCMPNK?=
 =?us-ascii?Q?4SOnxiME7piTiLJylQAbSdPKpqPvQ+1Sy4c61zR22jvAOXuaaXDHYXmah4b2?=
 =?us-ascii?Q?y6cOF6FERsWRWgjYx0DiYknqbgmb7LFUsx0NR5j1SjBQtLMzcA72b83+mqEG?=
 =?us-ascii?Q?4WKZ/4T0kr66khLkuTAKbCvrcuzgtUDGxZ/6S+zN5WHkb4dr/NEQTyRZLgmb?=
 =?us-ascii?Q?/q0rUk5E/oaUB9aTLQU5/DudfLF6u070XDhLeLYUSYiB1sD+JxATSAhCtVB9?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VpIbnYtviNEuzPdRURWY0BXAk+ApNTbHGUdCoFn2ontsPMsdNRBwSqDP3W+/PUZ/dCxvLmt3MLMKAD76RoZgadO+GhVOS6b5bT9OJfTzi5Qi429geHFqEGFZ74A+iSDkH4cUhRWSwPTw8920mcMmY2NJDXayv2htNSjgxWCGxJsbL2zzSF1gMIrU++ZKIdCzNuDJG7me3JP39if6cYAtYP7o8En0ZhTMetfQcX9vhrluPDF+K8IM52SGbR/7P0VNOaFSZHt8EPZZN5jHj/23wApPlFLLpyn4/M7/bpjyNTGiVURunfsvMVVOAgePZdGsrG7BITLhTnfuo4JgpjnS5JeLZE4KFX10wl13789ZUxgvv3UsooDloAHEh7NrRaWzEMI5KQCGgFpew7f4fJXkH1swSmM5LXUJE3zQS/dJ2X7DapeAX2V0HHH7kd8c0AC31R8MrKswHCkd4P6OF8ziXc9Ec3VH4QmtQ8nJyar+U31nQyN5ZM5eWzSIWKRKUHFVZjbWOQJHjZ9o0rrkxrptF8ryAKnmML7FHRmPEY0H+bPzvcbeNlxupLwGTxV73UAeJFBoUqtz7ZVlBO5BJ5q+S04cIFtqpmL3A/3GvkSZhIjQ9Xh6Rk8NunH3z268j/g7KHV7hrJdGQj7yP6rKFP+f8sdx5HI/9iuHHuojBoc9QPMidhnOrlPxO8ObI15PtpLDPDi2/ZYWuoKOVzDLuU5xwTnZKC8iyBcWs2524oPpQxtd7VVpHqOPhln5Jgc7FfndI/e+8LYFFw+RPQSorVpS+zz36tnWKcv2STBxaSscDDJ89zyOwNKEIPk3XXTidcN
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55560743-9c21-4097-0aad-08db9f2ffd52
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:41:06.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVTmp27RETzk1tGIg1nEcxZ88z9k7UZs/OAr0gOVPbJjIwup6cyLbw0gCf0emPbCgv92UY2R4BoJR/lYCf2Klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_09,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170130
X-Proofpoint-ORIG-GUID: BMFtftN1uwZV1WFs_caPB3k_rX51WbJt
X-Proofpoint-GUID: BMFtftN1uwZV1WFs_caPB3k_rX51WbJt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 15, 2023 at 11:54:22AM +1000, NeilBrown wrote:
> lwq is a FIFO single-linked queue that only requires a spinlock
> for dequeueing, which happens in process context.  Enqueueing is atomic
> with no spinlock and can happen in any context.
> 
> Include a unit test for basic functionality - runs a boot/module-load
> time.  Does not use kunit framework.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc_lwq.h |  79 +++++++++++++++++++

I'm wondering what your longer-term intentions are for this new
mechanism. If it is only useful for SunRPC, then perhaps this
header belongs under net/sunrpc instead.


>  net/sunrpc/Kconfig             |   6 ++
>  net/sunrpc/Makefile            |   2 +-
>  net/sunrpc/svc_lwq.c           | 135 +++++++++++++++++++++++++++++++++
>  4 files changed, 221 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/sunrpc/svc_lwq.h
>  create mode 100644 net/sunrpc/svc_lwq.c
> 
> diff --git a/include/linux/sunrpc/svc_lwq.h b/include/linux/sunrpc/svc_lwq.h
> new file mode 100644
> index 000000000000..4bd6cbffa155
> --- /dev/null
> +++ b/include/linux/sunrpc/svc_lwq.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef SUNRPC_SVC_LWQ_H
> +#define SUNRPC_SVC_LWQ_H
> +
> +/*
> + * light-weight single linked queue
> + *
> + * Entries can be enqueued from any context with no locking.
> + * Entries can be dequeued from process context with integrated locking.
> + *
> + */
> +#include <linux/container_of.h>
> +#include <linux/spinlock.h>
> +#include <linux/llist.h>
> +
> +struct lwq_node {
> +	struct llist_node node;
> +};
> +
> +struct lwq {
> +	spinlock_t		lock;
> +	struct llist_node	*ready;		/* entries to be dequeued */
> +	struct llist_head	new;		/* entries being enqueued */
> +};
> +
> +static inline void lwq_init(struct lwq *q)
> +{
> +	spin_lock_init(&q->lock);
> +	q->ready = NULL;
> +	init_llist_head(&q->new);
> +}
> +
> +static inline bool lwq_empty(struct lwq *q)
> +{
> +	return READ_ONCE(q->ready) == NULL && llist_empty(&q->new);
> +}
> +
> +struct llist_node *__lwq_dequeue(struct lwq *q);
> +#define lwq_dequeue(_q, _type, _member)					\
> +	({ struct llist_node *_n = __lwq_dequeue(_q);			\
> +	  _n ? container_of(_n, _type, _member.node) : NULL; })
> +
> +struct llist_node *lwq_dequeue_all(struct lwq *q);
> +
> +/**
> + * lwq_for_each_safe: iterate over detached queue allowing deletion
> + * @_n:		iterator variable
> + * @_t1:	temporary struct llist_node **
> + * @_t2:	temporary struct llist_node *
> + * @_l:		address of llist_node pointer from lwq_dequeue_all()
> + * @_member:	member in _n where lwq_node is found.
> + *
> + * Iterate over members in a dequeued list.  If the iterator variable
> + * is set to NULL, the iterator removes that entry from the queue.
> + */
> +#define lwq_for_each_safe(_n, _t1, _t2, _l, _member)			\
> +	for (_t1 = (_l);						\
> +	     *(_t1) ? (_n = container_of(*(_t1), typeof(*(_n)), _member.node),\
> +		       _t2 = ((*_t1)->next),				\
> +		       true)						\
> +	     : false;							\
> +	     (_n) ? (_t1 = &(_n)->_member.node.next, 0)			\
> +	     : ((*(_t1) = (_t2)),  0))
> +
> +static inline bool lwq_enqueue(struct lwq_node *n, struct lwq *q)
> +{
> +	return llist_add(&n->node, &q->new) && READ_ONCE(q->ready) == NULL;
> +}
> +
> +static inline bool lwq_enqueue_batch(struct llist_node *n, struct lwq *q)
> +{
> +	struct llist_node *e = n;
> +
> +	return llist_add_batch(llist_reverse_order(n), e, &q->new) &&
> +		READ_ONCE(q->ready) == NULL;
> +}
> +
> +#endif /* SUNRPC_SVC_LWQ_H */
> diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
> index 2d8b67dac7b5..5de87d005962 100644
> --- a/net/sunrpc/Kconfig
> +++ b/net/sunrpc/Kconfig
> @@ -115,3 +115,9 @@ config SUNRPC_XPRT_RDMA
>  
>  	  If unsure, or you know there is no RDMA capability on your
>  	  hardware platform, say N.
> +
> +config SUNRPC_LWQ_TEST
> +	bool "RPC: enable boot-time test for lwq queuing"
> +	depends on SUNRPC
> +	help
> +          Enable boot-time test of lwq functionality.
> diff --git a/net/sunrpc/Makefile b/net/sunrpc/Makefile
> index f89c10fe7e6a..b224cba1d0da 100644
> --- a/net/sunrpc/Makefile
> +++ b/net/sunrpc/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_SUNRPC_XPRT_RDMA) += xprtrdma/
>  
>  sunrpc-y := clnt.o xprt.o socklib.o xprtsock.o sched.o \
>  	    auth.o auth_null.o auth_tls.o auth_unix.o \
> -	    svc.o svcsock.o svcauth.o svcauth_unix.o \
> +	    svc.o svc_lwq.o svcsock.o svcauth.o svcauth_unix.o \
>  	    addr.o rpcb_clnt.o timer.o xdr.o \
>  	    sunrpc_syms.o cache.o rpc_pipe.o sysfs.o \
>  	    svc_xprt.o \
> diff --git a/net/sunrpc/svc_lwq.c b/net/sunrpc/svc_lwq.c
> new file mode 100644
> index 000000000000..528ad7e3abb1
> --- /dev/null
> +++ b/net/sunrpc/svc_lwq.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Light weight single-linked queue.
> + *
> + * Entries are enqueued to the head of an llist, with no blocking.
> + * This can happen in any context.
> + *
> + * Entries are dequeued using a spinlock to protect against
> + * multiple access.  The llist is staged in reverse order, and refreshed
> + * from the llist when it exhausts.
> + */
> +#include <linux/rcupdate.h>
> +#include <linux/sunrpc/svc_lwq.h>
> +
> +struct llist_node *__lwq_dequeue(struct lwq *q)
> +{
> +	struct llist_node *this;
> +
> +	if (lwq_empty(q))
> +		return NULL;
> +	spin_lock(&q->lock);
> +	this = q->ready;
> +	if (!this)
> +		this = llist_reverse_order(llist_del_all(&q->new));
> +	if (this)
> +		q->ready = llist_next(this);
> +	spin_unlock(&q->lock);
> +	return this;
> +}
> +
> +struct llist_node *lwq_dequeue_all(struct lwq *q)
> +{
> +	struct llist_node *r, *t, **ep;
> +
> +	if (lwq_empty(q))
> +		return NULL;
> +
> +	spin_lock(&q->lock);
> +	r = q->ready;
> +	q->ready = NULL;
> +	t = llist_del_all(&q->new);
> +	spin_unlock(&q->lock);
> +	ep = &r;
> +	while (*ep)
> +		ep = &(*ep)->next;
> +	*ep = llist_reverse_order(t);
> +	return r;
> +}
> +
> +#if IS_ENABLED(CONFIG_SUNRPC_LWQ_TEST)
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/wait_bit.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +struct tnode {
> +	struct lwq_node n;
> +	int i;
> +	int c;
> +};
> +
> +static int lwq_exercise(void *qv)
> +{
> +	struct lwq *q = qv;
> +	int cnt;
> +	struct tnode *t;
> +
> +	for (cnt = 0; cnt < 10000; cnt++) {
> +		wait_var_event(q, (t = lwq_dequeue(q, struct tnode, n)) != NULL);
> +		t->c++;
> +		if (lwq_enqueue(&t->n, q))
> +			wake_up_var(q);
> +	}
> +	wait_var_event(q, kthread_should_stop());
> +	return 0;
> +}
> +
> +static int lwq_test(void)
> +{
> +	int i;
> +	struct lwq q;
> +	struct llist_node *l, **t1, *t2;
> +	struct tnode *t;
> +	struct task_struct *threads[8];
> +
> +	printk(KERN_INFO "testing lwq....\n");
> +	lwq_init(&q);
> +	printk(KERN_INFO " lwq: run some threads\n");
> +	for (i = 0; i < ARRAY_SIZE(threads); i++)
> +		threads[i] = kthread_run(lwq_exercise, &q, "lwq_test-%d", i);
> +	for (i = 0; i < 100; i++) {
> +		t = kmalloc(sizeof(*t), GFP_KERNEL);
> +		t->i = i;
> +		t->c = 0;
> +		if (lwq_enqueue(&t->n, &q))
> +			wake_up_var(&q);
> +	};
> +	/* wait for threads to exit */
> +	for (i = 0; i < ARRAY_SIZE(threads); i++)
> +		if (!IS_ERR_OR_NULL(threads[i]))
> +			kthread_stop(threads[i]);
> +	printk(KERN_INFO " lwq: dequeue first 50:");
> +	for (i = 0; i < 50 ; i++) {
> +		if (i && (i % 10) == 0) {
> +			printk(KERN_CONT "\n");
> +			printk(KERN_INFO " lwq: ... ");
> +		}
> +		t = lwq_dequeue(&q, struct tnode, n);
> +		printk(KERN_CONT " %d(%d)", t->i, t->c);
> +		kfree(t);
> +	}
> +	printk(KERN_CONT "\n");
> +	l = lwq_dequeue_all(&q);
> +	printk(KERN_INFO " lwq: delete the multiples of 3 (test lwq_for_each_safe())\n");
> +	lwq_for_each_safe(t, t1, t2, &l, n) {
> +		if ((t->i % 3) == 0) {
> +			t->i = -1;
> +			kfree(t);
> +			t = NULL;
> +		}
> +	}
> +	if (l)
> +		lwq_enqueue_batch(l, &q);
> +	printk(KERN_INFO " lwq: dequeue remaining:");
> +	while ((t = lwq_dequeue(&q, struct tnode, n)) != NULL) {
> +		printk(KERN_CONT " %d", t->i);
> +		kfree(t);
> +	}
> +	printk(KERN_CONT "\n");
> +	return 0;
> +}
> +
> +module_init(lwq_test);
> +#endif /* CONFIG_SUNRPC_LWQ_TEST*/
> -- 
> 2.40.1
> 

-- 
Chuck Lever
