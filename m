Return-Path: <linux-nfs+bounces-11549-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E8AAD54B
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 07:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D303C986BA9
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 05:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB01D618E;
	Wed,  7 May 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0MZ9FYk5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A51DF25D
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595981; cv=none; b=pf7yBCHTfPl8i6hrnsDBOyHiL711RtEkXWWyuErLnaTh43FKxtlInUKsE1G70+KrSySFM0I6Sh85wXujGUOHXpkLoptiuQTYwMuBcagQMVZdtjaDHRtDi1cI93vi+IEV0aN9BDrGrRCdN6H523m3khu8hu0mrYYUCDvXxkkBrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595981; c=relaxed/simple;
	bh=BZQSFwlX10XleVKODiKa/NRUtRJHW/zJ4wM7LjSIfGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQvgQzmHCus5YyeRJhwqm/hK9XSKxo8E/fY2PZorGopUHFPMi1SZCvUiCtINjut7pXq+9CgfBE5b6S2gKPUNwS1qTHJjrMLYF5CausdRRvsXK5L2LLTR6P259Oj+XxzH/OstuEOiN988gtIq6DGAavCN8c/Ipj3WVXfhB8zS22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0MZ9FYk5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fFw6Y6agzrZjzBmkwNNwMz6H8AAqf4SDGK3o9ao+52k=; b=0MZ9FYk54fPF7MZJnz9Og9oyyx
	iAw0eZik1HsUmph2DEsORvSUESHnHm+a9j2wsySvfKFRxWBRa3aBxdAFl0gmEadTRC6rHOQR499JX
	I6Ctb4TMN31bsUNvZ2tsK8o+TdI/nER1kSmM4Gfgil5SICAchC1Rmlx7H/BPqEaH1DtX6FZ1sVnCQ
	e1SHxVHnEx9LTki91PMbEcdUien3bPclidLT42Vxziqv/+YdR3AarLCb5dHws03oaKtb0RwuhDKWQ
	YjpTZJlo6RyJ0eq+vk6uiVyLpbzlRaEWeEAY2oBZbOo4YEE1e24BxvmNeZSwkho5KDSRsv+MTc7Bx
	FAq+VGHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXOr-0000000EH9m-3eKe;
	Wed, 07 May 2025 05:32:57 +0000
Date: Tue, 6 May 2025 22:32:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Roland Mainz <roland.mainz@nrubsig.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] NFSD: Implement FATTR4_CLONE_BLKSIZE attribute
Message-ID: <aBrwiS1DM1i-DBXH@infradead.org>
References: <20250506150105.11874-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506150105.11874-1-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 11:01:05AM -0400, cel@kernel.org wrote:
> +static __be32 nfsd4_encode_fattr4_clone_blksize(struct xdr_stream *xdr,
> +						const struct nfsd4_fattr_args *args)

Overly long line here.  And easily avoided by using the much more
maintainable two-tab indents for prototype continuations.

> +{
> +	struct inode *inode = d_inode(args->dentry);
> +
> +	return nfsd4_encode_uint32_t(xdr, inode->i_sb->s_blocksize);

That's a bit of an assumption.  The generic clone prep function uses
the block size, but file systems aren't required to actually use
generic_remap_file_range_prep.

Probably still the best we can do, but a comment explaining including
a reference to generic_remap_checks / generic_remap_file_range_prep
would be very useful here.


