Return-Path: <linux-nfs+bounces-21341-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOgPJ9DY9GmfFQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21341-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 18:46:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AAA4AE27C
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 18:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19E2B302ED5F
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D33E5EC7;
	Fri,  1 May 2026 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="t/A09e1g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CE3FA5E7
	for <linux-nfs@vger.kernel.org>; Fri,  1 May 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653864; cv=none; b=oNTU5E3zbA8seImLKFpRCUFKaZE0SjC3o0RaqRqBWC12SwJllG/6DQ3dyWoJbwxlZWhJiRcx3rBDvPU18L51A1dRQ/AMyAEt4wq0qqwkm6j56Z/IjIG6hVHph5uRycOfvAO6RpGscedIS3exZwZZASuk9+4Sgc/PPbI6nEfaouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653864; c=relaxed/simple;
	bh=BzpvNNe0Y7pWnImNb7utvKGVhDIu4ekSHRzW3u8hMCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJn/j64XnEROQfb+g3IZk8AglDfu8vaeq25AldrkylnhUjoVk7bwV0dFndlStRkz0Su6aBd1Mu0TnzerOKCdktmAGAuZEemCEjSIwyAynfN0sd2vsq9CQ/WReVx484GVnTB3owLm0tOt68WNDhCY4A2N+QZGGBzNIgcgJlbFz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=t/A09e1g; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so2020777a34.2
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2026 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777653854; x=1778258654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=258tSgDmQvsBwqYiudf3HzA2YcVV3/7qcjtUVSy9L94=;
        b=t/A09e1gBKwHej8bFSSsDKaY+HbwtWehYTY6lD/aQAbC6dd7DgC01GYCseKf6U4Drp
         Nbu7cxnKVoOHHYDRK0bMNqX38VmWz9bPLe7lXQjWZhwP8rQ+wBdaOc2TZfNjdTp+fq5n
         J4/yDwZY6l2DpYYyZBBrSJ/aqLOZvzOcbRlBtgtIyA+Ug2IyK8NITuZt1WnAr9tHJZU2
         2aNDB1xK/1sP9de7FFVxjaqR2bVfBbc7w3XUCpg2PuqK+E7TP8Awfn3yzKbmJMP3uTaR
         dqBtWdMDAUQ8PtDgW0rUmoblNP27wev8sG/a2YqsNsQVbkvVAj+TjSvxxHE4pKcUrX8K
         v6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777653854; x=1778258654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=258tSgDmQvsBwqYiudf3HzA2YcVV3/7qcjtUVSy9L94=;
        b=EHXc7Q86IudlXrczY50/ulLGlciPtIAf1CZQ8+G/GRBncrlKcQai9/r/w8zO5EsYje
         xS2N6J7yFucRuLBdQj6uoI10wKhgETZs4kxzMNKA8bu10ckneGz4zheA5Z8zfCgtzcdx
         WO9tswdbM1SgXlXvlUYQGH+xt5LipO90XD1x5y9Ch97C12Oc/X029e5Q24dEL8FCA28v
         HpO28YdahgVcEmKy86ZS97IkArWwwq0PhyH1xUveTp5QoJ41dsSfKzujIq79Du+aTxnr
         R/2/Am5xvPqi30x8xEY8d/z3zacRg9TCw3rPrVF1TlZsCqtf89Zk0NG9YUJsSq3OZKIf
         jCXw==
X-Forwarded-Encrypted: i=1; AFNElJ+LczEpWX4wP53MB5gVoa6zgos0u4IJDb0879abWknDImuiX8xZV18CVQLHiXpUQvirct3AZtLFWx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoi8hyOp5bfmxzIzWLf6V8cs5b2tHxsphIXl9mKNV1mRhdBI9z
	JKdOs5rM78Ir2Cx7H8RQoB3ASsXs2gX6qwIBIwDLBHHiT+Xz/ikvmQqt2tjCTP2yd4A=
X-Gm-Gg: AeBDietphxlRwLXim7HtFyDf9Q/lltZoi8thCDbgth5ziDxtNCavIeyW8WUNMqh/QfF
	YIgojuG4MB2HxYVqz11RRL4p9eeyb/lLRbXlJlNbCc+DrMvDG6LaSHTkeLoujRQ8+582n1djP5A
	F8UENDcHwzub7Xkg9Cfq8ZuCIXfLoJirIsdxOtrLZ2nYOYNAe6TD6orqnu/5/NLSJlB2aeAOaDq
	RBVWjpsIzdj+ya8gxGNPcgknaBLy2t1zX6oTtXn+d9BtkoBEvcjQofQlc898hi80vtFtWWpQZb6
	La0f/gw7GwuXywAcRfq2Y2o/tzzPQOdMYsrzvCKXL8Dnpb12cRcA16KxH0tFvg4l2KKujUmMDi6
	kfowyVpoEqxfqh5njlIaHaY4BPhQqtury2tW/317iH6H+eTRGtkRRJbhUo4E5wejt+wd+vVQaaI
	ywOn9ZiTOs/rYeHcI0A43/klIdU+vPX+H+XbskygHhRqDCfRszZeGBYzec0iTCLiRKnx5i/9sPp
	MQ9UtOU+MuegqdbV3o=
X-Received: by 2002:a05:6820:a04:b0:694:8c67:5cb6 with SMTP id 006d021491bc7-6967a5dbd54mr3873019eaf.41.1777653853660;
        Fri, 01 May 2026 09:44:13 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d8ed0dsm2836466fac.17.2026.05.01.09.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 09:44:13 -0700 (PDT)
Message-ID: <ec07180c-665a-4e78-94a4-1670a8bf8efd@kernel.dk>
Date: Fri, 1 May 2026 10:44:11 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] mm: kick writeback flusher for IOCB_DONTCACHE with
 targeted dirty tracking
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Mike Snitzer <snitzer@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20260501-dontcache-v4-0-5d5e6dc71cb3@kernel.org>
 <20260501-dontcache-v4-2-5d5e6dc71cb3@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260501-dontcache-v4-2-5d5e6dc71cb3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8AAA4AE27C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21341-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,infradead.org,linux-foundation.org,oracle.com,google.com,suse.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim]

On 5/1/26 3:49 AM, Jeff Layton wrote:
> The IOCB_DONTCACHE writeback path in generic_write_sync() calls
> filemap_flush_range() on every write, submitting writeback inline in
> the writer's context.  Perf lock contention profiling shows the
> performance problem is not lock contention but the writeback submission
> work itself — walking the page tree and submitting I/O blocks the writer
> for milliseconds, inflating p99.9 latency from 23ms (buffered) to 93ms
> (dontcache).
> 
> Replace the inline filemap_flush_range() call with a flusher kick that
> drains dirty pages in the background.  This moves writeback submission
> completely off the writer's hot path.
> 
> To avoid flushing unrelated buffered dirty data, add a dedicated
> WB_start_dontcache bit and wb_check_start_dontcache() handler that uses
> the per-wb WB_DONTCACHE_DIRTY counter to determine how many pages to
> write back.  The flusher writes back that many pages from the oldest dirty
> inodes (not restricted to dontcache-specific inodes). This helps
> preserve I/O batching while limiting the scope of expedited writeback.
> 
> Like WB_start_all, the WB_start_dontcache bit coalesces multiple
> DONTCACHE writes into a single flusher wakeup without per-write
> allocations.
> 
> Also add WB_REASON_DONTCACHE as a new writeback reason for tracing
> visibility, and target the correct cgroup writeback domain via
> unlocked_inode_to_wb_begin().
> 
> dontcache-bench results (same host, T6F_SKL_1920GBF, 251 GiB RAM,
> xfs on NVMe, fio io_uring):
> 
> Buffered and direct I/O paths are unaffected by this patchset. All
> improvements are confined to the dontcache path:
> 
> Single-stream throughput (MB/s):
>                         Before    After    Change
>   seq-write/dontcache      298      897    +201%
>   rand-write/dontcache     131      236     +80%
> 
> Tail latency improvements (seq-write/dontcache):
>   p99:    135,266 us  ->  23,986 us   (-82%)
>   p99.9: 8,925,479 us ->  28,443 us   (-99.7%)
> 
> Multi-writer (4 jobs, sequential write):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     2,529    4,532     +79%
>   dontcache p99 (us)             8,553    1,002     -88%
>   dontcache p99.9 (us)         109,314    1,057     -99%
> 
>   Dontcache multi-writer throughput now matches buffered (4,532 vs
>   4,616 MB/s).
> 
> 32-file write (Axboe test):
>                                 Before    After    Change
>   dontcache aggregate (MB/s)     1,548    3,499    +126%
>   dontcache p99 (us)            10,170      602     -94%
>   Peak dirty pages (MB)          1,837      213     -88%
> 
>   Dontcache now reaches 81% of buffered throughput (was 35%).
> 
> Competing writers (dontcache vs buffered, separate files):
>                                 Before    After
>   buffered writer                  868      433 MB/s
>   dontcache writer                 415      433 MB/s
>   Aggregate                      1,284      866 MB/s
> 
>   Previously the buffered writer starved the dontcache writer 2:1.
>   With per-bdi_writeback tracking, both writers now receive equal
>   bandwidth. The aggregate matches the buffered-vs-buffered baseline
>   (863 MB/s), indicating fair sharing regardless of I/O mode.
> 
>   The dontcache writer's p99.9 latency collapsed from 119 ms to
>   33 ms (-73%), eliminating the severe periodic stalls seen in the
>   baseline. Both writers now share identical latency profiles,
>   matching the buffered-vs-buffered pattern.
> 
> The per-bdi_writeback dirty tracking dramatically reduces peak dirty
> pages in dontcache workloads, with the 32-file test dropping from
> 1.8 GB to 213 MB. Dontcache sequential write throughput triples and
> multi-writer throughput reaches parity with buffered I/O, with tail
> latencies collapsing by 1-2 orders of magnitude.

I like this, this is the better way to kick off the writeback.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


