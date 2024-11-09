Return-Path: <linux-nfs+bounces-7817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A139C2980
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 03:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFCB21DD0
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 02:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2B2BB09;
	Sat,  9 Nov 2024 02:28:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36517BA3;
	Sat,  9 Nov 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119339; cv=none; b=Jaaqf74DjXN8a0qsISywH+4eV4I5wb9IMz2bF4tDCoQZVJnDtoeC1UaVnPtlRkwOV4iIbxcXoXtbnbm2qZpGGjkcAqqfu7MSqpRKMyuuUnukdeQC6cn2gvpOh5+MF3oa7wqCfYbOW/bSuVoltvdatXzFN5UWRbfbzkETgASegNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119339; c=relaxed/simple;
	bh=wvFd1tZmndC7o8xnNugPRtmTmqP0DzsUqnLZ0/EnKjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R7T1nzqzVXp8DmLfd30GsL8frCAtLh9KT94gwG2Gf2DXsWoq3AZjqaYxka0Woww09idPXqBAiIZwhBA/1TF1uGbNeaonl0y2Pj9e29JJmzd38FCWAfSaXtlBXHyoAM4zTn28bP9lJl+PjZkfJUKyxsqHAc0gI+sK47/jJSAsk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XlfpH2kV2z1SDYT;
	Sat,  9 Nov 2024 10:27:03 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 698971400DA;
	Sat,  9 Nov 2024 10:28:48 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 Nov 2024 10:28:47 +0800
Message-ID: <a5d8d58f-9b4a-d260-744a-6afae3a7452c@huawei.com>
Date: Sat, 9 Nov 2024 10:28:46 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nfsd: set acl_access/acl_default after getting successful
To: Li Lingfeng <lilingfeng@huaweicloud.com>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<Trond.Myklebust@netapp.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<lilingfeng3@huawei.com>
References: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100006.china.huawei.com (7.202.181.220)

LGTM

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

Besides, nfsacld_proc_getacl should fix too.



在 2024/11/7 9:47, Li Lingfeng 写道:
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

