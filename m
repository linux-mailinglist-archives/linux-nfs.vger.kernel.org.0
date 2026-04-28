Return-Path: <linux-nfs+bounces-21209-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIzhI70r8GmBPQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21209-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 05:38:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DC47D1DC
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 05:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA43304DC87
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C1319860;
	Tue, 28 Apr 2026 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pNJkmPDM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22031F98D;
	Tue, 28 Apr 2026 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347458; cv=none; b=GU+kTLnsh+at7eQV5zHXtokIbLYMsfS4QbaCZq8RWWcMSZvvqp+5UDSP/7sJeRh2a6AfyIwakMfwXhjTrUu5Xvh46aOxnB/IXzH4OPWDYWMuMrZfOCdN1KaHYT1Aq83F0sb5c7gs2ohehY5DwtQHsDd1pxLiTAq2kqT2DLfM8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347458; c=relaxed/simple;
	bh=jRZUhaw6I6JKjtSbmXkgMFwHVUmUhcQq+J3lvty82Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef0PyIhY7gJT7pIofXk3x4W0GQwfpmF5i8Aelz5q7mw6KmwH7AKenAjr/yEUkfN9dRDpH6XlUFUL9aROE9tRGo+TzVjcO7Av3H3E+Otue95uDzXku/GglDefV00q9TjD2ESXF/rSs7SiCnDRksVj2HwAqRHeEhdElHQZCu1AVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pNJkmPDM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nbdvP6Vp/f9SvqO0OehGGDrf6DYlJHxQbEKPQveBRSk=; b=pNJkmPDME6sL6Pq/UqtEz3kn1s
	808HcB7Qb9udSSzfx6CwlyQrWlcwL87/iyq2GuBZm2D8Uvpy4i/AbKlBCa4NjsbwO6TGdczFo0V5j
	T+D5FecpsVCMwo/d53MwDYtNCbCqFzrI6SOM0kbeMXvZ+qYejnJvWiF3S43E59kVJOl106Ry7vfoI
	4lw+c4lAR4fsYht8rJthGQdxFgWVaV2CB/Lh7Zb/yQoxabj0Rxy8tpRhDCmk/brcrviSQuJtBEftO
	N5mHv2fBc6DbqgbBwKn3b3CHqo143XlGnlsPKVCVSO4/5xGuXZluK1l3Lp0hRxX8jaF2itA8NMqBH
	M4hOEy9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wHZGU-0000000GEnv-0FCz;
	Tue, 28 Apr 2026 03:37:38 +0000
Date: Tue, 28 Apr 2026 04:37:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in
 d_alloc_parallel()
Message-ID: <20260428033738.GV3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
 <20260427040517.828226-5-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427040517.828226-5-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: 392DC47D1DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21209-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:dkim,brown.name:email]

On Mon, Apr 27, 2026 at 02:01:22PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> d_alloc_parallel() currently requires a wait_queue_head to be passed in.
> This must have a life time which extends until the lookup is completed.
> 
> This makes it awkward to use and particularly make it hard to use in
> lookup_one_qstr_excl() which I hope to do in the future.
> 
> This patch changes d_alloc_parallel() to use wake_up_var_locked() to
> wake up waiters, and wait_var_event_spinlock() to wait.  dentry->d_lock
> is used for synchronisation as it is already held and the relevant
> times.
> 
> In most cases there will be no waiters so the wake_up_var_locked()
> call is a complete waste.  To optimise this a new ->d_flags flag is
> added: DCACHE_LOCK_WAITERS.  This is set whenever any thread prepares to
> wait for the dentry, and if it isn't set when DCACHE_PAR_LOOKUP is
> cleared, no wakeup is sent.
> (The name is deliberately generic as I plan to replace DCACHE_PAR_LOOKUP
> with more generic per-dentry locking in the future).
> 
> __d_lookup_unhash() now returns a bool rather than a wq.  This is true
> if DCACHE_LOCK_WAITERS was sent and is used to decide to send the wake
> up.  It would be easier to send the wakeup immediately when clearing
> DCACHE_LOCK_WAITERS, but then the waiter could wake a bit earlier and
> then spend time spinning on ->d_lock.  I don't know if that cost is
> interesting.

I definitely like the calling conventions change, so much that I'd be glad
to pick that one Right Fucking Now.  I'd probably make the store in
d_must_wait() conditional, though - ->d_flags and ->d_lock are in different
cachelines and there's no need to dirty both every time we are called.
IOW, have d_must_wait() do this:
	if (!d_in_lookup(dentry))
		return false;
	if (!(dentry->d_flags & DCACHE_LOCK_WAITER))
		dentry->d_flags |= DCACHE_LOCK_WAITER;
	return true;
Not sure if it would flow better with return values inverted (and
negation removed from wait_var_event_spinlock(), that is)...

>  static inline void end_dir_add(struct inode *dir, unsigned int n,
> -			       wait_queue_head_t *d_wait)
> +			       bool do_wake, struct dentry *de)
>  {
>  	smp_store_release(&dir->i_dir_seq, n + 2);
>  	preempt_enable_nested();
> -	if (wq_has_sleeper(d_wait))
> -		wake_up_all(d_wait);
> +	if (do_wake)
> +		wake_up_var_locked(&de->d_flags, &de->d_lock);
>  }

This calling conventions change, OTOH, I don't like at all.  I mean,
(dir, n, false, unused) vs. (dir, n, true, never_NULL) is seriously
asking to be reduced to (dir, n, NULL) vs. (dir, n, never_NULL).

> @@ -2800,29 +2793,29 @@ EXPORT_SYMBOL(d_alloc_parallel);
>   * - Retrieve and clear the waitqueue head in dentry
>   * - Return the waitqueue head

... not anymore.  The entire comment needs replacement, TBH - 2 lines of
3 are stale with that patch and remaining one is... ambiguous, since
there are *two* hashes around and "Unhash the dentry" usually refers to
the other one.

Something like

/*
 * Move dentry from in-lookup state to busy-negative one.
 *
 * From now on d_in_lookup(dentry) will return false and dentry is gone from
 * in-lookup hash.
 *
 * Anyone who had been waiting on it in d_alloc_parallel() is free to
 * proceed after that.  Note that waking such waiters up is left to
 * the callers; we might be called in write-side critical area for ->i_dir_seq,
 * and PREEMPT_RT kernels can't have that wakeup done in those.
 *
 * Returns whether there are waiters to be woken up.
 */

perhaps?

