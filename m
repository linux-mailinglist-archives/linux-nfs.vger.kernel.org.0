Return-Path: <linux-nfs+bounces-20658-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE+nL6Jg0WktIQcAu9opvQ
	(envelope-from <linux-nfs+bounces-20658-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 21:04:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8C139C2BC
	for <lists+linux-nfs@lfdr.de>; Sat, 04 Apr 2026 21:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98C703004620
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2026 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299713375D5;
	Sat,  4 Apr 2026 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nYk9y7bc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFE322B8C;
	Sat,  4 Apr 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775329440; cv=none; b=uj86zK3eWuaXYT/yDiKDzjN0qPYYzRDLm2m2dmBF5/EqHCsME+1sopGReb2670n3a+PAFU7C2fNHHjfCVjrAu0kL/3DqgQYDkdCcBltgg0HD+WA8dC3sFrR01svfdPAqxTlSn5cRaSBkhXNAAW2ixKId8Tu8ZLQRT8qLIWCvtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775329440; c=relaxed/simple;
	bh=teF4T6r/ZBCYWTnL9Nei23nnrHYz45LEoGSw3jT6Bbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Prt2EgQ4WxCW1cKgwdBoNrxtersCD9UNbeixD5GAtKznn3kt65wbQq9N/hpYzXgm7l8Cx5njFsHefWbTdy/7s8Uxc3ICq/19Q6AemV4VgesWmB9FIBFAnpM0BXtSS3xIJvzss3kttcCWFe0VW/zrmR/Ix7+1lrUH8ZFYm1y9gmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nYk9y7bc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oxPe4crecvenyF8DW1LxaTMjuqLjc2XBQMWQ3aIZXNI=; b=nYk9y7bc/ZwHGmKEW7MuSQYGON
	I4sP7YDMy4agDMgXJRQXK3zVGUUfJZ9bOkoFaTWki5YT2pTWtod0H2ugJOPW5nbExu7p1eGFnNGd0
	5sxiOK0ScHkRcYbSk6DhPVhbMdQ9fFHgMf6kipN6VTm4KRuvcBlrX0gmZcrWibVm1VvZ1dDqyX67Y
	hL/SmXtr19YTIj3xTkr1KUPoAkE+D2fws7+G9XGjNSI45gC63jIUjyD2p3JjcE012mdAovfFU0c58
	jr2V78BA4s4/JYmzAHFfrVeAaLn35pJcC5WsCnIY3jqcboJfhepx8W2cJTwih9dJb58+3KKQLvh9w
	FNTWnsbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w96LI-0000000BlhV-0AG1;
	Sat, 04 Apr 2026 19:07:36 +0000
Date: Sat, 4 Apr 2026 20:07:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] NFS: Fix directory delegation verifier checks
Message-ID: <20260404190735.GS3836593@ZenIV>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-20658-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 5E8C139C2BC
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

While we are at it, what are cursors doing on NFS directories?  AFAICS,
you are not using simple_dir_operations there or anything that would
call dcache_dir_open(), for that matter.  Confused...

