Return-Path: <linux-nfs+bounces-4122-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA1A90FC1A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B554D283BB9
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C022625;
	Thu, 20 Jun 2024 05:06:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8D237E
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718859980; cv=none; b=n+a8OSiH9C4CuRbjAKS1Dn4QW0ZIXyg6Sc89nU15GuAvD+DTJz7euUJYq5IsMSyI+z0KpVFIWxKvsTY+jqRp4fHf2hrnsA6bSWF6uSDRHqqY8caIYofBATrcbAh2+T2AuDSA5bIaGOhOmSWQ7qOyss07wwOMEmz6W6CUDfxtvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718859980; c=relaxed/simple;
	bh=nylLOEHTewsSM9zTE4inDYD+c2ZaA5B4AHzyc/gDubY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfSNy3VH/rzie2RL9fpega1/ppfII8+ZXPDSXH2ZLgnoK/n/0BbytT+J8a6FizudwJt6olm12UbuvyVuLBYn8nCULuc8hw0N9bnlxA44+7DM4rrpY91XG4AoV3lmou6jg9KG7z6svbMi7vSkx9oYApQadsLpYnLbLNFTDXgDp6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E0F168BEB; Thu, 20 Jun 2024 07:06:15 +0200 (CEST)
Date: Thu, 20 Jun 2024 07:06:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: cel@kernel.org
Cc: linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <20240620050614.GE19613@lst.de>
References: <20240619173929.177818-6-cel@kernel.org> <20240619173929.177818-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619173929.177818-9-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 19, 2024 at 01:39:33PM -0400, cel@kernel.org wrote:
> -	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
> +	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {

It might be worth to invert this and keep the unavailable handling in
the branch as that's the exceptional case.   That code is also woefully
under-documented and could have really used a comment.

> +		struct pnfs_block_dev *d =
> +			container_of(node, struct pnfs_block_dev, node);
> +		if (d->pr_reg)
> +			if (d->pr_reg(d) < 0)
> +				goto out_put;

Empty line after variable declarations.  Also is there anything that
synchronizes the lookups here so that we don't do multiple registrations
in parallel?

> +
> +	if (d->pr_registered)
> +		return 0;
> +
> +	error = ops->pr_register(bdev, 0, d->pr_key, true);
> +	if (error) {
> +		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
> +		return -error;

->pr_register returns either negative errnos or positive PR_STS_* values,
simply inverting the error here isn't doing the right thing.


