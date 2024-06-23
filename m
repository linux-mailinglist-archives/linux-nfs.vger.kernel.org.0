Return-Path: <linux-nfs+bounces-4243-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C4913B4D
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4961F21A95
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23018306F;
	Sun, 23 Jun 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOaWOtNg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E61822EA;
	Sun, 23 Jun 2024 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150320; cv=none; b=RAKE3Fx4JLtEyhBahjDn80aB/6x8nZoIJDwxyZE8u4qECY5qq5fZ1XTza6EJzVFytCPPZTodoc070Yt0kWBsyBOcyoMddocOZ5L6GgGWV3zteFXqrg0xjcWqILgHccxE/EnvC0D4OekCAnj0BtyRP/AZ+URelq4ogWsodw0azmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150320; c=relaxed/simple;
	bh=32heXUwtKJqYsXUkMr4DeerSE5vDJoTDbwuhcnQVVoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8nEfqskCYSCOdgzSG9pOTGkhJcIz0tOhGlWwQ4jwLxf+6CHiw/yt5OUUPUdCOL/uVCnXhsZacHxB7RP324srCb+810/RES03RjhJzKKANvJQWZkeagEz8hfECE+eFQWODNuXKank5+HpRhtoU4/nb54N7/dIdXzC8L5M1uFU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOaWOtNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926DAC4AF0C;
	Sun, 23 Jun 2024 13:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150320;
	bh=32heXUwtKJqYsXUkMr4DeerSE5vDJoTDbwuhcnQVVoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FOaWOtNgob9qvpQVmjtWfInwTKsAeK4Wc1SAYLxebPWp/zU2EJ9cHU9Ot7MiDPxnd
	 WkxqLkJ/cNqHxLrLq54wIlqPDZMkG6s3uIVNrwRmQMbKbA1KVjUw+7de4HmoaFb0Zf
	 5yON3H+avJD0MQfbc9FYvBTjexkvlAlfm+/krucTJs5zIBygGHTlko2Rm1U0y5/Bn6
	 ul7z6Ed4QeJxfV9zcFKIHM4F0PRYD9CMA4mL3ARUTgrMTJzqwVhZxGfY5BGllQXy1u
	 bZ+otvG+58zIYtzsB4G3QbFY+b58T3/51gxgwL7khYzulkRaZVf2c4H74ZpTlBUUcW
	 3XbFnw0sXZ6Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Mastykin <mastichi@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/12] NFSv4: Fix memory leak in nfs4_set_security_label
Date: Sun, 23 Jun 2024 09:45:04 -0400
Message-ID: <20240623134518.809802-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit

From: Dmitry Mastykin <mastichi@gmail.com>

[ Upstream commit aad11473f8f4be3df86461081ce35ec5b145ba68 ]

We leak nfs_fattr and nfs4_label every time we set a security xattr.

Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ec641a8f6604b..cc620fc7aaf7b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6274,6 +6274,7 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 	if (status == 0)
 		nfs_setsecurity(inode, fattr);
 
+	nfs_free_fattr(fattr);
 	return status;
 }
 #endif	/* CONFIG_NFS_V4_SECURITY_LABEL */
-- 
2.43.0


