Return-Path: <linux-nfs+bounces-13238-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD44B111C5
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F01CE7F65
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E072EE276;
	Thu, 24 Jul 2025 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK1nt8J1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F82ECE8D
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385477; cv=none; b=uQM2wD0okrTZwXchUgQ/nzdqfoujJ3GkLDH9QQhfnZfVEf9GdJsssmhpzGWB0nruoe+3uyvKYn9jYwOPPkKOLRRoLKhF4VWB7EHZj25gYmrbrB5h4Sh6Wie21YBaYuxmqdx/P5JAGDEiMZw/fglg9pDPFaPyN8SuvXWcM6hXTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385477; c=relaxed/simple;
	bh=3SX/cdANFDfluY7wRW1X4SjYrX2gieE5fsDBJl6UvFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr42SLjVIv4eOoQ1E3g3BmS0tS0d+cZzee1p3RZaF4NdM/UjyfxMZhOGUhSD5ccGc0rzNGgs93Y1VdYrQO41TQn2REwQH9LqWyEamcIO89hQsdVgN6n9lPN4vbBblE7HgBNd5fcE9Nf22mNcY6QUjr8jC9P/fsW2zmYUk/721iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK1nt8J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E5C4CEED;
	Thu, 24 Jul 2025 19:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385475;
	bh=3SX/cdANFDfluY7wRW1X4SjYrX2gieE5fsDBJl6UvFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jK1nt8J1sKZMgAB3SobkV1Jf+/kxj7epL78kCAEGoAG//kvZl8sWI3gSEXqC1wgb6
	 K+mZ87xK+bjir32J9y0brjCYRZuBDZyb6GZtghGl9/p6ZYvgbFJ16anApp9JOWAtqk
	 AAe9uSdYL89cYzxYj1lY6xR6piqkNNOBFOQAnlk/Rvb0fTMEyRwkvXufUhOZDLTHU+
	 fvfIBP+t8HrB4VOq7cp7DulscXif/ekMT88YK+g5BOijMS8mwTH2CwpiESTMdujEVu
	 vjGe7MrYOKA7luP7FZ/fOoNrSitTa0X0zrYmkndWAP9xzVj7lqtORFgN/e4a9grKFo
	 RBPxqzzc9bSHA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 08/13] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Thu, 24 Jul 2025 15:30:57 -0400
Message-ID: <20250724193102.65111-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
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
index ecfe22a105ea..0b54f01299d2 100644
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
index 7a058bd8c566..334e65d6bc72 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1707,10 +1707,10 @@ TRACE_EVENT(nfs_local_open_fh,
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


