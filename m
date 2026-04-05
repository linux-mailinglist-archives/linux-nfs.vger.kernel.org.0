Return-Path: <linux-nfs+bounces-20660-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB1YNKfK0Wm9NQcAu9opvQ
	(envelope-from <linux-nfs+bounces-20660-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Apr 2026 04:36:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1DA39D28B
	for <lists+linux-nfs@lfdr.de>; Sun, 05 Apr 2026 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EACD300EFAF
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Apr 2026 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD493290C3;
	Sun,  5 Apr 2026 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k8utYVm5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7DC2C11D7;
	Sun,  5 Apr 2026 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775356578; cv=none; b=H0txiMFS99d1Mkliz0fFq2W3cOILVtg+WjzOmfOVF9p9m8vOH1UMA+QZQxzCGohPJkbvqbedRdZDNT11rA/97dY3ybSPmx5hMA0qXeNpZ0JzupmpRgfPmwpoun+jqThye8Qk3eEnw1ZizD3FQpMmXNLxpfnmOBBAeCegxNSdlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775356578; c=relaxed/simple;
	bh=u+oh6pwycrXIwroiRghNdxmmaXTSao1UfBiuYMJ8Zws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP3LWFgB3Ur9tEOi9FZL2X5PzWvY34BG8bAy1zfx9xB6a81yUQb0UBX8DmDK7Akt7xYUHPp915gRDVg9DN5ptjIO2MFyB6lH9Mq/tdmsrgWtbSAprg5QnJ+64GQi0mth2SyQXSkL7aCs2wFOjAxitksINDjR6dm1Bg1hM4mtWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k8utYVm5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=360QBRpnY6c1o6AV5GxQGwycwbmrZg6p92jzKZ/rjmU=; b=k8utYVm5BcFN2zlg3yx2Ym0wzE
	FIck3GzDyTb8T2IRoyOuXydMaeTrrsf0E2nJrMv2glAO84YvfI4SunJjZaZrvVnmV+b1zqd7Gu7gW
	sjYUTiiMl7+qPQeTcbgliPB/Qcyo8bjs+WEvNOSJrBAj9lyPMlBcBERnyPEm3mXWADbIjyAACA3iV
	LdeMrriTonqxymt3yktiMLHF11i99pE8vFV7Tv3s69IORlRxNgyDYqTpMZ9ZJ1FkGQzSUPa1SHvB9
	7RIwyUcLJAWG6NIheapRp12n09E+wO+bkwS3UFS9qai6kNgM4i9O/YYLibgTE6mswhbek+F3Jg79T
	hNrGImMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w9DOz-0000000C2iO-21PC;
	Sun, 05 Apr 2026 02:39:53 +0000
Date: Sun, 5 Apr 2026 03:39:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <20260405023953.GU3836593@ZenIV>
References: <20251219201344.380279-1-anna@kernel.org>
 <aUnHnlnDtwMJGP3u@infradead.org>
 <aUnq_d93Wo9e-oUD@infradead.org>
 <53d40f4781783f9b79196bb30975b788be8bb969.camel@hammerspace.com>
 <20260404183247.GA2798238@ZenIV>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404183247.GA2798238@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20660-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 3B1DA39D28B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 07:32:47PM +0100, Al Viro wrote:
> [cc to fsdevel added]
> 
> On Wed, Dec 31, 2025 at 09:52:35PM +0000, Trond Myklebust wrote:
> 
> > +static void nfs_clear_verifier_directory(struct inode *dir)
> > +{
> > +	struct dentry *this_parent;
> > +	struct dentry *dentry;
> > +	struct inode *inode;
> > +
> > +	if (hlist_empty(&dir->i_dentry))
> > +		return;
> > +	this_parent =
> > +		hlist_entry(dir->i_dentry.first, struct dentry, d_u.d_alias);
> > +
> > +	spin_lock(&this_parent->d_lock);
> > +	nfs_unset_verifier_delegated(&this_parent->d_time);
> > +	dentry = d_first_child(this_parent);
> > +	hlist_for_each_entry_from(dentry, d_sib) {
> > +		if (unlikely(dentry->d_flags & DCACHE_DENTRY_CURSOR))
> > +			continue;
> > +		inode = d_inode_rcu(dentry);
> > +		if (inode &&
> > +		    NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0))
> > +			continue;
> 
> What's to stop the inode from being freed right under you?  You are *not*
> guaranteed to be holding rcu_read_lock(), unless I'm missing something
> in the call chain, so... what's going on here?

Incidentally, nfs_clear_verifier_file() doesn't need to bother with
checking for NULL dir - alias is found in ->i_dentry of inode with
->i_lock held, which means it can't have progressed through
__dentry_kill() to dropping the reference to parent.  So holding
alias->d_lock (which stabilizes ->d_parent) is enough - ->d_parent
is still pinned by alias and it can't have become negative.

"Can't have progressed through __dentry_kill()" is critical here -
that's the difference from nfs_set_verifier_locked() case.

Folks, this stuff can get seriously subtle; _please_ ask around on
fsdevel if you are doing something non-trivial with it.

