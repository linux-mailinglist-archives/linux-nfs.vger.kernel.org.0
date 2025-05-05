Return-Path: <linux-nfs+bounces-11439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2FAA9EFC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 00:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93F95A1DD3
	for <lists+linux-nfs@lfdr.de>; Mon,  5 May 2025 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2AC27BF60;
	Mon,  5 May 2025 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2Vmsuhp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3B27B518;
	Mon,  5 May 2025 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483280; cv=none; b=hlXkDHXOTG9XoJo2gPG2JDCuTzcR/CE76DTnbVBVTaY2mc0h3N97TWXUZAa+CPeFtywQQOg5Uc+hUNNSF+IZ34PiLvZzrBOKVjkqGqbU1YQ8b/ON3xPI/eh2GPlMco4Guk/Hv5w2905QAXh6oTsvrNUdjBnGNDp8oq1BBxeDFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483280; c=relaxed/simple;
	bh=4IpCerG67ETxEbzv7f0UVSL4XC1oG3Vi/m4enPSd8Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQboiDZXpCApQ/f1yCi1ExeNA1cimwroZ1rsGHfQsSH2FEG3wLVX3JOQbrfl02VfouwaeylKFuvE9gV3Fa8P/5chud4iqJy8e/S+dx/Nw5DXCkjr634K3Vi6ps7LFsxCGRTXlbuDZMhO8MR2FYF6JWJYRJT57owHn5/mAW2BCHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2Vmsuhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E4DC4CEED;
	Mon,  5 May 2025 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483279;
	bh=4IpCerG67ETxEbzv7f0UVSL4XC1oG3Vi/m4enPSd8Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2VmsuhpU49vRAsUalUGAMDDHlwQpx7/J4VImWy6ikCAeWPSHmcSqlTJBav4pznT/
	 R1CbR+LpthoMyCXGU1XT5bdbA1n9k1AZFKdca1qgAHBJDi5CilIzwb0x1qixd9PFHJ
	 J2HIxUx1PXjyNeCi9eGDLXUlZhK00j4mreTVSeB703q80wk//S/I2ch/tuFnjyI2eI
	 0J+O8prGTrXroHHeRINTJnywmaxrUmRH07UV2dQ5vspxHj/oNUWBaxg1YU/ZCm9x0N
	 ikzkEiKY+6IRzUKoe74wNdZEur5cmq0TwnbU6RA70Wf+ROESE/IhTLZbmLmf7zZDH/
	 +Z7ITlQLSEqnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 012/642] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
Date: Mon,  5 May 2025 18:03:48 -0400
Message-Id: <20250505221419.2672473-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


