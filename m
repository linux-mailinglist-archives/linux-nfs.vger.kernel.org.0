Return-Path: <linux-nfs+bounces-2520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D2890551
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 17:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C0B1C2F93B
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Mar 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A85E3BBE9;
	Thu, 28 Mar 2024 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE00o9yb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7E3A1BA
	for <linux-nfs@vger.kernel.org>; Thu, 28 Mar 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643698; cv=none; b=CfUq2krDL1HdjbY7RK5oyk8tg6oWlBgeak/hpS/vUaX3oZ2vh+7orALO2kYpBGAZXk4x/4yfK8zLqpjRey/XxO1BZQfIADAZ7cirHKqyo1f//+o9/BIiq3PAf7vWO7U84HGv/UWaEWjGCqikabvF8jaX+QYFV2R5hCBOrnCr65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643698; c=relaxed/simple;
	bh=jdfIqeGx7iuHgqcMFhxtu5WAhVw5xPnhsJo7b6P/XKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7udPM3DuQtmFtkHAAkB97mj6H/eoXN6fwgbhy6TBbDG7W6E1A2sB7sv4XYKsC44h9FQnmLOCVwiN0qinNYT45dXsWMFEHLQlbmKfqk9sAv7CMqWpSMLyDMyW3iztCs93X2nPNoU1eBFAldYrJvvpil6TsYKw5DFQWOsJ3SHlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE00o9yb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDfAk4YAlKNdLmSwUMxTH3zTc83Y1JZRxoVOBJSESsg=;
	b=PE00o9yb8iBNPTDCj2qHWWcFEz+wCXdU8JxzlFqVXb5uZFaLPxHLdXNd1/wdl+TrZry91B
	ymN8BNghkxGZeOl0g9WjoBMnz4I3eaqnQl/U4N2j63GbQrUkDIqql25WVb5j/V+BeYbyPx
	qoQ++HqgzZQVfqHLfHDsSvP9NiEakhA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-HdMk_3MKM8CSF0IznLHt6w-1; Thu,
 28 Mar 2024 12:34:53 -0400
X-MC-Unique: HdMk_3MKM8CSF0IznLHt6w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1060F3C0BE45;
	Thu, 28 Mar 2024 16:34:51 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA9EB492BC6;
	Thu, 28 Mar 2024 16:34:47 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 02/26] 9p: Clean up some kdoc and unused var warnings.
Date: Thu, 28 Mar 2024 16:33:54 +0000
Message-ID: <20240328163424.2781320-3-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Remove the kdoc for the removed 'req' member of the 9p_conn struct.

Remove a pair of set-but-not-used v9ses variables.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
---
 fs/9p/vfs_inode_dotl.c | 4 ----
 net/9p/trans_fd.c      | 1 -
 2 files changed, 5 deletions(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..7af27ba1c25d 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -297,7 +297,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			       umode_t omode)
 {
 	int err;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	kgid_t gid;
 	const unsigned char *name;
@@ -307,7 +306,6 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	p9_debug(P9_DEBUG_VFS, "name %pd\n", dentry);
-	v9ses = v9fs_inode2v9ses(dir);
 
 	omode |= S_IFDIR;
 	if (dir->i_mode & S_ISGID)
@@ -739,7 +737,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	kgid_t gid;
 	const unsigned char *name;
 	umode_t mode;
-	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL, *dfid = NULL;
 	struct inode *inode;
 	struct p9_qid qid;
@@ -749,7 +746,6 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 		 dir->i_ino, dentry, omode,
 		 MAJOR(rdev), MINOR(rdev));
 
-	v9ses = v9fs_inode2v9ses(dir);
 	dfid = v9fs_parent_fid(dentry);
 	if (IS_ERR(dfid)) {
 		err = PTR_ERR(dfid);
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 1a3948b8c493..196060dc6138 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -95,7 +95,6 @@ struct p9_poll_wait {
  * @unsent_req_list: accounting for requests that haven't been sent
  * @rreq: read request
  * @wreq: write request
- * @req: current request being processed (if any)
  * @tmp_buf: temporary buffer to read in header
  * @rc: temporary fcall for reading current frame
  * @wpos: write position for current frame


