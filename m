Return-Path: <linux-nfs+bounces-7795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4AA9C2828
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E17B21BB2
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715831F427F;
	Fri,  8 Nov 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8zV/JoT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA81E1C07
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109208; cv=none; b=NP5ADdcf5spAewSM9xCmdGUpjbfBucTLGyBiM8MhZfnxeGA6+Nmp6HH7sGW1dTgdjO/Nm3z5wXD6pa6XjiEZyOr0Kw96XO5yJtij55nP7VyBuEFvrHTF1TE7HiXD5mwBT9X5RXNBm6eRKIvae3XHNGGmCXUUuSr8gXPcJXM6H2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109208; c=relaxed/simple;
	bh=FzOLyeaGBvt9On5a9zfpPiVNqNEPSXph8kLfTfie5iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrne6HV1mctA7fLr6Qjb3tVYOSipTBccywdddeHT+JX6Tp60QqwGpuYK2HJVbtqHfRKRp17njH/EGnmEEnCywOIVHIDopNC7IYe82vfOehSrjScqshyVYXe39LZQj/W9MWxgTjY+OyuOtuXb1eol5ENplHTVVuxVuJG3HE5pSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8zV/JoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D29C4CED2;
	Fri,  8 Nov 2024 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109208;
	bh=FzOLyeaGBvt9On5a9zfpPiVNqNEPSXph8kLfTfie5iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8zV/JoT6QyyP4VR2kyueJKXPYi4//Ex7ElU8sMtsbYTmCApofLyTTGQw8/4BMYDG
	 lS7pM+XKzBPmEGLnFd2E1+sE+KqihNDocMMUCmDFWqJPJbTk0/mrk5OnRK0gpHaB9O
	 nJm91RUd7p56UHwIqy5+mJ6G8ZSztojAW1jlotGJPn73BAIdocuUILMiFMd2hO3hOf
	 UGyfLDMQ43HPkJ8XPyNG2mH8V94HSgRG16HT7BlUs8BWDU9DgkiHESe4kIUYkRZC+t
	 auSUZG28Kyc/qPlKGBUz25yMkEp2ZUtNeb0FZEPWhETp56jgkNTRI2A4aUC/vqCbBK
	 6QH6yBpNy62Eg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 03/19] nfs/localio: remove redundant suid/sgid handling
Date: Fri,  8 Nov 2024 18:39:46 -0500
Message-ID: <20241108234002.16392-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

nfs_writeback_done() will take care of suid/sgid corner case.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 637528e6368e..4b24933093b6 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -527,12 +527,7 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 	}
 	if (status < 0)
 		nfs_reset_boot_verifier(inode);
-	else if (nfs_should_remove_suid(inode)) {
-		/* Deal with the suid/sgid bit corner case */
-		spin_lock(&inode->i_lock);
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
-		spin_unlock(&inode->i_lock);
-	}
+
 	nfs_local_pgio_done(hdr, status);
 }
 
-- 
2.44.0


