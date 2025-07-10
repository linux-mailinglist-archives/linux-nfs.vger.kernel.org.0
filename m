Return-Path: <linux-nfs+bounces-12962-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8CAFFABC
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F117AB33D
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723322882AB;
	Thu, 10 Jul 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqNQ3tl+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913228751B;
	Thu, 10 Jul 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132113; cv=none; b=PlWXglXMvz6f1Nv16fE0DzDOgq5PhjI1gIPyTH9nF9+N47+B+h+Sjm4W7ReTO2f7ai/ePHcaYDevhGCGkpEs4/NN5gzZrA5sL8AEBJDH5vprq9JL28UnGiIH1Y5lS5GTRF2qh2lLKr96vOgbK3Hr/zMt6FQw0WZjH6Ty6eFQJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132113; c=relaxed/simple;
	bh=mH0l0/3NDRvoeIqiEZlhukO1z/JWzJAbWEzHTgFCdIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEEaY/fFuAzC8LFt4RqRTOf7HrDN2ppx9x8rVaItn8SrrFqMBfMvpd3SPmO8lyL7R9PkpbHEj1BLSDrX3HwA2hurZTGm+PfSI5ofRo0ARWQSstPwBiYS8zS33pRzLQk9YY5xW2jPfMjr8+9cdCa8EoKNJ4j6kZbSEbFTQKKFTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vqNQ3tl+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=no5NPpruJ7gR5NFjQR7yt5YQiwB7OPEm759eMrpc4uo=; b=vqNQ3tl+9O42H3UYn8vJG1kEEb
	8xmpFD0bOHgQJ7Pan6SKA3LbDunfAWOHgmqAxrlCGozPD1s1WdeLb/UxNpZ/gXQTin+nsi/+V6J3M
	chRgMaftDzhDUw3ZSfdbVEChkXP8SVEV5Bk9EKXVjMSk7O1Hq+uEJ7jFhYLWxdUbETSfP9jUEgS9b
	GW8DDWsQSGiWTUsMnmC6S9TfbpKri93Vcd3Q0H4b0A/rwa77DHXKe5A501/nYr87S553bA/04FuqM
	FwnhvyyAZ7XFLV49WdUsX2zjFQ8WyelgDBzK/4lNhXZYwhlKGpT/SUHG5J5/6rAR6Ul05cmBsOMIo
	D8EOvQhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlbG-0000000AzYy-3EEE;
	Thu, 10 Jul 2025 07:21:46 +0000
Date: Thu, 10 Jul 2025 00:21:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3] NFS: Fixup allocation flags for nfsiod's __GFP_NORETRY
Message-ID: <aG9qCtldrjhqW-s7@infradead.org>
References: <f83ac1155a4bc670f2663959a7a068571e06afd9.1752111622.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83ac1155a4bc670f2663959a7a068571e06afd9.1752111622.git.bcodding@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 09, 2025 at 09:47:43PM -0400, Benjamin Coddington wrote:
> If the NFS client is doing writeback from a workqueue context, avoid using
> __GFP_NORETRY for allocations if the task has set PF_MEMALLOC_NOIO or
> PF_MEMALLOC_NOFS.  The combination of these flags makes memory allocation
> failures much more likely.

Can we take a step back and figre out why this blanket usage of
__GFP_NORETRY exists at all?


