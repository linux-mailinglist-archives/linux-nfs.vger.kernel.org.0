Return-Path: <linux-nfs+bounces-21250-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHu2CdCa8Gl3WAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21250-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 13:32:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FE483CBF
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 13:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 660293070FBE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18233F9F22;
	Tue, 28 Apr 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="lraCHhwT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gG0+7/nA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2436A3F2112;
	Tue, 28 Apr 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375132; cv=none; b=ln1U9LbIxTprUedMVCowa4alm8kUAgTKaynoVB2iZgOYCS1zqng8uBMJeuZMMmNsletklXzCifVlbwqCAXmSm4WRfq9XCPmCV4PluROhfIvyhcliNOp6FwHSnZENKlIjSxlL8m4pO0+/BvNftM/GA0Cw4IpIR2yonRvyK8048CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375132; c=relaxed/simple;
	bh=E5BDhzxrMGjYoDhrfR/BZNteH3acMgF9u2AjBZTK03E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Pq+zVGcfeMx0Ifu/UF8xybdbtF+xVih0NmJY1BOAxgdv0vZEM6NxD7NmGy7fYQj/x0a1qtIYrWIOjxECEX2yywS4ydoUwNrGfSKruBHT2MvlQhZhC+L74zdZgPZirW8aYETly9o4D8nIOJangzGkZTY63t16bzEN7bQLrLUN40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=lraCHhwT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gG0+7/nA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C94921D001C1;
	Tue, 28 Apr 2026 07:18:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 28 Apr 2026 07:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1777375128; x=1777461528; bh=YZuyP2ARfj2LlxsZ8mIJ1yeVL+H2uqBh9ve
	OahD/Eps=; b=lraCHhwT8rstbj1rnVKTi++zJtazfuaPXK7JTuR9yhhXfBxAbuF
	2tKmYkukmE93QmMrMhicZY5uGKNUGkVAFBqwyAg0Gnq9y/S0mk2dZp66LMeuIwVa
	HC3ktKl2lRWyUxRqgixpHcOELsGFEKBQlpNVoV81XZAvUpAJ3Fn8XvGAo8NfeVke
	AJv3a6TpOkx/yvPYXTnF4zNH4e45f2IEFp+C6PvKUSil5f9+ucmYPSPn/AkfXkeU
	4t5znhMZ4LEFhk0XxTrt2eAxjbO4r0ixmx1GvzFp3F3ogIsMoksZmDd0wwPZrwHf
	OZZH2SmTypllRoMXXk2kJBq8Nat/hdNISZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777375128; x=
	1777461528; bh=YZuyP2ARfj2LlxsZ8mIJ1yeVL+H2uqBh9veOahD/Eps=; b=g
	G0+7/nAM+ACh/6JvLxqmgK8xmZ6lXsqP4aOAw9B369wKiMel62IfGtARQq3U7vpf
	7PNoBx/OhETHcuocrbZ+5ag06xf1XYMPHkfso2nNkd1cG7RBtExq+kQmHuE+i28z
	DVE6PUI2JJ9WIVo7AAMNFxGtKl9QuMDtl1O50TpFg8cmMT5CZb1v4yRA3oJhZLlS
	CU+r1pNeY+w7a0arwxj0KZmpKpeawJhfZe7+AwRREwtN2VZxCE6AQb7xkWfX/SMF
	hU6BTUdsa8djV9fSv9E/XzMT2f/vjzRbH0L7QKXVvzweerHDtDnVEi9BepgSQECW
	k9+g7LP3dNEyfWpPYhbgg==
X-ME-Sender: <xms:l5fwaQh4uLk7d1iJCaTFR7KIJ1kNZdBdcAGcJZBVSyHE0ZA6WYUGKg>
    <xme:l5fwaVUVRBQ-EFpY7Ro2ZiIhD4KA5PWfgEy5dlt8OM_ALve54wRUVaq6wcm8MFSNp
    8sv96k5nJsrt-lBceY_bPEWcB6vkK_05FzIE14G5o3b0k8fRL8>
X-ME-Received: <xmr:l5fwaZsVeeZQ5l_AJwlZ5VWx8MfG9PdLgumVE8OIrNV5q1s0VYDwqwOXsIq0x64PTP9VtuNYVfmPKjYn5qIgDDzSRy1uEXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepjhhksehoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:l5fwaeYzIInf91PF5sQwMhPdnEZIs6H9RAC9V4-r5M5EJPIKlLW0DA>
    <xmx:l5fwaS5ZQGDZs_gXSOUr99O7fUdBWABGUxOXMpsm0JIilfPB-9xyKA>
    <xmx:l5fwaWklkwivxOX0k6kyMV0psKokmALM7RdQnpplD1omxieFXpOxtQ>
    <xmx:l5fwaYH2znH5_NDabFlIwqti6B0TK83gQ9z-BTuTlvdr20Z5559C8A>
    <xmx:mJfwaZzNxnwMZhRH8XrN7nDi1-HHASXmbH8cbD6c1ufC2I8Wi3sXrnak>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 07:18:43 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Miklos Szeredi" <miklos@szeredi.hu>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeremy Kerr" <jk@ozlabs.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in
 d_alloc_parallel()
In-reply-to: <20260428033738.GV3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
  <20260427040517.828226-5-neilb@ownmail.net>
  <20260428033738.GV3518998@ZenIV>
Date: Tue, 28 Apr 2026 21:18:39 +1000
Message-id: <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Queue-Id: 7D5FE483CBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21250-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[ownmail.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,ownmail.net:dkim,noble.neil.brown.name:mid]

On Tue, 28 Apr 2026, Al Viro wrote:
> On Mon, Apr 27, 2026 at 02:01:22PM +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > d_alloc_parallel() currently requires a wait_queue_head to be passed in.
> > This must have a life time which extends until the lookup is completed.
> >=20
> > This makes it awkward to use and particularly make it hard to use in
> > lookup_one_qstr_excl() which I hope to do in the future.
> >=20
> > This patch changes d_alloc_parallel() to use wake_up_var_locked() to
> > wake up waiters, and wait_var_event_spinlock() to wait.  dentry->d_lock
> > is used for synchronisation as it is already held and the relevant
> > times.
> >=20
> > In most cases there will be no waiters so the wake_up_var_locked()
> > call is a complete waste.  To optimise this a new ->d_flags flag is
> > added: DCACHE_LOCK_WAITERS.  This is set whenever any thread prepares to
> > wait for the dentry, and if it isn't set when DCACHE_PAR_LOOKUP is
> > cleared, no wakeup is sent.
> > (The name is deliberately generic as I plan to replace DCACHE_PAR_LOOKUP
> > with more generic per-dentry locking in the future).
> >=20
> > __d_lookup_unhash() now returns a bool rather than a wq.  This is true
> > if DCACHE_LOCK_WAITERS was sent and is used to decide to send the wake
> > up.  It would be easier to send the wakeup immediately when clearing
> > DCACHE_LOCK_WAITERS, but then the waiter could wake a bit earlier and
> > then spend time spinning on ->d_lock.  I don't know if that cost is
> > interesting.
>=20
> I definitely like the calling conventions change, so much that I'd be glad
> to pick that one Right Fucking Now.  I'd probably make the store in
> d_must_wait() conditional, though - ->d_flags and ->d_lock are in different
> cachelines and there's no need to dirty both every time we are called.
> IOW, have d_must_wait() do this:
> 	if (!d_in_lookup(dentry))
> 		return false;
> 	if (!(dentry->d_flags & DCACHE_LOCK_WAITER))
> 		dentry->d_flags |=3D DCACHE_LOCK_WAITER;
> 	return true;

The only time that DCACHE_LOCK_WAITER will already be set is when there
are two (or more) waiters as well as the thread they are waiting on.
That means three (or more) threads all accessing the same name at the
same time.  How often does that happen?  Is the micro-optimisation worth
the small increase in code size?

> Not sure if it would flow better with return values inverted (and
> negation removed from wait_var_event_spinlock(), that is)...

I think the central question is what we would call the function.

"d_lookup_finished()" might work though it could be confused with
d_lookup_done() which is quite different.
But then it would be less obvious what DCACHE_LOCK_WAITER is being set.=20
Having "wait" in the name ("d_must_wait") makes that a little clearer I
think.
So while I agree it would be nicer to not have the negation in the
wait_var_event_spinlock, I can't think of a name that would result in a
net improvement.

>=20
> >  static inline void end_dir_add(struct inode *dir, unsigned int n,
> > -			       wait_queue_head_t *d_wait)
> > +			       bool do_wake, struct dentry *de)
> >  {
> >  	smp_store_release(&dir->i_dir_seq, n + 2);
> >  	preempt_enable_nested();
> > -	if (wq_has_sleeper(d_wait))
> > -		wake_up_all(d_wait);
> > +	if (do_wake)
> > +		wake_up_var_locked(&de->d_flags, &de->d_lock);
> >  }
>=20
> This calling conventions change, OTOH, I don't like at all.  I mean,
> (dir, n, false, unused) vs. (dir, n, true, never_NULL) is seriously
> asking to be reduced to (dir, n, NULL) vs. (dir, n, never_NULL).

In the callers it is cleaner to keep the do_wake flag separate.
So the call
   end_dir_add(dir, n, do_wake, dentry)
would become
   end_dir_add(dir, n, do_wake ? dentry : NULL)

which isn't beautiful but is probably OK and worth it for the clarity
added to end_dir_add().

I'll make that change.

>=20
> > @@ -2800,29 +2793,29 @@ EXPORT_SYMBOL(d_alloc_parallel);
> >   * - Retrieve and clear the waitqueue head in dentry
> >   * - Return the waitqueue head
>=20
> ... not anymore.  The entire comment needs replacement, TBH - 2 lines of
> 3 are stale with that patch and remaining one is... ambiguous, since
> there are *two* hashes around and "Unhash the dentry" usually refers to
> the other one.
>=20
> Something like
>=20
> /*
>  * Move dentry from in-lookup state to busy-negative one.
>  *
>  * From now on d_in_lookup(dentry) will return false and dentry is gone from
>  * in-lookup hash.
>  *
>  * Anyone who had been waiting on it in d_alloc_parallel() is free to
>  * proceed after that.  Note that waking such waiters up is left to
>  * the callers; we might be called in write-side critical area for ->i_dir_=
seq,
>  * and PREEMPT_RT kernels can't have that wakeup done in those.
>  *
>  * Returns whether there are waiters to be woken up.
>  */
>=20
> perhaps?
>=20

Yes, something like that.  I'll look at it again in the morning and
see what seems best.

Thanks,
NeilBrown

