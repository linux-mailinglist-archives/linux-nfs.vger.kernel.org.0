Return-Path: <linux-nfs+bounces-20788-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGc6LJhB12npLwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20788-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 08:05:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4E63C66EB
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 08:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79AE1300A306
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 06:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863942EA749;
	Thu,  9 Apr 2026 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtKfG8SF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FF1D86DC;
	Thu,  9 Apr 2026 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714709; cv=none; b=GmwztqMae9WS/FXpJuh4XD8SxpgjG7NEzld+tIHDVXi8kqNBiEYGBa5Duo/PlgWHwwva+F7Sz+y/ccluH+3r3skxAF+grcNuJ4OpK7guTDAYYeEMKLQRRTZ/7cSy0HzSytgV+zPD47IKKjj5uEybuiL/zWNnh66VmGCVedwZksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714709; c=relaxed/simple;
	bh=1flq5K7qixWu3/FLHv+xBNXDXhdDmYjb6Sv5he21cO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSlOCLUXxqKtHRMlZ/hh7i7O1P/9lUrOpKePOLjtfJzYocRcn8VouSckiBQ0bqqmcQRvnjIDz1MYSsLTwTmowFCG/YWDuPW3rNRWEyrSB/PjAEwUmWlpDBiQnmCc3+FhEG5db2ABH2yGJV48/gr0wTtBoqBTrKMylZ1AciodMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AtKfG8SF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AlV9liKL29iVcevggKbEsekSMq0e9B72XQq7jVOP77w=; b=AtKfG8SF+GOpLQVks541I23xk8
	Jpw1TpCf+jyW9IuOTTRYwESlrdcriGzdqP/Je4yt9s/xW/Xe4TWRp2hA+He1BTrnaW9i9AiGAvt2o
	LdUC+04nNVFD8owoOn5OnBDJ/ApS///2c7nj5dOFMItqFSIBY0/MvWzf3XuHBWrRuBDp+kUP8AwJL
	HerB3KzfL3ffVOH9OGbGZal0MknBJGWj3DC/u+1tLRImR5USjaq9TRZapmbRmdaf9d/La2VjyIpVa
	3190R3KMqOVohQCkbfIxJAOebBKO/Bpgo5+dqCc0XtQ3Iu74heVJu0eBuBRWawZ4xjURboKUZbOwn
	x8AecBAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiVk-00000009k06-27Kc;
	Thu, 09 Apr 2026 06:05:04 +0000
Date: Wed, 8 Apr 2026 23:05:04 -0700
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
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] mm: improve write performance with RWF_DONTCACHE
Message-ID: <addBkBKySJUb8MB4@infradead.org>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-dontcache-v2-0-948dec1e756b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20788-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,markdownpastebin.com:url]
X-Rspamd-Queue-Id: 4A4E63C66EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 10:25:20AM -0400, Jeff Layton wrote:
> This version adopts Christoph's suggest to have generic_write_sync()
> kick the flusher thread for the superblock instead of initiating
> writeback directly. This seems to perform as well or better in most
> cases than doing the writeback directly.
> 
> Here are results on XFS, both local and exported via knfsd:
> 
>     nfsd: https://markdownpastebin.com/?id=1884b9487c404ff4b7094ed41cc48f05
>     xfs: https://markdownpastebin.com/?id=3c6b262182184b25b7d58fb211374475

Please add the results into the patch.  Besides having them in the patch
vs the cover letter, URLs to random hosting sites tend to get stale
very easily.

Comments on the XFS numbers / benchmark setup:

How does O_DIRECT manage to create almost the same peek dirty as
buffered?  Similarly even this patched doncache show be lower, which
feels odd.

(the editorializing in these results feels odd, not sure what tool
generates them, but maybe edit it for the commit log to look a bit more
serious).

Given that this patch does not change the read path, how do the pure read
numbers for patches vs unpatched dontcache manage to differ so much?

Comments on the NFSD numbers / benchmark setup:

I though you were testing using dontcache on the server, but the
comments seem to imply it is done on the client, what is the case
here? 

Again, the read changes between patches and unpatched look suspect.
Please drill down why they happen, the fact that patches is slower here
and faster in XFS makes me wonder if the results might just be very
volatile?


