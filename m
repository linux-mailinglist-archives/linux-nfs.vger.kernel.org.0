Return-Path: <linux-nfs+bounces-4119-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA82E90FC0B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 06:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C882F1C22326
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 04:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4BC18EBF;
	Thu, 20 Jun 2024 04:50:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2C11CA1
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859051; cv=none; b=SCOf+e7BQboB+oN5xgbPoKEeLr+QI9O6Tjrgc/xnJNTAPNx7s7LNnJ6M0sv6ov7bfGQVGNYDBQ+MOp6drwXS+FyScpkiETJALvebVUfenwYr10CE/zkHAqSsPq6Ci4wlNPGIpe4WALRxEWwue2V53QKEJuYj7KJBsjw/XQ6KuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859051; c=relaxed/simple;
	bh=nGcflQOOnxsW7SEaCfJ0FYnYbkI7l6owqkxa+D26O2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwTKZG6HWRebhlRI6SHyhjRbbmanSMssB8EdIvKR2R7+plhz/2V8XeZcdy05bEEcI3aCdSzN+ekhpgirWFeD1aopqyQb7WsUlVGEPAhGMyOixF2PEC3jgX0s2z6TgK7xyaehjGc2kxft37CJBCgZz7WJRwJH09EFqpWCC68nTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4084968BEB; Thu, 20 Jun 2024 06:50:46 +0200 (CEST)
Date: Thu, 20 Jun 2024 06:50:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 1/4] nfs/blocklayout: SCSI layout trace points for
 reservation key reg/unreg
Message-ID: <20240620045046.GC19613@lst.de>
References: <20240619173929.177818-6-cel@kernel.org> <20240619173929.177818-7-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619173929.177818-7-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
>  
> @@ -24,14 +25,17 @@ bl_free_device(struct pnfs_block_dev *dev)
>  		kfree(dev->children);
>  	} else {
>  		if (dev->pr_registered) {
> -			const struct pr_ops *ops =
> -				file_bdev(dev->bdev_file)->bd_disk->fops->pr_ops;

If you touch this it might be worth returnin early before the else
above to reduce the indentation here a bit.

>  			if (error)
> -				pr_err("failed to unregister PR key.\n");
> +				trace_bl_pr_key_unreg_err(bdev->bd_disk->disk_name,
> +							  dev->pr_key, error);
> +			else
> +				trace_bl_pr_key_unreg(bdev->bd_disk->disk_name,
> +						      dev->pr_key);

I'd just pass the bdev to the tracepoint and derefence it there only
when tracing is enabled.  Note that the disk_name isn't really what
we'd want to trace anyway, as it misses the partition information.
The normal way to print the device name is the %pg printk specifier,
but I'm not sure how to correctly use that for tracing which wants
a string in the entry for binary tracing.

> +++ b/fs/nfs/nfs4trace.c
> @@ -29,5 +29,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_commit_error);
>  
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg_err);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg_err);

This is weird.  The trace points for nfsd really should be in
fs/nfsd/trace.h and not in fs/nfs/ as that would then pull in
the client code into the server.


