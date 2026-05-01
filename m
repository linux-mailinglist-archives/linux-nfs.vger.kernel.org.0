Return-Path: <linux-nfs+bounces-21320-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE3VJcb982nj9QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21320-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 03:11:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8D4A97C2
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 03:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8815B300B454
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 01:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EE12BF3F4;
	Fri,  1 May 2026 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P40ZBP6T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225329BD87;
	Fri,  1 May 2026 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597890; cv=none; b=nhNmkirLs/DlaE4GJLuxIRtw6/X/QD1VnZY6F1mrajz/3AIItUfd/FeXTdY++uNTN16UISHWeQyESo2i7qlfkfXU3sM0nMSCuYkOtW9SR77CnBbfYBr8WvUN1oj2AaRbEBt54Aw4neh4JyvLi5pCYifC2q7zNGfsDPSc+VEV/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597890; c=relaxed/simple;
	bh=q2FUFwmn4e1pgFgNlaih3TmZ3N3T0Ip+LeiuocIeZrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8uSGsvow8dBsvOR6IBgjLJxKMlqTo9J+7iFnGSeGILPcOxMRiUoL+0SbFq0vMDHmm2jZ5WdSLlT/TtmMRQXPJgYWoGg6Vsj1/c6Et0IpJJIdaPzGqrbQ5hJCLhoffvbibq5rZQ9x+SlwxflrISJpik9oXPmcC/URExx6dNk7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P40ZBP6T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KR+8ubcBI7cu5TARnKFNwpgQVYeQTnmqfhastYpHDSo=; b=P40ZBP6T2AXqUPxr7OJkSk3XMX
	8jEPjqTS4QOgnORGQ6x5wI7ep9ga1OQ8sFtzJx4YewG+qYlwuzeeHf7Bco3aJ8Vj3XKa8JDklNf89
	UpBQAS1AKTdBYH2YwunyJgzpnCq+4r1APxK64muYk9f7KzVrsHWsGT0Jph0rcLKAaPFcWoQHLN74u
	/1YrHS+8gFt7aWpolHcQae3K2+iP944XbAR5SaD6il+QR46pteLw/vwEBtDf8Qi7pBBuO2TtR4qDE
	gqIv+eHDcbEUPBHUGQqhrFg0lqoVrFwTDtzHbVAn72N4+ef/+euLzWGduqMfxZp6OY2t/aUet6Zb4
	68g2eFBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wIcPk-0000000Ctnc-2wuA;
	Fri, 01 May 2026 01:11:33 +0000
Date: Fri, 1 May 2026 02:11:32 +0100
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
Message-ID: <20260501011132.GA3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
 <20260427040517.828226-5-neilb@ownmail.net>
 <20260428033738.GV3518998@ZenIV>
 <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
 <20260428142225.GX3518998@ZenIV>
 <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
 <20260429052626.GY3518998@ZenIV>
 <20260429170731.GZ3518998@ZenIV>
 <177759308866.1474915.9708613530229799376@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177759308866.1474915.9708613530229799376@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: 32E8D4A97C2
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
	TAGGED_FROM(0.00)[bounces-21320-lists,linux-nfs=lfdr.de];
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

On Fri, May 01, 2026 at 09:51:28AM +1000, NeilBrown wrote:

> I saw this comment the first time I read this email, but I didn't
> process it properly.  That code is wrong.

One in mainline isn't - d_wait comes from target, as it ought to.

> It only makes sense to 
> __d_wake_in_lookup_waiters() a dentry that we know was in-lookup, and in
> d_move, that is target.
> This can only happen (I think) in nfs where nfs_lookup() skips the lookup
> for LOOKUP_RENAME_TARGET and leaves the dentry in-lookup.  Other threads
> looking up that name will then block.
> After the rename completes that in-lookup dentry will now be unhashed
> but we need to wake it up so other threads can continue (and repeat the
> lookup). 
> 
> So we need
> 
> 		__d_wake_in_lookup_waiters(target);
> 
> in d_move.  target, not dentry.

Yep.

> Thanks for flagging this,
> 
> Also my testing has hit a problem with some sort of deadlock in the nfs
> server (so accessing and XFS filesystem).  They are tring to unlink a
> file and are waiting in d_alloc_parallel() under reconnect_path.
> This is running generic/467.
> 
> So better hold off this patchset until I have that understood.

Let's deal with d_alloc_parallel() first; it doesn't have to be tied
into the rest of patchset.  Does the variant I've posted + s/dentry/target/ in that
call of __d_wake_in_lookup_waiters() trigger any problems in your testing?

If it doesn't, let's get that part out of the way - it makes sense on its own
and getting it into -next (I'm sitting on a bunch of fs/dcache.c patches, and
it would fit there nicely) would be a good idea.

FWIW, your "noblock" variant is a misnomer - it *is* a trylock analogue of
d_alloc_parallel(), all right, but it might very well block; on allocations,
if nothing else, and there's a chance of having that dput(dentry) in "wouldblock"
case coming right after the sucker ceased to be in-lookup and dropping the sole
remaining reference.  Which may block on real IO, final dput() being what it is...

And I really dislike the "drop and regain a caller-held lock" games - we'd been
there many times and it had ended up with race galore again and again; see
https://lore.kernel.org/all/20250623213747.GJ1880847@ZenIV/ for one recent
example...

