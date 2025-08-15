Return-Path: <linux-nfs+bounces-13689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47598B288C2
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EFEB658B5
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD62D46D9;
	Fri, 15 Aug 2025 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyXMdR4S"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F32D46D4
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300607; cv=none; b=sz057KfyVxwYZo2AkyuPZYAEnoIBpJ3+9C+MIkvHxYWTbkU4/CUyh1079zSpWAirPos1Oi0XgMxxm+rAJ3vI89cn8fo2ttoi8sIlqdaZ6CqLU3uiV1y5+Klmg20lNEd/opjyWE1BUoXvWCAXBTO+G1Szwf8Ug+fVKxLSQv9Hscg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300607; c=relaxed/simple;
	bh=IZCXihO3Spbx4dix5SR1R4666mw78e9r35+oZGkmL44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwJBASXsEmHg+j6epDo9RfZStGcdtUSWjqdeAmrVfhYNdF+/ETc8l1Ssc/UfjcCAExi+e2GGW2z1o3xaZBB89ZqO2GtvgjCbQs4209yyIvrdMNUTnWZQ/g7TZaLe2Z9wZx4bAy710GNi2fBCfroZIwjuRaYVPNRNohdf+rUc92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyXMdR4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BE8C4CEF4;
	Fri, 15 Aug 2025 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300606;
	bh=IZCXihO3Spbx4dix5SR1R4666mw78e9r35+oZGkmL44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyXMdR4SNpeQpArhqOqmM9Hy59QWAv2gMEbtCBCelVsb3PTjuwZ/SP1XizzekSS2x
	 wcPrbzY+Dk+sLqS78+xlT/WnS7aXCWnjtWvcTnTurhY6cywngGa76I531kjxFfr3A8
	 6eGsl5bJbB35EWxwZyKnGAlll0NZ9SHjD+iOUtCAIHGcVa65wB1KeyMCioIqV34SGi
	 fGhsGpbe1344s6o+gWYFKRxGYuCVJDh+Z3AROlCcyleESRE0Ts+zQeHECTWuFcOFjM
	 I4vDwCyuo5m17xGwqGMI0YJhp+rchX4M6UCuNIxlppHEHM7TOdwe9peW5rak+DAF36
	 uCHptUWjFL96g==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 1/9] nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
Date: Fri, 15 Aug 2025 19:29:55 -0400
Message-ID: <20250815233003.55071-2-snitzer@kernel.org>
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

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
---
 fs/nfs/localio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index bdb82a19136aa..97abf62f109d2 100644
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


