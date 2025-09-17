Return-Path: <linux-nfs+bounces-14518-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC6B8151D
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 20:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D080C188B1C2
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC72FE059;
	Wed, 17 Sep 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg6wUbvD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D334BA33
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133126; cv=none; b=eSTNVBtmsiNebv69u6mw1nN9sj6EbwZdVA7mONXbt3c5OQeYPWYK02iQmTI8Mt45V0K6JVkmKCGzjixbtTxOHa0NfBVroVjRm78kAk4D7ReK4wTXZ6NVnh07zm+olFpniibkFo0fspFzeRhk0CeNf5pUDN4p56m1YgS3zVCTyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133126; c=relaxed/simple;
	bh=61ZI3SBNGvwdfUUq+InvOY9fr+CLIEkvM6oCu4xbRro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL1EK2PJjwerDQvkSuPC9NRuP2HSWPJ/4GFPQP+XHDDKT1OB1awh00qbfNQ2bRSPRNy/PQZYOGtAOwQleXw9XvqF2c9N3+2M88alXyzjDnDC0gnKiTFO1ebYuk00qVzVyKrYEEO2xoGJtVn4ZEDCBrAiImG8RQdS1rgW62MdE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg6wUbvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A1EC4CEF7;
	Wed, 17 Sep 2025 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758133126;
	bh=61ZI3SBNGvwdfUUq+InvOY9fr+CLIEkvM6oCu4xbRro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cg6wUbvDFl+ZIZFVHJ9pcBAgBRffVbKoxrGFoA3QHaMU9OIUn5iCGs4jv3GewhZf1
	 YWZCfYbrLSU+ho623KjSSRj+VATrbXhsRkFS+nTsx7l5j4BAhDA2LE5M5qLVQ8m473
	 bjN0HQccGJeRaZ1H9fJNRv6ftY/3OOc3y2EhmUtamHQfpRBr60FCHP17lRQTRYcUt9
	 FE/f/tz1XpEmqfkAGaLSb0DSIX0ZK8m5vQf9ZFeIln20z+9UvngZmAtMv5EmfCl8/R
	 VdziwHsJjhPSN+TLmcsPM6OZA/WHWJPSHeSVbPaeP6J1QAopLK5y60+QX2K9sHMoJS
	 cByxyV4QXmgcQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v10 1/7] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Wed, 17 Sep 2025 14:18:37 -0400
Message-ID: <20250917181843.33865-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250917181843.33865-1-snitzer@kernel.org>
References: <20250917181843.33865-1-snitzer@kernel.org>
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


