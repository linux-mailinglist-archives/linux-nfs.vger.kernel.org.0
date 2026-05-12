Return-Path: <linux-nfs+bounces-21512-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA5ODBMiA2r10gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21512-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:50:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E35206EA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F1F31496CB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5135E3911AA;
	Tue, 12 May 2026 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t4jNkOJT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C704390617
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589389; cv=none; b=ravN7FTp++iuudRz5s1NdcJeI1CIsqstK7JWR2j9V2h/mhUk4JWpTp7bPFqQPv2H/ApszDxrSH4tTXqHE3DL201pvExCy2ZpfGogBAkNTX5SzwkDAn/NYyo+s68/PkcSdzdZSgktQxy1egKjVNT2Burgyoc8L9MBOXedzQgIyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589389; c=relaxed/simple;
	bh=/Yp7bcnpJtCMNSyK1nlTSmp61TbMvG0wLqpOVmk4WyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I6gNUxY1/hsfji3AjMB5tOEHzgDYwqfM2g8gG3DVnb9GLsTugQ5pIMmAZaW7S8zRGvxLLlRV/yPiyRFnTSmAxwlzorWHKDgfUxyX/ijD8r5I9AqJTD4fWK9CT9bXEhlj+5KFub6G64Qy6NIPBT1nxLq83I4D6C4UVJ5JXnCTpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t4jNkOJT; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4QL9GvonmrGEdxwl/phufvuCuJoq8lcKFz3trUkaD+o=;
	b=t4jNkOJT35kKGH4WFj9GVeyndVSFgMz/TwcQQwaNOU7Ad6fIFFgpLTL6tKdJzswxKHSpsARZm
	Cn5ARQtja/l0JA1fN4cEk/PRkCtfKi77SU0D+cQPpYZZZBmTiHgm6FnDsFIdiyDNxzIjxl+5tLU
	b+yz/8aom+ysXnwZfE2SOQ0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gFG8p1bkxzLlSk;
	Tue, 12 May 2026 20:28:26 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F584402AB;
	Tue, 12 May 2026 20:36:02 +0800 (CST)
Received: from [10.174.176.240] (10.174.176.240) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 20:36:01 +0800
Message-ID: <34c46a7c-14e7-4966-bec3-060e26ca08d7@huawei.com>
Date: Tue, 12 May 2026 20:36:00 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
To: Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huaweicloud.com>,
	<chuck.lever@oracle.com>, <misanjum@linux.ibm.com>, <neil@brown.name>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <yi.zhang@huawei.com>,
	<chengzhihao1@huawei.com>, <lilingfeng3@huawei.com>
References: <20260512023322.2828939-1-yangerkun@huawei.com>
 <a6c66164d75e6cfa530892b9f5f25ab9d677a9fa.camel@kernel.org>
 <5701706a-6a54-4bcb-a2ce-83eac3d4b715@huaweicloud.com>
 <da2da3a188b1823bad89e876001a5281351d8eb7.camel@kernel.org>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <da2da3a188b1823bad89e876001a5281351d8eb7.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100006.china.huawei.com (7.202.181.220)
X-Rspamd-Queue-Id: 841E35206EA
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-21512-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:mid,huawei.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



在 2026/5/12 20:30, Jeff Layton 写道:
> On Tue, 2026-05-12 at 20:19 +0800, yangerkun wrote:
>> Hi Jeff,
>>
>> 在 2026/5/12 19:25, Jeff Layton 写道:
>>> On Tue, 2026-05-12 at 10:33 +0800, Yang Erkun wrote:
>>>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>>>
>>>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>>>> callbacks") describes an issue where calling svc_export_put, path_put,
>>>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>>>> accessing ex_path or ex_client->name. However, after discussion in [1],
>>>> it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for the
>>>> lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.
>>>>
>>>> Additionally, commit 48db892356d6 ("NFSD: Defer sub-object cleanup in
>>>> export put callbacks") introduces a regression that was already fixed by
>>>> commit 69d803c40ede ("nfsd: Revert "nfsd: release svc_expkey/svc_export
>>>> with rcu_work""). Therefore, reverting commit 48db892356d6 ("NFSD: Defer
>>>> sub-object cleanup in export put callbacks") is necessary to fix this
>>>> regression.
>>>>
>>>> Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com/ [1]
>>>> Fixes: 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>>> ---
>>>>    fs/nfsd/export.c | 63 +++++++-----------------------------------------
>>>>    fs/nfsd/export.h |  7 ++----
>>>>    fs/nfsd/nfsctl.c |  8 +-----
>>>>    3 files changed, 12 insertions(+), 66 deletions(-)
>>>>
>>>
>>> The LLMs don't seem to agree that this is safe:
>>>
>>> commit (not yet applied)
>>> Author: Yang Erkun <yangerkun@huawei.com>
>>>
>>> Revert "NFSD: Defer sub-object cleanup in export put callbacks"
>>>
>>> This reverts commit 48db892356d6. The commit message states that
>>> e7fcf179b82d resolves the underlying UAF and that the reverted
>>> commit re-introduces an umount regression fixed by 69d803c40ede.
>>>
>>> Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com/
>>>
>>>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>>>
>>>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>>>> callbacks") describes an issue where calling svc_export_put, path_put,
>>>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>>>> accessing ex_path or ex_client->name. However, after discussion in [1],
>>>> it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for the
>>>> lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.
>>>
>>> Is this accurate?  Commit e7fcf179b82d holds a net reference for the
>>> lifetime of the /proc/fs/nfs/exports file descriptor.  This prevents
>>> nfsd_net_exit() from calling nfsd_export_shutdown() while the exports
>>> fd is open, keeping the cache_detail alive.
>>
>> Yes.
>>
>>>
>>> But the UAF described in 48db892356d6 is a different problem.
>>> cache_clean() periodically removes expired entries from the hash table
>>> via sunrpc_begin_cache_remove_entry() and drops their reference via
>>> cache_put().  If that was the last reference, svc_export_put() runs
>>> and frees sub-objects.
>>
>> Yes.
>>
>>>
>>> Meanwhile, c_show() and e_show() iterate cache entries under
>>> rcu_read_lock() without holding a reference.  Specifically, c_show()
>>> unconditionally calls cd->cache_show():
>>>
>>> net/sunrpc/cache.c:c_show():
>>> 	if (cache_check_rcu(cd, cp, NULL))
>>> 		seq_puts(m, "# ");
>>> 	else if (cache_is_expired(cd, cp))
>>> 		seq_puts(m, "# ");
>>> 	return cd->cache_show(m, cd, cp);
>>>
>>> svc_export_show() then accesses both exp->ex_path via seq_path()
>>> and exp->ex_client->name via seq_escape().  expkey_show() similarly
>>> accesses ek->ek_client->name and ek->ek_path.
>>
>> Yes.
>>
>>>
>>> Commit e7fcf179b82d does not prevent cache_clean() from removing
>>> individual entries concurrently with these RCU readers.  It seems
>>
>> Yes.
>>
>>> like the claim in this commit message may be conflating two different
>>> problems.
>>
>> True, the msg describe here seems confused. That should change to:
>>
>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks") describes an issue where calling svc_export_put, path_put,
>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>> accessing ex_path or ex_client->name. But after discussion in [1], it
>> seems cannot happen and either will introduce a gression that was
>> already fixed by commit 69d803c40ede ("nfsd: Revert "nfsd: release
>> svc_expkey/svc_export with rcu_work""). Therefore, reverting commit
>> 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>> is necessary to fix this regression.
>>
>>
>>>
>>>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>>>> index 665153f1720e..0baa58d1dbfc 100644
>>>> --- a/fs/nfsd/export.c
>>>> +++ b/fs/nfsd/export.c
>>>
>>> [ ... ]
>>>
>>>> -static void expkey_release(struct work_struct *work)
>>>> +static void expkey_put(struct kref *ref)
>>>>    {
>>>> -	struct svc_expkey *key = container_of(to_rcu_work(work),
>>>> -					      struct svc_expkey, ek_rwork);
>>>> +	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>>>>    	if (test_bit(CACHE_VALID, &key->h.flags) &&
>>>>    	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>>>>    		path_put(&key->ek_path);
>>>>    	auth_domain_put(key->ek_client);
>>>> -	kfree(key);
>>>> -}
>>>> -
>>>> -static void expkey_put(struct kref *ref)
>>>> -{
>>>> -	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>>>> -
>>>> -	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
>>>> -	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
>>>> +	kfree_rcu(key, ek_rcu);
>>>>    }
>>>
>>> With this change, path_put() and auth_domain_put() run immediately
>>> when the last reference is dropped, before the RCU grace period.
>>> kfree_rcu() only defers the kfree of the svc_expkey struct itself.
>>>
>>> If cache_clean() drops the last reference concurrently with an RCU
>>> reader in c_show() -> expkey_show(), the reader can access
>>> ek->ek_client->name after auth_domain_put() has freed the
>>> auth_domain, and can call seq_path(&ek->ek_path) after path_put()
>>> has freed the underlying dentry/mnt.  The rcu_read_lock() held by the
>>> reader prevents kfree_rcu() from freeing the struct, but does not
>>> prevent the direct path_put()/auth_domain_put() calls.
>>
>> Yes. It won't prevent the direct path_put/auth_domain_put calls.
>>
>>>
>>> Does this re-introduce the UAF that 48db892356d6 was fixing?
>>
>> No, something like release of dentry/mnt ek->ek_client->name all
>> protected will call_rcu(call_rcu(&dentry->d_rcu, __d_free) in
>> dentry_free, call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt) in
>> cleanup_mnt, call_rcu(&dom->rcu_head, svcauth_gss_domain_release_rcu) in
>> svcauth_gss_domain_release, call_rcu(&dom->rcu_head,
>> svcauth_unix_domain_release_rcu) in svcauth_unix_domain_release), so
>> rcu_read_lock/rcu_read_unlock for c_show/e_show can protect this trigger
>> UAF.
>>
> 
> Got it. Thanks for the explanation. In that case, I'm fine with
> reverting this patch.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks a lot for your review!

> 


