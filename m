Return-Path: <linux-nfs+bounces-16787-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998D0C937D5
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 05:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11673A9E8A
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD31A22D4E9;
	Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMx5VBxO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4A229B2A
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389195; cv=none; b=btL7Xb2lNi6AJGm+dnH/148IVcBiV40uGQ3GxhbItBma8JiZJ+vBhNpLoYduOWVOp9p8pzAqHSp6/Z2QOxCa5Do5eJaoHNeEGyNSjFttNFq9vr9DMpM7y08siKXPzFq8E7hUxRf+CxC8lIHyBxYJyNJzhmYZkDkBwX5y/B9GwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389195; c=relaxed/simple;
	bh=ZDeSQnIQmhNkBE5xV5nLBQmtpJJmgl7+kzbAAOnLDhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra1boV1+v+/sQ+cc2NZLPOQ5I7a1wjdTuQyhJvTcNfPNZp1QjpKnDoD4plmXP6DTJqhd/qSAMCeXHStGfoN/95c7h54LnSl22yeveCgieGUXNAzp664hdrzGi2HFQY8nd23TxAh3UJDA8DcnJr4AVTAwgTWbw6K5DULSQKwugFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMx5VBxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA0FC4CEF7;
	Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389195;
	bh=ZDeSQnIQmhNkBE5xV5nLBQmtpJJmgl7+kzbAAOnLDhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMx5VBxOX5/seRmcFdAPvdkFlBAqF8R74gMZZ3+Vd1VHEEy87G1Mj30t/eYVvJWC3
	 YhKZSLXFF+2NLR8QW0FBXB6nrL0X+LEDVJAsFjlPMIgh9U2E+7UftTCeCh05xbGiN7
	 By4BKTn4CZvvxAwOoK1PFsByrbff1EXpJIRpp3GUBw42dwT3tFNfJN2xXm9pCv7xSG
	 703ZQatuBPZvJ1879wFgSv0kiuzJkooSNqJ0eSoP1YDleVjMSjx5pjGYEM0TEXJYb2
	 VadzIkmJLC9mVSLYDEgB/6d9WDPAOMpWv9kCg6yi9NOBZnR4k1bbkhmIjtjgRLCoIl
	 MN8ArFjCdYdtw==
From: Trond Myklebust <trondmy@kernel.org>
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/6] Revert "nfs: ignore SB_RDONLY when mounting nfs"
Date: Fri, 28 Nov 2025 23:06:29 -0500
Message-ID: <bf48674cbd70599dcb161efdd2274b8119a6397d.1764388528.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764388528.git.trond.myklebust@hammerspace.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com> <cover.1764388528.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This reverts commit 52cb7f8f177878b4f22397b9c4d2c8f743766be3.

Silently ignoring the "ro" and "rw" mount options causes user confusion,
and is a regression.

Reported-by: Alkis Georgopoulos<alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>
Fixes: 52cb7f8f1778 ("nfs: ignore SB_RDONLY when mounting nfs")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2ecd38e1d17a..ffd382aa31ac 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -13,7 +13,7 @@
 #include <linux/nfslocalio.h>
 #include <linux/wait_bit.h>
 
-#define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
+#define NFS_SB_MASK (SB_RDONLY|SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
 
 extern const struct export_operations nfs_export_ops;
 
-- 
2.52.0


