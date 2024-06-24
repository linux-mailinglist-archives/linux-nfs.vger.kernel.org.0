Return-Path: <linux-nfs+bounces-4252-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E70914E79
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 15:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A6F1F22FA6
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C813D520;
	Mon, 24 Jun 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuipRUy0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D013D89C
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235712; cv=none; b=rkTT72JdnN1PP6/Yz0+YbE0HyQCSV3j4LpLdzPZnZUZ2F9iKkg2f9h1RZ5hG3PHAUpGZcOD9fWPi/DOZHsn8cbjfEP+5rmWaoLKMLpJOV/ow9QEyIj52W0ktI++LjfubG3BdmzEPmKy0uZKU2g5ZxO1vHg4YJOQqc16pajOIXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235712; c=relaxed/simple;
	bh=5UamcsGouDyCESke75eIDl+yCnMCqXITSZ4/rH97ApI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fGpTEfpLHnX5N+kO4G+6l/RV9mA7HfFkffos2qlBj8nHhs+0KkCa+k4G6hhICU/IlKZt2xTyu+R+v3IqzYm5R3E5IhsNSxEZaCnv4VbS8UXg/T+CYUVXo61LkyTEDVi9vEGw5cLu51/oO4oP0DQFtIAqI5L/4QCBuduCZGV1stc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuipRUy0; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfdcda2bdbcso158225276.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 06:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235709; x=1719840509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTLXMtePO1SNsYgtMaHyFsPnigd9vXQ1EabpLwrHnJU=;
        b=RuipRUy0kS38g8pCAGPbxMEQCi/hcbC6/SJQ3NQG2HdFQFYoH7ONq8AJCGO9l78NKw
         iBjv3+HYKUOAwPRYMRaguYASYXCIxD1hIeMo720aBk3EN4x3zA83gBIGxRlhJyPpfXwa
         ijTwWR9dayq3LQZSWCoFKWz2S4OMx+fXsraFDKSKEXvoJVCPJgQEYyUkGr9JNL1vwkGY
         bnT7btUhCeIh+dWj7JZzs2NilO2KotcKeDch6U638NALr/UddSptlPvX7UX+ILaGJx6y
         KAq0Zm1zAURfy5NOPgugDDxOsHEmd8tdPdSz9d2EJ8GQMVx3lU80NggkxF6Od/6eRvhw
         8U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235709; x=1719840509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTLXMtePO1SNsYgtMaHyFsPnigd9vXQ1EabpLwrHnJU=;
        b=VcThrH9dVws0bwx0JB6PoxR75+2+Ew5rbWVrApV7CSIVliP7IWc/0nnfMwG8fZTMXM
         REHak9eJTDBwf0cpqmKvUIWINuxK+cyIwcgQWQxyDWCMp+9PsYiQJTOOBMMTKIzGF8Yt
         MuxeJ0s+PinA94hg0k+KgXNii44D+RmYQI0ZeKTOe8ZGvAtYTWhoFnuPKajnhesxJLls
         4lFDpYUyVG/5cFj/zhN86AFsLvO3lr+KdBkrUbplIHHviR35QwXFfcUHP+b0j76Cj60c
         FqGKtQfyN/jNwZGshaz2IdyJRJE1vWyeRo74cvCRXks2fgeKtYHGpx9ce7V3leRbwp1i
         sgxg==
X-Gm-Message-State: AOJu0YwaHHXTNl58GAIs6xu6BpoQDqZWIaMtsKpZ/cY+ZbrBFL3x279d
	CHk6Uc86OAY2GoXy5T2nMnlGMbrvr5GN8cIJ/QVH4aYPxVZj9NMB
X-Google-Smtp-Source: AGHT+IFbvBdLDmwajlGKCExqGVyTVKn5G1ZD5D7iw7LRMIwHeGhJrJaQwxeblCtL5oaY6Wk8agDlVQ==
X-Received: by 2002:a25:d6c5:0:b0:e02:70d1:ade0 with SMTP id 3f1490d57ef6-e02f4c43070mr4297293276.4.1719235709304;
        Mon, 24 Jun 2024 06:28:29 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:188b:6f46:cdbf:33f2])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e6263a8bsm3194101276.30.2024.06.24.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:28 -0700 (PDT)
From: Olga Kornievskaia <olga.kornievskaia@gmail.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 another fix for EXCHGID4_FLAG_USE_PNFS_DS for DS server
Date: Mon, 24 Jun 2024 09:28:27 -0400
Message-Id: <20240624132827.71808-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <kolga@netapp.com>

Previously in order to mark the communication with the DS server,
we tried to use NFS_CS_DS in cl_flags. However, this flag would
only be saved for the DS server and in case where DS equals MDS,
the client would not find a matching nfs_client in nfs_match_client
that represents the MDS (but is also a DS).

Instead, don't rely on the NFS_CS_DS but instead use NFS_CS_PNFS.

Fixes: 379e4adfddd6 ("NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4client.c | 6 ++----
 fs/nfs/nfs4proc.c   | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 11e3a285594c..ac80f87cb9d9 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -231,9 +231,8 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 		__set_bit(NFS_CS_INFINITE_SLOTS, &clp->cl_flags);
 	__set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
 	__set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
-
-	if (test_bit(NFS_CS_DS, &cl_init->init_flags))
-		__set_bit(NFS_CS_DS, &clp->cl_flags);
+	if (test_bit(NFS_CS_PNFS, &cl_init->init_flags))
+		__set_bit(NFS_CS_PNFS, &clp->cl_flags);
 	/*
 	 * Set up the connection to the server before we add add to the
 	 * global list.
@@ -1011,7 +1010,6 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
-	__set_bit(NFS_CS_DS, &cl_init.init_flags);
 	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
 	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23819a756508..1afba4c1c352 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8820,7 +8820,7 @@ nfs4_run_exchange_id(struct nfs_client *clp, const struct cred *cred,
 #ifdef CONFIG_NFS_V4_1_MIGRATION
 	calldata->args.flags |= EXCHGID4_FLAG_SUPP_MOVED_MIGR;
 #endif
-	if (test_bit(NFS_CS_DS, &clp->cl_flags))
+	if (test_bit(NFS_CS_PNFS, &clp->cl_flags))
 		calldata->args.flags |= EXCHGID4_FLAG_USE_PNFS_DS;
 	msg.rpc_argp = &calldata->args;
 	msg.rpc_resp = &calldata->res;
-- 
2.43.0


