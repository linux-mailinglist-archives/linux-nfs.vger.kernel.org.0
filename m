Return-Path: <linux-nfs+bounces-9825-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F28A24BB7
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 20:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9CD7A3946
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Feb 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07371CD1FD;
	Sat,  1 Feb 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEgP50k0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31921CD1F1
	for <linux-nfs@vger.kernel.org>; Sat,  1 Feb 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738439945; cv=none; b=j+iplmIFeMzl6nsG9auHVJgiDWyd3zr/q92D2EXoBY0aDU88nU2zyZTHGwPfAO5eS+EZaDc29PMKTy+k8uQCj+UijydUj2VjgcWprKKBxI1rkZj5BLjxmkWSdJ45xLmcIOhdyNDgBuxT0V9ix0w8VLylTzN4qf9a2Ml4PNgf5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738439945; c=relaxed/simple;
	bh=rWexCuC8cWY34tKPFVsYPSk8TRIWxLPG1Qt44hqc4cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yi8lQTpz52awLyFtvvekmZsnZsHew5GPAyWv/mrehzQF4sRVzBnkbSNLWMKaA5UnM9jsXWvccRFOrELO5ceb8Nruim68eEs8DEis2Qt8pAymAiC4+lG8gch+ifKVf/LklXf7C1/RVBqHB2DNZHz6u6C1ZEFr6jhJSNbIW4gnWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEgP50k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B68C4CEE1;
	Sat,  1 Feb 2025 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738439945;
	bh=rWexCuC8cWY34tKPFVsYPSk8TRIWxLPG1Qt44hqc4cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEgP50k0i/sMNFSHfJ+ziVe+TE6cnU6hQf9ksGpqbkFRY39mrgs+VioVnvzXjzV0w
	 IpGyWobCNbscIww/Utrid8jEdh/wnMviBmOyh2T2+fpRiqZhwLG8KZB0a2l2N8uryi
	 toTfQIXRqZPqxPFyeOAjbnzQBP3m9jrwgriO2tgWFxDB7rdm+zQKfWmxkSwqpYDWDS
	 E2wsgayAckS1FrNvog3ITGuGZd0JYeOrH6PxGkINq849QNxE6UxdNJ0uR/J8n7N/+a
	 qWxpaP3f3RYy4kVwyTkbL78aqMN3CWWf0i/BN0gutzy/ReehlCoeEbhukcxWMf80Fe
	 jsAS/QS8TuAnw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/2] NFS: Adjust delegated timestamps for O_DIRECT reads and writes
Date: Sat,  1 Feb 2025 14:59:03 -0500
Message-ID: <dc9d3f8c31c383022907a6c27d7eb12a3d1a46d7.1738439818.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2e064c1d4ebaa8a58267fcd4f474e1a1e0089f38.1738439818.git.trond.myklebust@hammerspace.com>
References: <2e064c1d4ebaa8a58267fcd4f474e1a1e0089f38.1738439818.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Adjust the timestamps if O_DIRECT is being combined with attribute
delegations.

Fixes: e12912d94137 ("NFSv4: Add support for delegated atime and mtime attributes")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 40e13c9a2873..f32f8d7c9122 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -56,6 +56,7 @@
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
 
+#include "delegation.h"
 #include "internal.h"
 #include "iostat.h"
 #include "pnfs.h"
@@ -286,6 +287,8 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 	nfs_direct_count_bytes(dreq, hdr);
 	spin_unlock(&dreq->lock);
 
+	nfs_update_delegated_atime(dreq->inode);
+
 	while (!list_empty(&hdr->pages)) {
 		struct nfs_page *req = nfs_list_entry(hdr->pages.next);
 		struct page *page = req->wb_page;
@@ -779,6 +782,7 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 
 	spin_lock(&inode->i_lock);
 	nfs_direct_file_adjust_size_locked(inode, dreq->io_start, dreq->count);
+	nfs_update_delegated_mtime_locked(dreq->inode);
 	spin_unlock(&inode->i_lock);
 
 	while (!list_empty(&hdr->pages)) {
-- 
2.48.1


