Return-Path: <linux-nfs+bounces-20581-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJPoG+a6zGmcWAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20581-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 08:27:50 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2393752B8
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2852E303133B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943442C11F9;
	Wed,  1 Apr 2026 06:24:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94131717E;
	Wed,  1 Apr 2026 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024699; cv=none; b=fOvBesy4ETMg98T8ucLsckKM16QSCu/ISXqfxty7RBV0Hq8DSRYdhEdJiq66re8PEi8M61ylQvCVRsetE52r982CgyWAqMXX7FtLfj/qhc58p4gY7gKvGDFL81Nms+8J/xH6ih+Gfzl1eGzpuuXukhYu8l/3fLLVLNpwB/6B3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024699; c=relaxed/simple;
	bh=Aw7O1MFbui3G1eX050/dgKGxBWIJSJLDF/mpD8/sqhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX4oAwmDR71bOQp4raxqa6xWKcHyEIBoX91peg07XC0iRT7BjWsqNS5QBhTcvu7JTS8pgej0UYpA39PtZT4xvasJBUoEEa/A/4NSgs4xS0G0LbdSs94d+Vh9/0PWTsCoZHC3kHu2l9LecFY/Lo9+mdy0PxDkQz7Npg7RZCPiFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 98C6568AFE; Wed,  1 Apr 2026 08:24:55 +0200 (CEST)
Date: Wed, 1 Apr 2026 08:24:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] exportfs: don't pass struct iattr to
 ->commit_blocks
Message-ID: <20260401062455.GB24374@lst.de>
References: <20260331153406.4049290-1-hch@lst.de> <20260331153406.4049290-4-hch@lst.de> <bce25daeba83f6454b0bdf49c221e76a6843f9b6.camel@kernel.org> <13cf0349-b627-4324-aa0d-9d51a3429caa@app.fastmail.com> <eaa83e161502807046137baf1c78b4393cad2624.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa83e161502807046137baf1c78b4393cad2624.camel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,oracle.com,gmail.com,brown.name,redhat.com,talpey.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20581-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED2393752B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 01:33:10PM -0400, Jeff Layton wrote:
> > Disagree: I think the change in the first patch needs its own
> > patch description and motivation.
> >
> > > since you're making that change moot (and the
> > > ia_* times don't matter much anyway).
> > > 
> 
> Your call, but note that the changes in the first patch are completely
> removed by this one. There's really no need for that patch if you take
> this one too.

The big fat comment is still left.  The first patch is mostly intended as
clearly documenting what we're doing.  There is no behavior except for
sampling the current time more often in it anyway.


