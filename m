Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C100719343C
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCYXK5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:10:57 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53577 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCYXK5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177856; x=1616713856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dK/NmnaNo/jW5zcuurQSoU2gliZvcbx25b0/h38BNiA=;
  b=HmmKGhdHcgDlKf90yTYUL32EgUcX5qGfa/X00iCQRmqXwzwU8BHsOSXO
   JXTSidC9ipoH5W8JY7yyTF+h29EKs2W4xbkpJoOPFM2RPY7XyCuqTFi2B
   eVi/x69ouuHo4cNC9DO5efUbkCNFXhKFz/Z/4hRz5LBvww8obqdaNjqD/
   I=;
IronPort-SDR: Z9HUwDFtYJI+Hxoay69IqKA2cPtniPNK6vkpo5h9CHyCYeXrNZwiiwg0G0Bup04NhAd/xaCp6B
 Jcy/eQSVNUfg==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="33468198"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Mar 2020 23:10:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 88C8FA239C;
        Wed, 25 Mar 2020 23:10:54 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:53 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:52 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1236.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 630A1D92C6; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 08/13] nfs: modify update_changeattr to deal with regular files
Date:   Wed, 25 Mar 2020 23:10:46 +0000
Message-ID: <20200325231051.31652-9-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
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
 fs/nfs/nfs4proc.c | 70 +++++++++++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 0b2a14e1e268..f82c3e884662 100644
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
index 9207f945d75c..0bb2241028f0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1158,37 +1158,48 @@ nfs4_dec_nlink_locked(struct inode *inode)
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
 
@@ -2644,8 +2655,9 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
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
@@ -4534,7 +4546,8 @@ _nfs4_proc_remove(struct inode *dir, const struct qstr *name, u32 ftype)
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		update_changeattr_locked(dir, &res.cinfo, timestamp, 0);
+		nfs4_update_changeattr_locked(dir, &res.cinfo, timestamp,
+					      NFS_INO_INVALID_DATA);
 		/* Removing a directory decrements nlink in the parent */
 		if (ftype == NF4DIR && dir->i_nlink > 2)
 			nfs4_dec_nlink_locked(dir);
@@ -4618,8 +4631,9 @@ static int nfs4_proc_unlink_done(struct rpc_task *task, struct inode *dir)
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
 
@@ -4663,16 +4677,18 @@ static int nfs4_proc_rename_done(struct rpc_task *task, struct inode *old_dir,
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
@@ -4713,7 +4729,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
-		update_changeattr(dir, &res.cinfo, res.fattr->time_start, 0);
+		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
+				       NFS_INO_INVALID_DATA);
 		status = nfs_post_op_update_inode(inode, res.fattr);
 		if (!status)
 			nfs_setsecurity(inode, res.fattr, res.label);
@@ -4791,8 +4808,9 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
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
2.17.2

