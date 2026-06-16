Return-Path: <linux-nfs+bounces-22631-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I4AoKhNTMWpFgwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22631-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:43:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 098236900AA
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:43:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uM0+bPMZ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22631-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22631-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 833B2304B29B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A142E7376;
	Tue, 16 Jun 2026 13:40:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D7327BEC
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 13:40:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617205; cv=none; b=ZIH4MHO94Jc2C4LqSWooPio6OU5AjTO39etK3Hrn4O8NL6NvG2ISxDEfg2WNaoE3QgmwOZgSS3EcQfpvMztUPLhDePbfRNvFHdHl4wI633JgMswTsxBetaIp9LbRg2/5PS1Xr1PdJjwcUfV7AxKlYH1tdzp20Kx4E0w+prjPdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617205; c=relaxed/simple;
	bh=tUxT1zI1BNmrmL6C8tiQenB5TPmL4oGqhjOnjcJ2vRA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eOsp+LKzgZgoBva4MiQ2LBiT/ZZd3//GKG4ks3onJtN8gcagg3Q0dKsTJHAz0hC6xlEUs2Zoi8BE6hy4Qfl6zprdjg0rbiQxLntW32qxnOIU/gGswTvdJ8vTE4TpeqeJWUGwkDYQ/ohT57YULwxO8+voODf9UyPh6t5UwtpRug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uM0+bPMZ; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf55c3f44aso41526515ad.0
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781617204; x=1782222004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KfmNEms9WT8BM1m0vGOF8Pag7VQCxRcR85ufJLQG+hY=;
        b=uM0+bPMZSM8YbESwXzWgl4KJQUIbOaFONVHuSQDaYABkDZYQkdTpljXctHBkrigkyg
         cGZe/VnJ8XTC4NmOjwOGnesLeoEKZijuD2Z84cREQ0s0Bo6wzIPjRiDk7iE26j6gJ5E0
         7lKBbjAuU5phv4en7N6eGzLFhwVfRs6mgC6SD/ed1eb0A8iflDAd5pW5SDNO/w7mNZ9F
         Os8YqZ/QO2oPDcsffT6afRLNcOlMg3Ln9r69sKHRqx4nt0bc9eGXe9/aEnOPY5CaUtIw
         ETvqVcALrbXQW7y6MNbOP4WJatNhAP8R/3BUCMs78bs++sdr0ESeadf1RrFgCSQGkX0n
         9odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617204; x=1782222004;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfmNEms9WT8BM1m0vGOF8Pag7VQCxRcR85ufJLQG+hY=;
        b=PMkvlV4ms6+WFGlRLDXYbI/E2yBgGm1MALtdjNrX8/2pjFVLGou76taT+uteznieDk
         jmV73T2hfaHLPXu0Me5WxZ1lt3okvohDteeSZR+jJepxJvxjDXg4wQchMI8/KtEKV7tu
         zuIvaNvQPwGKshYzVGSBPJMSjZCMDmp0e5H9PblR2FlKOpfVeosyEGVc0K/8V+obZCJu
         f7OSW0NmmflxE6UHmWcmv/ri2XBBqaCvwdXapeLLHkkTiGjpI9WLK5CSbFT6RXlNrSzR
         sW7gBBhhGM7xIQmhHB7ZsPVO5B+seeJRjSovi+SL7MSM6JhRxHG2BaQpk6qzokhaiN7H
         +JUQ==
X-Gm-Message-State: AOJu0YzRkOdpxKt+5VXsnUIQYvRDuPO5KYw4SUApYX0IOWd98pk3C7/A
	fjk/AlRCinajXzP1R4YHQntPYPOeW7htZKSB+IFv387FIrD5B8VpAZdlV8xfSuarQD3YTGJSmBO
	uALY5lZIB/L5/hZvMvdXJVHQiFrN045ZABEZJA6RiaTJ2qjnY4Ei8Wlmv5tEpDyR3yXqNhiGV+I
	72PzAgPLHrQ5GPoUnEI5id6je3mHHvko4SOJ0=
X-Received: from plbay2.prod.google.com ([2002:a17:902:8b82:b0:2be:b2c1:9921])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2d:b0:2bf:22ac:a7d8
 with SMTP id d9443c01a7336-2c699a8d1fcmr29977185ad.5.1781617202996; Tue, 16
 Jun 2026 06:40:02 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:39:53 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616134000.2733403-1-praan@google.com>
Subject: [PATCH v2 0/7] nfs: Modernize Direct I/O path
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22631-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 098236900AA

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
This series has been tested with xfstests [2] on RDMA & TCP transports:

 ./check generic/091 generic/130 generic/139 generic/143 generic/154 \
         generic/155 generic/183 generic/188 generic/190 generic/196 \
         generic/198 generic/203 generic/214 generic/240 generic/263 \
         generic/287 generic/290 generic/292 generic/330 generic/444 \
         generic/450 generic/451 generic/586 generic/647 generic/708 \
         generic/729 generic/760

The following summary was tabulated via a custom script [3] (on github).

python3 display.py results/*/check.log
+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
| testcase     | rdma-sys-3   | rdma-sys-4.0 | rdma-sys-4.1 | rdma-sys-4.2 | tcp-sys-3    | tcp-sys-4.0  | tcp-sys-4.1  | tcp-sys-4.2  |
+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
| generic/091  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/130  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/139  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/143  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/154  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/155  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/183  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/188  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/190  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/196  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/198  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/203  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/214  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/240  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/263  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/287  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/290  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/292  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/330  | skipped      | skipped      | skipped      | pass         | skipped      | skipped      | skipped      | pass         |
| generic/444  | skipped      | skipped      | skipped      | skipped      | skipped      | skipped      | skipped      | skipped      |
| generic/450  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/451  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/586  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/647  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/708  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/729  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
| generic/760  | pass         | pass         | pass         | pass         | pass         | pass         | pass         | pass         |
+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+

Thanks,
Praan

[1] https://lore.kernel.org/all/20260401194501.2269200-1-praan@google.com/
[2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git


[v2] 
 - Fix data corruption in nfs_direct_extract_pages() by correctly
   calculating intra-page offsets using offset_in_page().
 - Fix requested_bytes accounting in direct read/write paths to only
   increment after successful RPC scheduling.
 - Add missing kernel-doc descriptions for the @pinned parameter in
   nfs_page_create_from_page() and nfs_page_create_from_folio().
 - Rebase on fs-next/

[v1] https://lore.kernel.org/all/20260603053033.3300318-1-praan@google.com/

Pranjal Shrivastava (7):
  nfs: make nfs_page pin-aware
  nfs: Track number of pinned pages in nfs_page
  nfs: Introduce nfs_release_request_list helper
  nfs: migrate direct I/O to iov_iter_extract_pages
  nfs: introduce nfs_direct_extract_pages helper
  nfs: Optimize direct I/O to use folios for requests
  nfs: Cleanup the nfs_page_create_from_page helper

 fs/nfs/direct.c          | 165 +++++++++++++++++++++++----------------
 fs/nfs/pagelist.c        |  87 +++++++++++----------
 fs/nfs/read.c            |   2 +-
 fs/nfs/write.c           |   2 +-
 include/linux/nfs_page.h |  12 ++-
 5 files changed, 150 insertions(+), 118 deletions(-)


base-commit: 389bb4a76905771adfa86d21ee0b865247148e9d
-- 
2.54.0.1136.gdb2ca164c4-goog


