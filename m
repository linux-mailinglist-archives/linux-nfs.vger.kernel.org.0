Return-Path: <linux-nfs+bounces-4035-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26490DFA9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 01:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BFD28126C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9917F36E;
	Tue, 18 Jun 2024 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EcvVu6Tk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h4xUn5Nd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EcvVu6Tk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h4xUn5Nd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051F17CA1D
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752351; cv=none; b=l1Wd6T4lESJ8vjzAwdDoxjnL3oc0vCcFGx1fH/uBD3s8KUgRLcAZq3LkFbkamqVBQk6dMydTp6Q1iiP/pKLmGdyzja4axP4UVfeuGUKz+TBdbUWjAGr0FvkD5d6WmX6WDoJkNySRcHFw2YMGsbYb4VlKmtjodIpMKF8HogQVc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752351; c=relaxed/simple;
	bh=dtR3PKrEfL6BP83GpI5sD0gOsQT+LfhnjH+dHKeTkcg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EFXOK4ObS+SlRpV914eIJIviul77XmumzTagE01AGm3kXT8ovMvBoRQippBOQT/EChYBqhOeBgSpDHTF1FG37sFIiGkHuhJhZ20/v/zk5qzRe6zpwaSGBoGsZRVyKfzWFBlxSoLgiiUnHbIhpx3B8NLGCqmXEIRhcVFyH2OipII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EcvVu6Tk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h4xUn5Nd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EcvVu6Tk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h4xUn5Nd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 232A01F799;
	Tue, 18 Jun 2024 23:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718752342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MglXCu61GvoZySiYLZgcHP0yD4l2VbHjdCb4ePFG0Gw=;
	b=EcvVu6TkL1IwLJoyey9fEmVxBbzKJ8tuzdDJ7gpb343/aX17f3Glu2P29fx9aurHM1MxGf
	bqb/Cdk1tvl5NzXddpdIrSSXc8f2vIYdFlEkrhsUVG8fhbLdmtBg+0dGGWf/C4Lp+2EAD+
	84c/9froDB0DigPg6KhLbbSYHiYl29A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718752342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MglXCu61GvoZySiYLZgcHP0yD4l2VbHjdCb4ePFG0Gw=;
	b=h4xUn5NdeoQZYizOEFl9ipKhereQCRzrAd23lVi+CRpSBr/xuyiPcwXK1h86c5NGYCqnmO
	DGLiNWd0Jgq+rTBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EcvVu6Tk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h4xUn5Nd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718752342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MglXCu61GvoZySiYLZgcHP0yD4l2VbHjdCb4ePFG0Gw=;
	b=EcvVu6TkL1IwLJoyey9fEmVxBbzKJ8tuzdDJ7gpb343/aX17f3Glu2P29fx9aurHM1MxGf
	bqb/Cdk1tvl5NzXddpdIrSSXc8f2vIYdFlEkrhsUVG8fhbLdmtBg+0dGGWf/C4Lp+2EAD+
	84c/9froDB0DigPg6KhLbbSYHiYl29A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718752342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MglXCu61GvoZySiYLZgcHP0yD4l2VbHjdCb4ePFG0Gw=;
	b=h4xUn5NdeoQZYizOEFl9ipKhereQCRzrAd23lVi+CRpSBr/xuyiPcwXK1h86c5NGYCqnmO
	DGLiNWd0Jgq+rTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D7CA1369F;
	Tue, 18 Jun 2024 23:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A+YTNFMUcmaTCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 18 Jun 2024 23:12:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck.Lever@oracle.com" <Chuck.Lever@oracle.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
In-reply-to: <a59ede76404c0f38f684475f1fe44f895f6bda80.camel@kernel.org>
References: <313d317dc0ca136de106979add5695ef5e2101e7.camel@hammerspace.com>,
 <a59ede76404c0f38f684475f1fe44f895f6bda80.camel@kernel.org>
Date: Wed, 19 Jun 2024 09:12:14 +1000
Message-id: <171875233480.14261.9986376933652804732@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 232A01F799
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On Wed, 19 Jun 2024, Jeff Layton wrote:
> On Tue, 2024-06-18 at 18:32 +0000, Trond Myklebust wrote:
> > I recently back ported Neil's lwq code and sunrpc server changes to
> > our
> > 5.15.130 based kernel in the hope of improving the performance for
> > our
> > data servers.
> > 
> > Our performance team recently ran a fio workload on a client that was
> > doing 100% NFSv3 reads in O_DIRECT mode over an RDMA connection
> > (infiniband) against that resulting server. I've attached the
> > resulting
> > flame graph from a perf profile run on the server side.
> > 
> > Is anyone else seeing this massive contention for the spin lock in
> > __lwq_dequeue? As you can see, it appears to be dwarfing all the
> > other
> > nfsd activity on the system in question here, being responsible for
> > 45%
> > of all the perf hits.
> > 
> > 
> 
> I haven't spent much time on performance testing since I keep getting
> involved in bugs. It looks like that's just the way lwq works. From the
> comments in lib/lwq.c:
> 
>  * Entries are dequeued using a spinlock to protect against multiple
>  * access.  The llist is staged in reverse order, and refreshed
>  * from the llist when it exhausts.
>  *
>  * This is particularly suitable when work items are queued in BH or
>  * IRQ context, and where work items are handled one at a time by
>  * dedicated threads.
> 
> ...we have dedicated threads, but we usually have a lot of them, so
> that lock ends up being pretty contended.
> 
> Is the box you're testing on NUMA-enabled? Setting the server for
> pool_mode=pernode might be worth an experiment. At least you'd have
> more than one lwq and less cross-node chatter. You could also try
> pool_mode=percpu, but that's rumored to not be as helpful.
> 
> Maybe we need to consider some other lockless queueing mechanism longer
> term, but I'm not sure how possible that is.

I spent a lot of thought trying to come up with a lockless dequeue and
failed.  I could do it if we had generic load-locked/store-conditional
primitives, but that requires hardware support to be efficient.
compare-and-exchange cannot do it.
The core of the problem is that dequeue requires concurrent control of
the "head" pointer and the selected entry.  cmpxchg can only control one
address at a time.

If the lock is highly contended, then sharding is likely the best option
- across numa nodes or across some other subset of CPUs.

NeilBrown


