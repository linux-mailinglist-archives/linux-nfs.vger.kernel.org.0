Return-Path: <linux-nfs+bounces-6409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E529769E3
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 15:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C132A2855F7
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179FB1AB6E2;
	Thu, 12 Sep 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CARefJUH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB41AB52D;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146162; cv=none; b=N7SdKnLHd40Zz2EaPJfx2v+NDDycrEJsQHhLWbTp25pBcj723zTbCQthgiO/7StacJftuTMB2wLh0mHzZD3Ur/vWAEy8oUUXLg9ce9ItkYvnrsKEhlE6PWieoIsmJJAbNQbjg2fpz3i8UvQl4JgA5BBDh4ot8dYoQFoRhFRB/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146162; c=relaxed/simple;
	bh=vYTxFFsCzvfKqDGXjnJvxAnURll9M3pNR5qgFnoTbWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivSnMhMJHu1ORJhfptohjfDq4EMdY46pOZCqwnQvxbIWoDzVtXXi5kFXjlVcoJaW/YU1dqOmoxBSEvNtYaRbHfCdYpEBHSlwBtkG31Ur4uh8BrtfT0uQQpoQBDvXPiGoe666F7jijB0F8dAJsBSB6I3wpbtcsH60tyH9Y57Rk3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CARefJUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947E4C4CEDA;
	Thu, 12 Sep 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146161;
	bh=vYTxFFsCzvfKqDGXjnJvxAnURll9M3pNR5qgFnoTbWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CARefJUHwex36sC8d/Ws5NIyyYVmhyrFfOxjr7/uY00eOLLU+fvO6l2D5RV5D5XRr
	 hpJVXWUMyso4+zUed37yU9LmssUYXnpVeCHHfcDomQzOuQBtLOXVE8jqVAIHltaX4v
	 l+OpWZsg+ILIj6/I5ULnui3rq+FbebsW+XD7DNaEJubRnX5W4yhW2rtR26QoYWF//5
	 sXiQqnNEvujviydngt9NyPAv4iaZNu6w+XVZY0jpZ8NnQ+nM87crBI5oKtaipF6Eqy
	 B5FdY3MCnm2YvKIU+KvdqzhHpu1uueGJN9NM2m/QgkGbm859Mq5VbcA3oCR3a7RPbg
	 1g4SzRx7RucdQ==
Received: by pali.im (Postfix)
	id 119E4C01; Thu, 12 Sep 2024 15:02:36 +0200 (CEST)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] nfs: Fix -o sec=none output in /proc/mounts
Date: Thu, 12 Sep 2024 15:02:19 +0200
Message-Id: <20240912130220.17032-5-pali@kernel.org>
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

Linux nfs userspace tools supports AUTH_NULL flavor under name 'none'.
This name is used in /etc/exports file and also in '-o sec' mount option.

So for compatibility show AUTH_NULL flavor in /proc/mounts output as 'none'
instead of 'null'.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 fs/nfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 4cb319be55ca..86d98d15ee22 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -321,7 +321,7 @@ static const char *nfs_pseudoflavour_to_name(rpc_authflavor_t flavour)
 		const char *str;
 	} sec_flavours[NFS_AUTH_INFO_MAX_FLAVORS] = {
 		/* update NFS_AUTH_INFO_MAX_FLAVORS when this list changes! */
-		{ RPC_AUTH_NULL, "null" },
+		{ RPC_AUTH_NULL, "none" },
 		{ RPC_AUTH_UNIX, "sys" },
 		{ RPC_AUTH_GSS_KRB5, "krb5" },
 		{ RPC_AUTH_GSS_KRB5I, "krb5i" },
-- 
2.20.1


