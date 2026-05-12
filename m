Return-Path: <linux-nfs+bounces-21510-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM16HEgbA2pt0gEAu9opvQ
	(envelope-from <linux-nfs+bounces-21510-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:21:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED00520081
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 14:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 311AA300A66D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D411360EFC;
	Tue, 12 May 2026 12:20:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7A38D41E
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588416; cv=none; b=Hi3qSYC6ZjXtgyF8eveCdHtflRlEd8C6v+PH+QS1rOhVpqLCoZAhPMfpMBMS0vZ/muIkdBF87JMX35o2e1E7QU4/SJD+w874ClkG+yJP3vgar684F64ycVZoasTv9eaKqFf87PuPzXpJqDjvJ/NIQwVb9vkZSO8iREftLe1vAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588416; c=relaxed/simple;
	bh=FBzKbBYhh5nA5TVA5ZNZVN3fzwBDOT4/u+civMaShYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7E+kdPs4e2joxKs4fNNdjR2doYH3OpDTzdfiBWRVLgInYuEPne+Y3LIsSweZSjhUm3WvjZj65aNiD+dK37rl1WGUd2xjAsfuMKGAGs5mLDMlhWhtG3hACoUGPdlmg/T36678p57Itg7h8hNynUP3yuHf3FxGhFiIuYsh8ohceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gFFyB03DRzKHMdq
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 20:19:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 72F6240561
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 20:20:06 +0800 (CST)
Received: from [10.174.176.240] (unknown [10.174.176.240])
	by APP4 (Coremail) with SMTP id gCh0CgCXX1vqGgNqE8sfCA--.59911S3;
	Tue, 12 May 2026 20:20:04 +0800 (CST)
Message-ID: <5701706a-6a54-4bcb-a2ce-83eac3d4b715@huaweicloud.com>
Date: Tue, 12 May 2026 20:19:53 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
To: Jeff Layton <jlayton@kernel.org>, Yang Erkun <yangerkun@huawei.com>,
 chuck.lever@oracle.com, misanjum@linux.ibm.com, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 lilingfeng3@huawei.com
References: <20260512023322.2828939-1-yangerkun@huawei.com>
 <a6c66164d75e6cfa530892b9f5f25ab9d677a9fa.camel@kernel.org>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <a6c66164d75e6cfa530892b9f5f25ab9d677a9fa.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXX1vqGgNqE8sfCA--.59911S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWDZr4xAFW7WF47XFyDGFg_yoW3uFyxpa
	yfAFW7Grs5JF40kr4kZw1UZa4F9a1Fv3WF93Wjk3ySvFy5Z3WxKF42vFyq9FyYkrW8G3yI
	vr10q3Z8Cry8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/
X-Rspamd-Queue-Id: 2ED00520081
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.989];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huaweicloud.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21510-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huaweicloud.com:mid,huawei.com:email]
X-Rspamd-Action: no action

Hi Jeff,

在 2026/5/12 19:25, Jeff Layton 写道:
> On Tue, 2026-05-12 at 10:33 +0800, Yang Erkun wrote:
>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>
>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks") describes an issue where calling svc_export_put, path_put,
>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>> accessing ex_path or ex_client->name. However, after discussion in [1],
>> it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for the
>> lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.
>>
>> Additionally, commit 48db892356d6 ("NFSD: Defer sub-object cleanup in
>> export put callbacks") introduces a regression that was already fixed by
>> commit 69d803c40ede ("nfsd: Revert "nfsd: release svc_expkey/svc_export
>> with rcu_work""). Therefore, reverting commit 48db892356d6 ("NFSD: Defer
>> sub-object cleanup in export put callbacks") is necessary to fix this
>> regression.
>>
>> Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com/ [1]
>> Fixes: 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/nfsd/export.c | 63 +++++++-----------------------------------------
>>   fs/nfsd/export.h |  7 ++----
>>   fs/nfsd/nfsctl.c |  8 +-----
>>   3 files changed, 12 insertions(+), 66 deletions(-)
>>
> 
> The LLMs don't seem to agree that this is safe:
> 
> commit (not yet applied)
> Author: Yang Erkun <yangerkun@huawei.com>
> 
> Revert "NFSD: Defer sub-object cleanup in export put callbacks"
> 
> This reverts commit 48db892356d6. The commit message states that
> e7fcf179b82d resolves the underlying UAF and that the reverted
> commit re-introduces an umount regression fixed by 69d803c40ede.
> 
> Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com/
> 
>> This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.
>>
>> Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
>> callbacks") describes an issue where calling svc_export_put, path_put,
>> and auth_domain_put directly can cause use-after-free (UAF) errors when
>> accessing ex_path or ex_client->name. However, after discussion in [1],
>> it is clear that commit e7fcf179b82d ("NFSD: Hold net reference for the
>> lifetime of /proc/fs/nfs/exports fd") actually resolves this problem.
> 
> Is this accurate?  Commit e7fcf179b82d holds a net reference for the
> lifetime of the /proc/fs/nfs/exports file descriptor.  This prevents
> nfsd_net_exit() from calling nfsd_export_shutdown() while the exports
> fd is open, keeping the cache_detail alive.

Yes.

> 
> But the UAF described in 48db892356d6 is a different problem.
> cache_clean() periodically removes expired entries from the hash table
> via sunrpc_begin_cache_remove_entry() and drops their reference via
> cache_put().  If that was the last reference, svc_export_put() runs
> and frees sub-objects.

Yes.

> 
> Meanwhile, c_show() and e_show() iterate cache entries under
> rcu_read_lock() without holding a reference.  Specifically, c_show()
> unconditionally calls cd->cache_show():
> 
> net/sunrpc/cache.c:c_show():
> 	if (cache_check_rcu(cd, cp, NULL))
> 		seq_puts(m, "# ");
> 	else if (cache_is_expired(cd, cp))
> 		seq_puts(m, "# ");
> 	return cd->cache_show(m, cd, cp);
> 
> svc_export_show() then accesses both exp->ex_path via seq_path()
> and exp->ex_client->name via seq_escape().  expkey_show() similarly
> accesses ek->ek_client->name and ek->ek_path.

Yes.

> 
> Commit e7fcf179b82d does not prevent cache_clean() from removing
> individual entries concurrently with these RCU readers.  It seems

Yes.

> like the claim in this commit message may be conflating two different
> problems.

True, the msg describe here seems confused. That should change to:

Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export put
callbacks") describes an issue where calling svc_export_put, path_put,
and auth_domain_put directly can cause use-after-free (UAF) errors when
accessing ex_path or ex_client->name. But after discussion in [1], it 
seems cannot happen and either will introduce a gression that was
already fixed by commit 69d803c40ede ("nfsd: Revert "nfsd: release
svc_expkey/svc_export with rcu_work""). Therefore, reverting commit
48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
is necessary to fix this regression.


> 
>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>> index 665153f1720e..0baa58d1dbfc 100644
>> --- a/fs/nfsd/export.c
>> +++ b/fs/nfsd/export.c
> 
> [ ... ]
> 
>> -static void expkey_release(struct work_struct *work)
>> +static void expkey_put(struct kref *ref)
>>   {
>> -	struct svc_expkey *key = container_of(to_rcu_work(work),
>> -					      struct svc_expkey, ek_rwork);
>> +	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>>   	if (test_bit(CACHE_VALID, &key->h.flags) &&
>>   	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>>   		path_put(&key->ek_path);
>>   	auth_domain_put(key->ek_client);
>> -	kfree(key);
>> -}
>> -
>> -static void expkey_put(struct kref *ref)
>> -{
>> -	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
>> -
>> -	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
>> -	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
>> +	kfree_rcu(key, ek_rcu);
>>   }
> 
> With this change, path_put() and auth_domain_put() run immediately
> when the last reference is dropped, before the RCU grace period.
> kfree_rcu() only defers the kfree of the svc_expkey struct itself.
> 
> If cache_clean() drops the last reference concurrently with an RCU
> reader in c_show() -> expkey_show(), the reader can access
> ek->ek_client->name after auth_domain_put() has freed the
> auth_domain, and can call seq_path(&ek->ek_path) after path_put()
> has freed the underlying dentry/mnt.  The rcu_read_lock() held by the
> reader prevents kfree_rcu() from freeing the struct, but does not
> prevent the direct path_put()/auth_domain_put() calls.

Yes. It won't prevent the direct path_put/auth_domain_put calls.

> 
> Does this re-introduce the UAF that 48db892356d6 was fixing?

No, something like release of dentry/mnt ek->ek_client->name all 
protected will call_rcu(call_rcu(&dentry->d_rcu, __d_free) in 
dentry_free, call_rcu(&mnt->mnt_rcu, delayed_free_vfsmnt) in 
cleanup_mnt, call_rcu(&dom->rcu_head, svcauth_gss_domain_release_rcu) in 
svcauth_gss_domain_release, call_rcu(&dom->rcu_head, 
svcauth_unix_domain_release_rcu) in svcauth_unix_domain_release), so 
rcu_read_lock/rcu_read_unlock for c_show/e_show can protect this trigger 
UAF.

> 
>> -static void svc_export_release(struct work_struct *work)
>> +static void svc_export_release(struct rcu_head *rcu_head)
>>   {
>> -	struct svc_export *exp = container_of(to_rcu_work(work),
>> -					      struct svc_export, ex_rwork);
>> +	struct svc_export *exp = container_of(rcu_head, struct svc_export,
>> +			ex_rcu);
>>
>> -	path_put(&exp->ex_path);
>> -	auth_domain_put(exp->ex_client);
>>   	nfsd4_fslocs_free(&exp->ex_fslocs);
>>   	export_stats_destroy(exp->ex_stats);
>>   	kfree(exp->ex_stats);
>> @@ -382,8 +369,9 @@ static void svc_export_put(struct kref *ref)
>>   {
>>   	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
>>
>> -	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
>> -	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
>> +	path_put(&exp->ex_path);
>> +	auth_domain_put(exp->ex_client);
>> +	call_rcu(&exp->ex_rcu, svc_export_release);
>>   }
> 
> Same concern here.  With path_put() and auth_domain_put() called
> directly in svc_export_put() before call_rcu(), a concurrent RCU
> reader in e_show() -> svc_export_show() or c_show() ->
> svc_export_show() could dereference freed sub-objects through
> seq_path(&exp->ex_path) or exp->ex_client->name.
> 


