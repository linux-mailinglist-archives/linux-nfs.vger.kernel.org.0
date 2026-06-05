Return-Path: <linux-nfs+bounces-22324-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ck+GAEROI2qBogEAu9opvQ
	(envelope-from <linux-nfs+bounces-22324-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 00:31:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCBE64BA5B
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 00:31:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="JK/je/9B";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22324-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22324-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A1E3301BC22
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 22:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2CB33F597;
	Fri,  5 Jun 2026 22:28:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B623C3781
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 22:28:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698537; cv=pass; b=kzdFqfWQ62jVucNxlWz+dV+m7Y1HN5Gk5NHWgVQoEIRJEdJ4/+52ECyUkg8DOzNVY72PDb50N2ADzi7JqT+ZwPtTA+QUDj37qqO+Pj0U+4/JbyVri08NF0jsYxOpD/gtXVlxR08DLptaQQi0xtfZv4JgSDpwtJsU9w3xK6NuAOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698537; c=relaxed/simple;
	bh=G8ucQDmjTQN0M6fZZIL7qhkeTXAC9KisZu7iQ8AYIJc=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF/P2WU2L6ok0Y6owQcpQ1IG/VN5F9YlPGoArBg4yzS0TYuM0fGqKHzRvOykjTGoyq+CZapF6lFiV+WD3BzEjHvAhz49T3nEWz8ErP+SKQP2aIwU8XO4am81yAHLi3vD+8uS32FI/QZsLGRm+jTY+Bj3vtO4v6ZkRX8KLGC90p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JK/je/9B; arc=pass smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1841902f8f.2
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2026 15:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780698534; cv=none;
        d=google.com; s=arc-20240605;
        b=G3EQgTnnsMBKeIHR2gFJAB7oQJKxR6q47ec2R+QObRGALzD2llp2PnBVE1Ea/O4bdM
         JH6W8YRFJxurDqO9VLoIsOHtNoXtYv6ZS2x3ABKFxQTmfLC2XZgyQGgohn7xcoRUZHMO
         EyDGKTz7odGrmAlRyPGh7ncF4iiBdMi3qXhXxNprrJZgHelJCZMHeqgQQ207K0C5bGoB
         4j1uwqJK6oRHeNL174xOBw1/GdMJ6aHEF2axxsmP//XTG/YNgSe1LNbcSd/1C9pM68TU
         c+VdRQja+RN1BjqYfRAxqJCfQHC/9e2F8WvmT5PSNN5wLlbWWnT1Gx4ohZTKOIaVu1KC
         tAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:dkim-signature;
        bh=lIJxdTrt49LBtHsHDIl4ZVxkc79PG/95V0H7WpUpRU0=;
        fh=+OX2oVlnyyptMJNj3fmjfDplbfRFYVTbxl3EruomDdQ=;
        b=RKFWHw7XAz6r2RPC6hKy2ebHRC3z2VpNia1lJILjKoPgeT+RQYzKVqcxNmia4nykGH
         c2ZZJE8IY3npPPyh8s3OJ9ZJqPRGQ1HRDxEilsuQxgesm0FfRffU274NZzIp3rP17dre
         d3LrRFZKZqgiv+LrHEq3kTPprDNzyMR/jZWfx3A/EN4gprNk40rWVM4dZ1VEetQhJRcn
         bpv5qIKtNQFC2XoFqD05jfHeoPYneHyiihXIW2i22P8Oc+LZSvu6nqr/pI+jLaTUz4zK
         OtmI+9UsHdAgePaWhPfstpa5nuQks2nrLpFoQdz1MFh4xBevVIzouGRzAJnvbRBKiofH
         arkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780698534; x=1781303334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lIJxdTrt49LBtHsHDIl4ZVxkc79PG/95V0H7WpUpRU0=;
        b=JK/je/9BGLFktqngfPbepm+Ypd0alfJR3quQI7G3f5sjvvJ1/sqzgsW4Y6Scv38gfm
         BgSVdduPPipxSR8xS7zFBqOQlnzA5e1uyCZFoHTx6N+mnq+Mx1+DS74XJXOgi31jsA4t
         M96NL5LsBgh9rBqzLuttsdzwVN3hrvuFjDhGJDtru3auJCk8KqYdP2UEv8JdHgqOYDbG
         V4LxMxiRdvJ0yHk2txZk/u2Wbge9lZK0NST0mWOVpElRfAkSjDoIn3ONV7d+8FNxBpZ8
         Spfv1eR2WeHOWBH7x9KvWgzXaTYScH8pP2ikMpdlBjaDwh+6CgFI5/fBW/pfq/sWzD75
         KCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780698534; x=1781303334;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIJxdTrt49LBtHsHDIl4ZVxkc79PG/95V0H7WpUpRU0=;
        b=V+30uKg0kRHMX129ScMcqhP5x6AqgUahWc6O3FfWkHdy4F102VbaeL/mA9vigQscJe
         iXMPGEXo4sp40sKjGDBIyqJnlu++BYsDADLYSkpLtYr5XEdiCLDnFM8/4MvZCo96bN2b
         qCj8SVdzJL96Pw1b5PRIKmvT2US75eojlnqiMRx0pmik95B/o3IeefvJvivjwiAJwLMA
         RxaYFO5jRbPhV+yFhIWW6B6RRRhiqdRTQNxnVLn38UDfKuNFxxxmhHZbhpCjzbq2TMFk
         TwtcoRtmdjGL0GKAqV8yGM/R1O1XSmAXTexU0CHHUV7kV3GVGwlj1gS4n/gPIwPK65Rn
         4qfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2Jfp1EVR4+FMYMqCPS/8lrX9N/V+FVqciq36DV6Fx9ZSQ5Ek1/GYaLQAz9/05KAMWxu331JGpUhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1URwqWPGPhXlUIl/K+I/54Rvgz7kCxRSEE8Znk8oEMKNF1DFq
	N1bcA+rjKkXOuqzBguy6OOlTM6HAxXRuHHbR8V9V+XZ1gaosRelH+tAyQfAXlmV91iIofBqrAWd
	imcst3QQoql8kl8oVaySnlh7VyqASI1mx7vyAuMeGrg==
X-Gm-Gg: Acq92OHErKfcMnm9DorvLBm03t4OZs5H4K3/M6vNC9/xNoD84nj7MwDQCG0i36jIraJ
	oFwdL9DUgcIH4RmH07raP515mXaoNQhpy6COB3YKhp5+Ss90UDRzOSyTVlZ0SKVcoZ7r1vqwIrG
	TtrNNJf0y/ktjN/14AYwfhZu5TAOXBQphGCMcX42Y/nfAhTSZPPHB+7dMgB41Cr2kl0SWeNPQFO
	AwRIaFhum9of/am848az1CNpBk6CwvxPj8VcZxtsvjfupQOs/mgWisOCrjA3Q8OB2f9Gw5HixqT
	SXpe1fhGakW/MOO7d2hm42eRjO4=
X-Received: by 2002:a5d:51d0:0:b0:452:11f9:bc40 with SMTP id
 ffacd0b85a97d-460302e03c7mr6617498f8f.2.1780698534179; Fri, 05 Jun 2026
 15:28:54 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
References: <20260319133610.2556826-1-cel@kernel.org> <aiHlPmeZq3WgMwoJ@kernel.org>
In-Reply-To: <aiHlPmeZq3WgMwoJ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEEouOnWSU9Hw+yWO6kqMEwMu7NIQGQWYGht9SoVsA=
Date: Fri, 5 Jun 2026 16:28:51 -0600
X-Gm-Features: AVVi8Ce_x27nsYedtX2uQIpgpMB-fB_mNZzLiYuizjuXABPWhrm88_d8K6ytSDs
Message-ID: <3cb119b4b2a8aada30c0c60286778a54@mail.gmail.com>
Subject: RE: [PATCH v4] svcrdma: Use contiguous pages for RDMA Read sink buffers
To: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <cel@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@ownmail.net>, 
	Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: multipart/mixed; boundary="0000000000009540740653892fc8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:snitzer@kernel.org,m:cel@kernel.org,m:leon@kernel.org,m:hch@lst.de,m:neilb@ownmail.net,m:jlayton@kernel.org,m:okorniev@redhat.com,m:dai.ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-22324-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,ownmail.net,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBCBE64BA5B

--0000000000009540740653892fc8
Content-Type: text/plain; charset="UTF-8"

> -----Original Message-----
> From: Mike Snitzer <snitzer@kernel.org>
> Sent: Thursday, June 4, 2026 2:51 PM
> To: Chuck Lever <cel@kernel.org>; Jonathan Flynn
> <jonathan.flynn@hammerspace.com>
> Cc: Leon Romanovsky <leon@kernel.org>; Christoph Hellwig <hch@lst.de>;
> NeilBrown <neilb@ownmail.net>; Jeff Layton <jlayton@kernel.org>; Olga
> Kornievskaia <okorniev@redhat.com>; Dai Ngo <dai.ngo@oracle.com>; Tom
> Talpey <tom@talpey.com>; linux-nfs@vger.kernel.org; linux-
> rdma@vger.kernel.org; Chuck Lever <chuck.lever@oracle.com>
> Subject: Re: [PATCH v4] svcrdma: Use contiguous pages for RDMA Read sink
> buffers
>
> On Thu, Mar 19, 2026 at 09:36:10AM -0400, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > svc_rdma_build_read_segment() constructs RDMA Read sink buffers by
> > consuming pages one-at-a-time from rq_pages[] and building one bvec
> > per page. A 64KB NFS READ payload produces 16 separate bvecs, 16 DMA
> > mappings, and potentially multiple RDMA Read WRs (on platforms with
> > 4KB pages).
> >
> > A single higher-order allocation followed by split_page() yields
> > physically contiguous memory while preserving per-page refcounts. A
> > single bvec spanning the contiguous range causes
> > rdma_rw_ctx_init_bvec() to take the
> > rdma_rw_init_single_wr_bvec() fast path: one DMA mapping, one SGE, one
> > WR.
> >
> > The split sub-pages replace the original rq_pages[] entries, so all
> > downstream page tracking, completion handling, and xdr_buf assembly
> > remain unchanged.
> >
> > Allocation uses __GFP_NORETRY | __GFP_NOWARN and falls back through
> > decreasing orders. If even order-1 fails, the existing per-page path
> > handles the segment.
> >
> > When nr_pages is not a power of two, get_order() rounds up and the
> > allocation yields more pages than needed. The extra split pages
> > replace existing rq_pages[] entries (freed via
> > put_page() first), so there is no net increase in per- request page
> > consumption. Successive segments reuse the same padding slots,
> > preventing accumulation. The rq_maxpages guard rejects any allocation
> > that would overrun the array, falling back to the per-page path.
> > Under memory pressure, __GFP_NORETRY causes the higher- order
> > allocation to fail without stalling.
> >
> > The contiguous path is attempted when the segment starts page-aligned
> > (rc_pageoff == 0) and spans at least two pages. NFS WRITE segments
> > carry application-modified byte ranges of arbitrary length, so the
> > optimization is not restricted to power-of-two page counts.
> >
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> > Changes since v3:
> > - Drop 1/3 - 3/3, they have already been reviewed and queued
> > - Incorporate hch's review comments
> > - Remove the #ifdef SZ_64K -- the logic works on those systems too
> >
> >
> >  net/sunrpc/xprtrdma/svc_rdma_rw.c | 213
> > ++++++++++++++++++++++++++++++
> >  1 file changed, 213 insertions(+)
>
> This patch, which landed during the 7.1 merge window as commit
> 18755b8c2f241 ("svcrdma: Use contiguous pages for RDMA Read sink
> buffers"), severely hurts RDMA performance when testing on very fast
RDMA
> networking on x86_64.
>
> With this commit WRITE performance is "only" 24.2GB/s.
> Without this commit WRITE performance is 60.6GB/s.
>
> The cpu burn due to spinlock dominates the flamegraph that was
collected.
> Chuck, I'll send you the flamegraph off-list (and can send it to anyone
else who
> might be interested).  Jon Flynn did the testing and we can request more
info
> from him.
>
> We may have a window _now_ on the current Hammerspace testbed to try an
> incremental fix, but as of now simply reverting commit
> 18755b8c2f241 is as far as we got.
>
> Thanks,
> Mike

Chuck, All,

Here is link to a bundle containing the test environment documentation,
benchmark results, system characterization, and perf data collected while
investigating the performance regression associated with commit
18755b8c2f241 ("svcrdma: Use contiguous pages for RDMA Read sink
buffers").
https://1drv.ms/f/c/522bdd4fbd5c042b/IgBszn47Y5ShQZzEqo9yQQfVAdlNkI2XCJBUK
NA23ikzE2c?e=fqUquj

Summary
Testing was performed using a single NFS/RDMA client and server connected
via dual 400 Gb/s ConnectX-7 adapters. The server exports four XFS
filesystems backed by four independent 8-drive NVMe RAID0 arrays. In the
phase1 steady-state run, the module containing commit 18755b8c2f241
achieved 30.3 GiB/s (32.5 GB/s) of write throughput versus 73.9 GiB/s
(79.4 GB/s) with the commit reverted. Average server system CPU
utilization increased from 8.54% with the commit reverted to 76.35% with
the commit present. Standard perf profiling consistently showed
significant CPU time spent in the page allocation path associated with the
contiguous buffer allocation logic introduced by this change.

The best starting point is:
* 'test_environment_configuration.docx'

That document summarizes the server, client, networking, storage,
filesystem, NFS, and workload configuration.

**Bundle Download**
The bundle layout is:
- 'system/'
  * Server hardware/software characterization
  * CPU, memory, PCI topology, NICs, RDMA, NVMe, mdadm, XFS, and NFS
configuration

- 'client-system/'
  * Client hardware/software characterization
  * NICs, RDMA, NFS mount configuration, and per-mount mountstats

- 'regressed/'
  * Data collected with commit 18755b8c2f241 present

- 'reverted/'
  * Data collected with commit 18755b8c2f241 reverted

Each of 'regressed/' and 'reverted/' contains:
- 'phase1/'
  * fio output
  * Server CPU utilization captures:
    * 'mpstat.txt'
    * 'sar-cpu.txt'
    * 'vmstat.txt'
    * 'top-threads.txt'

- 'phase2/'
  * Standard perf profile:
    * 'perf.data'
    * 'perf-report.txt'
    * 'perf-report-children.txt'
    * 'perf-mm-lock-summary.txt'

- 'phase3/'
  * Raw lock contention tracepoint collection:
    * 'perf-contention.data'
    * 'perf-contention-report.txt'
    * 'perf-contention-script.txt'

Regarding collection methods:
- Standard 'perf record' profiling was collected successfully and produced
usable call graphs and allocator-focused summaries.
- 'perf lock' was attempted, but it did not produce useful contention
information on this kernel/configuration.
- 'lock_stat' could not be used because 'CONFIG_LOCK_STAT' is not enabled
in this kernel.
- As an alternative, raw lock contention tracepoints were collected using
'lock:contention_begin' and 'lock:contention_end'. These traces are
substantially larger than the standard perf captures due to the volume of
contention events observed during the regressed test runs and should be
considered supplemental to the standard perf profiles.

The primary comparison is between the regressed module containing commit
18755b8c2f241 and a locally rebuilt module with that commit reverted while
keeping the remainder of the kernel unchanged.

Please let me know if there are any additional traces, instrumentation, or
workload variations that would be useful.

Thanks,

Jon Flynn

--0000000000009540740653892fc8
Content-Type: application/vnd.openxmlformats-officedocument.wordprocessingml.document; 
	name="test_environment_configuration.docx"
Content-Disposition: attachment; 
	filename="test_environment_configuration.docx"
Content-Transfer-Encoding: base64
X-Attachment-Id: c63a33431d87cff5_0.1

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
BgAAAAAQABAADAQAAAswAAAAAA==
--0000000000009540740653892fc8--

