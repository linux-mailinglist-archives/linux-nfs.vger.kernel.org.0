Return-Path: <linux-nfs+bounces-11480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4ACAABCC4
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1783D1880310
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478C22331E;
	Tue,  6 May 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dpXyCir6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE68220F35
	for <linux-nfs@vger.kernel.org>; Tue,  6 May 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519021; cv=none; b=hfFWjB9c38ilCY0VewW8f5MhHnGLWdtk4S4YtOY4DQk7o4Wy+OnlcD+RY/4jZOQjuvMQJhOuQIUGQ646SceAg38hrr7w6Bt45qewCyqmx/vgIwEZU51V8N/u8htGUHGyO+b7F27UQGT4bbI0AXDfpK22JiIT/+DU5+Ux/v9ePA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519021; c=relaxed/simple;
	bh=xPHtwcRyZypI0M/zn8r69qHb9Kf/LIapegrnkyfz0hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFgjUnsg+GhGagUVCb/4i8/Q3AbrIASVfAze+pQH1dRALx8OUvZNCO2fWqnOwFJ8tTdOYw9hzkprGi8akiMHPvXFRb4GoFzdR3hs4No+alwbiJ4Pdt5Qn4FK8iPWHNytU/KNwZcLlCBnRrbjP3eGA3WtmsI3u5UYl8pRHyoLiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dpXyCir6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OzyOOjeOVLi3r7iK57XVv83fbG54a7AzVwvdvL8XGrc=; b=dpXyCir65jLVHUNe+M0mIzRPzT
	G6rN7Zfn/tfTYmDO19gLzwNPRYATVP8wwNUEuFeZIjb0Ukm02conF4KL7jKsWeEV2J5yVkBbt49DM
	2jDuae7zp4hfDN5cqkegw5bKf1st9KoX5hmTfeqUbAb3+OUACL0aAwkfVajPPWkEqLv6DNYAqC5uM
	/fM/EZPirYwLuIQaOVNCeySXjw7ioJ7FeQHCYVlN7CYwTEuBwylfvCCa2rTUgnDXx56IEOQ78VwjR
	ncsVSGHk2YgZ3s64pIDBJWlYMdYp7OFBzYbM5kpqz7Ej2BnSf3ao2Hm+hwIUB2s/eK0nkghHp2YNh
	I3MZOCJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCDNZ-0000000B6aE-0yMf;
	Tue, 06 May 2025 08:10:17 +0000
Date: Tue, 6 May 2025 01:10:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>
Subject: Re: [PATCH] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
Message-ID: <aBnD6Wj1yq9MP8ZB@infradead.org>
References: <20250427163914.5053-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427163914.5053-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Apr 27, 2025 at 12:39:14PM -0400, cel@kernel.org wrote:
> NFSD can return 0 here, as at least one client implementation we
> are aware of (the Linux NFS client) treats 0 as meaning "CLONE has
> no alignment restrictions".

Usuaully clone does have a restriction, though.

> Meanwhile we need to consult the nfsv4 Working Group to clarify the
> meaning and use of the value of this attribute.

Yeah, the attribute seems to be severly underspecified, i.e. it does
not even provide a unit that the value is in.

I think the only sane way out is an errate that makes 0 mean
"not specified" and then provides the byte unit and maybe some
other quirks.

> +	/* Linux filesystems have no clone alignment restrictions */

That is absolutely untrue as said above.


