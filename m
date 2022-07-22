Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005E057E653
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jul 2022 20:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiGVSM2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Jul 2022 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiGVSM1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Jul 2022 14:12:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F779687
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 11:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D25C6B829C8
        for <linux-nfs@vger.kernel.org>; Fri, 22 Jul 2022 18:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1497FC341CB;
        Fri, 22 Jul 2022 18:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658513543;
        bh=4unQ+qRQn9Wxj2h76u02m3cwSeoDQMg2st+gsmemt3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upzP81m9JzoOFFf19IgXVbV5Ofei6Lr5fQUOquNnxllKcKLN0K/o3yPTYB/2Crcr/
         MuoNzLAyFoEUIBqDyDoVtcq8Q3ZjPZbbEWbaOhtb7PCVMhwIykd4XEhCYIVICH6cFd
         Agzc31k3v3YwPCQalkoHvas6tlNr9Onk9nMzJDANcQ9o0ojlQTbdK3mMN2mwf6We1i
         JwzBh1s409HHCTIlVyojzCnU4DzZeNk9vtUjahDnSO2FTd/ZW00wsjmgoF/w9bfkTI
         XAgCabBYl4QtDSSIU/8pE9zgruJgE6bVrfvZ6s3FTDZalaRwQ86cGSJw0Caj5astmm
         dkECbzHCiXvQQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com, bxue@redhat.com
Subject: [PATCH 1/3] nfs: add new nfs_direct_req tracepoint events
Date:   Fri, 22 Jul 2022 14:12:18 -0400
Message-Id: <20220722181220.81636-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722181220.81636-1-jlayton@kernel.org>
References: <20220722181220.81636-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add some new tracepoints to the DIO write code.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/direct.c   | 45 +++++++++----------------------
 fs/nfs/internal.h | 33 +++++++++++++++++++++++
 fs/nfs/nfstrace.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 4eb2a8380a28..ad40e81857ee 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -60,44 +60,12 @@
 #include "iostat.h"
 #include "pnfs.h"
 #include "fscache.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
 static struct kmem_cache *nfs_direct_cachep;
 
-struct nfs_direct_req {
-	struct kref		kref;		/* release manager */
-
-	/* I/O parameters */
-	struct nfs_open_context	*ctx;		/* file open context info */
-	struct nfs_lock_context *l_ctx;		/* Lock context info */
-	struct kiocb *		iocb;		/* controlling i/o request */
-	struct inode *		inode;		/* target file of i/o */
-
-	/* completion state */
-	atomic_t		io_count;	/* i/os we're waiting for */
-	spinlock_t		lock;		/* protect completion state */
-
-	loff_t			io_start;	/* Start offset for I/O */
-	ssize_t			count,		/* bytes actually processed */
-				max_count,	/* max expected count */
-				bytes_left,	/* bytes left to be sent */
-				error;		/* any reported error */
-	struct completion	completion;	/* wait for i/o completion */
-
-	/* commit state */
-	struct nfs_mds_commit_info mds_cinfo;	/* Storage for cinfo */
-	struct pnfs_ds_commit_info ds_cinfo;	/* Storage for cinfo */
-	struct work_struct	work;
-	int			flags;
-	/* for write */
-#define NFS_ODIRECT_DO_COMMIT		(1)	/* an unstable reply was received */
-#define NFS_ODIRECT_RESCHED_WRITES	(2)	/* write verification failed */
-	/* for read */
-#define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
-#define NFS_ODIRECT_DONE		INT_MAX	/* write verification failed */
-};
-
 static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops;
 static const struct nfs_commit_completion_ops nfs_direct_commit_completion_ops;
 static void nfs_direct_write_complete(struct nfs_direct_req *dreq);
@@ -595,6 +563,8 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 	struct nfs_page *req;
 	int status = data->task.tk_status;
 
+	trace_nfs_direct_commit_complete(dreq);
+
 	if (status < 0) {
 		/* Errors in commit are fatal */
 		dreq->error = status;
@@ -631,6 +601,8 @@ static void nfs_direct_resched_write(struct nfs_commit_info *cinfo,
 {
 	struct nfs_direct_req *dreq = cinfo->dreq;
 
+	trace_nfs_direct_resched_write(dreq);
+
 	spin_lock(&dreq->lock);
 	if (dreq->flags != NFS_ODIRECT_DONE)
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
@@ -695,6 +667,7 @@ static void nfs_direct_write_schedule_work(struct work_struct *work)
 
 static void nfs_direct_write_complete(struct nfs_direct_req *dreq)
 {
+	trace_nfs_direct_write_complete(dreq);
 	queue_work(nfsiod_workqueue, &dreq->work); /* Calls nfs_direct_write_schedule_work */
 }
 
@@ -705,6 +678,8 @@ static void nfs_direct_write_completion(struct nfs_pgio_header *hdr)
 	struct nfs_page *req = nfs_list_entry(hdr->pages.next);
 	int flags = NFS_ODIRECT_DONE;
 
+	trace_nfs_direct_write_completion(dreq);
+
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 
 	spin_lock(&dreq->lock);
@@ -759,6 +734,8 @@ static void nfs_direct_write_reschedule_io(struct nfs_pgio_header *hdr)
 {
 	struct nfs_direct_req *dreq = hdr->dreq;
 
+	trace_nfs_direct_write_reschedule_io(dreq);
+
 	spin_lock(&dreq->lock);
 	if (dreq->error == 0) {
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
@@ -799,6 +776,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	size_t requested_bytes = 0;
 	size_t wsize = max_t(size_t, NFS_SERVER(inode)->wsize, PAGE_SIZE);
 
+	trace_nfs_direct_write_schedule_iovec(dreq);
+
 	nfs_pageio_init_write(&desc, inode, ioflags, false,
 			      &nfs_direct_write_completion_ops);
 	desc.pg_dreq = dreq;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 8f8cd6e2d4db..24a48ba1ca7e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -859,3 +859,36 @@ static inline void nfs_set_port(struct sockaddr *sap, int *port,
 
 	rpc_set_port(sap, *port);
 }
+
+struct nfs_direct_req {
+	struct kref		kref;		/* release manager */
+
+	/* I/O parameters */
+	struct nfs_open_context	*ctx;		/* file open context info */
+	struct nfs_lock_context *l_ctx;		/* Lock context info */
+	struct kiocb *		iocb;		/* controlling i/o request */
+	struct inode *		inode;		/* target file of i/o */
+
+	/* completion state */
+	atomic_t		io_count;	/* i/os we're waiting for */
+	spinlock_t		lock;		/* protect completion state */
+
+	loff_t			io_start;	/* Start offset for I/O */
+	ssize_t			count,		/* bytes actually processed */
+				max_count,	/* max expected count */
+				bytes_left,	/* bytes left to be sent */
+				error;		/* any reported error */
+	struct completion	completion;	/* wait for i/o completion */
+
+	/* commit state */
+	struct nfs_mds_commit_info mds_cinfo;	/* Storage for cinfo */
+	struct pnfs_ds_commit_info ds_cinfo;	/* Storage for cinfo */
+	struct work_struct	work;
+	int			flags;
+	/* for write */
+#define NFS_ODIRECT_DO_COMMIT		(1)	/* an unstable reply was received */
+#define NFS_ODIRECT_RESCHED_WRITES	(2)	/* write verification failed */
+	/* for read */
+#define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
+#define NFS_ODIRECT_DONE		INT_MAX	/* write verification failed */
+};
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 012bd7339862..65388e4a0cd7 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1576,6 +1576,75 @@ TRACE_EVENT(nfs_commit_done,
 		)
 );
 
+#define nfs_show_direct_req_flags(v) \
+	__print_flags(v, "|", \
+			{ NFS_ODIRECT_DO_COMMIT, "DO_COMMIT" }, \
+			{ NFS_ODIRECT_RESCHED_WRITES, "RESCHED_WRITES" }, \
+			{ NFS_ODIRECT_SHOULD_DIRTY, "SHOULD DIRTY" }, \
+			{ NFS_ODIRECT_DONE, "DONE" } )
+
+DECLARE_EVENT_CLASS(nfs_direct_req_class,
+		TP_PROTO(
+			const struct nfs_direct_req *dreq
+		),
+
+		TP_ARGS(dreq),
+
+		TP_STRUCT__entry(
+			__field(const struct nfs_direct_req *, dreq)
+			__field(dev_t, dev)
+			__field(u64, fileid)
+			__field(u32, fhandle)
+			__field(int, ref)
+			__field(loff_t, io_start)
+			__field(ssize_t, count)
+			__field(ssize_t, bytes_left)
+			__field(ssize_t, error)
+			__field(int, flags)
+		),
+
+		TP_fast_assign(
+			const struct inode *inode = dreq->inode;
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			const struct nfs_fh *fh = &nfsi->fh;
+
+			__entry->dreq = dreq;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(fh);
+			__entry->ref = kref_read(&dreq->kref);
+			__entry->io_start = dreq->io_start;
+			__entry->count = dreq->count;
+			__entry->bytes_left = dreq->bytes_left;
+			__entry->error = dreq->error;
+			__entry->flags = dreq->flags;
+		),
+
+		TP_printk(
+			"dreq=%p fileid=%02x:%02x:%llu fhandle=0x%08x ref=%d "
+			"io_start=%lld count=%zd bytes_left=%zd error=%zd flags=%s",
+			__entry->dreq, MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle, __entry->ref,
+			__entry->io_start, __entry->count, __entry->bytes_left,
+			__entry->error, nfs_show_direct_req_flags(__entry->flags)
+		)
+);
+
+#define DEFINE_NFS_DIRECT_REQ_EVENT(name) \
+	DEFINE_EVENT(nfs_direct_req_class, name, \
+			TP_PROTO( \
+				const struct nfs_direct_req *dreq \
+			), \
+			TP_ARGS(dreq))
+
+DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_commit_complete);
+DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_resched_write);
+DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_complete);
+DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_completion);
+DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_schedule_iovec);
+DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_reschedule_io);
+
 TRACE_EVENT(nfs_fh_to_dentry,
 		TP_PROTO(
 			const struct super_block *sb,
-- 
2.36.1

