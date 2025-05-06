Return-Path: <linux-nfs+bounces-11485-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85251AAC557
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC9A5225A8
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5526127FD6F;
	Tue,  6 May 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIwcdzGk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFC2459F1;
	Tue,  6 May 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537055; cv=none; b=GXzU7NUTkTCQkpkhPCrE+r+D6B8q6zm5Lxt02lLS++kvENHzO+EwjI0RTAUPVN46WGy1z3xXlyqYmSwV3TSu/I5+/zUoqdP0pZekIadfw4X29Z9LTQCB98kGX6HEqv84qp04XvThgbWbRPpcl3TJg2WcfmlNsuzkhWpTP3kmFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537055; c=relaxed/simple;
	bh=2Jn/q7wrqigX+WJqNmb3g1Hxjl1PVQS0cJj8PVHicEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RggBpkA+5Ew/dqfrnB0bKIhZffKTlgfLfX/9Pnv4KgF7p3Z7BQ+yeLpf5Ojp+cWYc25F7maPUuRZLNxMiaMLpqM3r2UQ46cJwgftzVdsRPZjsv2UJDkkAJdm5g8ZDkKOr+fsDMYiBNZs1uLgg0noPwSprSxUk4+w/S9nvCcPWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iIwcdzGk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zF7MlYwOz415ocou34JPf1BvGpKrOcrmNJyOmdpy+SY=; b=iIwcdzGkTHYrZBoERSlk/nR1XM
	lbfqgl1zOUp68gJ6astHOu9yFgx8TF3HzzmfbUUoN7+juhtxYDFPuLPLn1S9++uRL/PNAiQXisr4w
	LzW3bcEyR6uYC8j9WXS2GECo7wKr4Bwc6qYQ8jo25/ywQLn3FMj05FOUj7VdK+rq8gVQhW6z/NfqY
	P0LJt1kAP3rAsSYfJLKAJQlV6w6+IXvsxp2tD9iYF9xq+5F0UREkTt5VSfAjpP+pWCLrbhFKM3l3I
	9P5rh/tThqde7h2gAvfpq7WVdAWcYnZZRAnHwTP6Q7n2U22BbTwLkCw8/prCquHlIPSyJDv8mTiWA
	sSULRelQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCI4R-0000000C2gt-3AyK;
	Tue, 06 May 2025 13:10:51 +0000
Date: Tue, 6 May 2025 06:10:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 02/14] sunrpc: Add a helper to derive maxpages from
 sv_max_mesg
Message-ID: <aBoKWw3pesMCpu0X@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428193702.5186-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 28, 2025 at 03:36:50PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This page count is to be used to allocate various arrays of pages,
> bio_vecs, and kvecs, replacing the fixed RPCSVC_MAXPAGES value.
> 
> The documenting comment is somewhat stale -- of course NFSv4
> COMPOUND procedures may have multiple payloads.

This helper looks fine, but please don't talk about the kvecs.
The fact that nfs currently only allocates PAGE_SIZE chunks
is home grown limitation that shouldn't be there.  I have a series
trying to fix this, but it got stuck, so it might take a whіle.


