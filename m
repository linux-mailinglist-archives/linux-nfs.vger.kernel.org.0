Return-Path: <linux-nfs+bounces-15733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37581C17018
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D441C3572D8
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3C42C3274;
	Tue, 28 Oct 2025 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sou3T0MM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532E27FD44
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686867; cv=none; b=Y1S5tgRQEajZkyCzbPNv/hXsKdJkLANn/R1mWyxUyIGVpiyfhZGh9URwfPzClkIwhKKZWY1WaQ5Ikm7awz0CAHzmkDJM7FTBvj2ffHj6/5Nd6A37UU2ZZNx+crzSao1RyfroKsI+f7bARRTGdPCTqfTNZhltuawtlsA0flRNh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686867; c=relaxed/simple;
	bh=NpIpXLql3o6cX59Xa9E6onlOz/3OTTwGpdQ1sAV3kGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwboD6XRX+hhQtzwFYQOKIxJIApPgpZ2No8YPW3zIU/gmmEkep90UouPZ1JpSlBemb0lMsumPaRCyDoyalUSTxZonmC6z/VG9isE0I2Vx0085B5m1DNe/8DWTqXw2jPI30dnkB61+S8OlTv/DARGErZStj6Fl4MlNnM5w46sRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sou3T0MM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D53C4CEFF;
	Tue, 28 Oct 2025 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761686866;
	bh=NpIpXLql3o6cX59Xa9E6onlOz/3OTTwGpdQ1sAV3kGE=;
	h=From:To:Cc:Subject:Date:From;
	b=sou3T0MMRtpIkPOjs7RYm8Su19MRt1VXIe0NYlN9R3IkECOcsU75Xrf0ew7JpN29b
	 ru7iV//SvrnrKGfWWXCgSRyznVs8XEv8t6NmQLxGu6Q3nyANLZq1yqbDD0xIR8uOTL
	 qqEGLZSg9/tT21jC9yLGiPFOc9sFoJFi73HauxsWYpI1MV3WayEe+U9bBZaNjU6b4z
	 xhe5VlRIRi8dpEvZTm3K9fotSCAYQsYeyGa1na2eaeN9PBR1jsGCJBOSP8zha6hpl+
	 aaIV17LQL/4kLUyZxsdaQtvJo5LhGbyp1SFa1qfpOkG/wiaWN08nMNNb4SKfGtCgEi
	 6dMYvcvzNn4IQ==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Stephen Abbene <sabbene87@gmail.com>,
	NeilBrown <neilb@ownmail.net>
Subject: [PATCH v2 1/2] NFSv2/v3: Fix error handling in nfs_atomic_open_v23()
Date: Tue, 28 Oct 2025 17:27:43 -0400
Message-ID: <03e3a5a82187cfc7936b87ce92ee001b27e18878.1761686833.git.trond.myklebust@hammerspace.com>
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
resolved. If that's the case, a lookup needs to be kicked off.

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


