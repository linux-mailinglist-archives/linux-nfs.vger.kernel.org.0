Return-Path: <linux-nfs+bounces-3426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0468D1165
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 03:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09C21C20F98
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2024 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9815BB;
	Tue, 28 May 2024 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ScPlXtUq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zC+S6QMQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ScPlXtUq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zC+S6QMQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE4364
	for <linux-nfs@vger.kernel.org>; Tue, 28 May 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716859199; cv=none; b=OBynBePXp71WyoKrvWOGKOS5yvDdoOOWbmHUArV8PnstZXv/lBeoLveFhzyv6I9CAqRkrgJfeibMMxfBovqbharm0TwLFtWbFgRggqe75MFcb7v8XCfxNkmzow44YZQ9U2YTgQWkVA6vixoOvs+mjBO2Zt85yQ023waeBnAGyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716859199; c=relaxed/simple;
	bh=38QbRZIQU+5UU0ioQEdY8FCCrexj7+8Wa3pjJ0lQL1g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RpiwG08WfshxpWBXk74IkaQSMPzKP1hFfl2n4QJKQJjYllTCS6FrpXxVVcbIDXsghr9jw0p0x5rLHhL/d3M0Qtocx789wMQwzinQsmLRJ1qHLrQA9EE2uomxbhQBobVnEHZ7/hIL8dEw+Xum+xxxBrsezkAiPCxgxK90jgHx6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ScPlXtUq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zC+S6QMQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ScPlXtUq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zC+S6QMQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1CB52005E;
	Tue, 28 May 2024 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716859195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLmNMpvCdlM/U/b7nbGr8iAgTS4dSciwa6zNuAdwFl8=;
	b=ScPlXtUqPiniBadY61Nct59JY/8UEkOp1guQS1BeiNvCd8Wk0tPhbzzwCCMyuHUZ1hAytV
	owYBSPZp0YGmpmZIa2ZBol7nkaTPowcGPYz+TwTp2q8m9o+xJPOUt+pJBYccKi9Tc88TbJ
	YdXgB7ksYJHMf4y8Ycz2Gxht9lLZ32s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716859195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLmNMpvCdlM/U/b7nbGr8iAgTS4dSciwa6zNuAdwFl8=;
	b=zC+S6QMQV/k3kfHpKviCM250mSgP86QDcXxJ/pQPs40Q0vHCpFo4dEbs7Bkt+FO2AlQ1cV
	myhEa/Mqbp2rt6Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ScPlXtUq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zC+S6QMQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716859195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLmNMpvCdlM/U/b7nbGr8iAgTS4dSciwa6zNuAdwFl8=;
	b=ScPlXtUqPiniBadY61Nct59JY/8UEkOp1guQS1BeiNvCd8Wk0tPhbzzwCCMyuHUZ1hAytV
	owYBSPZp0YGmpmZIa2ZBol7nkaTPowcGPYz+TwTp2q8m9o+xJPOUt+pJBYccKi9Tc88TbJ
	YdXgB7ksYJHMf4y8Ycz2Gxht9lLZ32s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716859195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLmNMpvCdlM/U/b7nbGr8iAgTS4dSciwa6zNuAdwFl8=;
	b=zC+S6QMQV/k3kfHpKviCM250mSgP86QDcXxJ/pQPs40Q0vHCpFo4dEbs7Bkt+FO2AlQ1cV
	myhEa/Mqbp2rt6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 598D913A55;
	Tue, 28 May 2024 01:19:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qI17OjgxVWZ9CwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 28 May 2024 01:19:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Trond Myklebust" <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "richard+debian+bugreport@kojedz.in" <richard+debian+bugreport@kojedz.in>,
 "1071501@bugs.debian.org" <1071501@bugs.debian.org>
Subject: Re: [PATCH] NFS: add barriers when testing for NFS_FSDATA_BLOCKED
In-reply-to: <a14f4bc37abb28c20cac7de3722f4b86c1fd28fb.camel@hammerspace.com>
References: <171677905033.27191.7405469009187788343@noble.neil.brown.name>,
 <a14f4bc37abb28c20cac7de3722f4b86c1fd28fb.camel@hammerspace.com>
Date: Tue, 28 May 2024 11:19:41 +1000
Message-id: <171685918152.27191.2794964215450312426@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A1CB52005E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[debian,bugreport];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, 28 May 2024, Trond Myklebust wrote:
> On Mon, 2024-05-27 at 13:04 +1000, NeilBrown wrote:
> > 
> > dentry->d_fsdata is set to NFS_FSDATA_BLOCKED while unlinking or
> > renaming-over a file to ensure that no open succeeds while the NFS
> > operation progressed on the server.
> > 
> > Setting dentry->d_fsdata to NFS_FSDATA_BLOCKED is done under ->d_lock
> > after checking the refcount is not elevated.  Any attempt to open the
> > file (through that name) will go through lookp_open() which will take
> > ->d_lock while incrementing the refcount, we can be sure that once
> > the
> > new value is set, __nfs_lookup_revalidate() *will* see the new value
> > and
> > will block.
> > 
> > We don't have any locking guarantee that when we set ->d_fsdata to
> > NULL,
> > the wait_var_event() in __nfs_lookup_revalidate() will notice.
> > wait/wake primitives do NOT provide barriers to guarantee order.  We
> > must use smp_load_acquire() in wait_var_event() to ensure we look at
> > an
> > up-to-date value, and must use smp_store_release() before
> > wake_up_var().
> > 
> > This patch adds those barrier functions and factors out
> > block_revalidate() and unblock_revalidate() far clarity.
> > 
> > There is also a hypothetical bug in that if memory allocation fails
> > (which never happens in practice) we might leave ->d_fsdata locked.
> > This patch adds the missing call to unblock_revalidate().
> > 
> > Reported-and-tested-by: Richard Kojedzinszky
> > <richard+debian+bugreport@kojedz.in>
> > Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071501
> > Fixes: 3c59366c207e ("NFS: don't unhash dentry during unlink/rename")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfs/dir.c | 44 +++++++++++++++++++++++++++++---------------
> >  1 file changed, 29 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index ac505671efbd..c91dc36d41cc 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -1802,9 +1802,10 @@ __nfs_lookup_revalidate(struct dentry *dentry,
> > unsigned int flags,
> >  		if (parent != READ_ONCE(dentry->d_parent))
> >  			return -ECHILD;
> >  	} else {
> > -		/* Wait for unlink to complete */
> > +		/* Wait for unlink to complete - see
> > unblock_revalidate() */
> >  		wait_var_event(&dentry->d_fsdata,
> > -			       dentry->d_fsdata !=
> > NFS_FSDATA_BLOCKED);
> > +			       smp_load_acquire(&dentry->d_fsdata)
> > +			       != NFS_FSDATA_BLOCKED);
> 
> Doesn't this end up being a reversed ACQUIRE+RELEASE as described in
> the "LOCK ACQUISITION FUNCTIONS" section of Documentation/memory-
> barriers.txt?

I don't think so.  That section is talking about STORE operations which
can move backwards through ACQUIRE and forwards through RELEASE.

Above we have a LOAD operation which mustn't move backwards through
ACQUIRE.  Below there is a STORE operation which mustn't move forwards
through a RELEASE.  Both of those are guaranteed.

> 
> IOW: Shouldn't the above rather be using READ_ONCE()?
> 
> >  		parent = dget_parent(dentry);
> >  		ret = reval(d_inode(parent), dentry, flags);
> >  		dput(parent);
> > @@ -1817,6 +1818,26 @@ static int nfs_lookup_revalidate(struct dentry
> > *dentry, unsigned int flags)
> >  	return __nfs_lookup_revalidate(dentry, flags,
> > nfs_do_lookup_revalidate);
> >  }
> >  
> > +static void block_revalidate(struct dentry *dentry)
> > +{
> > +	/* old devname - just in case */
> > +	kfree(dentry->d_fsdata);
> > +
> > +	/* Any new reference that could lead to an open
> > +	 * will take ->d_lock in lookup_open() -> d_lookup().
> > +	 */
> > +	lockdep_assert_held(&dentry->d_lock);
> > +
> > +	dentry->d_fsdata = NULL;
> 
> Why are you doing a barrier free change to dentry->d_fsdata here when
> you have the memory barrier protected change in unblock_revalidate()?

Ouch. This should be

	dentry->d_fsdata = NFS_FSDATA_BLOCKED;

I messed that up when rearranging the code after testing.

This doesn't need a barrier because a spinlock is held.  We check the
refcount under the spinlock and only proceed if there are no other
references.  So if __nfs_lookup_revalidate gets called concurrently, it
must have got a new reference, and that requires the same spinlock.
So if it is called after this assignment, the spinlock will provide all
needed barriers.

> 
> > +}
> > +
> > +static void unblock_revalidate(struct dentry *dentry)
> > +{
> > +	/* store_release ensures wait_var_event() sees the update */
> > +	smp_store_release(&dentry->d_fsdata, NULL);
> 
> Shouldn't this be a WRITE_ONCE(), for the same reason as above?

No, for the same reason as above.  WRITE_ONCE() doesn't provide any
memory barriers, it only avoid compiler optimisations.  Here we really
need the barrier on some CPUs.

Thanks for the review.

NeilBrown

> 
> > +	wake_up_var(&dentry->d_fsdata);
> > +}
> > +
> >  /*
> >   * A weaker form of d_revalidate for revalidating just the
> > d_inode(dentry)
> >   * when we don't really care about the dentry name. This is called
> > when a
> > @@ -2501,15 +2522,12 @@ int nfs_unlink(struct inode *dir, struct
> > dentry *dentry)
> >  		spin_unlock(&dentry->d_lock);
> >  		goto out;
> >  	}
> > -	/* old devname */
> > -	kfree(dentry->d_fsdata);
> > -	dentry->d_fsdata = NFS_FSDATA_BLOCKED;
> > +	block_revalidate(dentry);
> >  
> >  	spin_unlock(&dentry->d_lock);
> >  	error = nfs_safe_remove(dentry);
> >  	nfs_dentry_remove_handle_error(dir, dentry, error);
> > -	dentry->d_fsdata = NULL;
> > -	wake_up_var(&dentry->d_fsdata);
> > +	unblock_revalidate(dentry);
> >  out:
> >  	trace_nfs_unlink_exit(dir, dentry, error);
> >  	return error;
> > @@ -2616,8 +2634,7 @@ nfs_unblock_rename(struct rpc_task *task,
> > struct nfs_renamedata *data)
> >  {
> >  	struct dentry *new_dentry = data->new_dentry;
> >  
> > -	new_dentry->d_fsdata = NULL;
> > -	wake_up_var(&new_dentry->d_fsdata);
> > +	unblock_revalidate(new_dentry);
> >  }
> >  
> >  /*
> > @@ -2679,11 +2696,6 @@ int nfs_rename(struct mnt_idmap *idmap, struct
> > inode *old_dir,
> >  		if (WARN_ON(new_dentry->d_flags &
> > DCACHE_NFSFS_RENAMED) ||
> >  		    WARN_ON(new_dentry->d_fsdata ==
> > NFS_FSDATA_BLOCKED))
> >  			goto out;
> > -		if (new_dentry->d_fsdata) {
> > -			/* old devname */
> > -			kfree(new_dentry->d_fsdata);
> > -			new_dentry->d_fsdata = NULL;
> > -		}
> >  
> >  		spin_lock(&new_dentry->d_lock);
> >  		if (d_count(new_dentry) > 2) {
> > @@ -2705,7 +2717,7 @@ int nfs_rename(struct mnt_idmap *idmap, struct
> > inode *old_dir,
> >  			new_dentry = dentry;
> >  			new_inode = NULL;
> >  		} else {
> > -			new_dentry->d_fsdata = NFS_FSDATA_BLOCKED;
> > +			block_revalidate(new_dentry);
> >  			must_unblock = true;
> >  			spin_unlock(&new_dentry->d_lock);
> >  		}
> > @@ -2717,6 +2729,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct
> > inode *old_dir,
> >  	task = nfs_async_rename(old_dir, new_dir, old_dentry,
> > new_dentry,
> >  				must_unblock ? nfs_unblock_rename :
> > NULL);
> >  	if (IS_ERR(task)) {
> > +		if (must_unblock)
> > +			unblock_revalidate(new_dentry);
> >  		error = PTR_ERR(task);
> >  		goto out;
> >  	}
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
> 


