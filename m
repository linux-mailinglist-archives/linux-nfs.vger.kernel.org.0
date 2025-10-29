Return-Path: <linux-nfs+bounces-15746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5CAC18B65
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 08:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C7E1C882FE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 07:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D0128695;
	Wed, 29 Oct 2025 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p369sthV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9941C861D
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722719; cv=none; b=RoUe5c5l4sMkaCIrQtFsm1IeI3tBQIKCq3ouGvrBIfhY+n0Z0wQWWExP/V75l/Sc4W49THqlIqgpcTJu95h9zx/mHXoLvZAMItW7NltOzdIUlI1qe1lOkPjEuUGUQ+rWSRVGGOmXNvimEwuGTmXyunmV94v8eaUH41yjzJnOHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722719; c=relaxed/simple;
	bh=tK5BFGIB9y19o0eO5r38Zhrluv/FG4EX/qh5ptv7ESI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3+F9Enbxmi8Ptup+FW70GINL8owzuR9l2n2yB4BfUk4kCLsYiQsb2GYH0eeErwZ4AyMKeHHNZmEwsuJF6o08zHHtl2bWNUYNgsjguTGrgDiMXfW/oyuSXAchgbNd3Vyx5zgqxzVNXAGImAmWWZCPePkplA0n7XC9itvrKopBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p369sthV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dCwjneWkdeYG3HBABxFhBOejYu4MOLaeIgOyqDC0YkI=; b=p369sthVwguc4dGmFabpuV5Fsh
	ZcO43CGKtryGcZvdnT4RZutak3V0mcFM4dUuiqzywFDZMZyZ8W5ToyOEpFdwnMmWSzNQeh/bw2P6T
	kqsSwKjtdY+JtmMktpNX0cP35u3yt7gXrX7pwEE2dKna62+vuftfl7tP3I3xcPnPeRlnHRejADYPt
	tE4VTM8fUnTstdkSQL+rQMsMBnmFiXQDTsijWqC/WqM39Fx3Pbl37hPgeItW/TvFtmnskzfCcydTn
	QNHjNlcG1R4EcFKv3m+plCCjzKfoQBaKTn6CY50bDC7ERdHTDfwMR4kQ60fv3g2JaZ0dmAKnJRQ9S
	KwOlozLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0YU-000000005aw-42nt;
	Wed, 29 Oct 2025 07:25:14 +0000
Date: Wed, 29 Oct 2025 00:25:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQHBWu3lAfjgC8Zg@infradead.org>
References: <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a221755a-0868-477d-b978-d2c045011977@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 01:57:25PM -0400, Chuck Lever wrote:
> The compelling reason is that it's generally faster (or less work for
> the NFS server and its storage) to sync the metadata after the client
> has sent all of the data it wants to write. This amortizes the cost of
> the metadata operations, and allows the server to get the written data
> persisted (if it makes sense to do that) while waiting for the COMMIT.

Yes.  Also IFF the client does not want an extra COMMIT it can ask
for a stable write already.  And the (Linux) client already gets a
hint from the application that it doesn't want to do the extra commit
by using O_SYNC/O_DSYNC or RWF_SYNC.  So there really is not need for
the server to second guess the behavior here, and instead the client
should be changed to do this (from what I can tell it currently doesn't,
but I might be missing something).

> If you want to make an argument about data integrity, let's
> be as precise as we can about what we believe might be unsafe. The
> data integrity doubt was with the unaligned ends, IIRC? If we need
> that extra bit of integrity, then WRITEs with an unaligned portion
> will need to be IOCB_DSYNC, and then promoted.

IFF.  I've not really seen any argument for that.


