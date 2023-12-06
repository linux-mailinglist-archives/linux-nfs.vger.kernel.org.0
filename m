Return-Path: <linux-nfs+bounces-356-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827678066AA
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 06:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BFD1C20C21
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Dec 2023 05:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57796EAFD;
	Wed,  6 Dec 2023 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDuZEcsn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBACD5A
	for <linux-nfs@vger.kernel.org>; Tue,  5 Dec 2023 21:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jSXMUEwEKlogqLJouY8bxkG+ev/shBNNrzwfarR0D18=; b=NDuZEcsn+rw6YFX+llrunbvXw2
	M8OrR3doFjw/lvcxu8unHx9moAzv+LATf/q9hPJN/WLvhiaFjLgNmm7UBEpEO1sfo4frJrEf/fDuZ
	CIl8RSi4FngIU4eQcaqI5SSc7AuSYyHvt9AlC4oLEM1js5WVqk/RyMR09KUv+ewxPoT2G1y+N3L8O
	c39NwCtZWlHrW6TaRSYFbezbzzWUhBcJF0kkTSqN6TawoU41KLCzjkHjh3EHUIgzxhnaUjXRx7O0G
	vQ1nYUChg8w4o/Dt7MqBLaT7gqvuItpSXC4S7cuIkEj9vUsr5FqfNLTH/5rIaoO9WrGVFdeqr0k99
	IO2G/vkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkhv-0097ep-28;
	Wed, 06 Dec 2023 05:44:27 +0000
Date: Tue, 5 Dec 2023 21:44:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] pnfs/blocklayout: Don't add zero-length
 pnfs_block_dev
Message-ID: <ZXAKOw9Q5EoOqsr4@infradead.org>
References: <33e0ddfaad92ca5d6b0a4d1cc7541cf5a7480d7a.1701788600.git.bcodding@redhat.com>
 <53e2ab90d83d4cdc15f1b48b2eb671ad26f54a6a.1701788600.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e2ab90d83d4cdc15f1b48b2eb671ad26f54a6a.1701788600.git.bcodding@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 05, 2023 at 10:05:02AM -0500, Benjamin Coddington wrote:
> We noticed a SCSI device that refused to allow READ CAPACITY when the
> device had a PR with exclusive access, registrants only.  The result of
> this situation is that the blocklayout driver adds a pnfs_block_dev of zero
> length which always fails the offset_in_map tests.  Instead of continuously
> trying to do pNFS for this case, just mark the device as unavailable which
> will allow the client to fallback to the MDS for the duration of
> PNFS_DEVICE_RETRY_TIMEOUT.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

