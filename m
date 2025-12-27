Return-Path: <linux-nfs+bounces-17316-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B969CCDF82C
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 11:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8348A30056FE
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14804487BE;
	Sat, 27 Dec 2025 10:46:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B53B2BA
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766832396; cv=none; b=ZK2/PZs9dXA/KbAmEadgcM680rnzRij2IIU9xggxA85AtIOXGw+/+6dpl/kb6SZWVWsY7sM40OEVB/FFq/HA6FI/cp2aJTiS4r9Bfra9lUeHyuyojuP4CKyeILE3crBTf/kcsLDi6l0eXbkFjuRZZjwy4NrA72efIQzYDIwkWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766832396; c=relaxed/simple;
	bh=1RdEfCQsBBbZJTHLnVTBKEsKI51m9HDEiOZDwHZS3nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVR/eLlvkqprWU4MV/3353Y2gdKUs3Vz2vqtSPJyjfqS1Xl3qrbLkQ6R4i27STnW7QdBFGy1OUMF/V5ZJzyWhIW2LkWxCXMwSZp2JmdmpCtbGT43693plLAhZebPJzmKK2CYZBr9bqkKuL51TPODUlKGMI0DY/Lp/DFJhBU3tkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430fbb6012bso6500647f8f.1
        for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 02:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766832392; x=1767437192;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zOTa0phnMlsLHnfgQJsochYV1FpMjR38iQmnoMePpyE=;
        b=XG4GM/Is4cTPEthlwWrYjQ4XnF5fROHK3WEd43+jq8otMgy21LJCPHBL3FTulUKhkP
         V+aoGa0H9zigmP2G/T/VOstmbXZT8rXF5i7qZiGv74wEyTAC8KQtLlmBqq/PKhls7gMd
         UgF7xc5evM/cC4Pw9pxmjbw//ckvL9CiG5it8BysDDX5eMQvtHI0B0n+8D3Y4CN5O1SA
         FPDM78SW8wiuYF7FjXWmUea7Y1tqMX5QHo/rcCcneRYuHP84qAk609tLTZNUp+40hvi+
         LsjXR5mwAWRoieSDk72Y8K0cVFuknAZXXlfLsXmGLTtMDBPTli9vmYMZE29HeN2+h1UA
         ttPw==
X-Gm-Message-State: AOJu0YxGrrKxH7NSXog9EIBUsHSpqsgQRsM25ZeY3FURvBjevbhiEZX+
	9f2Fw4PSU8vL8uR7BI3EbY2K+g6IU/eWAJIKXSV5wDCQ+DCQoVbAKKYgKKDGclxx
X-Gm-Gg: AY/fxX7lqTgK7UeJ/vnCNx9qtZJG+QoWKFwxH6MlgFkFxmqiGOAG/YEWeI3aFKJOC+w
	nCWxoXLqRi7v4DT5nHRLSCfQMR2prB1ZSaEX9G85g2RSapw0UjC6ZObjZHBGQbDdsL7PD7BOHA8
	quWk0PxuFutwMA0bgc+E8Csr5LwANwofF3xme3vNFGSmwAr1hKR29EmnVdiJa0j2UA/gnSqIY5a
	X6z5PQCSnQ8geiaksqpMX8ocLL5hCev42YKk8ImOjQajdbxogWLKon4TEqNGCUvXrZxcX5JgdpO
	ArriV4Xjk2H7voNaKGfcmEGVOTguc5QM53Fw+wphW5vRJdhROLf3eSYWF/XpEDGashmml6exTWZ
	k3ftGWOdz6e8Av1DR0bOuL68gl9/j4elUq353+owEyRHBDMFkFjFIEPkC1x3/IjxJWkPtx2uZhb
	ZdahT5zEm1fypb8lGSDS86jxruKJoGmYJ/a7BcPry/Y2epiBDdDvC7fx3B
X-Google-Smtp-Source: AGHT+IFWUHKEYYqkkp4Ro4QHG8hyxg5ayNWU1Kk1D943+gYknYOIwTXf0wGoNuyWKvTS+zJRcK0cBA==
X-Received: by 2002:a05:6000:2dc7:b0:430:f463:b6ac with SMTP id ffacd0b85a97d-4324e50eccbmr29348379f8f.44.1766832391558;
        Sat, 27 Dec 2025 02:46:31 -0800 (PST)
Received: from vastdata-ubuntu2.vstd.int (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2a94sm51072693f8f.43.2025.12.27.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 02:46:31 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] fs/nfs: Fix readdir slow-start regression
Date: Sat, 27 Dec 2025 12:46:29 +0200
Message-ID: <20251227104629.234133-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
Reply-To: sagi@grimberg.me
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 580f236737d1 ("NFS: Adjust the amount of readahead
performed by NFS readdir") reduces the amount of readahead names
caching done by the client.

The downside of this approach is READDIR now may suffer from
a slow-start issue, where initially it will fetch names that fit
in a single page, then in 2, 4, 8 until the maximum supported
transfer size (usually 1M).

This patch tries to take a balanced approach between mitigating
the slow-start issue still maintaining some efficiency gains.

Fixes: 580f236737d1 ("NFS: Adjust the amount of readahead performed by NFS readdir")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- minor phrase
- added a Fixes tag

 fs/nfs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea9f6ca8f30f..514a2aadf612 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -72,7 +72,7 @@ const struct address_space_operations nfs_dir_aops = {
 	.free_folio = nfs_readdir_clear_array,
 };
 
-#define NFS_INIT_DTSIZE PAGE_SIZE
+#define NFS_INIT_DTSIZE SZ_64K
 
 static struct nfs_open_dir_context *
 alloc_nfs_open_dir_context(struct inode *dir)
@@ -83,7 +83,7 @@ alloc_nfs_open_dir_context(struct inode *dir)
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (ctx != NULL) {
 		ctx->attr_gencount = nfsi->attr_gencount;
-		ctx->dtsize = NFS_INIT_DTSIZE;
+		ctx->dtsize = min(NFS_SERVER(dir)->dtsize, NFS_INIT_DTSIZE);
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
-- 
2.43.0


