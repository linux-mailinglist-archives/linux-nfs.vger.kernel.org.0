Return-Path: <linux-nfs+bounces-17839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B78D1CB13
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 07:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3806A3067F67
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jan 2026 06:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31A36C5BB;
	Wed, 14 Jan 2026 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uR3Hk/6L"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE7C2D5408
	for <linux-nfs@vger.kernel.org>; Wed, 14 Jan 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768372669; cv=none; b=T0j5I7WJrVpIr4SajY/O6Oqbw7uXyW2ZXBNyE7NKwB3KYWHYp4nlagMrEkVEdRG/c82KLarMno1iWOQV01wCALzLYpB9GTA7eXPEG6+RJ0e16+m1opLl/9sHaM5IMvRtVYkilGD9e25i1G4LE6KowPakUdjpMigJK+/L97O/rTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768372669; c=relaxed/simple;
	bh=BiSIBneZ5ZCniYSAbWLIWGgzLQXTwRc+ttb6nIYxIBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdHCTZeqcbbItD8e34d385nX7XzY/hFqQu7mzEOH0esWrA26nEAxKTWU447A6PRnIhXKLfJbpTzOV56nTIrBZ8wYqXf1HqZ/Ct2usjnEDZ5qgMH810sGgf8WFoxMqdllTsNKPaIl6YK+ieozSp0/19sO2xDCR+k8eMY/t/iwkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uR3Hk/6L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q/WKdOKkMez6yN39Ireh5ggeeVRr+PODMN3NAY5tbDY=; b=uR3Hk/6LKM+ytat/tlqaOts5GS
	tMBZ2uFFf1uW9togeddILFJv+xSlFPna3Dr0QRLFHsWOpfefIyhuw5QNQyE2NILmrDvAejeAk1vJS
	OhLv50I4jtBgJ54ruoIzc1K9EjtBngNEqjqqj8Ou88WxABQtmWeikdNkuv5NNZVy9JfZPEAGtfJ35
	p34BtAUwkB8zsxY4mCCYfACkc1/dIMVs1YYHb3jHbEeZeibkCz+fQN0N42rgPZnUNw/IaALwEa3ez
	3YrHZQCyRoIqecq8RFEihup4803JkJPjPofkF84b/swfgKTCxR5/GUwLINqAAQc00YDXYfSd4Zr1Z
	rxOxNJMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfuVY-0000000888x-2FmL;
	Wed, 14 Jan 2026 06:37:32 +0000
Date: Tue, 13 Jan 2026 22:37:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhou Jifeng <zhoujifeng@kylinsec.com.cn>
Cc: linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Questions regarding the usage of SCSI layout for NFSD PNFS
Message-ID: <aWc5rH4t0Hg8ZNEO@infradead.org>
References: <tencent_5BEC627E1710B43F5D8245FA@qq.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5BEC627E1710B43F5D8245FA@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Zhou,

On Mon, Jan 12, 2026 at 01:49:32PM +0800, Zhou Jifeng wrote:
> Recently, I read the Linux nfs and nfsd codes. The nfs client supports various 
> types of Block type such as PNFS_BLOCK_VOLUME_SIMPLE, 
> PNFS_BLOCK_VOLUME_SLICE, PNFS_BLOCK_VOLUME_CONCAT, and 
> PNFS_BLOCK_VOLUME_STRIPE. However, the nfsd code only supports the 
> SIMPLE/SCSI types. From the perspective of the code, I understand that since 
> Linux nfsd only supports the SIMPLE type, when using it, a SCSI LUN can only 
> be mounted in one folder for use, and it is impossible to achieve the scenario 
> where the same folder cannot simultaneously be associated with multiple 
> physical LUN devices. I wonder if my understanding is correct?

That is correct.

Implementing mirroring or striping directly in the nfs/blocklayout code
would be fairly simple, so if you have a use case feel free to work on
it.

