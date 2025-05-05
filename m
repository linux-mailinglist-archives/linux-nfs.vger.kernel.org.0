Return-Path: <linux-nfs+bounces-11476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF5AAB574
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 07:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005A846689F
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE55534826D;
	Tue,  6 May 2025 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZZV1W93"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250B3AA166;
	Mon,  5 May 2025 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487104; cv=none; b=sgYYQBgWph3kCBZRoj5V/sVizVkJPhq54h7GNJrwLVBkdJTe/rDaVKm6iv9qCyOXeXw/JMg5GyjLkbBGIAPbcSrDMVMy/uBr3O0EN5W8AdtqBqp23unmBK2+tI4yS5Ec1bjs0B+0M4f203+GAq0hy55fIcOQP3T0mtDwpVOPl64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487104; c=relaxed/simple;
	bh=JXQr+KMgwa7FAF4DacubuYflAo0Uq4YrcI4bW2ObYdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VuOyVv9XfNyMkNb/AnlhSVHXWN0O3xs1IHv9eUuUNFH0keuh7miVHUhqQFV+wQKGn46gMorR5QwKi85zxPNCS6FUaV0kc4pi3P97gIAKqjQZH2kLV10KW6pxUdKfa35i3d20SIxg4oc6TYoO01VhQ2CROy2/krFQbQyCKaW1apQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZZV1W93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55056C4CEEE;
	Mon,  5 May 2025 23:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487103;
	bh=JXQr+KMgwa7FAF4DacubuYflAo0Uq4YrcI4bW2ObYdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZZV1W93KsfQz5zJ/4Tm+uEx9TzvCFAK3vUt0P8mgxQH4SqmVPEwlq/i0awT161YJ
	 7ESFg9LZDphTd878hfudjaciYRs9oaPhxVKmphi/Xc58a4DrJqXzSOlwW/9db2IbPb
	 zTWk5jXzrmN7bP1rUaJM9hu63w5AsUqXSTe63EI+zdRUAC87pMNBCBPZULXB5b/xEl
	 raCnbmIzT9/MBb/q3YOGAZ6avorS7v+fW9Lofvv5bKhZnajnc5LJI6MmvxFPEqdzp5
	 TH1MZjUMLRi6xlW7y7N4chagq2WmZMj9u0oP+Q4rNBH7KTa5QTP7ZPdVKpwdSA1wwE
	 ugne6GQKAGVPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 002/114] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
Date: Mon,  5 May 2025 19:16:25 -0400
Message-Id: <20250505231817.2697367-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index dbed8d44d8053..f3bb987e9dba7 100644
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


