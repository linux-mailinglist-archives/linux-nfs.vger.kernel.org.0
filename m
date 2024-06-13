Return-Path: <linux-nfs+bounces-3718-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137A906304
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 06:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C055B22D6C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA347132106;
	Thu, 13 Jun 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFbbGCi1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2EC1339A4
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252269; cv=none; b=bGcFk07yWn4yCu2pGP8U75FaQI6w5GDaaMFxB04QMP/5py0kPsNAhMlsYA8bhTQWqRf6WLirMQe8zaPKr4J1BNK3IduKNU0hXDkp1w/KPQbe5uguySoDzxp63Z5GX4jDWgkiGW1459bgWHWnFNzeFSLMRZbxdy+N+owY5OPHbhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252269; c=relaxed/simple;
	bh=uchDaSxoiBihPJaVbfjdkv8zT6brkwCTp93vdpr5PdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2AQQIz0YGCq7bFPNLCtkXgEbynLV4SsrJT4THu8j2TrnMjl0gNV/E6Y5a+uo4QdgLggdd7yHKRFhMxHB9KEqXTPdZTOOcEJo6gbupriyqZKZyR8ZNjWTMpngKinuOQB1Wkol9WXIBLFN0Kxmgs2kzRpzN7Zqn3wZb/gHSsgbmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFbbGCi1; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dff0712ede2so168587276.2
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 21:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718252267; x=1718857067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcbhNeh3lEUhaC4Ltb//45PFvbWHeFYX1K9+ueo6Pk0=;
        b=BFbbGCi1Xj1n99pzcDiPdMhDX46NoRZBuFEQ9sCi84NsCquvWWH380oHc/k0t6HfXR
         LVDpJSRctAOR4ImbSlclBe0izQm1OVALap98Q0BSnDlOi5pzOfyAdJWyoUlXJNmO0ciZ
         anLOhiEp1S7rSPGBLeNWGdRvKih3gQ98Q8bvlfy0P3Ze7WwFT92UhBgNOob4L6r+LFq5
         xYbMuobiw33WiQJdVEDnGsYPJNNZQrHAbFHB2qcmnJPWnwFxiYj7AZFV//GhX031SJfR
         iQvoi/PmbiSEZRBbCbhPYvwwejUlEOwdPlPmcwSqYUTXDGLVzHq/GfwpFqVCD1NShA4b
         iyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718252267; x=1718857067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcbhNeh3lEUhaC4Ltb//45PFvbWHeFYX1K9+ueo6Pk0=;
        b=t2Q5P/yak3zfdEwK5ZwyNtd+Rf+pWxosjJkdAGf3dHuYjYj42D7TaMI8HiKfRNxiVy
         Vryf+daOkdoLcSxgrLmtqbVjoEii2CwDGex9MIRqscjRPB+WIojADVY7ZItCjLQMdgsU
         8pEX8AevqX6OXMeDP3eRbdJmIXPK0l/bx+wq+N9I8q6Mk+iG0RLsHH51hdaTft4gRuGr
         D4Cu7s1kdGkm6NKGjyBEjFUOl4a+PPFUnZ0A/GqAOsBDKJyCmyeBo93HAtWZOrhzFFQz
         2P58hqfDUAP76HskxLupByleL07iQViNaieXCRJEeI2G4MoHnpdd0xAeWc+8X7i0fkx7
         go+Q==
X-Gm-Message-State: AOJu0Yw9DSvIV34YN/x40Dg7VwbhyKW2l6jCp7wBAre4C2v83fTFcZQu
	91So5vwiBhQm0Q8cmZPEZBcARExpRCFMKKmUC6Qc6RTXsYGM2kLdUD0v
X-Google-Smtp-Source: AGHT+IH6emcnwzWePUlqlEgSp052ZyWR9rtfYkC/YmxUb5UU/7wcEuziR5Fusklu9VXqTZoDwn5/FA==
X-Received: by 2002:a25:aac5:0:b0:df4:dfee:3572 with SMTP id 3f1490d57ef6-dfe675566e6mr3833934276.38.1718252266999;
        Wed, 12 Jun 2024 21:17:46 -0700 (PDT)
Received: from leira.trondhjem.org (c-68-40-188-158.hsd1.mi.comcast.net. [68.40.188.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c68ff3sm2851546d6.74.2024.06.12.21.17.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 21:17:46 -0700 (PDT)
From: trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To: linux-nfs@vger.kernel.org
Subject: [PATCH 09/19] NFSv4: Add a capability for delegated attributes
Date: Thu, 13 Jun 2024 00:11:26 -0400
Message-ID: <20240613041136.506908-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613041136.506908-9-trond.myklebust@hammerspace.com>
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com>
 <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com>
 <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com>
 <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
 <20240613041136.506908-9-trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         | 2 ++
 include/linux/nfs_fs_sb.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index b613c11fac09..efa07c275338 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3930,6 +3930,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 #endif
 		if (res.attr_bitmask[0] & FATTR4_WORD0_FS_LOCATIONS)
 			server->caps |= NFS_CAP_FS_LOCATIONS;
+		if (res.attr_bitmask[2] & FATTR4_WORD2_TIME_DELEG_MODIFY)
+			server->caps |= NFS_CAP_DELEGTIME;
 		if (!(res.attr_bitmask[0] & FATTR4_WORD0_FILEID))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_FILEID;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_MODE))
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..5a76a87cd924 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -278,6 +278,7 @@ struct nfs_server {
 #define NFS_CAP_LGOPEN		(1U << 5)
 #define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
 #define NFS_CAP_CASE_PRESERVING	(1U << 7)
+#define NFS_CAP_DELEGTIME	(1U << 13)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
 #define NFS_CAP_STATEID_NFSV41	(1U << 16)
-- 
2.45.2


