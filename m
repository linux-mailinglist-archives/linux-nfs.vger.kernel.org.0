Return-Path: <linux-nfs+bounces-15671-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB4C0E060
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE12406617
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A62289811;
	Mon, 27 Oct 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ezXeKOj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3BC2C21EC
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571671; cv=none; b=SwjzvHiPfPUUQ/1FfvoAWMSsKzrLFDwqKXxsrUt4ab6zxsZ4J7HGBvedFUvZF3/p6WQnM00pVT+q+k91QWohKLp15g2i3IMQNV29qBQCe1KvqkYJZCHDCEhp0eGAjcdEhPBVnB+AS/VIMwUURWvrure97FP6blu4CNOHfNk9iYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571671; c=relaxed/simple;
	bh=w9Tn6gxtR1eeMB7BTQZHOPzd/erdByM96PA6lifG/KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVX4AuyL6ZnVJccC0aD2XxPvvll5K7gHgMKGpN7lJe9tFWxbd9i2ALwL2L6fOZplMQtE6SLvChIpjG/PxPgkuvxyqMDxqffku4/cXM1bd2U0UEKGPiCDDMfMVOYIKrmVPQZ4XkJg5ti+6lMk+se8qkcOpc1mmAotBLdL6QmN8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2ezXeKOj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LjL+q54744p1iE9uVgUX5gWNDQeapLZhNQmv6UPlOSM=; b=2ezXeKOjy8zWijOwp0jyIYFMj0
	ObA1/+917gvTWT/BBqDrIImY/CcHZUpD2AoOiW4INufLOuKXCAW6j1ipJ0shlerT6i0bh3zHIzEFR
	ZZP1EOI/qavZYWfmIyKhfI6Q76TgYq3wWwH6sjaGO4kHQuFJscP//GUfJfVsEsDQAB3vPvtE/5gU7
	I3MfmCIMRJpD6d5q1hfc2lM1B1IN3yDPPTdlysAJD4YRqx2FuIgTw6eTemH8F3og+ZedU9Anc5zz9
	dOI+1SZt0A0J46EQE27MdkL1I/40fOJMuG7sg+2bXwYvPPOZCDFud1FmaJ85CKuVcRF68na4JYkOf
	9ei23tOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDNGF-0000000E0y9-2lt5;
	Mon, 27 Oct 2025 13:27:47 +0000
Date: Mon, 27 Oct 2025 06:27:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
Message-ID: <aP9zU_9e2VDw4G7I@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
 <aP8n4iqMPie83nYy@infradead.org>
 <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 09:23:27AM -0400, Chuck Lever wrote:
> Promoting all NFSD_IO_DIRECT writes to FILE_SYNC was my idea, based on
> the assumption that IOCB_DIRECT writes to local file systems left
> nothing to be done by a later commit. My assumption is based on the
> behavior of O_DIRECT on NFS files.
> 
> If that assumption is not true, then I agree there is no technical
> reason to promote NFSD_IO_DIRECT writes to FILE_SYNC, and I can remove
> that built-in assumption for v8 of this series.

It is not true, or rather only true for a tiny subset of use cases
(which NFS can't even query a head of time).

For devices that advertise a volatile write cache, commit has to flush
that.  High-end enough device won't have one, but a lot of devices that
people NFS-export do.  For pure overwrites the file system could
optimize this way by using the FUA flag, and at least the iomap direct
I/O code does implementation that optimization for that particular case.

For any write that is not purely an overwrite, commit has to write out
the metadata to track the newly allocated blocks.  Applications that
do overwrite fully allocated blocks typically do that using the O_DSYNC
flag to fully benefit from optimizations for that case.


