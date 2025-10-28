Return-Path: <linux-nfs+bounces-15741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583EC176D7
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 00:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571B81A2288C
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 23:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E3359F94;
	Tue, 28 Oct 2025 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/qwt0Xr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31593570A0
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695789; cv=none; b=jvCqAL5PrvT0jOZPSKMwc0N03QSPzr71V/QTYncDjsGBesekXJWMAu24HJSmqYU9ps76HehQc0rzVeMGpBpFNXk0dMcc8GPrXffJ0u11KzuygtMr4ippU9RBYpdg/sfTryMtN6ptD47IeN3K9ipJ3t/xL1Yx756siY6si8tZifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695789; c=relaxed/simple;
	bh=FsyasErvTji3bnd3dFdHf4hvsq8BITaavdB/BJq0BO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNsjP+vbu5B5vtZAQetjn+a05dIoe4VJjoyUUpa8mpXktN9nZ0y7pE872qrT8OcUBqHMzicVloo164bJiL5i61EM7miqAPiKSmsdYNQL0oF3tw3kobCQYDVlJ973UnHM0pM3Sa1hoIjB8fmcJdBJ8+JnX45V6k56p0rB5m/fSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/qwt0Xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B63C4CEFD;
	Tue, 28 Oct 2025 23:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761695789;
	bh=FsyasErvTji3bnd3dFdHf4hvsq8BITaavdB/BJq0BO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/qwt0XrwkP0pfMKgyKQ3KUJzjUvV30H3sWvNfsfBtBMcKkKh1OAQSblw5oDDmLYs
	 /ZK1ZYPEci9/DKslGyv+/vDRXRJ7Muwi6qh6FMR0wGw/P4nglIZxRnfEhZL3LvG97H
	 gOWCxDeZXXoRg8oZN50eGpd1PbCLwrdZbaCdHSu7ZfwYIa5iszRZ8Q6eCAuPwAVqsN
	 XTOJFckz7Y2Zv1eieXxr7S8Np/ck9qXBN0LRIJN5lzYwTJxUfHhZKjmRUpPPJ271iQ
	 eqaQ/2woCVo8poy5DW1T+5UPivRFQBPrGpDLLqpWHRQiKsME6R1uvOESSUZ5vEnjdJ
	 PVRy3EHQGyUSg==
Date: Tue, 28 Oct 2025 19:56:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQFYLKmC2Nr1QUrM@kernel.org>
References: <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
 <1f7b30d2-f806-400f-81d3-80b6c924c410@kernel.org>
 <aQDpjNnj47ISRItg@kernel.org>
 <b63ed4d4-8bbb-4794-ae07-64a4000e0ea9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b63ed4d4-8bbb-4794-ae07-64a4000e0ea9@kernel.org>

On Tue, Oct 28, 2025 at 02:48:33PM -0400, Chuck Lever wrote:
> On 10/28/25 12:04 PM, Mike Snitzer wrote:
> > I'm also concerned about initiating
> > any page cache invalidation off the back of the DIO WRITE in the
> > middle (and its potential to fallback to buffered if that invalidation
> > fails... any associated buffered IO fallback or ends best have O_DSYNC
> > set it ensure everything ondisk).
>
> My questions:

All good questions, and I appreciate the time you spent analyzing
these aspects.

I'm all for NFSD's IO modes being able to work with all possible
stable_how.  Your analysis helps expand the scope of these IO modes to
really be pushed to their limits (specifically thinking of
NFSD_IO_DIRECT being paired with UNSTABLE and it _not_ using
IOCB_DSYNC, interesting combo but IMO quite a risky default given
we're only at the debugfs interface stage for NFSD_IO_DIRECT).
 
> A. Which filesystem code can return -ENOTBLK?
> 
> - iomap-based DIO (fs/iomap/direct-io.c:715): XFS, ext4, f2fs, gfs2,
>   zonefs, erofs
> - Legacy DIO path (fs/direct-io.c:984): ext2, some ext4 code paths
> - btrfs (has its own DIO implementation that uses -ENOTBLK)
> 
> Code auditing shows that vfs_iocb_iter_write() never returns -ENOTBLK
> because all filesystems that could generate this error internally
> convert it to 0 or another error code before returning from their
> write_iter implementation.
> 
> Therefore NFSD itself does not need to know about or handle page cache
> invalidation failure.

OK, good to hear; but have you reviewed if they are all using D_SYNC
as part of their internal handling of their buffered fallback?  NFSD
setting DSYNC just acknowledges it is required to ensure O_DIRECT
WRITEs are ondisk upon return to client -- something I don't want to
leave to the client to ensure via NFS_UNSTABLE's subsequent COMMIT.

Setting O_DSYNC gives us a baseline where we don't leave some other
subsystem to ensure data gets to disk as quickly as possible (O_DSYNC
offers NFS_DATA_SYNC, but O_DSYNC|SYNC's NFS_FILE_SYNC offers a win by
avoiding COMMIT, even more enticing).

So I need NFSD_IO_DIRECT to be able to require IOCB_DSYNC and possibly
IOCB_DSYNC|IOCB_SYNC.  And I'm most comfortable with the misaligned
DIO WRITE support using O_DSYNC for all 3 segments; so that WRITE's
data is ondisk before returning from the WRITE (NFS_DATA_SYNC), and
bonus if we can avoid extra COMMIT (NFS_FILE_SYNC).

> B. Even if NFSD had to recover from a failed page cache invalidation,
>    does a fallback write need to set IOCB_DSYNC (not considering the NFS
>    protocol requirements) ?
> 
> When invalidation fails, some pages remain in the cache (dirty or with
> private data). The buffered fallback writes to those same pages,
> updating them with the correct data. There's no torn state or corruption
> hazard.
> 
> The fallback restarts the entire write from scratch, as buffered. Any
> partial progress (like a buffered first segment) gets rewritten with
> the same data. No orphaned blocks or inconsistent state.
> 
> If another process does a DIO read of this region, it will call
> kiocb_write_and_wait() first (see mm/filemap.c:2912), which flushes any
> dirty pages before reading. So they'll see correct data even if it's
> still dirty in cache (Jeff's concern).

Yes, but the point is there is extra work that involves the page
cache by other layers.  And O_DIRECT is intended to work expecting the
IO has been flushed to disk.  O_DIRECT is aiming to reduce page cache
usage, to keep memory use low.  So ensuring the page cache invalidated
to disk by the subsequent write as a side-efffect of O_DSYNC helps
(more on this below [0]).

> C. When setting up a three-segment write, is IOCB_DSYNC needed on the
>    unaligned ends (not considering the NFS protocol requirements) ?
> 
> Before writing the DIO middle segment, the VFS must first invalidate the
> page cache, so the first (buffered) segment is flushed to durability
> anyway. The use of IOCB_DSYNC for the first segment is superfluous.

No, the first segment reflects the misaligned head of the WRITE. The
DIO-aligned middle segment's DIO will just invalidate pages aligned on
the middle segment's alignment (which is page aligned).  So the DIO
from the middle segment won't have any side-effect on the first
segment's page.  First page needs to be written out with IOCB_DSYNC.

> After writing the DIO middle segment, the unaligned end remains only in
> the page cache if IOCB_DSYNC is not used. But a subsequent DIO read will
> flush that to durability (via kiocb_write_and_wait) before satisfying
> the read. So, IOCB_DSYNC is not needed there to meet putative file data
> visibility mandates.

The same applies to both the misaligned first (head) and third (tail)
segments, they both need O_DSYNC to ensure their contents are ondisk.

[0]: Again, my goal for NFSD_IO_DIRECT is to operate in terms of
O_DIRECT|O_DSYNC ondisk.. and not lean on the page cache more than
needed. This makes the VM subsystem more scalable as a side-effect of
it having more clean pages that are quickly dropped and/or reused if
something needs memory.

> >> As I understand it, IOCB_DSYNC has nothing to do with whether the three
> >> segments are directed to the correct file offsets. Serially initiating
> >> the writes with the same iocb should be sufficient to ensure
> >> correctness.
> > 
> > IOCB_DSYNC just ensures when they complete they are on-disk.  And any
> > failure of, or short WRITE, is trapped and immediate cause for early
> > return.  Whereby ensuring file offset integrity.
> 
> AFAICT, generic_perform_write() updates ki_pos synchronously whenever
> it returns successfully, regardless of the IOCB_DSYNC or IOCB_DIRECT
> flag settings. If the vfs_iocb_iter_write() call fails or returns fewer
> bytes than expected, the loop terminates immediately and writes to
> subsequent segments are not initiated. I don't see a data integrity
> issue here.

For ki_pos we're saying the same thing: yes ki_pos is updated (and
it'll reflect a short write if one happens, etc). IOCB_DSYNC doesn't
influence if ki_pos is advanced. But if IOCB_DSYNC isn't set then
ki_pos is advanced beyond what was written _to disk_. That obviously
doesn't matter if NFS_UNSTABLE, thanks to its COMMIT, but it does
increase latency (though it is worth benchmarking with various
workloads!).

Anyway, I've been working to ensure NFSD_IO_DIRECT acts as if at least
NFS_DATA_SYNC, but preferably NFS_FILE_SYNC, set.  I should have more  
clearly stated that.  Bypassing all caches as much possible allows for
enabling scalable cache coherence, e.g. intelligent applications that
don't rely on file locking, think multiple writers writing to their
own extent of a large file.

Having NFSD_IO_DIRECT be handled as UNSTABLE isn't adequate for my
needs (immediate ondisk requirements, lowest memory and CPU usage as
possible).  Would you be OK with adding 2 new debugfs knobs?:

/sys/kernel/debug/nfsd/io_cache_read_stable_how
/sys/kernel/debug/nfsd/io_cache_write_stable_how

- Each defaults to using the stable_how that the client requested.

- Each will serve as a floor, and only override default if they are
  greater/stricter than the client requested stable_how. (so if
  'io_cache_write_stable_how' set to NFS_FILE_SYNC it'd override
  client specified UNSTABLE).

- Each can override the stable_how used so each IO mode behaves
  accordingly (e.g. I can set NFSD_IO_DIRECT and NFS_FILE_SYNC to get
  the bahviour I'd like).

> Thus I'm still unconvinced that IOCB_DSYNC is required if the client has
> requested an UNSTABLE write. I'm open to reviewing actual evidence of a
> failure mode where IOCB_DSYNC might prevent data corruption, but so far
> I don't see how it can happen.

Yeah, I see your point now.  If io_cache_{read,write}_stable_how
debugfs controls are acceptable to you it'll give us maximum
flexibility for controlling how NFSD behaves in each NFSD_IO mode.

Thanks.
Mike

