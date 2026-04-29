Return-Path: <linux-nfs+bounces-21267-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM6jFoeW8WkyigEAu9opvQ
	(envelope-from <linux-nfs+bounces-21267-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 07:26:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98848F6C3
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 07:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48500303298D
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9A388398;
	Wed, 29 Apr 2026 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CBcmEff+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC55344052;
	Wed, 29 Apr 2026 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440385; cv=none; b=fdWfFt9tJdFeSxgv/kVS0ZTFBVhknP1ugkjSwFX3MypiYDZO/VyVLlJT0SMvKm+rb3RM+cOicbgX6eJq5d4T2CXvIHRZlVZDczedpqyFUijjlEIbjGvjw0v9uGVKEJeXvQZTXDLt1HRUD1njm4aIIaM8sy5dNZo1p9ix9FXko6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440385; c=relaxed/simple;
	bh=Jlx867jKI4gLtNGLTomyfHTBL5NvB7fYilqNwVBKmY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0HOmJf3tgzD4sNSYITQtblboz27H/DPwFE6/z62C4OfFVrllfjsV17ZBOlUeFiJHRlKUQaWky10yIqnCaDf52TasxJpwl+hdyToEr8jR1IypeYLU0yjOCyx3DUTLoC9sblkM6S5Mjpt3dgMA6rLMkUoI4gHRgspyMCN/Ewwmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CBcmEff+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zTapJ0y6zMogdD2OWXYHRyJtC7ULtGdRwYh0eCsShS0=; b=CBcmEff+MpkXPtTX2XD9NTnG3h
	MGqvsdvnIVS1HL4ZhxtQfcDl4DjnV+t+LXW0t9U/ZlpZsTAYoA48HDszASldSFYBZFtrUoOeVZUmA
	AVeWDClMnjfnrkhxbIR3hrL7hk0FNpNowGmkvCxzjdb2/bu7XB5ksdSNZyRSNC/UXXfSmg2OeHpK3
	4zhThQAdTO+G4n22zCEnzjUl1pjUSx37K9ilTF9/IkFYF+LGp5xbrE2ckC+YeMoNbQAFroEuLUTVd
	wsU5ffu+Sru5HGDmzcWQ1tHXckrWixX16VgeBLrAloE5ZauAlm3IXG34kmSpKq6BSiYl0sO3Tfjm7
	AKcz7L+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wHxRK-00000005Usd-0Io6;
	Wed, 29 Apr 2026 05:26:26 +0000
Date: Wed, 29 Apr 2026 06:26:26 +0100
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
Message-ID: <20260429052626.GY3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
 <20260427040517.828226-5-neilb@ownmail.net>
 <20260428033738.GV3518998@ZenIV>
 <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
 <20260428142225.GX3518998@ZenIV>
 <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: AA98848F6C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21267-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

On Wed, Apr 29, 2026 at 09:26:54AM +1000, NeilBrown wrote:

> > More to the point, why not set DCACHE_LOCK_WAITER as soon as we grab ->d_lock
> > there?  Then waiting becomes simply "wait until !d_in_lookup()".  Sure, we
> > might end up setting DCACHE_LOCK_WAITER on a dentry that has just dropped
> > DCACHE_PAR_LOOKUP - who cares?
> > 
> > While we are at it, do we need to drop it when we clear PAR_LOOKUP?  Because
> > if we do not, the whole "what do we return from __d_lookup_unhash()" thing
> > disappears - we simply pass the dentry to end_dir_add() and have it check
> > ->d_flags & DCACHE_LOCK_WAITER to decide whether to bother with wakeup.
> > 
> 
> Yes, your are right.
> 
> I've been thinking of this mostly in the context of locking the dentry for
> directory ops, for which lookup is just one special case.
> In that context the dentry can be locked and unlocked multiple time so
> we really want to clear DCACHE_LOCK_WAITERS on each unlock.
> 
> However in the current code it is only used for lookup which only
> happens once on a given dentry so we never need to clear
> DCACHE_LOCK_WAITERS.
> 
> On the basis that we shouldn't add complexity until we actually need it,
> I'll rename DCACHE_LOCK_WAITERS to DCACHE_LOOKUP_WAITERS and never clear
> it, as you suggest.

Alternative variant (and I'm pretty sure that it will generate good code)
would be this:

static inline void d_wait_lookup(struct dentry *dentry)
{
        if (likely(d_in_lookup(dentry)) {
		dentry->d_flags |= DCACHE_LOOKUP_WAITERS;
		wait_var_event_spinlock(&dentry->d_flags,
					!d_in_lookup(dentry),
					&dentry->d_lock);
	}
}

In __d_lookup_unhash(): just don't return anything and lose the parts
related to ->d_wait (including ->d_lru initialization - same as in your
patch, for the same reason).  Similar to your variant, except that
DCACHE_LOOKUP_WAITERS is *not* cleared.  Or checked, for that matter -
you only do that to find the return value.

In d_alloc_parallel(): lose the 'wq' argument, along with the store
to ->d_wait.

Add
// must be in the same ->d_lock scope as __d_lookup_unhash()
static inline void __d_wake_in_lookup_waiters(struct dentry *dentry)
{
	if (dentry->d_flags & DCACHE_LOOKUP_WAITERS) {
		wake_up_var_locked(&dentry->d_flags, &dentry->d_lock);
		dentry->d_flags &= ~DCACHE_LOOKUP_WAITERS;
	}
}

and have
void __d_lookup_unhash_wake(struct dentry *dentry)
{
        spin_lock(&dentry->d_lock);
	__d_lookup_unhash(dentry);
	__d_wake_in_lookup_waiters(dentry);
	spin_unlock(&dentry->d_lock);
}

static inline void end_dir_add(struct inode *dir, unsigned int n,
                               struct dentry *dentry)
{
	smp_store_release(&dir->i_dir_seq, n + 2);
	preempt_enable_nested();
	__d_wake_in_lookup_waiters(dentry);
}

with obvious adjustments in end_dir_add().  That's it.  Outside of fs/dcache.c,
same as in the patch you've posted, modulo renaming you've suggested for new flag.

That yields the same semantics for flags as your variant does (DCACHE_LOOKUP_WAITERS
may be present only along with DCACHE_PAR_LOOKUP), and fs/dcache.c part is more
straightforward that way, IMO.

