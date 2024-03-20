Return-Path: <linux-nfs+bounces-2425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ADA8818F3
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 22:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCBEB21EDD
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0B85947;
	Wed, 20 Mar 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN/IZcpY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4385653
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969082; cv=none; b=EZe7ycyJM46E2dMs0xjuSmEiMMO2J+Ja/r4rWDPJvIEIeWOwHagKJoxFDEEBBnZ43cyM3/Vn0pyIqMiMNL13madSRBFuo/jyKGlhPo1HxMfJZu9kootrRSnDnKdl7Akb508o3pGX8kDxeVAh2JyjucJgzQ5muiBWx6NA8F/fLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969082; c=relaxed/simple;
	bh=xWxj2l0iw0+w4rp8YS4jPLSt/FcKpJ6uJyO+GYBDEps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJowXuShwnQ/lWUFdjszLoCWOQhhdZ7jCbG9noNvcE7Hnja5nlugbZRJTzSVJz6dAu46ScJ9d07WrZIR0oCs+xlV6u6f3jF6uLePZ8B91CE87YX6s2q6yXdZNiZDBMI2IaaomGUP1w4LHCpRzq9gwLvMxOEiKczOLX4rA50c8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN/IZcpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23919C43394;
	Wed, 20 Mar 2024 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710969082;
	bh=xWxj2l0iw0+w4rp8YS4jPLSt/FcKpJ6uJyO+GYBDEps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iN/IZcpYSFCtYVpuZcEwP4jhcN1AzzkuQCCtY3zrrImxrNMpPcAdUAmfNo1y4k5kE
	 rMgmO3fWKcPlRKl6SHkhj0qi+mn4xYwNh8su529Fqlzs9ukxU9hNZBXK0WELW24pnY
	 BhWFFWdOTzFtqzon4L0Zk7er150BkSGWL0RTioCzIjDbpdyRCOEnGmSUBCFKKpow+E
	 NR0/DfBewzbR2cj8JqWqcUBgyiPRGMx5bFg7v/nMY3ASc4tgzXfi47hPq+SXsd3OtW
	 fsEMUS1RxAD91XPGRWgviV2JlBiMVt0XbUfDy+wjzXE2BH52udsUMZPvhsQwiztgWa
	 mnk265yGXS6wA==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 1/2] pNFS/filelayout: Remove the whole file layout requirement
Date: Wed, 20 Mar 2024 17:11:19 -0400
Message-ID: <20240320211120.228954-2-anna@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320211120.228954-1-anna@kernel.org>
References: <20240320211120.228954-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Layout segments have been supported in pNFS for years, so remove the
requirement that the server always sends whole file layouts.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/filelayout/filelayout.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index ce8f8934bca5..3fb18b16a5b4 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -605,14 +605,6 @@ filelayout_check_layout(struct pnfs_layout_hdr *lo,
 
 	dprintk("--> %s\n", __func__);
 
-	/* FIXME: remove this check when layout segment support is added */
-	if (lgr->range.offset != 0 ||
-	    lgr->range.length != NFS4_MAX_UINT64) {
-		dprintk("%s Only whole file layouts supported. Use MDS i/o\n",
-			__func__);
-		goto out;
-	}
-
 	if (fl->pattern_offset > lgr->range.offset) {
 		dprintk("%s pattern_offset %lld too large\n",
 				__func__, fl->pattern_offset);
-- 
2.44.0


