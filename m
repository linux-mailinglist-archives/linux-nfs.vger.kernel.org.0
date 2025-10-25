Return-Path: <linux-nfs+bounces-15627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093EC094E7
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Oct 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0080F1898F59
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Oct 2025 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3D3064B8;
	Sat, 25 Oct 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyUcnZNc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07264303CB4;
	Sat, 25 Oct 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408856; cv=none; b=jIIdcDyNEbJKKQrMSTszkSn/u2jDkrpNcm3rNA4FkEp5qrtQ9M5OglIo69CUguRFcSYaN2CUqMf/5SOBxmLABGrvD6oXD2FkC+UyNgWXipux4btRGQJR7yUFxpBm1lpQvS8fr4kT2s9yxjLHvfKCEU5dErbURgDGBS47s3ajYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408856; c=relaxed/simple;
	bh=kLmRAElkRwYw/pJGMsqaBVHCR/RytNuBvo5W5c1nDJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCUmSjQFHc8TWvyDZeQRcVhER0pF3zDqT0TggMv5zSDjhXmaz0upz+cr4JJwEC+M2Ae5s6vzM3VDV65mWzdyjRos1BRQiXR/w5lbLp9AOdUiZVLoOQu1yoL/FPdG2x/Nh3Dl8C0fOcYP55MpUoLt0z4tEJthDffZJB3073oyoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyUcnZNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE14AC4CEF5;
	Sat, 25 Oct 2025 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408855;
	bh=kLmRAElkRwYw/pJGMsqaBVHCR/RytNuBvo5W5c1nDJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyUcnZNcK4bqHh+vXZ5VnYaewrQgbnWJxY9Ec1b79SX63RvwauQ+iKYSgXb548TJc
	 MwpEbroRZo0On9jpxihKWBFhWVpwb6a5d13TwZnJcRmnlvCXIbfj4vyrLyGemlCOdX
	 HGlkIa3PyYGKzuanySXzT1geSdDL0q2Fd8Eb3GHQ7suYc8m4oq7e89NDa6HgmlYtyk
	 baiUFrs/p/i+DAMG3RcdCqebVfZSoJukGGyc1pIX4iJMjvigCIDjhfGAbskwYs6rRx
	 fKfGovnYLw+++If0Gt3djSQlxUUu+A9ac5PK4kPe99XU2b6N+FhiQgcJNexTbeRN1i
	 8jnM/1ns5d0tA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing
Date: Sat, 25 Oct 2025 11:55:33 -0400
Message-ID: <20251025160905.3857885-102-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit a890a2e339b929dbd843328f9a92a1625404fe63 ]

Theoretically it's an oopsable race, but I don't believe one can manage
to hit it on real hardware; might become doable on a KVM, but it still
won't be easy to attack.

Anyway, it's easy to deal with - since xdr_encode_hyper() is just a call of
put_unaligned_be64(), we can put that under ->d_lock and be done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- The race is in `fs/nfs/nfs4proc.c:395`, where
  `NFS_FILEID(d_inode(dentry->d_parent))` relied on `d_parent` staying
  stable while another thread might be executing `__d_move`/rename and
  mutating that field under `dentry->d_lock`. Without taking that lock
  we can observe a transient or freed `d_parent`, leading to an oops
  while synthesising the “..” entry during readdir.
- The fix simply wraps the dereference in `spin_lock(&dentry->d_lock)` /
  `spin_unlock(&dentry->d_lock)` (`fs/nfs/nfs4proc.c:394-396`), matching
  dcache locking rules so we never race with rename/unhash. The critical
  section only covers `xdr_encode_hyper` (a `put_unaligned_be64`), so
  there is virtually no new latency or deadlock risk.
- No behavioural changes beyond closing this bug: the rest of
  `nfs4_setup_readdir()` is untouched, there are no dependency patches
  required, and this aligns with the long-standing expectation that
  anyone walking `d_parent` holds the dentry lock.
- Because the bug can crash clients performing `readdir()` while
  directories are being renamed/unlinked—even if the window is
  narrow—this is a correctness fix with minimal risk and well within the
  stable backport guidelines.

 fs/nfs/nfs4proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4de3e4bd724b7..b76da06864e53 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -391,7 +391,9 @@ static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dent
 	*p++ = htonl(attrs);                           /* bitmap */
 	*p++ = htonl(12);             /* attribute buffer length */
 	*p++ = htonl(NF4DIR);
+	spin_lock(&dentry->d_lock);
 	p = xdr_encode_hyper(p, NFS_FILEID(d_inode(dentry->d_parent)));
+	spin_unlock(&dentry->d_lock);
 
 	readdir->pgbase = (char *)p - (char *)start;
 	readdir->count -= readdir->pgbase;
-- 
2.51.0


