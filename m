Return-Path: <linux-nfs+bounces-12940-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68356AFD07D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B2A1887F8D
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CC2E3AE6;
	Tue,  8 Jul 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auejm2Pm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCB2E266B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991673; cv=none; b=cFZdol9DOqdkS0CI5GEk9+6e2RUrwUrSF0u3rBd1VUm05Z124lmDxHgutf/VUC7gE1u+x7kXtWo4EP8/BYGUgQB3/1thW/iLY3V250LPYS//zBMFsQOnwGZOxEBE6inufLhtm/IZPBKKX7J7e3hz5eu/mn4zc6RJ47t/nZttir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991673; c=relaxed/simple;
	bh=z+EANebNrfp3U0HRy92WAxWlVhAM1CXFY7MQHzJIAsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVuT5R2OfBQ/7sfcNGXSkiYMd8oQhLKMQhikQxJvXMfit2qzyD9gxLVPYgxO8aPqwxf7P3tFXjdzOlcR59AJ9kmSKbkk7BJ9ar0oLn+FrtsVC+kD2lOdAhbGCUAcGlvIgsEOUYJhOtygg12GLe06/OxC100tcJOiUtm2tp1qiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auejm2Pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0B3C4CEED;
	Tue,  8 Jul 2025 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991673;
	bh=z+EANebNrfp3U0HRy92WAxWlVhAM1CXFY7MQHzJIAsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auejm2Pm8mcIp63DCgglIiDWI/NYQr67yC/WbFrTq0ynUF7xu6nzLRMYnFAbkskSv
	 kT9TqTQ3cH9s1qqlgFuVpZ60dZSQbiyIsZHBCPSohK4yaUw0Nlu+ZTS0lMcXZ92mtN
	 RdHgcPv9jfhVcj6I4Cox89RdH2OWyrEpePUijhUWAvymytYLWDQrP+uskTRDFtnhda
	 sWk3Pu1bgydZE0FGQzngwWMoWF0WNzOFFg7y1FGX1e8iRhvtfTPWtHpKRhdlSxwSqa
	 SRAsynFAqq2y4qkwNqnJJkXrkbeXxp9kKaHkXBuVdT0Cj6XijQNkOSj/1uQ0A/gkql
	 OgGm9LIeqycVg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	snitzer@kernel.org,
	Mike Snitzer <snitzer@hammerspace.com>
Subject: [RFC PATCH 3/6] nfs/localio: make trace_nfs_local_open_fh more useful
Date: Tue,  8 Jul 2025 12:20:44 -0400
Message-ID: <20250708162047.65017-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250708162047.65017-1-snitzer@kernel.org>
References: <20250708162047.65017-1-snitzer@kernel.org>
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
index c05dc8a09653..67de26392c4a 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -232,13 +232,13 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
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
@@ -248,6 +248,7 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
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


