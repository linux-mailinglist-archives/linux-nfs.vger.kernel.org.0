Return-Path: <linux-nfs+bounces-20607-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ49Fn35zWkdkAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20607-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:07:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0439383DA4
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D24E3029784
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 05:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B431715B;
	Thu,  2 Apr 2026 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PGAw8ToE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E527FB35;
	Thu,  2 Apr 2026 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106344; cv=none; b=Uz7Qz8vWznmkqQ1O3TySKfoeHNFz3P0exmR7or+aCs0uExdOqfYy47kaMsGkRmjzERJ7VA23Bf/oXTtrodk2pVtXqK+vn0oDAPUqIy9SLKaIquajk1gEY/rwhPAFcbB5RQ4149n9sT2xd2Tm27Z719kGnTvTO6zmGSkMFtINuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106344; c=relaxed/simple;
	bh=WrmP4xeitwaKkiK20UoChpSUaMTop6qzPNxEiPcXA7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPIOmRv11ROW6xwBsOtDLfIgOtHz9ULIXT9TaCvvbpyEKqyjScOkGmGDhqczcps7dtWYGKAZgZOfeyIDEWif5vGtCujYCfaLsWvx8mxqTIfS6DzCTj9zXSxdeMDgHsgIb5B9olRtlNWh5bZLpFYfOpGagTBvkrLa+yuwVlJpsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PGAw8ToE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KHrQDLTxrZsF/4RAZbeKe9eCtH4wciflhWZFWGPkUH4=; b=PGAw8ToEYuMge9U2EGmcvROZ6g
	iMSIKpljCOcbCdPTgWjkxQlXP9VgMWw1WPI8v6AMYPXZPY1TMpJlWT/obu8prrqvX81M+QSpAWgNk
	aY5P6wvRrFfmliTvTE5s/0dx7YurnLmFHZBTO+umln+UXW/hJU6+kvO0vDJYrKiAiz4BcsqRoKyd0
	4/bxOD1j5Wb5480eAuv4BbPYT2IUmmowbqTQVwSv7xHJWtikjYfjE5sWt68sl8A3cMCLCbNSn37jZ
	X29rTpulNrUC2pKo6pFmIKdRpBlUL3bn+G0zXxJN2NZ5nSP1jdt1hXeNI86QOGissn5HlxTcBnGLa
	bmG2t8OA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8AFM-0000000Gn9Y-0yDk;
	Thu, 02 Apr 2026 05:05:36 +0000
Date: Wed, 1 Apr 2026 22:05:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com,
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] nfs: allow P2PDMA in direct I/O path
Message-ID: <ac35ICYHuw4lEOri@infradead.org>
References: <20260401194501.2269200-1-praan@google.com>
 <20260401194501.2269200-5-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401194501.2269200-5-praan@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20607-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: F0439383DA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 07:45:00PM +0000, Pranjal Shrivastava wrote:
> Migrate the NFS Direct I/O path from the legacy iov_iter_get_pages_alloc2()
> API to the modern iov_iter_extract_pages() API. This migration enables
> support for PCI Peer-to-Peer DMA (P2PDMA) by allowing the setting the
> ITER_ALLOW_P2PDMA flag.
> 
> Pass ITER_ALLOW_P2PDMA to iov_iter_extract_pages() only if the local
> mount indicates support via the NFS_CAP_P2PDMA capability bit (detected
> at mount time for RDMA transports).

Please split theconversion to iov_iter_extract_pages into a separate
preparation patch, and even series.  That is a long overdue change
that fixes potential data corruption in XFS.


