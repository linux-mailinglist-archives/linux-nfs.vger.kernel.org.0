Return-Path: <linux-nfs+bounces-20845-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK7hFkMi32ngPAAAu9opvQ
	(envelope-from <linux-nfs+bounces-20845-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 07:29:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD09A400776
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 07:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67DB5302F385
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Apr 2026 05:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D731B810;
	Wed, 15 Apr 2026 05:29:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1EE1F92E;
	Wed, 15 Apr 2026 05:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776230970; cv=none; b=f9IWkRVVHvjWY0qG/blo8FH5yCASggo1Tn6nc/kAMVPD4ujTg9v4gAO/a4GRXhd243FKtnZguD0noe4EP0t/arENX97vJf5OKTYDdxUAfJL8pyQcwCBxB8KAl4ro7Ch5vD/I56bHkxBl7KeswSxX0I3f7qQJ7S7ridsLqmG7uCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776230970; c=relaxed/simple;
	bh=A5ymAytPJqONoKE2CgJqhBX5EEV4sZwuOHV8kE2E2i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVOedfdw7cTzBb825nchuT2hzIwHP1zlpTb82twelF47cC36O8B72BF98inv35e1UxKX8MA7Yc50Sa+muk81wJVhD8vggz6jyFnwZ0kgJHd4fuqIe5dZwRvr2NOGe8XSltYgVXHruPcxuJXjge+bEc7F6DugwjSFtlAkJxihI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBD0B68BFE; Wed, 15 Apr 2026 07:29:25 +0200 (CEST)
Date: Wed, 15 Apr 2026 07:29:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleanup block-style layouts exports v2
Message-ID: <20260415052925.GC26559@lst.de>
References: <20260401144059.160746-1-hch@lst.de> <8bef4d4e-1c0d-451d-8854-ed0cba27ee1f@app.fastmail.com> <20260409-schwalben-neutralisieren-fb5a184e5049@brauner> <20260410111007.GA10292@lst.de> <20260414-ausbrechen-gemixt-ff09f46bdad2@brauner>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-ausbrechen-gemixt-ff09f46bdad2@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20845-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,gmail.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: AD09A400776
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:01:39PM +0200, Christian Brauner wrote:
> On Fri, Apr 10, 2026 at 01:10:07PM +0200, Christoph Hellwig wrote:
> > On Thu, Apr 09, 2026 at 03:26:09PM +0200, Christian Brauner wrote:
> > > > Christian, are you OK if I take this series through the NFSD tree?
> > > 
> > > Hm, I generally prefer infrastructure to go through the VFS tree.
> > > You can get a stable branch ofc.
> > 
> > Communicating this earlier would be helpful.  If we switch to a new
> > tree base we're going to miss this merge window.
> 
> The series was sent on April 1 so with about 2 weeks before the merge
> window... If your series isn't ready by -rc5 what is it doing being
> merged for the coming merge window is the other side of the question. So
> afaict, there's no hurry.

That's a very weird generic standard.  I know a lot of subsystem don't
take complex core changes until a bit before the cutoff, but killing
3 weeks of the merge window for everything is odd.

Even more I'm not even why we're having that discussion - exportfs
has it's own maintainers, one of whom ACKed this including the whole
tree discussion.


