Return-Path: <linux-nfs+bounces-21909-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM7zKYroE2p8HQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21909-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 08:13:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 664155C63B7
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 08:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 430D0300F972
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E3372B5A;
	Mon, 25 May 2026 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ch8C4AQu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325ADDA9;
	Mon, 25 May 2026 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689603; cv=none; b=PWKcT2/U5R7B74SXluvjO0ipblnh3+W8dACtlHI7pC/uIU94tor9MgAit51FY6wW+5SE5mYg5XVOy1Rlz2owa7tLyKqEFfZFs92kHQw4sjZLiG69zDklbho8FbwohmMZQkobuFXYqsq1MWWLe/pWV1XeVKQ3gU0yg7q3H+71t5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689603; c=relaxed/simple;
	bh=eeD04UdoyibCLUbSESv4nDuwLvjdA69yocynqRXPeSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is2PNyz4XmIVLBUpW43iGhnDlWk9ygsFCI6C+ucV9nptBXkmcydX5jA7tPt65Zt9X+IqGHiqX8ieqgoyWd/4mjkyPRGwPAcklvi0PLBY3TCAVKgkNItHTfnihdPqUicNC8OdmnRh5fydxFetpR4lFC7GVsfDZxNv3l0ZKvuHPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ch8C4AQu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k3SPzxVyWdadKptBoGs22ABp+4fSutAbLhXgTnFnk+c=; b=ch8C4AQus3YZ806Wh67oNprJWu
	4YgLFI2/PnBCMuybdDy7PbfGtTtnOYTERUedeW5E5Ru5s2A42Wbka5YWGITgpXyoniyxVkeoX4jLc
	IUiRdYgZdzB/Am4gsRBuGO/BRVBQ7wRZfgKXj1zZbTQQSFMZAafdMq1Nx00l5Uir2sYkM1+syo7Sb
	tR2MZOHYxgUNgn6enT0n7mgnTQttQ6CNWFQCnUaBYMiOmFQAvhU06ASH+830Qwzg/OZoJ2MMde8pk
	5myaDznWnGdkaDDiOgZB+6sZOcmbLJfO3PHqjAYQdxaW+wE6I2paALx9V82PLnhPBfyxJiW3AXzQ8
	ADrqVaWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROYn-0000000GOIp-2PQ1;
	Mon, 25 May 2026 06:13:09 +0000
Date: Sun, 24 May 2026 23:13:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 05/21] Add a function to kmap one page of a multipage
 bio_vec
Message-ID: <ahPodavlA-gt44FO@infradead.org>
References: <20260518222959.488126-1-dhowells@redhat.com>
 <20260518222959.488126-6-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518222959.488126-6-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21909-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[brauner.io,infradead.org,manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:mid,infradead.org:dkim,manguebit.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 664155C63B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 11:29:37PM +0100, David Howells wrote:
> Add a function to kmap one page of a multipage bio_vec by offset (which is
> added to the offset in the bio_vec internally).  The caller is responsible
> for calculating how much of the page is then available.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  include/linux/bvec.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index d36dd476feda..9df4a56fef61 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -299,4 +299,21 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
>  	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
>  }
>  
> +/**
> + * kmap_local_bvec - Map part of a bvec into the kernel virtual address space
> + * @bvec: bvec to map
> + * @offset: Offset into bvec
> + *
> + * Map the page containing the byte at @offset into the kernel virtual address
> + * space.  The caller is responsible for making sure this doesn't overrun.
> + *
> + * Call kunmap_local on the returned address to unmap.
> + */
> +static inline void *kmap_local_bvec(struct bio_vec *bvec, size_t offset)

The name is rather confusing for something that does not map the entire
bvec, and is an anagram of the existing bvec_kmap_local.  So please
rename it to bvec_kmap_partial or something.

> +{
> +	offset += bvec->bv_offset;
> +
> +	return kmap_local_page(bvec->bv_page + offset / PAGE_SIZE) + offset % PAGE_SIZE;

Overly long line.  Also this can use shits and byte masking to be a tad
more efficient and matching the rest of the bvec code.

Users of this would be interesting and why you're not simply using a
bvec_iter at page granularity, which is what other block kmap code
does.


