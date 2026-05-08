Return-Path: <linux-nfs+bounces-21440-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TwI1JzpO/Wm4aQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21440-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 04:45:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F04F0E5E
	for <lists+linux-nfs@lfdr.de>; Fri, 08 May 2026 04:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A80F300C021
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2026 02:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062A28C854;
	Fri,  8 May 2026 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="adYUVP7b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9B276058;
	Fri,  8 May 2026 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208310; cv=none; b=oIzXoRsWBxDAZi//q5YpEAbO+CQFuKOb7VRrAf0cdPwX1ooP5IdXfPc1w2KgmMcNk/YuIreOTT2YAYnEw6G+FrCNVo4xW1wNT1uQjE5G2+KyHS1vhgusl//ls4juZzUb7xadrB2rUoFq69itN9kePV4nL1MsPYaTSEAQZuk9H/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208310; c=relaxed/simple;
	bh=J6mvIxH+ZZzLBDBHsSOL4HrTFGVClt8f94g6+dy+Ys8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KY38YoabvBXH6sO5+0q9D+BRAc39qsMGXN3EQRd1kqRQA0cXnnCZBVaToTcrtAM4XmksrsShzTfY5b9W3O5qp+11lzudkoccMtKXAF25NJ1J3Bk6eVWmN7q1Dzto8i/CLcFFC10AkkozHeE5ZvvC5ufcwUM/z6BGwbhLkt+gSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=adYUVP7b; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nIfdFbiZVgiXdv9VSRsfyJN+b7Vc9DXCfpPg/eyjtVE=;
	b=adYUVP7bOZN+ranjhCnTfspCuat+EA2xM+rynfed3f3Fu+qGaVp6PqB+TozQDqLv7h8Vy5hwA
	O0wWMedXxLkqGqoDNoxGxkWEE4auAcHHB9boPY9RjV7uHiMLiWaypsWIslwL7JMtrjpyU4/Prs9
	CHawLwYMHKf6aT1MavurUwE=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gBYDq2xt3z1K984;
	Fri,  8 May 2026 10:37:31 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id DF59840575;
	Fri,  8 May 2026 10:45:03 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 8 May 2026 10:45:02 +0800
Message-ID: <4bb9ed6b-1a64-406a-9239-b0560ca963cc@huawei.com>
Date: Fri, 8 May 2026 10:45:01 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] SUNRPC: Address remaining cache_check_rcu() UAF in
 cache content files
To: Chuck Lever <cel@kernel.org>, Misbah Anjum N <misanjum@linux.ibm.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
	<anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <yi.zhang@huawei.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
 <c45779f6-fe6c-4037-bb1c-01cfbbaa8aac@huawei.com>
 <76a10e49-54a6-4813-8b58-b7cd0820fdc6@app.fastmail.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <76a10e49-54a6-4813-8b58-b7cd0820fdc6@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Queue-Id: 802F04F0E5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-21440-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huawei.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello  Chuck,

在 2026/5/8 0:12, Chuck Lever 写道:
> Hello Erkun -
> 
> On Thu, May 7, 2026, at 11:09 AM, yangerkun wrote:
>> Hi,
>>
>> 在 2026/5/1 22:51, Chuck Lever 写道:
>>> Misbah Anjum reported a use-after-free in cache_check_rcu()
>>> reached through e_show() while sosreport was reading
>>> /proc/fs/nfsd/exports on ppc64le.  Two fixes for that report
>>> landed in v7.0:
>>>
>>>     48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>>>     e7fcf179b82d ("NFSD: Hold net reference for the lifetime of /proc/fs/nfs/exports fd")
>>
>> Back to the problem fixed by this patches, I'm a little confused why
>> this UAF can be trigged.
>>
>> Before this patches, svc_export_put show as follow:
>>
>>    368 static void svc_export_put(struct kref *ref)
>>    369 {
>>    370         struct svc_export *exp = container_of(ref, struct
>> svc_export, h.ref);
>>    371
>>    372         path_put(&exp->ex_path);
>>    373         auth_domain_put(exp->ex_client);
>>    374         call_rcu(&exp->ex_rcu, svc_export_release);
>>    375 }
>>
>> The auth_domain_put function releases ->name using call_rcu, and
>> path_put may release the dentry also via call_rcu. All of this seems to
>> prevent e_show from causing a UAF. Could you point out which line in
>> d_path triggers the issue?
> 
> The dentry, the mount, and the auth_domain ->name buffer all
> end up RCU-freed (dentry_free() and delayed_free_vfsmnt in
> fs/, svcauth_unix_domain_release_rcu() in svcauth_unix.c).
> The eventual kfree isn't the problem.
> 
> The problem is the synchronous teardown inside path_put(),
> which runs before svc_export_put() ever reaches its own
> call_rcu():
> 
>    path_put(&exp->ex_path)
>      -> dput(dentry)
>         -> __dentry_kill()              [if last ref]
>            -> __d_drop()                /* unhashes */
>            -> dentry_unlink_inode()     /* d_inode = NULL */
>            -> d_op->d_release() if set
>            -> drops parent d_lockref    /* may cascade up */
>            -> dentry_free()             /* call_rcu deferred */
>      -> mntput(mnt)                     /* deferred via task_work */
> 
> The dentry pointer itself is RCU-safe, so prepend_path()'s walk
> of d_parent and d_name doesn't read freed memory.  But by the
> time the reader gets there, __d_clear_type_and_inode() has
> already stored NULL into d_inode, __d_drop() has broken the
> hash linkage, and the parent's d_lockref has been decremented
> -- which can in turn fire __dentry_kill() on the parent, and
> on up the tree.  An e_show() that's still inside its cache RCU
> read section walks into that half-dismantled state through
> seq_path(), and that's the NULL deref Misbah reported.

Thank you for your detailed explanation! Yes, e_show might be called 
when the state is partially dismantled, but after carefully reviewing 
the code with dput up to __dentry_kill, I still cannot find anything 
that could cause this issue. Additionally, the comments for prepend_path 
indicate that they have already taken into account that the dentry can 
be removed concurrently. I have also run some tests on my arm64 QEMU, 
but I couldn't reproduce the problem either. Could you please help me 
identify the specific line or pointer in the dentry that triggers this 
use-after-free or null pointer issue?

Maybe I am not be very familiar with the code, which caused me to fail 
to identify the real root cause. I'm so sorry for that.


265 char *d_path(const struct path *path, char *buf, int buflen)
266 {
267         DECLARE_BUFFER(b, buf, buflen);
268         struct path root;
269
270         /*
271          * We have various synthetic filesystems that never get 
mounted.  On
272          * these filesystems dentries are never used for lookup 
purposes, and
273          * thus don't need to be hashed.  They also don't need a 
name until a
274          * user wants to identify the object in /proc/pid/fd/.  The 
little hack
275          * below allows us to generate a name for these objects on 
demand:
276          *
277          * Some pseudo inodes are mountable.  When they are mounted
278          * path->dentry == path->mnt->mnt_root.  In that case don't 
call d_dname
279          * and instead have d_path return the mounted path.
280          */
281         if (path->dentry->d_op && path->dentry->d_op->d_dname &&
282             (!IS_ROOT(path->dentry) || path->dentry != 
path->mnt->mnt_root))
283                 return path->dentry->d_op->d_dname(path->dentry, 
buf, buflen);
284
285         rcu_read_lock();
286         get_fs_root_rcu(current->fs, &root);
287         if (unlikely(d_unlinked(path->dentry)))
288                 prepend(&b, " (deleted)", 11);
289         else
290                 prepend_char(&b, 0);
291         prepend_path(path, &root, &b);
292         rcu_read_unlock();
293
294         return extract_string(&b);
295 }


> 
> The earlier fix (2530766492ec, "nfsd: fix UAF when access
> ex_uuid or ex_stats") moved the kfree of ex_uuid and ex_stats
> into svc_export_release() so those are RCU-safe now.
> path_put() and auth_domain_put() couldn't go in there because
> both may sleep, and call_rcu callbacks run in softirq context.
> This series uses queue_rcu_work() instead: it defers past the
> grace period AND runs the callback in process context, so the
> sleeping puts move into the deferred path and the window
> closes.

Yeah, I can get this! Thanks again for your detail explanation!

Thanks,
Erkun.

> 
> 


