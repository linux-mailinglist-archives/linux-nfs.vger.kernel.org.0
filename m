Return-Path: <linux-nfs+bounces-21255-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOHEObLC8GmmYQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21255-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:22:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88629486D90
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 16:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CC18301E6D8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38988441022;
	Tue, 28 Apr 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mSJdFBE9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8D3D5227;
	Tue, 28 Apr 2026 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386147; cv=none; b=nWirvew7GheVj9XoKjVX9pVDmdE1wG7E4STvUFXRsVUdpb9OFgNPMgmf2X+q2UTu9RsTJbccaZcYPcIbqngNZQZVWE0HeqVizT7hJzc2JiYDhMu+GrpNQqW14Rnqu96v/i8fvo3BDww+KrdY8SXh5IfUZ4fw1/q+NHjkAMkwX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386147; c=relaxed/simple;
	bh=sl1fqLImGDcEEKCBCo2L/+ljN9uGeACIGU4eqA8valA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap74bTGjQsdg8Xe3g1V/JqBv/gKYb4yjtlVB10JWVnImhhTJWvTVshrXlTWxZzgdwG5BKGztYizRTcA87+HRFf+BCDlYa2BvIrhkLn/MzPXafJU8/xCp/C2Hu4un2L1QD4NkhKMEbb1/vODQ+kAVFQwKQqW+X9zcPciZHgBOUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mSJdFBE9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r9Hup9E3/oT6Fka4DsUaI6wjWjOX8izftWYyjO/QbNY=; b=mSJdFBE9ahFIrl6ZrqyL0VQTJt
	+HNrR+hnMC33kG0BDUrznpRNac4VLuKJ4jBHg2SWoV9cChvQQl5dmfCyFqK9qtSzedBDKT4jEQlWi
	Pf/+80uv80xoyV2dE/1vYukGEoqB9DB3AqC2ei2nZGmQy3exf4KpbFfDjeAWjHS85acg/PkNuMWoP
	uNfpusC6O6ynrKoCsGE1Z/Ic2pARN5i0Kej0bgHBaaYAWRro38zzoLmh0ql9x+ffpAYW111RKEZZ4
	RTdyWhnPEfIuHZV79U8goabOKFh/l4OeYbTWJieXjFbf/S2ahgR4l7OZpfeZM8vMX/uKNOh3k/emv
	ihXe8tFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wHjKT-000000011sv-3ldP;
	Tue, 28 Apr 2026 14:22:27 +0000
Date: Tue, 28 Apr 2026 15:22:25 +0100
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
Message-ID: <20260428142225.GX3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
 <20260427040517.828226-5-neilb@ownmail.net>
 <20260428033738.GV3518998@ZenIV>
 <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: 88629486D90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21255-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.org.uk:dkim]

On Tue, Apr 28, 2026 at 09:18:39PM +1000, NeilBrown wrote:
> > d_must_wait() conditional, though - ->d_flags and ->d_lock are in different
> > cachelines and there's no need to dirty both every time we are called.
> > IOW, have d_must_wait() do this:
> > 	if (!d_in_lookup(dentry))
> > 		return false;
> > 	if (!(dentry->d_flags & DCACHE_LOCK_WAITER))
> > 		dentry->d_flags |= DCACHE_LOCK_WAITER;
> > 	return true;
> 
> The only time that DCACHE_LOCK_WAITER will already be set is when there
> are two (or more) waiters as well as the thread they are waiting on.
> That means three (or more) threads all accessing the same name at the
> same time.  How often does that happen?  Is the micro-optimisation worth
> the small increase in code size?

Depends upon the load, obviously - a bunch of threads hitting the same
pathname at the same time... not impossible.

More to the point, why not set DCACHE_LOCK_WAITER as soon as we grab ->d_lock
there?  Then waiting becomes simply "wait until !d_in_lookup()".  Sure, we
might end up setting DCACHE_LOCK_WAITER on a dentry that has just dropped
DCACHE_PAR_LOOKUP - who cares?

While we are at it, do we need to drop it when we clear PAR_LOOKUP?  Because
if we do not, the whole "what do we return from __d_lookup_unhash()" thing
disappears - we simply pass the dentry to end_dir_add() and have it check
->d_flags & DCACHE_LOCK_WAITER to decide whether to bother with wakeup.

