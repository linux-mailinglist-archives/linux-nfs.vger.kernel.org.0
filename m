Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48220675E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387926AbgFWWoR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:17 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:57647 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387927AbgFWWoN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952253; x=1624488253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=skMcASTWrdo0Edf4ZLGzYnxzxLaN9tOOUKR5g2P/cCk=;
  b=PjZ9yIVkcPEv1xFYlKukVJALuxMQUzZg6ncxVkT+JqQneSOzNA0k7kzf
   3UqQQu+NEEMGTBYGs/8Kjp3EOE51Hv7k93865F39bZ+OB/FIwaXMtNS3q
   Mjlfp75xBVGVqbuOjcnyj1DifOY1QxQp9iv6wYp15a54tHp6GE1EJJBos
   k=;
IronPort-SDR: cTvc6eXPYGeBCEfveeXrGaKBK8GhbAwofkr7a/Nu4k7WDn5uQQAspIvPsBAV1ZGpRwapYf5/R3
 qXO4t0k+jVdA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="46390755"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id B67DEA28BB;
        Tue, 23 Jun 2020 22:39:05 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:04 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id CC1A8CD362; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 08/13] nfs: modify update_changeattr to deal with regular files
Date:   Tue, 23 Jun 2020 22:38:59 +0000
Message-ID: <20200623223904.31643-9-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
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
index 526b3e70d57c..c16ec860b8b3 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -324,6 +324,11 @@ extern int update_open_stateid(struct nfs4_state *state,
 
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
index c88351f8b18d..6540071cb228 100644
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
@@ -4531,7 +4543,8 @@ _nfs4_proc_remove(struct inode *dir, const struct qstr *name, u32 ftype)
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		update_changeattr_locked(dir, &res.cinfo, timestamp, 0);
+		nfs4_update_changeattr_locked(dir, &res.cinfo, timestamp,
+					      NFS_INO_INVALID_DATA);
 		/* Removing a directory decrements nlink in the parent */
 		if (ftype == NF4DIR && dir->i_nlink > 2)
 			nfs4_dec_nlink_locked(dir);
@@ -4615,8 +4628,9 @@ static int nfs4_proc_unlink_done(struct rpc_task *task, struct inode *dir)
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
 
@@ -4660,16 +4674,18 @@ static int nfs4_proc_rename_done(struct rpc_task *task, struct inode *old_dir,
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
@@ -4710,7 +4726,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
-		update_changeattr(dir, &res.cinfo, res.fattr->time_start, 0);
+		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
+				       NFS_INO_INVALID_DATA);
 		status = nfs_post_op_update_inode(inode, res.fattr);
 		if (!status)
 			nfs_setsecurity(inode, res.fattr, res.label);
@@ -4788,8 +4805,9 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
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

