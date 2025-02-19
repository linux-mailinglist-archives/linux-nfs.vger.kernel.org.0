Return-Path: <linux-nfs+bounces-10191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93273A3AEC6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 02:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459BC16AB81
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA546447;
	Wed, 19 Feb 2025 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JxVaI7gP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4/56uEL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vksi2P7Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EieI1O9O"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1B22097
	for <linux-nfs@vger.kernel.org>; Wed, 19 Feb 2025 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928028; cv=none; b=VRXonU6mp6gjM0uf7sXaI+exeVyVmR9c44vRj5XS7EooqbWl4k6BddG4o7c+P+wbtJjA22eYc1QqhQ8O3U29LwxTUHlQ0IEf5dPcvf9sSVAzyWGo4ebXeIlqv2k/WFjnWHL4GCyYx6aGTGAWr/p84KK7hlVqpSTiOIwmkVb8kYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928028; c=relaxed/simple;
	bh=om5nK7u5d1YDDRrxO43iG/jgumcCtZkwuMSHFGgpww0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RhNKS6gREMEUYKVaTZwQAPABizwdUZ9Ybx8dSZMjhzAqcoc1TIPViq7PMkZCmvlUqc/Oq/GsA5KoKHBPwzj6sO9VdVUpjm2vXiKVw36I3CX6PrLZBpFg2n6z5G1GwozluGN9HKkAcRY17Nd5mexjPfVR+seSKwB7RzGx3X1SIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JxVaI7gP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4/56uEL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vksi2P7Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EieI1O9O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC3371F396;
	Wed, 19 Feb 2025 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739928025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDclDqMU/5pODGgf8TrzHq/YO7GT6spZSMBed2OX9Ig=;
	b=JxVaI7gPv0MGnCDZM6EKpxeGEL4Q0JT/CR/xNFVjBWbQqsQejvSt35Zl4phFkTHhW+YrzV
	W9YqQtMdrZh76ICM7WyZ9DXPTWnELkzTvJGeqmNF8kSzCwiqHm2+36MpiDRWQE4kPX0oRr
	OuptTd1LkA5BgBdbXBqJu//ynAokoVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739928025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDclDqMU/5pODGgf8TrzHq/YO7GT6spZSMBed2OX9Ig=;
	b=X4/56uELMkuO8NE659KGVoQ7KALHUbTv98XRRLEL3G8qiPGjSMZTaJ++Rsy7ud/2ADKT97
	K5YZGIFgMV1oGNAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739928024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDclDqMU/5pODGgf8TrzHq/YO7GT6spZSMBed2OX9Ig=;
	b=vksi2P7Q6vMNUSEAWQfVLe6oXX0vxHkkGv6Aocywdky7qN1qvV004JamJ0lOoI0OlvW//l
	xgh3fw9YfTW1Hu7NysxyuNRPbUueX7MUcDf2a4ys9YHHQ3SDh9udRsp+cf3+dTt+F3UcRR
	FCaRjOXfeqMlMWNJhU0/cd1/HWY8TZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739928024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDclDqMU/5pODGgf8TrzHq/YO7GT6spZSMBed2OX9Ig=;
	b=EieI1O9O1ChAsODbCkWI80IG+zRbYVzaKV/f+CDGVzEx0z3J5aLDqHGCz99r0ZS8BrYXWV
	mw6wlicWxmZZ/PDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39BA31388E;
	Wed, 19 Feb 2025 01:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ZKVN9UxtWdNJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 19 Feb 2025 01:20:21 +0000
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
Cc: cel@kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 2/7] NFSD: Re-organize nfsd_file_gc_worker()
In-reply-to: <Z7Um6Ujm3DwC73gw@dread.disaster.area>
References: <>, <Z7Um6Ujm3DwC73gw@dread.disaster.area>
Date: Wed, 19 Feb 2025 12:20:15 +1100
Message-id: <173992801529.3118120.10560796074795688736@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 19 Feb 2025, Dave Chinner wrote:
> On Tue, Feb 18, 2025 at 10:39:32AM -0500, cel@kernel.org wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Dave opines:
> > 
> > IMO, there is no need to do this unnecessary work on every object
> > that is added to the LRU.  Changing the gc worker to always run
> > every 2s and check if it has work to do like so:
> > 
> >  static void
> >  nfsd_file_gc_worker(struct work_struct *work)
> >  {
> > -	nfsd_file_gc();
> > -	if (list_lru_count(&nfsd_file_lru))
> > -		nfsd_file_schedule_laundrette();
> > +	if (list_lru_count(&nfsd_file_lru))
> > +		nfsd_file_gc();
> > +	nfsd_file_schedule_laundrette();
> >  }
> > 
> > means that nfsd_file_gc() will be run the same way and have the same
> > behaviour as the current code. When the system it idle, it does a
> > list_lru_count() check every 2 seconds and goes back to sleep.
> > That's going to be pretty much unnoticable on most machines that run
> > NFS servers.
> > 
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/filecache.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 909b5bc72bd3..2933cba1e5f4 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -549,9 +549,9 @@ nfsd_file_gc(void)
> >  static void
> >  nfsd_file_gc_worker(struct work_struct *work)
> >  {
> > -	nfsd_file_gc();
> > +	nfsd_file_schedule_laundrette();
> >  	if (list_lru_count(&nfsd_file_lru))
> > -		nfsd_file_schedule_laundrette();
> > +		nfsd_file_gc();
> >  }
> 
> IMO, the scheduling of new work is the wrong way around. It should
> be done on completion of gc work, not before gc work is started.
> 
> i.e. If nfsd_file_gc() is overly delayed (because load, rt preempt,
> etc), then a new gc worker will be started in 2s regardless of
> whether the currently running gc worker has completed or not.
> 
> Worse case, there's a spinlock hang bug in nfsd_file_gc(). This code
> will end up with N worker threads all spinning up in nfsd_file_gc()
> chewing up all the CPU in the system, not making any progress....
> If we schedule new work after completion of this work, then gc might
> hang but it won't slowly drag the entire system down with it.

While I agree that the enqueue is best done later rather than earlier, I
think your worst-case is over-stated.
queue_delayed_work() is a no-op if WORK_STRUCT_PENDING_BIT is still set.
A given work_struct can only be running once.
If the timer fires while nfsd_file_gc() is still running,
nfsd_filecache_laundrette will be queued to start immediately that the
currently running instance completes.  So the worst cases is that
there will always be one instance running.

Thanks,
NeilBrown

