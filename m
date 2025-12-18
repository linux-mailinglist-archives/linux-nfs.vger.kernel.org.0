Return-Path: <linux-nfs+bounces-17212-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76891CCD7FE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EFC43025705
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752F2C08C0;
	Thu, 18 Dec 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfm6qYAb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AF2D877D
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088849; cv=none; b=F5Ddfm9GqVNQf4g9IshT760wQ2CJ9NafLum/5pveFmG8SEhAGutqkHpFYhmhHV/GCCBVs5eBe2G6zrKBJ4WcCp+kSgkXj/tom5DCzQ2Edinz8K+IHs7JB74fGOmldVBMidd+qIXoQPJqxFxfxo+CAXhlTJ/QxtPjfmzitKxMxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088849; c=relaxed/simple;
	bh=gjZgUFq7uHadujGBdlcMqFrmrk33jgo3MxfWmFGMegI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdZxNJKdS/i7aFadSSHjl79t3YgERmhjiDWcE3nzOf5LeWq8cGvXKs/CmWYDsPFyBlnRaXTDe7vbg3feL3S02CDZ7w4VYwfwq9bnQs9uIjKBmPjN6ooI1v6Vqf9c1qdR0lLliFJdBh7utimz+fqY1eUsPkGm7mfe6G1767hCUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfm6qYAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E92FC16AAE;
	Thu, 18 Dec 2025 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088848;
	bh=gjZgUFq7uHadujGBdlcMqFrmrk33jgo3MxfWmFGMegI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kfm6qYAbcpBI+j3K7Hu/3f/BpjqjJ7EBZna92kSeQd5RBO+PSNLMs+kRS5GcU3Owo
	 Poy19+j1GSnyvswZLINgPBPx3AoUs8PdRyz1Wr51kSRrjoepqIAd11G2jfCNVPFKVq
	 qwYbMCsrGaJVXWVaqu+k7h+GDrjJUcWIoGFAV7I3zmRU8E7s2b3MKnzaArUmw5KZe3
	 sAldWELpOPyaP1lX/PGW5sp9Gp8agPJ/v+GdXsTpkcRSumllFHPW2gXIYV6lwLvtjT
	 hsJpBszc+sOlCbhDZsZ9n05NtcZaUpCUa+Y0JZhHQj6gi0Joq3E/L9tT7MvMR4h/Yi
	 q42YiV1uS3IsQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 24/36] lockd: Convert server-side NLMPROC4_CANCEL_RES to use xdrgen
Date: Thu, 18 Dec 2025 15:13:34 -0500
Message-ID: <20251218201346.1190928-25-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 8fe6fb952089..c005eb73e146 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1057,15 +1057,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "LOCK_RES",
 	},
-	[NLMPROC_CANCEL_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "CANCEL_RES",
+	[NLMPROC4_CANCEL_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "CANCEL_RES",
 	},
 	[NLMPROC_UNLOCK_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.52.0


