Return-Path: <linux-nfs+bounces-15676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E24C0E32C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737A04F9492
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C42F9D9A;
	Mon, 27 Oct 2025 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zd1/v2oY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684D3009CB
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572989; cv=none; b=ND3vYIFkN7Z77ey13qSyOsn4jTOhrp+2ecVmug0FCJG+O9vSYN0sp5qbEXrgmeHT87y5n19R3q7OEscOD53qT0b9tLBH1NIur2lpmDPzBLUNYBv13z4hyx7jmf9XpFCG1MiVEBvXFbxhVY1ePPrWFUUk0D/f0yZQn0e4QgB6R3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572989; c=relaxed/simple;
	bh=QMCnt1gAKirQSE7ODAlgtEQgF1t4r+WqTIYJurtCOJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqJAicrutikzUoO/BMtd5N2z5HHrFY/VqZ5xR2EY3POBkYLFWVBNivvZXfNiNxqeI5QGFNw7YurZRURRZXiBndr1+5pba7DJ2Yee4JjgIkTFn3/MV/zt+st6WSKXHV/+GvHOyD1Jk44oXksLcp4WlZPz6WRGv4ncn5umq6PEG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zd1/v2oY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P6LAVtTBJlVn/tki36+pLj0HNx6epU4ujYIrlzVCclw=; b=zd1/v2oYEbCG17N1IwDgpVuCxp
	NSm/0g+8AhvsBbXukjEc9BR6K6I8zGV+Sj20T4Mp7E8TbL10UxWZJj7n2nbXFeYq3jvWQtGtiOaFh
	7VZNHI5t8go5nO2K/r5X6oIP66udjfQudbudd1XjTlw5W1Yt+0oh9KEHZHvqVVqxCTYWnYrIIMAo2
	CdJldIZhL72tjtBt9MF30Nx6Rxdwoj4e+OFfumNKqc+6SlrQllc3xG9IjBa26BTr+YBqTr8poX5NC
	cTzFyqQgr2ZG8s9bayRjLGzHHgD6qVtI5JeqvEEJqly44zHw7f0nz7C0jJ5mAWRN0QLPw4Pui1joE
	lPXGUmkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDNbV-0000000E5cp-0QSW;
	Mon, 27 Oct 2025 13:49:45 +0000
Date: Mon, 27 Oct 2025 06:49:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP94eWOQ4kkQHw7r@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <fc8e4689-ca7e-45e5-882f-aaa0946e1df7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc8e4689-ca7e-45e5-882f-aaa0946e1df7@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 09:48:23AM -0400, Chuck Lever wrote:
> What concerns me a bit is that the code that handles unaligned ends
> is careful to issue the vfs_iocb_iter_writes in file offset order. Are
> we OK to use IOCB_DSYNC for the unaligned parts but IOCB_DIRECT +
> subsequent COMMIT for the direct I/O middle segment?

I would just expect a COMMIT for everything.  If the client wants a
stable write, it should ask for it.


