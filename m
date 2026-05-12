Return-Path: <linux-nfs+bounces-21533-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJKDFCBdA2qE5QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21533-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:02:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A611525562
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 19:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BBCC30316E6
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052803D7A14;
	Tue, 12 May 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjMYk2vR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130E3D5C05;
	Tue, 12 May 2026 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605325; cv=none; b=Wq9Q4kDZmK5kwZQqxCAaLYa3G4FxKUfTQSHsKm4hROgv12VDfwegJHQb7WykVhnOUyMnMrgrbBb99Fr8PnD6Gbc/Vhc7lFxFk3rqpk17cJBXY12NZOkTzhTT/qO3Zb0O8w0aly0IgyIU779BLts2Av1skhpQuunGeNI07n7Zp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605325; c=relaxed/simple;
	bh=3w1awZ3eeZyi0jyriVIT/nzrxciCz6a3fg6BE8QtIlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5uslSr+tSmuo0d6F51f0tPRdKogqVtXMZCSxCTsHwtfQSsgHC6M+pEYzL1LWEUos7mAmBEaEySZK6tmXHFvLq89RMDAQTqX1J8GUpudprL9qVCJhdtKNfQvQa+2I6EMqs0VjoxOyS3d7fb3HZqE8Q3hRZeE0ACmwl059ef00rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjMYk2vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F11FC2BCC7;
	Tue, 12 May 2026 17:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605325;
	bh=3w1awZ3eeZyi0jyriVIT/nzrxciCz6a3fg6BE8QtIlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjMYk2vRoty2a4xDF+mPNkwg088Su/Dx1Sz86vsQ2QZG6kbz61WB0pPzkcCZAxjYq
	 kJY3nMshWUg7KGRx6BsutKaT+vu8mwemfJijbJapF//T7rUIbic7QUSCSMCINj9Vnm
	 utITe5nMhhEVSeINgpaCBTozVPfIZ/os3th5Ms0aJgOfThlG42fWDsASqq13Ot1T5b
	 Wg1VYUEw8U21QanLlWxGkEH80h/yjschij/vN+NnHNHX+S7Sb+2OzYIZUb7Q97/fHl
	 QCDzO30QikF4V6NHzRaXJaxzSG3Ei3fZ/Pa/6QN0mk9zIzYYmmkf0fXA4YRksP43ne
	 w2Gji8z2LDbZA==
Date: Tue, 12 May 2026 10:02:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 08/12] swap,iomap: simplify iomap_swapfile_iter
Message-ID: <20260512170204.GI9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-9-hch@lst.de>
X-Rspamd-Queue-Id: 0A611525562
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21533-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:35:24AM +0200, Christoph Hellwig wrote:
> add_swap_extent already coalesces multiple extents, no need to duplicate
> that in the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

/me wishes he'd either noticed that add_swap_extent already had the
coalescing code or had documented why he implemented his own.

OH.  Now I remember why -- it's to handle contiguous mixed mappings
better.

Let's say that you have a 1k fsblock filesystem and 4k base pages.  You
fallocate an 8G swap file and then mkswap it.  The first mapping is a 1k
written mapping at offset 0 for the swap header, followed by an 8388607k
unwritten mapping at offset 3k.

The PAGE_SIZE rounding code in iomap_swapfile_add_extent will round the
end of that first mapping down to zero and ignore it.  The second
mapping will be treated as if it were a 8388604k mapping starting at
offset 4096.  Now the page counts are wrong and the swapon fails.

A more generic solution to this would be to change add_swap_extent to
take sector_t addr and length values and use them to construct a bitmap
representing contiguous physical space on the bdev, accounting of course
for PAGE_SIZE alignment.  Except for the swap header page, every other
contiguously set page-aligned region in the bitmap gets added to the
swap extent map.

You could then maximize the number of pages participating in swap even
for files with layouts that are truly egregiously bad.  But I elected
not to go there because the common case is fallocate getting contiguous
space.

But still, I'm not sure we want to drop the iomap accumulator in
fs/iomap/swapfile.c.

--D

> ---
>  fs/iomap/swapfile.c | 104 +++++++++++++-------------------------------
>  1 file changed, 31 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index cf354fdfb7c3..a4e0ca462cc4 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -6,57 +6,32 @@
>  #include <linux/iomap.h>
>  #include <linux/swap.h>
>  
> -/* Swapfile activation */
> -
> -struct iomap_swapfile_info {
> -	struct iomap iomap;		/* accumulated iomap */
> -	struct swap_info_struct *sis;
> -	unsigned long nr_pages;		/* number of pages collected */
> -	struct file *file;
> -};
> -
> -/*
> - * Collect physical extents for this swap file.  Physical extents reported to
> - * the swap code must be trimmed to align to a page boundary.  The logical
> - * offset within the file is irrelevant since the swapfile code maps logical
> - * page numbers of the swap device to the physical page-aligned extents.
> - */
> -static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
> -{
> -	struct iomap *iomap = &isi->iomap;
> -	uint64_t first_ppage;
> -	uint64_t next_ppage;
> -
> -	/*
> -	 * Round the start up and the end down so that the physical
> -	 * extent aligns to a page boundary.
> -	 */
> -	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
> -	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
> -			PAGE_SHIFT;
> -	return add_swap_extent(isi->sis, next_ppage - first_ppage, first_ppage);
> -}
> -
> -static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
> +static int iomap_swapfile_fail(struct file *file, const char *str)
>  {
>  	char *buf, *p = ERR_PTR(-ENOMEM);
>  
>  	buf = kmalloc(PATH_MAX, GFP_KERNEL);
>  	if (buf)
> -		p = file_path(isi->file, buf, PATH_MAX);
> +		p = file_path(file, buf, PATH_MAX);
>  	pr_err("swapon: file %s %s\n", IS_ERR(p) ? "<unknown>" : p, str);
>  	kfree(buf);
>  	return -EINVAL;
>  }
>  
>  /*
> - * Accumulate iomaps for this swap file.  We have to accumulate iomaps because
> - * swap only cares about contiguous page-aligned physical extents and makes no
> - * distinction between written and unwritten extents.
> + * Report physical extents for this swap file.  Physical extents reported to the
> + * swap code must be trimmed to align to a page boundary.  The logical offset
> + * within the file is irrelevant since the swapfile code maps logical page
> + * numbers of the swap device to the physical page-aligned extents.
>   */
> -static int iomap_swapfile_iter(struct iomap_iter *iter,
> -		struct iomap *iomap, struct iomap_swapfile_info *isi)
> +static int iomap_swapfile_iter(struct iomap_iter *iter, struct file *file,
> +		struct swap_info_struct *sis)
>  {
> +	struct iomap *iomap = &iter->iomap;
> +	uint64_t first_ppage;
> +	uint64_t next_ppage;
> +	int error;
> +
>  	switch (iomap->type) {
>  	case IOMAP_MAPPED:
>  	case IOMAP_UNWRITTEN:
> @@ -64,35 +39,31 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
>  		break;
>  	case IOMAP_INLINE:
>  		/* No inline data. */
> -		return iomap_swapfile_fail(isi, "is inline");
> +		return iomap_swapfile_fail(file, "is inline");
>  	default:
> -		return iomap_swapfile_fail(isi, "has unallocated extents");
> +		return iomap_swapfile_fail(file, "has unallocated extents");
>  	}
>  
>  	/* No uncommitted metadata or shared blocks. */
>  	if (iomap->flags & IOMAP_F_DIRTY)
> -		return iomap_swapfile_fail(isi, "is not committed");
> +		return iomap_swapfile_fail(file, "is not committed");
>  	if (iomap->flags & IOMAP_F_SHARED)
> -		return iomap_swapfile_fail(isi, "has shared extents");
> +		return iomap_swapfile_fail(file, "has shared extents");
>  
>  	/* Only one bdev per swap file. */
> -	if (iomap->bdev != isi->sis->bdev)
> -		return iomap_swapfile_fail(isi, "outside the main device");
> -
> -	if (isi->iomap.length == 0) {
> -		/* No accumulated extent, so just store it. */
> -		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
> -	} else if (isi->iomap.addr + isi->iomap.length == iomap->addr) {
> -		/* Append this to the accumulated extent. */
> -		isi->iomap.length += iomap->length;
> -	} else {
> -		/* Otherwise, add the retained iomap and store this one. */
> -		int error = iomap_swapfile_add_extent(isi);
> -		if (error)
> -			return error;
> -		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
> -	}
> +	if (iomap->bdev != sis->bdev)
> +		return iomap_swapfile_fail(file, "outside the main device");
>  
> +	/*
> +	 * Round the start up and the end down so that the physical extent
> +	 * aligns to a page boundary.
> +	 */
> +	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
> +	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
> +			PAGE_SHIFT;
> +	error = add_swap_extent(sis, next_ppage - first_ppage, first_ppage);
> +	if (error)
> +		return error;
>  	return iomap_iter_advance_full(iter);
>  }
>  
> @@ -110,10 +81,6 @@ int iomap_swap_activate(struct file *file, struct swap_info_struct *sis,
>  		.len	= ALIGN_DOWN(i_size_read(inode), PAGE_SIZE),
>  		.flags	= IOMAP_REPORT,
>  	};
> -	struct iomap_swapfile_info isi = {
> -		.sis = sis,
> -		.file = file,
> -	};
>  	int ret;
>  
>  	/*
> @@ -125,16 +92,7 @@ int iomap_swap_activate(struct file *file, struct swap_info_struct *sis,
>  		return ret;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.status = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (isi.iomap.length) {
> -		ret = iomap_swapfile_add_extent(&isi);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> +		iter.status = iomap_swapfile_iter(&iter, file, sis);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_swap_activate);
> -- 
> 2.53.0
> 
> 

