Return-Path: <linux-nfs+bounces-21208-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAnFHC8a8GntOQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21208-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 04:23:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29447CB86
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 04:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69A613046E94
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CE3921C6;
	Tue, 28 Apr 2026 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mjXWv6r2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87F390999;
	Tue, 28 Apr 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342964; cv=none; b=LtQX4Bt3F4erW9vWPLlhg8BaSxgTf1dRQrFkdedeNLenKqgBXNVip3wON5pCRhupefAfLX9pS4zuJGPNm+5+Sl8KEr37jWM9zN7gCxmUnVRKC+/y2igqAm82HY6/M960zwzEvKT6xQIZoSdTwDFf45lDaojalXmVc8fA4iRVYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342964; c=relaxed/simple;
	bh=UCia1IcO0LRuZrQweVktWn+d4QaePflZAJFonZxyAN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX+CPCkLl99pk3i7/oOMo0UMriRMTlaxndtvIqpMdlqNIFegZOCoKrPtK24Hou5nlekp+bO4cejoCXNpChCk2Nx5E5QUY4lufaeBGC/r2LQY1Q6gw07tULnXtLYPNjlvgtZUb0rjUUMBFIoJk8yPOets6p9ssZc3nLaqvxs+REM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mjXWv6r2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kpIAu5jYgeVlU8I7a3oFm2SUIDSJX80p3CvY1ihlZAw=; b=mjXWv6r2BpSV5QXli0cB0CekDG
	KHSTq5SWdr/mnwvVKRLP4FH4d6acXHrP/21X+qkLP25zkw/NK+cwXydC69S8skiEtFseLSZbf49HQ
	PzkWog0crr1xHWLwzeySMXCnqyvsrh7ZjvunTchVCaUEQVN80TdApjY6B57WhSW21eoJrAtrmMbrc
	jjR08ac3xIgeoJyGNR1wsYGeMDjXO8bRYt3QUn/Snf+XqUmzWGA+Txdu30gb1totyjUjKqBrz8i/q
	yqJonmaGtBQZ9nUmaag4EhxCWLpvADpVfbJNibP78xM7HAoS39JSvLxHB6QXUvnBlNCJaFSY2oi32
	2QqCqxyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wHY61-0000000FyCX-3SbI;
	Tue, 28 Apr 2026 02:22:45 +0000
Date: Tue, 28 Apr 2026 03:22:45 +0100
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
Subject: Re: [PATCH v3 05/19] VFS: introduce d_alloc_noblock()
Message-ID: <20260428022245.GU3518998@ZenIV>
References: <20260427040517.828226-1-neilb@ownmail.net>
 <20260427040517.828226-6-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427040517.828226-6-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Queue-Id: DB29447CB86
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
	TAGGED_FROM(0.00)[bounces-21208-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email]

On Mon, Apr 27, 2026 at 02:01:23PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> Several filesystems use the results of readdir to prime the dcache.
> These filesystems use d_alloc_parallel() which can block if there is a
> concurrent lookup.  Blocking in that case is pointless as the lookup
> will add info to the dcache and there is no value in the readdir waiting
> to see if it should add the info too.

... except that there is - large part of the reasons for that in the original
user (procfs) is that we want getdents() + open() + fstat() + compare ->st_ino
from fstat() with ->d_ino from getdents() to work, even if you race with lookup
from another process coming in the middle of your getdents().

What are your plans in that area?

