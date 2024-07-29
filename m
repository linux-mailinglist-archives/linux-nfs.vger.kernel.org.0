Return-Path: <linux-nfs+bounces-5149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CB93F91A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AC21F22264
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5D0155725;
	Mon, 29 Jul 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hTrMSXF7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF4156227
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265711; cv=none; b=dJSXNX8MuAw/Ob6AiM1RTzn5aQdrUAixR85rvKkHUcjSgmOHjVWsCgPfctxqXEKZTuD9PlCQFHTpwvCAuj77D0np//XQDaevuBip4W5jX5wG2yli//K6H5/Moz2iNUCFjzEbA3cCuIGn0EWl2pjfbJT5mfG1qN6QvI58rO4xSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265711; c=relaxed/simple;
	bh=tER4iAqe4m94f95rN/Vu1N8GsrRM1W/96IBrPSD8HYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVVHfmj4XZoNKVZDUCbbwpqMjU8JmPzHbJHM2HdSoYR5qzSB4kUMZAAsPcsQOOhHCYEwbPBgPMCmEUvxoI3ZEhXTMyWJzLpV2w2iLRmrnJWaN6kheE7w/v9fUVutpNAme8LHCmGAS+DPRiG8C0qscxXga3FnU+for4Aqf/B0aPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hTrMSXF7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s6vrNOhJXSGNrBMI2tqx98ZU5zoWMj1SB90mwIXLJvY=; b=hTrMSXF7Qv5rZ74zqeAVQu+eyC
	pouwR8Lzc3VPGsPmGdB706VVJmej+Yrft/TCVHrKBkgUiukedDXClfc1wd1tBKh0UJPl2daygNXnN
	nG7oSY35m6FAvztYFrtO+GZCMZ5ks+Q0jaDTP1NLCwZxCsKeTt4qell4elmlZITMWcl8mgDfiSfOs
	tUQIIup9bZSrala+MhkZlywM0a/hG4LfdrXp7sFVKvbT49qNyMQ1jeELA/kNKBf7MwW3SqS0rLrdD
	FRfYXGT0g1EJK97CZ/JaJlIyroU+px440TieciS1ZRcKEsC4KcY4+/ir/25HyUDJtEFdigCAYvSIQ
	hHr1KUEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYRzB-0000000BoWz-2w3S;
	Mon, 29 Jul 2024 15:08:29 +0000
Date: Mon, 29 Jul 2024 08:08:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Aloni <dan.aloni@vastdata.com>
Cc: anna@kernel.org, linux-nfs@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nfs: add 'noalignwrite' option for lock-less 'lost
 writes' prevention
Message-ID: <ZqewbefiA_Duy_gz@infradead.org>
References: <20240724110712.2600130-1-dan.aloni@vastdata.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724110712.2600130-1-dan.aloni@vastdata.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

As mentioned last time my preference would still be if NFS did not
do this weird extension by default.  But given that Trond like it
I suspect I'm unlikely to get that, so at least having an option
is a good thing:

Reviewed-by: Christoph Hellwig <hch@lst.de>


