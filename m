Return-Path: <linux-nfs+bounces-11446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA9AAA84E
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9611646DB
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159C34BA3C;
	Mon,  5 May 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuZQuM9l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DE34BA37;
	Mon,  5 May 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484782; cv=none; b=J3zoPXGMraE1BLZEhgaOrz9Ojifja46zGSAyPiFjv+QDuLDwNhM0n2ki60asqNTT24SAz2b5QZIq9wHYIqTwLwhH0g2ci1Gq5dJrn5WVlPNVot+/8aYwNa71JgffN6ZHyCgtwnIj/vWaEvCYkyfPIBCeooc1EtWvIQds8kLhnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484782; c=relaxed/simple;
	bh=4IpCerG67ETxEbzv7f0UVSL4XC1oG3Vi/m4enPSd8Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxmwtlJIpojMbQyk8nS1I8yKncsWwIEsOuXVAAkvGmV20K34mRkLN181pOQ/Ff5/LUNPz8DIZMpW0ghn0grojMOnjFssBPT8DxvIPAlVi+WbuZ5/ZmhJ8TC/CugPfT+hpP8/cN7Bh04+ZPznDy1oPD+WkZ45s7VajGo1phsvX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuZQuM9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8E3C4CEE4;
	Mon,  5 May 2025 22:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484781;
	bh=4IpCerG67ETxEbzv7f0UVSL4XC1oG3Vi/m4enPSd8Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FuZQuM9lyQVWWC/NS288NMYVqPjeBc4ntaMTm0f6Q84uMz3azULQDMyE0LzoribjH
	 LJ29wQ4SI9B44U81QyNdQwDSGJFDMW3ATAtnQb9Y4LUsSW0jvAukYUV6jvNpijLWrb
	 OoM7/TJXVPA07PPzCDeCL9Mhl1P77ZV/CpQFsaD2TUdU+kOoeLN+ttsX2LQ+j2rl77
	 0bdx9iM9AVdZkCsJbppmA120kmk8BMKzh4qVLMAkYKrbiVGoKR2NvCw6tbxbqPmSLs
	 KK5wKs1SGDp1Q5ib1VU63+DcbsifDDIHLNy8vGyVz6GOxJ/2FccXq/eJugzQqF4znT
	 tADp3TnPU+rNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 011/486] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
Date: Mon,  5 May 2025 18:31:27 -0400
Message-Id: <20250505223922.2682012-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 325ba0663a6de..8bdbc4dca89ca 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -307,7 +307,8 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
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


