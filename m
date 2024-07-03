Return-Path: <linux-nfs+bounces-4600-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC09264D7
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5811F1F231DD
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B317E8EE;
	Wed,  3 Jul 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3yvKNJ6S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CE17DA20
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020564; cv=none; b=HKImLjXx1NZKry3PEWH58e6C634NL8gpSvvVvijDjTeW99LwlGiipaFTeZYCtaQRh2AGE0+iSTJNINOwS0cpm/VgeNNgSH5q8Q/AUqIY5rg1C7YknrFU+RCQZDuFN5IwwUcPR2yne9FZLf3q/8FR6pfhyH+Mgo5DaYUbeavOAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020564; c=relaxed/simple;
	bh=SMv9ubDQsVdjYsvZDJiRUDELyEjnxIxAWnZmJ8W02vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAWqL9TsaUKQZI6DEbtELfNcBtafdGGMPMUPjutPD+uf9VFXE1qecDz6LxCDtQ7V5VvmbIXocLyD2/oti4cFv42brIXOp0MCSNkm4WLQGaEUbD6LfQIEbCDARCHxB820Xjg5LxQzL0l5UIsS37NRQIdkDPt5j5lZ2/6wsm8cNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3yvKNJ6S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tfVxorKDDorqcMWr5EHg7B7km4wgJe6Z009pj7Jqqac=; b=3yvKNJ6SIJ9lyEqi9NmCrbuyAl
	i16uslLz84T8rdjKPVEFpyMHZh3kanfi2ouYHWbm8zI/qO2E4pGJ9DhRj09e0+Hjswv+K/DeX0m7J
	JDhSLAnzBSxpoxsW/8gALQJUo3horCCcup9ta+koh0YSzDrptweace8waeA0fL6x8Ok26/KFt9xU/
	JVBgoWmb9PQtCsfb5sUFs3/oyOy+sDKwsj2BBG93nxNMTDEnX9EzTtq8AoJIxO0QV+8SlG/QxG+6j
	sORY21uDFyRoPqsOEb4xJu2aRL1/t4BAiIFah/UJBtLhstYzB4aFLlyYflhsZywRRJ7bK7w0HyFLs
	cd/4+oDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1v8-0000000AgDO-2yJV;
	Wed, 03 Jul 2024 15:29:22 +0000
Date: Wed, 3 Jul 2024 08:29:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoVuUriFaVCWj-Dy@infradead.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <3A583EDC-519C-4820-87E9-F4DC164656DB@oracle.com>
 <ZoTb-OiUB5z4N8Jy@infradead.org>
 <ZoURUoz1ZBTZ2sr_@kernel.org>
 <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 03, 2024 at 03:24:18PM +0000, Chuck Lever III wrote:
> I'm also concerned about applications in one container being
> able to reach around existing mount namespace silos into the
> NFS server container's file systems. Obviously the NFS protocol
> has its own authorization that would grant permission for that
> access, but via the network.

Yes.  One good way I could think is to use SCM_RIGHT to duplicate a file
descriptor over a unix socket.  For that we'd need a way to actually
create that unix socket first and I also don't think we currently have
support for using that in-kernel, but it's a well-known way to hand file
descriptors to other processes.  A big plus would be that this would
even work with non-kernel servers (or event clients for the matter)
as long as they run on the same kernel (including non-Linux kernels).


