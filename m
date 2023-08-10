Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE5D777B7E
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 17:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjHJPBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjHJPBo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 11:01:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E551D26B5
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 08:01:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AEwu3o006044;
        Thu, 10 Aug 2023 15:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ZEVf/Faa6L+zBRL6FXPFwtdUogUi5cer/qExEtlZDpI=;
 b=Lr7mK5OfpsXHvQyLhAXdXq4aBL8e51xWv92zauysmpH3ukiFxUc8+tTGX1LHOBriAiBp
 Oc0UAl/vshfXn5XR3v1MHehXCRBBQjI4ZZeJIUnMhcN/ixOAGdh73ZwIvFR+SFycDEe8
 Q9GbJ6io+Jx5glt6qph78v9ansYB6ylGoFbAAHWUw0vBfqsE89znrJAs+xi1P+9mDcq1
 zqUIwTSBxNROb+cbGFSW2DnbsI3B5JupHdNfsvmLnZBkBzVw0lqS0rlQn3qU/h2X8mUm
 JwoKb0N/hYiBkNog/6lntLQI5G/34m2x438J7k63599PUcSe5qWUwVTe5WSZFlrt1hBi aw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d73kdmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 15:01:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37AEowx1016366;
        Thu, 10 Aug 2023 15:01:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvf4cq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 15:01:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMEuBpesn6YjNLM1qJotqsZBjZK2ZQEJYZiahIhcxCWj8CxUAaWqio60OZ4ugT8/zuKoZ0r8vrrClfNEWnRYyH+55aKdeEM34L0WIzbwbaYTA5mBzESTKNoiOwuBbJihUczfw0k2BRaaKw6JHkaorCCMpBM1zfmU1ReVTXuucrvIeCOetItPnWUKNKVQ41F1Rpn5Cd9jerAWu7FLNT3ZBP2OFXCpFH5xNlyJAUgskbD2D4fAVe/LvGRIby9hJGFE/SJd2hQiI12xQxYZ0b1OoKzcKiCOb+JOOGWOMnKwtC+mle08W/gRvaTQrwpulAKP8uYhpNPSwOMgfAQ6Q2kJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEVf/Faa6L+zBRL6FXPFwtdUogUi5cer/qExEtlZDpI=;
 b=fjsrPExsIYJHmiWDewyjyjKqiP5jPySsn3BrGQjhW6JOvj0LOF4otpIdr46PHi31MP7pYYa1mdZgRswlmjkDur2b2nsRnKa59GQPsEX9UXOmb+p/WI7V4RnyIH0hgGk3qiZi0EujZqJ/UmoavZvhgRl9jKeDNAW1WrTikt7pyJxQmJ8DqWIQ2tuasGiFmLB/b7/zET9ncunNYIBVfKaqMr8hh6X6jIlGFuLbbM2N2s1pISt1CL04W3kgLFgwS9imyBDvCwYBeq4tYxd8y0XGy3JPKAlbrb5diFGXDvgJSXAEv48dfyqd8oZU1jxVVs+EC2IHCY4gMmsOboGYDJDHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEVf/Faa6L+zBRL6FXPFwtdUogUi5cer/qExEtlZDpI=;
 b=bK+Kht/70cRwn39Pk72vYgO4V0bZ6/hmSAl++ST+7ucS9tMBno/j+CoovPeWZUVNfsI4eORR80GkjQJpYVBMW2G4rDSikP6nJ4Ab/dRHu55q6ijwVcDGE+6ov5tNo3HOC3DaUFbtX4lyAzCz/jk01YeHm43pDJzd9gkWKg/BJ2c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7487.namprd10.prod.outlook.com (2603:10b6:208:450::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:01:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:01:25 +0000
Date:   Thu, 10 Aug 2023 11:01:21 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v6 3/3] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZNT7wdG8SYfDRkDg@tissot.1015granger.net>
References: <cover.1691656474.git.lorenzo@kernel.org>
 <177cfd4fc640d9b406101761be24da07990ca81e.1691656474.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177cfd4fc640d9b406101761be24da07990ca81e.1691656474.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:610:4e::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecafbde-0459-4e39-2428-08db99b2aaac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmJNAII/b61tYUQQJhRSyBdlhN0OFJJYQvn3DZPNNCqRZvWBYlIk53SkI6AKmQVx6AjtIdIGEweJAUGS+bxLRHiBawJ3VrboDu7urRglvFtk+HlSlafdYPymtXfDyURElfXFlxS3UeDGaWUpNwvuGxS69M8lL8R4co+Q2nwbasY60K0X1h5EulacK3m6wgFtvxl1pDOr6eTu7XLP4JGoF8bXZ8KQRqjCd1x4/VA04PrCpZCXOz00M+g4Ilawj2TPnOb6+6Zn8X/QFF7/qYFIqIB5Dn5mttV/r9TzRHGUDOgd6clHgPUrVsF3ImEudGEqa4+DjOS1d2GL25w1p71eWx2bg/q9pITzFMqafIxq7++cTgwqSQpf5jobcOfHviy3Tusd/8XL7OCQxHu/wb6CzPwavJTXrkh1UJGeR3xzX4Q2/TEbaWbslH/gZR350VH8059VyybsnRaz6YLr+QwowaIGuYToN8SXqXHT2mgABcbCfqzFEaVhrKgTTrZoCeTJOoWIXmgh5iZ7Pn4acsdimDHXH2OhjzgJ1dABNDYr/eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(186006)(1800799006)(451199021)(30864003)(2906002)(44832011)(86362001)(83380400001)(26005)(6916009)(4326008)(6506007)(38100700002)(478600001)(8936002)(66556008)(66476007)(5660300002)(66946007)(9686003)(6666004)(966005)(6512007)(41300700001)(8676002)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5f7IHQHBamIfBG9JCFkf9hj55gHrlTJMdNrPnN+Nzg2cBZfYl8kfXM98nyBI?=
 =?us-ascii?Q?7ZGj9pIm1FytIycjrdEyQxubNY/bIbq15MJCugGwtM6oydCODTaxJwi2bEoN?=
 =?us-ascii?Q?ACkz0r6FAHC7Y+vM9yIoyqpw6AwR0LjikdgRCMcUbx08WyHF1W3CS3wf1APn?=
 =?us-ascii?Q?2bdVmVom7IPDiEALYoGXOT7sdB4yydiBW1y4XAzjt2sEJGHUeHqBGhZjZPQw?=
 =?us-ascii?Q?PuUaS+ae0PgUPLIfGq8c8D7ZWqTps4edDv4XO2I0VsqxmKOvpat6Cfiu5VyI?=
 =?us-ascii?Q?aIXnJGH1/9ck5jQN5cZRLgSU8AmxP6hUZZWBfA3UB31Xnl8TB1VleXT3sRC0?=
 =?us-ascii?Q?hvx0TRBF8cgIMOBsB0eYwDWdYp13nDsjzmv1a6wW2QQyxHQutYrTRr9jgDce?=
 =?us-ascii?Q?wJlGfCybyFSolc1FdQhX59q7M191wjBM51+fByJNiO3bpAjP+iW5qsEIO7gH?=
 =?us-ascii?Q?wMVV2imFE9lpTWNGLjMYJPrC5YETgVPd1z1872xxixucL8eEOaGPoNzJ2b7B?=
 =?us-ascii?Q?wrfXAENxmw01ZH45QXGeWYkVGSnC6W1yFDSqa8aSW11AMbpU/BIk5/9s64s7?=
 =?us-ascii?Q?AUyl5dMgxekPd0KVuRf5u+63vQPxRnoG5MZUptOTliibcYD5KXgrb06jo0jF?=
 =?us-ascii?Q?qd9FvzeKFBPbfRp59Nk3o8GsaWHTn+6GY2VFqBJzLDmeApzXrlJQCnvqFWHx?=
 =?us-ascii?Q?sq8o+68s2XhNSszXGC1yzVlGjj1h+ymJU6odcXZIAITRu6nvgiZdeaBVQDGg?=
 =?us-ascii?Q?cSJcsMaCD7NaZjb6/ajyuWNsvkAZmC3V/2Q1j4ADqqwQStVe6nIsdXAJs184?=
 =?us-ascii?Q?C7nDs8OIwIBM7eON8Q7cKsoTIQUanr+rw87mQWNWNzijry5zWSeKaXOuwWIH?=
 =?us-ascii?Q?PTh5CMMbiby57mQjr7iDW5auEsTAfgC1fGB+ZP9t+kKwyhyHmQ+19pbGNoJ7?=
 =?us-ascii?Q?5Ot9rcLQhXde/70zdK0SIx7OJEi3jekQaAsg3swX2KRB44mT4O8IVXUUtFFc?=
 =?us-ascii?Q?gJikr3XSKiX5EyU9x7cyydGsOU5wjeGNQE7Z4v+3MvVgg4tw3m8TtPVdEpsX?=
 =?us-ascii?Q?Zg2vq2UK3K/i5UJ1P2RDXxMa4LkrV0z6XAGUps7O7Sv7UR523QQvzYcPBn5V?=
 =?us-ascii?Q?+hPssx3eQ1QsPsRA+XefwQC+k3t0ah2OankzlqjZUf15RGXyE7xqqpjAgw4E?=
 =?us-ascii?Q?oYMLYc0xhyNkHz7c8zfc4NOuc9/WmOTTfvpEDAmMjqscirC1iVOrEks58gP0?=
 =?us-ascii?Q?fU0O4xXTTCpluKmezzEZgEYt0cWfKyTa8PibAiB2g8MHj3XM5/aLTCcpqCpF?=
 =?us-ascii?Q?QmuP5VY8frZhP9T7trcjLTDYh9aqfFe+EZJI+evyT9fdJzThP44grTin2T6w?=
 =?us-ascii?Q?aTKmv/lVDbkBVVenlL7qXaMLMtorY3a/HZXaYn7t+Qy1XOq69xZYfRpaE11V?=
 =?us-ascii?Q?ORprLRbVaQlADz+qJzdA/pj+WonuPB/O5vl4Aacu+/ewfYY/G8GwOd5W+cnT?=
 =?us-ascii?Q?9t/MRO9gZ2Hz+CD0ccPGQclWje9qyNJqmcALJ+vvtLYJ4x/TxCtLWs62Fwy7?=
 =?us-ascii?Q?vufM8y0UH/fBcob9x5JJpwmSFLj0KAVNMUM7twFJQNbVoQU/7YEq2tjkmC/E?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i+9wb/4yg+eZyQ9OhtqMtKTS5gJ+Aw8GLxXZNAmFcBrak6FYV9SjzXT9E4O/PMWBQYzGLvO/TyEoLXDszvkj6Q3ZmU1EKRHHSMBLtxf0htZVhvorJd5XpzxTKIyDksJCPf3vJ5QJCMH77WbMmkNlBPF1MzHnwqh9r0UuEZy3j4EI5WLUhxVB12AfFUdtblLZm2yx6qjnGU2goIvIXsKbEx72VUvX8hBx/++cQBvksb7EMC5u3HEx3lRbSJLHbCysWS/wP2uPsF8Z89z9dDHKDNXjkl97+HG4urb0ouhUIJYlQqUS5tTmFOXQuWj1V993r2x9XwAn7qVzvuHtxn8YU4D0QbPHXqbcTjQphitdpZ4FsYbHXx10oc0VzTcy3LJfuqXHj2ihC9LTVW3UY0S42xVGgK2/w/OJKLLMNMaA0PpIoDb1mY+qZ7ggQLG7tLXxWyGQnC8t4PLovPPj+OcBWTtt2hyrEni3GuEftpU/t1WdXm53frsgzUTKiTb1fJOHmkNiuk51uVRMOF2ltrnCVSksXGVFNicdY95VuJ5i904hp4BruzJoGRuER7aLal5RDL/SmkrXu55vRLhQZZ51/oy6F3p1dbd64664/1F0o2hzGe263A6BiFwF8W9Lv6kGfKQrRVhnnFgxrJbpquiK7sHXGUvcD0BafNq5wpkDAIZ8slBLU3pCPZmuodbvl/3YMv7Yd188Ehybq8+dr7gFrXWbTJLh3WHmL79AZO/wC4AukUJ3nTsD9iGZZW92zTUHJXT/YenjsfJ9LMbFzdvx18Qq1F/+lrDSuihZ2QcPNrBcmhPxICabW3Pqfwck3q9bEfnr9E1CkS4oE2Abx/9nwg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecafbde-0459-4e39-2428-08db99b2aaac
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:01:25.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFKomDmmc6ky8Ct2tNVkcjy7BBgwMQWoJedl1WS5tcGnwsnZ/p2djn7WbNCvKGwF1nqUtdLyFu5j/dWEdt7iSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100128
X-Proofpoint-GUID: SHkvnBkV9gbn1pxOLO0ZqTA27I44dS7Z
X-Proofpoint-ORIG-GUID: SHkvnBkV9gbn1pxOLO0ZqTA27I44dS7Z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 10, 2023 at 10:39:21AM +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status entry in nfsd debug filesystem in order to dump
> pending RPC requests debugging information.
> 
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=366
> Reviewed-by: NeilBrown <neilb@suse.de>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c         |   4 +-
>  fs/nfsd/nfsctl.c           |   9 +++
>  fs/nfsd/nfsd.h             |   7 ++
>  fs/nfsd/nfssvc.c           | 140 +++++++++++++++++++++++++++++++++++++
>  include/linux/sunrpc/svc.h |   1 +
>  net/sunrpc/svc.c           |   2 +-
>  6 files changed, 159 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index aa4f21f92deb..ff5a1dddc0ed 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2496,8 +2496,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
>  
>  static const struct nfsd4_operation nfsd4_ops[];
>  
> -static const char *nfsd4_op_name(unsigned opnum);
> -
>  /*
>   * Enforce NFSv4.1 COMPOUND ordering rules:
>   *
> @@ -3627,7 +3625,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
>  	}
>  }
>  
> -static const char *nfsd4_op_name(unsigned opnum)
> +const char *nfsd4_op_name(unsigned int opnum)
>  {
>  	if (opnum < ARRAY_SIZE(nfsd4_ops))
>  		return nfsd4_ops[opnum].op_name;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index dad88bff3b9e..83eb5c6d894e 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -47,6 +47,7 @@ enum {
>  	NFSD_MaxBlkSize,
>  	NFSD_MaxConnections,
>  	NFSD_Filecache,
> +	NFSD_Rpc_Status,
>  	/*
>  	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
>  	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
> @@ -195,6 +196,13 @@ static inline struct net *netns(struct file *file)
>  	return file_inode(file)->i_sb->s_fs_info;
>  }
>  
> +static const struct file_operations nfsd_rpc_status_operations = {
> +	.open		= nfsd_rpc_status_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= nfsd_stats_release,
> +};
> +
>  /*
>   * write_unlock_ip - Release all locks used by a client
>   *
> @@ -1394,6 +1402,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
>  		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
>  		[NFSD_MaxConnections] = {"max_connections", &transaction_ops, S_IWUSR|S_IRUGO},
>  		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
> +		[NFSD_Rpc_Status] = {"rpc_status", &nfsd_rpc_status_operations, S_IRUGO},
>  #ifdef CONFIG_NFSD_V4
>  		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},
>  		[NFSD_Gracetime] = {"nfsv4gracetime", &transaction_ops, S_IWUSR|S_IRUSR},
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 55b9d85ed71b..3e8a47b93fd4 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
>  int		nfsd_set_nrthreads(int n, int *, struct net *);
>  int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_stats_release(struct inode *, struct file *);
> +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
>  void		nfsd_shutdown_threads(struct net *net);
>  
>  static inline void nfsd_put(struct net *net)
> @@ -511,12 +512,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>  
>  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
>  
> +const char *nfsd4_op_name(unsigned int opnum);
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
>  {
>  	return 0;
>  }
>  
> +static inline const char *nfsd4_op_name(unsigned int opnum)
> +{
> +	return "unknown_operation";
> +}
> +
>  static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
>  
>  #define register_cld_notifier() 0
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 460219030ce1..237be14d3a11 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
>  
> +	/*
> +	 * Release rq_status_counter setting it to an odd value after the rpc
> +	 * request has been properly parsed. rq_status_counter is used to
> +	 * notify the consumers if the rqstp fields are stable
> +	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
> +	 * is even).
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
> +
>  	rp = NULL;
>  	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
> @@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
>  
> +	/*
> +	 * Release rq_status_counter setting it to an even value after the rpc
> +	 * request has been properly processed.
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
> +
>  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> @@ -1101,3 +1116,128 @@ int nfsd_stats_release(struct inode *inode, struct file *file)
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> +
> +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> +{
> +	struct inode *inode = file_inode(m->file);
> +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> +	int i;
> +
> +	seq_puts(m, "# XID FLAGS VERS PROC TIMESTAMP SADDR SPORT DADDR DPORT COMPOUND_OPS\n");
> +
> +	rcu_read_lock();
> +
> +	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			struct {
> +				struct sockaddr daddr;
> +				struct sockaddr saddr;
> +				unsigned long rq_flags;
> +				const char *pc_name;
> +				ktime_t rq_stime;
> +				__be32 rq_xid;
> +				u32 rq_vers;
> +				/* NFSv4 compund */
> +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> +			} rqstp_info;
> +			unsigned int status_counter;
> +			char buf[RPC_MAX_ADDRBUFLEN];
> +			int opcnt = 0;
> +
> +			/*
> +			 * Acquire rq_status_counter before parsing the rqst
> +			 * fields. rq_status_counter is set to an odd value in
> +			 * order to notify the consumers the rqstp fields are
> +			 * meaningful.
> +			 */
> +			status_counter = smp_load_acquire(&rqstp->rq_status_counter);
> +			if (!(status_counter & 1))
> +				continue;
> +
> +			rqstp_info.rq_xid = rqstp->rq_xid;
> +			rqstp_info.rq_flags = rqstp->rq_flags;
> +			rqstp_info.rq_vers = rqstp->rq_vers;
> +			rqstp_info.pc_name = svc_proc_name(rqstp);
> +			rqstp_info.rq_stime = rqstp->rq_stime;
> +			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> +			       sizeof(struct sockaddr));
> +			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> +			       sizeof(struct sockaddr));
> +
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers == NFS4_VERSION &&
> +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */
> +				struct nfsd4_compoundargs *args = rqstp->rq_argp;
> +				int j;
> +
> +				opcnt = args->opcnt;
> +				for (j = 0; j < opcnt; j++) {
> +					struct nfsd4_op *op = &args->ops[j];
> +
> +					rqstp_info.opnum[j] = op->opnum;
> +				}
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +
> +			/*
> +			 * Acquire rq_status_counter before reporting the rqst
> +			 * fields to the user.
> +			 */
> +			if (smp_load_acquire(&rqstp->rq_status_counter) != status_counter)
> +				continue;
> +
> +			seq_printf(m,
> +				   "%04u %04ld NFSv%d %s %016lld",
> +				   be32_to_cpu(rqstp_info.rq_xid),

It's proper to display XIDs as 8-hexit hexadecimal values, as you
did before. "0x%08x" is the correct format, as that matches the
XID display format used by Wireshark and our tracepoints.


> +				   rqstp_info.rq_flags,

I didn't mean for you to change the flags format to decimal. I was
trying to point out that the content of this field will need to be
displayed symbolically if we care about an easy user experience.

Let's stick with hex here. A clever user can read the bits directly
from that. All others should have a tool that parses this field and
prints the list of bits in it symbolically.


> +				   rqstp_info.rq_vers,
> +				   rqstp_info.pc_name,
> +				   ktime_to_us(rqstp_info.rq_stime));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.saddr, buf,
> +						    sizeof(buf), false));
> +			seq_printf(m, " %s",
> +				   __svc_print_addr(&rqstp_info.daddr, buf,
> +						    sizeof(buf), false));
> +			if (opcnt) {
> +				int j;
> +
> +				seq_puts(m, " ");
> +				for (j = 0; j < opcnt; j++)
> +					seq_printf(m, "%s%s",
> +						   nfsd4_op_name(rqstp_info.opnum[j]),
> +						   j == opcnt - 1 ? "" : ":");
> +			} else {
> +				seq_puts(m, " -");
> +			}

This looks correct to me.

I'm leaning towards moving this to a netlink API that can be
extended over time to handle other stats and also act as an NFSD
control plane, similar to other network subsystems.

Any comments, complaints or rotten fruit from anyone?


> +			seq_puts(m, "\n");
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
> + * @inode: entry inode pointer.
> + * @file: entry file pointer.
> + *
> + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs handler.
> + * nfsd_rpc_status dumps pending RPC requests info queued into nfs server.
> + */
> +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> +{
> +	int ret = nfsd_stats_open(inode);
> +
> +	if (ret)
> +		return ret;
> +
> +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> +}
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 7838b37bcfa8..b49c0470b4fe 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -251,6 +251,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	unsigned int		rq_status_counter; /* RPC processing counter */
>  };
>  
>  /* bits for rq_flags */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index af692bff44ab..83bee19df104 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1656,7 +1656,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
>  		return rqstp->rq_procinfo->pc_name;
>  	return "unknown";
>  }
> -
> +EXPORT_SYMBOL_GPL(svc_proc_name);
>  
>  /**
>   * svc_encode_result_payload - mark a range of bytes as a result payload
> -- 
> 2.41.0
> 

-- 
Chuck Lever
