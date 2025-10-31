Return-Path: <linux-nfs+bounces-15844-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F874C253F7
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404204F76A4
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2726A34A3CA;
	Fri, 31 Oct 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zdHoB6tI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD92E413
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916835; cv=none; b=uVTMPCfizDV/5l8OkjEJdp8mTshs6Xcc6LXcl41Zlj1yqFdu/vSGWzajeeg2zau1F6YNW9//ijlAsEGCnjrZdjfG2j0Smm6rB7bfZ8DB/MmmJ5oIjVtDKYuT1RU9pyaPgOgqkYiaIGA4oOyN4MJMPqw/dO3s1iqKr3R0U8XKbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916835; c=relaxed/simple;
	bh=IPT6Ji3OwdbL5dCypbawJ48hSzUjMWf325WbCU67x4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef4wAC8jndgX8YjTgwniW7CI9csBVpslDX5qXijPpHDNCQhdTr3Rn8NusXrKVqHqRGNOsSfulj/aZFvB4KD7ysoSvoR9JmayJ4/BEaiIR3H1quQhJPPySuq308eM5UDml3bawrpuJy5sOKEsEAqyxVynWpvJcn6pY7m5H2yAzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zdHoB6tI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f4z3nj9fVcDr/Um+OHSNEgmJwxBfsIKKfRYWY2vqroA=; b=zdHoB6tI8giJbFk/h/xy44l8mG
	+Hv4lyiBXn3JJfjofBBgUOsJ7vNOd9rbAaOTmz6rKzVP1UEuMEYkup4UfwAdP5LJVmu9L+tQ9A91T
	yflt6uNZ692GZjDoRl+Ve7kuyGqsX2LuIINSGxqmKW8S5sQLGutwdAmj3xq6v4iKuqOv66ZD5v/S7
	3YT7bqZ/1tBIsQpT7X/oaNwTZaDG1C3sIEsCyKMASBi3nN7qQqnXEQWW+PFAUAxNhFJ6BpU4vvjof
	IE42HnC811vspOAA+nUnA+OpRw6hbYlIu9z+P3co3bykCVy4lOcxI5wwdzKuZhJNaNgkJo74e2J8W
	jieClcBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEp3P-000000069c3-0LAD;
	Fri, 31 Oct 2025 13:20:31 +0000
Date: Fri, 31 Oct 2025 06:20:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 10/12] NFSD: Combine direct I/O feasibility check with
 iterator setup
Message-ID: <aQS3n3xPHoeLJhZg@infradead.org>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027154630.1774-11-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 11:46:28AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> When direct I/O is not feasible (due to missing alignment info,
> too-small writes, or no alignment possible), pack the entire
> write payload into a single non-DIO segment and follow the usual
> direct write I/O path.
> 
> This simplifies nfsd_direct_write() by eliminating the fallback path
> and the separate nfsd_buffered_write() call - all writes now go
> through nfsd_issue_write_dio() which handles both DIO and buffered
> segments.

Yes, this sounds much more sensible.  No real review as I've already
lost the context from 10 patches earlier touching the area
unfortunately.


