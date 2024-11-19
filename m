Return-Path: <linux-nfs+bounces-8111-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B39D260E
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 13:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21C2283B66
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63D1CBA1A;
	Tue, 19 Nov 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WJ9P3mSV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668891C9EC2;
	Tue, 19 Nov 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020138; cv=none; b=GgmYIMv3oibCgGQgJ0/rUSp1/6bJjFxf+6jXTd3jPtrDizWMGtfxiY7DbQoKu2jkMytDxpz8JXlC8NFBFzU8Nwyo8PJf/uQkEYOTDxUuD5UCCfgbqgZCo9x+pNCJidBXC1o1EWc1SSyhGVHBv8qe9+oUrgaVGekkcPcurxgeAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020138; c=relaxed/simple;
	bh=wWKTqUQ5iv4RgeTY719W4FLY1/DymU8v/OW7Ir19xGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNDHsuKHvsnoVx1VrYMdAifyUrJedt+XT0UIte9f++1VsvRJ22BE5vER8FuszJnoY4kM09SYgFEfG6weh2KWQgvK7TePUcLP/Z93QXGc2oifSSNYf7zXhk+NF3NtN23GgH+D+cxojQcQLXiz4KhNv4VzpIiTufbOnJLgBNOIquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WJ9P3mSV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=puRMvSLyawqJq23PQKWWRN4nNtfGHtUVP3j5guk5Wl0=; b=WJ9P3mSVDIDod+9iP7msOwyB43
	BJ7nUNy1PJoa6f+pOuHABiyLJ1+0xqjFGxI7CAN9LhHDH6yd0Kor8VO6ZY2ad2x7Y8eSzlxFjdmm3
	DLjFUKV4q4R06DHQqk4QAN7KnOyecxgiG98AGdEtm9XceS7GrfHQTqa8JUXYnaA9UDDXKeJ5/xtjD
	f77FGUmAp9cVY4Xg3pkDN10Iz9YSIalisQ81yAaV/ptz8PbI8VpqTlXQwm7DDxY9vgvMg2HdxqtKW
	2kqjiYA85dD5IUDrZ8rbMCuVSZBM8bMn81mVOcvM3fEyZeF1VD8g1xU8Nrp44QR0TVwXT/pkDhRFG
	hol6rWqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNYe-0000000COfP-3foN;
	Tue, 19 Nov 2024 12:42:16 +0000
Date: Tue, 19 Nov 2024 04:42:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfs/blocklayout: Don't attempt unregister for
 invalid block device
Message-ID: <ZzyHqEDt8UXoAUyh@infradead.org>
References: <cover.1731969260.git.bcodding@redhat.com>
 <eeb62d9260f2e9b61ff5e186eec0048e51bc8758.1731969260.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb62d9260f2e9b61ff5e186eec0048e51bc8758.1731969260.git.bcodding@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 18, 2024 at 05:40:40PM -0500, Benjamin Coddington wrote:
> Since commit d869da91cccb, an unmount of a pNFS SCSI layout-enabled NFS

Please also spell out the commit subject in the commit log body, similar
to to the Fixes tag.

> index 6252f4447945..7ae79814f4ff 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -16,13 +16,16 @@
>  
>  static void bl_unregister_scsi(struct pnfs_block_dev *dev)
>  {
> -	struct block_device *bdev = file_bdev(dev->bdev_file);
> -	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
> +	struct block_device *bdev;
> +	const struct pr_ops *ops;
>  	int status;
>  
>  	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
>  		return;
>  
> +	bdev = file_bdev(dev->bdev_file);
> +	ops = bdev->bd_disk->fops->pr_ops;
> +

Hmm.  Just moving the test_and_clear_bit to the caller would
feel cleaner than this to me.

But either way the change looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


