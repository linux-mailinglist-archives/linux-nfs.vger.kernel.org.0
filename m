Return-Path: <linux-nfs+bounces-15649-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DFEC0C424
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA82F189E401
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DF19D065;
	Mon, 27 Oct 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e6LCrWGW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE31DF252
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552769; cv=none; b=YlVeZUzj/FguaWU7UWqGEU6WslE5J4yQNICOM82hmS2pLTptZSI8UUhkMyWB2db8Sm2PfheGcDz77gZd6cB1GHn+mhjPMFtYr/drWFagwiYu7uonjQKwi9xRVscmJxmjizFEcodDoFkZFAWTki+p/u7fOmX0XBCgApnRcL3xsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552769; c=relaxed/simple;
	bh=Becg98V+9h5Jfx72Nez3ui9DB13YAxd43psVH8FXcT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcoGzc1M4zHdOeV3PdfJk35O7DHFnZdLGBfZ+1gHld13XvcJvi/+LaOWlcxcgnN3640V8tS3KJvND6gQUVXrIUkcA4zPqCEptnLzcCAeSgva0PL0Y8grGSOxZKeNp8Fi0DQ0arKOrtW5GHqWjLGm0ng7bYvhVDVp4tFzarU9rh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e6LCrWGW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gE0f+iHWlvil/mURBEs+5H0Gpac7owHzxb63u9dPVeQ=; b=e6LCrWGWhMJMXlmJw8l9pOK1ip
	5E+PhfhKg2lPnap58TubvkvhC4lStV5KFj88Owb92grAbq9kp3DAFiHQuAUmlNyBXUyU/OHozeOzD
	DTR2ZMnQs2UvgmEvow4+2gGz0H+YAK5t6A0jzhzhTT8qu1mIDjRoecyFU++zVe4LyRCXlD+Pv0it4
	g6SpVrNi56aK3FFnpGN3a6MRSXKBAIbTP+VgI0INTpVKw99YPHx6le6U3JN8Rcn2+gHl16qJcNGjO
	0ElWJtCXwNHppA4rLTOlG7OFjvJvkCMNOLrP9kBfoDs2Tyk4KZ9e/SIDbETwia4Z+y1bgZ40MHx+7
	aHIgP3bQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDILO-0000000DKXT-0VBZ;
	Mon, 27 Oct 2025 08:12:46 +0000
Date: Mon, 27 Oct 2025 01:12:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP8pfpm6jb-Hj92B@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
> This looks like an xfs-specific fix. I'm reluctant to apply a fix for
> a specific file system implementation in what's supposed to be generic
> code.

It's not a fix, it is a performance optimization.

> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
> systems, then it needs an explanatory code comment, which I'm not yet
> qualified to write. I don't see any textual material in previous
> incarnations of this code that might help get me started.

IOCB_SYNC always needs IOCB_DSYNC as I explained three times now,
including a detailed analsys of all users (We really need to rename
IOCB_SYNC to __IOCB_SYNC to match __O_SYNC to make this more obvious
I guess..)  I still don't understand why we need sync behavior and
forced stable writes at all, though.


