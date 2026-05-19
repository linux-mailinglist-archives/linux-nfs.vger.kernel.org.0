Return-Path: <linux-nfs+bounces-21716-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ITUMKvPDGrImQUAu9opvQ
	(envelope-from <linux-nfs+bounces-21716-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 23:01:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122A584F66
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6854301A704
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B63BE644;
	Tue, 19 May 2026 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMUqSb3Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362A3AFD17
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224399; cv=none; b=iX+TLXwxMGoVJ5YE1JKxfmGzTjn4OfRvQLMb6f1nJOMz4wSqWpJ3No8kB4Ac1hy472DM2GwPOZzrDOo7YGb/tmEBL6GBkSrOjHAz3ipGvyAZOVKOE9Z0EITX4NtTEF419kUw0pbn7qKe8qIYNB2yQHLyZ9x9xfCQdkcGsjjQZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224399; c=relaxed/simple;
	bh=4kd0N3JUTtDN1NfimzWLzNRdKYyppmzodCBAaTwNaHM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sdWvN27acVzTDHs9ugQsoq02NcYxC8zvKHjUdraQSSRXinuTYkiTjx/JA7QnfvKcT3FO3Z+pY9upa0uBvwHP9NhiwcWSv/ol8NyamdwbEk6A8QvKYNszgW5LR8a8KNbjg6e4DQDk8CNHaW0W8rxPl9pLcxSMcJVClYsvMeV+PKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMUqSb3Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DC41F00894;
	Tue, 19 May 2026 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224398;
	bh=Gvas0LEH0kTcsCtxTcdl0ZDPTJTKfFbAn4xkC0sYMUM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=GMUqSb3Z0FD0HBbnK8yHp3e4Y2HKo19HMY/6tDYqA9EBv4r7Y/U5sWoVuWcm3pM9E
	 Qbw7UyGko1wfkHNixDIgsLqxAQhmqJWFm9NwNST4b+ImGmySkbpiRdCzWoWopAztOO
	 9yHimcFroyh2c4BEtqQ4HMA/KzE3zEwjyt21D9/+uP6btBAjEi8asRObuAZKx99sEi
	 Q8hwNeHFzp0f8R1TbPlZqv59n5BqlcoLqpiOQRTOuhGN2Va4ByBSHVvS4m3ouz2liO
	 bbptJMoRHNilg8XDFzudNaJrbrMQLRgCiPoI9ZKS9h3NPPvJ9ptDS6IR+PRk303/31
	 tQd1TVAcNn//g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5371FF4006D;
	Tue, 19 May 2026 16:59:57 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 19 May 2026 16:59:57 -0400
X-ME-Sender: <xms:Tc8Man5uwVNofkhgojF0tzxMxF1nLusf1RfwtbItYHOCtge8naxUBA>
    <xme:Tc8MansTWG4XW_bHB2X2R1RxAed45mXwEznIWj9r_YDDXUv3lhdP7yFcykkz9Wzw_
    DKQsXKi9hT_-FhjdkzTTRMy0WZMMJUk9PzuS-HeiSrkosc3CshAlbnY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsggvnhdrtghougguihhnghhtohhnsehhrghmmhgvrhhsphgrtggvrdgtohhmpd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgv
    ihhlsgesshhushgvrdguvgdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Tc8MakgfJviWEcb5-vTEEbTbHpi1gVxv6kSQ_Ww1nQLTbs8R_LsbjQ>
    <xmx:Tc8Maq0P1gdr98iRYgZ5cbYyro7-8i0y76kzn7UygDmbMEP7tXwkGw>
    <xmx:Tc8MamhQ987ngQSWGho7zWLQng6YOeH2yie49Zlhr1ZpOQGtyvPuvw>
    <xmx:Tc8Maif6APAX0m0sHqZr1o5pB7LQ9i37iJDinV4e2asoGwu82576Qw>
    <xmx:Tc8MahmgCAddVjvSdC-HB9afxvDywL35SE3vBZJg73YUBSwFPIC2cmYU>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 34183780075; Tue, 19 May 2026 16:59:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABrU-SqmuE1V
Date: Tue, 19 May 2026 16:59:37 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
In-Reply-To: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21716-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1122A584F66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, May 19, 2026, at 4:45 PM, Benjamin Coddington wrote:
> We've been chasing a class of starvation problem on knfsd servers and would
> appreciate feedback before going further.
>
> NFS clients that opens many TCP connections (for example with nconnect=N)
> combined with a large NFSv4.1 slot table can keep enough requests in flight
> to saturate the entire nfsd thread pool, starving other clients sharing the
> same server.  In our environment we routinely see one such client push
> hundreds of nfsd threads into uninterruptible waits, leaving little or no
> service capacity for everyone else.  Concretely, 8 connections at 128 slots
> is already ~1000 potentially-concurrent ops from one host against a default
> 640-thread server.
>
> The root cause looks structural to me.  svc_xprt_enqueue() and svc_recv()
> schedule fairly across xprts, so a client with N sockets gets N times the
> service share of a client with one socket.  From the server's point of view
> there is no notion of "client identity" in the dispatch path -- the xprt is
> the unit of fairness.
>
> ISTM the right shape is an opt-in fair-queueing scheduler that groups ready
> xprts by client identity and round-robins (or deficit-round-robins) across
> identities rather than across sockets.  The natural identity is the NFSv4
> clientid where available, with source address as a fallback for NFSv3.
> Default behavior would be unchanged and the new policy would be selectable
> per service or per pool.
>
> Before we go further I'd like to ask a few things.  Is per-client fairness in
> knfsd something the community wants, or would you rather see this solved
> purely on the client side?  What's the right layer for client classification
> -- sunrpc is clean but identity-blind, and nfsd knows clientid but only later
> in the path?  Would a simpler per-client concurrency cap be preferable to a
> true fair-queue scheduler?  And is there prior art I should be aware of -- I'm
> thinking of interactions with the recent dynamic thread-pool work, but there
> may be older threads I've missed.
>
> I'm happy to share more detail on the workload that surfaced this.

We're very open to discussing this. It's a well-known shortcoming of NFSD,
currently.

I'm not sure making the client (or, say, the network namespace) the unit of
fairness is the best approach. A single client is known to encounter the
same class of deadlock that you describe above, for instance.

The current design assumes that whatever work a thread is given to accomplish
will complete in milliseconds or less. When the network layer knows this will
not be the case, the request can be deferred by sunrpc.

But there are problems with this design:

* The network layer is not always privy to what might trigger long delays.
  For NFSv4, for example, a client that is not responding to a delegation
  or layout recall will stall the server thread, but that happens well
  /after/ the network layer has passed control to NFSD. Likewise, this
  is a problem when I/O is glacially slow, for instance for NFS re-export
  when an NFS client is partitioned or otherwise unresponsive.

* The send and receive buffers for each request are tightly coupled to
  the threading model. Once a request has been received, the consumed
  receive buffer ties up a thread.

So we've been playing whack-a-mole to try to break these deadlocks one at
time, because resolving the buffer-to-thread coupling issue will be long-
horizon work.


-- 
Chuck Lever

