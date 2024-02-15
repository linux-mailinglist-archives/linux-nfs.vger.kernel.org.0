Return-Path: <linux-nfs+bounces-1968-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C237856CF5
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 19:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D571D28F7BE
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Feb 2024 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896201386DF;
	Thu, 15 Feb 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn/RtFVs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622471386DD
	for <linux-nfs@vger.kernel.org>; Thu, 15 Feb 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022562; cv=none; b=gEfyAyw0y76ac/1mab6Mw0/N8eVEz86/HW2rnv1XPDb8YI1cCWc3xidwnupN/4bRhPA3pizHBROvbaiAAJko3MLYrA9HvOpvoSnkiICtjDyAKhbTnCp1YAEZcfEK4gqACkDbC4pRds1OMEsDNUHtdzVSxp1YkMkcbUiT6rZj6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022562; c=relaxed/simple;
	bh=UMHgVWMg1bBalJsVtKImJWwTuudZ6oDtK586t6gMfYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+0QgBNCycvtlV5NHgELJlf7fSLmVC7vo+E+e79UztBMyMYYbMXlANeJt9yl9n1Ha1+sCw1EzCinLq7W2sb8dP6o8dCvZXwliz72j7Yg0qy9AyVZURP0Jq3fGur799C13eD4MRtkC9NBzEr1OrI5WLDMLaZ8nahsrow/wvvGQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn/RtFVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B698BC433C7;
	Thu, 15 Feb 2024 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708022562;
	bh=UMHgVWMg1bBalJsVtKImJWwTuudZ6oDtK586t6gMfYg=;
	h=From:To:Cc:Subject:Date:From;
	b=tn/RtFVsdDxNH5I4GIqbwM72tSScDT7pcLnQJ51WCoagkmXk7bLWp0EL9+MLMaPgL
	 WiCzPcNbfWQ6JeMejrpMmcS4U5P/oqNoBCJM+Egn/4a8laxAzEqYCrwVOmaHTqneMH
	 goNa4MmS70AG86shm/6rpF7svlEmHKp1fzoxwr6lLiYZZHp311qeFg3fkea50qivYP
	 to2LXuAc+KfaIUgXrbQWe6cduY9X0MpFkdZds+PB58zJM1eK9BYApkYP+jSuRX/DVh
	 eSIJ7QLlGxQfvlq+rE6FKDIV5pefd0B3w5DUkWy9KJ90i5q0uxidyg1FWD25j8DHKN
	 FOSCDQ86++O4Q==
From: Jeff Layton <jlayton@kernel.org>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: remove unused NFS_CALL macro
Date: Thu, 15 Feb 2024 13:42:40 -0500
Message-ID: <20240215184240.82306-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing uses this, and thank goodness, as the syntax looks horrid.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/nfs_xdr.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 539b57fbf3ce..d09b9773b20c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1820,13 +1820,6 @@ struct nfs_rpc_ops {
 	void	(*disable_swap)(struct inode *inode);
 };
 
-/*
- * 	NFS_CALL(getattr, inode, (fattr));
- * into
- *	NFS_PROTO(inode)->getattr(fattr);
- */
-#define NFS_CALL(op, inode, args)	NFS_PROTO(inode)->op args
-
 /*
  * Function vectors etc. for the NFS client
  */
-- 
2.43.0


