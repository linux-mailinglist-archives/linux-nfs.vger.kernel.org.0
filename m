Return-Path: <linux-nfs+bounces-21134-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCG1MDnc7mm+ygAAu9opvQ
	(envelope-from <linux-nfs+bounces-21134-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:47:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38846C922
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 05:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CC563005663
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 03:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5C362154;
	Mon, 27 Apr 2026 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qaYZ7R1B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29753361DBA;
	Mon, 27 Apr 2026 03:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261623; cv=none; b=DjnrwLiswADVIYmN62FhuKC8agR0NqF6BeuaDHHF1L5J4s0GHnaxc0HOzQmG5Nz2182y4d9iOTmJhhwWWVS0T+UDGT31urd6Ufts3L6EQPYty7SoXmajpTXOlb9lGWQvM7UTrT+AxjfzREn/I6L63oJduKMag3XXy2gIIZuojDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261623; c=relaxed/simple;
	bh=PXtHrkpeoeEZCNni7njwoZ/gPRQg81Uvu64iZ5CXssk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHBNOOrnPgW12zezDFmfdmH79fXvN2yMPA/DRmxCkoepoY0u8w0XykAutti8KLPhrbvfUeFQRtFc7LUFdbhp93OodRO3uiHMU/zQOn3TmcgS6KBYlxJ9ZRiWM+Ir5tqZoBSbtt9K3OruWwnNP0XbHUcw0YWphs+qPqjiZ4N6Ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qaYZ7R1B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yX5gniV3PFQjBtZAVsjCI1d+uQEPy+M6yDq46UbG8R4=; b=qaYZ7R1BSz12zM7uf2Pg+BOLEI
	TaUVYBVdwxpOrDqPxJv+1tXBM6U+0fQ46t7C9VKfseuSBd25/FUIp0dBj4H9guVawLFF16xug3tc8
	RXCDk17YKOxrTaGYw0X/yAaxwYUNTeF0VFyo/m0aplUX2MmEDzvwNZ/dJgt10idP3FmL866Xx+IkE
	D3o9g5gealOy2ZNy+yWUKVmBdQIwXXpVIFeQGOUcW2VgO6G2vN9IND4zEYziIXmsENC4bHcNqyiOZ
	YsakHfH5mFn/YYhM6B8Djcu7A5+F/8NDSkTSuvnPjQ3qzbjU/xBgUxv3n/j8cNW42jszBirn8XKGi
	qM+jQ0zw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wHCw1-0000000Avps-1Ify;
	Mon, 27 Apr 2026 03:47:01 +0000
Date: Mon, 27 Apr 2026 04:47:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel
Subject: Re: [PATCH v2 00/19] Prepare to lift lookup out of exclusive lock
 for directory ops
Message-ID: <20260427034701.GS3518998@ZenIV>
References: <20260427033527.773006-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427033527.773006-1-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: 3E38846C922
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21134-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,szeredi.hu,gmail.com,ozlabs.org,infradead.org,vger.kernel.org,vger.kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:dkim]

On Mon, Apr 27, 2026 at 01:29:33PM +1000, NeilBrown wrote:
> This patch set progresses my effort to improve concurrency of
> directory operations and specifically to allow concurrent updates
> in a given directory.
> 
> It is a selection of patches from the 53-patch set I posted in March
> which got relatively little response.  Maybe a shorter set will be more
> approachable.

Got it, will post a review tomorrow.

> This set:
>  - prepares the VFS in various ways
>  - make use of these preparations in ovl and NFS (the most challenging
>    filesystems for lookup as they do the most interesting things)
>  - make use in efivars and shmem which for different reasons need a small 
>    change that seemed worth including here.
> 
> The goal that these patch work towards is moving lookup out of i_rwsem
> on the directory - except for the actual ->lookup call.  This is itself
> a step towards allowing broad concurrency of operations in a given
> directory.
> 
> There are two particular requirements before lookup can move outside the lock:
> 1/ d_drop() mustn't be used before an operation completes: the dentry being present
>    in the dcache becomes part of the locking protocol.  This in turn requires
>    d_splice_alias() to work with hashed negative dentries.
> 2/ d_alloc_parallel() mustn't be called while i_rw_sem is held, as this would
>    result in a lock inversion.  So d_alloc_noblock and others are introduced
>    to handle the various cases.
>    In a few cases we need to drop and re-take i_rw_sem inside ->lookup.
>    As lookup might be called with a shared or exclusive lock this requires
>    a new LOOKUP_SHARED flag which is ugly but can be removed after the
>    lookup is moved out of the lock (then ->lookup will only ever be called
>    with a shared lock).
> 
> The full set of patches including these 19 and the rest to complete the
> lifting of lookup out of the exclusive lock can be found at
>    github/neilbrown/linux in branch pdirops
> 
> Significant changes since last time are:
>  - use wait_var_event for d_alloc_parallel() rather than effectively
>    duplicating that infrastructure - as suggested by Christop
>  - changes to ovl_readdir handling as discussed with Amir.
> 
> Thanks,
> NeilBrown
> 
> 
>  [PATCH v2 01/19] VFS: fix various typos in documentation for
>  [PATCH v2 02/19] VFS: enhance d_splice_alias() to handle in-lookup
>  [PATCH v2 03/19] VFS: allow d_alloc_name() to be used with ->d_hash
>  [PATCH v2 04/19] VFS: use wait_var_event for waiting in
>  [PATCH v2 05/19] VFS: introduce d_alloc_noblock()
>  [PATCH v2 06/19] VFS: add d_duplicate()
>  [PATCH v2 07/19] VFS: Add LOOKUP_SHARED flag.
>  [PATCH v2 08/19] VFS/xfs/ntfs: drop parent lock across
>  [PATCH v2 09/19] ovl: stop using lookup_one() in iterate_shared()
>  [PATCH v2 10/19] VFS/ovl: add d_alloc_noblock_return()
>  [PATCH v2 11/19] efivarfs: use d_alloc_name()
>  [PATCH v2 12/19] shmem: use d_duplicate()
>  [PATCH v2 13/19] nfs: remove d_drop()/d_alloc_parallel() from
>  [PATCH v2 14/19] nfs: use d_splice_alias() in nfs_link()
>  [PATCH v2 15/19] nfs: don't d_drop() before d_splice_alias()
>  [PATCH v2 16/19] nfs: don't d_drop() before d_splice_alias() in
>  [PATCH v2 17/19] nfs: Use d_alloc_noblock() in nfs_prime_dcache()
>  [PATCH v2 18/19] nfs: use d_alloc_noblock() in silly-rename
>  [PATCH v2 19/19] nfs: use d_duplicate()

