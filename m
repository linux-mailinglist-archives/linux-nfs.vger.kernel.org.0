Return-Path: <linux-nfs+bounces-13171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC85B0CFDE
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 04:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58637A18F1
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9AC273802;
	Tue, 22 Jul 2025 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsWEEjN9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBE272E6B
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152567; cv=none; b=lUS2t3EEPKeFgAJwp1CFmUu6/wKQoo9VRAwhJ6OANS/iGNNkR2nrYUQpelu+DoU/TtkHDzkgOE+4e7tso0ZmTqjEiw7ww0jgaX1TBUQT8a1OWo7LaiFXD0mBfO+KJDB76hLyNT8c8WO558uUjMdl6IKpoNIRMpcb7QSXCFQt6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152567; c=relaxed/simple;
	bh=3JlBlNu9YSycTI9u/dIkyiyMNt1HFdi72gm6pZEMSWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FySFFXrcdYT6ECJao6HRQXti6mLLrC63//EkxmeC6A79GwH1fSclc4DGtxMWUKYADkJvBoPQNSn4zPlLeM2LOT44uenGXab+yV/M4cvqUm+4MSBKgBiLRU+X8g6hlKdHVpzMlmiagSTib4zRo4TjpoR/9OeyXOuEgdYvL+ezYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsWEEjN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025E2C4CEF1;
	Tue, 22 Jul 2025 02:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753152567;
	bh=3JlBlNu9YSycTI9u/dIkyiyMNt1HFdi72gm6pZEMSWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsWEEjN9zJyjwGg+DwQA/q/yz/aok3Aphm3AW9o7qhqBIPWXXy/E2TSNIVTxOMzg1
	 hJWzHB5cG28X48zYJBzOByjOxgSOVNgzxUQNriIU3vZXXjT/jOrHBBjunqctE2nTWq
	 8yC+C1pLhZvZRiqqj7W7FA6OUk9DLtYuike4hQdggFncF2oa0UvXAEIxyfuiPSN6L9
	 EmurM3naXsDVouxTjOwSM2LWdkgVseuwBAtu2MOEQUy6VGBPZdOFcTJxqSIpVg0g6N
	 CJ56jiOBGOxk6DGjs/KFmhuWRmFPN/nvFRRFIjHZGre4OdaELdsBmrn6MCi2D50qXC
	 MGoYa6hiVi2mA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/7] nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
Date: Mon, 21 Jul 2025 22:49:18 -0400
Message-ID: <20250722024924.49877-2-snitzer@kernel.org>
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

Previously nfs_local_probe() was made to disable and then attempt to
re-enable LOCALIO (via LOCALIO protocol handshake) if/when it was
called and LOCALIO already enabled.

Vague memory for _why_ this was the case is that this was useful
if/when a local NFS server were to be restarted with a local NFS
client connected to it.

But as it happens this causes an absurd amount of LOCALIO flapping
which has a side-effect of too much IO being needlessly sent to NFSD
(using RPC over the loopback network interface).  This is the
definition of "serious performance loss" (that negates the point of
having LOCALIO).

So remove this mis-optimization for re-enabling LOCALIO if/when an NFS
server is restarted (which is an extremely rare thing to do).  Will
revisit testing that scenario again but in the meantime this patch
restores the full benefit of LOCALIO.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 510d0a16cfe9..ecfe22a105ea 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -180,10 +180,8 @@ static void nfs_local_probe(struct nfs_client *clp)
 		return;
 	}
 
-	if (nfs_client_is_local(clp)) {
-		/* If already enabled, disable and re-enable */
-		nfs_localio_disable_client(clp);
-	}
+	if (nfs_client_is_local(clp))
+		return;
 
 	if (!nfs_uuid_begin(&clp->cl_uuid))
 		return;
@@ -244,7 +242,8 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		case -ENOMEM:
 		case -ENXIO:
 		case -ENOENT:
-			/* Revalidate localio, will disable if unsupported */
+			/* Revalidate localio */
+			nfs_localio_disable_client(clp);
 			nfs_local_probe(clp);
 		}
 	}
-- 
2.44.0


