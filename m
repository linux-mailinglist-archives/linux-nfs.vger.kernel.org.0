Return-Path: <linux-nfs+bounces-21531-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMJMDAVcA2qE5QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21531-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:57:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35337525439
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 635FD30B2F5D
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F413D5C32;
	Tue, 12 May 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAWk2Dt7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1423D5C06;
	Tue, 12 May 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604275; cv=none; b=sa0T13lqLlnDpLL9ZD2GPy36dYq3SzCzooAeCUJIF6yp3ZorQC8AY/I9nPoIMNeFlVWFp+W5fpQy4qbAQuUxb7P70G1mF33sXW7WhqoO0bQDwATLs392UBWiTfTaHdOdfkMieXNB1Pcf/Qtj7b6vTu6SLXeCYKOtL6cU5+N1U7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604275; c=relaxed/simple;
	bh=gGFNGe/d0M89UTLDXMOv6nsS+erKCcqBt2dE1dcvtY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxpklO8sO7sxg0Jc/IE+OZeUA2qKTtTagqwDTvkbMVnV4Yajlr7yXwdkQpr6pGtJvH9bjkOo2HJ1QvadltIjqA6CWHvdSkp3usEYgRWZHTKu/qqyk2jHpAKPdr+nP4vvfZXLAJtrADu4+5KVW6qN+FuYyv9QgN6QJOfyoYnrVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAWk2Dt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94604C2BCB0;
	Tue, 12 May 2026 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778604274;
	bh=gGFNGe/d0M89UTLDXMOv6nsS+erKCcqBt2dE1dcvtY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAWk2Dt7RsZrCFS9unG1nWDOKsnka8WTNpKpmGBNL8x/ti9XtrG3TdXrs6WH4e5BU
	 ltC3sh8hegMiIJhKNXwPCyaCjCxXKcN7sln8gAHEl7XoYVCpVbVRN6wW1HP9LBKZsk
	 1YYQzisER40xRJI3oK6vUJJiQ3ONyUGUkWtGpG/aUgSSGPIlwoW4VgU6aZVdtHWQjH
	 ScW0d/Qv5EaSpNSN/yMThsRhOcOKiM7uyAHAnhvQpMYABWHMOAwl+sD0eFkON4mfxa
	 nSiVFll9RpwAK0OC8floHetUAzO/VHuZgWvupp/df9NPOhn9OB5hFCFRHSN8xqiz/w
	 MMDfyMlGmVcVw==
Date: Tue, 12 May 2026 09:44:34 -0700
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
Subject: Re: [PATCH 06/12] swap,block: move the block device swapon code into
 block/fops.c
Message-ID: <20260512164434.GG9555@frogsfrogsfrogs>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512053625.2950900-7-hch@lst.de>
X-Rspamd-Queue-Id: 35337525439
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21531-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 07:35:22AM +0200, Christoph Hellwig wrote:
> Make use of the abstractions we have.  This is a preparation for
> moving more special casing down into block/.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice straightforward hoist.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/fops.c  | 6 ++++++
>  mm/swapfile.c | 5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index bb6642b45937..453141801684 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -949,6 +949,11 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
>  	return generic_file_mmap_prepare(desc);
>  }
>  
> +static int blkdev_swap_activate(struct file *file, struct swap_info_struct *sis)
> +{
> +	return add_swap_extent(sis, sis->max, 0);
> +}
> +
>  const struct file_operations def_blk_fops = {
>  	.open		= blkdev_open,
>  	.release	= blkdev_release,
> @@ -965,6 +970,7 @@ const struct file_operations def_blk_fops = {
>  	.splice_read	= filemap_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= blkdev_fallocate,
> +	.swap_activate	= blkdev_swap_activate,
>  	.uring_cmd	= blkdev_uring_cmd,
>  	.fop_flags	= FOP_BUFFER_RASYNC,
>  };
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1b7fc03612f4..fbf11c8c5c69 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2781,13 +2781,8 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
>  static int setup_swap_extents(struct swap_info_struct *sis,
>  			      struct file *swap_file)
>  {
> -	struct address_space *mapping = swap_file->f_mapping;
> -	struct inode *inode = mapping->host;
>  	int ret, error = 0;
>  
> -	if (S_ISBLK(inode->i_mode))
> -		return add_swap_extent(sis, sis->max, 0);
> -
>  	if (swap_file->f_op->swap_activate)
>  		ret = swap_file->f_op->swap_activate(swap_file, sis);
>  	else
> -- 
> 2.53.0
> 
> 

