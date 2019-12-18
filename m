Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E7C12548C
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 22:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfLRVZi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 16:25:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50438 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfLRVZi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 16:25:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBIL9t1e196548;
        Wed, 18 Dec 2019 21:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=MeQ7gM7fMAu+a5pmH9KpcNjG1CUHFxDWDrbqJUdVyzM=;
 b=FkP17N7gITsVb3/zLQntfe8uBo59gvanRDe/108tV8MvzAehE6ZxUHwVp71aXDMp15Jg
 jo2Qrtm0f45WRZ/fXy3BEx099rfsDa9lSpMfuiKwEnt6+ajNgnJt5bXY+rj/QEMBOJ1r
 VLa9tsuHyg20fAtvAdZA/e4ljS1x5N9jQvDHmGnxo5xrxTV6/xIuxWtC733u9Gn2DOQi
 1bbG6WVNY2K/Bqcd0ZZM4rcRst4UeHd6HutjAa4Xdt90Ce4v/awHdUT/DLPpuFdY+AKe
 d+T573BoRK5d1JSnFrkAGPnZyZSoy0swKxZTVvhjOiaJmpj5G5UxH4sHZDic6t8nJZIU cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wvrcrg5nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 21:25:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBILAhoq186441;
        Wed, 18 Dec 2019 21:25:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2wyut48eea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 21:25:31 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBILPQww014407;
        Wed, 18 Dec 2019 21:25:27 GMT
Received: from mbp2018.cdmnet.org (/82.27.120.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 13:25:26 -0800
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] NFSv4.x recover from pre-mature loss of openstateid
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
References: <20191218211327.30362-1-olga.kornievskaia@gmail.com>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Message-ID: <e7a2973e-f4bc-a0b4-537d-49857c8b9e03@oracle.com>
Date:   Wed, 18 Dec 2019 21:25:23 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:73.0)
 Gecko/20100101 Thunderbird/73.0a1
MIME-Version: 1.0
In-Reply-To: <20191218211327.30362-1-olga.kornievskaia@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912180163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912180163
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

hi Olga…

On 18/12/2019 9:13 pm, Olga Kornievskaia wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
> 
> Ever since the commit 0e0cb35b417f, it's possible to lose an open stateid
> while retrying a CLOSE due to ERR_OLD_STATEID. Once that happens,
> operations that require openstateid fail with EAGAIN which is propagated
> to the application then tests like generic/446 and generic/168 fail with
> "Resource temporarily unavailable".
> 
> Instead of returning this error, initiate state recovery when possible to
> recover the open stateid and then try calling nfs4_select_rw_stateid()
> again.
> 
> Fixes: 0e0cb35b417f ("NFSv4: Handle NFS4ERR_OLD_STATEID in CLOSE/OPEN_DOWNGRADE")
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>   fs/nfs/nfs42proc.c | 36 ++++++++++++++++++++++++++++--------
>   fs/nfs/nfs4proc.c  |  2 ++
>   fs/nfs/pnfs.c      |  2 +-
>   3 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 1fe83e0f663e..9637aad36bdc 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -61,8 +61,11 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
>   
>   	status = nfs4_set_rw_stateid(&args.falloc_stateid, lock->open_context,
>   			lock, FMODE_WRITE);
> -	if (status)
> +	if (status) {
> +		if (status == -EAGAIN)
> +			status = -NFS4ERR_BAD_STATEID;
>   		return status;
> +	}
>   
>   	res.falloc_fattr = nfs_alloc_fattr();
>   	if (!res.falloc_fattr)
> @@ -287,8 +290,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>   	} else {
>   		status = nfs4_set_rw_stateid(&args->src_stateid,
>   				src_lock->open_context, src_lock, FMODE_READ);
> -		if (status)
> +		if (status) {
> +			if (status == -EAGAIN)
> +				status = -NFS4ERR_BAD_STATEID;
>   			return status;
> +		}
>   	}
>   	status = nfs_filemap_write_and_wait_range(file_inode(src)->i_mapping,
>   			pos_src, pos_src + (loff_t)count - 1);
> @@ -297,8 +303,11 @@ static ssize_t _nfs42_proc_copy(struct file *src,
>   
>   	status = nfs4_set_rw_stateid(&args->dst_stateid, dst_lock->open_context,
>   				     dst_lock, FMODE_WRITE);
> -	if (status)
> +	if (status) {
> +		if (status == -EAGAIN)
> +			status = -NFS4ERR_BAD_STATEID;
>   		return status;
> +	}
>   
>   	status = nfs_sync_inode(dst_inode);
>   	if (status)
> @@ -546,8 +555,11 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
>   	status = nfs4_set_rw_stateid(&args->cna_src_stateid, ctx, l_ctx,
>   				     FMODE_READ);
>   	nfs_put_lock_context(l_ctx);
> -	if (status)
> +	if (status) {
> +		if (status == -EAGAIN)
> +			status = -NFS4ERR_BAD_STATEID;
>   		return status;
> +	}
>   
>   	status = nfs4_call_sync(src_server->client, src_server, &msg,
>   				&args->cna_seq_args, &res->cnr_seq_res, 0);
> @@ -618,8 +630,11 @@ static loff_t _nfs42_proc_llseek(struct file *filep,
>   
>   	status = nfs4_set_rw_stateid(&args.sa_stateid, lock->open_context,
>   			lock, FMODE_READ);
> -	if (status)
> +	if (status) {
> +		if (status == -EAGAIN)
> +			status = -NFS4ERR_BAD_STATEID;
>   		return status;
> +	}
>   
>   	status = nfs_filemap_write_and_wait_range(inode->i_mapping,
>   			offset, LLONG_MAX);
> @@ -994,13 +1009,18 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
>   
>   	status = nfs4_set_rw_stateid(&args.src_stateid, src_lock->open_context,
>   			src_lock, FMODE_READ);
> -	if (status)
> +	if (status) {
> +		if (status == -EAGAIN)
> +			status = -NFS4ERR_BAD_STATEID;
>   		return status;
> -
> +	}
>   	status = nfs4_set_rw_stateid(&args.dst_stateid, dst_lock->open_context,
>   			dst_lock, FMODE_WRITE);
> -	if (status)
> +	if (status) {
> +		if (status == -EAGAIN)
> +			status = -NFS4ERR_BAD_STATEID;
>   		return status;
> +	}
>   
>   	res.dst_fattr = nfs_alloc_fattr();
>   	if (!res.dst_fattr)
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 76d37161409a..f9bb4b43a519 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -3239,6 +3239,8 @@ static int _nfs4_do_setattr(struct inode *inode,
>   		nfs_put_lock_context(l_ctx);
>   		if (status == -EIO)
>   			return -EBADF;
> +		else if (status == -EAGAIN)
> +			goto zero_stateid;
>   	} else {
>   zero_stateid:
>   		nfs4_stateid_copy(&arg->stateid, &zero_stateid);
> diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
> index cec3070ab577..fc36a60bf4ec 100644
> --- a/fs/nfs/pnfs.c
> +++ b/fs/nfs/pnfs.c
> @@ -1998,7 +1998,7 @@ pnfs_update_layout(struct inode *ino,
>   			trace_pnfs_update_layout(ino, pos, count,
>   					iomode, lo, lseg,
>   					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
> -			if (status != -EAGAIN)
> +			if (status != -EAGAIN && status != -EAGAIN)

that doesn't look quite right?

>   				goto out_unlock;
>   			spin_unlock(&ino->i_lock);
>   			nfs4_schedule_stateid_recovery(server, ctx->state);
> 


