Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB307CA8DA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Oct 2023 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJPNJa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Oct 2023 09:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjJPNJ2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Oct 2023 09:09:28 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438F3EE
        for <linux-nfs@vger.kernel.org>; Mon, 16 Oct 2023 06:09:26 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ce84:d8c0:f79a:fa0])
        by xavier.telenet-ops.be with bizsmtp
        id yd9L2A00k0pDX7N01d9Meh; Mon, 16 Oct 2023 15:09:24 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsNLR-006jYu-Do;
        Mon, 16 Oct 2023 15:09:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qsNLU-00A9nW-R3;
        Mon, 16 Oct 2023 15:09:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH -next v3 1/2] sunrpc: Wrap read accesses to rpc_task.tk_pid
Date:   Mon, 16 Oct 2023 15:09:18 +0200
Message-Id: <fb3bd4ed540bbe18f60bf1f700c110d662533503.1697460614.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697460614.git.geert+renesas@glider.be>
References: <cover.1697460614.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The tk_pid member in the rpc_task structure exists conditionally on
debug or tracing being enabled.

Introduce and use a wapper to read the value of this member, so users
outside tracing no longer have to care about these conditions.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310121759.0CF34DcN-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.
---
 fs/nfs/filelayout/filelayout.c         | 12 ++++++------
 fs/nfs/flexfilelayout/flexfilelayout.c |  9 +++------
 include/linux/sunrpc/sched.h           | 10 ++++++++++
 net/sunrpc/clnt.c                      |  2 +-
 net/sunrpc/debugfs.c                   |  2 +-
 5 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index ce8f8934bca517c0..5af545f49c54db4f 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -93,8 +93,7 @@ static void filelayout_reset_write(struct nfs_pgio_header *hdr)
 	if (!test_and_set_bit(NFS_IOHDR_REDO, &hdr->flags)) {
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
-			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			rpc_tk_pid(task), hdr->inode->i_sb->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
@@ -110,8 +109,7 @@ static void filelayout_reset_read(struct nfs_pgio_header *hdr)
 	if (!test_and_set_bit(NFS_IOHDR_REDO, &hdr->flags)) {
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
-			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			rpc_tk_pid(task), hdr->inode->i_sb->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
@@ -274,7 +272,8 @@ static void filelayout_read_prepare(struct rpc_task *task, void *data)
 		return;
 	}
 	if (filelayout_reset_to_mds(hdr->lseg)) {
-		dprintk("%s task %u reset io to MDS\n", __func__, task->tk_pid);
+		dprintk("%s task %u reset io to MDS\n", __func__,
+			rpc_tk_pid(task));
 		filelayout_reset_read(hdr);
 		rpc_exit(task, 0);
 		return;
@@ -372,7 +371,8 @@ static void filelayout_write_prepare(struct rpc_task *task, void *data)
 		return;
 	}
 	if (filelayout_reset_to_mds(hdr->lseg)) {
-		dprintk("%s task %u reset io to MDS\n", __func__, task->tk_pid);
+		dprintk("%s task %u reset io to MDS\n", __func__,
+			rpc_tk_pid(task));
 		filelayout_reset_write(hdr);
 		rpc_exit(task, 0);
 		return;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a1dc338649062de3..3dd17f675d433f4d 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1017,8 +1017,7 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 	if (retry_pnfs) {
 		dprintk("%s Reset task %5u for i/o through pNFS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
-			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			rpc_tk_pid(task), hdr->inode->i_sb->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
@@ -1030,8 +1029,7 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 	if (!test_and_set_bit(NFS_IOHDR_REDO, &hdr->flags)) {
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
-			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			rpc_tk_pid(task), hdr->inode->i_sb->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
@@ -1066,8 +1064,7 @@ static void ff_layout_reset_read(struct nfs_pgio_header *hdr)
 	if (!test_and_set_bit(NFS_IOHDR_REDO, &hdr->flags)) {
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
-			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			rpc_tk_pid(task), hdr->inode->i_sb->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 8ada7dc802d30507..0f39e60d28ed0132 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -270,6 +270,11 @@ void		rpc_prepare_task(struct rpc_task *task);
 gfp_t		rpc_task_gfp_mask(void);
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
+static inline unsigned short rpc_tk_pid(const struct rpc_task *task)
+{
+	return task->tk_pid;
+}
+
 static inline const char * rpc_qname(const struct rpc_wait_queue *q)
 {
 	return ((q && q->name) ? q->name : "unknown");
@@ -281,6 +286,11 @@ static inline void rpc_assign_waitqueue_name(struct rpc_wait_queue *q,
 	q->name = name;
 }
 #else
+static inline unsigned short rpc_tk_pid(const struct rpc_task *task)
+{
+	return 0;
+}
+
 static inline void rpc_assign_waitqueue_name(struct rpc_wait_queue *q,
 		const char *name)
 {
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9c210273d06b7f51..2f37e4143789b0cc 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3320,7 +3320,7 @@ static void rpc_show_task(const struct rpc_clnt *clnt,
 		rpc_waitq = rpc_qname(task->tk_waitqueue);
 
 	printk(KERN_INFO "%5u %04x %6d %8p %8p %8ld %8p %sv%u %s a:%ps q:%s\n",
-		task->tk_pid, task->tk_flags, task->tk_status,
+		rpc_tk_pid(task), task->tk_flags, task->tk_status,
 		clnt, task->tk_rqstp, rpc_task_timeout(task), task->tk_ops,
 		clnt->cl_program->name, clnt->cl_vers, rpc_proc_name(task),
 		task->tk_action, rpc_waitq);
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index a176d5a0b0ee9a2c..8896518dd6f3ce0e 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -31,7 +31,7 @@ tasks_show(struct seq_file *f, void *v)
 		xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 
 	seq_printf(f, "%5u %04x %6d 0x%x 0x%x %8ld %ps %sv%u %s a:%ps q:%s\n",
-		task->tk_pid, task->tk_flags, task->tk_status,
+		rpc_tk_pid(task), task->tk_flags, task->tk_status,
 		clnt->cl_clid, xid, rpc_task_timeout(task), task->tk_ops,
 		clnt->cl_program->name, clnt->cl_vers, rpc_proc_name(task),
 		task->tk_action, rpc_waitq);
-- 
2.34.1

