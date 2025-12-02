Return-Path: <linux-nfs+bounces-16840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CCC9A332
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 07:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9D73A170B
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 06:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E12F5A3B;
	Tue,  2 Dec 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MDz2CC0k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5128C84D
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764655762; cv=none; b=l0YOznqINVGq2Cd+DOQ49lYpOWmJZU5QT9HyOGzsY2YkSDTLiBOP+0I90eRQK0sLZAMhHs56AGs21HJswE/ffJLzvBGfGigmxNbACyFYIqxwIPr+kTjQF7bgGnO6q9D7hhc/pSwVABCKWWj5pk2xgrsVrlqu6tVIkCKo8FlzdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764655762; c=relaxed/simple;
	bh=f7Lo14bXUlJRxZhnT/Zw2AsaYWvsdhtwNMJ4vIRJ6EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2EJ7+bn3xFhX04g3GaLnhJ3YlfglPLYK+uI+0r5XdYhrBO5jTmhG6OLXgBqdFx5UkeJ5rw9OE2/H7H0RgdBsab4QuRh20wbpAK2KAsnOWem5BsIXAJ0drj6RWiLsW7HfI/VWJBfh9cwVYGOLRvZ7cYMg1i00aNSWSlwmfAkN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MDz2CC0k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f7Lo14bXUlJRxZhnT/Zw2AsaYWvsdhtwNMJ4vIRJ6EQ=; b=MDz2CC0kLl3cAHKpYzUU42jhjO
	xJhphMgfcNPm03jv+Tt39/uUW3knufo0LxLxGh3IeP4xDbqbMCu0ha96t/phGraVyxw1p/ki8qqkI
	c+34jscnPAajwZ7sP/4nBks6t3usaBwbgT+4/fgNtv0R5ZPbt7maZfJVh3HEpZYtWYXm0ZblmTRXr
	ildPjiHgHovl4i7npny0PBVaLxHGyC5DOqXq6IvuaEO/LZYi6C5aZMFncl2KGpjSPTzLN0oFoTO2m
	fMJUtHCT+Emn8jggVvJNaMIMlzG529W6Ou8/bwzR2TMFzQ2+lOv1Q7zw/bEWif2bKK8qz2M1q8mzq
	DLCKwTdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQJZX-00000004tSA-0Ln7;
	Tue, 02 Dec 2025 06:09:11 +0000
Date: Mon, 1 Dec 2025 22:09:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Zhou Jifeng <zhoujifeng@kylinsec.com.cn>,
	linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: Can the PNFS blocklayout of the Linux nfsd server be used in a
 production environment?
Message-ID: <aS6ChyDRx-hALj5V@infradead.org>
References: <tencent_780E66F24A209F467917744D@qq.com>
 <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1b3d07-fd80-47d0-bbf8-726d1f01ba54@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

As the author of much of the block* layout code I agree with Chuck, just
want to throw in a little extra note:

On Thu, Nov 27, 2025 at 11:40:50AM -0500, Chuck Lever wrote:
> NFSD's pNFS block layout with NVMe implementation is fresh from the
> factory (I think the implementation went into v6.12?). As with
> iSCSI/SCSI, try it and see if it works well enough for you.

So while the NVMe layout support is indeed very new, it's also very
little code, on the server side the support is entirely contained in
the nvme driver by implementing the get_unique_id method (~60 lines of
code) and on the client side it is looking for the nvme persistent
devices names (2 Lines of code after a small preparatory refactoring).

So in general I think it should be taken as the same maturity as the
SCSI layout at this point.


