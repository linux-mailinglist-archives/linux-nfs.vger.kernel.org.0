Return-Path: <linux-nfs+bounces-13953-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FFEB3C166
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 18:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D3C1896064
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Aug 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A233EB13;
	Fri, 29 Aug 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQoS1hH6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F633EB0E
	for <linux-nfs@vger.kernel.org>; Fri, 29 Aug 2025 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486666; cv=none; b=LsdCF/YleoWS703XH7/EY0K9D2GtVfhTtlAGjrKPo6dBGmr+Ib0vSKtGrzBTJUrxgE4vIENXu7ZNWQjk4kOYdPjiRF9L1GsRLj5qY8VObaIGZddRWmZHBvHG7c76lUJe39PpOaye0Fe3DnQNXNcNtwZLFnr+1WnuZUvwceFOieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486666; c=relaxed/simple;
	bh=RDE+fANyaRiYRPEp/LLK3kFjpoqXFv3SfZQETGq0NMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuwyG3tjXkv+uKhhQChSu8KukeY4uLaUT3GdEkWYe1HXQ70kAdK2mYSK/aQFaIUtubfJBg8dBXHutzLtmvbdYrymCbudh2e2cO6vTT/fBx33N3T70n1eJ27zD0kK54Wt0QfFI8q9A9pbS8tuSJ1Hy8d+xuXmSI9p+ZC4rJXnVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQoS1hH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FF8C4CEF8;
	Fri, 29 Aug 2025 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756486665;
	bh=RDE+fANyaRiYRPEp/LLK3kFjpoqXFv3SfZQETGq0NMw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KQoS1hH6uneeua/KwQ5knX7Pnne4jZ9BT7PgOxmtKhUmzMasNWpYB8RBqLOWT+ngi
	 IV+++f5lOmHZLuJIzqp4MyyzmveQkJdTPf5pOsPi0BRZ68o7C62/SRIEyhYoNZfDOz
	 pVKTc39o4oMhZYGbtPmK/nJGuwbWP6h1y7ncI1qLFNOpKgf1kYa92GrswLJIE9mnUC
	 1vAyMr1yAU78LMMlKeoRF44VW3h+LLuyKSIz8mFuxOFpykRY4dQ94heDTafDgeSO0o
	 ObERTB3wIcZ9lc6qlmgO6fIC8Opmm6UWsvPb0iHOAaDHllNHEqsnTYKZClQIY+Llhk
	 O/CRta3Zw3mVw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org,
	Scott Haiden <scott.b.haiden@gmail.com>
Subject: [PATCH 2/4] NFSv4: Clear the NFS_CAP_FS_LOCATIONS flag if it is not set
Date: Fri, 29 Aug 2025 12:57:40 -0400
Message-ID: <dd5a8621b886b02f8341c5d4ea68eb2c552ebd3e.1756486626.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756486626.git.trond.myklebust@hammerspace.com>
References: <528e7a88-9c63-43d4-8c67-50a36ceda8a7@gmail.com> <cover.1756486626.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

_nfs4_server_capabilities() is expected to clear any flags that are not
supported by the server.

Fixes: 8a59bb93b7e3 ("NFSv4 store server support for fs_location attribute")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5b92fcf45dd7..d0f91d9430f6 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4013,8 +4013,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 				     res.attr_bitmask[2];
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
-		server->caps &= ~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS |
-				  NFS_CAP_SYMLINKS| NFS_CAP_SECURITY_LABEL);
+		server->caps &=
+			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
+			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS);
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
-- 
2.51.0


