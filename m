Return-Path: <linux-nfs+bounces-17576-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09257CFED0E
	for <lists+linux-nfs@lfdr.de>; Wed, 07 Jan 2026 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C270300974C
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jan 2026 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377C350D68;
	Wed,  7 Jan 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlWVnIf8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C38390CC1
	for <linux-nfs@vger.kernel.org>; Wed,  7 Jan 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802147; cv=none; b=aAqPsHR48LC+n0xPJ7c02gtSfm7rucnnx/GVOesX6d9NRAsZGF9hK2e9IJ5keAYm5c/OU+mcVj9k5/TmfCLV8k6TH6yXzxR+OcngY1tKgQWzitOjkwuXod/hUyZ0w7xgIzaFvmPuSvs8k7hc6hLLZ/vrBPOElyFw79kCWtIYIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802147; c=relaxed/simple;
	bh=Z7/GQU/lYZ5nSIUU/OyVImD/CkOETzR+4gzn3pwUMDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBCMUqQwCZeI0IZKXg7j08Wo72QcV9a1lDKvjipVM/6/tbUoa17zjp1MpR+AF2hOowBObWBPFP7eSEzVgkNG0ooWzGPDbA9TjBJAo6H4iNPj06+rkJbe46+YKMPsIAvRmRccV8sS/mB9vdfsScf33kfk2U+zaxT1Y1LdKoDuiXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlWVnIf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238EAC4CEF7;
	Wed,  7 Jan 2026 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767802144;
	bh=Z7/GQU/lYZ5nSIUU/OyVImD/CkOETzR+4gzn3pwUMDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlWVnIf8+kLOrCAZa5BQidbXZ1TTsXM9iObtpw+omhA1gPBS5ybSReGhptp96qSS4
	 0Xwa8zqq2cfii6XoToTaz40Pl2Wj3ZhEHMCOf4hwa1Ba+7dMhSzhcBUNllOG7+iGIN
	 MIsxCbuabH44LD8GzkjHRQnpBq5JQN1Hbr7VRB3aEntb0tzUmywpbytvVpitbPSqMt
	 E5501lT1o3IhHsng3g3G87vM/8Pplqg2g+FgHgYNv7Z38bzfTW2hWG8eoM85NsdVgW
	 OrEZIpdzvLRMGJy0+SCfp+0tvFUlHLPxoeYRp8Ikt6PBkTRwtGPQfOcaKnISa9NXck
	 UmklF3kgn5jFA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] NFS/localio: remove -EAGAIN handling in nfs_local_doio()
Date: Wed,  7 Jan 2026 11:08:57 -0500
Message-ID: <20260107160858.6847-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260107160858.6847-1-snitzer@kernel.org>
References: <20260107160858.6847-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handling -EAGAIN in nfs_local_doio() was introduced with commit
0978e5b85fc08 (nfs_do_local_{read,write} were made to have negative
checks for correspoding iter method) but commit e43e9a3a3d66
since eliminated the possibility for this -EAGAIN early return.

So remove nfs_local_doio()'s -EAGAIN handling that calls
nfs_localio_disable_client() -- while it should never happen from
nfs_do_local_{read,write} this particular -EAGAIN handling is now
"dead" and so it has become a liability.

Fixes: e43e9a3a3d66 ("nfs/localio: refactor iocb initialization")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 9ec1652cc5369..fa37425c5784b 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -989,8 +989,6 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd_file *localio,
 	}
 
 	if (status != 0) {
-		if (status == -EAGAIN)
-			nfs_localio_disable_client(clp);
 		nfs_local_iocb_release(iocb);
 		hdr->task.tk_status = status;
 		nfs_local_hdr_release(hdr, call_ops);
-- 
2.44.0


