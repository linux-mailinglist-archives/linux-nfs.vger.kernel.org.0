Return-Path: <linux-nfs+bounces-11460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E69AAAC37
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 04:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81534C3E03
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790F3C4D86;
	Mon,  5 May 2025 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de9LjfhH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9022F155B;
	Mon,  5 May 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486807; cv=none; b=eheYe4r66KIaO0A0mD5kA9ZJNME3OSbNsF4n8TXwi/sz2H/uxahRlaN/lbV9DaeOuzJQ9MxC3OJU9qDsK7q7l/nVgSpLGHpiqq+sfEH8kvBOR3d0O/Ni3XZGcVJwFlwCldNMCsu5T5m1+ZbEhjI1ZJhmfLW+a7c+agt/Hw+Fu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486807; c=relaxed/simple;
	bh=m5D/x+U7KO4cviVfbv6ibJQJZAFAun8YRhdyaraSydk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHb9c7etXAu9tiwfb4tkzk/zZ1oeC+TFTiIJf1SYRqkgEryks1dgEqCAsD2uC6AWyOi4jLZHSqEwhIbU14T3xo/OjnCmfUe40yhu9JsrY5myHrIeme5wECRPrNN6OgOF/9jIDSF5584XEs0NEaV0sfpr4vO83MjqhoviO/AzwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de9LjfhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56D5C4CEF1;
	Mon,  5 May 2025 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486806;
	bh=m5D/x+U7KO4cviVfbv6ibJQJZAFAun8YRhdyaraSydk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=de9LjfhH3eGFjb+DhZ/cBquCnCU4wLLNvOaIsukMKqud0jvjJSF71r4aOb9ExdeIN
	 EElYfOjgGHo5taaHbWS3QSpulITO+LT5fJZLby1PK5ftBI+tOETjHtZrTSZovxm1jn
	 I0EiCruZeXiIN8nBycDVlL6pAua5E5rmZjUq0pGh95K1jjWC5qiMEgdhkZcD46ttdR
	 7k11swKOdC9i7zieMUycYo73owwKpI7P0jppEvnc0dQtKPked5RTxHYWiCUhG3mwY+
	 0yrsT4bu7n9pTSaEAuK3J+TWdIHdjNvn1tkOsQmWNBrn0sYw/1dZBgEpt7p3koUHe7
	 ppFUjrfshzEJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 002/153] NFSv4: Check for delegation validity in nfs_start_delegation_return_locked()
Date: Mon,  5 May 2025 19:10:49 -0400
Message-Id: <20250505231320.2695319-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 0c14ff09cfbe3..45ef1b6f868bf 100644
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


