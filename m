Return-Path: <linux-nfs+bounces-20933-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJhzNS6u4WnuwgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20933-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 05:51:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33693416B5E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 05:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68ABF305DBA6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2026 03:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE024351C2D;
	Fri, 17 Apr 2026 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P98dDbUO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437A351C07
	for <linux-nfs@vger.kernel.org>; Fri, 17 Apr 2026 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397779; cv=none; b=MTJmOV8NZMgDBgCfkIqL3oW94PdIy0LU3bzuYBFsDyExc/VeVA8Ddl/97x3nY+/TAZSsgsFCVbA31xKp3K+vGISSwb5z2Bk2o5MGh5tMCpqctAesGflv1sNnJ+sxpZZjpRCJ8R4jW3eW2PMbzFQ2CqO3K3lcvOxHGYwNyF1UctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397779; c=relaxed/simple;
	bh=0B5H2P8mBfGSUUI0p0aDJZX85KBZrWwukS/PjfMEs5c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=GPJkYKMbhYvS4vn9mNWTSGQv0/JSo5m6fUiZDRq+6wM90Ovxurcd6xcgVQA1CrI37vn2Nuj6+0eSc9o3BxdkX5wBWxDxySp/0iTAN3ZFjqtD/2mS2tcFfVsQOpWL4PjCwUIxB0bezYwZZRs+zmL3ywLIFXa9m+aINWTSecBpmZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P98dDbUO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so142991a91.0
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776397778; x=1777002578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOIYn6Vs3t3hB4T19aQ0W0U21onG5fYSXjKIJbShOas=;
        b=P98dDbUOSXADXTgICZlLDQimU1yWb2pvDptFjQzh/u2cB5v7K4ZMLYWkwM0MDPNmjK
         h922I9REjS/eYYzmODrjjvsN0ymb1Ycn31NhsEvNfKSgDorhfxFj+4tzHphZnZfkhu2W
         ISYvEVpl9LeQlDXw/QFsjnHfWMLut6QC9JPFqSKnQzFRhDMBzZMyrmWpUwixELm2s2BY
         6qQguO+qtcdh0qMFF6x78bPdy2TDrBAocwq9LkuvnIt+hpg596uXM/ErMDEmvMfBVxo7
         KnwZlLASjPnICAD/mWI9BVz32nlNgnBsdVt5odMhluVzgcyTqtuDAM9k0wmqbcOIVXXk
         sjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776397778; x=1777002578;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOIYn6Vs3t3hB4T19aQ0W0U21onG5fYSXjKIJbShOas=;
        b=U71cpu5ckVe8eVy3kHRNni9txS1PLGj3AtHsEZN8J51TM1paqfs6JTDqaYNQKVdGdb
         pJz+dBQVVPyI92MylECRCkN1m3VhnGT38/gU3RaWC5LX5lF9LZgYRbVKxh3dV6C9bVRi
         r+r/D8j9poAQo9NjK6l63BUukgxNIjI2r8metrEztQmG/puEqTNDXEepBs+LKQDM74Ye
         q4ngxERY5VtSk++X9FYFQfi0mRvFlv+NP+it7qDsdjsRgtw8/boCWat7+eqbfUgl8GRL
         W7a0L+chZS6JWVw/1ecDQnJaCn/5sBIIMW2Y3JqCyb+VdZH+qrxKDQ4hBeJejIyn+RAv
         kRmw==
X-Forwarded-Encrypted: i=1; AFNElJ+bplT71weOAr1begeLzYhq1RL4pICsGwulStfNTttPho8KP2qIQVjSXgN9nCSoTgjU+ZMQiX/GgnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ShbdvydbCCvhqQomwcvVItjy/NKcJIJiFEWHwzP0FuwHDDQO
	R0bDcprRVzH91iI2YZaujfZiej0ml/9QYVtuQC6Wxk0DjIClhEqryGjv
X-Gm-Gg: AeBDiesEvbvAPZKM8zlnQZOppVjm2ndCKJHp5PxKIJWWth2IvabZYyo5uDU31+7ajz7
	K3SM002w3at96/ngzKH2193txyjDFgVAEDP3/xRGhjUMv/gIOXl7HyZgb/EIxifYP9ZvjrubvCi
	ecpR8TnkJOGKcmEXucJWgX6rf4mif8iLEdnmz+Mneck2n99991IscJx0YL2mYagyXWZ0szrE+AX
	sWO9nWrb1Nygop8c8/yqTIl1CrrfQdFLDNhBiw8KcscQ79FcTJGRxXEuNvmmlMDqd7eJ79OVDWt
	yiwJlOzpQz3ZpTf9q+aIvp4NfJ1I6BMUNQGwhOK+TkaXS/a13rmcetbGrv1Udmirf1qg5/IuZve
	i/x7KgUfQLpi3RdbzG9aAGb7V24tE8705XEGNY4QrqsFW//Hb9VHJBApbaDmCYYe5MXOfhP6gaq
	0bSwwnTUK+syqRZEIh7iHJ+8mx8Awl9tOT
X-Received: by 2002:a17:90b:2e90:b0:35b:945d:752a with SMTP id 98e67ed59e1d1-3614046e0b8mr1021853a91.17.1776397777891;
        Thu, 16 Apr 2026 20:49:37 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm392590a91.3.2026.04.16.20.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 20:49:37 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: kick writeback flusher instead of inline flush for IOCB_DONTCACHE
In-Reply-To: <52b81c4d1fb2ad0e07b3b3b4dfbd3d36e8ee3e7d.camel@kernel.org>
Date: Fri, 17 Apr 2026 08:25:52 +0530
Message-ID: <ik9qthvr.ritesh.list@gmail.com>
References: <20260408-dontcache-v2-0-948dec1e756b@kernel.org> <20260408-dontcache-v2-1-948dec1e756b@kernel.org> <tstklxm7.ritesh.list@gmail.com> <52b81c4d1fb2ad0e07b3b3b4dfbd3d36e8ee3e7d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20933-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33693416B5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2026-04-09 at 07:10 +0530, Ritesh Harjani wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > The IOCB_DONTCACHE writeback path in generic_write_sync() calls
>> > filemap_flush_range() on every write, submitting writeback inline in
>> > the writer's context.  Perf lock contention profiling shows the
>> > performance problem is not lock contention but the writeback submission
>> > work itself — walking the page tree and submitting I/O blocks the
>> > writer for milliseconds, inflating p99.9 latency from 23ms (buffered)
>> > to 93ms (dontcache).
>> > 
>> > Replace the inline filemap_flush_range() call with a
>> > wakeup_flusher_threads_bdi() call that kicks the BDI's flusher thread
>> > to drain dirty pages in the background.  This moves writeback
>> > submission completely off the writer's hot path.  The flusher thread
>> > handles writeback asynchronously, naturally coalescing and rate-limiting
>> > I/O without any explicit skip-if-busy or dirty pressure checks.
>> > 
>> 
>> Thanks Jeff for explaining this. It make sense now.
>> 
>> 
>> > Add WB_REASON_DONTCACHE as a new writeback reason for tracing
>> > visibility.
>> > 
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/fs-writeback.c                | 14 ++++++++++++++
>> >  include/linux/backing-dev-defs.h |  1 +
>> >  include/linux/fs.h               |  6 ++----
>> >  include/trace/events/writeback.h |  3 ++-
>> >  4 files changed, 19 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> > index 3c75ee025bda..88dc31388a31 100644
>> > --- a/fs/fs-writeback.c
>> > +++ b/fs/fs-writeback.c
>> > @@ -2466,6 +2466,20 @@ void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
>> >  	rcu_read_unlock();
>> >  }
>> >  
>> > +/**
>> > + * filemap_dontcache_kick_writeback - kick flusher for IOCB_DONTCACHE writes
>> > + * @mapping:	address_space that was just written to
>> > + *
>> > + * Wake the BDI flusher thread to start writeback of dirty pages in the
>> > + * background.
>> > + */
>> > +void filemap_dontcache_kick_writeback(struct address_space *mapping)
>> 
>> This api gives a wrong sense that we are kicking writeback to write
>> dirty pages which belongs to only this inode's address space mapping.
>> But instead we are starting wb for everything on the respective bdi.
>> 
>> So instead why not just export symbol for wakeup_flusher_threads_bdi()
>> and use it instead?
>> 
>> If not, then IMO at least making it... 
>>    filemap_kick_writeback_all(mapping, enum wb_reason)
>> 
>> ... might be better.
>
> I did draft up a version of this -- adding a way to tell the flusher
> thread to only flush a single inode. The performance is better than
> today's DONTCACHE, but was worse than just kicking the flusher thread.
>
> I think we're probably better off not doing this because we lose some
> batching opportunities by trying to force out a single inode's pages
> rather than allowing the thread to do its thing.
>

So, if I understood it correctly, Christoph might be talking about a
different approach here.
Instead of kicking flusher thread to writeback pages for a single inode,
if we can track the number of dontcache pages
(get_nr_dontcache_pages()), then we can kick the flusher for those many
target pages. I think this way we are still reducing the dirty page
cache pressure - the problem which RWF_DONTCACHE is supposed to solve.
But I guess, that doesn't necessarily always mean that only dontcache
marked folios will get written.

If we implement that then, this should still help with the batching
problem you mentioned and hopefully should not cause a major regression
for the workload which Jan mentioned.

Feel free to correct my understanding here please.

-ritesh

