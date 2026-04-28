Return-Path: <linux-nfs+bounces-21210-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMVxGwY58GmbQAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21210-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 06:35:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C443D47D640
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 06:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73B223029AC1
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 04:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BA131AAAF;
	Tue, 28 Apr 2026 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qCTyoM2i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C474CB5B;
	Tue, 28 Apr 2026 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777350910; cv=none; b=nyJomgDk3f9w2MPuJvQgE8oUHj7IoeqKvgxRAn7/Hy8rchRfC6IW2THy4rmNnPcqUMd74xdlvIUU0zRETs+DpS3w5BTCQ6GPjpRZNMBifVTVB09yfRO/JRFadCqZxtpXC4Lnv6F1SZHHqclDBuzWcLcD9bPkkB3UeC/Bt16DDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777350910; c=relaxed/simple;
	bh=Zm9w5DNleu17gjCBn+k9YgYm2EnLrdy5BWM0YsdbSjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOX4oWU/i+/YgWRm4Cgk01urD6q9DuroVXy4cUoUN1LiODL24Uo/BrIthkTcPymVj70efroyWuynTAUluamzJoaKowyQCKlcusFB5I3ViFrcYSjVxJsr/75IzmlAZQwJaWtdK+GS9125lAVwtpU7d2EqKxV6U4jtmC4WMnlVkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qCTyoM2i; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rsgzUrrq3PeweHmEyreyOSkp3xwGzOg4HYman1OvYvg=; b=qCTyoM2iNh3bWDZwKKCwKNsKRv
	Zv7AKovym44iwdfb+9rwbr26SCluYNOG0jj0uBhbm+E2XydXO9tpopcQSogXi9luvAmJwTwyNtTc3
	UBLR/7gE+HAJNM/7XPLxoGVBBnM1pHiwi39SmVRE3aj4YmW9zS2p2alZ8yAMixRh1k2WeDRyhNKUx
	xtxGQvYmXwch0248GuD2iD9f6OoiUrFg5z9fIp2AwJzpB1zSbztviCqQVS+5BqltN/LWf7nbXoERn
	vo9F8LtvlKhs73FAA+j2lfcpgdXSJmkPOxHH+jCwEge3vueS5WsYkH9OhbIQWoe7pllZjIQjF2WTl
	0e1i7ZBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wHaAB-0000000GRH3-0Xc2;
	Tue, 28 Apr 2026 04:35:11 +0000
Date: Tue, 28 Apr 2026 05:35:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/19] VFS/ovl: add d_alloc_noblock_return()
Message-ID: <20260428043511.GW3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
 <20260427040517.828226-11-neilb@ownmail.net>
 <CAOQ4uxiZF0_dGtHY0x7T0oh=3jhDC7-THH_ANt-Ha5kfdRe4QQ@mail.gmail.com>
 <177733649056.1474915.2313612194633470905@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177733649056.1474915.2313612194633470905@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: C443D47D640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21210-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,suse.cz,szeredi.hu,ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 10:34:50AM +1000, NeilBrown wrote:

> > This contract is a bit subtle.
> > We have plenty of contracts where the caller must dput() in case of success
> > or in case of error, but must dput in case of a specific error that
> > sounds fragile.
> > 
> > How about:
> > * If the existing dentry is d_in_lookup(), d_alloc_noblock()
> >  * returns with error %-EWOULDBLOCK and the blocking dentry is passed
> >  * in @dentryp. Regardless of the returned error, if @dentryp is set by this
> >  * function, the returned dentry must be dput() by the caller.
> 
> That is sensible, though I've used slightly different words.

I would add "dentry reference stored in *dentryp may be in any state -
the only thing promised is that the reference is counting one;
do *NOT* expect it to be in-lookup or in the same directory or
hashed at any point or anything whatsoever, really.  Users beware."

In case it's not obvious from the above, I don't think it's a safe API to have -
there's very little you can do to that dentry other than dput() it and it does
change things in a fairly subtle way: right now in-lookup dentry is *not*
visible to any thread other than caller of d_alloc_parallel() that has created
it.  In particular, d_in_lookup(dentry) can only change due to actions of the
same thread.  With this primitive added this is no longer obviously true.

