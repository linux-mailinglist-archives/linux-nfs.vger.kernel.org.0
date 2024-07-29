Return-Path: <linux-nfs+bounces-5147-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C593F90B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD633282081
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472B15350B;
	Mon, 29 Jul 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQ9w9joL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A13C24
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265555; cv=none; b=FOSAAfie90CLQA3HqJe6x+GQArWmbo5bD2dVRYO1bYT8OxvpykyfV602dBlsJElKES690ZWYrP6uIQwu+g8LvFnFulVHh3hF8aJGYJ0fZaLoFGTU/wUG2dWChbJn5PUTUulAGpHfKvtUvKDggGwfB/UqGZ4kCNOhgJy1IUZEVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265555; c=relaxed/simple;
	bh=giWS+k9+zO1cwOQo4PfQknUNPBIA78uOAKsyAThzj4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxFNiQCpACUYoUTKqmDNleqehBMlzKjCLegwQi6h6lBZZJB59/7xJHHoLaGL3nnjsSUbHaqSoQ4DIEnWPKGS25dC7Uc73gjLy72d9w1T8359HiM5OE8YAEy39xYW7BIu9La4hdOAEMLn67dnrv3qpfklWfFect+9mhJ3VWKZEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tQ9w9joL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mHQP0d1Ui3rf70yEqYTPJvFR//Zl1VoPFRREqNxFmWE=; b=tQ9w9joLdTSv9E8ntqYCN5DDcs
	4iHT6jhZSF87LYddr7rPI3sI5qiQz4pA8LD3WAOz+aRqjU3nwlvIDxiI2yNEH9gJSTB+BApI4Z++M
	StXMj3kT3WdNIB2hcc3sXax9BdRCh1D97/aLMHLxA7UZfu+kNp7Idh2tQ1ABJ+Jtt5LXYHPvILlJw
	igDQUeMiBGXXWnFgoW5inYrzTzEgD2u959rT/Z+9H1B5r8g62X372xaJYEDD9/bs3IQNWiATeoiF8
	R0RJlF0IY5dMONSYnGEZo9c1NK0wkNobpASUfQJJNDxFjcqMf/MqqvwdEYkyvzuEYVDC95hKWPID0
	zrXPIWrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRwf-0000000Bo7m-0Idk;
	Mon, 29 Jul 2024 15:05:53 +0000
Date: Mon, 29 Jul 2024 08:05:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 2/3] nfsd: be more systematic about selecting error codes
 for internal use.
Message-ID: <Zqev0WwqLHa-_ZzG@infradead.org>
References: <20240729014940.23053-1-neilb@suse.de>
 <20240729014940.23053-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729014940.23053-3-neilb@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 29, 2024 at 11:47:23AM +1000, NeilBrown wrote:
> Rather than using ad hoc values for internal errors (30000, 11000, ...)
> use 'enum' to sequentially allocated numbers starting from the first
> known available number - now visible as NFS4ERR_FIRST_FREE.
> 
> The goal is values that are distinct from all be32 error codes.  To get
> those we must first select integers that are not already used, then
> convert them with cpu_to_be32().
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsd.h       | 23 ++++++++++++++++++-----
>  include/linux/nfs4.h | 17 ++++++++++-------
>  2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8f4f239d9f8a..593c34fd325a 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -326,17 +326,30 @@ void		nfsd_lockd_shutdown(void);
>  #define nfserr_xattr2big		cpu_to_be32(NFS4ERR_XATTR2BIG)
>  #define nfserr_noxattr			cpu_to_be32(NFS4ERR_NOXATTR)
>  
> -/* error codes for internal use */
> +/* Error codes for internal use.  We use enum to choose numbers that are

Nit: normal kernel style would be:

/*
 * Error codes for internal use.  We use enum to choose numbers that are

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

