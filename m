Return-Path: <linux-nfs+bounces-10034-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8CA2FEA9
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 00:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DDC3A3F06
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2025 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8269926461E;
	Mon, 10 Feb 2025 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="WDfA36nH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958126460F
	for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739231872; cv=none; b=Cerq9/EhwcPg+Nb1qzYET46i7dZRJvrUTN6l+lcCz829vqTJIm387KV5OyWSaNzUdZe9sUZNivfzKGL2oKGPwm2FlVoB65vZI9d289Dl7HUYyPWG8wc1YkHgWgZ5K3N5QlZnb1qNfCyNrdnn4UqXNEmvhK6HlDxE99H7hGoeGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739231872; c=relaxed/simple;
	bh=ss5G6vkgNQk5+C25dURMiSXzMbaXz+lk31kEpewRKp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTgMWTt5Nk+MmaWfA2VdUioY8TwSbJzVi7wWmwfyO3k8sXPrEeKbVUlnsp8tcQamtu+O7NIkgU6Y/efxE3NqlbPTwlPT4LYcPiOq1MoCd/ZZPrkf0Q1p3RvmO1CWm6jTIBJ15v75Z+0w7oiD57X7g6sF3QbOiM/Z+L0eY16vvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=WDfA36nH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21fa56e1583so20804635ad.3
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2025 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739231870; x=1739836670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0+Cg/RDAoDrUc0LboYVornjRACuuDfgyfMCrI1s+Z8=;
        b=WDfA36nHwlDIXUe2MgAvbI2X4QftM2lj4ue0z5YPlsbe7E6Bbn2QnoOiu7WO69oy1C
         6kiLfiR25DlUFTGbocGPSxR/QzA/RiGqblCPVmL0hEZOY6RrQSGpu3fc6VDvlbgcb13V
         6JwekHbXnjzupuwL74hAqZoGq8fqZuhxTNX6OwN8njRad9ldVHG/m4iYycczdYcbOD86
         hEGt0TFENJUG2P4hqgmwDmUMwSUCuk6TgMF4Jl8XFlMO2V7KclARrv/cgdTK8sxm9EIj
         2PKfxM84vStXYXajEvpJ+VjSncjtdA8ESANaz3lBWSzi/xz4DV+p2wNr8/kbZaWe8lAG
         nfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739231870; x=1739836670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0+Cg/RDAoDrUc0LboYVornjRACuuDfgyfMCrI1s+Z8=;
        b=AC9IF1qnYWyXDzJGiS4+8fSwuqghOYHLj6D4hZk/y1hHX8vy8ZWgF4JAOCOEnvlZNo
         mrJdLgTf48Q656jZei0ichD4A5hYuQGVZMyFG/Br+9W4graUWzXVpVPt6zQdnlXs4qFB
         8y8PXeSMHtQV2XrbfebkmYwACpWd2qi0oM2XVsw3kqZVCc1UuDDotvv2WMzW1XDuhU9T
         nES1089ER4GL2eq/gSZuIl0LCQo+saY/Uiaiy909g7fhsrlVLAWYP4GVm8SiS3v9pzNs
         YXBwakR8KK4u6aZcR0oNiHWeqX3YJgtp5F9qgi7lOd6hEPUUgsJ8OAzIwpfwgH2d4uxQ
         RWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXObjF2/8nFHWh5J3mdM4DBAnmdzahmoSWNKbRxhAEbsxY8xdK7bs+Nf0SVgTLJrv5rYV4tdGpcmWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWTPjy+/o/kC3sviAfcde342tM5MxJ2dAuwd/XcbqduvEtGTK
	uvqIpTk0Bc0ijlYwxYRYGlAeCiqFLqA/waaw0I4lf+3pJatYIo0aBLRi41faELc=
X-Gm-Gg: ASbGncvSeahS2aMMXY92rLZCGvjFmN0Iuz/JKTHAX3pb9f6yhtL6o1IvL5L/6oj2f3E
	suB9UquvqPo6xWofv0GITJbGTfiIrHXgfEWrxizc9FKfGV+E6If8GN7uKsWwQSDzrITb3w+MjKe
	HTr8ajghnoNWGy0vGBD8VHcoubaBvHqxvjtdbvBAi6M3uBneoAuC4HZlr0I2Bfwwac0VOx5EXSm
	E3v+bhFKZVCAtF6D9JUnz5oTbwjuM8DW86BDN1xoyp07QqpGWLUOPCwEXRXot1/ZDQ2PTrhxqwa
	wFfZQ04pF/H7Pdc+65t6CzJLXQK2hb/SsuG+dpBLZQUWSXVKaSc4kxI/
X-Google-Smtp-Source: AGHT+IFSL+n9Jkm5iHqhyM+9tCsOehSS5HJmddQCYP+u/OwPJRhppQ+JIK836sqwk3wkv+RJf7y/+g==
X-Received: by 2002:a05:6a20:6f87:b0:1db:d932:ddcc with SMTP id adf61e73a8af0-1ee03a7de87mr25142846637.19.1739231869898;
        Mon, 10 Feb 2025 15:57:49 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73094741977sm2017388b3a.114.2025.02.10.15.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 15:57:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1thdes-0000000HFGA-1u7g;
	Tue, 11 Feb 2025 10:57:46 +1100
Date: Tue, 11 Feb 2025 10:57:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 4/6] nfsd: filecache: introduce NFSD_FILE_RECENT
Message-ID: <Z6qSenQcLKrP2fF1@dread.disaster.area>
References: <20250207051701.3467505-1-neilb@suse.de>
 <20250207051701.3467505-5-neilb@suse.de>
 <5e6060d79e247a7e97443f200399061da8d558f9.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6060d79e247a7e97443f200399061da8d558f9.camel@kernel.org>

On Mon, Feb 10, 2025 at 09:01:41AM -0500, Jeff Layton wrote:
> On Fri, 2025-02-07 at 16:15 +1100, NeilBrown wrote:
> > The filecache lru is walked in 2 circumstances for 2 different reasons.
> > 
> > 1/ When called from the shrinker we want to discard the first few
> >    entries on the list, ignoring any with NFSD_FILE_REFERENCED set
> >    because they should really be at the end of the LRU as they have been
> >    referenced recently.  So those ones are ROTATED.
> > 
> > 2/ When called from the nfsd_file_gc() timer function we want to discard
> >    anything that hasn't been used since before the previous call, and
> >    mark everything else as unused at this point in time.
> > 
> > Using the same flag for both of these can result in some unexpected
> > outcomes.  If the shrinker callback clears NFSD_FILE_REFERENCED then the
> > nfsd_file_gc() will think the file hasn't been used in a while, while
> > really it has.
> > 
> > I think it is easier to reason about the behaviour if we instead have
> > two flags.
> > 
> >  NFSD_FILE_REFERENCED means "this should be at the end of the LRU, please
> >      put it there when convenient"
> >  NFSD_FILE_RECENT means "this has been used recently - since the last
> >      run of nfsd_file_gc()
> > 
> > When either caller finds an NFSD_FILE_REFERENCED entry, that entry
> > should be moved to the end of the LRU and the flag cleared.  This can
> > safely happen at any time.  The actual order on the lru might not be
> > strictly least-recently-used, but that is normal for linux lrus.
> > 
> > The shrinker callback can ignore the "recent" flag.  If it ends up
> > freeing something that is "recent" that simply means that memory
> > pressure is sufficient to limit the acceptable cache age to less than
> > the nfsd_file_gc frequency.
> > 
> > The gc caller should primarily focus on NFSD_FILE_RECENT.  It should
> > free everything that doesn't have this flag set, and should clear the
> > flag on everything else.  When it clears the flag it is convenient to
> > clear the "REFERENCED" flag and move to the end of the LRU too.
> > 
> > With this, calls from the shrinker do not prematurely age files.  It
> > will focus only on freeing those that are least recently used.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/filecache.c | 21 +++++++++++++++++++--
> >  fs/nfsd/filecache.h |  1 +
> >  fs/nfsd/trace.h     |  3 +++
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > index 04588c03bdfe..9faf469354a5 100644
> > --- a/fs/nfsd/filecache.c
> > +++ b/fs/nfsd/filecache.c
> > @@ -318,10 +318,10 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
> >  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
> >  }
> >  
> > -
> >  static bool nfsd_file_lru_add(struct nfsd_file *nf)
> >  {
> >  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > +	set_bit(NFSD_FILE_RECENT, &nf->nf_flags);
> 
> Technically, I don't think you need the REFERENCED bit at all. This is
> the only place it's set, and below this is calling list_lru_add_obj().
> That returns false if the object was already on a per-node LRU.
> 
> Instead of that, you could add a list_lru helper that will rotate the
> object to the end of its nodelist if it's already on one. OTOH, that
> might mean more cross NUMA-node accesses to the spinlocks than we get
> by using a flag and doing this at GC time.

No, please don't.

Per-object reference bits are required to enable lazy LRU rotation.
The LRU lists are -hot- objects; touching them every time we touch
an object on the LRU is prohibitively expensive because of exclusive
lock/cacheline contention. Hence we defer operations like rotation
to a context where we already have the list locked and cached
exclusively for some other reason (i.e. memory reclaim).

This is the same reason we use lazy removal from LRUs - it avoids
LRU list manipulations every time a hot cached object is accessed
and/or dropped.

IOWs, removing the per-object NFSD_FILE_REFERENCED bit will undo one
of the necessary the optimisations that allow hot caches LRU
management to work efficiently with minimal overhead.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

