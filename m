Return-Path: <linux-nfs+bounces-5332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3F894F9B0
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295DFB2284E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CE198A20;
	Mon, 12 Aug 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8FZxJxk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B2197A9F;
	Mon, 12 Aug 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502235; cv=none; b=PZHU3cNcG+4mlqrhQ7X3k8+KBCHTJmEpIPCa3iw4xya+pYJEWrjL5Q6b57PCD8iwaJ8G9H6QJFkuNe0eKe16zBCtK49SNWpLk3r2TyQmVaorVVNGJwOXGMALXKnITnJZSzBNKdiCTjAJrDq/5bPLbdVAPN0aU3YSbYSzrVBa/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502235; c=relaxed/simple;
	bh=pay9oNX7AAEbPMFc2rGq+J2C4vJJ5nxFoVlDB5HVIL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8Np7PGYhQSS9K2Kse5AR2/RwFytVc2cGkfymQcZfAR4bSutSyHuysamIdWQYR2G/pCoN2dHFJs4ZhRW6p23InbI4cmsUNU8nS9vz4PGz83p51St7H5Nn31NfnOQCmgof450whkNIwX0zyKXbYp2vVRUTnqMGgyrd1TTDFBaLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8FZxJxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F638C4AF0D;
	Mon, 12 Aug 2024 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502234;
	bh=pay9oNX7AAEbPMFc2rGq+J2C4vJJ5nxFoVlDB5HVIL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8FZxJxkS/JEftvmNaUWqRjHHwpREjWEHmWuK5P/exl5e/uzanBqYWGJP3VgNbihL
	 Pese5CpjjH5YWq0yFgqUtYas8o2PEIeneuLaYnMD9m9uRwfpkjcmzqKuhRqYbGwLlf
	 kTRE5RCZL4BJcWTSxNI1/YVrvIxWx8Jf/HYrCG9U4DyFb8ieQJqYGv03pJxzv/kiu3
	 OA3BCUZYCNhLpuYxixLfSVRv8lyKCiubGzTztEHl415iCVaZoteCHDa/rb7sZkmO41
	 dJN8vhAslX3sv5XAyo09FIHxRfTOfJijttJRHdiLIBWBHlFXu0gU311XilUWCRmYsk
	 /Cch3dD5TZPfQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 06/12] sunrpc: remove ->pg_stats from svc_program
Date: Mon, 12 Aug 2024 18:35:58 -0400
Message-ID: <20240812223604.32592-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
References: <20240812223604.32592-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 3f6ef182f144dcc9a4d942f97b6a8ed969f13c95 ]

Now that this isn't used anywhere, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c           | 1 -
 include/linux/sunrpc/svc.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index bd9572ce2310..acb1c1242005 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -136,7 +136,6 @@ struct svc_program		nfsd_program = {
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_stats		= &nfsd_svcstats,	/* version table */
 	.pg_authenticate	= &svc_set_client,	/* export authentication */
 	.pg_init_request	= nfsd_init_request,
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 1a13ea759af3..3d8b215f32d5 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -336,7 +336,6 @@ struct svc_program {
 	const struct svc_version **pg_vers;	/* version array */
 	char *			pg_name;	/* service name */
 	char *			pg_class;	/* class name: services sharing authentication */
-	struct svc_stat *	pg_stats;	/* rpc statistics */
 	enum svc_auth_status	(*pg_authenticate)(struct svc_rqst *rqstp);
 	__be32			(*pg_init_request)(struct svc_rqst *,
 						   const struct svc_program *,
-- 
2.45.1


