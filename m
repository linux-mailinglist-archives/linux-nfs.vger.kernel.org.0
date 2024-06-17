Return-Path: <linux-nfs+bounces-3902-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6E90B2E7
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00EB1F262B5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2E1C8FC4;
	Mon, 17 Jun 2024 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="puKWe5LW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35249198E9F;
	Mon, 17 Jun 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632449; cv=none; b=Pgn+KJMfxHJM+37BwcyyFkqsYgj0C7IsCqkLaHPWx22oSDgVbSlB6RXctKM5VImttKN6GszhJiedde5kpdj/7z6eTsWTA0qOwDE81OFWtX4XVjVzQgLebWbs8W9FK94JEWqTWv+fE1HZ17blUFTb6vX/Uq5PidizRVy/fAlL2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632449; c=relaxed/simple;
	bh=2MPnAz6vZV4CVtI9QpFVH8cHiuhbHrxIPWdcQgsPZa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxCGlTPjekX1KsK3VF/Jukce7n8AiEwgdGUHCVi9o5tFqHIWd/CTosj12jDMWTgFcG3hh7qVGjaboefy5128GfAw0M8YleggxLC+vTgldF1Ah8JVVzALsNaagNgn4tNuowczMtBKvui3Xps0AnafuyJT5DEbp/qk2ppMwf13q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=puKWe5LW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HCTsYi006730;
	Mon, 17 Jun 2024 13:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=j
	vVqQQBnWkNMvfMwHN58UAbqX4cO+LpI6I1rVUfUXNw=; b=puKWe5LWfCsyH/NxE
	tofu2d0586D0DO6CHkiLdxCD/lt9xeLgxi2g4itKUpegudKx5y/XHaEsKK8HYt23
	ojKYC3ATOHmeqV2KvGoOicRVP+gBEgHuXdjgq8Wq6edPqG1Lc0d0Wn3Bi/baS6cv
	q/WmWIx2GljLzUP/HyHwqd8vTw3jmfbYabtbyU1HEZnHmCUMiE5xRjBbyaD2dqJi
	CyulvPAYKT+0yjV479Zpq4kk8cHDadf1CYYixe6Q8au3L4nPmIseYbsIu61p7HN6
	cBViQkGaPsJnyrYt9bJlC9r0x+BkQNJwpOtDr2oIbhZ+GIPuOtDItXWCVDWf1zE2
	P5z/w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ytn6j86k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:53:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45HDITd3019506;
	Mon, 17 Jun 2024 13:53:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp0ts81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:53:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45HDrokZ54395340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 13:53:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258632004B;
	Mon, 17 Jun 2024 13:53:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5311620040;
	Mon, 17 Jun 2024 13:53:47 +0000 (GMT)
Received: from [9.43.117.91] (unknown [9.43.117.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Jun 2024 13:53:46 +0000 (GMT)
Message-ID: <1786d5aa-2474-4bd3-92ee-c5a880a37728@linux.ibm.com>
Date: Mon, 17 Jun 2024 19:23:45 +0530
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: fix oops when reading pool_stats before server is
 started
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240617-nfsd-next-v1-1-5833b297015a@kernel.org>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240617-nfsd-next-v1-1-5833b297015a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ALCnmHpe_2LBQ6inmQFo0H-5gLV0bc3Y
X-Proofpoint-ORIG-GUID: ALCnmHpe_2LBQ6inmQFo0H-5gLV0bc3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_11,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170104

Hello Jeff,

With the below fix applied, the issue is not observed.
Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for the fix.

- Sourabh Jain

On 17/06/24 17:24, Jeff Layton wrote:
> Sourbh reported an oops that is triggerable by trying to read the
> pool_stats procfile before nfsd had been started. Move the check for a
> NULL serv in svc_pool_stats_start above the mutex acquisition, and fix
> the stop routine not to unlock the mutex if there is no serv yet.
>
> Fixes: 7b207ccd9833 ("svc: don't hold reference for poolstats, only mutex.")
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   net/sunrpc/svc_xprt.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index d3735ab3e6d1..b757a8891813 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1422,12 +1422,13 @@ static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
>   
>   	dprintk("svc_pool_stats_start, *pidx=%u\n", pidx);
>   
> +	if (!si->serv)
> +		return NULL;
> +
>   	mutex_lock(si->mutex);
>   
>   	if (!pidx)
>   		return SEQ_START_TOKEN;
> -	if (!si->serv)
> -		return NULL;
>   	return pidx > si->serv->sv_nrpools ? NULL
>   		: &si->serv->sv_pools[pidx - 1];
>   }
> @@ -1459,7 +1460,8 @@ static void svc_pool_stats_stop(struct seq_file *m, void *p)
>   {
>   	struct svc_info *si = m->private;
>   
> -	mutex_unlock(si->mutex);
> +	if (si->serv)
> +		mutex_unlock(si->mutex);
>   }
>   
>   static int svc_pool_stats_show(struct seq_file *m, void *p)
>
> ---
> base-commit: 4ddfda417a50309f17aeb85f8d1a9a9efbc7d81c
> change-id: 20240617-nfsd-next-8593f73544f5
>
> Best regards,


