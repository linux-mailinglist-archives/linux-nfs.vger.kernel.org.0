Return-Path: <linux-nfs+bounces-4126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DAD90FC2A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 07:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98FBB21283
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 05:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAA82745D;
	Thu, 20 Jun 2024 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AH18XrPS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30735628
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 05:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860913; cv=none; b=ITWPSv/gf/CAoucj8bWYqMjzdjGuAXFcq6HqHDT13ANLvbw1BAv2+64CNf4tjdiPMLbNIWc4t6I0OakOcI9IxqaEbP9O6B7woWrlI76KTRA2ar/GxCXpdXtFlv81MY8fD/GgTgK9B91i0auw/OAtQfHXRBkWAY3itYKeweoK+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860913; c=relaxed/simple;
	bh=AzAMeubMAbORmQRAb9jHEg/sRmEybaFW8/R1jx4aDy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az2jyYiAcE7M31CPFPzuhb2mI/SFVZFqwTN3iaV0esV9rMwqgu89GL6hgV8/bVcuqLAMGe6T6Q+2s/V6eFRh9sMG0iblQJmUl9OZ/eWpVfaBi5xWVuCDPUlk34NMrjeOQGpBKi0zw1K17sXN7ZF5wmFMvF9p7EDY5yuknIWxU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AH18XrPS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mSibmmyA4RCOInw5rw6+LUgt5oR4Eeo/YQ0k3WlN2qU=; b=AH18XrPSoycbrBDqoU2R5T7Pb0
	EQayY237QGIqPnudZt978nB+s0AC5vG/7+402HevR1o51r9LXE8G/TJZf6e1kluUTCVPDKh20+mfG
	4xlC5zKNIPt2VR1VDKC7R6E3Q3ir8FMHDDwyC7KEHFURqy/cGc+rJxFJ7Qh/AhHQkCi1/HLEriBEU
	JRvwtZbiuEfWmA8g4oIrIME+BWHTMOdhWnwjnvC3jyE2GpC4+XABq+8oZ8mtt+sHkHzZP1S6e1t0r
	FgLG9dg5C+dCy8ujU+v6eceqoiA3m4WkQiW/CMHbPmvCp+IKq2mlBEBBi6j7MkF7GrW1+S1F4cmUB
	Pka29Ceg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKAF5-00000003fZv-0T2q;
	Thu, 20 Jun 2024 05:21:51 +0000
Date: Wed, 19 Jun 2024 22:21:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: cel@kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Ben Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfs/blocklayout: fput() needed for ENODEV error flow
Message-ID: <ZnO8byESzfdyftNm@infradead.org>
References: <20240619135255.176454-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619135255.176454-2-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 19, 2024 at 09:52:56AM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> A recently-added error flow needs to fput() the block device just
> like the other error flows in this area; otherwise the device is
> leaked.
> 
> Fixes: d76c769c8db4 ("pnfs/blocklayout: Don't add zero-length pnfs_block_dev")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


