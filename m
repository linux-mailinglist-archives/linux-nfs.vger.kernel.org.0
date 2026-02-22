Return-Path: <linux-nfs+bounces-19098-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKszCHJbm2k4ygMAu9opvQ
	(envelope-from <linux-nfs+bounces-19098-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 20:39:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFF170360
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 20:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 733C9300A4D7
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E235A93B;
	Sun, 22 Feb 2026 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRsfQ8Ga"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954E352F87
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771789165; cv=none; b=qJGKNg6zjCtv6RyIPBzo5vZCViow6ugzY2WeNISnVzkNn+4Bx/CU0UWBssphYdCCgUcN5+cZciDO7xuPArAEDrBpNS5FSPHYHbtV0Z0MXhpP7Wf/yCvCw3v3ZD+S7GgFQ56T8PD1dpSMc9jgBoC3djFisGqSxKWUr+53ubTWLKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771789165; c=relaxed/simple;
	bh=UILP1dam8BKBhG81q+Pp2jFcItIkY1H/ScQ93PjDYrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpchaVuX8zExaM9U0tMUD386UPe9wk+rF4ag3yDqnn1wmePRtvsPWBaVrcuxc9dzROfgwa4zubCl/oMZROzyOdJhDNQF7mr/Fz7g71wbf/lcye8kDk/DBU0yO48Fzr8YK/Vr4xJ1G2OE/Wrh80sLkagRvkHuvO9upM08nlcqBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRsfQ8Ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C541C116D0;
	Sun, 22 Feb 2026 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771789165;
	bh=UILP1dam8BKBhG81q+Pp2jFcItIkY1H/ScQ93PjDYrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRsfQ8Ga0pF1qhUFZnY94zqwY3qMpIo+s/AxZFexKqGDSo27j4CAIU5Iakckj/JxM
	 BrOrs9fTEK/tgMQ9HgcVVQR0aZUsB0Z3krdBY406oLVU3wvnbBLL3khObiEiuJ9A8t
	 GvXhxUpuI1WriyKVmb84sz4q6A5/ky31YPIHAhZJykKwO/hlezvxVWDRfjA88NUHsS
	 Fz6LyRtOcKIyvp/PeUj5KbKKI/E3ahG2iRMcr3HPgJo04TbwLFI+6O1ZaTrd56qlHE
	 zoEyAIevzG2AdSqGb3ZdcJTdN1w+K4j/hcXUMwdllsn4KAAI9uApnbgYFs5YzC87Qa
	 cBrw74g2JB1jw==
Date: Sun, 22 Feb 2026 14:39:24 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] NFS/NFSD: nfs4_acl passthru for NFSv4 reexport
Message-ID: <aZtbbJ-dxkw-V4NU@kernel.org>
References: <20260219221352.40554-1-snitzer@kernel.org>
 <fbdf4c2b-6d3b-45bc-ae2e-48316dd16eeb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbdf4c2b-6d3b-45bc-ae2e-48316dd16eeb@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19098-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[snitzer@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91BFF170360
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 12:53:14PM -0500, Chuck Lever wrote:
> 
> 
> On Thu, Feb 19, 2026, at 5:13 PM, Mike Snitzer wrote:
> > Hi,
> >
> > This patchset aims to enable NFS v4.1 ACLs to be fully supported from
> > an NFS v4.1 client to an NFSD v4.1 export that reexports NFS v4.2
> > filesystem which has full support for NFS v4.1 ACLs (DACL and SACL).
> >
> > The first 6 patches focus on nfs4_acl passthru enablement (primarily
> > for NFSD), patch 7 adds 4.1 nfs4_acl passthru support (DACL and SACL),
> > patch 8 optimizes particular nfs4_acl passthru implementation in NFSD
> > to skip memcpy if nfs4_acl passthru isn't needed, patches 9-11 offer
> > the corresponding required NFSv4 client changes.
> >
> > This work is based on the NFS and NFSD code that has been merged
> > during the 7.0 merge window.
> 
> Hey Mike, do you have a particular commit hash on which this series
> applies? I've tried Torvalds master and nfsd-testing, and patch 3/11
> fails to apply to either of them.

Sorry about that.

It's closest baseline is nfsd-7.0 (but my tree is a frankenbeast
starting at 6.12 sync'd all the way through to nfs-for-6.18-3 and
nfsd-7.0), see:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.63/nfs4_acl-passthru

Given what you found, I'm missing some of your latest conflicting
changes. So it'll need a rebase.

> > This patchset is marked as RFC because I expect there will be
> > suggestions for possible NFSD implementation improvements.
> 
> I think I understand the purpose of the series, and agree there is
> an issue here. It doesn't look intractable to resolve.
> 
> Wondering, though, if plumbing .setacl and .getacl through the
> export ops is the right way to go. These seem like inode ops to
> me, not export ops. Shouldn't they work like an inode's existing
> POSIX ACL ops?

I didn't even consider this.

I'll have to take a closer look, but my intent was to convey that
these interfaces are tightly coupled to NFSD for passthru purposes.
Making them inode operations exposes the interface in a more generic
way right?  Is it useful to do _now_?  If/when there is a need then
they could be exposed as inode operations.  How might doing that
expose the interfaces to usage that was never intended or needed?

Getting a bit into the weeds of design philosophy but I prefer to
expose interfaces that cater to their immediate use. Put differently:
I try not to game out hypotheticals too much.  But I do welcome
suggestions like this that offer experienced vision for being mindful
of exposing interfaces that lend themselves to standing the test of
time (more so than my scalpel approach anyway).

Below you mention ZFS supports NFSv4 ACLs, how is that used? And does
its usage offer a glimpse of some further hypothetical that is
meaningful for Linux?

> Second, I see this in one of the patch descriptions: "This 4.1 DACL
> and SACL support is confined to NFSD's NFS reexport case (e.g. when
> NFSD 4.1 reexports NFS 4.2)." It made me wonder -- is re-exporting
> NFSv4.2 on an NFSv4.1 mount the only configuration that we want NFSD
> to support? I would think that any combination of NFSv4 minor
> versions could be supported. And if only a few combinations can be
> supported, the cover letter or Documentation/ should explain why.

My "(e.g. when NFSD 4.1 reexports NFS 4.2)" was only an example.  The
code should work fine with any NFSv4 combination -- though obviously
4.0 won't understand nfs4 acl utils --dacl and --sacl flags.

> But really, I expect any file system type might be able to implement
> NFSv4 ACLs (eg, ZFS does, but it's out-of-tree). I would like to
> think about this in terms of "native file system NFSv4 ACL support"
> rather than "NFSD pass through". So, the NFS client's NFSv4 inodes
> have it, and this series doesn't need to add it anywhere else for
> now.

Sounds fine to frame it in those terms, but may cause make-work for
some future consumer that'll never actually materialize.

Relative to NFSD, its purely about passing through the nfs4_acl pages
that it got off the wire directly down to FS that has "native file
system NFSv4 ACL support".

Thanks,
Mike

