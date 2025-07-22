Return-Path: <linux-nfs+bounces-13172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52EB0CFDD
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 04:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D0E3B0A9A
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 02:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7DD273806;
	Tue, 22 Jul 2025 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUxe1kU+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02E272E6B
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152568; cv=none; b=oA/Y+A4EILluPFwrt/B2bEV7+fzFrpGDY2xJlOaQGTPyrOmirzg0q2RfJjzqTnYzHhl/9ph7w3dHzCkWWosw832ZUUfX/auxaarLCa7rlBNg356CroM6lk1YpzaAWdFsrZFwaWMKULbrIR0G0kgC1FoQ/nTc57SitaAMdB1M6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152568; c=relaxed/simple;
	bh=WVXivqnFV+XBqHFDE0HHB9FZYLxR/GYzSAOXLxF77dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFy5r/j/mKRVj/nvXaJ+9TA1y/Ju2dt1KopNIc10bHTT+CrR1hpdYDqktHDExpFgLxOzay26C5wF9H0vs00dyki0cHfSogqDo6mO0aWTYUE4Q0PNbbVCTB430+stiiAd5fWI1jLlydFl5L/FeqVyxqElpgFWQpbr69RScish7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUxe1kU+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F10C4CEED;
	Tue, 22 Jul 2025 02:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753152568;
	bh=WVXivqnFV+XBqHFDE0HHB9FZYLxR/GYzSAOXLxF77dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUxe1kU+Ja67cerxkNWu417Dm8vnUXIMew3/pjiGMehOTdyhdtGqsWMeImuFUS/Th
	 yHhpWFAoziDNZFhaXWk9a1oxrLN2L5fScqZGv9vulGsll74Li8fPZcuxOoB+I+edv8
	 jDHAxbb5iRWF2CNjnmL4ja+e32aLo92PbKV/B1u1lK6J+L6Z5Fxd1PTJt6Y9kVl0h9
	 Yn/rWPQLsrc9XNnnkjP5NJdZIrJMYvIWAZiE81loIV5iQDdnWkgOBBnMGEyAOJUaNZ
	 LuNA/OrZAzJyBdi45TbawKuUkZxpL1hGC9GhXkpFa3kXNvETR2au61PU1nGeR/IsiL
	 ST3TgUPhRTsYQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/7] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Mon, 21 Jul 2025 22:49:19 -0400
Message-ID: <20250722024924.49877-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250722024924.49877-1-snitzer@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
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
index f49f064c5ee5..feadaa6dee63 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1708,10 +1708,10 @@ TRACE_EVENT(nfs_local_open_fh,
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


