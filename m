Return-Path: <linux-nfs+bounces-9892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A11A29EB6
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 03:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394327A2AC5
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Feb 2025 02:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE044C94;
	Thu,  6 Feb 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="lh2eWSTQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4326ACD
	for <linux-nfs@vger.kernel.org>; Thu,  6 Feb 2025 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808520; cv=none; b=o3WbLWidXlsPdduQoNRd0fvHMSTvs79zDNMsUuno7l3k7/K+EcdVI1BNVVzTDjYQ61N9prgB9Tf7G55BooPoFaCb2rUfVW5Dhze1J1Wkaz57e2G2eTCuMQGh8Gyp6NJdULdNpIpNbCfyf2DmsW1XmO2fC1dmfXHtLmPJS4SyaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808520; c=relaxed/simple;
	bh=qBFtQO+gpY4y1V3swgi0Dkpr26Ufn3OR75HhhYuv02Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqUWac5/fW9+8BxM4PUi9sdcAkI9rDgOI+5X+QWI2TqP5uBqLv4QV99BxrrioODvLNpK3btKoaoSBmhH7CAr0WijqrD5PIGYYB2H3ORmZyvlT+5wWEB1u2kUSNcR9pw3ZBN6x62qtOPdwV9t/Aq5dZIcVw3jzYfNEbtv24C47JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=lh2eWSTQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9d74037a7so682584a91.2
        for <linux-nfs@vger.kernel.org>; Wed, 05 Feb 2025 18:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738808518; x=1739413318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZkA+Cp3/kVEWu01CBo6XIgceYf3Cy9F2m23xIQEOjo=;
        b=lh2eWSTQI43tFvAtzaSMLUhfI/ewK1+dOdGJs+15mVOoz1Xhcq1CJXkXip+Xi6oyBU
         5USxOV9BIGDPsbTrd+/r4GEdT8BchOag15zsInCjAvw3vTYFQ4qiY8S0VJdXNJZweyjL
         8XNMBOKyryvxQL/yT1P/sy8rW/WT14YiRiQNntay5n0bRSfo0U+cREccBERbgcwoQoo2
         ZpohUW+ZaJqQDmfBjzEmNe0+nzjyCLgQ0I8OXhDxvuxHpNWNet40+ysNFszfX8bl85n2
         lNODVCcpX4+5uENibI77yzmKE1p83QtL3pH5TOQjTvnx+QHXSZ0llExCBH9cCgQy3IpB
         Dj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738808518; x=1739413318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZkA+Cp3/kVEWu01CBo6XIgceYf3Cy9F2m23xIQEOjo=;
        b=Z8ZgRb4CafAokeRJET7F2iSv152tF/W6VwLRJ7Aivbk03omY4Nc5IjIINCD9jMMyP3
         y6NNlsiDe7aunjrsDei3fWPu61yFN9eut2BWmJ1NW2Mt3ryP60C1Bc4JWgKUyjN7qon5
         mT8B16echlBHDQWbiMRHDDLT9o1XRccr7MNbcghjJ2RlkN8XkMyJkzfwPJyTRCRVueTc
         RnFeaCoqCDJcFLloTBz5CTafesw/bTsr66Zm4H4Dr6DPL4p39/qBxKolCso0cXDrNuKj
         boEYHB+f89asFXpc4/bj8MHu3bemGfZ+/qEPJW5hEixqK0JJpEvr7q2zBMDhYyezH7WE
         eqPg==
X-Forwarded-Encrypted: i=1; AJvYcCVaw0FN5bPa2ik/ifbhlXZ+xM5aFHmkMVZV59T+iU1B7j/kF2IVGrKZJR4Bj2nI6dfG2IY06Ou45gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqyvwcaKJ61pcuo3UXfuEi8HMZ7fmK1wKs1UE7Z2RobSyxkAC
	65ECTtbG75t7+YAAi0J7Fa/7iwiop1QJm3MIKxMhuhTitHXMPW2QupcWZrAELkQ6rBrDY0piyHY
	l
X-Gm-Gg: ASbGnctAD7isIjA0BY+bpbBjGrHySLWt1En66N5yyfIK2o7YSuSYypFJigK347pLCED
	2FLoGq52/h7Acskf02nApc7CVxrEcHAXmwTNH5K9eRxCkj38cOebE7Vn17Tb4sGRTaNXw6sZBZV
	fMJn9UrlJQ62xY8TETxhTJEuOPrNRKp7kjYJahx7JKC1g2RTMrCdeweAUadgcpiDx5JgnWXqn0d
	FcX5fWHOwkB7Wbzd5+b2AwYRU+yDZwQa+ae+YCR3fT0uqwKJMPJW26wu7uEFE0hdRdm4LfnddvV
	EgPYpejqaS4EyZMrhxoxgCKCqSXLsK83SfTZJFH8ioRaiCts4EzeW9oaawiDah4Rbu4=
X-Google-Smtp-Source: AGHT+IHbrkqaj5zKg0f2SbzFiG4A8qy3SVjcTKkWVhtQPB3/fIwN7UCOPDuDOD5idBm9pngDGvvY6w==
X-Received: by 2002:a17:90b:3c8d:b0:2f9:9ddd:689c with SMTP id 98e67ed59e1d1-2f9e08107ffmr7773615a91.25.1738808518209;
        Wed, 05 Feb 2025 18:21:58 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09b5d0b6sm133278a91.46.2025.02.05.18.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 18:21:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfrWb-0000000FBLn-3s4d;
	Thu, 06 Feb 2025 13:21:53 +1100
Date: Thu, 6 Feb 2025 13:21:53 +1100
From: Dave Chinner <david@fromorbit.com>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 0/7] nfsd: filecache: change garbage collection lists
Message-ID: <Z6QcwbsFfOahoJ1P@dread.disaster.area>
References: <20250127012257.1803314-1-neilb@suse.de>
 <Z5h7HOogTsM4ysZx@dread.disaster.area>
 <173818645556.22054.17713237842941971206@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173818645556.22054.17713237842941971206@noble.neil.brown.name>

On Thu, Jan 30, 2025 at 08:34:15AM +1100, NeilBrown wrote:
> On Tue, 28 Jan 2025, Dave Chinner wrote:
> > On Mon, Jan 27, 2025 at 12:20:31PM +1100, NeilBrown wrote:
> > > [
> > > davec added to cc incase I've said something incorrect about list_lru
> > > 
> > > Changes in this version:
> > >   - no _bh locking
> > >   - add name for a magic constant
> > >   - remove unnecessary race-handling code
> > >   - give a more meaningfule name for a lock for /proc/lock_stat
> > >   - minor cleanups suggested by Jeff
> > > 
> > > ]
> > > 
> > > The nfsd filecache currently uses  list_lru for tracking files recently
> > > used in NFSv3 requests which need to be "garbage collected" when they
> > > have becoming idle - unused for 2-4 seconds.
> > > 
> > > I do not believe list_lru is a good tool for this.  It does not allow
> > > the timeout which filecache requires so we have to add a timeout
> > > mechanism which holds the list_lru lock while the whole list is scanned
> > > looking for entries that haven't been recently accessed.  When the list
> > > is largish (even a few hundred) this can block new requests noticably
> > > which need the lock to remove a file to access it.
> > 
> > Looks entirely like a trivial implementation bug in how the list_lru
> > is walked in nfsd_file_gc().
> > 
> > static void
> > nfsd_file_gc(void)
> > {
> >         LIST_HEAD(dispose);
> >         unsigned long ret;
> > 
> >         ret = list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> >                             &dispose, list_lru_count(&nfsd_file_lru));
> > 			              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> >         trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> >         nfsd_file_dispose_list_delayed(&dispose);
> > }
> > 
> > i.e. the list_lru_walk() has been told to walk the entire list in a
> > single lock hold if nothing blocks it.
> > 
> > We've known this for a long, long time, and it's something we've
> > handled for a long time with shrinkers, too. here's the typical way
> > of doing a full list aging and GC pass in one go without excessively
> > long lock holds:
> 
> "Typical"?? Can you please point me to an existing example?

Of the top of my head: shrink_dcache_sb().

However, *every single shrinker implementation in the kernel* uses
this algorithm whether they use list-lru or not.

i.e. this "iterate list in small batchs to minimise lock hold
latency" algorithm has been used by the shrinker infrastructure
since the 2.5.x days.

list-lru was designed explicitly for use with shrinker walk
algorithms, so -typical- usage it to walk in small batches unless
it is known that there are no concurrent accesses to the list
possible. (e.g. during teardown).

Just because you don't know about how list_lru is typically used,
doesn't mean that there aren't typical uses...

> > IOWs, a batched walk like above resumes the walk exactly where it
> > left off, because it is always either reclaiming or rotating the
> > object at the head of the list.
> 
> "rotating the object" to the head of the per-node list, not the head of
> the whole list_Lru (except in the trivial single-node case).

Yup. That's because shrinkers are numa node specific. i.e. memory
reclaim is not global, it is per-node and we have one list_lru list
per node. IOWs, the structure of list-lru is intended to be optimal
for NUMA aware memory reclaim algorithms.

Most important VFS and filesystem caches ceased to have global LRU
ordering a -long- time ago. Scalability to really large machines is
far more important than strict global LRU maintenance.

> list_lru_walk() iterates over the multiple node lists in a fixed order.
> Suppose you have 4 nodes, each with 32 items, all of them referenced, and
> a batch size of 64.
> The first batch will process the 32 items on the first list clearing the
> referenced bit and moving them to the end of that list.  Then continue
> through those 32 again and freeing them all.  The second batch will do the
> same for the second list.  The last two lists won't be touched.
> 
> list_lru_walk() is only ever used (correctly) for clearing out a
> list_lru.  It should probably be replaced by a function with a more apt
> name which is targeted at this: no spinlocks, no return value from the
> call-back.
> 
> Yes, we could change the above code to use list_lru_walk_node and wrap a
> for loop around the whole, but then I wonder if list_lru is really
> giving us anything of value.

Apart from scalability and the ability for memory reclaim to do sane
per-node object reclaim? What about the fact that anyone familiar
with list-lru doesn't need to look at how the lists are implemented
to know how the code behaves?

Using common infrastructure, even when it's not an exact perfect
fit, holds a lot more value to the wider community than a one-off
special snowflake implementation that only one or two people
understand....

> Walking a linked list just to set a bit in ever entry is a lot more work
> that a few list manipulation in 5 cache-lines.

Maybe so, but the cache gc isn't a performance critical path.

> > > This patch removes the list_lru and instead uses 2 simple linked lists.
> > > When a file is accessed it is removed from whichever list it is on,
> > > then added to the tail of the first list.  Every 2 seconds the second
> > > list is moved to the "freeme" list and the first list is moved to the
> > > second list.  This avoids any need to walk a list to find old entries.
> > 
> > Yup, that's exactly what the current code does via the laundrette
> > work that schedules nfsd_file_gc() to run every two seconds does.
> > 
> > > These lists are per-netns rather than global as the freeme list is
> > > per-netns as the actual freeing is done in nfsd threads which are
> > > per-netns.
> > 
> > The list_lru is actually multiple lists - it is a per-numa node list
> > and so moving to global scope linked lists per netns is going to
> > reduce scalability and increase lock contention on large machines.
> 
> Possibly we could duplicate the filecache_disposal structure across
> svc_pools instead of net namespaces.  That would fix the scalability
> issue.  Probably we should avoid removing and re-adding the file in
> the lru for every access as that probably causes more spinlock
> contention.  We would need to adjust the ageing mechanism but i suspect
> it could be made to work.

Typical usage of list-lru is lazy removal. i.e. we only add it to
the LRU list if it's not already there, and only reclaim/gc removes
it from the list.  This is how the inode and dentry caches have
worked since before list_lru even existed, and it's a pattern that
is replicated across many subsystems that use LRUs for gc
purposes...

IOWs, the "object in cache" lookup fast path should never touch
the LRU at all.

> > i.e. It's kinda hard to make any real comment on "I do not believe
> > list_lru is a good tool for this" when there is no actual
> > measurements provided to back the statement one way or the other...
> 
> It's not about measurements, its about behavioural correctness.  Yes, I
> should have spelled that out better.  Thanks for encouraging me to do
> so.

So you are saying that you don't care that the existing code can
easily be fixed, that your one-off solution won't scale as well and
is less functional from memory reclaim POV, and that the new
implementation is less maintainable than using generic
infrastructure to do the same work.

If that's the approach you are taking, then I don't know why you
asked me to point out all the stuff about list_lru that you didn't
seem to know about in the first place...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

