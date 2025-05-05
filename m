Return-Path: <linux-nfs+bounces-11459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C2AAAB82
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 03:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FB77A4299
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 01:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE93B3BA3;
	Mon,  5 May 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdnG6UWx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19755288C13;
	Mon,  5 May 2025 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486398; cv=none; b=OqsiVOGv6i7yM0oBaRDpsW5f/QOyas9FMFgUzOJELXR1PFXG+dZ5ctjDJodTMXuTzDT9JqvLrxPhzDNDNHyj0AMd2gSebLEAB5ThGhiLuWtcneZuzfp+wq4OYWLI1BUVwbwZvpqRU0VIltwYfNh9+9qTyHePZPErlQxmLrY7tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486398; c=relaxed/simple;
	bh=cEbV+W4/SnH81T8+5LTt+QQukQcNS5q/Md9/WewlFw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTKDJB5WtJqTMP+KiwKPkgsUz12Pv7qzKr8A6rGUpxIzBjQpMtQKcfdugLTVC4TADitxljsHNJ4ACSBzYC4kT6rk3KGvF8HA7yrMsiE9kV+ZZH+XLQT/g/Lpyqs51o3rN3ZJq35AH5fdlqnHuaIQFr5MRmIxMfJXjPufF/W+HkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdnG6UWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D248C4CEED;
	Mon,  5 May 2025 23:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486397;
	bh=cEbV+W4/SnH81T8+5LTt+QQukQcNS5q/Md9/WewlFw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdnG6UWxIQ86HgMch963KRMbrs6xFl4M423NjCtP1HgY/AA2POeql2P6MlEKsv9dX
	 q8YOXtUZqOfMCZlva17FjzpLhF5MbyIdMSmesT1AmNB723OZx4AmkQ2k6fTgvJiWR9
	 xiST1QFwW80HqUeZr/5ZQEaiBeJOMsCmiGf5oZfmDZdhKoj2jaPoFLNd9+ChoLCWiH
	 UlNA2367+SDv0/Am9p4+94+/THExYAdD5saIsoRawWMP/LJZkBSnlipV1bUHkP4V2L
	 VV0kK3LV4dAMOyr255E8h2pmlVTjscj0k4olUtXTC/m8oaDQC5NpSIuMuM7/jwfnYz
	 SwXtLFHUgSfUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 007/212] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
Date: Mon,  5 May 2025 19:02:59 -0400
Message-Id: <20250505230624.2692522-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 9e8f324bd44c1fe026b582b75213de4eccfa1163 ]

Check that the delegation is still attached after taking the spin lock
in nfs_start_delegation_return_locked().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/delegation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6363bbc37f425..17b38da17288b 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -297,7 +297,8 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 	if (delegation == NULL)
 		goto out;
 	spin_lock(&delegation->lock);
-	if (!test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+	if (delegation->inode &&
+	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
 		/* Refcount matched in nfs_end_delegation_return() */
 		ret = nfs_get_delegation(delegation);
-- 
2.39.5


