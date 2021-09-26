Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1001418A77
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Sep 2021 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhIZSSA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Sep 2021 14:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhIZSSA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 26 Sep 2021 14:18:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 327CC60FC2;
        Sun, 26 Sep 2021 18:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632680183;
        bh=DD2tHO1AR+SDG2ewvg4buONJUF9lKXD6gkH4OJ0rNIM=;
        h=From:To:Cc:Subject:Date:From;
        b=uJ+P+12oFzR7ao/FCrA1fq0tqpdGwKDxLp3sR8/UApDMOHcQndx3a9R8DeTGev7kt
         HtAfzniwwvtlJBTnMI0RVb0coRZx4lbFx0uT1zinFWBrtKHtd5eY9y+4js5No4rs1F
         dbRxzktHoObWo3ehxC8QCzU4xeGswZ6lcFsSwcSafQvByCrNLm39hssyFD4GI9Zokt
         Es4PllFXDLza0hmjSRWCpFaEOgdUBnrQEookRF2S/DNauqSSnQHor8Fq9fuFVixFfT
         OhWbqWSpp7LCBqHQ9EEUSDVfMcMaEjDi9BVib3smA7DYihGyoYCt1F2mH/sEWHVY5Z
         5qkmxHtbHaLAQ==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Default change_attr_type to NFS4_CHANGE_TYPE_IS_UNDEFINED
Date:   Sun, 26 Sep 2021 14:16:22 -0400
Message-Id: <20210926181622.81474-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Both NFSv3 and NFSv2 generate their change attribute from the ctime
value that was supplied by the server. However the problem is that there
are plenty of servers out there with ctime resolutions of 1ms or worse.
In a modern performance system, this is insufficient when trying to
decide which is the most recent set of attributes when, for instance, a
READ or GETATTR call races with a WRITE or SETATTR.

For this reason, let's revert to labelling the NFSv2/v3 change
attributes as NFS4_CHANGE_TYPE_IS_UNDEFINED. This will ensure we protect
against such races.

Fixes: 7b24dacf0840 ("NFS: Another inode revalidation improvement")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3xdr.c | 2 +-
 fs/nfs/proc.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index e6eca1d7481b..9274c9c5efea 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2227,7 +2227,7 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 
 	/* ignore properties */
 	result->lease_time = 0;
-	result->change_attr_type = NFS4_CHANGE_TYPE_IS_TIME_METADATA;
+	result->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
 	return 0;
 }
 
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index ea19dbf12301..ecc4e717808c 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -91,7 +91,7 @@ nfs_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
 	info->dtpref = fsinfo.tsize;
 	info->maxfilesize = 0x7FFFFFFF;
 	info->lease_time = 0;
-	info->change_attr_type = NFS4_CHANGE_TYPE_IS_TIME_METADATA;
+	info->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
 	return 0;
 }
 
-- 
2.31.1

