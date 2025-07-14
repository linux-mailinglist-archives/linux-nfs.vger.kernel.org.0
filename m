Return-Path: <linux-nfs+bounces-13012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608DB034D4
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 05:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E927A1B7B
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 03:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD181E00A0;
	Mon, 14 Jul 2025 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBYuUswf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6C2E3713
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462842; cv=none; b=p8stk7S5lB9pwd/LfwOSXXZLkAMSk8jO3HY0P6dlk8+5/ASV3JopmUPqTHybR4qTuYSdnnWOnnRqfsBuHZyaRKiEgguciN3d+sS/s1W6B25KQpZ2a8KmgfurnY8xWDfdlTOLueESy236Yx7s4LmLtRhJ/l9O6itPjC11beVG2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462842; c=relaxed/simple;
	bh=YfXkXz/J9sRLMHWX2eD6D/8I+YKgULUXTzFSTc2V3c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqIUKrDN+bt4by7bphadmANwg6lSoZwQHkr5Pi0+hkgXdlSEqfeLCMU3z0NGbqAGs/t7u+MBUJJsctWWmAekjhuPeoLaMvKLyifT/7DEP/Ant88RIZzAqrmdzaR3XtKHc46TtorsKnOtPZ15BEA6bRDzJbxOs12CRvV1SPRR980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBYuUswf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23BBC4CEF1;
	Mon, 14 Jul 2025 03:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752462842;
	bh=YfXkXz/J9sRLMHWX2eD6D/8I+YKgULUXTzFSTc2V3c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBYuUswfk5bUyhtBcmys4o/zGOhoxNnDA9apy8EvITYmJRHwna69FfJcVoz/xSY3p
	 kqXdzWlDqaL4F4FQUaeM6gLyHxCenuT0tG15qz1qJ3BuDvCMsh1Jl2l/8i6QO5h1MD
	 Ov6WyIjDi1HAFYv+r2H88pTqCHkU8TC29g2Wkvm56AyoV/NRY4ZQPLOWAqgaeUmjaJ
	 NaYGj1pwhOx4DQMqSgNul5ZCsNyU6M1sK1XXNOUxdpe0OPUCn9PHNRQuA+qIHTAUvE
	 dkGQmlkbNAHCQ4hB+HizMkWbwuZeb71B2BpTQNxZoiGuWQ7xqN4tyiavD1TCpAmrCj
	 JDtQEkwTortgA==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org
Subject: [for-6.16-final PATCH 1/9] Revert "NFSD: Clean up kdoc for nfsd_open_local_fh()"
Date: Sun, 13 Jul 2025 23:13:51 -0400
Message-ID: <20250714031359.10192-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250714031359.10192-1-snitzer@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit cae55a0ab53b2f7c92633a85f1c448746c4ae689.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/localio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 4f6468eb2adf..80d9ff6608a7 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -32,7 +32,7 @@
  * @rpc_clnt: rpc_clnt that the client established
  * @cred: cred that the client established
  * @nfs_fh: filehandle to lookup
- * @pnf: place to find the nfsd_file, or store it if it was non-NULL
+ * @nfp: place to find the nfsd_file, or store it if it was non-NULL
  * @fmode: fmode_t to use for open
  *
  * This function maps a local fh to a path on a local filesystem.
-- 
2.44.0


