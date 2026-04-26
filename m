Return-Path: <linux-nfs+bounces-21111-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0fJLB0557mlpuQAAu9opvQ
	(envelope-from <linux-nfs+bounces-21111-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 22:45:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DDC46B1B7
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 22:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22FFE3008742
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FEB390208;
	Sun, 26 Apr 2026 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4pLnzvZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B538F620;
	Sun, 26 Apr 2026 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236297; cv=none; b=IvE32w302fzl0vQZ3fFvGivnWFoyMalACRoI1qr3mBSfQ0p9wLKaNqKY4fhSF5PLkjKGaGDi8QraKnBD4klRrPe51xPUCONHTyIQBCNOgy3zfksmyDe2zrpzkC6cgDKTMg2uvuyd5b0LwgvHr9vXOq+pu/mUXK6X10Qtv5ETEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236297; c=relaxed/simple;
	bh=A4cX4SCoQqheLqNNtb4gR1vv39pWcfx9UbYePfIDCiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmQusQCtFnF6XU4vGnaPgtymaPxFtCf/orpBqkd14NGjmuYnGSmnx4QSyZZ72Mpyj9vHibkWosuWkGt5hbKTdmuE9y+zeWPybodoL3xQqVL3awkxNGtD9byVRcSG2HbW6p1nm94AJU3cArO0dk53BiDVidcjAoUbbnDgZIWONCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S4pLnzvZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I/fTyPP7bqTqt5fNYUoxgKpJh1vpEuR3aFaCVhySFZA=; b=S4pLnzvZn8wrgvL75yH/njOHFS
	qi3So9o5mDIDheJ6DeCD+gLAKuPaApFP2a8iw+bbRYYCoD/CnPn4F/8/qF9X0VR82yMqoVLxjrGXD
	TJeQqJOfcmOUSNfU3NU4CENu6sp4ZXRaXpZAhne0g/1iAKHtEthPIWv7t8ZaiUYqynOAJAElxhNWZ
	xEfa8BbC6KdRILxUzJq1iyPFoHLd/DVKd4aDMy+TQq7ZRG161vtP/TDWWUAV4n7Q/AaBcDJxsR6C8
	LjDHkjlkKkPE5BdVjJlG2EGpbcUcbDhERYKOxZ5FbtGCS/ZPdO1ogRAMxRRB8lLq9Vn0ntAHBRU81
	GOxj8lHw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wH6LD-00000000zSI-3g9m;
	Sun, 26 Apr 2026 20:44:35 +0000
Date: Sun, 26 Apr 2026 21:44:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE
 with targeted dirty tracking
Message-ID: <ae55M8xBIVYZXPFN@casper.infradead.org>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
 <20260426-dontcache-v3-2-79eb37da9547@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dontcache-v3-2-79eb37da9547@kernel.org>
X-Rspamd-Queue-Id: 41DDC46B1B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21111-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,linux-foundation.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,infradead.org,tencent.com,linux.dev,goodmis.org,efficios.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,casper.infradead.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, Apr 26, 2026 at 07:56:08AM -0400, Jeff Layton wrote:
>   Mixed-mode noisy neighbor (dontcache writer + buffered readers):
>                        baseline    patched     change
>   writer (MB/s)         1297.6     1471.1     +13.4%
>   readers avg (MB/s)     855.0      462.4     -45.9%

hm.  This wasn't what I thought of when I thought of "noisy neighbour".
I'd have process A doing DONTCACHE writes to file A and process B doing
normal buffered writes to file B.


