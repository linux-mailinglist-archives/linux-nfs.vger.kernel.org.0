Return-Path: <linux-nfs+bounces-14442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE267B58125
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48AC188F14E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0520FAAB;
	Mon, 15 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoM1LBfX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C3202C46
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950879; cv=none; b=ktKmUIdOIl4OLZ5YJJfJOKNZznCiKb2oVVYCP0OQBwjuATRllnfctA+1BX+sV4eCe8+MftOomgGxg75Hqdif34WTKAZ9N4Z5qkGu0GU2ZuM3M3gmqQeJAgmh/NDQp+2hNeAS7WMMUXcXGRotIMGBMPTmC2FmLoQKgo6Udl5/R1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950879; c=relaxed/simple;
	bh=61ZI3SBNGvwdfUUq+InvOY9fr+CLIEkvM6oCu4xbRro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHlpPe0F/YtOE29CbMAdbRlYVcWMzcYauHWKt34tTRuUaZutC6OLSNmSVK8CA13fE3y1gjSehm+1N588epHmI4db8caYdXx5LSbGSFcdZEa+xwg2ZQMgIMKdWd0eC9+y/xQ0qXcmpv65Ry9RKG4DqFH6Z+2RmBO7yS3JyIWH2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoM1LBfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8972AC4CEF1;
	Mon, 15 Sep 2025 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950878;
	bh=61ZI3SBNGvwdfUUq+InvOY9fr+CLIEkvM6oCu4xbRro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoM1LBfXuHk1sLkc9qxBbdPdndIjFnV3Ws3lytcU/WhW/XKpYBqEbcmY7U863iz1w
	 It9v5mXJ0fk5pEZAxYQtO30sCoOGwNTdi22VmnJEUfFQO3U3k6dt4BmJhzd645Vpt4
	 7DjLiRjuJ6qFXN8u0agKc2aBF/9PLS+0fqitSzLdakJ6voVeJqL9L2DHv9W/xzNIZi
	 L7+vwG3NFLAZ8QV4I//KfUQcWXGZSasb8pXMjGEpxwIZUcN9nxpT0foVTWVHdzZHja
	 LcfhYoGvyGWHy6LpZwop6LBvJ5o1iDI3hFCvstxLpioA0q0Y6EdKEg/tc13BF+6dlH
	 EGO0ws+BE/Uag==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 1/7] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Mon, 15 Sep 2025 11:41:09 -0400
Message-ID: <20250915154115.19579-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250915154115.19579-1-snitzer@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Always trigger trace event when LOCALIO opens a file.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c  | 5 +++--
 fs/nfs/nfstrace.h | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 97abf62f109d2..42ea50d42c995 100644
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
index 627115179795f..d5949da8c2e5d 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1713,10 +1713,10 @@ TRACE_EVENT(nfs_local_open_fh,
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


