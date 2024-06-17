Return-Path: <linux-nfs+bounces-3877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C9890A1C5
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EEBEB21C43
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A266D1C2AD;
	Mon, 17 Jun 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN/PpU+9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6B1C286
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587517; cv=none; b=Mp3zCsdS2vJdxS8G8C1PuEgOmZDn0a64+FYmPtSofvovdX5J1WnEBLLr1JBsG9kUkOcZCZR8nNe5zBwAWFRlA3YghfYMyi12KNxRtakQvfg2c/3q0ts6rAkZ5NGYOKuA7r8MVThBu4rWdpCbEI7/kcU83eTwKXmzvkhSUO92iv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587517; c=relaxed/simple;
	bh=L0STbWuvMFu7jpIkm4Nialx9lW9wymrmgWKzuvbxOjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvBbIZupeblWbTSBRZJW5XFRaTu0EkApUKPFOs9qpm1ctGj0COJLsT2JMrCIbS2KBd+vDX9a439NlW2odViUft4rU+LrfXkTWOE/KNz+S00rcaCu2GInmqFpUnOgCSn1Qbl/vxAhaZUeobT8OHLL1FtpntWzY53cqPIc+K4HTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN/PpU+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0C0C4AF54
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587517;
	bh=L0STbWuvMFu7jpIkm4Nialx9lW9wymrmgWKzuvbxOjA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BN/PpU+9mwwWrEMgJEV4soj/UqC4tqt63UvH9ycCmd35kuw0ruY9N6aOD1ReYUmZG
	 5CZ+7dmAyv6PzQakhHd/veYXrsWVl8h0lAGkEaGXSF8YI9Jsup1kkVH09PEjKcstML
	 GqE8X/564+Yxsz8N3UX4E67XA5jeCmESXIfPnn33hiupLBAVk49CVKPGxccHf1MVvc
	 enfp3UfD88ZPmGm/mUuKgfy1ei1R6QUZwJGzFS9m65V0p1XEjvbWANtgs5QQTKPOt8
	 aRcWgki7CNowyRH9CMeFA15gqjnDP7KOjIy92bvXAFu1kA4uJGgFTGBeABLlgtjpqN
	 oGDAGBwlm7mbw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 19/19] NFSv4: Don't send delegation-related share access modes to CLOSE
Date: Sun, 16 Jun 2024 21:21:37 -0400
Message-ID: <20240617012137.674046-20-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-19-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
 <20240617012137.674046-13-trondmy@kernel.org>
 <20240617012137.674046-14-trondmy@kernel.org>
 <20240617012137.674046-15-trondmy@kernel.org>
 <20240617012137.674046-16-trondmy@kernel.org>
 <20240617012137.674046-17-trondmy@kernel.org>
 <20240617012137.674046-18-trondmy@kernel.org>
 <20240617012137.674046-19-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we set the new share access modes for CLOSE in nfs4_close_prepare().
we should only set a mode of NFS4_SHARE_ACCESS_READ, NFS4_SHARE_ACCESS_WRITE
or NFS4_SHARE_ACCESS_BOTH. Currently, we may also be passing in the NFSv4.1
share modes for controlling delegation requests in OPEN, which is wrong.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9376b5031acf..26758acba3a6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1333,8 +1333,7 @@ static fmode_t _nfs4_ctx_to_openmode(const struct nfs_open_context *ctx)
 }
 
 static u32
-nfs4_map_atomic_open_share(struct nfs_server *server,
-		fmode_t fmode, int openflags)
+nfs4_fmode_to_share_access(fmode_t fmode)
 {
 	u32 res = 0;
 
@@ -1348,6 +1347,15 @@ nfs4_map_atomic_open_share(struct nfs_server *server,
 	case FMODE_READ|FMODE_WRITE:
 		res = NFS4_SHARE_ACCESS_BOTH;
 	}
+	return res;
+}
+
+static u32
+nfs4_map_atomic_open_share(struct nfs_server *server,
+		fmode_t fmode, int openflags)
+{
+	u32 res = nfs4_fmode_to_share_access(fmode);
+
 	if (!(server->caps & NFS_CAP_ATOMIC_OPEN_V1))
 		goto out;
 	/* Want no delegation if we're using O_DIRECT */
@@ -3753,8 +3761,7 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 	}
 
 	calldata->arg.share_access =
-		nfs4_map_atomic_open_share(NFS_SERVER(inode),
-				calldata->arg.fmode, 0);
+		nfs4_fmode_to_share_access(calldata->arg.fmode);
 
 	if (calldata->res.fattr == NULL)
 		calldata->arg.bitmask = NULL;
-- 
2.45.2


