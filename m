Return-Path: <linux-nfs+bounces-17580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3455CFF43F
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 19:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33B034381F2
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E93644BC;
	Wed,  7 Jan 2026 16:25:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD23A1A33
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803127; cv=none; b=QjW8S9ZnExQDY9Nyk8WX65yM3bR6mpQh8jpSr/aUp/oJsyMZzxp6pMHHzlx7soDnZliUz3J6/4jJYx9Ep8YWSM5MbGOll4Ll2TP5MIVzIUEEa52yOyldOkoE12PTjPUk+gDfzxSHQerFonXbneTuJKG42gHbyKhgrUGypZ+pIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803127; c=relaxed/simple;
	bh=LBoO/WKyGrWkTJjIIFR/bEG/nVRFEv+T+MDk2lTfqiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXh9Sc4OEWhThQhIHqnWElgDFKQbAccP/YlqsWk/pIXqjklrcgt/ieeLkkqpmoNlLCvOwFydnrqHwrNFJbqlpN2dsZzqeXCC4etpsnyJa6lrjfwKM64X/BC5+UF8qaxOI/TWgRTow2/mVJO9Eqi1DZCtwodlTctp1KiE4bCG9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 747C7227A87; Wed,  7 Jan 2026 17:25:04 +0100 (CET)
Date: Wed, 7 Jan 2026 17:25:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 2/2] NFSD: Add asynchronous write throttling support
Message-ID: <20260107162503.GA23222@lst.de>
References: <20251219141105.1247093-1-cel@kernel.org> <20251219141105.1247093-3-cel@kernel.org> <20260107080057.GB19005@lst.de> <cc3a3e80-7b2b-4652-811b-c2a126daf9c7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc3a3e80-7b2b-4652-811b-c2a126daf9c7@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 09:42:58AM -0500, Chuck Lever wrote:
> I'm happy to run with this one and drop (or postpone) 1/2, if that is
> your assessment.

I don't really understand what exactly patch 1 is aiming for.  Not
stalling nfsd threads when congested makes total sense on the other
hand.


