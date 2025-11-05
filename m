Return-Path: <linux-nfs+bounces-16053-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E51C363B4
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E30C56746C
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2A248F57;
	Wed,  5 Nov 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tnKJS/W4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04E2D73A7
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354529; cv=none; b=MngnxFP0GE6dyIprDxFrhCfWh4ufQn36mZGsh2F5X1+ykqgo3RACkwi81WcVHrpjsBTdHWBF2983P/AYYIEzYH+vgjTWFQaaXoP+nqZB89Qdxg8rHXNBpgyZI/RWiuv27qn3fkv5hQt/73GeaDqAA1EbEhBqCpB1Lh3puUEM/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354529; c=relaxed/simple;
	bh=QxNOl6Lf2dfgbprm+rQfqmfJjznm9Vxee0hv+r5w3VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/oFW2KAKakZhcvVd5/5DMblkuSmrkB7oYj+nAA7w5AY2rGF6u4Uzp/ZTLK3/HgWYrpU+aJFLlyw/PWR/+X0IuStyIXwS5J0ucKORM5A6SeseTfxlUZ8jeuaXzQfysU4fkTa9u2GCqdZX3Gw1uCNDhryoCYWvjmGDwIYhDb1wIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tnKJS/W4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JTr/4LAnRtkfI7Wb1+lw3oXKytrEme26HcvzOyRRyUE=; b=tnKJS/W4deYNBIJB184neXBxZG
	D3FcewE/Y9tv0kjOP03zBXz5jU0gKxxWCrsbQ254G8sMvQGM/ZJkKloqGbDsYJ1uCRlGS5pENnSBG
	U2HJ6eljZRMI05EwxhZKxOR+D3EHJqR6NMzYC0ffYh0Jt9PYwaCCCXIpcwFgny1GE9rmZ02bHExUk
	ZTjKLOKGLxHwngODiCou4JLoZj3hz9Vdm4CwECXZPzA0nr3ncEx6gU+w0xtmKnICWogrAAbMOGvff
	5TJrB1n31k3scuy5WI6V16aSPu/ZtBTlx/j1+vjV7Kd9Df+1KCazLgpBaaETi6aDxUfORYlcJm19L
	bPefcuCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGeux-0000000DsWT-1U6n;
	Wed, 05 Nov 2025 14:55:23 +0000
Date: Wed, 5 Nov 2025 06:55:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v9 05/12] NFSD: Remove alignment size checking
Message-ID: <aQtlWyVkReHDaEEt@infradead.org>
References: <20251103165351.10261-1-cel@kernel.org>
 <20251103165351.10261-6-cel@kernel.org>
 <176220902556.1793333.10293656800242618512@noble.neil.brown.name>
 <aQnpB4mYMwW9IGM0@infradead.org>
 <35ddc8b0-2727-453e-b970-07b493e21f93@kernel.org>
 <aQtIqn28Bo2ElPqG@infradead.org>
 <a06fd92d-0c37-4b18-8ec2-1392d587264a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06fd92d-0c37-4b18-8ec2-1392d587264a@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 05, 2025 at 09:38:33AM -0500, Chuck Lever wrote:
> > The action I'd see is to collapse the series into reviewable chunks.
> > I.e., fold the addition of the direct I/O writes into a single patch
> > that has all the policy decisions and documents them, leaving only
> > clearly separate prep patches separate.
> Meaning: combine the patches from 3/12 to 12/12 into a single patch.

Yes.  Unless the merging makes it clear that something could actually
be split out as a self-contained prep patch, but nothing sticks out to
me currently.


