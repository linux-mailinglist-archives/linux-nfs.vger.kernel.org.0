Return-Path: <linux-nfs+bounces-19685-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMrzIDwCp2k7bgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19685-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 16:46:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80A1F2E24
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FE6F3065EE9
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2026 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD323914F4;
	Tue,  3 Mar 2026 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MQe3mxBb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B45390991
	for <linux-nfs@vger.kernel.org>; Tue,  3 Mar 2026 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552031; cv=none; b=Dfk879tjfeTGpSc46E3DOvlcigO15S48PYWgWtMfYSJG8dHA3lYZyOYI2jtykjxplFbCn0u3V2ExAgTmZUKk0Fwpd2b0fwtYySlsWIvu3VODYEPuMuouq17EQd31oHugPuPXiOm0AAyHJAqJsqt64dfI3UDgpeWjF5XjXnn9h6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552031; c=relaxed/simple;
	bh=tGShfk+0xqwhnt8T0AsxFFxIHFP9ygTMq+pv3k9z57w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWVH+pEE333d4BV+TSdRL4laDiYb7kfDCsrJpCv6qSfw4Nl9j5t+IHw1YfPyHSnUEWwWuzcAfngLnh9bAkQZjERa60bQDqNKDvqVC11ORVr6lsx8xEvWTsZK0ZaWMOOSRMqu/lmSCLTApVfe0GLkMjSX0BlBLDXQZTGb25NP37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MQe3mxBb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JA9kvt1xUPJJunIULkqsAer02D/CnPmA4NB1cN0pDZM=; b=MQe3mxBbpvbuOnBPix5ZWDdUZP
	ohded/SQ+ZMYKamiy5wXfu4Yl4DlEicNyIvCZGj02DsKr71YzEpN8zWpKMRWQ8aQFHApS1tJfCDFS
	8Zu8TFbTIiJoxkrKPRYe3DhSaycZp386x9BmTW/5aZtfJw3uazAAU2Na5fLVqralVIn0vC2/yfRvv
	KTyX/iiAldFmjN4uLC2Ykr9v90YC3tx1gjC2axHZ5WTc2IxockTGeD1Gi+M9cCodS1g/Efo7IAZVl
	2HfTv1KJ+W8/yrj5jAYx5Y3ytClyLWHC+GM5cYY88OOB6F/qdJe0HQp89h34w5Anz+azwpmxflU2Z
	qCu/RMnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxRkr-0000000FRKA-3MWN;
	Tue, 03 Mar 2026 15:33:49 +0000
Date: Tue, 3 Mar 2026 07:33:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] pNFS: Serialize SCSI PR registration to avoid
 reservation conflicts
Message-ID: <aab_XbwjYoIPk2_a@infradead.org>
References: <20260302005138.1844156-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302005138.1844156-1-dai.ngo@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 6D80A1F2E24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19685-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 04:51:23PM -0800, Dai Ngo wrote:
> This problem can be reproduced by running 'fio' test with this
> workload:

I wish we could wire this up somewhere.  Not sure what the right
place for these kinds of nfs tests are, though.

>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
> index 6da40ca19570..535db8b0e89c 100644
> --- a/fs/nfs/blocklayout/blocklayout.h
> +++ b/fs/nfs/blocklayout/blocklayout.h
> @@ -117,6 +117,7 @@ struct pnfs_block_dev {
>  
>  	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
>  			struct pnfs_block_dev_map *map);
> +	struct mutex			pbd_mutex;

Can you keep this up with the non-function pointer fields?  I guess
pbd_registration_lock might be a more descriptive name, and comment
explaining what the lock protects also never hurts.

> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
> index cc6327d97a91..45630781f1a8 100644
> --- a/fs/nfs/blocklayout/dev.c
> +++ b/fs/nfs/blocklayout/dev.c
> @@ -33,10 +33,14 @@ static bool bl_register_scsi(struct pnfs_block_dev *dev)
>  	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
>  	int status;
>  
> -	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> +	mutex_lock(&dev->pbd_mutex);
> +	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
> +		mutex_unlock(&dev->pbd_mutex);
>  		return true;
> +	}

This seems to only lock the registration side, and not the
unregistration side, which is a bit odd.  If you fully protect
register/unregister we also don't need atomic bitops for
PNFS_BDEV_REGISTERED and have a more consistent locking scheme.

