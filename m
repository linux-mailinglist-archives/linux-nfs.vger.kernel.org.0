Return-Path: <linux-nfs+bounces-22339-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id huCmL4paJGpy5gEAu9opvQ
	(envelope-from <linux-nfs+bounces-22339-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 19:36:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4A64DF86
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 19:36:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=TMOTRTXF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22339-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22339-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3AE030046AF
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186092E7388;
	Sat,  6 Jun 2026 17:35:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E32E7360
	for <linux-nfs@vger.kernel.org>; Sat,  6 Jun 2026 17:35:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767359; cv=pass; b=M0BgSq+t/OpInEEmaxibSVioap1ifU/HQBv0q5Q2Gmv7UZpw3SwR4PhC3ocxKb0SnrNesRiZ3ILyecg28q8uAFYUHS8bmw80uZsqsCzt0ZRyEiEIy0IqRAIknuIfDVxtmWwwtVWYx5xAt0H/5WaiXdZCdabYhdgQ7mIhgYaCNlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767359; c=relaxed/simple;
	bh=kaIOlM2dR399VfkohKkulIGjRFRv1YLOvYZvYkxuEv4=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVQuDT4JpZ0Mn5d3WzfWy3L0ElpERBNCW2XahoZ1hUja1PyrQ3c8FACANoYt9AADfBi5/7mKNbhRq9923hVIvQTnD/x0Cvxzney3GBuyw62a2zrl/QD6i/EekyX/8eFDw2nH6rTnKzs4dd7kXdhLQg6obMRWi+1b5NXkMss00gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=TMOTRTXF; arc=pass smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so32479265e9.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jun 2026 10:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780767354; cv=none;
        d=google.com; s=arc-20240605;
        b=TGjXpOsPZZK0oOZJ0+SV7XZ6iVdSZoVMYecP6yeB45wt5O9bHIU6sP+6L4TFwJ4b6k
         Olq3T2kuyADbAdL6pdtQN6JE5pmQmBoEQjyPxk6rNQTAaQtYjLJX7djV3pH+JJSEq745
         8AYJzXXy23KiOKuyqvKFjrxnujZooOMO7gv9oOT8OsSLsMkJq7XIlBpQ9tIolkDNlx1l
         FaO3CSnHlTpKWHHV2lUnryxx7766ZPU2bx0neIH0iSeZKDrIcz1lLkMUpxXfOdyb8cvu
         tCG8+/FOaJV/+yowm6jpA2Fh6jFMBw22tgmCQfzDgE+SN5HCjK1tkVqGCEx8esgCaDdT
         v29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:dkim-signature;
        bh=Hppu2DGhG4EZwt2QnaFLsyyEt3kmcDDCj2adKDQrCl4=;
        fh=zclRT0AL/VU5GNEzXpWBMxRZa9n+H0QFGVGjNlhFdfI=;
        b=D9VwCwWsm7yj/WK6rYAF5jmS59+fScP4k2KfLvm/8aVwFS89cJl/L5VN3XT+D3b62S
         bygI4sdlg/Jq+KzF48OiO2FMSyefH8sbb0pKKnv9BP130KBNTwQGfcXdypv//kj+Ts34
         guEyresGmMg54xFZKdKyPZatu02TC5F6XrdLqrrmenv67E+PK9puyZqasxvKRZeP7eb2
         FKc1zW7YSAUjfULzaq0nQ+MT+D9NULtvikW5tgVjly3a0ueAhMx/cb/gRJ+5am9/JJU5
         um2omI6yLzMLUuXgVrM7vx/SWG0Eoulc6Qh8tbiLYWylKD67/7a594vgva//Lq1snzu2
         ZsCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780767354; x=1781372154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hppu2DGhG4EZwt2QnaFLsyyEt3kmcDDCj2adKDQrCl4=;
        b=TMOTRTXFD/GN1jg5cEc55ASv/xygFpFonwc7TEeuAnBgHV3VtNeRTnVtzD2UTN6vli
         oZA7U5IxuhVmIN/QpASUBZRwsyGu8bVGwti0B7cMRoCNn2TKbblNkE+lOuTefwLcM1Uf
         TfaGALGyQwLS7STQbmB1Zys8ajSV29qeVAJwXn6qcFt//lylEnXcdWrQq/b81fFy6tam
         1TBX0qCLvmiYMzFFl4fNM5luaBFYckyYFUr7ZP1D0SVc4Uwfx32kUei4W/ZCOrCb3NZ0
         Ri/p4bz6ICkwWwmxTRDTCzun5/7l6XKAJ2BXvk+Jj9hEfxt6MYfEHY5DKS8NQ4Vw8avP
         8TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780767354; x=1781372154;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hppu2DGhG4EZwt2QnaFLsyyEt3kmcDDCj2adKDQrCl4=;
        b=eXCptTJHttWBdUGZ+om9h5iyIN7qNzSjTSenW4uiHUToZ7TqfFOhrGldPJs6Y/LPhR
         UNsRxDj5f9yqfu6RlsQNK5wTqa+4Zifr6WXa4AFfEgxDbMSpoW5Fl6ALefO5RRzfwpCh
         VxcEpOEntMHJzWEvZlYHcPq7kzpr+0QsOIFNb8ialoagCsV0fA42QtBAvmK6gu90oBSH
         05db9qE5wPx97lSQbsBUMJYEd2+CZMuJNpiqPTEYbJu7x4VlFdb1Ri0XqxpXREikECMS
         RiN/sWmnVPRi9DYYZRESKlUa6aI7vC3xFJ5f6y2g53G1g762P7WmNHoWQUFEiBfysE0D
         n77g==
X-Gm-Message-State: AOJu0Yx+HcFyv0B072pwjqcwJ/KMN5kTidGTU/ofMjJyzVGECmftdl4i
	PkgKEed6Yon9FGzP0pO5MyCdW8yTjvTc4F7HXOtXJQd0UL65LPur/+5BWCWgokpSBWTCrN0oh8n
	ciqiIYUoMoK6WLk6yDs8L5Xbiij4L2owuYW6pfh/BuQ==
X-Gm-Gg: Acq92OFys/TlSkBUxTSQqnGIWoP8cVMUcncTUkHN+xlEdhj+FOqKDLlnT1s2FwYvSjJ
	v/NfEEyTjQXB2P2jE5jArQ5AMQXLwLdNIlOBuTZs8p7kVrIcHQRsu9VAtunnSC0tcvl8YYHktD5
	NHvw0irDWchmA6kq8HWrOQ3VW2203JK9FcbFI27IghOIMelXK/KbKyVxV7g8mIeOIPPFDUZU66a
	3Tvw1Flb0at38bAxqYM9Cic9pmohJM7GnaGUg3mTseKuqmOwU6sj/Q+Fu/2fCZ459xSaCoP6FPi
	XdqjK8ji3hmj1jdW
X-Received: by 2002:a05:600c:4fc6:b0:490:b432:6f1e with SMTP id
 5b1f17b1804b1-490c2614bf9mr144449255e9.33.1780767353362; Sat, 06 Jun 2026
 10:35:53 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
References: <20260606035722.83175-1-cel@kernel.org>
In-Reply-To: <20260606035722.83175-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMa29E4u4Im5YIb7ViXmqyooY1UybO1/K8Q
Date: Sat, 6 Jun 2026 11:35:51 -0600
X-Gm-Features: AVVi8Cez9uncDsFw8DZPkODWXV4aG8-aKGtQeYnLtb6-RB7MYGS0NV-SQUjhB-Q
Message-ID: <65a2cdb132b0c28e69a29955e3bd37e7@mail.gmail.com>
Subject: RE: [PATCH] svcrdma: Cap Read sink allocations at PAGE_ALLOC_COSTLY_ORDER
To: Chuck Lever <cel@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22339-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.flynn@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11D4A64DF86

I tested the PAGE_ALLOC_COSTLY_ORDER change on the same setup.
Unfortunately, it did not improve the regression. Throughput was slightly
worse than the previous GFP_NOWAIT test, measuring 25.4 GiB/s.

Current results are:
Original regressed build: ~30.3 GiB/s
GFP_NOWAIT build: ~31.0 GiB/s
PAGE_ALLOC_COSTLY_ORDER: 25.4 GiB/s
Commit reverted: ~73.9 GiB/s

I added the results to the shared bundle. (including flamegraph)

The GFP_NOWAIT and the Original Commit flamegraphs are nearly identical.
The dominant stack being:
svc_recv()
-> svc_rdma_build_read_segment_contig()
-> alloc_pages_noprof()
-> get_page_from_freelist()
-> rmqueue_buddy()

The PAGE_ALLOC_COSTLY_ORDER flamegraph is different. Time spent under
alloc_pages_noprof() is reduced, but the reduction does not translate into
improved throughput.

The following percentages were observed:
                                                   Original     GFP_NOWAIT
COSTLY_ORDER
svc_recv()                                 76.09%      75.99%
78.44%
alloc_pages_noprof()             58.07%      57.99%               40.29%
folios_put_refs()                        7.15%        7.19%
16.06%
svc_rdma_read_complete()    7.18%        7.21%               16.08%

In other words, the PAGE_ALLOC_COSTLY_ORDER change reduces time spent in
the allocation path, but a larger fraction of CPU time then appears under
svc_rdma_read_complete() and folios_put_refs(), while overall throughput
decreases further.

-Jon

> -----Original Message-----
> From: Chuck Lever <cel@kernel.org>
> Sent: Friday, June 5, 2026 9:57 PM
> To: Mike Snitzer <snitzer@kernel.org>
> Cc: linux-nfs@vger.kernel.org; linux-rdma@vger.kernel.org; Chuck Lever
> <chuck.lever@oracle.com>; Jonathan Flynn
> <jonathan.flynn@hammerspace.com>
> Subject: [PATCH] svcrdma: Cap Read sink allocations at
> PAGE_ALLOC_COSTLY_ORDER
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Jonathan Flynn reports that commit 18755b8c2f24 ("svcrdma: Use
contiguous
> pages for RDMA Read sink buffers") regresses NFS/RDMA WRITE throughput
> from 73.9 GiB/s to 30.3 GiB/s on a 128-core single-NUMA-node server
driving
> dual 400Gb/s links with 640 nfsd threads. In the regressed
configuration,
> server CPU utilization rises from 8.5% to 76%, and 73% of all server CPU
cycles
> are spent in native_queued_spin_lock_slowpath.
>
> The contended lock is zone->lock. The page allocator serves allocations
only
> up to PAGE_ALLOC_COSTLY_ORDER (3) from its per-CPU page lists;
> SVC_RDMA_CONTIG_MAX_ORDER is 4, so every contiguous sink buffer
> allocation falls through to rmqueue_buddy() and acquires the zone lock.
The
> workload above issues roughly half a million order-4 allocations per
second,
> all serialized on the single zone lock of the one NUMA node. Replacing
the
> GFP mask with GFP_NOWAIT did not change the profile because direct
> reclaim never
> ran: the cycles are spent acquiring the lock, not reclaiming memory.
>
> Cap the allocation order at PAGE_ALLOC_COSTLY_ORDER so contiguous sink
> buffer allocations remain eligible for the per-CPU page lists, where
zone lock
> acquisition is amortized across pcp batch refills. An order-3 chunk
still
> replaces eight per-page bvecs with one.
>
> Reported-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
> Fixes: 18755b8c2f24 ("svcrdma: Use contiguous pages for RDMA Read sink
> buffers")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_rw.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> index efde26cac961..4546e594f2d7 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
> @@ -746,11 +746,12 @@ int svc_rdma_prepare_reply_chunk(struct
> svcxprt_rdma *rdma,  }
>
>  /*
> - * Cap contiguous RDMA Read sink allocations at order-4. Higher orders
risk
> - * allocation failure under GFP_NOWAIT, which would negate the benefit
of
> - * the contiguous fast path.
> + * Cap contiguous RDMA Read sink allocations at
> PAGE_ALLOC_COSTLY_ORDER.
> + * The page allocator serves allocations at or below that order from
> + * its per-CPU page lists; above it, every allocation acquires the
> + * zone lock, which serializes all nfsd threads.
>   */
> -#define SVC_RDMA_CONTIG_MAX_ORDER	4
> +#define SVC_RDMA_CONTIG_MAX_ORDER	PAGE_ALLOC_COSTLY_ORDER
>
>  /**
>   * svc_rdma_alloc_read_pages - Allocate physically contiguous pages
> --
> 2.54.0

