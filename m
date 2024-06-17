Return-Path: <linux-nfs+bounces-3945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89C90BCFA
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 23:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98ED1C22A89
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B219146C;
	Mon, 17 Jun 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jXLkls7G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="awc7LiFL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jXLkls7G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="awc7LiFL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE918FC90;
	Mon, 17 Jun 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659984; cv=none; b=Q0QqvDuxx1MEpmjQAZA5DzQhJoE6zSlcv+GnTPFp4v3ygcNKfhwRo/1XyB1CsbBkYAEDxzkcgXlX9v3D9Waig4342GPr5+LETC5x8Xyscm7FjUToKaRSHEsvMVZH/XQKmtTD6zpqJ9snALwnaVjR3ZXGTJB9SSeuNIjVxQvZtp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659984; c=relaxed/simple;
	bh=sdaDMvLQCreBwTA57eVWyzB2b5NZ72cf2xJlc9gYc0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxHr5ag2ZScUqieFQHFR5dP+3q0acjzk/Y4SB1YA8CCqUFC1HwciNt2VlitbdZB2TO6I07xQ6+qYvBeBmG8DtlK8luQmccYSkFLQx8Es6MEQ4c8wfq0T4Fw+BcS9JMvFGuQELM4/9AYKNTQPXeftUi+/pj7jvqeU61qFVnDBgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jXLkls7G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=awc7LiFL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jXLkls7G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=awc7LiFL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3A11F747;
	Mon, 17 Jun 2024 21:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718659980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZIkcM2Jg5cQeoR/5GuAI6KY2sxiEb8XUmVreSeq1Lk=;
	b=jXLkls7Gg36TdnuZn/Uovq+cvGYbKqMGUCVYKgxcsEUB9Jsne9spvnQSAHPGhwEwynFk9M
	4LAEhLZj3/x60Gc7Vitf/UJp70UcNNd/hv6x9nXYiFm7a3P9oxE2PkrEmTGEydnUnddJQ2
	x1NhhexsmnRLDq2lGyPP7ZxiWDUOhRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718659980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZIkcM2Jg5cQeoR/5GuAI6KY2sxiEb8XUmVreSeq1Lk=;
	b=awc7LiFLCbsytHw/yfYy1gWG7NzLvYeAvlEiGnXo//N6X5M7i0AWfkI3UmGQETKUOZc6Ch
	f434vBWqXK7zccDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jXLkls7G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=awc7LiFL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718659980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZIkcM2Jg5cQeoR/5GuAI6KY2sxiEb8XUmVreSeq1Lk=;
	b=jXLkls7Gg36TdnuZn/Uovq+cvGYbKqMGUCVYKgxcsEUB9Jsne9spvnQSAHPGhwEwynFk9M
	4LAEhLZj3/x60Gc7Vitf/UJp70UcNNd/hv6x9nXYiFm7a3P9oxE2PkrEmTGEydnUnddJQ2
	x1NhhexsmnRLDq2lGyPP7ZxiWDUOhRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718659980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZIkcM2Jg5cQeoR/5GuAI6KY2sxiEb8XUmVreSeq1Lk=;
	b=awc7LiFLCbsytHw/yfYy1gWG7NzLvYeAvlEiGnXo//N6X5M7i0AWfkI3UmGQETKUOZc6Ch
	f434vBWqXK7zccDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 428F813AAA;
	Mon, 17 Jun 2024 21:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BpV7D4yrcGbuUQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Jun 2024 21:33:00 +0000
Message-ID: <e7cbca4d-9b34-46f8-961a-9f8ddc92be21@suse.cz>
Date: Mon, 17 Jun 2024 23:34:04 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: paulmck@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
 bridge@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>, netdev@vger.kernel.org,
 wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org,
 ecryptfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-can@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 kasan-dev <kasan-dev@googlegroups.com>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240612143305.451abf58@kernel.org>
 <baee4d58-17b4-4918-8e45-4d8068a23e8c@paulmck-laptop>
 <Zmov7ZaL-54T9GiM@zx2c4.com> <Zmo9-YGraiCj5-MI@zx2c4.com>
 <08ee7eb2-8d08-4f1f-9c46-495a544b8c0e@paulmck-laptop>
 <Zmrkkel0Fo4_g75a@zx2c4.com> <e926e3c6-05ce-4ba6-9e2e-e5f3b37bcc23@suse.cz>
 <3b6fe525-626c-41fb-8625-3925ca820d8e@paulmck-laptop>
 <6711935d-20b5-41c1-8864-db3fc7d7823d@suse.cz>
 <1755282b-e3f5-4d18-9eab-fc6a29ca5886@paulmck-laptop>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <1755282b-e3f5-4d18-9eab-fc6a29ca5886@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,gmail.com,kernel.org,inria.fr,vger.kernel.org,lists.linux.dev,efficios.com,lists.ozlabs.org,linux.ibm.com,csgroup.eu,lists.zx2c4.com,suse.de,netapp.com,oracle.com,talpey.com,netfilter.org,googlegroups.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8F3A11F747
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 6/17/24 8:54 PM, Paul E. McKenney wrote:
> On Mon, Jun 17, 2024 at 07:23:36PM +0200, Vlastimil Babka wrote:
>> On 6/17/24 6:12 PM, Paul E. McKenney wrote:
>>> On Mon, Jun 17, 2024 at 05:10:50PM +0200, Vlastimil Babka wrote:
>>>> On 6/13/24 2:22 PM, Jason A. Donenfeld wrote:
>>>>> On Wed, Jun 12, 2024 at 08:38:02PM -0700, Paul E. McKenney wrote:
>>>>>> o	Make the current kmem_cache_destroy() asynchronously wait for
>>>>>> 	all memory to be returned, then complete the destruction.
>>>>>> 	(This gets rid of a valuable debugging technique because
>>>>>> 	in normal use, it is a bug to attempt to destroy a kmem_cache
>>>>>> 	that has objects still allocated.)
>>>>
>>>> This seems like the best option to me. As Jason already said, the debugging
>>>> technique is not affected significantly, if the warning just occurs
>>>> asynchronously later. The module can be already unloaded at that point, as
>>>> the leak is never checked programatically anyway to control further
>>>> execution, it's just a splat in dmesg.
>>>
>>> Works for me!
>>
>> Great. So this is how a prototype could look like, hopefully? The kunit test
>> does generate the splat for me, which should be because the rcu_barrier() in
>> the implementation (marked to be replaced with the real thing) is really
>> insufficient. Note the test itself passes as this kind of error isn't wired
>> up properly.
> 
> ;-) ;-) ;-)

Yeah yeah, I just used the kunit module as a convenient way add the code
that should see if there's the splat :)

> Some might want confirmation that their cleanup efforts succeeded,
> but if so, I will let them make that known.

It could be just the kunit test that could want that, but I don't see
how it could wrap and inspect the result of the async handling and
suppress the splats for intentionally triggered errors as many of the
other tests do.

>> Another thing to resolve is the marked comment about kasan_shutdown() with
>> potential kfree_rcu()'s in flight.
> 
> Could that simply move to the worker function?  (Hey, had to ask!)

I think I had a reason why not, but I guess it could move. It would just
mean that if any objects are quarantined, we'll go for the async freeing
even though those could be flushed immediately. Guess that's not too bad.

>> Also you need CONFIG_SLUB_DEBUG enabled otherwise node_nr_slabs() is a no-op
>> and it might fail to notice the pending slabs. This will need to change.
> 
> Agreed.
> 
> Looks generally good.  A few questions below, to be taken with a
> grain of salt.

Thanks!

>> +static void kmem_cache_kfree_rcu_destroy_workfn(struct work_struct *work)
>> +{
>> +	struct kmem_cache *s;
>> +	int err = -EBUSY;
>> +	bool rcu_set;
>> +
>> +	s = container_of(work, struct kmem_cache, async_destroy_work);
>> +
>> +	// XXX use the real kmem_cache_free_barrier() or similar thing here
>> +	rcu_barrier();

Note here's the barrier.

>> +	cpus_read_lock();
>> +	mutex_lock(&slab_mutex);
>> +
>> +	rcu_set = s->flags & SLAB_TYPESAFE_BY_RCU;
>> +
>> +	err = shutdown_cache(s, true);
> 
> This is currently the only call to shutdown_cache()?  So there is to be
> a way for the caller to have some influence over the value of that bool?

Not the only caller, there's still the initial attempt in
kmem_cache_destroy() itself below.

> 
>> +	WARN(err, "kmem_cache_destroy %s: Slab cache still has objects",
>> +	     s->name);
> 
> Don't we want to have some sort of delay here?  Or is this the
> 21-second delay and/or kfree_rcu_barrier() mentioned before?

Yes this is after the barrier. The first immediate attempt to shutdown
doesn't warn.

>> +	mutex_unlock(&slab_mutex);
>> +	cpus_read_unlock();
>> +	if (!err && !rcu_set)
>> +		kmem_cache_release(s);
>> +}
>> +
>>  void kmem_cache_destroy(struct kmem_cache *s)
>>  {
>>  	int err = -EBUSY;
>> @@ -494,9 +527,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
>>  	if (s->refcount)
>>  		goto out_unlock;
>>  
>> -	err = shutdown_cache(s);
>> -	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
>> -	     __func__, s->name, (void *)_RET_IP_);
>> +	err = shutdown_cache(s, false);
>> +	if (err)
>> +		schedule_work(&s->async_destroy_work);

And here's the initial attempt that used to warn but now doesn't and
instead schedules the async one.

>>  out_unlock:
>>  	mutex_unlock(&slab_mutex);
>>  	cpus_read_unlock();
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1617d8014ecd..4d435b3d2b5f 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5342,7 +5342,8 @@ static void list_slab_objects(struct kmem_cache *s, struct slab *slab,
>>   * This is called from __kmem_cache_shutdown(). We must take list_lock
>>   * because sysfs file might still access partial list after the shutdowning.
>>   */
>> -static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>> +static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n,
>> +			 bool warn_inuse)
>>  {
>>  	LIST_HEAD(discard);
>>  	struct slab *slab, *h;
>> @@ -5353,7 +5354,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>>  		if (!slab->inuse) {
>>  			remove_partial(n, slab);
>>  			list_add(&slab->slab_list, &discard);
>> -		} else {
>> +		} else if (warn_inuse) {
>>  			list_slab_objects(s, slab,
>>  			  "Objects remaining in %s on __kmem_cache_shutdown()");
>>  		}
>> @@ -5378,7 +5379,7 @@ bool __kmem_cache_empty(struct kmem_cache *s)
>>  /*
>>   * Release all resources used by a slab cache.
>>   */
>> -int __kmem_cache_shutdown(struct kmem_cache *s)
>> +int __kmem_cache_shutdown(struct kmem_cache *s, bool warn_inuse)
>>  {
>>  	int node;
>>  	struct kmem_cache_node *n;
>> @@ -5386,7 +5387,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
>>  	flush_all_cpus_locked(s);
>>  	/* Attempt to free all objects */
>>  	for_each_kmem_cache_node(s, node, n) {
>> -		free_partial(s, n);
>> +		free_partial(s, n, warn_inuse);
>>  		if (n->nr_partial || node_nr_slabs(n))
>>  			return 1;
>>  	}
>>

