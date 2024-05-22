Return-Path: <linux-nfs+bounces-3346-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E78CC8F5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2024 00:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111E62817F5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A71811E0;
	Wed, 22 May 2024 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTVRsmX9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19F7EF0C
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416361; cv=none; b=hsYs2DreojYJCMAozq5OFQJYEeLRvdiufplvAIYCWAfkxalPvftI1774RhAPj5HBRhtPPeocU0mnXmLUrzXVCSVUVKfH2KRlMMg0MipTcFQnezVrF2rJbIicIxg9s0S3JeAU+GD8eMgio2FieFJt31iqIjRvV3bPqWyG17AtaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416361; c=relaxed/simple;
	bh=bPrfsJgJCoSDDmHu6YtGdm8J4XVulVyUzcd02lnrDvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8m9MuQNINl/qGCDiP96FDWP7D7c5anxLqnAI7qYENN4kXfcCHEqZF3iwqztj0a8GXDWz94uAtl49ZAg7CyqB1e7/eykQYHDkGC8e6DusaoUpmgru2VNb2VDFzuQlLXj7SLhjqilHvLID/Q4NZHmqOpWNiomd626T3Iy8NqlagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTVRsmX9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716416358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5zpPnXo01Dv9bzCOALzQrACjBZMOCaDc18rYhkXfD0=;
	b=VTVRsmX919infP1QdUlzGOlsgr83m/g9Nl+QtaX7VD2yDSkQyoPiB4fprhFGG7uvyQpC5m
	L69JtWsLhdCKHfl51Ufs3rSUzNaA7HAo9UDGXzQ/Ba7VwUGcN7O+vgRdnDLTj2Bgyd+8OP
	x/cKOmyAThyZW3AEm6U3kMXeF/VCDj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-xLAL9ZBCMh6hEh55HtiQow-1; Wed, 22 May 2024 18:19:17 -0400
X-MC-Unique: xLAL9ZBCMh6hEh55HtiQow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9541800042;
	Wed, 22 May 2024 22:19:16 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.33.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4E7100046D;
	Wed, 22 May 2024 22:19:16 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 147BE14C3A7;
	Wed, 22 May 2024 18:19:16 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna.schumaker@netapp.com
Cc: neilb@suse.de,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: don't invalidate dentries on transient errors
Date: Wed, 22 May 2024 18:19:16 -0400
Message-ID: <20240522221916.447239-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This is a slight variation on a patch previously proposed by Neil Brown
that never got merged.

Prior to commit 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()"),
any error from nfs_lookup_verify_inode() other than -ESTALE would result
in nfs_lookup_revalidate() returning that error (-ESTALE is mapped to
zero).

Since that commit, all errors result in nfs_lookup_revalidate()
returning zero, resulting in dentries being invalidated where they
previously were not (particularly in the case of -ERESTARTSYS).

Fix it by passing the actual error code to nfs_lookup_revalidate_done(),
and leaving the decision on whether to  map the error code to zero or
one to nfs_lookup_revalidate_done().

A simple reproducer is to run the following python code in a
subdirectory of an NFS mount (not in the root of the NFS mount):

---8<---
import os
import multiprocessing
import time

if __name__=="__main__":
    multiprocessing.set_start_method("spawn")

    count = 0
    while True:
        try:
            os.getcwd()
            pool = multiprocessing.Pool(10)
            pool.close()
            pool.terminate()
            count += 1
        except Exception as e:
            print(f"Failed after {count} iterations")
            print(e)
            break
---8<---

Prior to commit 5ceb9d7fdaaf, the above code would run indefinitely.
After commit 5ceb9d7fdaaf, it fails almost immediately with -ENOENT.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/dir.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ac505671efbd..d9264ed4ac52 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1635,6 +1635,14 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 		if (inode && IS_ROOT(dentry))
 			error = 1;
 		break;
+	case -ESTALE:
+	case -ENOENT:
+		error = 0;
+		break;
+	case -ETIMEDOUT:
+		if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
+			error = 1;
+		break;
 	}
 	trace_nfs_lookup_revalidate_exit(dir, dentry, 0, error);
 	return error;
@@ -1680,18 +1688,8 @@ static int nfs_lookup_revalidate_dentry(struct inode *dir,
 
 	dir_verifier = nfs_save_change_attribute(dir);
 	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
-	if (ret < 0) {
-		switch (ret) {
-		case -ESTALE:
-		case -ENOENT:
-			ret = 0;
-			break;
-		case -ETIMEDOUT:
-			if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
-				ret = 1;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	/* Request help from readdirplus */
 	nfs_lookup_advise_force_readdirplus(dir, flags);
@@ -1735,7 +1733,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 			 unsigned int flags)
 {
 	struct inode *inode;
-	int error;
+	int error = 0;
 
 	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
 	inode = d_inode(dentry);
@@ -1780,7 +1778,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 out_bad:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_done(dir, dentry, inode, 0);
+	return nfs_lookup_revalidate_done(dir, dentry, inode, error);
 }
 
 static int
-- 
2.44.0


