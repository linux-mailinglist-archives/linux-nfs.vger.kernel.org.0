Return-Path: <linux-nfs+bounces-15745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2958C18AE1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 08:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884324627A0
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DAC30E83E;
	Wed, 29 Oct 2025 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byiCup4l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D04C6D
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722449; cv=none; b=K5AxNd1JrnMR3Um3CzbLQ2Bc1hmv9NgQKRnk1s9PAfKJcyNXkk+NDlZPF5QlfOi+3LAq9WiVYBluq5MXnzvEp5acVtSpe+wGpuoZLJopgWzLWipnZBFIrIJnmSv3P+AmA3DcJEIE/UPqmwpYhmBOL5/0IZXO5eizX/oMwqptDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722449; c=relaxed/simple;
	bh=k0kfyMYW86crkpEzqObi9A/0xroVRFPAjxJTkswfcmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vqv15an1FTVDVfK3noY7m9As2d1ZHDpja2zAG0gYUteYUh5o12YJAFVXllP9vGo2vjJKqt84hjwFh8uHyye9QRnQlLQISYYynmlzNr9Pd6jNNtAiHX+pOA98KwtlNbgLcHHO5pXgBxXFK9OUIXedFz8KH471GX7jtUYiL1iw7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byiCup4l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L6dfQK8PTQAo4xMo3Uyqc0dDRQ30gQKm9QSUMAbgfYs=; b=byiCup4l84POhm+Btm+99ykcoF
	XQxZdCJl3sMmVZAaiFeLzs20SKTsFyr3RZ8Qu+N+/7v3UEL6bKdt6aGlHJ1DScaQOMrkyUYkqxrWu
	dGk3/Mgo4UpJs7+cYagZDvt2H9LX7pS2rZ7KJxiYUus9SOJvdiJknzz5/pE9/ygvVG/quTc324X4P
	gj4hr38hdu/QGAKUi692TkJ+S5fSnuaR1acjbuM0zxfe3yAWBWV4PLTyrZuFjD7g0AdLt1oBmga3o
	fVc7yilCl1dFNFNegqI4dY0v5pG7VFGB6nfD6JCZFm8dOnaAIA1qBWVuSkZwHnw77ng1wJUB9NUhK
	RBxj5tog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0U4-000000004bK-3tPb;
	Wed, 29 Oct 2025 07:20:40 +0000
Date: Wed, 29 Oct 2025 00:20:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQHASIumLJyOoZGH@infradead.org>
References: <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <fc8e4689-ca7e-45e5-882f-aaa0946e1df7@kernel.org>
 <aP-bVnJ-teH1x5eK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-bVnJ-teH1x5eK@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 12:18:30PM -0400, Mike Snitzer wrote:
> LOCALIO's misaligned DIO will issue head/tail followed by O_DIRECT
> middle (via AIO completion of that aligned middle).  So out of order
> relative to file offset.

That's in general a really bad idea.  It will obviously work, but
both on SSDs and out of place write file systems it is a sure way
to increase your garbage collection overhead a lot down the line.


