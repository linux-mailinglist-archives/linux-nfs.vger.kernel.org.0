Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCB1737FA
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 14:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgB1NJm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Feb 2020 08:09:42 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34610 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1NJm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Feb 2020 08:09:42 -0500
Received: by mail-yw1-f65.google.com with SMTP id b186so3236965ywc.1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Feb 2020 05:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sGnPE/JUP7OhzF7gIyYz62C2odtn3cxa6PMyuttqqhI=;
        b=jNLS1dWwz/ulkL/qiRcJHrx/EjpqII6ZNt+/NHTs7Dih4MyWdwCFN8fYDMX71B8C4c
         ccrVP4CT6nUZD7IyYBshOJhhfDCStevWlCZAhzJJcLitPnzYP8OiYYUMwEr1fp4vU1F7
         mRccXYTcPv8hLgTkSm++wgpy84MFB03Ugml36cujbcngKWcZs3Xm5syX58tbB7oBYnG7
         qljtbmbAK0/Np3HZ0QBpeomZk+Dl7Ra0aj0yXHYSCnbl2GnP3fqV6GrIlK4PdK3v6gHG
         P6d2R9Ev/yYDFdgTj/OqUfauedUq8u+b05nCy9iPPxRI/vuO+vbuwNH1nY+Vx7BsyiN3
         4dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGnPE/JUP7OhzF7gIyYz62C2odtn3cxa6PMyuttqqhI=;
        b=n6OtVY6dZDkOc3DxW+BV2p76GDu9nl1iiCQun9Pum4MuiePjTXRsXIpTd8mPgTVqD2
         1Lgy4rDrClVc+Ti85JpScHyNBkcCPOOs4JEuO8uGE55tO/2Fnna1D8a48FTGbUPJE508
         vVUnD6ehYPGcnwFq+rOK6CjNiceutzcrlVJOTjWW/5vDfv3KNKFer2UXPMfknqOmQiEK
         ivLRjDeit3eJX/ZDPw+CM7CnA6GhGq5l99D8hD3qeT8L1w7NEsUVd2KOX5kWpkZ2Nr77
         RYAb/Kup9EEzjkB88uLo3NROrCr2e7UlJX/+ByWaHMIcuYA2arHr1/Ym3q0YzuBuiRlH
         GeWw==
X-Gm-Message-State: APjAAAVzVcjximGuyv+crrx4fFNa/gfCuzDUdgC25b0/2+xXpLE3sDar
        vPgFlRjzN7M3Fupfyhb5wIcPNwbf2Q==
X-Google-Smtp-Source: APXvYqxPhAGMa2pok2XxOaVZLcvgTUAvFo2NVwG8h1TIfF9j1vBZwWGJvyCbqdCGVO3FemjyKxnztA==
X-Received: by 2002:a81:5e09:: with SMTP id s9mr4514215ywb.348.1582895380689;
        Fri, 28 Feb 2020 05:09:40 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id j23sm3925150ywb.93.2020.02.28.05.09.39
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:09:39 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/7] NFSv4: Add support for CB_RECALL_ANY for flexfiles layouts
Date:   Fri, 28 Feb 2020 08:07:25 -0500
Message-Id: <20200228130725.1330705-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228130725.1330705-6-trond.myklebust@hammerspace.com>
References: <20200228130725.1330705-1-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-2-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-3-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-4-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-5-trond.myklebust@hammerspace.com>
 <20200228130725.1330705-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we receive a CB_RECALL_ANY that asks us to return flexfiles
layouts, we iterate through all the layouts and look at whether or
not there are active open file descriptors that might need them
for I/O. If there are no such descriptors, we return the layouts.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback.h      |   4 +-
 fs/nfs/callback_proc.c |  13 ++++
 fs/nfs/nfs4_fs.h       |   4 +-
 fs/nfs/nfs4state.c     |  24 ++++++-
 fs/nfs/nfs4trace.h     |   8 ++-
 fs/nfs/pnfs.c          | 148 +++++++++++++++++++++++++++++++++++++----
 fs/nfs/pnfs.h          |   3 +
 7 files changed, 186 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/callback.h b/fs/nfs/callback.h
index 549350259840..6a2033131c06 100644
--- a/fs/nfs/callback.h
+++ b/fs/nfs/callback.h
@@ -127,7 +127,9 @@ extern __be32 nfs4_callback_sequence(void *argp, void *resp,
 #define RCA4_TYPE_MASK_OBJ_LAYOUT_MAX  9
 #define RCA4_TYPE_MASK_OTHER_LAYOUT_MIN 12
 #define RCA4_TYPE_MASK_OTHER_LAYOUT_MAX 15
-#define RCA4_TYPE_MASK_ALL 0xf31f
+#define PNFS_FF_RCA4_TYPE_MASK_READ 16
+#define PNFS_FF_RCA4_TYPE_MASK_RW 17
+#define RCA4_TYPE_MASK_ALL 0x3f31f
 
 struct cb_recallanyargs {
 	uint32_t	craa_objs_to_keep;
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 97084804a953..e61dbc9b86ae 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -597,6 +597,7 @@ __be32 nfs4_callback_recallany(void *argp, void *resp,
 	struct cb_recallanyargs *args = argp;
 	__be32 status;
 	fmode_t flags = 0;
+	bool schedule_manager = false;
 
 	status = cpu_to_be32(NFS4ERR_OP_NOT_IN_SESSION);
 	if (!cps->clp) /* set in cb_sequence */
@@ -619,6 +620,18 @@ __be32 nfs4_callback_recallany(void *argp, void *resp,
 
 	if (args->craa_type_mask & BIT(RCA4_TYPE_MASK_FILE_LAYOUT))
 		pnfs_recall_all_layouts(cps->clp);
+
+	if (args->craa_type_mask & BIT(PNFS_FF_RCA4_TYPE_MASK_READ)) {
+		set_bit(NFS4CLNT_RECALL_ANY_LAYOUT_READ, &cps->clp->cl_state);
+		schedule_manager = true;
+	}
+	if (args->craa_type_mask & BIT(PNFS_FF_RCA4_TYPE_MASK_RW)) {
+		set_bit(NFS4CLNT_RECALL_ANY_LAYOUT_RW, &cps->clp->cl_state);
+		schedule_manager = true;
+	}
+	if (schedule_manager)
+		nfs4_schedule_state_manager(cps->clp);
+
 out:
 	dprintk("%s: exit with status = %d\n", __func__, ntohl(status));
 	return status;
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 8be1ba7c62bb..2b7f6dcd2eb8 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -42,7 +42,9 @@ enum nfs4_client_state {
 	NFS4CLNT_LEASE_MOVED,
 	NFS4CLNT_DELEGATION_EXPIRED,
 	NFS4CLNT_RUN_MANAGER,
-	NFS4CLNT_DELEGRETURN_RUNNING,
+	NFS4CLNT_RECALL_RUNNING,
+	NFS4CLNT_RECALL_ANY_LAYOUT_READ,
+	NFS4CLNT_RECALL_ANY_LAYOUT_RW,
 };
 
 #define NFS4_RENEW_TIMEOUT		0x01
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index f7723d221945..ac93715c05a4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2524,6 +2524,21 @@ static int nfs4_bind_conn_to_session(struct nfs_client *clp)
 	}
 	return 0;
 }
+
+static void nfs4_layoutreturn_any_run(struct nfs_client *clp)
+{
+	int iomode = 0;
+
+	if (test_and_clear_bit(NFS4CLNT_RECALL_ANY_LAYOUT_READ, &clp->cl_state))
+		iomode += IOMODE_READ;
+	if (test_and_clear_bit(NFS4CLNT_RECALL_ANY_LAYOUT_RW, &clp->cl_state))
+		iomode += IOMODE_RW;
+	/* Note: IOMODE_READ + IOMODE_RW == IOMODE_ANY */
+	if (iomode) {
+		pnfs_layout_return_unused_byclid(clp, iomode);
+		set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
+	}
+}
 #else /* CONFIG_NFS_V4_1 */
 static int nfs4_reset_session(struct nfs_client *clp) { return 0; }
 
@@ -2531,6 +2546,10 @@ static int nfs4_bind_conn_to_session(struct nfs_client *clp)
 {
 	return 0;
 }
+
+static void nfs4_layoutreturn_any_run(struct nfs_client *clp)
+{
+}
 #endif /* CONFIG_NFS_V4_1 */
 
 static void nfs4_state_manager(struct nfs_client *clp)
@@ -2635,12 +2654,13 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		nfs4_end_drain_session(clp);
 		nfs4_clear_state_manager_bit(clp);
 
-		if (!test_and_set_bit(NFS4CLNT_DELEGRETURN_RUNNING, &clp->cl_state)) {
+		if (!test_and_set_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state)) {
 			if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
 				nfs_client_return_marked_delegations(clp);
 				set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 			}
-			clear_bit(NFS4CLNT_DELEGRETURN_RUNNING, &clp->cl_state);
+			nfs4_layoutreturn_any_run(clp);
+			clear_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state);
 		}
 
 		/* Did we race with an attempt to give us more work? */
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 1e97e5e04cb4..543541173a3d 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -584,7 +584,9 @@ TRACE_DEFINE_ENUM(NFS4CLNT_MOVED);
 TRACE_DEFINE_ENUM(NFS4CLNT_LEASE_MOVED);
 TRACE_DEFINE_ENUM(NFS4CLNT_DELEGATION_EXPIRED);
 TRACE_DEFINE_ENUM(NFS4CLNT_RUN_MANAGER);
-TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN_RUNNING);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECALL_RUNNING);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECALL_ANY_LAYOUT_READ);
+TRACE_DEFINE_ENUM(NFS4CLNT_RECALL_ANY_LAYOUT_RW);
 
 #define show_nfs4_clp_state(state) \
 	__print_flags(state, "|", \
@@ -605,7 +607,9 @@ TRACE_DEFINE_ENUM(NFS4CLNT_DELEGRETURN_RUNNING);
 		{ NFS4CLNT_LEASE_MOVED,		"LEASE_MOVED" }, \
 		{ NFS4CLNT_DELEGATION_EXPIRED,	"DELEGATION_EXPIRED" }, \
 		{ NFS4CLNT_RUN_MANAGER,		"RUN_MANAGER" }, \
-		{ NFS4CLNT_DELEGRETURN_RUNNING,	"DELEGRETURN_RUNNING" })
+		{ NFS4CLNT_RECALL_RUNNING,	"RECALL_RUNNING" }, \
+		{ NFS4CLNT_RECALL_ANY_LAYOUT_READ, "RECALL_ANY_LAYOUT_READ" }, \
+		{ NFS4CLNT_RECALL_ANY_LAYOUT_RW, "RECALL_ANY_LAYOUT_RW" })
 
 TRACE_EVENT(nfs4_state_mgr,
 		TP_PROTO(
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 268e7b9ff54e..6b25117fca5f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -309,6 +309,16 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 	}
 }
 
+static struct inode *
+pnfs_grab_inode_layout_hdr(struct pnfs_layout_hdr *lo)
+{
+	struct inode *inode = igrab(lo->plh_inode);
+	if (inode)
+		return inode;
+	set_bit(NFS_LAYOUT_INODE_FREEING, &lo->plh_flags);
+	return NULL;
+}
+
 static void
 pnfs_set_plh_return_info(struct pnfs_layout_hdr *lo, enum pnfs_iomode iomode,
 			 u32 seq)
@@ -782,7 +792,7 @@ pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 		/* If the sb is being destroyed, just bail */
 		if (!nfs_sb_active(server->super))
 			break;
-		inode = igrab(lo->plh_inode);
+		inode = pnfs_grab_inode_layout_hdr(lo);
 		if (inode != NULL) {
 			if (test_and_clear_bit(NFS_LAYOUT_HASHED, &lo->plh_flags))
 				list_del_rcu(&lo->plh_layouts);
@@ -795,7 +805,6 @@ pnfs_layout_bulk_destroy_byserver_locked(struct nfs_client *clp,
 		} else {
 			rcu_read_unlock();
 			spin_unlock(&clp->cl_lock);
-			set_bit(NFS_LAYOUT_INODE_FREEING, &lo->plh_flags);
 		}
 		nfs_sb_deactive(server->super);
 		spin_lock(&clp->cl_lock);
@@ -2434,29 +2443,26 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 	return -ENOENT;
 }
 
-void pnfs_error_mark_layout_for_return(struct inode *inode,
-				       struct pnfs_layout_segment *lseg)
+static void
+pnfs_mark_layout_for_return(struct inode *inode,
+			    const struct pnfs_layout_range *range)
 {
-	struct pnfs_layout_hdr *lo = NFS_I(inode)->layout;
-	struct pnfs_layout_range range = {
-		.iomode = lseg->pls_range.iomode,
-		.offset = 0,
-		.length = NFS4_MAX_UINT64,
-	};
+	struct pnfs_layout_hdr *lo;
 	bool return_now = false;
 
 	spin_lock(&inode->i_lock);
+	lo = NFS_I(inode)->layout;
 	if (!pnfs_layout_is_valid(lo)) {
 		spin_unlock(&inode->i_lock);
 		return;
 	}
-	pnfs_set_plh_return_info(lo, range.iomode, 0);
+	pnfs_set_plh_return_info(lo, range->iomode, 0);
 	/*
 	 * mark all matching lsegs so that we are sure to have no live
 	 * segments at hand when sending layoutreturn. See pnfs_put_lseg()
 	 * for how it works.
 	 */
-	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, &range, 0) != -EBUSY) {
+	if (pnfs_mark_matching_lsegs_return(lo, &lo->plh_return_segs, range, 0) != -EBUSY) {
 		nfs4_stateid stateid;
 		enum pnfs_iomode iomode;
 
@@ -2469,8 +2475,126 @@ void pnfs_error_mark_layout_for_return(struct inode *inode,
 		nfs_commit_inode(inode, 0);
 	}
 }
+
+void pnfs_error_mark_layout_for_return(struct inode *inode,
+				       struct pnfs_layout_segment *lseg)
+{
+	struct pnfs_layout_range range = {
+		.iomode = lseg->pls_range.iomode,
+		.offset = 0,
+		.length = NFS4_MAX_UINT64,
+	};
+
+	pnfs_mark_layout_for_return(inode, &range);
+}
 EXPORT_SYMBOL_GPL(pnfs_error_mark_layout_for_return);
 
+static bool
+pnfs_layout_can_be_returned(struct pnfs_layout_hdr *lo)
+{
+	return pnfs_layout_is_valid(lo) &&
+		!test_bit(NFS_LAYOUT_INODE_FREEING, &lo->plh_flags) &&
+		!test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
+}
+
+static struct pnfs_layout_segment *
+pnfs_find_first_lseg(struct pnfs_layout_hdr *lo,
+		     const struct pnfs_layout_range *range,
+		     enum pnfs_iomode iomode)
+{
+	struct pnfs_layout_segment *lseg;
+
+	list_for_each_entry(lseg, &lo->plh_segs, pls_list) {
+		if (!test_bit(NFS_LSEG_VALID, &lseg->pls_flags))
+			continue;
+		if (test_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags))
+			continue;
+		if (lseg->pls_range.iomode != iomode && iomode != IOMODE_ANY)
+			continue;
+		if (pnfs_lseg_range_intersecting(&lseg->pls_range, range))
+			return lseg;
+	}
+	return NULL;
+}
+
+/* Find open file states whose mode matches that of the range */
+static bool
+pnfs_should_return_unused_layout(struct pnfs_layout_hdr *lo,
+				 const struct pnfs_layout_range *range)
+{
+	struct list_head *head;
+	struct nfs_open_context *ctx;
+	fmode_t mode = 0;
+
+	if (!pnfs_layout_can_be_returned(lo) ||
+	    !pnfs_find_first_lseg(lo, range, range->iomode))
+		return false;
+
+	head = &NFS_I(lo->plh_inode)->open_files;
+	list_for_each_entry_rcu(ctx, head, list) {
+		if (ctx->state)
+			mode |= ctx->state->state & (FMODE_READ|FMODE_WRITE);
+	}
+
+	switch (range->iomode) {
+	default:
+		break;
+	case IOMODE_READ:
+		mode &= ~FMODE_WRITE;
+		break;
+	case IOMODE_RW:
+		if (pnfs_find_first_lseg(lo, range, IOMODE_READ))
+			mode &= ~FMODE_READ;
+	}
+	return mode == 0;
+}
+
+static int
+pnfs_layout_return_unused_byserver(struct nfs_server *server, void *data)
+{
+	const struct pnfs_layout_range *range = data;
+	struct pnfs_layout_hdr *lo;
+	struct inode *inode;
+restart:
+	rcu_read_lock();
+	list_for_each_entry_rcu(lo, &server->layouts, plh_layouts) {
+		if (!pnfs_layout_can_be_returned(lo) ||
+		    test_bit(NFS_LAYOUT_RETURN_REQUESTED, &lo->plh_flags))
+			continue;
+		inode = lo->plh_inode;
+		spin_lock(&inode->i_lock);
+		if (!pnfs_should_return_unused_layout(lo, range)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		spin_unlock(&inode->i_lock);
+		inode = pnfs_grab_inode_layout_hdr(lo);
+		if (!inode)
+			continue;
+		rcu_read_unlock();
+		pnfs_mark_layout_for_return(inode, range);
+		iput(inode);
+		cond_resched();
+		goto restart;
+	}
+	rcu_read_unlock();
+	return 0;
+}
+
+void
+pnfs_layout_return_unused_byclid(struct nfs_client *clp,
+				 enum pnfs_iomode iomode)
+{
+	struct pnfs_layout_range range = {
+		.iomode = iomode,
+		.offset = 0,
+		.length = NFS4_MAX_UINT64,
+	};
+
+	nfs_client_for_each_server(clp, pnfs_layout_return_unused_byserver,
+			&range);
+}
+
 void
 pnfs_generic_pg_check_layout(struct nfs_pageio_descriptor *pgio)
 {
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 8df9aa02d336..7bfb6970134a 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -329,6 +329,9 @@ int pnfs_write_done_resend_to_mds(struct nfs_pgio_header *);
 struct nfs4_threshold *pnfs_mdsthreshold_alloc(void);
 void pnfs_error_mark_layout_for_return(struct inode *inode,
 				       struct pnfs_layout_segment *lseg);
+void pnfs_layout_return_unused_byclid(struct nfs_client *clp,
+				      enum pnfs_iomode iomode);
+
 /* nfs4_deviceid_flags */
 enum {
 	NFS_DEVICEID_INVALID = 0,       /* set when MDS clientid recalled */
-- 
2.24.1

