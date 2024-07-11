Return-Path: <linux-nfs+bounces-4809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF892E7B6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 13:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF091C21540
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091BD15F410;
	Thu, 11 Jul 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XcVgRhxj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624815F407
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698907; cv=none; b=JjV3IXDvMIlS1PEcX50VraKMvPpjvvFN1l5b64fPFDl2F9qm0ELTKzGUCEd1Fkt0ivWYFQTO5z9muJV8r8HilUCvVIZTcbsP3In6WwUt2SR6u4hpLHslO91DjtCaND5/h1DQOYRJJouUI+CKEpCxBIW5xQukRU1ofsguxHvW9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698907; c=relaxed/simple;
	bh=IjKBQypoiYpezQuDfjEMCysU4UpG4sxhNzaYrDgsDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbEgA86BM4phcEk5l3UQqLkhGjl7noKeYysKuNtfn3p7CR6lPh4w4BQsgZLOT8UZWu7x3W0ABgvq7n9yg3vVFwxdBlj7+o+VchuDyfwFmXV334ZFrMYBs5XnmaLx2cplZxoIw5EdJPDShp3hVS5wAOKHPmY/MiVKjYGCmQ8XCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XcVgRhxj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa9ecfb321so5909335ad.0
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720698905; x=1721303705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjYWpoT4u/Zq2mIe8pqxx1BxwM6H3Jj1huw4voUKaZg=;
        b=XcVgRhxjMCFJcMwD6HhIVmFgm9XBeXGn+wcClOHpgvqNnlt7u/jZzHCeLAOVEA0xO5
         6ZgVMXX4HeNnVYdRi/SJ+qIzGAQ5eKzkeQanKJLOvDtEuwPGvx5rJtXB5wgQYV8h2CAR
         KTyp6D2Bt1ape2i8sVeQvYG+4z2yWaYbv2jL+y876G//CcmYRY1jYsY8nW2jdeLvNGjv
         5xnIOTxaUrIU+w2N91s1x3JejsHcX84gnOJE5k2MFV8eyIQyZqDHToxXte/J0OpT/EMZ
         KTW6zLifKO14gvxfLxQAXzcl77m2oVNrIM/pTTqyzKiY8TqqF7PoDI6ssNt7mP3gA9P1
         QP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698905; x=1721303705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjYWpoT4u/Zq2mIe8pqxx1BxwM6H3Jj1huw4voUKaZg=;
        b=YSF0O+wVUrWE6Xr0Z58B3Ovkyaeu4XPwt0Dsw/6663BQhCqnvRsBY/B/9gM3LIUWIe
         iBO/kEOyC4nkJ2GOeCezsCIl2Q47KHpgynJy9xGxeatqHCigZXkNGgdLY0GCIJloVCVK
         GrkwHgzdiHrGhwKZZbXRI6hG5O/zIxhqZu9qJ4dS2WAXM7qosA2eY+JmoUtezjXv2LF+
         7mVH+RsM6fT0ENDKkYReAURv18an7VCelrRZ6Xf23Gv122u7FhezQL2/9Y6nuKrVKSNN
         5hM5cPi4zcDjBs4y3XZHe8KfktWINsOiLW/R4tYmTF/79gOciFeecZfQh12M9HKEmwMv
         SanQ==
X-Forwarded-Encrypted: i=1; AJvYcCUArxUf1aUjUa16cECaHurrcs1Sus6gLZNZFjkoouXKJ0jbRZM/Ut1TAQFh0Up81hHAV+B//bMRSM0mU1oze+BggI4GW/imm7K8
X-Gm-Message-State: AOJu0Yzz2V5NqGlNizqNmeNsL3VJPjNTI63fmXowmfqOlwjsrWnhhRt/
	UUc8Wy5qlDLOEFQxIyQpXgdFX1MzcNimnSvQ7sNlr8Ts8qCbRQxeRyY28uyOSPQ=
X-Google-Smtp-Source: AGHT+IHc/2NCtrqEJg+0Imf71rTjjn0FUGUhGEF9LXOZb1eutDkZEADYESdmeMrIbVmejDdivQbvVA==
X-Received: by 2002:a17:902:ced2:b0:1fb:6ea1:4c with SMTP id d9443c01a7336-1fbb6d3d631mr73256845ad.23.1720698905482;
        Thu, 11 Jul 2024 04:55:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7d9csm48859965ad.157.2024.07.11.04.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:55:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sRsO6-00C0GN-1Q;
	Thu, 11 Jul 2024 21:55:02 +1000
Date: Thu, 11 Jul 2024 21:55:02 +1000
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, linux-xfs@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: enable WQ_MEM_RECLAIM on m_sync_workqueue
Message-ID: <Zo/IFjI9u2E+PSW2@dread.disaster.area>
References: <>
 <ZoVdAPusEMugHBl8@infradead.org>
 <172056677808.15471.5200774043985229799@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172056677808.15471.5200774043985229799@noble.neil.brown.name>

On Wed, Jul 10, 2024 at 09:12:58AM +1000, NeilBrown wrote:
> On Thu, 04 Jul 2024, Christoph Hellwig wrote:
> > On Wed, Jul 03, 2024 at 09:29:00PM +1000, NeilBrown wrote:
> > > I know nothing of this stance.  Do you have a reference?
> > 
> > No particular one.
> > 
> > > I have put a modest amount of work into ensure NFS to a server on the
> > > same machine works and last I checked it did - though I'm more
> > > confident of NFSv3 than NFSv4 because of the state manager thread.
> > 
> > How do you propagate the NOFS flag (and NOIO for a loop device) to
> > the server an the workqueues run by the server and the file system
> > call by it?  How do you ensure WQ_MEM_RECLAIM gets propagate to
> > all workqueues that could be called by the file system on the
> > server (the problem kicking off this discussion)?
> > 
> 
> Do we need to propagate these?
> 
> NOFS is for deadlock avoidance.  A filesystem "backend" (Dave's term - I
> think for the parts of the fs that handle write-back) might allocate
> memory, that might block waiting for memory reclaim, memory reclaim
> might re-enter the filesystem backend and might block on a lock (or
> similar) held while allocating memory.  NOFS breaks that deadlock.
>
> The important thing here isn't the NOFS flag, it is breaking any
> possible deadlock.

NOFS doesn't "break" any deadlocks. It simply prevents recursion
from one filesystem context to another. We don't have to use
NOFS if recursion is safe and won't deadlock.

That is, it may be safe for a filesystem to use GFP_KERNEL
allocations in it's writeback path. If the filesystem doesn't
implement ->writepage (like most of the major filesystems these
days) there is no way for memory reclaim to recurse back into the fs
writeback path. Hence GFP_NOFS is not needed in writeback context to
prevent reclaim recursion back into the filesystem writeback
path....

And the superblock shrinkers can't deadlock - they are non-blocking
and only act on unreferenced inodes. Hence any code that has a
locked inode is either evicting an unreferenced inode or holds a
reference to the inode. If we are doing an allocation with eithe rof
those sorts of inodes locked, there is no way that memory reclaim
recursion can trip over the locked inode and deadlock.

So between the removal of ->writepage, non-blocking shrinkers, and
scoped NOIO context for loop devices, I'm not sure there are any
generic reclaim recursion paths that can actually deadlock. i.e.
GFP_NOFS really only needs to be used if the filesystem itself
cannot safely recurse back into itself.

> Layered filesystems introduce a new complexity.

Nothing new about layered filesystems - we've been doing this for
decades...

> The backend for one
> filesystem can call into the front end of another filesystem.  That
> front-end is not required to use NOFS and even if we impose
> PF_MEMALLOC_NOFS, the front-end might wait for some work-queue action
> which doesn't inherit the NOFS flag.
> 
> But this doesn't necessarily matter.  Calling into the filesystem is not
> the problem - blocking waiting for a reply is the problem.  It is
> blocking that creates deadlocks.  So if the backend of one filesystem
> queues to a separate thread the work for the front end of the other
> filesystem and doesn't wait for the work to complete, then a deadlock
> cannot be introduced.
>
> /dev/loop uses the loop%d workqueue for this.  loop-back NFS hands the
> front-end work over to nfsd.  The proposed localio implementation uses a
> nfslocaliod workqueue for exactly the same task.  These remove the
> possibility of deadlock and mean that there is no need to pass NOFS
> through to the front-end of the backing filesystem.

I think this logic is fundamentally flawed.

Pushing IO submission to a separate
thread context which runs them in GFP_KERNEL context does not help
if the deadlock occurs during IO submission. With loop devices,
there's a "global" lock in the lower filesystem on the loop device -
the image file inode lock.

The IO issued by the loop device will -always- hit the same inode
and the same inode locks. Hence if we do memory allocation with an
inode lock held exclusive in the lower filesystem (e.g. a page cache
folio for a buffered write), we cannot allow memory reclaim during
any allocation with the image file inode locked to recurse into the
upper filesystem. If the upper filesystem then performs an operation
that requires IO to be submitted and completed to make progress
then we have a deadlock condition due to recursion from
the lower to upper filesystem regardless of the fact that the
lower IO submission is run from a different task.

Hence the loop device sets up the backing file mapping as:

	lo->lo_backing_file = file;
        lo->old_gfp_mask = mapping_gfp_mask(mapping);
        mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));

GFP_NOIO context. It also sets up worker task context as:

	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;

GFP_NOIO context. IOWs, all allocation in the IO submission path is
explicitly GFP_NOIO to prevent any sort of reclaim recursion into
filesysetms or the block layer. That's the only sane thing to do,
because multi-filesystem deadlocks are an utter PITA to triage and
solve...

Keep in mind that PF_LOCAL_THROTTLE also prevents IO submission
deadlocks in the lower filesystem.  If the lower filesystem IO
submission dirties pages (i.e. buffered writes) it can get throttled
on the dirty page threshold. If it get's throttled like this trying
to clean dirty pages from the upper filesystem we have a deadlock.
The localio submission task will need to prevent that deadlock,
too.

IOWs, just moving IO submission to another thread does not avoid
the possibility of lower-to-upper filesystem recursion or lower
filesystem dirty page throttling deadlocks.

> Note that there is a separate question concerning pageout to a swap
> file.  pageout needs more than just deadlock avoidance.  It needs
> guaranteed progress in low memory conditions.   It needs PF_MEMALLOC (or
> mempools) and that cannot be finessed using work queues.  I don't think
> that Linux is able to support pageout through layered filesystems.

I don't think we ever want to go there.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

