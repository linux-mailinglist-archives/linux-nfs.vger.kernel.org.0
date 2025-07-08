Return-Path: <linux-nfs+bounces-12938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5ACAFD07A
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100C2188672B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CD82E427E;
	Tue,  8 Jul 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhYArUsB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A552E266B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991670; cv=none; b=cqzFtQS6zVzOKILdJjFvFL4bZlj99c31Wu5d4kYmefa95n+slp0kaz3HT7mYRcw1W0iGYs3eQLW3x/lANJPN/gtVZrjLk2rP97tV3+u4HOo+4YKp869ZhjMObozxjkxNaBMQzIFKzAzJ1Z+UAb0jxuYyXUX0AWV8MAhvYxQFFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991670; c=relaxed/simple;
	bh=RsB3Gdc3UaYWER8K5kGGBo+3RyWQmjnMwf0n7jOlaps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbCoJuv4+MAZYu1aWfdh1mpSgU3WSIkq5oMOjTs3CRqJyCxcAIItgllk3bo4Q2rodykQq6Yyy6YHPItvzs4pm0apoVHOdOUjPSTXD4/QytBuzOC1+yf3zCgrE3+z6aOaPPy8ZbNbn3clM+ltdyTXD7WoGIFCCwJX7HvogC67nQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhYArUsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7088C4CEED;
	Tue,  8 Jul 2025 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991670;
	bh=RsB3Gdc3UaYWER8K5kGGBo+3RyWQmjnMwf0n7jOlaps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhYArUsBIoOjrGP3BMmP0NshJIAM11JtDARQHMD9hEbhJBLw2wFyixQUp4MSf2odA
	 FDoMvj0H2JNc8+igHuYkDNe7buCnp+vsiH8trnLU30uRNEloLUoadP4/P+XMN0/58B
	 Rk7D0ZrccqdYCIzMjynR533BsuENVT6Ow0Q4BJTZY+gCai4PLZfzGdjuxXEjquP3QL
	 gtE6WPzM+AfBHKOl38ZTNEXIY/wphqjM5qBuYIwx14yVgLBlUPj+nW1UG2CB9cy/UD
	 aUQpwp3tS40M2lVicwGC1DHRYMW4I+fKz/yPrsbXN0avBPu4b0Hs862o2wDCNabw0P
	 p4/zedpnGr4lA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	snitzer@kernel.org,
	Mike Snitzer <snitzer@hammerspace.com>
Subject: [RFC PATCH 1/6] nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
Date: Tue,  8 Jul 2025 12:20:42 -0400
Message-ID: <20250708162047.65017-2-snitzer@kernel.org>
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
---
 fs/nfs/localio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index ef12dd279539..b728b9305a0f 100644
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
@@ -237,7 +235,8 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
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


