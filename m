Return-Path: <linux-nfs+bounces-21444-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHtRDmHf/Wn0jwAAu9opvQ
	(envelope-from <linux-nfs+bounces-21444-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 15:04:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 849CF4F6C06
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 15:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98ED2305E376
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2026 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC56280A5A;
	Fri,  8 May 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XX8z0kWk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3B346FA7;
	Fri,  8 May 2026 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245221; cv=none; b=JDdMHR4z+/qHYol5635ScIUdx/wEDbqfy15NsUQbt2IAyD6pWFrjrZgWBiMp1339oGeo85Tg6cpifLi6h2J39TsVBQM3JsXYJumA8b0m8RJMPEHeYi51M+itsbKWMQxA/n87LAlnp//vOQ+y3WcUU54hQqS/x36LargkJn5fS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245221; c=relaxed/simple;
	bh=VOTenCH+yVCAOU/B/X+w1TN8sfvfgnU61LeNEOd2v9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=XVBInZgTTmITUrOS8vKPkm2Dfe8eaYy3ee8770X9eV07kECb2e2gg0MF+Nt2jBTx7mfr+0DVsyS783FwnclVh01l4p19D/QMGwJV2lnIM7hk8kq8Dy+uz6YXrmQnhlPIoNKBDi0cZzAwMvwt/ctpu99FpxiJrHv7nFBa8t5aLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XX8z0kWk; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jBfBcBIL2bV05exYHwd/uY8mcQjvCoEww7m2lBB4MA0=;
	b=XX8z0kWkkSvINIzHjMzQOSDeN9FE8SuRnzmKfpUgCeXRdOUeVsThn4czLXsCwHpzcRU7bnKq8
	nxcVJgpOI7BzMmdA8wVGzAzN3ZkVx15tGXVQ3F0GozZNtYwgtRJGHjOwhCzfQ+vf6OvG5qByAi7
	SU3qP0++7NJjXRDh+LaO6FQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gBptd22t5zLlSC;
	Fri,  8 May 2026 20:52:41 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id E79214055B;
	Fri,  8 May 2026 21:00:14 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 8 May 2026 21:00:13 +0800
Message-ID: <39819ad4-3105-4802-b5e2-79e131b25984@huawei.com>
Date: Fri, 8 May 2026 21:00:12 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in
 cache content files
From: yangerkun <yangerkun@huawei.com>
To: Chuck Lever <cel@kernel.org>, Misbah Anjum N <misanjum@linux.ibm.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	<anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <yi.zhang@huawei.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>, Li Lingfeng <lilingfeng3@huawei.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
 <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
 <76a10e49-54a6-4813-8b58-b7cd0820fdc6@app.fastmail.com>
 <4bb9ed6b-1a64-406a-9239-b0560ca963cc@huawei.com>
 <05f93fc4-59d7-4735-bc7d-a00d1497687a@huawei.com>
 <10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com>
In-Reply-To: <10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Queue-Id: 849CF4F6C06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[oracle.com:server fail,huawei.com:server fail,sea.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-21444-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim,oracle.com:email]
X-Rspamd-Action: no action



在 2026/5/8 16:16, yangerkun 写道:
> 
> 
> 在 2026/5/8 11:08, yangerkun 写道:
>>
>>
>> 在 2026/5/8 10:45, yangerkun 写道:
>>> Hello  Chuck,
>>>
>>> 在 2026/5/8 0:12, Chuck Lever 写道:
>>>> Hello Erkun -
>>>>
>>>> On Thu, May 7, 2026, at 11:09 AM, yangerkun wrote:
>>>>> Hi,
>>>>>
>>>>> 在 2026/5/1 22:51, Chuck Lever 写道:
>>>>>> Misbah Anjum reported a use-after-free in cache_check_rcu()
>>>>>> reached through e_show() while sosreport was reading
>>>>>> /proc/fs/nfsd/exports on ppc64le.  Two fixes for that report
>>>>>> landed in v7.0:
>>>>>>
>>>>>>     48db892356d6 ("NFSD: Defer sub-object cleanup in export put 
>>>>>> callbacks")
>>>>>>     e7fcf179b82d ("NFSD: Hold net reference for the lifetime of / 
>>>>>> proc/fs/nfs/exports fd")
>>>>>
>>>>> Back to the problem fixed by this patches, I'm a little confused why
>>>>> this UAF can be trigged.
>>>>>
>>>>> Before this patches, svc_export_put show as follow:
>>>>>
>>>>>    368 static void svc_export_put(struct kref *ref)
>>>>>    369 {
>>>>>    370         struct svc_export *exp = container_of(ref, struct
>>>>> svc_export, h.ref);
>>>>>    371
>>>>>    372         path_put(&exp->ex_path);
>>>>>    373         auth_domain_put(exp->ex_client);
>>>>>    374         call_rcu(&exp->ex_rcu, svc_export_release);
>>>>>    375 }
>>>>>
>>>>> The auth_domain_put function releases ->name using call_rcu, and
>>>>> path_put may release the dentry also via call_rcu. All of this 
>>>>> seems to
>>>>> prevent e_show from causing a UAF. Could you point out which line in
>>>>> d_path triggers the issue?
>>>>
>>>> The dentry, the mount, and the auth_domain ->name buffer all
>>>> end up RCU-freed (dentry_free() and delayed_free_vfsmnt in
>>>> fs/, svcauth_unix_domain_release_rcu() in svcauth_unix.c).
>>>> The eventual kfree isn't the problem.
>>>>
>>>> The problem is the synchronous teardown inside path_put(),
>>>> which runs before svc_export_put() ever reaches its own
>>>> call_rcu():
>>>>
>>>>    path_put(&exp->ex_path)
>>>>      -> dput(dentry)
>>>>         -> __dentry_kill()              [if last ref]
>>>>            -> __d_drop()                /* unhashes */
>>>>            -> dentry_unlink_inode()     /* d_inode = NULL */
>>>>            -> d_op->d_release() if set
>>>>            -> drops parent d_lockref    /* may cascade up */
>>>>            -> dentry_free()             /* call_rcu deferred */
>>>>      -> mntput(mnt)                     /* deferred via task_work */
>>>>
>>>> The dentry pointer itself is RCU-safe, so prepend_path()'s walk
>>>> of d_parent and d_name doesn't read freed memory.  But by the
>>>> time the reader gets there, __d_clear_type_and_inode() has
>>>> already stored NULL into d_inode, __d_drop() has broken the
>>>> hash linkage, and the parent's d_lockref has been decremented
>>>> -- which can in turn fire __dentry_kill() on the parent, and
>>>> on up the tree.  An e_show() that's still inside its cache RCU
>>>> read section walks into that half-dismantled state through
>>>> seq_path(), and that's the NULL deref Misbah reported.
>>>
>>> Thank you for your detailed explanation! Yes, e_show might be called 
>>> when the state is partially dismantled, but after carefully reviewing 
>>> the code with dput up to __dentry_kill, I still cannot find anything 
>>> that could cause this issue. Additionally, the comments for 
>>> prepend_path indicate that they have already taken into account that 
>>> the dentry can be removed concurrently. I have also run some tests on 
>>> my arm64 QEMU, but I couldn't reproduce the problem either. Could you 
>>> please help me identify the specific line or pointer in the dentry 
>>> that triggers this use-after-free or null pointer issue?
>>>
>>> Maybe I am not be very familiar with the code, which caused me to 
>>> fail to identify the real root cause. I'm so sorry for that.
>>>
>>>
>>> 265 char *d_path(const struct path *path, char *buf, int buflen)
>>> 266 {
>>> 267         DECLARE_BUFFER(b, buf, buflen);
>>> 268         struct path root;
>>> 269
>>> 270         /*
>>> 271          * We have various synthetic filesystems that never get 
>>> mounted.  On
>>> 272          * these filesystems dentries are never used for lookup 
>>> purposes, and
>>> 273          * thus don't need to be hashed.  They also don't need a 
>>> name until a
>>> 274          * user wants to identify the object in /proc/pid/fd/. 
>>> The little hack
>>> 275          * below allows us to generate a name for these objects 
>>> on demand:
>>> 276          *
>>> 277          * Some pseudo inodes are mountable.  When they are mounted
>>> 278          * path->dentry == path->mnt->mnt_root.  In that case 
>>> don't call d_dname
>>> 279          * and instead have d_path return the mounted path.
>>> 280          */
>>> 281         if (path->dentry->d_op && path->dentry->d_op->d_dname &&
>>> 282             (!IS_ROOT(path->dentry) || path->dentry != path->mnt- 
>>>  >mnt_root))
>>> 283                 return path->dentry->d_op->d_dname(path->dentry, 
>>> buf, buflen);
>>> 284
>>> 285         rcu_read_lock();
>>> 286         get_fs_root_rcu(current->fs, &root);
>>> 287         if (unlikely(d_unlinked(path->dentry)))
>>> 288                 prepend(&b, " (deleted)", 11);
>>> 289         else
>>> 290                 prepend_char(&b, 0);
>>> 291         prepend_path(path, &root, &b);
>>> 292         rcu_read_unlock();
>>> 293
>>> 294         return extract_string(&b);
>>> 295 }
>>>
>>>
>>>>
>>>> The earlier fix (2530766492ec, "nfsd: fix UAF when access
>>>> ex_uuid or ex_stats") moved the kfree of ex_uuid and ex_stats
>>>> into svc_export_release() so those are RCU-safe now.
>>>> path_put() and auth_domain_put() couldn't go in there because
>>>> both may sleep, and call_rcu callbacks run in softirq context.
>>>> This series uses queue_rcu_work() instead: it defers past the
>>>> grace period AND runs the callback in process context, so the
>>>> sleeping puts move into the deferred path and the window
>>>> closes.
>>>
>>> Yeah, I can get this! Thanks again for your detail explanation!
>>
>> Also, could the scenario described in this commit be triggered again?
>>
>> commit 69d803c40edeaf94089fbc8751c9b746cdc35044
>> Author: Yang Erkun <yangerkun@huawei.com>
>> Date:   Mon Dec 16 22:21:52 2024 +0800
>>
>>      nfsd: Revert "nfsd: release svc_expkey/svc_export with rcu_work"
>>
>>      This reverts commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d.
>>
>>      Before this commit, svc_export_put or expkey_put will call 
>> path_put with
>>      sync mode. After this commit, path_put will be called with async 
>> mode.
>>      And this can lead the unexpected results show as follow.
>>
>>      mkfs.xfs -f /dev/sda
>>      echo "/ *(rw,no_root_squash,fsid=0)" > /etc/exports
>>      echo "/mnt *(rw,no_root_squash,fsid=1)" >> /etc/exports
>>      exportfs -ra
>>      service nfs-server start
>>      mount -t nfs -o vers=4.0 127.0.0.1:/mnt /mnt1
>>      mount /dev/sda /mnt/sda
>>      touch /mnt1/sda/file
>>      exportfs -r
>>      umount /mnt/sda # failed unexcepted
>>
>>      The touch will finally call nfsd_cross_mnt, add refcount to 
>> mount, and
>>      then add cache_head. Before this commit, exportfs -r will call
>>      cache_flush to cleanup all cache_head, and path_put in
>>      svc_export_put/expkey_put will be finished with sync mode. So, the
>>      latter umount will always success. However, after this commit, 
>> path_put
>>      will be called with async mode, the latter umount may failed, and if
>>      we add some delay, umount will success too. Personally I think 
>> this bug
>>      and should be fixed. We first revert before bugfix patch, and 
>> then fix
>>      the original bug with a different way.
>>
>>      Fixes: f8c989a0c89a ("nfsd: release svc_expkey/svc_export with 
>> rcu_work")
>>      Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>      Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>
>>
> 
> After reviewing these two commits:
> 
> e7fcf179b82d NFSD: Hold net reference for the lifetime of /proc/fs/nfs/ 
> exports fd
> 48db892356d6 NFSD: Defer sub-object cleanup in export put callbacks
> 
> I believe that the issue described in commit e7fcf179b82d might be the
> root cause of the null pointer dereferences mentioned in [1]. This is
> because we do not call get_net when opening /proc/fs/nfs/exports. As a
> result, when the network namespace exits, nfsd_net_exit is triggered.
> If, at the same time, the contents of /proc/fs/nfs/exports are being
> read, a use-after-free (UAF) can occur on the struct cache_detail. I
> think all three bugs referenced in [1] stem from this issue. Therefore,
> commit e7fcf179b82d has already addressed the problem. To prevent the
> issue described in commit 69d803c40ede, should we consider reverting
> commit 48db892356d6 first? Please let me know if I have misunderstood
> any aspect of this problem.

Locally, I wrote a stable regression test case. I also reverted to 
commit 9189d23b835cec646ba5010db35d1557a77c5857 (which is before commits 
2862eee078a4 "SUNRPC: make sure cache entry active before cache_show" 
and be8f982c369c "nfsd: make sure exp active before svc_export_show"). 
Even then, a panic can still be triggered without any actual export path...

> 
>>>
>>> Thanks,
>>> Erkun.
>>>
>>>>
>>>>
>>>
>>
>>
>>
> 
> 
> 


