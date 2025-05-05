Return-Path: <linux-nfs+bounces-11466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B6AAB6A6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 07:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87EA1C21BFC
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 05:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F3C42F853;
	Tue,  6 May 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlS2O6xn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED936BA47;
	Mon,  5 May 2025 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485810; cv=none; b=Zge+PqP6nRHna2yeJjwQLirzyFWr4kTxdDowMWLpvOrBqz4XMgUPdzilZ0vDXmej39AGPONH6IFYfoS/O76UDwJa/6Sj9hQG02PkZbF1gCivxuu04ht7i6BtFbLoLT05FdjVkTHrAIpQQcNCQYIO/BGaBbYyBhNEYYYZ2fnSNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485810; c=relaxed/simple;
	bh=HzdditQjkwur0Bv5K9IZW5bJPDXO6F1EM/S7XQ66tCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JeBAiPW0+zr7kiOGn7onjoSlbEZ3zMoE/RwbqDGR6XR9+jZDnwg6pq04szhCUj6V+DZQThXlNWzpUBBA3asSZ2oiH0O4+TG6kELMuQldthA+VpqcYBkD7tKPx0feWnGGtcC+vr19RTFceGAc/F1eR3UyB1ROpFKtGIBG2WaP5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlS2O6xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240E9C4CEEE;
	Mon,  5 May 2025 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485808;
	bh=HzdditQjkwur0Bv5K9IZW5bJPDXO6F1EM/S7XQ66tCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hlS2O6xnAhBlxjO+fVeWgat903Iaa8peiPWGyGLFIRx84A57RXJeRDHf9yECq7ZXF
	 LrXpMGy2s05WocbmiJeqpXFNuDXqV87qkTbdaTBx5MUXhHjyZJhFyCWfEI7/FqhiTn
	 gAe5xMd0kfBrl4B8V9dXmm0UXlw3LZCJn3OtEjufgYI3toq+Vp89oOviN9XSzzoqqH
	 3CuIRwFyBrrpx3Q4A4PMdwm7QuYEwPGiqhYWMjIxph0L9cGBOCABMNPO7SoJn76MJf
	 4gZngtYASNFoysoH3jCf6vzrgtOuTpeFdpikwFGxnhHHmW7OKu36fShwQ94I1Ho8EO
	 Z11jjTDQuXg8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 008/294] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
Date: Mon,  5 May 2025 18:51:48 -0400
Message-Id: <20250505225634.2688578-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 55cfa1c4e0a65..bbd582d8a7dc9 100644
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


