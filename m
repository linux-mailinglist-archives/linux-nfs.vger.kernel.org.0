Return-Path: <linux-nfs+bounces-4236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EA6913AE4
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FFF1F21956
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1B181BA2;
	Sun, 23 Jun 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUfOWeom"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E5181B9C;
	Sun, 23 Jun 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150250; cv=none; b=es+pK1Yp933mNl5VWArqyMcLq/J/GSPgzhAVPoGPdH3536q1yqTAxOw1cfrJbnJipe8qLXxoDEWT+RLDW4HT83NmbNwPfxQbAte3R7tl1h45yXxs4q9O+yXgTwQfwycUz0p7nzpv2XtG3/GevJefqSLCS4sQzjgQQlfKiq+rD68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150250; c=relaxed/simple;
	bh=EOP0IlNb/sPC/uwzDn2qLCQ8nM+BrFL0qAZeV9k+cko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeKocPuQ2/hGV82wpxJqPiteGlS89+JJ5gqTKn1H6b9BbRmZbpVcSlsN1oAbdaYWYe0byIPWxYKGr9SdVsVh0Frm6y791e/Ra6LsIvUQhjwRTdTsjARLk0OasqwmgEk6iIpL7+OV+u1BDaty6ghUZAi9D7JzMvN4mASRqVX5Y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUfOWeom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A847BC4AF0A;
	Sun, 23 Jun 2024 13:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150249;
	bh=EOP0IlNb/sPC/uwzDn2qLCQ8nM+BrFL0qAZeV9k+cko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUfOWeomk5/NfKCVwbPn2mqcdpmzOCg51rd3iD85z2NOTRe1gpfLf301+0MPikBw8
	 HoXx3zfwgPbyAKfROpRlQ2w5KBBEkxCEwMS+0W+nrbYZuuXZBHNR8slJ88BXAejZwa
	 azBFPg+sqhONmkhW3rFNTF6kr5xmqDgfh05Z7exMev43ufdx6/A6KqSB8tB4zRNh0X
	 UsAO0CJypWHMjx/7bOGmOqDNirHU1sMVB0Uv8SbcLZ70ZCDfnAtVrrGZHGq50mRzOk
	 /5X8TqM/dtrMpr7qbW2Hrxri0WVSU1Wuo9b65tB76eBWD0p8CQoldCpysLZbvZGCLY
	 Qgg2GRAN24hDw==
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
Subject: [PATCH AUTOSEL 6.9 02/21] nfs: propagate readlink errors in nfs_symlink_filler
Date: Sun, 23 Jun 2024 09:43:35 -0400
Message-ID: <20240623134405.809025-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
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


