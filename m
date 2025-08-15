Return-Path: <linux-nfs+bounces-13690-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D2B288C1
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E1417E517
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF62D4B65;
	Fri, 15 Aug 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw6tO8QY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1D285C8D
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300608; cv=none; b=e2fPN6Kqhp5adznq/KdVqQcWYujbPOS0gfu25335j9GUZIqVhuKjIKtl3ikwQ/6H5nLQ1j3CaE3I1tcsXRBPw0Qn1/5xE/N/XUg4I+0EU786g3UZDRTETngNR+aETDE90ACx5eY63rAWCYpeapiTK2AOiimbNqQ4Simni6JVcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300608; c=relaxed/simple;
	bh=3DWwygUCLoVu6PDbf1wgNUtYv0Gowj/JbkZK5FcjenA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/brNQhX63cQltt3X0JLvIF2jeJ9SQWkNIyyN5WqvDDZR4h7yZCNSbxQtJcBfLEN68UtEt1uIb2d1AfcfxDVZWuDu2vwIUZuO6RtYz3BmcKh14DLGIUOntatKybTdTdq/eSjdqnZYzUa2XI4UclQ7de4M3Pbpc9q+yTjVr2rBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw6tO8QY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B1BC4CEEB;
	Fri, 15 Aug 2025 23:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300607;
	bh=3DWwygUCLoVu6PDbf1wgNUtYv0Gowj/JbkZK5FcjenA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fw6tO8QYlbWKHhJgnzQlGNko1aURiRH6TH9OR1SRcACynI/d+o3m6ECyZwMnYCzWj
	 htCZ6jrKBbQ5JbXae4pqQ1oBMhWKyhsy1i37n4tn4bBWnbssg8hxdmYz+d9+mIvxFl
	 fAOGVl3S3hawRGB4LgtCwyJxFH9SvpQvfi9wXLCHtZBvbUFHIs3cK152UFBGDOXQpE
	 fJrJELuHR/SIIAQsjNSg8dF1wiJgZHNSBgMSqSSLWQlMLr1rx5yTpH/gRwpjsk74nL
	 lEQN2m+l8DKfT9NXbluSODwp0/hB94VNqz3/fKy3HeK6D9ZJ9Nwl/gmTCw/xPASHXc
	 /F2uybRwr6K0Q==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 2/9] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Fri, 15 Aug 2025 19:29:56 -0400
Message-ID: <20250815233003.55071-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250815233003.55071-1-snitzer@kernel.org>
References: <20250815233003.55071-1-snitzer@kernel.org>
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


