Return-Path: <linux-nfs+bounces-22221-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GQc5FAK8H2q3pAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22221-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:30:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E062A63447C
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 07:30:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=K7n8LFwI;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22221-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22221-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 572873025ACA
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 05:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1803126DA;
	Wed,  3 Jun 2026 05:30:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B878F4A
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 05:30:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780464638; cv=none; b=CS1SaEY8Z+1UZDdZiVyxrzEb68je8nIY32TJ/oAecuz79BSMjrQQw/CBFRx+KXK7JoS9JpBH0tSfnM1IRWjsKlPC8mIf3ddgN0XarsOIOaP18qzptaJU2mu2mnyCp2rAiJNCWpAj/p6j8v9NZVmsNpSZuBw3i4FOwS3b+C7FQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780464638; c=relaxed/simple;
	bh=Q0D8jDrRcRHDJM37OlpFYuTE9Um5+/MQvZUeKQkrNhs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nQzxKrPKjtRc3NVpx67ZWf5bxoKCbFquARo8Y7oIGpuvUaJrKjOkxWtmgoQRLzMNvx2szohP5U5rkrx3U30Yem93kglnjKTFSAxYf0QQac2E0JXRerfXzeVsm9NtEdMygnlijYPHoyQ9rAfYROZQK3YhvJfor8mjzVoGzhlRjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7n8LFwI; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b7f696b40so5165642a91.1
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jun 2026 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780464637; x=1781069437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvYVhLCrvwQ19orwR9RfHUVycxN5Xiji++Ju2gKa2bM=;
        b=K7n8LFwIxfvk8fhqCaP/7BmJa9y03iO7hKyv5JLnF9HmSKg3lH1MvYdGj5A8aUdk6E
         kOmVZPEEPDFP2EEwH8mfGW8xqJ3CjwR4qwL0bkWbEMnNYL6jiXTx4eDoj4/QrIRLwjRt
         avGX7I/0yVNOxwUNTo38cGgsqXiyLfVCwX+kXg2iEf03wDTrYMJxaWGECeAo0SL2vr5o
         Oe2tSY4MZ3rZ+2YFV+KP1wyPPwgoL9AlhDamuGw6oqHqYXZY7Li1aDJxfqodgWn+A46l
         HSQfUk1y2djCGVtcApsK19xs0RR4JdlFRREAHkna5j9Qt5ASXeQzLq8+5URX0mhbKNWa
         kNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780464637; x=1781069437;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvYVhLCrvwQ19orwR9RfHUVycxN5Xiji++Ju2gKa2bM=;
        b=WkpEP0jd3E4jK59tFiIVnhDV/aX2uCku/16UZzasuFNWOUUD1Yqx2+g5h6GI+EpQSb
         p2ICV6Nt2dRN9pLnWltrofLV0uaXpv8NwP0rChhRNNE/Jsm9yCOCDN2aE1d7I0sicmNr
         DtBea0WqgR68I52GNzlOgsROLlJCgG1HTdemifdmP5YSHu93giGLcmfD949xGp1QjHNG
         70p50jy+bYfJjgLjqAjorDe1qRVR3Uvy4DFpO75vfv5vPQINHjj4GFQY6QO8NtTgV99U
         Ant4Dd6nAGnOHltk3SFykpDPGmGietUWRhllxug/NojzbwCyAMGkT619lgmmB1Ww0Ygz
         m0aA==
X-Gm-Message-State: AOJu0Yw8hCLdAlr4epKCoNeRfEZF1TGnM8i9sLlONlNahuD1lzEV/Cs2
	mCHcEBvnTtzT5dItQUrvIV5AzMdqpx2A4armY/aX/DGC2qgWcgdDAh/FBGJ70SYmgVFJ4/xaZ1S
	oxTXqdUzjVkLos3g2d2rW6/eGcg8mP40cMONLFYj3z62Hk5nDax8738JAh+KGTB7WMkqVDLCTCs
	y8cYwAFxDV+A+z1/C4ic6ZLrSmyMePYkKSX2E=
X-Received: from pjbgc16.prod.google.com ([2002:a17:90b:3110:b0:367:f83b:97d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2c5:b0:35c:cba:3453
 with SMTP id 98e67ed59e1d1-36e33105750mr2104272a91.22.1780464636449; Tue, 02
 Jun 2026 22:30:36 -0700 (PDT)
Date: Wed,  3 Jun 2026 05:30:26 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603053033.3300318-1-praan@google.com>
Subject: [PATCH v1 0/7] nfs: Modernize Direct I/O path
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Christoph Hellwig <hch@infradead.org>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22221-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E062A63447C

Modernize the NFS Direct I/O path as a preparatory step to enable PCI
Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
RFC [1], the modernization and architectural changes are split into
this standalone series.

Currently, NFS O_DIRECT relies on the legacy iov_iter_get_pages_alloc2()
API which does not support the pinning requirements for P2P memory.
The implementation moves NFS to the modern iov_iter_extract_pages() API
and migrates NFS direct I/O away from pages to use folios.

Design
======

1. Pin-Awareness
Standard NFS requests use get_page() and put_page() for memory
management. However, memory extracted via iov_iter_extract_pages()
requires explicit pinning.

Introduce a PG_PINNED flag and a wb_nr_pinned count to struct nfs_page.
This allows the request lifecycle to track ownership of physical pins
and ensure that unpinning is performed only when the I/O is complete.

2. API Migration
Migrate the Direct I/O path to the modern iov_iter_extract_pages()
API. This aligns NFS with the modern extraction model and serves as
the foundation for passing ITER_ALLOW_P2PDMA in a follow-up series.

3. Extraction Helper and Folio Support
Introduce a new extraction helper in direct.c to group contiguous
pages from the same folio into a single struct nfs_page. This
effectively migrates the Direct I/O path from being page-based to being
folio-based.

Note: zone_device_pages_have_same_pgmap() checks are intentionally
omitted in the extraction helper since P2PDMA enablement will be
introduced in a follow-up series.

Bisectability
=============
The series attempts to remain bisectable. 

[Patches 1-2] Introduce pin-aware infrastructure and accounting.
[Patch 3] Adds a centralized request release helper.
[Patch 4] Migrates the Direct I/O path to iov_iter_extract_pages().
[Patches 5-6] Implement the extraction helper and folio-based grouping.
[Patch 7] Removes orphaned page-based helpers.

Testing
=======
The series lightly tested using fio (bs=1M, size=1G) on a small
(non-server) machine running Linux 7.1-rc6. Some test logs from a run:

nfs-test: (g=0): rw=read, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=libaio, iodepth=1
fio-3.42-37-g5b47
Starting 1 process

nfs-test: (groupid=0, jobs=1): err= 0: pid=33264: Tue Jun  2 23:50:15 2026
  read: IOPS=5145, BW=5146MiB/s (5396MB/s)(1024MiB/199msec)
    slat (usec): min=8, max=168, avg=11.12, stdev= 5.16
    clat (usec): min=153, max=628, avg=182.20, stdev=24.15
     lat (usec): min=165, max=796, avg=193.33, stdev=27.64
    clat percentiles (usec):
     |  1.00th=[  159],  5.00th=[  163], 10.00th=[  165], 20.00th=[  169],
     | 30.00th=[  172], 40.00th=[  176], 50.00th=[  178], 60.00th=[  182],
     | 70.00th=[  186], 80.00th=[  194], 90.00th=[  202], 95.00th=[  215],
     | 99.00th=[  229], 99.50th=[  334], 99.90th=[  408], 99.95th=[  627],
     | 99.99th=[  627]
  lat (usec)   : 250=99.32%, 500=0.59%, 750=0.10%
  cpu          : usr=1.01%, sys=5.56%, ctx=1025, majf=0, minf=265
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=1024,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0.00ns, window=0.00ns, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=5146MiB/s (5396MB/s), 5146MiB/s-5146MiB/s (5396MB/s-5396MB/s), io=1024MiB (1074MB), run=199-199msec

Pranjal Shrivastava (7):
  nfs: make nfs_page pin-aware
  nfs: Track number of pinned pages in nfs_page
  nfs: Introduce nfs_release_request_list helper
  nfs: migrate direct I/O to iov_iter_extract_pages
  nfs: introduce nfs_direct_extract_pages helper
  nfs: Optimize direct I/O to use folios for requests
  nfs: Cleanup the nfs_page_create_from_page helper

 fs/nfs/direct.c          | 160 ++++++++++++++++++++++-----------------
 fs/nfs/pagelist.c        |  86 +++++++++++----------
 fs/nfs/read.c            |   2 +-
 fs/nfs/write.c           |   2 +-
 include/linux/nfs_page.h |  12 ++-
 5 files changed, 144 insertions(+), 118 deletions(-)

base-commit: 2c9eb6f2c18bff4cf3ddeab96db5137cc2b2572b
-- 
2.54.0.1013.g208068f2d8-goog


