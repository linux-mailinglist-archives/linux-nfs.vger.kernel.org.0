Return-Path: <linux-nfs+bounces-15643-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4C1C0C378
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A9A3BCFB7
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC5D2E0407;
	Mon, 27 Oct 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GLkJD1ZA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA09199FAB
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552161; cv=none; b=TbvHBQQMkfAArvSParFNbW9NnWmvWXNCLTMOx0b56AYQ9RyB73fGfKUNy3B4b+7tRwVLRviJJXF10V6O1RZWacDu1x8O+haMXOmmIGrTCRJjqO+HBeFDv+AQqbQ3XX/ouLUEpi7H1uXNCDZHGhL4oLcNdXbVfMuHOBAcmPt6AUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552161; c=relaxed/simple;
	bh=VIYwCaRacC5qDIzF1RQFwzBKDr/Jc8WRWUUtvhIWLe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbMXSYl6dF5BoGkN1LCaFHpUCttaWJgAGV3lfwxdgoJSSPnm7pmPPISiUw2GCcTf3xUlVGpeu/sgMPhL1ZI7cGxP3JyzRP1Pef8JGtvqzkRQfJt0W9OrMQ2TkcAJBRkrfsHlvdFKb47frFgGJt4AXpwFb9p8tGQcVGaiqaw0BL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GLkJD1ZA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rJFUbKE7HxBmdrFSO0n46fSmEiBh/XkZsGe0nRync7g=; b=GLkJD1ZAvNH86tObIkQQlI0Ut7
	pgAWFgaW4p5RERPJCa5lgIqZS5ruxl/cZ3YNVhghxxA2F4fZoMak+3weeIOvHnbI8d4JQwnlisQta
	ZqOjRu8FfT32GYMulk2OUrHqa/LikxEHDTXXnUO+sVodDwJW35unaVjGQ/UdRnLlYqCeILMJRthe/
	/GucC0yeuPBdeUloGzspFgyBYBEI2pEV4NEzm4MS5hue0mZZjJf9LV/oC13ZjzeilpqddhbF7Ciss
	WSiBOhoWoRfhWeiAxNWD1uZmQuSHWBVlYUqvShu1ZqUR7mMGh8ZRG6yESZ4iiL9iVv12upUxmSqou
	aulF4urA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIBZ-0000000DJvw-2GbP;
	Mon, 27 Oct 2025 08:02:37 +0000
Date: Mon, 27 Oct 2025 01:02:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v7 01/14] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aP8nHSq-4PPoxxZ1@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024144306.35652-2-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 10:42:53AM -0400, Chuck Lever wrote:
> For many years, NFSD has used a "data sync only" optimization for
> FILE_SYNC WRITEs, in violation of the above text (and previous
> incarnations of the NFS standard). File time stamps haven't been
> persisted as the mandate above requires.

Haven't been forced to be persisted.  Because for most (all?) Linux
file systems timetstamps (and other metadata not needed to find the
data) are piggy backed on fdatasync-mandatory metadata updates, this
would only affect the case where previously fully allocated file data
is overwritten.  I think that's important to note here.

> The purpose of this behavior is that, back in the day, file systems
> on rotational media were too slow to handle writes with time stamp
> updates.

I really don't think that is true.  Doing an extra roundtrip is just
as (relatively) expensive on SSDs.  I also don't see any argument for
that in the commit history.  As far as I can tell this simple was
an oversight.

> The impact of this change will be felt only when a client explicitly
> requests a FILE_SYNC WRITE on a shared file system backed by slow
> storage. UNSTABLE and DATA_SYNC WRITEs should not be affected.

Again, nothing about slow storage.  Optimizing non-overwriting writes
using the FUA bit in Linux was specifically done for SSD storage.

> @@ -1314,8 +1314,14 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		stable = NFS_UNSTABLE;
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos = offset;
> -	if (stable && !fhp->fh_use_wgather)
> -		kiocb.ki_flags |= IOCB_DSYNC;
> +	if (stable && !fhp->fh_use_wgather) {
> +		if (stable == NFS_FILE_SYNC)
> +			/* persist data and timestamps */
> +			kiocb.ki_flags |= IOCB_DSYNC | IOCB_SYNC;
> +		else
> +			/* persist data only */
> +			kiocb.ki_flags |= IOCB_DSYNC;
> +	}

Maybe use a switch statement here to enumerate the valid cases?


