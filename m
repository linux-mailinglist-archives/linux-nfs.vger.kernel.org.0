Return-Path: <linux-nfs+bounces-12966-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1525AFFAD5
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5529E6421E4
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37337289344;
	Thu, 10 Jul 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0rQ6/oJ3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB128751F;
	Thu, 10 Jul 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132451; cv=none; b=Loju6D9QFNpTyIqHmEyFU/xUbodJEGNhLqQ6mewxuI3e/CFRFKcgsMLYBBoSZ/Dz6LeiXgrw+S4mCNfARzxuaqs88P//wgDh6b8T3mYlBxpFUkx9AoPrQEFBQqN/11ldkavO7zy5SBsA3N93ia+YoHZ+mEPoLpO9WwFj+f/+wHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132451; c=relaxed/simple;
	bh=g8YKwRBQ/Daz6OJS1mQgLxGoQfTbhZoc2pRv7WiVHAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIgzBRuNbwZd6lbqdIAJeSZTfIkhgWoTRZgfrcbTKVHhNrJYrdBAZ3eHSNr2oKfDAHC29no1akknTiWo0zqYiVBtLX/+ECmhusg/2D1LEVkamjTAoOuUJPeOZvU2tpR0tDL78t46Xdv71x7+Nk7PBwZLPtJCKweb924r7Fj37Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0rQ6/oJ3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ap7vfZ6nvvwfafMk1H3deMvYucsWuAVGhSig+rD+R/U=; b=0rQ6/oJ3BTNYtBkDfwNB+/2ZFm
	Wmqt9A3hL5DX4lHGKGvkdqRhMvb3fu8IVfu70YoRRj61It/AXji2lOA8voJX5pANuYMlUbP2EAit5
	B5fYPVp3RZVimkwYA3/xgAbPXElOtaBe1hpAzNPOBVqFgPDGWGEvE7m7RF/uFSGtweJebEcHAJuI8
	KNZh7xcz5W1WF4p89pDUxWyvOGkFG79C+VrX7qMuJxTV34VPSZYiB28HX9OziIcSRHzlPakFvE//u
	ImrUwpnhYFabW0QjzYGYdmgtKGktlpjOo3qiuTwGwkF3azSXMZrldwBkVJ2lZMwHirDKnsqd7/vNO
	RZHZZAPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlgl-0000000B0NK-3eT2;
	Thu, 10 Jul 2025 07:27:27 +0000
Date: Thu, 10 Jul 2025 00:27:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH 2/2] NFSD: Fix last write offset handling in layoutcommit
Message-ID: <aG9rX2zPlCC1pnSa@infradead.org>
References: <20250704114917.18551-1-sergeybashirov@gmail.com>
 <20250704114917.18551-3-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704114917.18551-3-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jul 04, 2025 at 02:49:05PM +0300, Sergey Bashirov wrote:
> The data type of loca_last_write_offset is newoffset4 and is switched
> on a boolean value, no_newoffset, that indicates if a previous write
> occurred or not. If no_newoffset is FALSE, an offset is not given.
> This means that client does not try to update the file size. Thus,
> server should not try to calculate new file size and check if it fits
> into the seg range.
> 
> Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
>  fs/nfsd/blocklayout.c |  2 +-
>  fs/nfsd/nfs4proc.c    | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 19078a043e85..ee6544bdc045 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -118,7 +118,7 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
>  		struct iomap *iomaps, int nr_iomaps)
>  {
>  	struct timespec64 mtime = inode_get_mtime(inode);
> -	loff_t new_size = lcp->lc_last_wr + 1;
> +	loff_t new_size = (lcp->lc_newoffset) ? lcp->lc_last_wr + 1 : 0;
>  	struct iattr iattr = { .ia_valid = 0 };
>  	int error;

Please guard the entire new_size check below instead, i.e.

	if (lcp->lc_newoffset) {
		loff_t new_size = lcp->lc_last_wr + 1;

		if (new_size > i_size_read(inode)) {
			iattr.ia_valid |= ATTR_SIZE;
			iattr.ia_size = new_size;
		}
	}


> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 37bdb937a0ae..ff38be803d8b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2482,7 +2482,7 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
>  	const struct nfsd4_layout_seg *seg = &lcp->lc_seg;
>  	struct svc_fh *current_fh = &cstate->current_fh;
>  	const struct nfsd4_layout_ops *ops;
> -	loff_t new_size = lcp->lc_last_wr + 1;
> +	loff_t new_size = (lcp->lc_newoffset) ? lcp->lc_last_wr + 1 : 0;

Same here.


