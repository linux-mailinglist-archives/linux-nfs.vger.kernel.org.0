Return-Path: <linux-nfs+bounces-18946-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH35FTFNk2mi3AEAu9opvQ
	(envelope-from <linux-nfs+bounces-18946-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 18:00:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D4F146871
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 927D43003722
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E753EBF12;
	Mon, 16 Feb 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3d21Hcp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A61A23B9
	for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261225; cv=none; b=AUFsffNQy+74exjnkJ0sz5vjwGLrDPnsNNx6Y1K1uWZUEJ7dEae/mabUMAdMbTEKMKrWsQAziepQ3kCTV+HCsLWo80CHowoFbzKGjkUw9pErh5YRTe+aXZtYdS9vacmlgH7gs1zxDw4gu8iwgrdzYIvelO7I2T9Ns8KSOn1LDNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261225; c=relaxed/simple;
	bh=9gRLJcy79or1/WKvApiFk44TE/4+RkpzZaCO0pyJipg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5F7IJp6wfIEJeWPZ/pZAln3lOxil0ppjh9rfDu/7haY3bweX5Qkul8Ne93ZRaNxJJ6MmLsmUyy3DK2ARRr6N9Cfh229KBaYwuavDNJbDzy6i1O4c8O+MZey9FWPiHFw16s6LRZVPNqnZXJ397rmRkrgeAMqQ0OD+ScW7zOsuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3d21Hcp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82418b0178cso1822632b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771261224; x=1771866024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6RL6PqLI4urJjmYITsxktReGvY/7dE5J3r1kbbY2fw=;
        b=a3d21HcpXgsAvb6B2mbIFGgxKxohcoF7s4y+MXCGYiQvynPUx+f1c+INhQgD8+lyc8
         GcHTfxnLvBT87RbY3Xx8nZ8NYfsUBisnZba0BY27JF7Ki44++J7fYNZLa0fH9MOT3KnW
         uAUSQtuvnq14mhfM+lFchFNAL0LlvucfUCdi8CeuO4HqOzBcPnY0sWSqo715HDCjZCUZ
         TVfhuJAHq6O8FwTJFB6wJt9CUuDIACJkvDE6UvY9+u3a1shM6htePax/k97b/k7b8Tre
         wmvPaiVq7HpDv8PIWIXCULFNk2IYlhQ2OIesanCU9n8L7d/Uog3+Se3AGfs519Tu/6e/
         syCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771261224; x=1771866024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6RL6PqLI4urJjmYITsxktReGvY/7dE5J3r1kbbY2fw=;
        b=Bj+Fj65x/KJ4oKjQm2YVz3gX/8MIpjYNloeweVa0JoWGlTcEVA4X6Q5l3879sbdV2b
         yV+30X0qvKXScQmy26G6T5vLVsYwJi6gvA2BJcm3CGIovSEjITPa/xTPdXJMrQbWn5nN
         pBmvFrciq8mz0x2VXN+y0GJqqJrUwB3S2WlqF9VewnnFsE2vXdwHyqMxDBufDimojQiO
         JpCJvqY8FWOmv/T5dOiXc7gXFgsOjfFsEfQZejN+RekkAM0SjPkXRxQtAGFLaXH2l5ht
         os77zd0/IOAH2BvsXHnorM3VKRvKUNX9s/G7sJCcisxAG5mcVORvhvD49F9+iSgqZeMF
         LCVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/QOdIr4HX7zal1mW+e7Re96p2hJrb48K69Vmidm5awii3+xCQsC+QYVr9YwexuUasiV6gnSWCLk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7n6tEwIiqEZm8bgkLuytDzBtz8ZzBPfZbHoK6egPSDAW6VuZ
	7oCtGVT6L+fTIdFFDq5PIuIl9adIv9NOIn2HMiJgm8RKQK093yYTiPZ3
X-Gm-Gg: AZuq6aIXbwZWIqrtqWwtrVSUnQmg1zFgcCUYYuGaO6pwt+YB2Os0jAFp20AExc0pBed
	6IgXUUPBjn4v+B4Gh/dtJFdSlCPS0rL/sz9Wkkc0TcBiIJqJN4kxzJdtdJzc+7ZAP08XfLWU+nm
	f69teAraRkAiyaurIwCNvfgV/r3IkxxSNZsvmmW4NjXciIj4lxND0XQpc18ZuSO4oKSd0r+Le9Z
	9HM2MgNrOVzB1ENQB55AMQxLDDPZD4meeq/XX3rbYtBddUW6vA8bqW0vTA69GUuu2KsFQGJ1Oa0
	tLvEiJ//KhOuLkWxtB9JgqItlpO6qUxC1G5eX+Zl7zN1Fj/XQSSpp2rzdn3S6q5gsJ76G29d97m
	ywtsU0MipEQ7blc2gm/XOMnvKdsT7H4BLnjgRUvudbnEEuxV1EJ6r0uf4Hmj7ZpGldmGyVVI0oP
	9WfBxiaCndEBCkl6mmOjQXXkUvVUpMhQXGrI3RF21Lzn8P/86qQoiSwDSptlBDQaQwGLVV
X-Received: by 2002:a05:6a00:a111:b0:81b:13c5:b6b2 with SMTP id d2e1a72fcca58-824c95c1151mr9294051b3a.33.1771261223326;
        Mon, 16 Feb 2026 09:00:23 -0800 (PST)
Received: from sean-All-Series.. (1-160-221-65.dynamic-ip.hinet.net. [1.160.221.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a431f2sm11940512b3a.22.2026.02.16.09.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:00:22 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH] treewide: fix unused variable and format-truncation warnings
Date: Tue, 17 Feb 2026 01:00:04 +0800
Message-Id: <20260216170004.448754-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18946-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74D4F146871
X-Rspamd-Action: no action

Address several compiler warnings across NFS and MACB drivers to
enable a cleaner build:

- nfs: add __maybe_unused to 'err' in flexfilelayout.c
- nfs: add __maybe_unused to 'ret' in flexfilelayoutdev.c
- nfs: add __maybe_unused to 'ptr' in nfs4proc.c
- macb: use precision specifier in snprintf to ensure string fits
  within ETH_GSTRING_LEN (32 bytes) in macb_main.c

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c  | 4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
 fs/nfs/nfs4proc.c                         | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 43cd013bb70e..26f9ccadd9f6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3159,8 +3159,8 @@ static void gem_get_ethtool_strings(struct net_device *dev, u32 sset, u8 *p)
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			for (i = 0; i < QUEUE_STATS_LEN; i++, p += ETH_GSTRING_LEN) {
-				snprintf(stat_string, ETH_GSTRING_LEN, "q%d_%s",
-						q, queue_statistics[i].stat_string);
+				snprintf(stat_string, ETH_GSTRING_LEN, "q%u_%.19s",
+					 q, queue_statistics[i].stat_string);
 				memcpy(p, stat_string, ETH_GSTRING_LEN);
 			}
 		}
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 9056f05a67dc..de9e8bad6af2 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1502,7 +1502,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	u32 status = *op_status;
-	int err;
+	int err __maybe_unused;
 
 	if (status == 0) {
 		switch (error) {
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index c2d8a13a9dbd..3fb8dba0abf5 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -53,7 +53,8 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
-	int i, ret = -ENOMEM;
+	int i;
+	int ret __maybe_unused = -ENOMEM;
 
 	/* set up xdr stream */
 	scratch = folio_alloc(gfp_flags, 0);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 180229320731..f76c23cdc888 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9241,7 +9241,7 @@ static int _nfs4_proc_create_session(struct nfs_client *clp,
 int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 {
 	int status;
-	unsigned *ptr;
+	unsigned *ptr __maybe_unused;
 	struct nfs4_session *session = clp->cl_session;
 	struct nfs4_add_xprt_data xprtdata = {
 		.clp = clp,
-- 
2.34.1


