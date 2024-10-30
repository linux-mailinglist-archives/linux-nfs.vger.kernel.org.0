Return-Path: <linux-nfs+bounces-7571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68209B64D2
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F54A1F231C3
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AD61EABC2;
	Wed, 30 Oct 2024 13:52:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF561E8844
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296341; cv=none; b=bQTWO7OOkaF5528eIOvfjxWi905X8DA6eNw9OPOs7H7NyFV1U3hHHEeQV09VvRIU+2BW+uUPA7oTfpMlqgLw7JBJNBoaG2EPJ7iWUoEJLustlZLgORWVx9sTHbQa/6dFH1T3N9M7q3JMNIcK3ANn8N5NqjGdFjWRSfkem7y+UAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296341; c=relaxed/simple;
	bh=2mLUU982IqWK2KYwZS4Lz725WmnjU47VYzfifclBaDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoYO3hQDV0q+fCG+8PbW3HEaUEjy3hr5UMGunzUxNKyz+eXFNog89wJnZKVx0e8L3JxS2d670YejP11qbIBVqamfuCfamtP045Ad5nfP9asIP+TIKiW2mdRdXQzLVFgip/IIlHvqkpyY1OtTI944MUhB4LNt1dsIoYCSDO+zFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 82A48227AAE; Wed, 30 Oct 2024 14:52:14 +0100 (CET)
Date: Wed, 30 Oct 2024 14:52:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] dm: add support for get_unique_id
Message-ID: <20241030135214.GA28166@lst.de>
References: <f3657efae72f9abb93d3169308052e77bf0dbad6.1730292757.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3657efae72f9abb93d3169308052e77bf0dbad6.1730292757.git.bcodding@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 08:57:56AM -0400, Benjamin Coddington wrote:
> This adds support to obtain a device's unique id through dm, similar to the
> existing ioctl and persistent resevation handling.  We limit this to
> single-target devices.
> 
> This enables knfsd to export pNFS SCSI luns that have been exported from
> multipath devices.

Is there anything that ensures that the underlying IDs actually
match?

> +	struct dm_unique_id *dmuuid = data;
> +	const struct block_device_operations *fops = dev->bdev->bd_disk->fops;
> +
> +	if (fops->get_unique_id)
> +		return fops->get_unique_id(dev->bdev->bd_disk, dmuuid->id, dmuuid->type);
> +
> +	return 0;

Overly long line here.  Also maybe just personal, but I find code easier
to read when the exit early condition is in the branch, e.g.

	strut gendisk *disk = dev->bdev->bd_disk

	if (!disk->fops->get_unique_id)
		return 0;
	return disk->fops->get_unique_id(disk, dmuuid->id, dmuuid->type);


