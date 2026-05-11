Return-Path: <linux-nfs+bounces-21462-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJCyNk3XAWryjwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21462-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 15:19:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6450EBEB
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 15:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A8463061EB8
	for <lists+linux-nfs@lfdr.de>; Mon, 11 May 2026 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CF3B19AA;
	Mon, 11 May 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMnpmT/V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253313A1CE6;
	Mon, 11 May 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505056; cv=none; b=hC/us9Ym7UFi5hiLI52/6ml2vUfhFKE4s3LWgt9Vz/JAQvSKJYf7AzBiDvGtYqFbSQ1XJX8o5qDHeYVy4cow2GEFYsuQo8MLh0viMWZQy9CbRwK/pYTWIqEamQMQPI+naL3y3yN/+g5FfXAey98JgdELhtDyaSJd2CnHcEjgJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505056; c=relaxed/simple;
	bh=4IYVrNKfE39U89Ai1am7hQrNp3oZrSkOKSpVaaJ9FHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL9e9+IbuKVwU03GzWrtWC1oaWAG0Ra9Dj9pHQ/JQcHPZ2vsOUjDwjnaSMmMdb9b2G9EZp+YN8bbx8Ncr5ddgEilTw+KcqiWYUfseJd58BqSVNinUdg2y3FEuut8J1TEsKirmGpa8bCNu7RRX9W5tpuG6lSD0Kv2hF5LvDUOq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMnpmT/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C94C2BCB0;
	Mon, 11 May 2026 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778505055;
	bh=4IYVrNKfE39U89Ai1am7hQrNp3oZrSkOKSpVaaJ9FHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMnpmT/V2PuDt0NDeDkforyAcO0RMZPjHSRKnOws709em/Jb/gowlrPf93S7rRuX3
	 f7yaT3abzvoNxzcKAll65O+Ef+pqonipYp5MT2DuTOJ1cuBhPx9eZs6fQTq6KWD1Ch
	 qgeilxQb1Yy2/AZzjHtP2j1v0Azgs6bFqIMag3mqJp2FG8mT5sQry+Bx/HJHhLo9be
	 Crc3MLAxSWIab99jPnKD1FYEzXlJl7/VWIXNjt4iqOLqnTuQbOGZO4/7oURsSCSM6A
	 vmpHG1yN49ZletrxibcP/RcjqVl8gwawBPH4AZayBFHBnHJV/qodQCVkB9cZq3GlTB
	 8sqgrszeg9sCA==
Date: Mon, 11 May 2026 15:10:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v7 2/3] mm: track DONTCACHE dirty pages per bdi_writeback
Message-ID: <20260511-begonnen-zuwege-b4272b78eb00@brauner>
References: <20260511-dontcache-v7-0-2848ddce8090@kernel.org>
 <20260511-dontcache-v7-2-2848ddce8090@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511-dontcache-v7-2-2848ddce8090@kernel.org>
X-Rspamd-Queue-Id: 34A6450EBEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21462-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,infradead.org,linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:58:28AM -0400, Jeff Layton wrote:
> Add a per-wb WB_DONTCACHE_DIRTY counter that tracks the number of dirty
> pages with the dropbehind flag set (i.e., pages dirtied via RWF_DONTCACHE
> writes).
> 
> Increment the counter alongside WB_RECLAIMABLE in folio_account_dirtied()
> when the folio has the dropbehind flag set, and decrement it in
> folio_clear_dirty_for_io() and folio_account_cleaned(). Also decrement it
> when a non-DONTCACHE lookup atomically clears the dropbehind flag on a
> dirty folio in __filemap_get_folio_mpol(), using folio_test_clear_dropbehind()
> to prevent concurrent lookups from double-decrementing the counter, and
> guarding the decrement with mapping_can_writeback() to match the increment
> path.
> 
> Transfer the counter alongside WB_RECLAIMABLE in inode_do_switch_wbs() so
> that the stat is properly migrated when an inode switches cgroup writeback
> domains.
> 
> The counter will be used by the writeback flusher to determine how many
> pages to write back when expediting writeback for IOCB_DONTCACHE writes,
> without flushing the entire BDI's dirty pages.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Assisted-by: Claude:claude-opus-4-6

Picking up on something we discussed at LSFMM in one of the sessions as
an aside rant: I find these AI Assisted-by tags so useless tbh and just
pure noise in the git log _especially_ for a core developer like Jeff
that I really don't see the point of them and I'm always tempted to just
remove the tags when I apply. I have dropped them before because I found
them so pointless.

Crediting Jan here is the right thing to do and it provides actual value
and also just makes sure that a real person who spent time helping out
gets visibility in the git history. Why we should extend the same
courtesy to automated tooling is really beyond me. Somehow we've become
all convinced that these tools require a special status but have spent
months arguing about the usefulness of other tags.

