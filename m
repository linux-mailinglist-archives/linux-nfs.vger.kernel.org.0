Return-Path: <linux-nfs+bounces-20606-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNKUBPH4zWmrjwYAu9opvQ
	(envelope-from <linux-nfs+bounces-20606-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:04:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6C383D5F
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CE6D3002F7A
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0C126BF1;
	Thu,  2 Apr 2026 05:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pRm30Ak+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BF1A681B;
	Thu,  2 Apr 2026 05:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106274; cv=none; b=PJPtm5xXaRwSxIY9CnlmDX1d6CGV2ewni8LR7uPT9AHRG/oXSHKRH6/TJyCdCstCrNXJimfd9cvNZHR57i7j7anwOkykHrjQsf1N/VRObNTXzR9WWs2gWySqjGXnGCoBPPk0b4he4BHAN47fl0E2Mp809YxFLBtOTqi+XZupDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106274; c=relaxed/simple;
	bh=qHaVVJcbhhys6SFB3R6XegUnjydo9F6y85Zqwp2/F+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpR4h4E/slD0Y5LwiOKaWo8YKNZeCWjqS3irJptxnZ/bj5rpCfKV64IWA40gG4rD9v22YWtLFW9GKIya1io5XpJbo/llv5L/gITATM6+Y4CreSQ0iTM7xC9mvqHfxL2y/VLzKFlohE+Vs66VXVXLRc27QyswpbBYlNrBGtrGw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pRm30Ak+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MHuWa9gjO/UjPCeuOgu73Q8GftjCDqIODtwfGH0CU/c=; b=pRm30Ak+86fJXgU4tJ9BbBzh/Y
	xusbtW4s9Ot4n28Nqik4KKRJeQVRcvO8Wrc19yRqD9dbKHkV/Q3jxmMDqu/Ct4TMt5U0LtQ7j/H6S
	6Xl3dNmhp+jrvblVQJ428GHvtGCcgv4Tt0QHGbgR5SQZwvfQfGwy/8x9uedTFymelVWzJoZLO0mYS
	tVm0Rj2uXjmKwB1eklUtZYcPrbJttAWwl+sHeuE2BlDPIqtJ9na10z8A0OSvK2Om0wm0AggTnTkv2
	J+L82XPS6+vwbYblSMVTtbWXXRErbPN8lsE7uZncbiC6BdyXelbneYa40p/mPxgHMSitnFlecxVx4
	A9t1wqxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8AEB-0000000Gn6i-1O9w;
	Thu, 02 Apr 2026 05:04:23 +0000
Date: Wed, 1 Apr 2026 22:04:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com,
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] nfs: make nfs_page pin-aware
Message-ID: <ac341x4RXKoShXsB@infradead.org>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-4-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401194501.2269200-4-praan@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20606-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0B6C383D5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This conversion really should go first as it is badly needed independent
of any P2P support.  And I wonder if it should go further - currently
the NFS I/O code is using folios for buffered I/O, but pages for direct
I/O, which makes larger I/O very inefficient.

The iov_iter_extract_bvecs wrapper allows to extract bvecs instead, which
might be a good choice here either by passing down the bvecs or
converting to an nfs_page inline.  Or just open coding a variant of
iov_iter_extract_bvecs that converts to nfs_page structures instead of
bvecs.  This would pair with a helper similar to __bio_release_pages on
the unlock side.

> +			req = nfs_page_create_from_page(dreq->ctx, pagevec[i], false,
>  							pgbase, pos, req_len);
>

A lot of this code reads pretty odd as it's overflowing the lines.


