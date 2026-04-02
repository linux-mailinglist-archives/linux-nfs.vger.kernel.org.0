Return-Path: <linux-nfs+bounces-20616-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a8aLCw9nzmlRngYAu9opvQ
	(envelope-from <linux-nfs+bounces-20616-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 14:54:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 694DB389446
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0616308AACF
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491A13DF018;
	Thu,  2 Apr 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3oi11MO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612B366816
	for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134344; cv=none; b=Ir1EUKqNQWhsWGBwhoiDqysmQLWJAFUosRP+jjKlbeBBBMDq/SeWcsIwSmI1WoeZf7SWJ2cG8qc+UXC3cBzszgPOD5T0AjXcajd7kJ7tQ6PJF9CIuGJKyHclB3sZNc0dYgofzIjWkCf5orzDmDAmJ3bZuy6BuMh3trMU+juqlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134344; c=relaxed/simple;
	bh=o1ZCYwcFc8lRBKP856YOVeSOHiTUCIiilJIC6oIentI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=eqwsK02SiydECx8zeISA/cow8crC5T2tOSNCekceSn15NDAhKZOw/o7irpZutPvC+YoTfCvF5+Cis6iHAvJYUstoNndQAqKftljyHqeyznsRY8/c12maI2ZDMSsZiArG/128QrANFmXWPq0FFQ1mJHSe9QvHD/frGlx40boe6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3oi11MO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso524488a91.2
        for <linux-nfs@vger.kernel.org>; Thu, 02 Apr 2026 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775134339; x=1775739139; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TQ3lrWVKO87z8vhsStJXZkDwRc6VLmdZN5o7clgXULk=;
        b=s3oi11MOqnDG32fuaoFARK5ha79/g9zCsdwtFdWWCZWIHsSvBTQKJz+lE3UO8jhWAD
         rKT1TDd0zuNlFDCgX4/hTDnx5OJ0HdNeXxQTkPZkP60W+/pnd47sLSht8Yy/nHD/NAkY
         VBcB4qockof2HeEFkojTvsaDg9br6MfJoDmw40gjFgQs5aVc9Xyx8fegOQGLu2X/15B7
         k4U3Kp4KqWLlRqUyIqq+CvxN/gen40shZHd8hJ/IWcxJSWJt86SebzPTnoqIcs2o2RQP
         vwu57W2vCS9LBuB3M8qKuG3bH9QhNn0ELeUKyvlU5Bnen4r4EvNfts6PCWaMtVZbvXeC
         RGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134339; x=1775739139;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQ3lrWVKO87z8vhsStJXZkDwRc6VLmdZN5o7clgXULk=;
        b=N35TplAs+JB7nSDmnAS2pw3M7PilXN14AUBuOynFP9mJCjVhtBK7b5ezlgcXLcRtsT
         dzkFaqc+eLCfCWHYUX4JKqsSpPkWOATU7VVLPB6BPM0NErWDP2kVxuAXNZnVdi4q7usd
         bnjPGjaVNi1JBE9bvnVv0Bw4AtDquLiJ0cw0ePxgnOB1UwDrRR5OZ0mHIyT5f23HiUql
         x31lOSXk/2lNtETAHEepmg1g9020/uFL/7bhn2BS3MkzSRz68PiyvBK6WALUzM4KtUp1
         TDesY+Id6xcQqlOrMwK3+NG7lFtJNTdsoN8b2io0A4ffs7MDiy49WHtNkQQYhsKBnPzj
         w78A==
X-Forwarded-Encrypted: i=1; AJvYcCWzbvMZSrLHMpiPuMVAYOFBEqJQhxYJ0AU6DjFU2RN5Niv9mqVsz67kJvOVHsk6qdwIcJ7e/ZaDMfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUwnLNbXKHMnXR2jijQCDd9sWDyxc+MdLqr0tYBkX37wsq9W8
	0MxsUOQKV0Tdfv9w/Wj3IEd5CjWM3DeohU5bZNNKYwCHtENC5BgT489l
X-Gm-Gg: AeBDieu6nauferlbJFdCbhHvtLo0PLdS59crrJXkJur7+7PIY7GlPRU0GNrWSjx2omC
	E4aUSSgkbsVHZ3Jx14z1yxpVGSDWBukIsHRWlyo11UGypb0SyOhJ3p7NxyLakcthKUz1ll8k+Hw
	X6C8HiujPrNyw6DCvnfGX+MvGj8avXIC8wNIRrXyndt73XhJzrq4283EwBAkdIaYj63j8O99QnH
	bJFq5Vcc4ZBdtzXummCJeRiNw1xqKcaw64kwxcNJyqzEuqISuLWQZ523YCQo3/MBz49OmX24/3K
	+JXIoiRiY2Fs3uU0loql8IS9a/RTNuR0wOzQU/ANPjKpOpTxnnZVuHgeUGD7pfOAkGWFfsPhuO6
	7nMwTwFdIJC00zBQKafILlzZVHNhn+Jws6D8oGgXG1jNcXtaWk7qRlAMj43bRT2mEhCdwX6C8Z3
	ZUCckc52aHKyUUOVKcQzwPpA==
X-Received: by 2002:a17:90b:1850:b0:35d:9c39:4dc9 with SMTP id 98e67ed59e1d1-35dc6f8a3famr6709877a91.23.1775134339387;
        Thu, 02 Apr 2026 05:52:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbb8932ecsm3838360a91.5.2026.04.02.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:52:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: fix IOCB_DONTCACHE write performance with rate-limited writeback
In-Reply-To: <09672fa10c77d4fbfa1a13ea16aedf79d23fd8f8.camel@kernel.org>
Date: Thu, 02 Apr 2026 18:10:32 +0530
Message-ID: <h5ptmt6n.ritesh.list@gmail.com>
References: <20260401-dontcache-v1-0-1f5746fab47a@kernel.org> <20260401-dontcache-v1-1-1f5746fab47a@kernel.org> <ikaam0ox.ritesh.list@gmail.com> <09672fa10c77d4fbfa1a13ea16aedf79d23fd8f8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20616-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,markdownpastebin.com:url]
X-Rspamd-Queue-Id: 694DB389446
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2026-04-02 at 10:13 +0530, Ritesh Harjani wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > IOCB_DONTCACHE calls filemap_flush_range() with nr_to_write=LONG_MAX
>> > on every write, which flushes all dirty pages in the written range.
>> > Under concurrent writers this creates severe serialization on the
>> > writeback submission path, causing throughput to collapse to ~47% of
>> > buffered I/O with multi-second tail latency.
>> 
>> Yes, between concurrent writers, I agree with the theory.
>> 
>> 
>> > Even single-client
>> > sequential writes suffer: on a 512GB file with 256GB RAM, the
>> > aggressive flushing triggers dirty throttling that limits throughput
>> > to 575 MB/s vs 1442 MB/s with rate-limited writeback.
>> 
>> I am not sure if this 2.5x performance penalty in a "single" sequential

Sorry my bad.. I mis-understood this 2.5x delta at first.

So in a single sequential write case, what this patch is mainly
improving is from unpatched RWF_DONTCACHE (1179 MB/s) to patched
RWF_DONTCACHE (1453 MB/s) = ~23% improvement.

So the below theory which I was talking about was from this delta
perspective i.e. comparing unpatched v/s patched RWF_DONTCACHE mode.

>> writer is due to throttling logic. On giving it some thoughts, I suspect
>> if this is because, the submission side and the completion side both
>> takes the xa_lock and hence could be contending on that.
>> 
>> For e.g. since this patch skips doing the flush the second time, (note
>> that writeback is active when the same writer dirtied the page during
>> previous write), this allows the writer to do more work of writing data
>> to page cache pages, instead of waiting on the xa_lock which the
>> completion callback could be holding (folio_end_writeback() -> folio_end_dropbehind())
>> 
>> If I see Peak Dirty data from the link you shared [1] in single writer case...
>> 
>> Mode                    MB/s	p50 (ms)	p99 (ms)	p99.9 (ms)	Peak Dirty	Peak Cache
>> dontcache (unpatched)	1179	3.2	    103.3	    170.9	    14 MB	    4.7 GB
>> dontcache (patched)	1453	5.4	    43.8	    57.4	    36 GB	    45 GB
>> 
>> ... this too shows that the submission side is writing more dirty pages,
>> then the completion side able to write it... 
>> 
>> I suspect this contention (between submission and completion) could more
>> in IOCB_DONTCACHE case, since the completion side also removes the folio
>> from the page cache within the same xa_lock, which is not the same with
>> normal buffered writes.
>> 
>> Maybe a perf callgraph showing the contention would be nicer thing to add
>> here [1] ;). 
>> 
>> [1]: https://markdownpastebin.com/?id=96249deb897a401ba32acbce05312dcc
>> 
>
> That's an interesting point.
>
> The theory I've been operating on is that the flusher thread ends up
> squatting on the xa_lock for a while when memory gets tight, and that
> blocks other readers and writers. Staying ahead of the dirty limits and
> limiting the amount of flush work that each writer does alleviates
> contention for that lock and that's what improves the performance.
>

That's right for comparison between buffered write against RWF_DONTCACHE.
But what I meant in above was for the improvement from 1179 MB/s to 1453
MB/s could be accounted to less contention on xa_lock on patched version
v/s unpatched version for single write sequential testcase.

> You're right though. I'll plan to play around with perf and see if I
> can confirm the theory.
>

Yes, thanks, that will be nice to have!

-ritesh

