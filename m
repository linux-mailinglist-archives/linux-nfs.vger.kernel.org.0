Return-Path: <linux-nfs+bounces-19729-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOHOIKovqGlPpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-19729-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 14:12:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA798200233
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 14:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D445301C5A7
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69CC35949;
	Wed,  4 Mar 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wtOTT0/h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F3277CA5
	for <linux-nfs@vger.kernel.org>; Wed,  4 Mar 2026 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629915; cv=none; b=GaSbFGi2KcovljP62UFTf/UaXUJk0v7Yl4kfTyPLpTmBIS5BZGNBXW6sSzVfBYy+Zow8psezLETVtL2t6EkMMj8blkAGTFWaWqBas6EFF0x0LvXby/0VMUb4F65RgagAG/1e4d526oQpVp5qzl1DU/MMQ1ldIo5n9emAIKKbOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629915; c=relaxed/simple;
	bh=YGYeg+A5NvhOwfu3cvm6IaOHvA6F0cieUAXj4lOSWBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DspKisuVe31zOVxfNlYs0FeJkFRGld27wDx7nBKLvF/gbAD/mXXkkdyVxuuTQSLxrBYWBBjr4SGPzoyM+jqg3Z6Ryn1SVAwRGk78yN7/ds2zCzIM80GdFc55IUoy73N0pGXzQQSSlSByyURutCPgJy0SHke7pV8qsQvx63jfII0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wtOTT0/h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GBt/gjriJNs5vQMe7KLnskiEP5TAkf9OoxIGvdS+aiQ=; b=wtOTT0/hEHANh1L0D+I0ArMvMy
	N2RDMAfy0Gi6BU/E0VVv3uDQcWFZ+dRCgtal/V0SlWQUVVqy3vMZfvscVLnQXxU4fO9bJ0PeBhDHI
	BL7v1YsjzDfyitUqmmLO9lcFoLMzseFhzy9pqbOso5OfUS0V5Z9p4Pvlt9IWKMJZVHVNMA9cjKTXQ
	XiCAjuzOOXzxyRPF9FACwIftnXgsNdcUezYowgmzd28QOv9GXGEaO3FlxHR0uGdUHlLqOQRf8Dy/t
	RXk6mJIoQ2lAkYq2YeyyCdsxP+e2xFEFeg4T8eWgt7cvxR7NCVBGwNzc3WirZ088IrCEMuRu5acVX
	9q+VWMtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxm14-0000000HEJA-1iFI;
	Wed, 04 Mar 2026 13:11:54 +0000
Date: Wed, 4 Mar 2026 05:11:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, trondmy@kernel.org,
	anna@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] pNFS: Serialize SCSI PR registration to avoid
 reservation conflicts
Message-ID: <aagvmtZ0t-GKwrZ4@infradead.org>
References: <20260302005138.1844156-1-dai.ngo@oracle.com>
 <aab_XbwjYoIPk2_a@infradead.org>
 <53291a21-4a4a-4f43-8f8d-73f9415d6128@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53291a21-4a4a-4f43-8f8d-73f9415d6128@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: DA798200233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19729-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:21:07AM -0800, Dai Ngo wrote:
> > >   			struct pnfs_block_dev_map *map);
> > > +	struct mutex			pbd_mutex;
> > Can you keep this up with the non-function pointer fields?
> 
> Can you please clarify this, you meant move this mutex up above
> the (*map)() declaration?

Yes.

> > > -	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
> > > +	mutex_lock(&dev->pbd_mutex);
> > > +	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
> > > +		mutex_unlock(&dev->pbd_mutex);
> > >   		return true;
> > > +	}
> > This seems to only lock the registration side, and not the
> > unregistration side, which is a bit odd.
> 
> The reason I did not use the mutex on unregistration is because
> unregistration happens when the export is unmounted and I don't
> see any race condition can happen at that time. Besides, even if
> there is race condition on the unregistration the consequence is
> a duplicate SCSI PR unregistration which is harmless.
> 
> However, if you think we should also protect the unregistration
> then I can add it in. At the very least, it makes the code look
> symmetric.

And it clearly defines what the mutex protects, so please yes.

> 
> >    If you fully protect
> > register/unregister we also don't need atomic bitops for
> > PNFS_BDEV_REGISTERED and have a more consistent locking scheme.
> 
> Even we fully protect register/unregister don't we still need the
> PNFS_BDEV_REGISTERED bit so the others thread can check and skip
> the register/unregister op?

Yes, but it doesn't need to use the atomic bit ops.


