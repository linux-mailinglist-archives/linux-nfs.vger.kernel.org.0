Return-Path: <linux-nfs+bounces-20793-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHq3I1a212lURwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20793-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 16:23:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBE3CBF55
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ABC0300B639
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE773C2791;
	Thu,  9 Apr 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oekmWysY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418F53B583E;
	Thu,  9 Apr 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744508; cv=none; b=L43WjcLfSUrTuEd2rOBvQ8mjNcRLOV4QCAcIt6Nf0Jk8c3SxVek6rbnJMNO0KpSWwew5jz0CdR3e3u5I0uhai1N/kKO8nHQ4rPO12FONirvtFxLbtQrXe6nPMqAUSpWM7x2mMHm0dMKasBhbB1LB+UfYeQpetpKaZKGIosFEpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744508; c=relaxed/simple;
	bh=KdI0AAIKXXq/sviYn1Y35plnhBxX8MDqftaLPVtTFvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAlqeiUxbBMCVuG1ZEngyVhS+iTa79BPOz+WNiiojt+b6FE1GytYtCOaKb35Uvl9jDJiRPFzr9yUjNocBdcRRYjKSCiVkgNJDGR9bFHCu5M8U1jE/wlm1H7MnQfpcFYeW3/xny2ans3DzKJwcAqEE046hygWmmcuvDelKcd9HGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oekmWysY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AXd7Pgrw236phRDb4BUy2CY5/uYF1kqf7t0zPf4iggE=; b=oekmWysY0YtMv6PRwb3tb7EfZ5
	FPdgB9Ion+gg5IECBzJHFaETbhF8z/KXCsS19UFElbUYttxXwl1T+y7bO7fPby4sniGIAVz9uSqg5
	c4mFdGpGQ+tntp+RUbQVhaRCaCxQpQTO+my4kDbEUMVHmTc+v7VSiJWvji0wqfm+s0iMP3HQsdvYZ
	Xo0AXa6nOnf5nUqvpTf9KqQYeFDP7IsYTmfJb9UY3dgxJzdN6FNk7B7g+4aOm+VG4kMcqfSTZzPqU
	/+Cv5Ch7yl1d1LRsdbwsPhZHDnGV2UqjB/9MqBOFQ56ukeTyWu7rAHLv/oTFES9Ni7BPzMC/Ti7bN
	p/jcoRfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqG2-0000000AgGR-2cnH;
	Thu, 09 Apr 2026 14:21:22 +0000
Date: Thu, 9 Apr 2026 07:21:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: kick writeback flusher instead of inline
 flush for IOCB_DONTCACHE
Message-ID: <ade14lOI1CDiraar@infradead.org>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
 <20260408-dontcache-v2-1-948dec1e756b@kernel.org>
 <adc-Q1iDWHD5yxHH@infradead.org>
 <gpcc6t5unsoepakjdffsmnmd5duuvijxwdochd753ttix75h7l@nahwzi4qfdcq>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gpcc6t5unsoepakjdffsmnmd5duuvijxwdochd753ttix75h7l@nahwzi4qfdcq>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20793-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Queue-Id: 0EEBE3CBF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 09:21:36AM +0200, Jan Kara wrote:
> > So I think you'll want a new WB_start_dontcache bit, a new
> > get_nr_dontcache_pages() helper on a new node counter, etc.
> 
> But I'm not sure how you imagine this would work without restricting
> writeback to particular inodes. Maybe we could mark inodes which have
> folios with dropbehind set and make flush worker only write such inodes?

I'd only expedite writing by the number of pending dontcache folios.
It would still write the least recently dirtied inodes.


