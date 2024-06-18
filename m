Return-Path: <linux-nfs+bounces-4036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7590DFBF
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 01:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57021F241EC
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8CF1849C1;
	Tue, 18 Jun 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NW991UUZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b4xVhSi2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lEB73zN+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fu5oYDlX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5413A418
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752658; cv=none; b=Yl9Jh7KAQ8tsvkZxk4MdiQbYHkiDWxoXrimMFKxx5BN/BR7u8bNCTZj0PbEGjBkYPqxLzWkITJgJFntqRjM5pAKPspMd5N7BgX0r/CQYPwtEtq85bW9SDmTZEUl9XzRV3KSLfurE3kWW7F+8HMUcBwUBe7ggiPmneg8x9gG50TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752658; c=relaxed/simple;
	bh=6o//G++J3VjQ6RIa6aedCLpAcQLO/z6hry89KDARuE0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VI/xi3UtBf/tSCX8Y/N+2RW1BVxQKSBIDRx+xIJ7jIruA7aJHIGajir2kbszIVHmeHuFg2XzIjlMjeTI6c/ENTEBvKLZ4tY2at6diareQckvNtj0dXBCum5TqlJg8pd+zMO3A9KdkRjdkivf2iKobC4/69J761XgdDLDZ6fg12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NW991UUZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b4xVhSi2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lEB73zN+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fu5oYDlX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1CCB1F798;
	Tue, 18 Jun 2024 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718752655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUG2hf4PVuaXjis7UK3XHZ5Iav3H+1y6KWQ8co8nyNA=;
	b=NW991UUZuXX9IMimjLkSVmqu7zks03JSy584PbGEtngSEL3WIclXN4k5LNhecwLyiEpdjm
	kh8+5OTL2rbCz1VZWddgKf55/wvgDnnl4rL+cNiDJsCOxTzedTSgV4tmrQbkmI9DBqDD3A
	pMeeEnzSfg82Rk1A3sYO8gz630NCda0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718752655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUG2hf4PVuaXjis7UK3XHZ5Iav3H+1y6KWQ8co8nyNA=;
	b=b4xVhSi2EG3zp2IdWdhL2bYcDK6vEfMroo+5E9UFc+bWnB1Wp4zb0iw6uQgwQcvKsrAihy
	4GtgcbLS90RRf9DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lEB73zN+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fu5oYDlX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718752654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUG2hf4PVuaXjis7UK3XHZ5Iav3H+1y6KWQ8co8nyNA=;
	b=lEB73zN+yXUvRWSoHX9ZYzqMOyUpKhvNXof7Lw1ISoq9T7mGVuz4Qfiy9b9Hb24dwMn++P
	AIwir1iUY8CqLesqieMwnkmhQ04qQvUTFaSAPjcgMrUX/uHA9ZHnKa42jdP4B9l2b8hVpJ
	Yiv9QKsyMQicoOlgsv8IenWxqrjCQmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718752654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUG2hf4PVuaXjis7UK3XHZ5Iav3H+1y6KWQ8co8nyNA=;
	b=fu5oYDlXIvNwXX4yXStJHXinw3klzZJMXIk664/9MzVg1ahuro5YLb0Wx0+zWnHI265qX+
	tqMhvoQFZkWpGCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB3741369F;
	Tue, 18 Jun 2024 23:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MBX+E4wVcmblCQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 18 Jun 2024 23:17:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever III" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Dave Chinner" <david@fromorbit.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: knfsd performance
In-reply-to: <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
References: <>, <87354accc0d1166eb60827c0f8da545e0669915b.camel@kernel.org>
Date: Wed, 19 Jun 2024 09:17:29 +1000
Message-id: <171875264902.14261.9558408320953444532@noble.neil.brown.name>
X-Rspamd-Queue-Id: E1CCB1F798
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 19 Jun 2024, Jeff Layton wrote:
> On Tue, 2024-06-18 at 19:54 +0000, Chuck Lever III wrote:
> > 
> > 
> > > On Jun 18, 2024, at 3:50 PM, Trond Myklebust
> > > <trondmy@hammerspace.com> wrote:
> > > 
> > > On Tue, 2024-06-18 at 19:39 +0000, Chuck Lever III wrote:
> > > > 
> > > > 
> > > > > On Jun 18, 2024, at 3:29 PM, Trond Myklebust
> > > > > <trondmy@hammerspace.com> wrote:
> > > > > 
> > > > > On Tue, 2024-06-18 at 18:40 +0000, Chuck Lever III wrote:
> > > > > > 
> > > > > > 
> > > > > > > On Jun 18, 2024, at 2:32 PM, Trond Myklebust
> > > > > > > <trondmy@hammerspace.com> wrote:
> > > > > > > 
> > > > > > > I recently back ported Neil's lwq code and sunrpc server
> > > > > > > changes to
> > > > > > > our
> > > > > > > 5.15.130 based kernel in the hope of improving the
> > > > > > > performance
> > > > > > > for
> > > > > > > our
> > > > > > > data servers.
> > > > > > > 
> > > > > > > Our performance team recently ran a fio workload on a
> > > > > > > client
> > > > > > > that
> > > > > > > was
> > > > > > > doing 100% NFSv3 reads in O_DIRECT mode over an RDMA
> > > > > > > connection
> > > > > > > (infiniband) against that resulting server. I've attached
> > > > > > > the
> > > > > > > resulting
> > > > > > > flame graph from a perf profile run on the server side.
> > > > > > > 
> > > > > > > Is anyone else seeing this massive contention for the spin
> > > > > > > lock
> > > > > > > in
> > > > > > > __lwq_dequeue? As you can see, it appears to be dwarfing
> > > > > > > all
> > > > > > > the
> > > > > > > other
> > > > > > > nfsd activity on the system in question here, being
> > > > > > > responsible
> > > > > > > for
> > > > > > > 45%
> > > > > > > of all the perf hits.
> > > > > > 
> > > > > > I haven't seen that, but I've been working on other issues.
> > > > > > 
> > > > > > What's the nfsd thread count on your test server? Have you
> > > > > > seen a similar impact on 6.10 kernels ?
> > > > > > 
> > > > > 
> > > > > 640 knfsd threads. The machine was a supermicro 2029BT-HNR with
> > > > > 2xIntel
> > > > > 6150, 384GB of memory and 6xWDC SN840.
> > > > > 
> > > > > Unfortunately, the machine was a loaner, so cannot compare to
> > > > > 6.10.
> > > > > That's why I was asking if anyone has seen anything similar.
> > > > 
> > > > If this system had more than one NUMA node, then using
> > > > svc's "numa pool" mode might have helped.
> > > > 
> > > 
> > > Interesting. I had forgotten about that setting.
> > > 
> > > Just out of curiosity, is there any reason why we might not want to
> > > default to that mode on a NUMA enabled system?
> > 
> > Can't think of one off hand. Maybe back in the day it was
> > hard to tell when you were actually /on/ a NUMA system.
> > 
> > Copying Dave to see if he has any recollection.
> > 
> 
> It's at least partly because of the klunkiness of the old pool_threads
> interface: You have to bring up the server first using the "threads"
> procfile, and then you can actually bring up threads in the various
> pools using pool_threads.
> 
> Same for shutdown. You have to bring down the pool_threads first and
> then you can bring down the final thread and the rest of the server
> with it. Why it was designed this way, I have NFC.
> 
> The new nfsdctl tool and netlink interfaces should make this simpler in
> the future. You'll be able to set the pool-mode in /etc/nfs.conf and
> configure a list of per-pool thread counts in there too. Once we have
> that, I think we'll be in a better position to consider doing it by
> default.
> 
> Eventually we'd like to make the thread poos dynamic, at which point
> making that the default becomes much simpler from an administrative
> standpoint.

I agree that dynamic thread pools will make numa management simpler.
Greg Banks did the numa work for SGI - I wonder where he is now.  He was
at fastmail 10 years ago..

The idea was to bind network interfaces to numa nodes with interrupt
routing.  There was no expectation that work would be distributed evenly
across all nodes. Some might be dedicated to non-nfs work.  So there was
expected to be non-trivial configuration for both IRQ routing and
threads-per-node.  If we can make threads-per-node demand-based, then
half the problem goes away.

We could even default to one-thread-pool-per-CPU if there are more than
X cpus....

NeilBrown

