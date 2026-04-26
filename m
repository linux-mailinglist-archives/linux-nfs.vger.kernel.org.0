Return-Path: <linux-nfs+bounces-21106-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NdctJHcG7ml+qAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21106-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 14:35:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25B469CC8
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 14:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF9883013690
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Apr 2026 12:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B37835E92B;
	Sun, 26 Apr 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fcxiKN5r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85F3542D1;
	Sun, 26 Apr 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777206897; cv=none; b=oj/dyvOGs1S7LSqFmijCej1+xihp5B4Awi9IEcFSbiDd8migEQ3Y1RL4/ByZTzb+5a4CFB9wciousDwG0t1WWfrNJdOLWw9dP3O7gsKQtlUqk3iAOw3K3lhIULmzanRmt+MCdLFZWi1XxWnqbAo+2N5aWX7i0uEqZ+j3NE+mhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777206897; c=relaxed/simple;
	bh=BaSaKLFcdJ+SYi5Kybvkce1qiCJ+Moij9HYFUQ8DY2M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M7gzCUafmyNDMFOpUhoZKUCWPHIwwyS6WDdrSHfIR7N2//6shi1eWyG+Nf3U3MGZtEcf3SQxC7aAv1vRq+LfKZx/iByQwzc/yrRfe133q3jVcklacbZpV8VBMDNQG0L5cU+EAx+wfoNddPno0p9mEL/3xnMkii1jpdQOfk4yLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fcxiKN5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA71C2BCAF;
	Sun, 26 Apr 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777206897;
	bh=BaSaKLFcdJ+SYi5Kybvkce1qiCJ+Moij9HYFUQ8DY2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fcxiKN5rSz+bLNRnfPlWCVNiwZdMQHiXq8jp8dmXPVZ5kTaH+NOl8+71ePWUnWN0e
	 NhdjG8fmfRLFCbhVLPF3TELHbG/hLx18MhzGBq8F46N2vsuUCITTWM2BtUNoU67RoD
	 /6H+5HN+eQBtHXsXcG41Yhd5rrZtFQ4pe8eZPsCs=
Date: Sun, 26 Apr 2026 05:34:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Mike
 Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ritesh Harjani
 <ritesh.list@gmail.com>, Christoph Hellwig <hch@infradead.org>, Kairui Song
 <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] testing: add nfsd-io-bench NFS server benchmark
 suite
Message-Id: <20260426053455.4c06140446976964e6fbb8ab@linux-foundation.org>
In-Reply-To: <20260426-dontcache-v3-3-79eb37da9547@kernel.org>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org>
	<20260426-dontcache-v3-3-79eb37da9547@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA25B469CC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21106-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,tencent.com,linux.dev,goodmis.org,efficios.com,vger.kernel.org,kvack.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]

On Sun, 26 Apr 2026 07:56:09 -0400 Jeff Layton <jlayton@kernel.org> wrote:

> Add a benchmark suite for testing NFSD I/O mode performance using fio
> with the libnfs backend against an NFS server on localhost.  Tests
> buffered, dontcache, and direct I/O modes via NFSD debugfs controls.
> 
> Includes:
>  - fio job files for sequential/random read/write, multi-writer,
>    noisy-neighbor, and latency-sensitive reader workloads
>  - run-benchmarks.sh: orchestrates test matrix with mode switching
>  - parse-results.sh: extracts metrics from fio JSON output
>  - setup-server.sh: configures NFS export for testing
> 
> Assisted-by: Claude:claude-opus-4-6

OK, question.

>  10 files changed, 1024 insertions(+)

Seems that this code was largely machine-generated.  So I assume that
you're in possession of the scripts/prompts/whatever which were used to
generate this code.

(Can you please briefly describe the process which you used here?)

So how are we to maintain this?  Will other developers have to go in
and hack this machine-generated output by hand?  Or would it be better
to provide (in-tree) other developers with the means to regenerate this code,
presumably using Claude?

IOW, this feels a bit like shipping the .s file without giving us the .c
file!

