Return-Path: <linux-nfs+bounces-4239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8345F913B24
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26C5B21816
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8FA1822C1;
	Sun, 23 Jun 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVv4EzZ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1926181CF2;
	Sun, 23 Jun 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150291; cv=none; b=UYi8PLL3loVI1TkSudeseImTOXfNZvud8H4BUbZJCsRgAN0OnPYWGqQ5tGBTEG8zQAY598mRbEpMJypzpd69v+J4axCzC/X2mNpy9IqQMX5Hr/C+ZmWqTEBygVE+Xz4iM0VUB9m4K5d1GrD2Ch7kBjFq1qr76NG5NRrQ/ZDGCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150291; c=relaxed/simple;
	bh=5XKhNOxh2hgc99lxRWJbgPZBH8yheI69UKNwcOC84m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/f19iOu01m1GTwc+gT8L6MfbEDv2YIny4KdvDFADw4z3LxK9bxlLDPUrc1V9gchouU6n3q+Mm/Gg8BE8VwqX0TuY1SOabOMrb/u0yZEudNGBwT7N1wNrpTSlcJ5KrhmyeTDOFJ4MxVfeRTW6yEsW7mFdStFI9NkHJKvKDGHvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVv4EzZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E66BC2BD10;
	Sun, 23 Jun 2024 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150291;
	bh=5XKhNOxh2hgc99lxRWJbgPZBH8yheI69UKNwcOC84m8=;
	h=From:To:Cc:Subject:Date:From;
	b=sVv4EzZ1I32LPII2pJkEYPQBjL0/tyt4sQ754FKMzMS2Lwdcv7K39vL/Xt/C8rJRj
	 gzTV4XxrqmUMPyKKxZEFEL7byJFPXLU2L4IIO2w6V5xz/N4e5vzjq1p/NnM+qHanl9
	 2XDZgGxdBoXfeCMP1ANUdCSKw5oVlB0x8bZS2u/nGKZxzzTn7SDt9wTeyrZ07qO9sC
	 yijiGuo+1ZKbpDQt3Tpvw39nbMCLrOjTTpD7KE2p2DLGC+MQAws1giXMlKqnXJA6eD
	 0yeU5NLOaRltiH3wrUomW+PRy2L1L4oEN1ZtzIgmWsin2idyjLFxRdFEy5IseVU3nA
	 DVspPm9oI1zSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Mastykin <mastichi@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/16] NFSv4: Fix memory leak in nfs4_set_security_label
Date: Sun, 23 Jun 2024 09:44:30 -0400
Message-ID: <20240623134448.809470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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
index f0953200acd08..05490d4784f1a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6268,6 +6268,7 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 	if (status == 0)
 		nfs_setsecurity(inode, fattr);
 
+	nfs_free_fattr(fattr);
 	return status;
 }
 #endif	/* CONFIG_NFS_V4_SECURITY_LABEL */
-- 
2.43.0


