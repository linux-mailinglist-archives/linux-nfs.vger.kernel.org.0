Return-Path: <linux-nfs+bounces-14759-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B57BA83B1
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 09:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC961892442
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83024E4A8;
	Mon, 29 Sep 2025 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kp0vEIkm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07517597;
	Mon, 29 Sep 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130632; cv=none; b=anaCDCb3nitqnL8jklFdMGZX4doPszOj6UDbM4CNOCNgLBYofa6IFC0PgzgMjzXVSdeCjcgnHCBirknBaB38q8dq/O/XoKRMLbvTeWw7sVh1gK15Ex/UYZdU/zviwNbXvgPFnVR5w6tBXcL8BcR4+/ENOXhW7WX8y+teMa3Z9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130632; c=relaxed/simple;
	bh=ymWfIn4S+lZR7XhOeyRFtypUYJirm5sIA95DPsfVPg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViVq5r3ifB97IldRd1TiRmXrydaBRZIQ6WXYeTAwVRCKcud3jciOCLY0WRR0D/sLcLHj/f/bJ8zS3FSfC9dh2RmPN0JThhYWpNBWM0z0NgTBlGNtu+OsYj118ix2rQOgOqxw+dYdK23JT3+SfPmCxlM3bZ1l0jVnoNekqyS6wTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kp0vEIkm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gua9l8lhP4z44BPeL6lnyhEAjLAeYtr5YMP04G+DAsQ=; b=Kp0vEIkmlIsPgs8tVCUxPPrNvz
	30IkXZ7vn+vVYYSJXGGVH/G99thujyGikxWsuPHZtFP2jUECDa7Y7i2bF9SkzHR34Mo7ASCBlq0k0
	au8cRJZrK3sYsb/uNS9VrpCjwmgB4ZhWOYfmWDhv05cNUPHFZwXtxlDNP7z24gnYQ7H5LRJgKXzNU
	s/tqEjEimoz68cwiMDvPfiMr+vSu26Sxw7bodbJd6cOMZ6ZTdiSAZiV4301ZLXvKSm66nha8yqzDq
	1xhgLCtwKd7bCe6il34ZpzpWlyuqsPGJOhXuMBSjrMdulc6FUltIyz4jiTB2qwEqlBtVXyDEpdKi4
	waFZVaZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v38Ee-00000001bU9-0KO5;
	Mon, 29 Sep 2025 07:23:48 +0000
Date: Mon, 29 Sep 2025 00:23:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSD: Impl multiple extents in block/scsi layoutget
Message-ID: <aNo0BCzVQxR60qeT@infradead.org>
References: <20250911160208.69086-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911160208.69086-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The subject line is odd.  What is impl supposed to mean?

I'd say something like:

nfsd/blocklayout: support multiple extent per LAYOUTGET

On Thu, Sep 11, 2025 at 07:02:03PM +0300, Sergey Bashirov wrote:
> This patch allows the pNFS server to respond with multiple extents

This patch is redundant and should generally be avoided in commit log.

> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---
> Checked with smatch, tested on pNFS block volume setup.

Any chance we could get testing for this added to pynfs?

Also what is this patch against?  If fails to apply to linux-next for
me.

> +/**
> + * nfsd4_block_map_extent - get extent that covers the start of segment
> + * @inode: inode of the file requested by the client
> + * @fhp: handle of the file requested by the client
> + * @seg: layout subrange requested by the client
> + * @minlength: layout min length requested by the client
> + * @bex: output block extent structure
> + *
> + * Get an extent from the file system that starts at @seg->offset or below,
> + * but may be shorter than @seg->length.
> + *
> + * Return values:
> + *   %nfs_ok: Success, @bex is initialized and valid
> + *   %nfserr_layoutunavailable: Failed to get extent for requested @seg
> + *   OS errors converted to NFS errors
> + */

I'm not sure how Chuck handles this, but kerneldoc comments for static
functions and thus not as public documentation can be really annoying
due to the verbose formatting of the paramters.  I'd generally avoid
them and instead of have short comments explaining the interesting bits
about the calling convention and/or functionality.

> +nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
> +		const struct nfsd4_layout_seg *seg, u64 minlength,
> +		struct pnfs_block_extent *bex)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	struct iomap iomap;
>  	u32 device_generation = 0;
>  	int error;
>  
> -	if (locks_in_grace(SVC_NET(rqstp)))
> -		return nfserr_grace;
> -
> -	if (seg->offset & (block_size - 1)) {
> -		dprintk("pnfsd: I/O misaligned\n");
> -		goto out_layoutunavailable;
> -	}
> -

There is a lot of code movement here mixed with functional changes,
which makes it very hard to follow.  Any chance you could first
split the functions, then introduce the new pnfs_block_layout structure
and only then actually add multiple extents per layoutget?  That'll
make it a lot easier there are no unintended changes.

> + *   %nfserr_layoutunavailable: Failed to get extents for requested @seg
> + *   OS errors converted to NFS errors
> + */
> +static __be32
> +nfsd4_block_map_segment(struct inode *inode, const struct svc_fh *fhp,
> +		const struct nfsd4_layout_seg *seg, u64 minlength,
> +		struct pnfs_block_layout *bl)

I struggle to see what the point of the nfsd4_block_map_segment helpers
is, as it seems to add no real value while making the code harder to
follow.

> +{
> +	struct nfsd4_layout_seg subseg = *seg;
> +	u32 i;
> +	__be32 nfserr;

Nit: nfserr can be local in the loop.

The subextent handling confuses me a bit - there is no such thing
as a subsegment in NFS.  I'd pass a never changing end of layout,
a moving offset, and a constant iomode directly, which should simply
the code quite a bit, i.e. something like:

	u64 map_start = seg->offset;
	u64 seg_end = seg->offset + seg->len;

	for (..) {

		nfserr = nfsd4_block_map_extent(inode, fhp, ...
				map_start, &end);
		if (end > seg_end) {
			bl->nr_extents = i + 1;
			break;
		}

		map_start = end;
	}


> +nfsd4_block_proc_layoutget(struct svc_rqst *rqstp, struct inode *inode,
> +		const struct svc_fh *fhp, struct nfsd4_layoutget *args)
> +{
> +	struct nfsd4_layout_seg *seg = &args->lg_seg;
> +	u64 seg_length;
> +	struct pnfs_block_extent *first_bex, *last_bex;
> +	struct pnfs_block_layout *bl;
> +	u32 nr_extents_max = PAGE_SIZE / sizeof(bl->extents[0]) - 1;

Where is that -1 coming from?  Or the magic PAGE_SIZE?


