Return-Path: <linux-nfs+bounces-20610-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNuJMFH+zWnJkAYAu9opvQ
	(envelope-from <linux-nfs+bounces-20610-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:27:45 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B0383FC5
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 07:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C135304297C
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 05:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D5136213E;
	Thu,  2 Apr 2026 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="306nTQxK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713213A3F7;
	Thu,  2 Apr 2026 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775107662; cv=none; b=tUBbhEAGiDid0U/BvzwqCiefQyCvK4LqEPHOrZ+O0p0LzUgJpWilnjPPzy7LYSuv4+FbeVvrrfTPFE+aKN70wZfbruAhf1R3xDQs7PG1pgbbrh1q0MKgHTEOxvEEbVKjlwfTLGmo//g8cudA3b20T0qYuEOVNWSDo3wRqiN+QNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775107662; c=relaxed/simple;
	bh=KVzc5Y4yY/a61Dy2hPfi75/L2WCjuKSNhOVB+/7Xd9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS+p42nOZYo5KbS3Rho/dy9JvgWzGYq2Gn6O+sR9YN2dH9rL81jBp/2mzhJTn2xg9WgFAREWZz+5rv+ft7KLanp+46/rekSNhaJcMfcc5bHZhMghwVsv1p5PCOa71Nz51QLgpvEr0HKqWr/az7SQwQNkvnxe0rN1KzknjBPlCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=306nTQxK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+zTGBJY6hQ0zMeJQBjpowApqHyqRrKXxjo6V6st3wsk=; b=306nTQxKHjO9BgmuzmqBLF66EF
	XXR1rQ0dxmCenfIox2XxXf+dRDdKc1Z7KezTOEOH1pHmE/6O6Zh2xcMC1GEFPWHjsBhaKWvPiJAOS
	lyyNV3mNqLy21C8nIk+h2JwGYGwE3TRRiUdPcgzkim6RrLvWR8r74qHQN2dEtV5NHQKH80G0SDQfN
	6WimEMBvKdCChiBBB+RKN7Zogiw7RjkFFQzezFLrRXGIEQCStmGGlR4lUKrkXx1gmVTxsm0TOgjCf
	5/UYFUr4t6hYh7DtA4vQ+MWaEUXKtptcrhb5bvTjEE0Ul0/pzJCWNEjOkxZ1cTA2RT0oocNCeAiT7
	7rsOiudg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Aaf-0000000GoIg-1hFS;
	Thu, 02 Apr 2026 05:27:37 +0000
Date: Wed, 1 Apr 2026 22:27:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <msnitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm: add atomic flush guard for IOCB_DONTCACHE
 writeback
Message-ID: <ac3-SU7BElHJVCEL@infradead.org>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org>
 <20260401-dontcache-v1-2-1f5746fab47a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401-dontcache-v1-2-1f5746fab47a@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20610-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 3A7B0383FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 03:10:59PM -0400, Jeff Layton wrote:
> When the PAGECACHE_TAG_WRITEBACK tag clears after a round of writeback
> completes, all concurrent IOCB_DONTCACHE writers see the tag clear
> simultaneously and submit proportional flushes at once — a thundering
> herd that causes p99.9 tail latency spikes.
> 
> Add an AS_DONTCACHE_FLUSHING flag to the address_space and use
> test_and_set_bit() to ensure at most one IOCB_DONTCACHE writer
> flushes at a time.  Other writers that find the bit set skip their
> flush entirely.  The bit is cleared when the flush completes.

This sounds like a bad reimplementation of the single writeback thread
:)

Have you considered stopping to do in-caller writeback for
IOCB_DONTCACHE vs just leaving it to the writeback daeon?

Either by totally disabling the writeback and just leaving the
dropbehind bit, or by queuing up wb_writeback_work instances for
the ranges, or by just increasing the pressure for the writeback
daemon.  Note that with all schemes including the one in this patch
we might eventually run into writeback scalability limits, which
will require multiple writeback workers.


