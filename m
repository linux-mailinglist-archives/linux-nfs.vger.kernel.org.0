Return-Path: <linux-nfs+bounces-16876-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11FCA0A81
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Dec 2025 18:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0CD34F13D9
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Dec 2025 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4706330D23;
	Wed,  3 Dec 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3c9XABD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D0330B3E;
	Wed,  3 Dec 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777141; cv=none; b=eWxM6GKYQfZzAVYnqBmz0qDhY8Hc4S2l8SYeJzegILUNCh83Q3+Lyr9/k8Mu48bybWttd51I+MTiFGt0U9O5/e+CeH7VHgy551ptjG07GfyBkqTR0TkNvNHtT3/YCb8fpMPkNv4dAFng+H5aIBkw9G0V9KatzygmkQKvah7sMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777141; c=relaxed/simple;
	bh=pkwmZeXWd97XcHgqH5JzMbaLm2KzN9UnExHYzpplR4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMrxz7OFfbDT5io5jiJBxkNatI0UVI+MuO36I/4otmj5y3eoeQzj+qmHj2pI0XTOCZJCFr2XdrfNB6I+/HsquNhv17I6vpDF9/X9JI3yNsjAGHAEVWzepj1Ac9PjhMJkFQoen0xQ5HP87CI+SJh93+P9i4S4ZI8yveyDR91JVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3c9XABD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0751C4CEF5;
	Wed,  3 Dec 2025 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764777141;
	bh=pkwmZeXWd97XcHgqH5JzMbaLm2KzN9UnExHYzpplR4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O3c9XABDVAtcQgYWun/miqolUVkTF+aLBzrOEYpmAHx53BLDSFTLXriTcIIYi1eRm
	 ssF3ajrgoBJVtCkVR04EUTQCyZWtdxX5jkYQPkgplnc74xt3IfuYvU92X7zM6YQE7t
	 69K716JQyhZzG4dFe78rYXhZCmNavgnQUImLlMyoPvu7J8BELnDu8+n8ZL059oExUU
	 mvU/F1zd7YSmCInS2RACodeBUc1SjkGlFwW19M9544FuF9Nji4EG20NAdWdNkTl1YD
	 vk7LqpjacXq48c08l41tcoweJ6v+NJ9W89SR1i9ded2tc2VrRmdjGNqj4cK3QK1nqY
	 57E8zUZx7foAw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 03 Dec 2025 10:52:16 -0500
Subject: [PATCH 2/2] nfsd: prefix notification in
 nfsd4_finalize_deleg_timestamps() with "nfsd: "
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-nfsd-7-0-v1-2-653271980d7e@kernel.org>
References: <20251203-nfsd-7-0-v1-0-653271980d7e@kernel.org>
In-Reply-To: <20251203-nfsd-7-0-v1-0-653271980d7e@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pkwmZeXWd97XcHgqH5JzMbaLm2KzN9UnExHYzpplR4I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMFyykqfag9qxWIxrPQOQcBSGfIlJAl1VD4SJi
 9MWUSJhwLSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTBcsgAKCRAADmhBGVaC
 FQpmEACv/CJZ2b0y2chxYVcdiszzu1XiiyCGKTTHW3QJOEyfSVLKBIAgvCPzbewXhHMZfl5eb3A
 wJqgdQxAHFvKA3wMMC7SgoCg5Jepz2E1rL6ZB9PrLURZ4nduRxdja5hSO+lnAg5qZ57lIFyqp5x
 XgY5eANEgJMrpQN3fuW6+xQICoHWregQDa0THkxP+qaR7Tjo765PUtpG9mrmYu1gmRgZzNUbqEt
 DvppE9eROsZTRlAGgV6D2453Z2j8wW9oBGBwfDkFMr0axm1ZznNwUv0GGU2LLOui3tdJb4PqXun
 hOZpz3h/hh9qWVzuRx/eA6iQHMzQCdE3ggfSclI9lzw0NPUaXy4kYB/BkPG3UBeS4YJp6mmCHTj
 Rmx5ysnqcFdAhpCA4kRgY6z+0wIoG16t+zQlhOi1oDlx8WIP36X1AsVCLx+ba99qu2dgNLqJpUE
 tfy4hzqImxgZGLezT1McCRcjyHAgeqIed1hPNt9YMLgBXEqMsm+89h18LsCWUJnLBzKsjeVx6d1
 VIvqWJA2FrVQVG4Hv0TV7nSbN2OxURe5dDFxqMPn6k1mTBDU9rO/1uhj86LyM9WM20ZgHx+lwHo
 wvlM3Y3ZE0713r99rWKqiHGZ50LaKxZXFl7rAkPSnIaVNNTBTDCk1jdHI0A8NraP5FMYHL8u7sK
 BDTr3RnrOlgft1w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Make it distinct that this message comes from nfsd.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b0111104e969057486a4b878fffb84b84ca97b7b..22246a1d970c3a1fcf1d821e20edd2ca7b1ed488 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1253,7 +1253,7 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 	if (ret) {
 		struct inode *inode = file_inode(f);
 
-		pr_notice_ratelimited("Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
+		pr_notice_ratelimited("nfsd: Unable to update timestamps on inode %02x:%02x:%lu: %d\n",
 					MAJOR(inode->i_sb->s_dev),
 					MINOR(inode->i_sb->s_dev),
 					inode->i_ino, ret);

-- 
2.52.0


