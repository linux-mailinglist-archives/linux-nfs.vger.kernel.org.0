Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCE61822E9
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgCKT4l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:41 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:61723 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgCKT4l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956601; x=1615492601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lkmouOHohvmjzhaAq6LvZSVH/G8CYMX7DCSlHHauoZs=;
  b=aTGnPFl37heAcsxp6gtx1Qj64WKHc7rahrZjt6PIo7UPwzwtjxSA1IbE
   Q/AA9VR5/mvnR/jbspZmO3wO3nMa+9/NSmd0Ra5D5lwqCSlyVr9Q/ioe3
   6PF63ZWBPZhFNBvzTXcxWMNwpx8y/DwdbrvPJlnEJktyh+iHkxicKfEe5
   M=;
IronPort-SDR: z19N5WTUNsxdLV3RxKR7nDrIqf3jplboF2i/3NiZEfjTCF6QeWTcUFAdBPC9luuT6sKWkVQkeq
 uvEAlL+AE6SA==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="21100375"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Mar 2020 19:56:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 6D554C1C31;
        Wed, 11 Mar 2020 19:56:26 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:25 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:24 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 05160DEF46; Wed, 11 Mar 2020 19:56:24 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 08/13] nfs: modify update_changeattr to deal with regular files
Date:   Wed, 11 Mar 2020 19:56:08 +0000
Message-ID: <20200311195613.26108-9-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Until now, change attributes in change_info form were only returned by
directory operations. However, they are also used for the RFC 8276
extended attribute operations, which work on both directories
and regular files.  Modify update_changeattr to deal:

* Rename it to nfs4_update_changeattr and make it non-static.
* Don't always use INO_INVALID_DATA, this isn't needed for a
  directory that only had its extended attributes changed by us.
* Existing callers now always pass in INO_INVALID_DATA.

For the current callers of this function, behavior is unchanged.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs4_fs.h  |  5 ++++
 fs/nfs/nfs4proc.c | 70 ++++++++++++++++++++++++++++++++++---------------------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 8be1ba7c62bb..42c9f237dc61 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -322,6 +322,11 @@ extern int update_open_stateid(struct nfs4_state *state,
 
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
 		struct nfs_fsinfo *fsinfo);
+extern void nfs4_update_changeattr(struct inode *dir,
+				   struct nfs4_change_info *cinfo,
+				   unsigned long timestamp,
+				   unsigned long cache_validity);
+
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
 extern int nfs4_proc_create_session(struct nfs_client *, const struct cred *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index da72237c6933..31d65bbf4a23 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1157,37 +1157,48 @@ nfs4_dec_nlink_locked(struct inode *inode)
 }
 
 static void
-update_changeattr_locked(struct inode *dir, struct nfs4_change_info *cinfo,
+nfs4_update_changeattr_locked(struct inode *inode,
+		struct nfs4_change_info *cinfo,
 		unsigned long timestamp, unsigned long cache_validity)
 {
-	struct nfs_inode *nfsi = NFS_I(dir);
+	struct nfs_inode *nfsi = NFS_I(inode);
 
 	nfsi->cache_validity |= NFS_INO_INVALID_CTIME
 		| NFS_INO_INVALID_MTIME
-		| NFS_INO_INVALID_DATA
 		| cache_validity;
-	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(dir)) {
+
+	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(inode)) {
 		nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo_timestamp = jiffies;
 	} else {
-		nfs_force_lookup_revalidate(dir);
-		if (cinfo->before != inode_peek_iversion_raw(dir))
+		if (S_ISDIR(inode->i_mode)) {
+			nfsi->cache_validity |= NFS_INO_INVALID_DATA;
+			nfs_force_lookup_revalidate(inode);
+		} else {
+			if (!NFS_PROTO(inode)->have_delegation(inode,
+							       FMODE_READ))
+				nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE;
+		}
+
+		if (cinfo->before != inode_peek_iversion_raw(inode))
 			nfsi->cache_validity |= NFS_INO_INVALID_ACCESS |
-				NFS_INO_INVALID_ACL;
+						NFS_INO_INVALID_ACL;
 	}
-	inode_set_iversion_raw(dir, cinfo->after);
+	inode_set_iversion_raw(inode, cinfo->after);
 	nfsi->read_cache_jiffies = timestamp;
 	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
 	nfsi->cache_validity &= ~NFS_INO_INVALID_CHANGE;
-	nfs_fscache_invalidate(dir);
+
+	if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
+		nfs_fscache_invalidate(inode);
 }
 
-static void
-update_changeattr(struct inode *dir, struct nfs4_change_info *cinfo,
+void
+nfs4_update_changeattr(struct inode *dir, struct nfs4_change_info *cinfo,
 		unsigned long timestamp, unsigned long cache_validity)
 {
 	spin_lock(&dir->i_lock);
-	update_changeattr_locked(dir, cinfo, timestamp, cache_validity);
+	nfs4_update_changeattr_locked(dir, cinfo, timestamp, cache_validity);
 	spin_unlock(&dir->i_lock);
 }
 
@@ -2643,8 +2654,9 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 			data->file_created = true;
 		if (data->file_created ||
 		    inode_peek_iversion_raw(dir) != o_res->cinfo.after)
-			update_changeattr(dir, &o_res->cinfo,
-					o_res->f_attr->time_start, 0);
+			nfs4_update_changeattr(dir, &o_res->cinfo,
+					o_res->f_attr->time_start,
+					NFS_INO_INVALID_DATA);
 	}
 	if ((o_res->rflags & NFS4_OPEN_RESULT_LOCKTYPE_POSIX) == 0)
 		server->caps &= ~NFS_CAP_POSIX_LOCK;
@@ -4543,7 +4555,8 @@ _nfs4_proc_remove(struct inode *dir, const struct qstr *name, u32 ftype)
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		update_changeattr_locked(dir, &res.cinfo, timestamp, 0);
+		nfs4_update_changeattr_locked(dir, &res.cinfo, timestamp,
+					      NFS_INO_INVALID_DATA);
 		/* Removing a directory decrements nlink in the parent */
 		if (ftype == NF4DIR && dir->i_nlink > 2)
 			nfs4_dec_nlink_locked(dir);
@@ -4627,8 +4640,9 @@ static int nfs4_proc_unlink_done(struct rpc_task *task, struct inode *dir)
 				    &data->timeout) == -EAGAIN)
 		return 0;
 	if (task->tk_status == 0)
-		update_changeattr(dir, &res->cinfo,
-				res->dir_attr->time_start, 0);
+		nfs4_update_changeattr(dir, &res->cinfo,
+				res->dir_attr->time_start,
+				NFS_INO_INVALID_DATA);
 	return 1;
 }
 
@@ -4672,16 +4686,18 @@ static int nfs4_proc_rename_done(struct rpc_task *task, struct inode *old_dir,
 	if (task->tk_status == 0) {
 		if (new_dir != old_dir) {
 			/* Note: If we moved a directory, nlink will change */
-			update_changeattr(old_dir, &res->old_cinfo,
+			nfs4_update_changeattr(old_dir, &res->old_cinfo,
 					res->old_fattr->time_start,
-					NFS_INO_INVALID_OTHER);
-			update_changeattr(new_dir, &res->new_cinfo,
+					NFS_INO_INVALID_OTHER |
+					    NFS_INO_INVALID_DATA);
+			nfs4_update_changeattr(new_dir, &res->new_cinfo,
 					res->new_fattr->time_start,
-					NFS_INO_INVALID_OTHER);
+					NFS_INO_INVALID_OTHER |
+					    NFS_INO_INVALID_DATA);
 		} else
-			update_changeattr(old_dir, &res->old_cinfo,
+			nfs4_update_changeattr(old_dir, &res->old_cinfo,
 					res->old_fattr->time_start,
-					0);
+					NFS_INO_INVALID_DATA);
 	}
 	return 1;
 }
@@ -4722,7 +4738,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
-		update_changeattr(dir, &res.cinfo, res.fattr->time_start, 0);
+		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
+				       NFS_INO_INVALID_DATA);
 		status = nfs_post_op_update_inode(inode, res.fattr);
 		if (!status)
 			nfs_setsecurity(inode, res.fattr, res.label);
@@ -4800,8 +4817,9 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 				    &data->arg.seq_args, &data->res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		update_changeattr_locked(dir, &data->res.dir_cinfo,
-				data->res.fattr->time_start, 0);
+		nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
+				data->res.fattr->time_start,
+				NFS_INO_INVALID_DATA);
 		/* Creating a directory bumps nlink in the parent */
 		if (data->arg.ftype == NF4DIR)
 			nfs4_inc_nlink_locked(dir);
-- 
2.16.6

