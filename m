Return-Path: <linux-nfs+bounces-21203-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK8HC7z372mFMwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21203-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 01:56:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985ED47BFDD
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 01:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27FA300AB25
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533E237C93C;
	Mon, 27 Apr 2026 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcuFY12v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52BA3B7747
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334138; cv=none; b=AnvRYt4+p4PpvRD1agvXe2w2zqrJquq9AGOc2+neUJr6ImisfsDe6eGG1VQiEJYe91XraHVXxIk2bNDarzLZDM4Zlf9fOGD6FusFsJoKcX4Z/MJKTG+6qFeEE4xYhER9fHDR3lzefKLhgJn0ESmp2HPVpdm2liwOVC4XmoHfGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334138; c=relaxed/simple;
	bh=6kXywhWGRAqfZcJnUKbUhCWuhKfcPlm4r7kE4iiYotc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Z73w/p0ZjEDRN0lAKcr7lE9Ocz6BXg8kKPpP8WzoiSynyhvBbfFZqjMkBEScH9cJW/u9bUoBGJVJvH+suHJp3R51FyqOYXvHC5O7z+a4yDSuhZSjncYvCeW9VlR0ZgxhzEgjw0aJX2ZOSwFi9PQI3Q8Vkklxji5G6jxsnDwmX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcuFY12v; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso3422621a12.3
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 16:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777334136; x=1777938936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgEWh+XI0SPB+PinHXs94gFrx3gTRtQhlrntWyMIEwk=;
        b=LcuFY12vVWO7vqr/F2eC3lhWHJSOrNATLXKt11bZknSt/jmHAxsCa2fq2Ckhzgs7NQ
         T8QpxY+aYZ3vCgmQb9W6CSCt2LA0PDBSio0kY8RaE7Sr6SW3O00EBhl3ZZ0J6pXuLEvR
         swqpCtV80o4ODeBpHUah5QPL6PmX0/KH6vUG0Pep/7K4KlJNbBcSE2QlcHthpQdiYZ4w
         0xpYVlAWQSWHB0YqA33sw6Taa2E+8uRo6+Z5cql+8zkAREGDa229fEbeIrn0V4h7d4xP
         XhmHqtO7BENBYcmIGM7OkvSZNX6Y+jW1/Ai3jO87L3H68gl7+jpqeLKDqPpVSqLvaEfA
         ZiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777334136; x=1777938936;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zgEWh+XI0SPB+PinHXs94gFrx3gTRtQhlrntWyMIEwk=;
        b=HN0tEoOrNQIcHSd0dvK6/GR3XA0UPxeZbHCNWaJWdys3IabxuNqGqkx/fTiu1a7O2G
         ERmDDAnfjrAb7CIhaYxqBOvcKtpJO93X2ghCYXWmye336LwAZTtRFn0FKlVogNMIiOBV
         zGYASMBf5UPTuxDHNq7UTmVkxcJkqmEfzBmUE08et4BSjB+YgqYXGvwPd1HJmBWQQ9k0
         00BOXUjsoe7bQLP8R9w4yrz7qXoksqeT6x7d3T7VWHyDZWwhjvNDTLq9FvkDwD+gwBxm
         sEvj2xn9AUPvDOpO3ZRonUXTkWBU8Rc/q3QTUBFi5lukAkXpj1+AJYnvpmmzKIlqKh8b
         RPRg==
X-Forwarded-Encrypted: i=1; AFNElJ9xFwF7FRc4Js2Di3gfuyDwlyQQ9DgdZShWuRLYjQisRBifB0hfOjyTNprTwMKbfzQEGd9FgqIzcOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9sB7l7fygbqTFRwakDssZH7o6bMs+8hP1uW/eJQHF9OloxWp
	Aw5fM3E0GuzvfF0VMIyeyBZZKBvwIE3LxIckB/Ef86A285aQalOR/Zmd
X-Gm-Gg: AeBDievxSprvbzL4LNPPBYcXWzikvKrzV/sG0qHgrCMldQohB+gQrMN3Rk3uGJ0ykAW
	5Ka6MZUKbxuvzt4wBwrTOoBO8ova1Yde5kyOpmZajvVusi8vXYBaXfkRGh82TBbc0SiK5KOCQIP
	QHgMpIKkpOX6v+xAZOv35hA4sg6SSvwG6TZBO/TGlKZLdDm2Qi/alDOGmPN7buZkx6pK52CyJfv
	TgHDWJtjOPrLxonyoQYzyuKkoIB6xEElxX5ahUHwLwgqQNxHfbpsMuwwOVz8+0JQQ0jynsQXh2/
	qMosQTsBE6Ds90gKVj+vbLTK2jgZSdRmoIGvoC3XYYVttQS1GLBJPQkFPxZj4SI4vIIFHh5f0Zh
	fi3MSaI3ZYY8NwtiGig2I+livLuaotMZSRkkgSK1SGpbJr8VpInWDa2nsLu9m5nXVSbZvpGmh0S
	ZuUzi7bDv6Drs5/D6+Q0yM/DAxzI+vpdyU
X-Received: by 2002:a17:902:76c3:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2b97c43c746mr4936135ad.12.1777334136066;
        Mon, 27 Apr 2026 16:55:36 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97a96cc61sm6493415ad.0.2026.04.27.16.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 16:55:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: kick writeback flusher for IOCB_DONTCACHE with targeted dirty tracking
In-Reply-To: <bb418f9a7bfcabc3070b412c745c5b6456d592b9.camel@kernel.org>
Date: Tue, 28 Apr 2026 04:56:10 +0530
Message-ID: <jytsrnn1.ritesh.list@gmail.com>
References: <20260426-dontcache-v3-0-79eb37da9547@kernel.org> <20260426-dontcache-v3-2-79eb37da9547@kernel.org> <qzo1s6a4.ritesh.list@gmail.com> <bb418f9a7bfcabc3070b412c745c5b6456d592b9.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 985ED47BFDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21203-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Jeff Layton <jlayton@kernel.org> writes:

>> 
>> Also should the following change be documented somewhere? Like in Man
>> page maybe? i.e.
>> Earlier RWF_DONTCACHE writes made sure that those dirty pages are
>> immediately submitted for writeback and completion would release those
>> pages. But now, in certain cases when there is a mixed buffered write in
>> the system, those dontcache dirty pages might be written back after a
>> delay (whenever the next time writeback kicks in).
>> However for RWF_DONTCACHE reads, it should not affect anything.
>> 
>
> Looks like DONTCACHE is documented in the preadv/writev manpage. Here's
> the current blurb about writes:
>
>     Additionally, any range dirtied by a write operation with RWF_DONT‐
>     CACHE  set  will  get kicked off for writeback.  This is similar to
>     calling  sync_file_range(2)  with  SYNC_FILE_RANGE_WRITE  to  start
>     writeback on the given range.  RWF_DONTCACHE is a hint, or best ef‐
>     fort,  where  no hard guarantees are given on the state of the page
>     cache once the operation completes.
>
> I don't think this verbiage is invalid after this change. Kicking off
> writeback is still just a hint, like it was before. We could mention
> about how that I/O can compete with regular buffered I/O, but it seems
> a bit like we're adding info that will just be confusing for users.
>

Make sense.

>> > dontcache-bench results on dual-socket Xeon Gold 6138 (80 CPUs, 256 GB
>> > RAM, Samsung MZ1LB1T9HALS 1.7 TB NVMe, local XFS, io_uring, file size
>> > ~503 GB, compared to a v6.19-ish baseline):
>> > 
>> 
>> Can we please also test parallel buffered writes and dontcache writes? 
>> Since this patch series definitely affects that.
>>
>> BTW - adding these numbers in the commit msg itself is much helpful.
>> 
>
> To be clear, this only affects DONTCACHE, not normal buffered writes,
> but I guess you're referring to the fact that DONTCACHE and buffered
> writes can compete now.
>
> Can you clarify specifically what you'd like me to test here? Are you
> saying you want me to test parallel and buffered writes together at the
> same time (i.e. make them compete?).
>
> I should be able to do that for the local benchmarks, but nfsd's iomode
> settings are global and that won't be possible there.
>

The reason I am thinking of this is: dontcache marked pages, gets
evicted from page cache after they are written back. But this patch
series can now delay that from happening when there is a parallel
buffered writer dirtying page cache pages. Because of the reasons we
already discussed...

Note that, this may not be a workload which matters in the real world,
but I was thinking, it will be good to know the impact if any, of such
workload with this patch series (parallel buffered and dontcache
writers).


>> >   Single-client sequential write (MB/s):
>> >                        baseline    patched     change
>> >   buffered              1449.8     1440.1      -0.7%
>> >   dontcache             1347.9     1461.5      +8.4%
>> >   direct                1450.0     1440.1      -0.7%
>> > 
>> >   Single-client sequential write latency (us):
>> >                        baseline    patched     change
>> >   dontcache p50         3031.0    10551.3    +248.1%
>> >   dontcache p99        74973.2    21626.9     -71.2%
>> >   dontcache p99.9      85459.0    23199.7     -72.9%
>> > 
>> >   Single-client random write (MB/s):
>> >                        baseline    patched     change
>> >   dontcache              284.2      295.4      +3.9%
>> > 
>> >   Single-client random write p99.9 latency (us):
>> >                        baseline    patched     change
>> >   dontcache             2277.4      872.4     -61.7%
>> > 
>> >   Multi-writer aggregate throughput (MB/s):
>> 
>> Can you please help describe this test scenario if possible.. In above
>> you mentioned we are writing file_size as 2x RAM_SIZE. But your
>> multi-client tests says something else..
>> 
>> local num_clients=4
>> +	mem_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
>> +	client_size="$(( mem_kb / 1024 / num_clients ))M"
>> 

I guess you missed answering this. The reason why I was asking about this is....

>> >                        baseline    patched     change
>> >   buffered              1619.5     1611.2      -0.5%
>> >   dontcache             1281.1     1629.4     +27.2%
>> >   direct                1545.4     1609.4      +4.1%
>> > 

... If we see the performace of buffered and dontcache in baseline case,
then we don't see dontcache doing any good. Even the patched version is
just slightly better compared to buffered case.

But IIUC, dontcache should really shine in cases where we have buffered
writers dirtying the page cache pages which can overflow the RAM size
[1]. The reason why dontcache should show benefit there is, because we
don't see any page cache pressure, since after writeback the pages gets
evicted. Also earlier in the unpatched version, the I/O submission
happens immediately in the same context.

So, I guess, isn't it better to evaluate those scenarios as well with
the patched version - since this series affects those code paths now?

[1]: https://lore.kernel.org/all/20241110152906.1747545-11-axboe@kernel.dk/

>> 
>> Nice :)
>> Some explaination here of why 5x improvement with NFS compared to local
>> filesystems please?
>> (I am not much aware of NFS side, but a possible reasoning would help)
>> 
>
> I suspect that it's because of the "scattered" nature of nfsd writes.
> When the client sends a write to nfsd, we wake a nfsd thread to service
> it. So, if there are a lot of writes operating in parallel, they all
> get done in the context of different tasks.
>
> My hunch is that this I/O pattern (writing to same file from a bunch of
> different threads), particularly suffers from the DONTCACHE inline
> write behavior. The threads all end up competing to submit jobs to the
> queue and that causes the performance to fall off sharply.
>

Thanks!

-ritesh

