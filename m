Return-Path: <linux-nfs+bounces-4858-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435DA92F96D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 13:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80E12825B6
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jul 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2FD158A35;
	Fri, 12 Jul 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PdQHb8Qg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LIfZX9T7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PdQHb8Qg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LIfZX9T7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3DBD512;
	Fri, 12 Jul 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782854; cv=none; b=n/UCnZTkogcwVUcerfQ58LY3dsU6wOHWOIt62P4TDOxhzXxO8irERrM6jNyaBWAtwmylcFLIiiybrqS0ilI3FHkXmKBMYN9Q4QdB4CAXamNAonjObgz8o+Nmhk8Rw+qsdOu56aG6RWhypsLgwv5VdKNJ4s79WU3kXBClgl9+FPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782854; c=relaxed/simple;
	bh=dy2wY2IJkHJkWYWh2MyIpRjaGDuJ5cxy++CM9jyg5Wk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=U9ckh85+z1zdcEaVY06j8Z13sKWqM1ber0ErH/VzJ56eKNMemhhrPEKk4ZJ49hQsfCLxAdlCJH2FwfJPsTlT271p06Ocz2hBzzvBSUmfRMHSEsiSd59uxI0WUMLlMLDbmqcOnY3ESZEA4Cvm4OcwFEQx4OGvcJOZ4DmAfcWaOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PdQHb8Qg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LIfZX9T7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PdQHb8Qg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LIfZX9T7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6534A1FB7E;
	Fri, 12 Jul 2024 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720782850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
	b=PdQHb8Qg6f3KKtYiYyev+EG4jQNpczpUCCYwefz/ZDjiHjQ3KhIKT4JoU5J79YB9Q5J8WT
	rpS/SCGkJYFGOflpGC7v2Y8cnWF7hlV8W43C8fAidyGYCxvKmK7tuNmx/Rq7W9TXTCfw3A
	IgXLwuqLWRhbEZS2wNTUrsQOJDzzguI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720782850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
	b=LIfZX9T7Y3N7mHtQEaTAeG3kyvBybKBad7irujFfEVzIBP73ArkrLL/RaG8eSeQOYLlwSo
	mumV+eDL5IacwODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720782850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
	b=PdQHb8Qg6f3KKtYiYyev+EG4jQNpczpUCCYwefz/ZDjiHjQ3KhIKT4JoU5J79YB9Q5J8WT
	rpS/SCGkJYFGOflpGC7v2Y8cnWF7hlV8W43C8fAidyGYCxvKmK7tuNmx/Rq7W9TXTCfw3A
	IgXLwuqLWRhbEZS2wNTUrsQOJDzzguI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720782850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
	b=LIfZX9T7Y3N7mHtQEaTAeG3kyvBybKBad7irujFfEVzIBP73ArkrLL/RaG8eSeQOYLlwSo
	mumV+eDL5IacwODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5A9F13686;
	Fri, 12 Jul 2024 11:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mOQBGvwPkWYVOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 12 Jul 2024 11:14:04 +0000
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
Cc: "Chuck Lever III" <chuck.lever@oracle.com>, "Greg KH" <greg@kroah.com>,
 "Sherry Yang" <sherry.yang@oracle.com>,
 "Calum Mackay" <calum.mackay@oracle.com>,
 "linux-stable" <stable@vger.kernel.org>, "Petr Vorel" <pvorel@suse.cz>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, "Avinesh Kumar" <akumar@suse.de>,
 "Josef Bacik" <josef@toxicpanda.com>
Subject:
 Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel 6.9
In-reply-to: <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
References: <>, <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
Date: Fri, 12 Jul 2024 21:13:59 +1000
Message-id: <172078283934.15471.13377048166707693692@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	REPLY(-4.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri, 12 Jul 2024, Jeff Layton wrote:
> On Fri, 2024-07-12 at 16:12 +1000, NeilBrown wrote:
> > 
> > My point is that if we are going to change the kernel to accommodate LTP
> > at all, we should accommodate LTP as it is today.  If we are going to
> > change LTP to accommodate the kernel, then it should accommodate the
> > kernel as it is today.
> > 
> 
> The problem is that there is no way for userland tell the difference
> between the older and newer behavior. That was what I was suggesting we
> add.

To make sure I wasn't talking through my hat, I had a look at the ltp
code.

The test in question simply tests that the count of RPC calls increases.

It can get the count of RPC calls in one of 2 ways :
 1/ "lhost" - look directly in /proc/net/rpc/{nfs,nfsd}
 2/ "rhost" - ssh to the server and look in that file.

The current test to "fix" this for kernels -ge "6.9" is to force the use
of "rhost".

I'm guessing that always using "rhost" for the nfsd stats would always
work.
But if not, the code could get both the local and remote nfsd stats, and
check that at least one of them increases (and neither decrease).

So ltp doesn't need to know which kernel is being used - it can be
written to work safely on either.

NeilBrown


> 
> To be clear, I hold this opinion loosely. If the consensus is that we
> need to revert things then so be it. I just don't see the value of
> doing that in this particular situation.
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


