Return-Path: <linux-nfs+bounces-8240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555559DB0A9
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 02:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3E0166476
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Nov 2024 01:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C4419BBC;
	Thu, 28 Nov 2024 01:18:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3B17753;
	Thu, 28 Nov 2024 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732756695; cv=none; b=k6wGDddzwGAFWTPjh6T+L64qq5oYsd89VbWGx8LpbfX4qbyyRSuxoH9xoNPwoSuN32yuPPzo9S9+HU/xprgs8+1gtNSrwqED7L9bcCiXHlbaSWlUy+wz1OH3UVPs6Lu3AN7gRxLv+SmSw13qDjRY9VAzARXafKXOoWbbT3p79lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732756695; c=relaxed/simple;
	bh=EDsgf28RLqRnZDZV/6+IhfEfEenTkUqLlA3rEKCmld0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQtRAwJP4pdcvSF3Mxog7cYWCYVAtObZ9cje3VXwc45aXD6ZpMr+DfcOS84qSqKk7RtmBweEWAcK7YJJju587UpWxbqvUMxsezbXsJtNBZ7wOOZyD9Noj2c7NCXkhFOJ4UMeGnG1lW/WbZXAy9nOqgQSl3ZFA1v+ePi41emOWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XzJL56Vtsz21m0y;
	Thu, 28 Nov 2024 09:16:29 +0800 (CST)
Received: from dggpeml500004.china.huawei.com (unknown [7.185.36.140])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D3721400D5;
	Thu, 28 Nov 2024 09:18:00 +0800 (CST)
Received: from [10.174.179.184] (10.174.179.184) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 09:17:59 +0800
Message-ID: <93fd0f1c-812f-4393-ad73-4d07ecebf979@huawei.com>
Date: Thu, 28 Nov 2024 09:17:55 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfsd: set acl_access/acl_default after getting successful
To: Li Lingfeng <lilingfeng@huaweicloud.com>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<Trond.Myklebust@netapp.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng3@huawei.com>
References: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500004.china.huawei.com (7.185.36.140)

there is one case when disk error cause get_inode_acl(inode, 
ACL_TYPE_DEFAULT) return EIO,
resp->acl_access will not be null. posix_acl_release(resp->acl_default) 
will trigger this warning.


> If getting acl_default fails, acl_access and acl_default will be released
> simultaneously. However, acl_access will still retain a pointer pointing
> to the released posix_acl, which will trigger a WARNING in
> nfs3svc_release_getacl like this:
>
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
> refcount_warn_saturate+0xb5/0x170
> Modules linked in:
> CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
> 6.12.0-rc6-00079-g04ae226af01f-dirty #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xb5/0x170
> Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
> e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
> cd 0f b6 1d 8a3
> RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
> RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
> R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
> R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
> FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   ? refcount_warn_saturate+0xb5/0x170
>   ? __warn+0xa5/0x140
>   ? refcount_warn_saturate+0xb5/0x170
>   ? report_bug+0x1b1/0x1e0
>   ? handle_bug+0x53/0xa0
>   ? exc_invalid_op+0x17/0x40
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? tick_nohz_tick_stopped+0x1e/0x40
>   ? refcount_warn_saturate+0xb5/0x170
>   ? refcount_warn_saturate+0xb5/0x170
>   nfs3svc_release_getacl+0xc9/0xe0
>   svc_process_common+0x5db/0xb60
>   ? __pfx_svc_process_common+0x10/0x10
>   ? __rcu_read_unlock+0x69/0xa0
>   ? __pfx_nfsd_dispatch+0x10/0x10
>   ? svc_xprt_received+0xa1/0x120
>   ? xdr_init_decode+0x11d/0x190
>   svc_process+0x2a7/0x330
>   svc_handle_xprt+0x69d/0x940
>   svc_recv+0x180/0x2d0
>   nfsd+0x168/0x200
>   ? __pfx_nfsd+0x10/0x10
>   kthread+0x1a2/0x1e0
>   ? kthread+0xf4/0x1e0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> Clear acl_access/acl_default first and set both of them only when both
> ACLs are successfully obtained.
>
> Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
> Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
> ---
>   fs/nfsd/nfs3acl.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 5e34e98db969..17579a032a5b 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -29,10 +29,12 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
>   {
>   	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
>   	struct nfsd3_getaclres *resp = rqstp->rq_resp;
> -	struct posix_acl *acl;
> +	struct posix_acl *acl = NULL, *dacl = NULL;
>   	struct inode *inode;
>   	svc_fh *fh;
>   
> +	resp->acl_access = NULL;
> +	resp->acl_default = NULL;
>   	fh = fh_copy(&resp->fh, &argp->fh);
>   	resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
>   	if (resp->status != nfs_ok)
> @@ -56,19 +58,19 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
>   			resp->status = nfserrno(PTR_ERR(acl));
>   			goto fail;
>   		}
> -		resp->acl_access = acl;
>   	}
>   	if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
>   		/* Check how Solaris handles requests for the Default ACL
>   		   of a non-directory! */
> -		acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
> -		if (IS_ERR(acl)) {
> -			resp->status = nfserrno(PTR_ERR(acl));
> +		dacl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
> +		if (IS_ERR(dacl)) {
> +			resp->status = nfserrno(PTR_ERR(dacl));
>   			goto fail;
>   		}
> -		resp->acl_default = acl;
>   	}
>   
> +	resp->acl_access = acl;
> +	resp->acl_default = dacl;
>   	/* resp->acl_{access,default} are released in nfs3svc_release_getacl. */
>   out:
>   	return rpc_success;

