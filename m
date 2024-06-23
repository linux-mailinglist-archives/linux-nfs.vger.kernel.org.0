Return-Path: <linux-nfs+bounces-4240-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B06913B27
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25E11F212CE
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5118EFCC;
	Sun, 23 Jun 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6uybJK7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F170718EFC7;
	Sun, 23 Jun 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150293; cv=none; b=tMz6N3Z58An9KUFWGPVS0Kwn/ojNPRm8mvzE2YVMdS1DEPuCQdr8hcEuYk0hrEj5wmtDWwuCIUQsW4t4CkxJ0Y5rDl7KLz/B2z4+MvM2dt1myhBkruquFNJcnFcFhc/scWpnT+i2kiK7Emw3uOPaozl0y/XN1Cc6evLTaxc6hYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150293; c=relaxed/simple;
	bh=EOP0IlNb/sPC/uwzDn2qLCQ8nM+BrFL0qAZeV9k+cko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j57fzevipRSrLUGkLlCSQvKE1vdcpWRCkdvfK1VbijRLlXj8iyDx2G2Bc5cG5+j0m0wCg5bT5GFdRm6NgC7quZBAYLkEHoNiTHJv5sf8ahpbIb0Uljhx8YCkxtshI1FWhF0Cbt9lOpPBeiLh1qEUWawuhialDdQXd+4+Ko7heo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6uybJK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B968BC4AF07;
	Sun, 23 Jun 2024 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150292;
	bh=EOP0IlNb/sPC/uwzDn2qLCQ8nM+BrFL0qAZeV9k+cko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T6uybJK7L/t83QE3O4gIQl+zUMurtcVidB57/DDhML0OttcEYcpOSKsvT+u5+fFX3
	 ddhkqaXf9NpufzG+8L8Matu4SnODo8BaEgzwoGnWut5Oav+MukKPmvHBWIt5r9ux5n
	 xY6kwWYUqZDbxDTO6hbt6iZ6t+uoYyH5xmjMfZGCxF8Ff7Cw0v6l5/JHcMPj+uUfAD
	 6okd5TmO5KtaLtaq1C/aBH/CLgjWvcV/zeXzRvYLsuc2GCmthOxmqDFiUpZA02iKnu
	 QzBJ/hEB+1TElxXCgloCJpNwjZXkxavb2UzEIXNNRbHLgps9V0tC9YrJoUSVKdIrjJ
	 kCsdSyx5cuOzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Dan Aloni <dan.aloni@vastdata.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/16] nfs: propagate readlink errors in nfs_symlink_filler
Date: Sun, 23 Jun 2024 09:44:31 -0400
Message-ID: <20240623134448.809470-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
Content-Transfer-Encoding: 8bit

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 134d0b3f2440cdddd12fc3444c9c0f62331ce6fc ]

There is an inherent race where a symlink file may have been overriden
(by a different client) between lookup and readlink, resulting in a
spurious EIO error returned to userspace. Fix this by propagating back
ESTALE errors such that the vfs will retry the lookup/get_link (similar
to nfs4_file_open) at least once.

Cc: Dan Aloni <dan.aloni@vastdata.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/symlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 0e27a2e4e68b8..13818129d268f 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file *file, struct folio *folio)
 error:
 	folio_set_error(folio);
 	folio_unlock(folio);
-	return -EIO;
+	return error;
 }
 
 static const char *nfs_get_link(struct dentry *dentry,
-- 
2.43.0


