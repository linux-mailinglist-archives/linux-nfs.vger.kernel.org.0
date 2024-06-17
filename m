Return-Path: <linux-nfs+bounces-3868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B20490A1B9
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA63C1F2109A
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B162AFC0E;
	Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4zfn0nY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4AFBEA
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587513; cv=none; b=WKqM0tquLynMM+wR2rgLsfbEHUt2Vf47qLUzN54jqdKaS0CqS2P9I4i+L5Qzq1s7qQlqgNLYCex0LO9stoWoIHvw+c5TNe8JUTrLrPzbwWVYGBk/3GbFL8wRHuFnwWTgCs49KcofwsBSSKAMkp7gsWcLHbojukJySwxRREB6yXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587513; c=relaxed/simple;
	bh=sWCRVkeokI6gb2n+q0iHNz3hgS97VyWo5o1tT/MvVUk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7/vuZdf5pi6RHrcEiOgp7FIhSwkwF00WZ97lQStOGiaEuKXsOFEac5zBUhNNf3i+7E3jFMcIfgUfsLWqsianYSA5bwAywOz7m/yNHlgz7eLgyLa27cKVOK+3RdA84795s6IOI4Sc0bnrZVxWK1G1qzyBp3u3rGTcRJoqJOQ3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4zfn0nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4754CC4AF48
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587513;
	bh=sWCRVkeokI6gb2n+q0iHNz3hgS97VyWo5o1tT/MvVUk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U4zfn0nYjeBFsDTbSEqkxMEsM2FBe5yM2Q2ufoidiaXvOUo3/wDovo29fSDCooGa9
	 0NJR+8TN5gZI0xljGGoJVdq3AU5zFG2aVpJ8yXoJgfE3ILVOuwTfFNcoUafWppeyV7
	 1aM7Obi3UrkGXrOQBeDCEPM9D2CRguc58QhdVRAaiBTwWNC8aTbq8sAjMCYrTAdDZn
	 LApAcgPQldFKINH+XLkybKil5wPSbftlyWAnDHRa+OeglFK7mQBpteKuWIegpuKVsr
	 vhJPPNhU/ZwmKa4XZ9mKheYdptnlLe5Gnfnrie3jjL26w57ZOmNbNTPac8SRixJeKb
	 cAaiUCP5CQWGA==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/19] NFSv4: Add a capability for delegated attributes
Date: Sun, 16 Jun 2024 21:21:27 -0400
Message-ID: <20240617012137.674046-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-9-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

Cache whether or not the server may have support for delegated
attributes in a capability flag.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         | 2 ++
 include/linux/nfs_fs_sb.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 34182a3c38a7..03835c8a180f 100644
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


