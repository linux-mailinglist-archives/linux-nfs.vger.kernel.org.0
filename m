Return-Path: <linux-nfs+bounces-13382-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24FB18652
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262881764F4
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1F1DF755;
	Fri,  1 Aug 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjIJw/rw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B491DED4C
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068254; cv=none; b=JuDqVgTu1Gk4z7DwvqQrqFjOIGNmfVUoTndOK17syz5j2yL4V1AbBl2+Sh+fAEMgccug/RU05ZT3ht/zKpAOUwDrf1JbNovisHUcslZHu9Sbn4FCTrAcVudVIwQ4jQDMFKgiwnZIrsOguYIVFCN6dF9TMlsFxxmH+CIR31WpEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068254; c=relaxed/simple;
	bh=9jAPvPAH1B/qaPyKoebiOEBGo3zDEPjaGDFnulj5Pok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+n89408p2bGDZj/TjQY4mywECPpW0jUGRtf/v2ibm30QVtf+DNVPusB3SSFM4pG28tZ74cyr+SYbFK5UN9F/RYHfkPs2OrWNqRYzEMz9+XK1MJ+Ye7B7ud5/xtgCnhGS/zjw4Hx35LDLdf+/CYI8REV0VBVgWAOaESIynCTmMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjIJw/rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62109C4CEF6;
	Fri,  1 Aug 2025 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068253;
	bh=9jAPvPAH1B/qaPyKoebiOEBGo3zDEPjaGDFnulj5Pok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjIJw/rwsy5Qf8xfSiupB+YaFnmSPTgDFMfjUcMKc+2qVpkS5i/VO3t0ZC6rMVEwD
	 u6uK/rnWGCYvp6ASn8aDfOZ8DR2S9YHgQIf8r1+FF0ejaP/o8Aly6Fm/XC/1XYFclo
	 oqIq+hoIdZFuJaGbPFhXuJUoDO6LYRxJypoqB99dKMr1CTB/ob8X7olDL2W/0FewHa
	 WwUhYYRbPeHQ2/YpRhsyjRzitvsnsNe82ntyUJGXuX8MVW3BegeOoAjh/DPV6yJ6qW
	 PuafCkPoLSEUfmWrsPWdoOGtB9kUZRoua4Emk+krUVL0YLzZXB1y8qGF8cr9H9pvaV
	 cTCPJ21ypoQJA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v6 2/7] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Fri,  1 Aug 2025 13:10:44 -0400
Message-ID: <20250801171049.94235-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250801171049.94235-1-snitzer@kernel.org>
References: <20250801171049.94235-1-snitzer@kernel.org>
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
index ecfe22a105eaf..0b54f01299d2c 100644
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


