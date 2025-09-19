Return-Path: <linux-nfs+bounces-14598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24868B8A01C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5617167FC8
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B769314B85;
	Fri, 19 Sep 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDRVs2Ue"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629D2FC03B
	for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292594; cv=none; b=oGW6uiRS5DoStuJtSAyxlz/2jvVyR1QopgY9E8WB/jgjsTbCRivWNtWsK2fiDnBSrtdp1sJTmef4W+tcqpkKtIwSgXfNRhUk94F5pUbJr5yzMtb082S3Q6YVPN+lilKSVlMHwFjXrr46he+1fx0LCpwDVzVLve5SK7HY53d68vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292594; c=relaxed/simple;
	bh=61ZI3SBNGvwdfUUq+InvOY9fr+CLIEkvM6oCu4xbRro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKSR5HG36OvCwCA7WxJH1D9wArgw/enW3L33Oa27p13DWOYei/5wI0TfKxYrCnJ68kNGOerPhli7hH/i2XmInwDoLRR28qUeE+gVAGRC48oR2/zN4LzwRoHu759Bjyk0LpljKY4+jhmgBfHysoe22twXOJNT28uJFmD7NaFu7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDRVs2Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979B1C4CEF0;
	Fri, 19 Sep 2025 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292593;
	bh=61ZI3SBNGvwdfUUq+InvOY9fr+CLIEkvM6oCu4xbRro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDRVs2Ue8QI9hkQmFfxE4gbLJcTouywmQUc5sWOK5QiEDP6nXtZOde13T0C9r9BxN
	 mHMboyCM1/8/MEbGxeSp/hSx3zId7/vNpFxr2NnY9rqzUcUmO/6vBp15BZ/JdMokNH
	 KuXfqNmDXKBvAfI+TRHfKidGMlcx76YzwxcVO+lFKmoqmIw5w792wyQcsQXBx91zI0
	 nBcY2DOsDygCyvFpqiV8gubUZU9j+P5gDoQDrG/mIwpAbb42TZR4kF6Bl7hMArL2Sh
	 iIrAjQvFnPG8gBvbmMrSWFpnwbzqAlx4/tllzDIjXmTQdzVVXqkkQ/JD7dzITRFcDs
	 5KZPxxw0ryfTw==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v11 1/7] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Fri, 19 Sep 2025 10:36:25 -0400
Message-ID: <20250919143631.44851-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250919143631.44851-1-snitzer@kernel.org>
References: <20250919143631.44851-1-snitzer@kernel.org>
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


