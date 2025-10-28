Return-Path: <linux-nfs+bounces-15731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C37C16E3D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82A11A68763
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E065D2D0625;
	Tue, 28 Oct 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTnSRVQf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CC1DDC1B
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686003; cv=none; b=YtI6lNi5iiYjjHc6Zc8TbZ6LWbzHm6fV7Pfbt63RS/0c39pk+t9Z7MpC8N25v1CQZkclc+q+QrrRFli0OeAawnuB3afKcDGELAKLPqp3Nj8TLjok6PPts2tzm7ANAXCGBS5VGU8bm+Lwus+pw874IbRYyCbZlwwF9lGjefUcwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686003; c=relaxed/simple;
	bh=4j5oqG4gxnp7QUdijCPJYUCQ6AZ4iTzapGVU5DUGuts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtgkSZyxqQ8k86TGUpkxqJY/kXAUA0KX2hUK7Lifz0flEPwGEPa/YXuor0d6poqCjXFU0ITxx5fEryRkNw7bS3ffftkeYs4zaRhHHTeIF06d4Hd9Y+EUX0Z2PnNoKrMgYWTb/m8Z2HNLVj6VLegNeBkjzZHn9f7IdFUszIcbr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTnSRVQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EAEC4CEE7;
	Tue, 28 Oct 2025 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761686003;
	bh=4j5oqG4gxnp7QUdijCPJYUCQ6AZ4iTzapGVU5DUGuts=;
	h=From:To:Cc:Subject:Date:From;
	b=hTnSRVQfgMj3k/keqnjabmNiai6goUv/fYyodJtXXwM0m/QiHjY3/NZMba9xLGUd2
	 CYtU4QxDK2h08WAGZWA5EBmPQbpKVdLDszCpqGhjqucQgARLSSreSHj1Wm9+sW4Bx5
	 AVEn4RR1K04KGeW6LSSsmh2pUZqqmGrMYFBIKV29JcWD8OWpSROm2EvdMb7ea2SzLM
	 +lfIijNkLB6+rP9jw7SLHlg5+yVMfq4BWtk2F3pkm5Ck9t/Kc0RlOsRY7nFs4U8g1J
	 qbIXAoAltP1ulaM5xcEX8UtUAQyN6SjExbv20+2XH0r4DlARug9tYv8pMo5dYXlLnm
	 Xj387J00fPAqA==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Stephen Abbene <sabbene87@gmail.com>,
	NeilBrown <neilb@ownmail.net>
Subject: [PATCH 1/2] NFSv2/v3: Fix error handling in nfs_atomic_open_v23()
Date: Tue, 28 Oct 2025 17:13:20 -0400
Message-ID: <a523a1f55710c2b55b86e2c6c4dfcf147677b7ec.1761685801.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When nfs_do_create() returns an EEXIST error, it means that a regular
file could not be created. That could mean that a symlink needs to be
resolved. If that's the case, another lookup needs to be kicked off.

In addition, the error handling needs to look at the result of the
lookup, and return an appropriate error if the wrong type of object was
found.

Reported-by: Stephen Abbene <sabbene87@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220710
Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 46d9c65d50f8..ea9f6ca8f30f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2268,11 +2268,12 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 		return -ENAMETOOLONG;
 
 	if (open_flags & O_CREAT) {
-		file->f_mode |= FMODE_CREATED;
 		error = nfs_do_create(dir, dentry, mode, open_flags);
-		if (error)
+		if (!error) {
+			file->f_mode |= FMODE_CREATED;
+			return finish_open(file, dentry, NULL);
+		} else if (error != -EEXIST || open_flags & O_EXCL)
 			return error;
-		return finish_open(file, dentry, NULL);
 	}
 	if (d_in_lookup(dentry)) {
 		/* The only flags nfs_lookup considers are
-- 
2.51.0


