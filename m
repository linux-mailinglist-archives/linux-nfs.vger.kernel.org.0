Return-Path: <linux-nfs+bounces-13381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B0B18651
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B112173A43
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA61DED47;
	Fri,  1 Aug 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjYEAx2t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE526F2F2
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068253; cv=none; b=XduQy2RLQenkQEIzYeLJNYsAEOuK8nQ0HgsCSyzw9zJe/xPuudV2MKJ6GDwOu1CtjXglrcDS8AHv0/FkxQOcO3aF+JLLHO3tcnbN8+RDh93SlTrmDYnviVpM3KRhwe6EQXOwxffR7t3L9FFBHFTeGQ2F8tgGRfwdszCqyu7CiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068253; c=relaxed/simple;
	bh=22zp6XZfxtW0VGlxDfahfz2vH97nD2M26SHIVYlutPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACLnKfit8UYeryNaU/28N91owQrzyiSRKg8V3+c+JdymjQiEmTNM8w89hakznXCO1+oq4P5nWxlldahvXXSo/Nq0pXgiqK2HpB4Rrx2cuo0sVbTGx9Am5HuEXWpWAHBg8LOywm3zPWvuJocCyGQzYxzUcBvfURmz/usZRcKBtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjYEAx2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E64C4CEE7;
	Fri,  1 Aug 2025 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068252;
	bh=22zp6XZfxtW0VGlxDfahfz2vH97nD2M26SHIVYlutPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjYEAx2tfAnA6YWiPEQWn2umpkqb1rbnm0kSOKahxwr9XMhBs6TRYLV/Ea8LRp4+3
	 D8ivwC4ivTZKlDRSgG09AQuZVSjV0W6dPfgf3vfwUNFEoSMUD7PyDB8EPjSFwH073E
	 989dsHcPYhZvlqU0i4g3acDwgGDxrySO3p1xsLrJSxNCqHaBnYl8WUL0jgx1gBI5/m
	 XaA6gKpay60B4i5YVaj4y7F9Kv+3manTCiqMfxCSluGDYp849lwyhE8WmVbXN1dmjX
	 0w2NfK11HG887uYXCm68SrBa3+rT46+D/mw6q+hXdDzCWqZgkQjohEQc1wrTYO3fVs
	 ND2Om4/LNt9ww==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v6 1/7] nfs/localio: avoid bouncing LOCALIO if nfs_client_is_local()
Date: Fri,  1 Aug 2025 13:10:43 -0400
Message-ID: <20250801171049.94235-2-snitzer@kernel.org>
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
index 510d0a16cfe91..ecfe22a105eaf 100644
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


