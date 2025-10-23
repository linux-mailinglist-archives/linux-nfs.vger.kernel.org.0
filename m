Return-Path: <linux-nfs+bounces-15563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E2BFF5F2
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 08:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25CBD35767F
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 06:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0EA28D82F;
	Thu, 23 Oct 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yPypZO/c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF23279784
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201603; cv=none; b=tmF8mza0WYpMioPnuzusYRUaroVoLHOUVDBezb6MH0SfokQ/SaFWy8YcAJskihob5EGEwsrQM/BNhuj2Z1C3emG6Ms/Suxv8NFu+fzc/ZSoJahCS8PaniZ2cjqdb4xmXEdzbBpA4Ftux6Mcgt0uQJa2OOeX6/tI02EFNgvJB9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201603; c=relaxed/simple;
	bh=Y6/cVWozQEm7XgXzQwkSZ4yo+vMKovKzDu+4MKdy4Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHup5YIkxgRHsJQ+CBJd57aX+LeZahyf/O14jYeKmWc4hzQbaIejLqk8E1HUzTZEH+8n35WzX3DCTRlBNkPOtz3QScD4nFApeCsg7fcPcFIVvtfvscBN2LKiRlkULPJ/7H5lPPUZXwm6yh5fweI/6u08PKDLUf+UQoQKENdpPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yPypZO/c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=65JbCq98auAx0swzsecpZ4JeIShnUcBYRbYR2M0ONFI=; b=yPypZO/cNEM7pjhukgRcK1fxJj
	iwnI4D88yUcuI/lZ6vS8KVS9S4j/JTj3YdGPxB22i/w5m0beNwNPrgRRZNj9gE11HyLA7x0hDxMUh
	AKoX3FV57IxaRP8zax3CeJnGdu+M6pRBKYLGYFoimCq/7yRKDvOhAUY5mq2JQqdFBKHhBqSSfyJgH
	xSVv1neEVVeGDAKPrd807VWwkAduz8ZAo6eaivQlnek8YdCUDCCaKbG9YUYhoiJdWztNnnbI78UsE
	5Up/NjpDZbhB1EDgdTL2d1hE/Xg9l5wSi/ls3u8A5Mnl85KVs/VapgFYiFW7NGdDKZAR+HFobHI+u
	0hXINj5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBozP-00000005Ea8-3uAB;
	Thu, 23 Oct 2025 06:39:59 +0000
Date: Wed, 22 Oct 2025 23:39:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Talpey <tom@talpey.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aPnNv3zLgJD6RCkB@infradead.org>
References: <20251022162237.26727-1-cel@kernel.org>
 <63c79d16-fec8-47f2-ace3-0b8fd4f41528@talpey.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c79d16-fec8-47f2-ace3-0b8fd4f41528@talpey.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 22, 2025 at 01:22:52PM -0400, Tom Talpey wrote:
> There needs to be some statement of the performance consequences of
> removing this "optimization". I'm going to predict it's significant
> on rotating media, and should not go unmeasured.

This has absolutely nothing to do with rotating media.  The only
difference is for pure overwrites.  If you have e.g. a database
workload that zeroes once and then overwrites you will see a difference
on SSD and HDD.  For anything that extends files, fills holes etc
you won't see any difference.


