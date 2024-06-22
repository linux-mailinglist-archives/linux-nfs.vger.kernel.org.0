Return-Path: <linux-nfs+bounces-4227-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF091320A
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 07:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A32842E7
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jun 2024 05:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC25D148FFB;
	Sat, 22 Jun 2024 05:03:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD71494BC
	for <linux-nfs@vger.kernel.org>; Sat, 22 Jun 2024 05:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719032618; cv=none; b=VVtASPPJWHMsbCuahV7Arzo4yedqPsk41N3knOKmpw1ajY9xlj9ni/XI/8O45ZBa0/o7mM4eIfGaqIlJC2YdDkY1U5o/Qu9I8IjKgGj0GHqUO2Dcx3fwuhP6+Lgb3l/S3mAze4luS1ro9DApUmRfUzc9NmaimA5NcinqWdLNSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719032618; c=relaxed/simple;
	bh=hPorZphDROpuoa4XsxvAxmkjKuQ7hxMUthxxRSowAX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFpiSvO5f9YC4G8kwZVwH/0eqJBEidw2+QOs9U6ga5q3dAHmKiSwHTlaZLwJiWbzwWYebrB4iddT3ax2ZwmgjL6e3mfETvMnOGNNpEe4yePEDhtOsO5N3KSDuW9Hf7+B5WjV4uZrePEVyIVJCDig4Q+TBTr8kwqoUTE2+oytFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56F8C68C7B; Sat, 22 Jun 2024 07:03:25 +0200 (CEST)
Date: Sat, 22 Jun 2024 07:03:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <20240622050324.GA11110@lst.de>
References: <20240621162227.215412-6-cel@kernel.org> <20240621162227.215412-7-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621162227.215412-7-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 21, 2024 at 12:22:29PM -0400, cel@kernel.org wrote:
> @@ -367,14 +391,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
>  		goto out_blkdev_put;
>  	}
>  
> -	error = ops->pr_register(file_bdev(d->bdev_file), 0, d->pr_key, true);
> -	if (error) {
> -		pr_err("pNFS: failed to register key for block device %s.",
> -				file_bdev(d->bdev_file)->bd_disk->disk_name);
> -		goto out_blkdev_put;
> -	}
> -
> -	d->pr_registered = true;
> +	d->pr_register = bl_pr_register_scsi;

I think this will break complex (slice, concat, stripe) volumes,
as we'll never call ->pr_register for them at all.  We'll also need
a register callback for them, which then calls into underlying
volume, similar to how bl_parse_deviceid works.  That would also
do away with the need for the d->pr_register callback, we could
just do the swithc on the volume types which might be more
efficient.  (the same is actually true for the ->map callback,
but that's a separate cleanup).


