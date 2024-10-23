Return-Path: <linux-nfs+bounces-7386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF19ACB67
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1241F212AB
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671F1ABEA9;
	Wed, 23 Oct 2024 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM5EiCGt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA01459F6
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690757; cv=none; b=E/c/EZg+k1vHSOWeCNjnRU9fJlujMINW7iP/OEqFlJaCvzb9tfp9FAdMQSFxUoAC71xKKVpBfYj3oFjm0v10ZWCa74EdFSrEuhgezgIJmXgr2dJxRs3NH4/DdvYOzAXx5/U1aOUaeYtUXFEUTNbTCuRwNH66PZBFS3RKtCvlR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690757; c=relaxed/simple;
	bh=FnONdiHuF7W9JeNZm6pdmVXJLvZ/yw1J7V3bMRPR5Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXdmp2mU+MBLKPzMWeH+qvQDrLA00OfPQGZz43XyKUlVZSvc75NUnHz0ZtU/rODE/HOG7hfhVO3Jtk/f3Fb4ouK7vXg9V5CRIW4ElwXMzdJEhNtF4k1NwRuPou7O4o3spaOorxtXYdOUB0I8/UCN+spA41doZdHizdbw5Xkwukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM5EiCGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605AEC4CEC6;
	Wed, 23 Oct 2024 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690756;
	bh=FnONdiHuF7W9JeNZm6pdmVXJLvZ/yw1J7V3bMRPR5Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nM5EiCGtkSEzYeFM6lbT2VLHSObxbN4ledgv0OwO/rs2cur+TABxerRn48nsjtzb4
	 xXxe4MchneqYd7mwofT3vEv8jweR89Flr7cSEwwkODr2N3u8Dq2TKTfspLxnMI6QJK
	 fCBL24fKAKutkcfAyU9hcSSpyxZa0Sv20Y9XRxAW2vjE3JzcygYFiFjgYVY/SI71r3
	 54ojByzx2WnTA9KifhgV0FRzJ3H+FmHSV4xYxoCtFB/pLTI+/MCzXNUvxikfNoYxkc
	 IGANGZjzilgnzuQ4sN3EFDF558nBzp5drOE9RfAFpLz/EMkG0YaDHIpHj+H5xU7Wzp
	 H8eONF2sWMvQQ==
From: trondmy@kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix attribute delegation behaviour on exclusive create
Date: Wed, 23 Oct 2024 09:35:43 -0400
Message-ID: <ec430d0f67478233dba5625b3c1e8eca4c91626f.1729690156.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ec5b6e191b976c413dc00681013ad1378d9f260b.camel@kernel.org>
References: <ec5b6e191b976c413dc00681013ad1378d9f260b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When the client does an exclusive create and the server decides to store
the verifier in the timestamps, a SETATTR is subsequently sent to fix up
those timestamps. When that is the case, suppress the exceptions for
attribute delegations in nfs4_bitmap_copy_adjust().

Fixes: 32215c1f893a ("NFSv4: Don't request atime/mtime/size if they are delegated to us")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index cd2fbde2e6d7..9d40319e063d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3452,6 +3452,10 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		adjust_flags |= NFS_INO_INVALID_MODE;
 	if (sattr->ia_valid & (ATTR_UID | ATTR_GID))
 		adjust_flags |= NFS_INO_INVALID_OTHER;
+	if (sattr->ia_valid & ATTR_ATIME)
+		adjust_flags |= NFS_INO_INVALID_ATIME;
+	if (sattr->ia_valid & ATTR_MTIME)
+		adjust_flags |= NFS_INO_INVALID_MTIME;
 
 	do {
 		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, fattr->label),
-- 
2.47.0


