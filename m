Return-Path: <linux-nfs+bounces-4163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40693910BE1
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 18:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50B02871D9
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B01B3724;
	Thu, 20 Jun 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jMOUnED4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812001B14E6;
	Thu, 20 Jun 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900288; cv=none; b=AUXn1Am+oT1w4eAFV4OtkjuMhW5TGGz+XExoPvzkUHjXqVydBW4Gg1FrNdAesxGNvDzuNxjIPHBcshdcMuhL/ga9Uuz+V6bvplP3uRCq9Yp5zCbyurvClKm83rNldBo0Ccb2TVs6dRl5ffNNmegXnNu4RjStwFQIUbqR4gmsI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900288; c=relaxed/simple;
	bh=1dFUQMCGHMZ3LH1izFqUEiTLo9GXkX0FPQTOZy4JQLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X4JwbZHuR3an8YRIiBleNbKkhiXvJCnaHEEaSuwOlO/Cequ7n17NxW303wXl/TvXj3fnLqdS8SlOf2K/YoRPOzU4FUw1faQHSmRzM51UIFyrGuJ+nxhIe6lIfRkgzizEppZWTZpHJePntgHFJb2Am2/Tiq54gO7b7w+na58cAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jMOUnED4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KDmDh7024158;
	Thu, 20 Jun 2024 16:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	av3bSper8XkT24kJs48B9E2HUSJzvcJCEJjAApE39x4=; b=jMOUnED4vp+wo05D
	4McItidBwVJpHr/Cbn4xX/L+A3ufy+62FguwPoTjFDs7KIjJzyvYSiE77Y150yGB
	1R8mYt2nkNovr+XXA54CtWXpDl6RBTaumvCAcCX1tu6qXM0Bw0OGcJ6pABTuNPyi
	4KKO/I/UzA0d0Gbh++qhxtDL9plcW51JNeKSBHbx9gw5b9NV0u2LQhkm93KTY/j2
	2XiWazIR5a/l8Nd3QfEr5rYAwcsGg6RYV/MlbInhvRuAv7CpLz055sesC6SzlcdX
	ialkYun0VYHmj1iRMNfn9tYrSRJlfLvsnnINctS49JAN4ZOz5EDkTxEJYIhhtSyT
	kdinXA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvnmh8d7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:17:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGHq1n019100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:17:52 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:17:51 -0700
Message-ID: <0284e6be-a176-48a6-a99b-82ed4ad1a910@quicinc.com>
Date: Thu, 20 Jun 2024 09:17:50 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: nfs: add missing MODULE_DESCRIPTION() macros
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker
	<anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Christian Brauner <brauner@kernel.org>,
        "Alexander Viro,"
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240527-md-fs-nfs-v1-1-64a15e9b53a6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p8-5mBJJaexEwGfLCKtSoV561Moqotdh
X-Proofpoint-GUID: p8-5mBJJaexEwGfLCKtSoV561Moqotdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200117

On 5/27/24 10:58, Jeff Johnson wrote:
> Fix the 'make W=1' warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs_common/nfs_acl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs_common/grace.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv2.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv3.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   fs/nfs/inode.c         | 1 +
>   fs/nfs/nfs2super.c     | 1 +
>   fs/nfs/nfs3super.c     | 1 +
>   fs/nfs/nfs4super.c     | 1 +
>   fs/nfs_common/grace.c  | 1 +
>   fs/nfs_common/nfsacl.c | 1 +
>   6 files changed, 6 insertions(+)
> 
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index acef52ecb1bb..57c473e9d00f 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2538,6 +2538,7 @@ static void __exit exit_nfs_fs(void)
>   
>   /* Not quite true; I just maintain it */
>   MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
> +MODULE_DESCRIPTION("NFS client support");
>   MODULE_LICENSE("GPL");
>   module_param(enable_ino64, bool, 0644);
>   
> diff --git a/fs/nfs/nfs2super.c b/fs/nfs/nfs2super.c
> index 467f21ee6a35..b1badc70bd71 100644
> --- a/fs/nfs/nfs2super.c
> +++ b/fs/nfs/nfs2super.c
> @@ -26,6 +26,7 @@ static void __exit exit_nfs_v2(void)
>   	unregister_nfs_version(&nfs_v2);
>   }
>   
> +MODULE_DESCRIPTION("NFSv2 client support");
>   MODULE_LICENSE("GPL");
>   
>   module_init(init_nfs_v2);
> diff --git a/fs/nfs/nfs3super.c b/fs/nfs/nfs3super.c
> index 8a9be9e47f76..20a80478449e 100644
> --- a/fs/nfs/nfs3super.c
> +++ b/fs/nfs/nfs3super.c
> @@ -27,6 +27,7 @@ static void __exit exit_nfs_v3(void)
>   	unregister_nfs_version(&nfs_v3);
>   }
>   
> +MODULE_DESCRIPTION("NFSv3 client support");
>   MODULE_LICENSE("GPL");
>   
>   module_init(init_nfs_v3);
> diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
> index 8da5a9c000f4..b29a26923ce0 100644
> --- a/fs/nfs/nfs4super.c
> +++ b/fs/nfs/nfs4super.c
> @@ -332,6 +332,7 @@ static void __exit exit_nfs_v4(void)
>   	nfs_dns_resolver_destroy();
>   }
>   
> +MODULE_DESCRIPTION("NFSv4 client support");
>   MODULE_LICENSE("GPL");
>   
>   module_init(init_nfs_v4);
> diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
> index 1479583fbb62..8f034aa8c88b 100644
> --- a/fs/nfs_common/grace.c
> +++ b/fs/nfs_common/grace.c
> @@ -139,6 +139,7 @@ exit_grace(void)
>   }
>   
>   MODULE_AUTHOR("Jeff Layton <jlayton@primarydata.com>");
> +MODULE_DESCRIPTION("lockd and nfsv4 grace period control");
>   MODULE_LICENSE("GPL");
>   module_init(init_grace)
>   module_exit(exit_grace)
> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
> index 5a5bd85d08f8..ea382b75b26c 100644
> --- a/fs/nfs_common/nfsacl.c
> +++ b/fs/nfs_common/nfsacl.c
> @@ -29,6 +29,7 @@
>   #include <linux/nfs3.h>
>   #include <linux/sort.h>
>   
> +MODULE_DESCRIPTION("NFS ACL support");
>   MODULE_LICENSE("GPL");
>   
>   struct nfsacl_encode_desc {
> 
> ---
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> change-id: 20240527-md-fs-nfs-42f19eb60b50
> 

Adding core fs maintainers.
Following up to see if anything else is needed to get this merged.


