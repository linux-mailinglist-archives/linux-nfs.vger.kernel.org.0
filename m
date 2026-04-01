Return-Path: <linux-nfs+bounces-20600-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDrtBWt2zWnYdgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20600-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:47:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0DF37FF04
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 21:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49200301D064
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9835A3A0;
	Wed,  1 Apr 2026 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6Dd56uL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813E313E3B
	for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2026 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775072709; cv=none; b=JO5+nCelEP5llXWmsASF0u/e/Tt2ybavv8nRh0YMMkNJSyU4cLtRQlVolgYJbyd/qRrCaxwguaNneheL9MXKV14lAGwwEggxhYbmxfIvYm4sz4Nd2839PZibg9UXZhOpEkDrxjEi5uCjQLfzGxcoL6YnBFg4YNdY/O5MJW1Ww0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775072709; c=relaxed/simple;
	bh=rRO3oXxMQ5K+aJS3fz/IzsEi+KzV3CVpOeh/nVrRirw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UKt68cgBck1ux/3+JQbCeF2x5lMjgjlVYMDjGsHNE3XV45hrlCg9W5qVsyiHmn94ZFPDbfUq6lbmOxbOVu+bqfNUPgviMiEZm0ck/1hWsb5vIsHzLVTCkF+wOPO4AIYgpPcuq/J8kDMhcHwVS6ddIj7HAydXOFVXBMbkJZ2S96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6Dd56uL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b242f76113so794455ad.0
        for <linux-nfs@vger.kernel.org>; Wed, 01 Apr 2026 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775072707; x=1775677507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KOVihVZmvAI72pQYZS6lCrpErGIBVs1asnwx+4bn+hA=;
        b=A6Dd56uLHed01H/Iuw+2YxYPg7mwDwVHU5XmKBzPq8qMiByS3sBHfTBPHvyB44xJ7X
         A3qP4mBGE34Ga4ErK+mk1Qh00MTC/JmDjrLjaxqy8wx9LKtUs7NJiK9cy7/05oMU1w2/
         m4xKd9macxX27RcuTrgQjC0NoD05cHem8dq+yIfwh03TtcivX8NBjc2hfLVuDg21Mjq4
         /KtFcJfKfr6V6YV5uwHSMQvckCy7pDamWwxEZulBsUu9tERlD16bwM32jiRB6J+oBuFZ
         x4DG/tDDvXj1S10moXawrPE9w3V3UvHeAhMggYFSA4A7HnN0CAWmMydNrYvCyoVVZZvR
         Wnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775072707; x=1775677507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOVihVZmvAI72pQYZS6lCrpErGIBVs1asnwx+4bn+hA=;
        b=dZwlCxU+AifgFPNc/4VdX4iZg3Ac0C7c2ZqXF/Lry2GlKqZt6/R5wyYJ1+m+sEXreX
         PmY1cizn4G74Htz+vmghHTHGLER9pMMGB7o/icT7zvi/MoHXX8JqdRowBMUfxA5iNZU3
         +w4JBwaSbid2CHsk1Zjp2Dgu+bnSg8nFLVe8CeIXKrNwHh57zDUNXwsuZekePeUapU1U
         wMcjqWq+8MIFFumZ9zGZj4MoouzY1/8KgBPpMGPeT266n2+CvvGspb1uSDzocI/kMylU
         yTTjGpQYHaBBh9b4KF1X0S9+ly91BdFz1TeTAF9jF6wBXvsRkE9nSAIHy4VOXpXuuBdz
         bkyA==
X-Forwarded-Encrypted: i=1; AJvYcCXFHXMDPXPgdj0rDRd+VQY7D0RC8Gwa/Zu7NvWEGBUtyuYEnl8oPyiDjybD2SC4PEFit8zJC7n+6+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznpgbOMuhsYJ2lmnWb1wfA/FxShJUIPZ2m/BU9++YGRsgTxagn
	nnR3DLTW5bKt7Ewb/A17qjraEZ6L9lUXaEduW+XzoX7UawtfwSTwpS09zv83a9PoUp7J43vy+F4
	JaQ==
X-Received: from plbkc3.prod.google.com ([2002:a17:903:33c3:b0:2b0:a8dc:303f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc3:b0:2b2:5503:1b8c
 with SMTP id d9443c01a7336-2b269abcbe7mr51526225ad.11.1775072706837; Wed, 01
 Apr 2026 12:45:06 -0700 (PDT)
Date: Wed,  1 Apr 2026 19:44:56 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260401194501.2269200-1-praan@google.com>
Subject: [RFC PATCH 0/4] nfs: Enable PCI Peer-to-Peer DMA (P2PDMA) support
From: Pranjal Shrivastava <praan@google.com>
To: trond.myklebust@hammerspace.com, anna@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, chuck.lever@oracle.com, jlayton@kernel.org, tom@talpey.com, 
	okorniev@redhat.com, neil@brown.name, dai.ngo@oracle.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20600-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D0DF37FF04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As high-performance storage environments increasingly rely on direct
data movement between PCIe endpoints (e.g., moving data directly between
an NVMe Controller Memory Buffer and a Network Interface), support for 
Peer-to-Peer DMA (P2PDMA) in the network filesystem layer becomes 
essential. This series introduces P2PDMA support for the NFS Direct I/O.

Currently, NFS O_DIRECT operations fail with -EREMOTEIO if the user
buffer resides in PCIe BAR memory. This is primarily due to the use of
the legacy `iov_iter_get_pages_alloc2()` API, which cannot pass the 
required `FOLL_PCI_P2PDMA` flag, and a request lifecycle that is unaware
 of the pinning requirements for P2P memory.

Design
=======
The proposed design centers around making the NFS request lifecycle
"pin-aware" and upgrading the infrastructure to support modern memory 
extraction APIs.

1. 64-bit Capability Infrastructure
The existing nfs_server->caps bitmask is limited to 32 bits and is
currently exhausted. This series expands the bitmask to 64 bits to
accommodate NFS_CAP_P2PDMA. Crucially, it also refactors the NFS_CAP_*
constants to use ULL definitions. This prevents a subtle 32-bit
truncation bug where bitwise negations (e.g., caps &= ~NFS_CAP_ACLS)
would accidentally clear the high bits of the 64-bit capability field.

2. Transport-Level Detection
P2PDMA support is a property of the local transport hardware. A new
supports_p2pdma operation is added to the SunRPC transport ops. For RDMA,
this is implemented by querying the underlying device via 
ib_dma_pci_p2p_dma_supported(). The NFS client queries this during mount
and sets the NFS_CAP_P2PDMA bit accordingly.

3. Pin-Aware Request Lifecycle
Standard NFS requests use get_page() and put_page() for memory 
management. However, memory extracted via iov_iter_extract_pages()
requires explicit pinning and unpinning (unpin_user_page()).

This series introduces a PG_PINNED flag in struct nfs_page. When set,
the request lifecycle skips standard page referencing and ensures that
unpin_user_page() is called only when the I/O is complete. This ensures
that physical memory remains pinned for the duration of the DMA transfer

4. API Migration
The Direct I/O path is migrated to the modern iov_iter_extract_pages()
API. The ITER_ALLOW_P2PDMA flag is passed to the iterator only when the
local mount has signaled P2P support via the capability bit. This ensures
that "normal" users on standard TCP/UDP transports see no change in
behavior or overhead.

Call for review
===============
Any insights on the proposed changes to the nfs_page lifecycle and the
64-bit capability expansion are appreciated. If this approach is deemed
incorrect or if there is a more idiomatic way for this, please direct me
in the right direction.

Thanks,
Praan

Pranjal Shrivastava (4):
  sunrpc: add supports_p2pdma to rpc_xprt_ops
  nfs: add NFS_CAP_P2PDMA and detect transport support
  nfs: make nfs_page pin-aware
  nfs: allow P2PDMA in direct I/O path

 fs/nfs/client.c                 |  8 ++++
 fs/nfs/direct.c                 | 51 ++++++++++++++++++-------
 fs/nfs/nfs4_fs.h                |  2 +-
 fs/nfs/pagelist.c               | 18 ++++++---
 fs/nfs/super.c                  |  2 +-
 include/linux/nfs_fs_sb.h       | 67 +++++++++++++++++----------------
 include/linux/nfs_page.h        |  2 +
 include/linux/sunrpc/xprt.h     |  1 +
 net/sunrpc/xprtrdma/transport.c |  9 +++++
 9 files changed, 106 insertions(+), 54 deletions(-)

-- 
2.53.0.1185.g05d4b7b318-goog


