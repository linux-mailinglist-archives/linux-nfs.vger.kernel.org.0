Return-Path: <linux-nfs+bounces-14937-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1C5BB5FF5
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 08:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EE014E2997
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA121B195;
	Fri,  3 Oct 2025 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d9GTXDca"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4B1C84DC;
	Fri,  3 Oct 2025 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474491; cv=none; b=jRLEn+IEJ+pOD08N3co7ZLMhleoGUVdauL94A1nByghcDYem2hsXqEOE4wnjY/fe8tMeI2YnVLAKY8RAlf0EtIQlPhyo2nDTTIOxkxes2xMuj4vg0NGm5hAg0a0jfap0WaE6QtxffCJmF0tOvO27pW6+fJUx1y4+7bXM1gQI9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474491; c=relaxed/simple;
	bh=dxOdG+G6vIwZPiIR/JdgHAcatfzUDfshbAKSs0tyVDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6BfSUxcxNlW+FqtMnTjNFe7xoVWIdGWeddnOgLa9FppipJZs3iMc+IgJHWrh7zkUKdXkHRMyzB4ds1fBFB3C+PQbQleLKlLxBZgIn4bziWgwz0maHLteOOnTUDAUCG311+JOCEAJl8wKPbdpvkjfOsooUOblqlFFKIP2hKtCgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d9GTXDca; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OKkdH+wZWKH8PQiS1B8EW1Q/EiGwfcrGnF8QV1FSBOI=; b=d9GTXDcasdc2FbKFeOrykrLjQG
	Y+jGIxL4yH4gtX+T9QbRJWeTbJc2qJuwuNejKgB0txSkHpJ8aXh7skpinwZwAZgn9U+dC+NuIEWu+
	Tw3pajDtWFox+/fb+8NfoIOYCo3nllKTQWSg8wQCwRzOG+U5zT5d/m/5O4f+8nddgc7zgFZcoyei+
	UiIfiAvWMmMQicAh6VMleJGcwZGxR1GzOT/g13EcWrnDegKJSqdQ+qJzL/evvjz/D6BBLR5Euwh84
	5LYZxf98esvErd+0eK8MTN/d8harSpJpM05yloV4VrUVlxOmO9vARtoFxx1q4WV/DzXKKzREFuzBS
	+NZAZp6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4Zgj-0000000BlCI-1lIo;
	Fri, 03 Oct 2025 06:54:45 +0000
Date: Thu, 2 Oct 2025 23:54:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Dai Ngo <Dai.Ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] NFSD/blocklayout: Fix minlength check in
 proc_layoutget
Message-ID: <aN9zNZ7n4KwhIZrJ@infradead.org>
References: <20251002203121.182395-1-sergeybashirov@gmail.com>
 <20251002203121.182395-2-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002203121.182395-2-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 02, 2025 at 11:31:11PM +0300, Sergey Bashirov wrote:
> Minor fix as part of the functional changes. The extent returned by

I'd drop the first sentence here.

> the file system may have a smaller offset than the segment offset
> requested by the client. In this case, the minimum segment length
> must be checked against the requested range. Otherwise, the client
> may not be able to continue the read/write operation.
> 
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>

Can you add a Fixes: tag here?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

