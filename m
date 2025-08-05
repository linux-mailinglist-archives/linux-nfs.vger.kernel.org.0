Return-Path: <linux-nfs+bounces-13451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491EAB1BD0A
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BF418A43F7
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BAD2BDC2E;
	Tue,  5 Aug 2025 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISrRNpuf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66520B7ED
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436074; cv=none; b=nzlXcbPgvqAFN6qw9tN7M6gnHHmi0R4aTh+CyWxOZKtmTAL/e0cAu6Z5WjiEqYN80l2jL7BkQYXSUNlvme5DVktgMC8pJHDqXZQtOsIuf5wAVqcKQ9cUONUwtVq9ycpzDUCK76U7HX7pDZFIqBzV6teZ4y10oIRFVSF1CY8eCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436074; c=relaxed/simple;
	bh=Qr0k08EzRrF3DD6Mlyi26ySaPhsm3lZqVbFUD/jxiA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9n2Y0kFGfSj9TGvR2IXR5WV3x7PKURSMwhURMlJ1ZoQSKpnQeNsbmZCKjL7+Vnu6aa7sGvKI9DsAxhFT+zXknwAwlxyx8o8Ba2FzX/nR4L4snQvFW8qnhfJTgJFTVqzedztpi2pjBiaXYce+z6pmlZjnem4D5JidIthFcS0iYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISrRNpuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660C6C4CEF0;
	Tue,  5 Aug 2025 23:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436073;
	bh=Qr0k08EzRrF3DD6Mlyi26ySaPhsm3lZqVbFUD/jxiA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISrRNpufxqcvZ6riULEpZP20d2TzHHYkztDxQMQtUTU6/AvNVF/CD/x9TOLhlwoTt
	 2MxOlL16mb7soxiaDrhNrYv6elndai9EfS/MO4o4S2cjDnOO1Fryn99DpuhdMVa7d6
	 hQl9t0M7JMvxUuPK2TpzwogW9PlK/NZ0LnqRmoYoetmpRmsVWqOf6U+rzcsAfmDHVy
	 UM40CkWf1DaOR9uF95NblffqVmVPexIglocUFiTZ5Nmhjcz0WuW8U6a8eGQ3YBOpup
	 ps2LJpceoxhIne3rI2tmnv6FQAH4hsN6aGWTrlgREpq+1JsA6bMvpb3ykx5jW5V+8F
	 9qiMPCnrMCXHg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 04/11] nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
Date: Tue,  5 Aug 2025 19:20:59 -0400
Message-ID: <20250805232106.8656-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
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
index bd5fca2858998..9adcd1380bbba 100644
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


