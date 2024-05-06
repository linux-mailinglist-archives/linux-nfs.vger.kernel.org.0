Return-Path: <linux-nfs+bounces-3182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083FA8BD69A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 23:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4302D1C20E72
	for <lists+linux-nfs@lfdr.de>; Mon,  6 May 2024 21:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBA446AC;
	Mon,  6 May 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgtKXXQi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4758EBB
	for <linux-nfs@vger.kernel.org>; Mon,  6 May 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029453; cv=none; b=HFZZD/i6alWxuYq51Yl9AZ8FmUGpP+WYObegQ++X7vYPUop9kJh/tQlqbODBGUxFQGdS05U42/GNVQqlBumgZdTwUyaorezVv3VVeRxxVRMEl66KaEeFJ0T6H32cKSeVAFvH/82mKGppYEcc9BPcgkTX5ULg2WTIcFnOiGvnzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029453; c=relaxed/simple;
	bh=84LaucSvuIO29dKS79xg+PYhSZWeRGW+mEGw/ORS+tI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bT377ZbTL+aig2LU1sKAsjmzOy8vzuIaXIvY+Ll/K11mt+cCMgQHVhRWvAIaq6HXcJNJADyUbtKD6TLLn84hJv5VYaHun/pu3huHrpXHQn6Ofw9pC55yLC4YshUQ+7ufD0fgaDm2sQ3+l3wLDXKDMxsnglZuN6hGe2/IUSSXTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgtKXXQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1BFC116B1;
	Mon,  6 May 2024 21:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715029452;
	bh=84LaucSvuIO29dKS79xg+PYhSZWeRGW+mEGw/ORS+tI=;
	h=From:To:Cc:Subject:Date:From;
	b=GgtKXXQiK/LQyDkdJf/JXJrCUTxGL3i6ZM17VJBMPLOI7gC7xSlqEgM42186VZTOG
	 IBX0kcNWeAI3dxzF2oulsuvP86agCo1J+MienIti37gXCzkLNSR44buiQeZWuD4olY
	 5QISFA+v2RW335A4ZOd06z+V+wNDXnpTGFi9WoJ/puBuGmDKHNKre2L6NZuzBZ75WM
	 Yt/1pW1/Bnhg4Pq6+oXnU8O/g1PzikhTqYh8w0nU3AJaQdR4X8B3XZGOBcjr02MH1L
	 nx9X5Ypi+teweRapf+QhdSB5wnNCgFZGQAsVTaB+H8n25XPdMGUx4ehOHuCb2VxO6n
	 vb01tfAyg14TQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Force all NFSv4.2 COPY requests to be synchronous
Date: Mon,  6 May 2024 17:04:08 -0400
Message-ID: <20240506210408.4760-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

We've discovered that delivering a CB_OFFLOAD operation can be
unreliable in some pretty unremarkable situations, and the Linux
NFS client does not yet support sending an OFFLOAD_STATUS
operation to probe whether an asynchronous COPY operation has
finished. On Linux NFS clients, COPY can hang until manually
interrupted.

I've tried a couple of remedies, but so far the side-effects are
worse than the disease. For now, force COPY operations to be
synchronous so that the use of CB_OFFLOAD is avoided entirely.

I have some patches that add an OFFLOAD_STATUS implementation to the
Linux NFS client, but that is not likely to fix older clients.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ea3cc3e870a7..12722c709cc6 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1807,6 +1807,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd4_copy *async_copy = NULL;
 
+	/*
+	 * Currently, async COPY is not reliable. Force all COPY
+	 * requests to be synchronous to avoid client application
+	 * hangs waiting for completion.
+	 */
+	nfsd4_copy_set_sync(copy, true);
+
 	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		trace_nfsd_copy_inter(copy);

base-commit: 939cb14d51a150e3c12ef7a8ce0ba04ce6131bd2
-- 
2.44.0


