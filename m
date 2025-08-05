Return-Path: <linux-nfs+bounces-13452-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7910B1BD0B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D7618A45E3
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109FB29C344;
	Tue,  5 Aug 2025 23:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwGXD3M+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E189F20B7ED
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436076; cv=none; b=TEoh8zMMjDRfuVXl4R/q4SUi7CA49mG0TR6MispioEAF0qMkRNkHN0Q4N7U6vEJY1A+TcwuGHBEcEopLGnqk1gUtCdbTQ0z9UDo8kSjo22kTtG4pElncoGmVfabn/i7S/zxQ7ySaQmR3S2B6sMxx4UUgvPArlUnY9ZtXy2b/lgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436076; c=relaxed/simple;
	bh=X7riWog1HWt5dcXW9+rBuZjacyfRGOuNUCU11BQ9rh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVwDrmi5i1lNqJ5p0bYtqNHM61lk2Qy+IiGHva4Di5JrIVJxbQXV5zV+E3xt9aiDeIh1VvsjVIKlMzyy4ku0zaUxRj8ycMg4gL+9mHIT7COGx0TPOzBkYY1cFopSfTOMuH24D1ru8ZltH4/hBm9gX3hMN1f+tXddwX7fyjOvWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwGXD3M+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47DBC4CEF0;
	Tue,  5 Aug 2025 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436075;
	bh=X7riWog1HWt5dcXW9+rBuZjacyfRGOuNUCU11BQ9rh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwGXD3M+WhwrYH3m44bgm05dEvOvoBnEko6JuSRfb3hWYiBvnTL75X1+LzVtD5My6
	 CVvV3P9XRo5FATsM9Kk5bS5ZIh6tHbxyncOkS3i6K2ESC3C5/WQ1UhZpK600MaZcS3
	 RIF7c1wBHfKdxq67FVhBDlM9i5PGHR+njn/e35tNNk8HK90LUyaXtrieZdyvY44Fvl
	 D1lWOjV4wEB2kmGwmwvK4Y6oC+rNftCkrXbBm1uxYLKIppzTE/A2W2lGa2n6yahF8k
	 3tEuZGrtFxDbp+nPL9PL7HWDqx2kxoL/PQMvxH3Gx4TsOk8FHWbzqgB/UVU67Fu9PN
	 hWCafiToq/qeg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 05/11] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Tue,  5 Aug 2025 19:21:00 -0400
Message-ID: <20250805232106.8656-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Always trigger trace event when LOCALIO opens a file.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c  | 5 +++--
 fs/nfs/nfstrace.h | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 9adcd1380bbba..2a6e1d3a764ba 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -231,13 +231,13 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		    struct nfsd_file __rcu **pnf,
 		    const fmode_t mode)
 {
+	int status = 0;
 	struct nfsd_file *localio;
 
 	localio = nfs_open_local_fh(&clp->cl_uuid, clp->cl_rpcclient,
 				    cred, fh, nfl, pnf, mode);
 	if (IS_ERR(localio)) {
-		int status = PTR_ERR(localio);
-		trace_nfs_local_open_fh(fh, mode, status);
+		status = PTR_ERR(localio);
 		switch (status) {
 		case -ENOMEM:
 		case -ENXIO:
@@ -247,6 +247,7 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 			nfs_local_probe(clp);
 		}
 	}
+	trace_nfs_local_open_fh(fh, mode, status);
 	return localio;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 96b1323318c2f..4ec66d5e9cc6c 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1712,10 +1712,10 @@ TRACE_EVENT(nfs_local_open_fh,
 		),
 
 		TP_printk(
-			"error=%d fhandle=0x%08x mode=%s",
-			__entry->error,
+			"fhandle=0x%08x mode=%s result=%d",
 			__entry->fhandle,
-			show_fs_fmode_flags(__entry->fmode)
+			show_fs_fmode_flags(__entry->fmode),
+			__entry->error
 		)
 );
 
-- 
2.44.0


