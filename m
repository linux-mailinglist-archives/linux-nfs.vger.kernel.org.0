Return-Path: <linux-nfs+bounces-9617-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151AA1C66F
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 07:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9367A304F
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 06:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C327C185B72;
	Sun, 26 Jan 2025 06:28:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886E17E;
	Sun, 26 Jan 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737872916; cv=none; b=E0+OLNL0nZOj2D/sQrVraTwdxdwWCnF4bg35WawOZdiaFNlyl+tXvAcbOH6Ez92kcsBox32RP//pfmxYrI5D0IodaAkPjj0Nm6+hQJNAiSF33mVJkwtdWF9aLZxQQrv7LZE3SZ4IlocWRRXAJLan8Yecsw6gBOdk0s2SCh0gd5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737872916; c=relaxed/simple;
	bh=NtzDspUanN0omf3O5U6v65E4Ar0Kzi/PVqnsu1Y9WpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rwjAlAeOb7GU089Vqr8fekevZIhG7NYLecLLTxkZYGSgrMM+EUIBLw/p9jviNrG+MMKSP9T5Xu3Zhcs3crXA6HAPqdbbo/gVgBFr4SOJY50xpFX+1mzvTMdIrqJ4Bu6uuAPac/Po+t7Lc0n2maz6Dy6AEu6z3M7iWI1v297hZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YghPm1dY7z22lwl;
	Sun, 26 Jan 2025 14:25:48 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F4421A0188;
	Sun, 26 Jan 2025 14:28:22 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 26 Jan 2025 14:28:21 +0800
Message-ID: <23481c82-e7cc-470c-ad89-3e0170a727b2@huawei.com>
Date: Sun, 26 Jan 2025 14:28:20 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfsd: set acl_access/acl_default after getting successful
To: Rick Macklem <rick.macklem@gmail.com>, Chuck Lever
	<chuck.lever@oracle.com>
CC: <lilingfeng@huaweicloud.com>, "zhangjian (CG)" <zhangjian496@huawei.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<Trond.Myklebust@netapp.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
 <93fd0f1c-812f-4393-ad73-4d07ecebf979@huawei.com>
 <CAM5tNy4rYLWSuO_KrgXJrHV+DPhOoZGZAdWLZsW35u3qWuMSvg@mail.gmail.com>
 <CAM5tNy4QXM8bhcfTtrKt+ogWPPOKe5g06j1sgFm5z8=BKP-4vw@mail.gmail.com>
 <Z03fpnNYHjuKox0E@tissot.1015granger.net>
 <CAM5tNy4AYfJ+AhX-UJ_orvuOkv=ctg=oCHrrOjTcfLz+rRrCsg@mail.gmail.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <CAM5tNy4AYfJ+AhX-UJ_orvuOkv=ctg=oCHrrOjTcfLz+rRrCsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2024/12/3 1:06, Rick Macklem 写道:
> On Mon, Dec 2, 2024 at 8:33 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>> CAUTION: This email originated from outside of the University of Guelph. Do not click links or open attachments unless you recognize the sender and know the content is safe. If in doubt, forward suspicious emails to IThelp@uoguelph.ca.
>>
>>
>> On Wed, Nov 27, 2024 at 07:37:42PM -0800, Rick Macklem wrote:
>>> On Wed, Nov 27, 2024 at 7:14 PM Rick Macklem <rick.macklem@gmail.com> wrote:
>>>> On Wed, Nov 27, 2024 at 5:18 PM zhangjian (CG) <zhangjian496@huawei.com> wrote:
>>>>> there is one case when disk error cause get_inode_acl(inode,
>>>>> ACL_TYPE_DEFAULT) return EIO,
>>>>> resp->acl_access will not be null. posix_acl_release(resp->acl_default)
>>>>> will trigger this warning.
>>>>>
>>>>>
>>>>>> If getting acl_default fails, acl_access and acl_default will be released
>>>>>> simultaneously. However, acl_access will still retain a pointer pointing
>>>>>> to the released posix_acl, which will trigger a WARNING in
>>>>>> nfs3svc_release_getacl like this:
>>>>>>
>>>>>> ------------[ cut here ]------------
>>>>>> refcount_t: underflow; use-after-free.
>>>>>> WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
>>>>>> refcount_warn_saturate+0xb5/0x170
>>>>>> Modules linked in:
>>>>>> CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
>>>>>> 6.12.0-rc6-00079-g04ae226af01f-dirty #8
>>>>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>>>>> 1.16.1-2.fc37 04/01/2014
>>>>>> RIP: 0010:refcount_warn_saturate+0xb5/0x170
>>>>>> Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
>>>>>> e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
>>>>>> cd 0f b6 1d 8a3
>>>>>> RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
>>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
>>>>>> RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
>>>>>> RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
>>>>>> R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
>>>>>> R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
>>>>>> FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>> Call Trace:
>>>>>>    <TASK>
>>>>>>    ? refcount_warn_saturate+0xb5/0x170
>>>>>>    ? __warn+0xa5/0x140
>>>>>>    ? refcount_warn_saturate+0xb5/0x170
>>>>>>    ? report_bug+0x1b1/0x1e0
>>>>>>    ? handle_bug+0x53/0xa0
>>>>>>    ? exc_invalid_op+0x17/0x40
>>>>>>    ? asm_exc_invalid_op+0x1a/0x20
>>>>>>    ? tick_nohz_tick_stopped+0x1e/0x40
>>>>>>    ? refcount_warn_saturate+0xb5/0x170
>>>>>>    ? refcount_warn_saturate+0xb5/0x170
>>>>>>    nfs3svc_release_getacl+0xc9/0xe0
>>>>>>    svc_process_common+0x5db/0xb60
>>>>>>    ? __pfx_svc_process_common+0x10/0x10
>>>>>>    ? __rcu_read_unlock+0x69/0xa0
>>>>>>    ? __pfx_nfsd_dispatch+0x10/0x10
>>>>>>    ? svc_xprt_received+0xa1/0x120
>>>>>>    ? xdr_init_decode+0x11d/0x190
>>>>>>    svc_process+0x2a7/0x330
>>>>>>    svc_handle_xprt+0x69d/0x940
>>>>>>    svc_recv+0x180/0x2d0
>>>>>>    nfsd+0x168/0x200
>>>>>>    ? __pfx_nfsd+0x10/0x10
>>>>>>    kthread+0x1a2/0x1e0
>>>>>>    ? kthread+0xf4/0x1e0
>>>>>>    ? __pfx_kthread+0x10/0x10
>>>>>>    ret_from_fork+0x34/0x60
>>>>>>    ? __pfx_kthread+0x10/0x10
>>>>>>    ret_from_fork_asm+0x1a/0x30
>>>>>>    </TASK>
>>>>>> Kernel panic - not syncing: kernel: panic_on_warn set ...
>>>>>>
>>>>>> Clear acl_access/acl_default first and set both of them only when both
>>>>>> ACLs are successfully obtained.
>>>>>>
>>>>>> Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
>>>>>> Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
>>>>>> ---
>>>>>>    fs/nfsd/nfs3acl.c | 14 ++++++++------
>>>>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
>>>>>> index 5e34e98db969..17579a032a5b 100644
>>>>>> --- a/fs/nfsd/nfs3acl.c
>>>>>> +++ b/fs/nfsd/nfs3acl.c
>>>>>> @@ -29,10 +29,12 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
>>>>>>    {
>>>>>>        struct nfsd3_getaclargs *argp = rqstp->rq_argp;
>>>>>>        struct nfsd3_getaclres *resp = rqstp->rq_resp;
>>>>>> -     struct posix_acl *acl;
>>>>>> +     struct posix_acl *acl = NULL, *dacl = NULL;
>>>>>>        struct inode *inode;
>>>>>>        svc_fh *fh;
>>>>>>
>>>>>> +     resp->acl_access = NULL;
>>>>>> +     resp->acl_default = NULL;
>>>> (A) These two lines fix the bug, without other changes needed, I think...
>>> Oops, I was wrong w.r.t. this. These two lines need to be repeated after the
>>> posix_acl_relase() calls under "fail:".
>>>>>>        fh = fh_copy(&resp->fh, &argp->fh);
>>>>>>        resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
>>>>>>        if (resp->status != nfs_ok)
>>>>>> @@ -56,19 +58,19 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
>>>>>>                        resp->status = nfserrno(PTR_ERR(acl));
>>>>>>                        goto fail;
>>>>>>                }
>>>>>> -             resp->acl_access = acl;
>>>> Because you deleted this line...
>>>>>>        }
>>>>>>        if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
>>>>>>                /* Check how Solaris handles requests for the Default ACL
>>>>>>                   of a non-directory! */
>>>>>> -             acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
>>>>>> -             if (IS_ERR(acl)) {
>>>>>> -                     resp->status = nfserrno(PTR_ERR(acl));
>>>>>> +             dacl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
>>>>>> +             if (IS_ERR(dacl)) {
>>>>>> +                     resp->status = nfserrno(PTR_ERR(dacl));
>>>>>>                        goto fail;
>>>> The goto fail here will not release the access acl, if I read the code
>>>> correctly.
>>>>>>                }
>>>>>> -             resp->acl_default = acl;
>>>>>>        }
>>>>>>
>>>>>> +     resp->acl_access = acl;
>>>>>> +     resp->acl_default = dacl;
>>>>>>        /* resp->acl_{access,default} are released in nfs3svc_release_getacl. */
>>>>>>    out:
>>>>>>        return rpc_success;
>>>> Actually, all that is needed to fix the bug is adding the two lines
>>>> that initialize
>>>> them both NUL, I think.. I marked that change (A) above.
>>> Nope, I was wrong w.r.t. this part. You either need to set
>>>       resp->acl_access = acl;
>>>       resp->acl_default = dacl;
>>> after the posix_acl_relase() calls or switch to using the local
>>> acl and dacl variables for these posix_acl_release calls and stick
>>> with what you did above w.r.t. resp->acl_access and resp->acl_default.
>>>
>>> Anyhow, I think the case I noted above where get_inode_acl(inode,
>>> ACL_TYPE_DEFAULT)
>>> fails will not release acl with your patch.
>>>
>>> rick
>> Howdy -
>>
>> This one didn't make it into v6.13 because there are some
>> outstanding (and ambiguous, at least to me) review comments. Can you
>> address the comments, update the patch, and post it again?
> In an effort to disambiguate my comments, I'll try again.
> (And, yes, I did not do a good job last time;-)
>
> 1 - I think your patch fails for the case where the acl_access is acquired,
>       but the acl_default fails. For this case, I do not see how acl_access
>       would be posix_acl_release()'d and would leak the acl structure.
>       If you look at your patched version, resp->acl_access is not set when
>       the "goto fail" is executed in the default acl if block.
Thank you for your review. The issue you pointed out does indeed exist.
>
> 2 - Instead of your patch, the bug can be fixed by simply adding the two
>       lines:
>       resp->acl_access = NULL;
>       resp->acl_default = NULL;
>       after the posix_acl_release() calls below the "fail" label.
>       No other changes are required, from what I can see.
This looks better, I will test it and send v2 soon.
>
> rick
>
>> --
>> Chuck Lever
>>

