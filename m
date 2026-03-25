Return-Path: <linux-nfs+bounces-20393-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN/eKbY0xGkAxQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20393-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 20:17:10 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3997332B1C5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 20:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4928030175E7
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 19:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D583537E0;
	Wed, 25 Mar 2026 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PXjNBZR7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890E1C84CB;
	Wed, 25 Mar 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466152; cv=none; b=t1eJhqjS12ytkO6oaNE+zbAAWqFpptNYyB0OxWujIRPNOH9O5P/8z4uyRpfG+rhLWSaCh9/8JUBspfkRGM3huy7O+uDXnnV7bL5nIVVj1Yu6lTqi+WhD/I8OOfqdb8lLJGG+w5H0L9xhrDIirwjUyCpIqux5DjhZDjK9Px6q0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466152; c=relaxed/simple;
	bh=C4P5kqlXZBwN8pvEi7dRsjH+Ubeb8VOuGcv8ZPBnTRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONXIZtMqVT6MTUg+HsjmkF2qzP3uM4b1EKyvEXEOD1SoeoggELiT+qxmTJMTChr1BVOSoxpNJXCjsXeOPlTQwttVwt/jCS3GRLhQpt9iZKojX4Sp4Ldxmyb8jsCUGIy8bIOqG9r6yCPmm30fU4txxnsX0HE80YbN8FRAH2eP3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PXjNBZR7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Ws0zxo76Oq8skurR4/Ct4jTfvOy+YmWkHbAMtBNRQw=; b=PXjNBZR7aTHA6Hz9FBJJqjN7Db
	wIRsfz3JuwEYANUB9AaDi11hn6nh6/M8Yt1u2lh7xZ74+k10CalBjr8MrK+Nrwx21n4+aIKk2lPhW
	ftJeYNMO2w0SOI46yedcw1nWwUzdRM7VeeL1Q4JkPGsR8iX3lFOynw+O8RZB1eESxJPw/e0kSAQ5O
	B2aZiC14kT+lKYFCczKzfaugpqeSu3M88yANRuxYn6kzyfKCynn3AJ6nAs+i7GXfgOEixHdNBEAd3
	+szXGpZFnv0gnrSxgaDNNjBGPuo9f3lOBbVoxNyvchKNAJNbxK3Bp2Oq/e0zo5Ry9iBIkvy4osERr
	wmEZlTjg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5Thh-0000000GQBU-13Lr;
	Wed, 25 Mar 2026 19:15:45 +0000
Date: Wed, 25 Mar 2026 19:15:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Rushil Patel <rushil.patel@gsacapital.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [RFC PATCH 0/1] mm/filemap: make writeback wait killable in
 __filemap_fdatawait_range()
Message-ID: <acQ0YRLM_SxYfjfI@casper.infradead.org>
References: <20260325113616.785496-1-rushil.patel@gsacapital.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325113616.785496-1-rushil.patel@gsacapital.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20393-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3997332B1C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:36:15AM +0000, Rushil Patel wrote:
> We run Slurm on compute nodes with NFS mounts (NFSv4.1, NetApp).
> When a job is cancelled, processes with dirty NFS pages get stuck
> in D-state inside folio_wait_bit_common() because
> __filemap_fdatawait_range() uses folio_wait_writeback(), which is
> TASK_UNINTERRUPTIBLE. If the filer is slow to respond these processes are
> unkillable - we've found the only recovery in practice is rebooting
> the node.

Hi Rushil.  Thanks for the patch!  I have a lot of sympathy for the
problem you're trying to solve.  It was something similar which led
to me introducing the TASK_KILLABLE infrastructure back in 2007.
My problem was read-only though, and while I had an initial attempt
to also handle write workloads, it didn't work and I didn't have a
personal need for it, so I abandoned it.  Now you have a real need, so
let's make it work.

> The patch switches to folio_wait_writeback_killable() so SIGKILL can
> interrupt the wait. Writeback itself continues on the server, we just stop
> waiting for the ack. All 6 callers of __filemap_fdatawait_range() detect
> errors independently via errseq_t / filemap_check_errors(), so the early
> return doesn't suppress error reporting.

Well ... I'm not entirely sure it doesn't suppress error reporting.
But I think I see what you're trying to say, and I think the change
of behaviour is one that was never guaranteed anyway.

> The tricky part is a re-entry through do_exit(). Making the wait killable
> alone isn't enough - we hit this in testing:
> 
>   1. SIGKILL wakes the killable wait, signal is consumed by get_signal()
>   2. do_exit() -> exit_signals() sets PF_EXITING
>   3. do_exit() -> exit_files() -> nfs4_file_flush() -> nfs_wb_all()
>      re-enters __filemap_fdatawait_range()
>   4. wants_signal() checks PF_EXITING *before* the SIGKILL special case
>      (kernel/signal.c:951 vs 954), so it returns false
>   5. No signal can wake the second wait -> stuck in D-state again

Yes, this was where I got stuck too!

> The PF_EXITING check at the top of the function avoids re-entering the
> wait entirely. This is the same pattern used in mm/oom_kill.c,
> mm/memcontrol.c, block/blk-ioc.c, and io_uring/.

I'm not entirely comfortable with the location of the check.  I feel
that __filemap_fdatawait_range() is a bit too low level for a check
of PF_EXITING.  I could see there being other places
which really do want to wait, even in the presence of an exiting task.
Maybe I'm being overly paranoid there, but I would suppress the call
from nfs_wb_all().  Maybe something like this?

-	ret = filemap_write_and_wait(inode->i_mapping);
+	if (current->flags & PF_EXITING)
+		ret = filemap_fdatawrite(inode->i_mapping);
+	else
+		ret = filemap_write_and_wait(inode->i_mapping);

What held me up from doing this though was the next part of
nfs_wb_all():

        ret = nfs_commit_inode(inode, FLUSH_SYNC);

I didn't trace through exactly what this would do, but I inferred from
the FLUSH_SYNC that it would also wait for the file server to finish
the write of the inode ...

> Reproduced with iptables DROP on port 2049, confirmed the killable-only
> revision gets stuck on re-entry, and the PF_EXITING + killable revision
> kills cleanly.

... but if your testing shows that it works, I must be mistaken about
that.

> Sending as RFC because this touches the generic writeback sync path in
> mm/filemap.c rather than being NFS-specific. NFS can't really fix this on
> its own - it reaches __filemap_fdatawait_range() through
> filemap_write_and_wait() and doesn't own the wait. But I wanted to get
> guidance on whether this is the right place for the fix, or if you'd prefer
> a different approach.

Appreciate your flexibillity on this ... sounds like you considered
doing it this way, but didn't know about filemap_fdatawrite()?

Anyway, adding the NFS people for their opinions.  Other filesystems
don't do this flush-on-close behaviour (for various reasons, but
basically NFS has a close-to-open consistency model).  I believe
we can break this guarantee in this case as it's not an orderly close
but an involuntary termination of the process.

