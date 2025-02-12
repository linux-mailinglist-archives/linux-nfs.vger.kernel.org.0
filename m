Return-Path: <linux-nfs+bounces-10068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75782A33250
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 23:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047C43A7BFE
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Feb 2025 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ECA1FFC59;
	Wed, 12 Feb 2025 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r2RNC71P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="25tRtSmM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r2RNC71P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="25tRtSmM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06935190470
	for <linux-nfs@vger.kernel.org>; Wed, 12 Feb 2025 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398624; cv=none; b=Yq1RWN+iqlHVUguv06jXyrTpRo+5neC4ScDmvUl/GpPvNh+rwlaiF2RWCoWs2JRIo+gMngRTwedRdXS01xO2F0eMpx0T/k/y3mGqcRuT6c83V5J0KaOk6du1/A/sXnUDevEcD7xbnbr8LOF9vGUl3lwzSxr/bnLmyxfkQWZuzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398624; c=relaxed/simple;
	bh=0UXWhVueCsFe1ypE/hfWEjAW2B7EGfTnCt9J9WUF6NE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=U87k3jPB4uwxTAnmIj6OzNrRE4WpUMEYXkf298SIjcSHPmQH646Y0jV87DDGkOK5JGTsSoke24rsf7BuA5u01Q6Ry6aQv+AbpkOo9UtNM/xybv5lf1XiJ4Lv8G82lAYOEQkiwP5OPIZ7pX3gHvdJKy90xQEYPNrPBR8F3O2NSZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r2RNC71P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=25tRtSmM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r2RNC71P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=25tRtSmM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F205A1F890;
	Wed, 12 Feb 2025 22:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739398620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub9J9E8SxNXGaPHnJRIIpbCthGSOWWZ2ANzxm6/TYII=;
	b=r2RNC71Pn9i5UU5kFzCxttpHiKQE61C4xIteUIQAUh9y5mg1L3DFipPlf4fO3wZIezIU2y
	jrvaIHbMcjFm0s4/zrhM33SHOh6OZlCtUPk/jI2CL0/3/5iOPkAXwVGadTO2J8eZLWFWf3
	yJRFenqDJeIwoW1kFsv0SXjFVlKHsyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739398620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub9J9E8SxNXGaPHnJRIIpbCthGSOWWZ2ANzxm6/TYII=;
	b=25tRtSmM2sJhlhylIWNhtZS027Bz+4aieOouTPq3V0QQXSv9BfzNXJRyYPnjN6F36pbMTf
	1+MFZDgrv7CTX4AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r2RNC71P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=25tRtSmM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739398620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub9J9E8SxNXGaPHnJRIIpbCthGSOWWZ2ANzxm6/TYII=;
	b=r2RNC71Pn9i5UU5kFzCxttpHiKQE61C4xIteUIQAUh9y5mg1L3DFipPlf4fO3wZIezIU2y
	jrvaIHbMcjFm0s4/zrhM33SHOh6OZlCtUPk/jI2CL0/3/5iOPkAXwVGadTO2J8eZLWFWf3
	yJRFenqDJeIwoW1kFsv0SXjFVlKHsyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739398620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ub9J9E8SxNXGaPHnJRIIpbCthGSOWWZ2ANzxm6/TYII=;
	b=25tRtSmM2sJhlhylIWNhtZS027Bz+4aieOouTPq3V0QQXSv9BfzNXJRyYPnjN6F36pbMTf
	1+MFZDgrv7CTX4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 991E113AEF;
	Wed, 12 Feb 2025 22:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZxHpE9kdrWeKRwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Feb 2025 22:16:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dave Chinner" <david@fromorbit.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: filecache: remove race handling.
In-reply-to: <Z6qMrhV11Dtcveja@dread.disaster.area>
References: <>, <Z6qMrhV11Dtcveja@dread.disaster.area>
Date: Thu, 13 Feb 2025 09:16:50 +1100
Message-id: <173939861036.22054.7500741229199220325@noble.neil.brown.name>
X-Rspamd-Queue-Id: F205A1F890
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 11 Feb 2025, Dave Chinner wrote:
> On Fri, Feb 07, 2025 at 04:15:11PM +1100, NeilBrown wrote:
> > The race that this code tries to protect against is not interesting.
> > The code is problematic as we access the "nf" after we have given our
> > reference to the lru system.  While that take 2+ seconds to free things
> > it is still poor form.
> > 
> > The only interesting race I can find would be with
> > nfsd_file_close_inode_sync();
> > This is the only place that really doesn't want the file to stay on the
> > LRU when unhashed (which is the direct consequence of the race).
> > 
> > However for the race to happen, some other thread must own a reference
> > to a file and be putting in while nfsd_file_close_inode_sync() is trying
> > to close all files for an inode.  If this is possible, that other thread
> > could simply call nfsd_file_put() a little bit later and the result
> > would be the same: not all files are closed when
> > nfsd_file_close_inode_sync() completes.
> > 
> > If this was really a problem, we would need to wait in close_inode_sync
> > for the other references to be dropped.  We probably don't want to do
> > that.
> > 
> > So it is best to simply remove this code.
> > 
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/filecache.c | 16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index a1cdba42c4fa..b13255bcbb96 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -371,20 +371,10 @@ nfsd_file_put(struct nfsd_file *nf)
> >  
> >  		/* Try to add it to the LRU.  If that fails, decrement. */
> >  		if (nfsd_file_lru_add(nf)) {
> > -			/* If it's still hashed, we're done */
> > -			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> > -				nfsd_file_schedule_laundrette();
> > -				return;
> > -			}
> > -
> > -			/*
> > -			 * We're racing with unhashing, so try to remove it from
> > -			 * the LRU. If removal fails, then someone else already
> > -			 * has our reference.
> > -			 */
> > -			if (!nfsd_file_lru_remove(nf))
> > -				return;
> > +			nfsd_file_schedule_laundrette();
> > +			return;
> 
> Why do we need to start the background gc on demand?  When the nfsd
> subsystem is under load it is going to be calling
> nfsd_file_schedule_laundrette() all the time. However, gc is almost
> always going to be queued/running already.
> 
> i.e. the above code results in adding the overhead of an atomic
> NFSD_FILE_CACHE_UP bit check and then a call to queue_delayed_work()
> on an already queued item. This will disables interrupts, make an
> atomic bit check that sees the work is queued, re-enable interrupts
> and return.

I don't think we really need the NFSD_FILE_CACHE_UP test - if we have a
file to put, then the cache must be up.
And we could use delayed_work_pending() to avoid the irq disable.
That is still one atomic bit test though.

> 
> IMO, there is no need to do this unnecessary work on every object
> that is added to the LRU.  Changing the gc worker to always run
> every 2s and check if it has work to do like so:
> 
>  static void
>  nfsd_file_gc_worker(struct work_struct *work)
>  {
> -	nfsd_file_gc();
> -	if (list_lru_count(&nfsd_file_lru))
> -		nfsd_file_schedule_laundrette();
> +	if (list_lru_count(&nfsd_file_lru))
> +		nfsd_file_gc();
> +	nfsd_file_schedule_laundrette();
>  }
> 
> means that nfsd_file_gc() will be run the same way and have the same
> behaviour as the current code. When the system it idle, it does a
> list_lru_count() check every 2 seconds and goes back to sleep.
> That's going to be pretty much unnoticable on most machines that run
> NFS servers.

When serving a v4 only load we don't need the timer at all...  Maybe
that doesn't matter.

I would rather use a timer instead of a delayed work as the task doesn't
require sleeping, and we have a pool of nfsd threads to do any work that
might be needed.  So a timer that checks if work is needed then sets a
flag and wakes an nfsd would be even lower impact that a delayed work
which needs to wake a wq thread every time even if there is nothing to
do.

Thanks,
NeilBrown

