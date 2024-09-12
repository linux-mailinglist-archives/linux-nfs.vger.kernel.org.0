Return-Path: <linux-nfs+bounces-6405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6E9769DB
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2241F234C9
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523319F42D;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0v2BHbK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79E3A267;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146161; cv=none; b=n0hSrYcjDhqetp7q1LZANuEp4Hz3a5lPilTlSHnuGFHt1BxtuoxlVB4DOiTlEXxmgAicDY3YDFI6J5+QVZGwOhJYcParX831dM/Qn3IHGYkqq7/65LV0RjCGiVi+ewyzaVmM/B1svEo/QEcPMprSF05yPTvz7XeHlkolW0KbRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146161; c=relaxed/simple;
	bh=eyR+pOiVzBa/kDDxhPyz/knSOuyik7GIQNAJydI0rtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtvIkDFnzLs+2cigyqm46VNyqpLW9ADx7griReOFYH7BUpMbdXd41ljcG4eXL6ips4Y8H5NflAgrHPyCdMtloi5MZcRU49kKxfMSd8lJObyiseSpsKltsSbOVV7aI9vWWogId48w8bOrKHqkQ9qOdHCwDsWVITROsaWrEpI7DqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0v2BHbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACD7C4CEC5;
	Thu, 12 Sep 2024 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146160;
	bh=eyR+pOiVzBa/kDDxhPyz/knSOuyik7GIQNAJydI0rtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0v2BHbKkEaXkmJ0sranppcJunUhVPleXYNPPkXCXcQMNLLT06qoRrg9k7RC9OIWJ
	 Fit9MJjjlyt2nM3/1DIxqaiSgqxFqSk6hrhcM12drFVsHLL+wuhfxtojjzoe0aNKCS
	 Vtz81u8kBo2uirJUEHNAs+RrNYcnbHISWJ4GA/EF7zVVs9brTfJqm9K7yXgwa8GEGr
	 NskVkVvz/cbbIBcUNF9k2HdB//rCjfuONxut1TxhQf5M2YjpyC50o6N05Q7AgjVqcy
	 G0iDYjSkAnbvzoXzzi0m9iId8ijL1edJ/eueeEITP5H/GalrQsfyjzbvC1Crxqaxtm
	 8IFuxuc+5Mo/w==
Received: by pali.im (Postfix)
	id 827F0A11; Thu, 12 Sep 2024 15:02:35 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] nfs: Fix support for NFS3 mount with -o sec=none from Linux MNTv3 server
Date: Thu, 12 Sep 2024 15:02:16 +0200
Message-Id: <20240912130220.17032-2-pali@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912130220.17032-1-pali@kernel.org>
References: <20240912130220.17032-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Linux MNTv3 server does not announce AUTH_NULL in auth_info response.
This is a MNTv3 server bug and prevents kernel to mount exports with
AUTH_NULL flavor. So as a workaround when user explicitly specifies
only AUTH_NULL flavor via mount option -o sec=none then allow to
continue mounting export via AUTH_NULL.

This change fixes mounting of NFS3 AUTH_NULL exports from Linux NFS3
servers.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 fs/nfs/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 97b386032b71..3fef2afd94bd 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -819,6 +819,20 @@ static int nfs_verify_authflavors(struct nfs_fs_context *ctx,
 		goto out;
 	}
 
+	/*
+	 * Linux MNTv3 server does not announce AUTH_NULL in auth_info response.
+	 * This is a MNTv3 server bug and prevents kernel to mount exports with
+	 * AUTH_NULL flavor. So as a workaround when user explicitly specifies
+	 * only AUTH_NULL flavor via mount option -o sec=none then allow to
+	 * continue mounting export via AUTH_NULL.
+	 */
+	if (ctx->auth_info.flavor_len == 1 && ctx->auth_info.flavors[0] == RPC_AUTH_NULL) {
+		dfprintk(MOUNT,
+			 "NFS: requested auth flavor \"none\" is not announced by server, continuing anyway\n");
+		flavor = RPC_AUTH_NULL;
+		goto out;
+	}
+
 	dfprintk(MOUNT,
 		 "NFS: specified auth flavors not supported by server\n");
 	return -EACCES;
-- 
2.20.1


