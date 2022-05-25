Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABB5534124
	for <lists+linux-nfs@lfdr.de>; Wed, 25 May 2022 18:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbiEYQNY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 May 2022 12:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbiEYQNS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 May 2022 12:13:18 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6BBB82DF
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 09:13:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id e2so602248qvq.13
        for <linux-nfs@vger.kernel.org>; Wed, 25 May 2022 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GPaazRXbYofK3duple/3o/xisQb6QJL7zJW7jzrRqFo=;
        b=fkvQ2hY1pji4X5V6HkJEM53kF6ydRsx/yubvy3+e5re2alSRVGILIoOzhO9ND0VLML
         c/JYVB/EdTSYwBttUx5UAUIl2Vugloz8BPM6KYzy1eP//Ee3bdREO7nMAiZa9wRaTOqV
         aKKdQrr0vF0AoCsFhjkimEgNQLodQzcxnhzRrAldOmg4nYSC9W+RzDf9cdOTXP+lcXpo
         hYY1cdnuwbbuUGRDYT7K+Yh8VtjCbn5VqXgHRaLFbzGZUs7Q99y8J7jGcLwSecmBOPB5
         wtWbk4Sb7ETta9n6uTAeDf+s2fgK94SeTrS0YNLu0l9Y/EAWrDvrab15DFcEb/m+kpP1
         gl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GPaazRXbYofK3duple/3o/xisQb6QJL7zJW7jzrRqFo=;
        b=4MF6n22JWJ8OJE9S+TuSKuuvpVfGzK7vXRlRySfOQYgNzzKQED8ExMMZvCQHV37U2/
         zmpHaYj/Xh73XhQc/6uqbg9Ytu3XE0hcnWAlTZzQvijt5Tx5BEmiynSPrBXe1ghTBj1s
         uWJtCHcg9uA4Pj8OONncQm8xJ7jd+nYczJCNeKBabfLslpJsk0YXhDgn7FEKjznPYwZk
         kWtxQlktANbdl5L63AKYcdSmzfKrIkGOM2XBlGBRk5ZBhBWOFL1iz5TTrd54i3JJ6SIi
         D5Fl0moQWu54xnoHi94FOE5OzQT+XEjqhqp30YhLkNi4+7mjCYZoQ1cSOA1H8swZUcXQ
         9xeA==
X-Gm-Message-State: AOAM533RxsUyOrR+4goceUIoI+ciFb50QrIG4ELeHe6OZLM8iX6MnUsO
        I7qyroulRr6jSmDZoXdswT8=
X-Google-Smtp-Source: ABdhPJwHqHqf4t8bEo6dfhFGith4e+kDWpLoKJgZEngk1FCRjtfJhxqotsEjnMptxHTH5zV1A1vTJQ==
X-Received: by 2002:a05:6214:226a:b0:462:2a3b:53ed with SMTP id gs10-20020a056214226a00b004622a3b53edmr16121208qvb.115.1653495187650;
        Wed, 25 May 2022 09:13:07 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com ([2600:1700:6a10:2e90:4485:dff6:95f4:1222])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8124b000000b002f908680602sm1510211qtj.81.2022.05.25.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 09:13:06 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFSv4.1 mark qualified async operations as MOVEABLE tasks
Date:   Wed, 25 May 2022 12:12:59 -0400
Message-Id: <20220525161259.73007-1-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

Mark async operations such as RENAME, REMOVE, COMMIT MOVEABLE
for the nfsv4.1+ sessions.

v2
Change how tasks are checked for whether or not they can
be moved based on server's capability. All v1 and v2 version's
tasks are marked as moveable

Fixes: 85e39feead948 ("NFSv4.1 identify and mark RPC tasks that can move between transports")
Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 fs/nfs/nfs4proc.c         | 26 ++++++++++++++------------
 fs/nfs/pagelist.c         |  3 +++
 fs/nfs/unlink.c           |  8 ++++++++
 fs/nfs/write.c            |  4 ++++
 include/linux/nfs_fs_sb.h |  1 +
 5 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0dfdbb406f96..895808beba25 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1162,7 +1162,7 @@ static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 {
 	unsigned short task_flags = 0;
 
-	if (server->nfs_client->cl_minorversion)
+	if (server->caps & NFS_CAP_MOVEABLE)
 		task_flags = RPC_TASK_MOVEABLE;
 	return nfs4_do_call_sync(clnt, server, msg, args, res, task_flags);
 }
@@ -2568,7 +2568,7 @@ static int nfs4_run_open_task(struct nfs4_opendata *data,
 	};
 	int status;
 
-	if (server->nfs_client->cl_minorversion)
+	if (nfs_server_capable(dir, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
 	kref_get(&data->kref);
@@ -3737,7 +3737,7 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 	};
 	int status = -ENOMEM;
 
-	if (server->nfs_client->cl_minorversion)
+	if (nfs_server_capable(state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
 	nfs4_state_protect(server->nfs_client, NFS_SP4_MACH_CRED_CLEANUP,
@@ -4408,7 +4408,7 @@ static int _nfs4_proc_lookup(struct rpc_clnt *clnt, struct inode *dir,
 	};
 	unsigned short task_flags = 0;
 
-	if (server->nfs_client->cl_minorversion)
+	if (nfs_server_capable(dir, NFS_CAP_MOVEABLE))
 		task_flags = RPC_TASK_MOVEABLE;
 
 	/* Is this is an attribute revalidation, subject to softreval? */
@@ -6640,10 +6640,13 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 		.rpc_client = server->client,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_delegreturn_ops,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT | RPC_TASK_MOVEABLE,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_TIMEOUT,
 	};
 	int status = 0;
 
+	if (nfs_server_capable(inode, NFS_CAP_MOVEABLE))
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
@@ -6957,10 +6960,8 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 		.workqueue = nfsiod_workqueue,
 		.flags = RPC_TASK_ASYNC,
 	};
-	struct nfs_client *client =
-		NFS_SERVER(lsp->ls_state->inode)->nfs_client;
 
-	if (client->cl_minorversion)
+	if (nfs_server_capable(lsp->ls_state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
 	nfs4_state_protect(NFS_SERVER(lsp->ls_state->inode)->nfs_client,
@@ -7231,9 +7232,8 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 	int ret;
-	struct nfs_client *client = NFS_SERVER(state->inode)->nfs_client;
 
-	if (client->cl_minorversion)
+	if (nfs_server_capable(state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
 	data = nfs4_alloc_lockdata(fl, nfs_file_open_context(fl->fl_file),
@@ -10468,7 +10468,8 @@ static const struct nfs4_minor_version_ops nfs_v4_1_minor_ops = {
 		| NFS_CAP_POSIX_LOCK
 		| NFS_CAP_STATEID_NFSV41
 		| NFS_CAP_ATOMIC_OPEN_V1
-		| NFS_CAP_LGOPEN,
+		| NFS_CAP_LGOPEN
+		| NFS_CAP_MOVEABLE,
 	.init_client = nfs41_init_client,
 	.shutdown_client = nfs41_shutdown_client,
 	.match_stateid = nfs41_match_stateid,
@@ -10503,7 +10504,8 @@ static const struct nfs4_minor_version_ops nfs_v4_2_minor_ops = {
 		| NFS_CAP_LAYOUTSTATS
 		| NFS_CAP_CLONE
 		| NFS_CAP_LAYOUTERROR
-		| NFS_CAP_READ_PLUS,
+		| NFS_CAP_READ_PLUS
+		| NFS_CAP_MOVEABLE,
 	.init_client = nfs41_init_client,
 	.shutdown_client = nfs41_shutdown_client,
 	.match_stateid = nfs41_match_stateid,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 9157dd19b8b4..317cedfa52bf 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -767,6 +767,9 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		.flags = RPC_TASK_ASYNC | flags,
 	};
 
+	if (nfs_server_capable(hdr->inode, NFS_CAP_MOVEABLE))
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
+
 	hdr->rw_ops->rw_initiate(hdr, &msg, rpc_ops, &task_setup_data, how);
 
 	dprintk("NFS: initiated pgio call "
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 6f325e10056c..9697cd5d2561 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -102,6 +102,10 @@ static void nfs_do_call_unlink(struct inode *inode, struct nfs_unlinkdata *data)
 	};
 	struct rpc_task *task;
 	struct inode *dir = d_inode(data->dentry->d_parent);
+
+	if (nfs_server_capable(inode, NFS_CAP_MOVEABLE))
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
+
 	nfs_sb_active(dir->i_sb);
 	data->args.fh = NFS_FH(dir);
 	nfs_fattr_init(data->res.dir_attr);
@@ -344,6 +348,10 @@ nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
 		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF,
 	};
 
+	if (nfs_server_capable(old_dir, NFS_CAP_MOVEABLE) &&
+	    nfs_server_capable(new_dir, NFS_CAP_MOVEABLE))
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2f41659e232e..1c706465d090 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1709,6 +1709,10 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 		.flags = RPC_TASK_ASYNC | flags,
 		.priority = priority,
 	};
+
+	if (nfs_server_capable(data->inode, NFS_CAP_MOVEABLE))
+		task_setup_data.flags |= RPC_TASK_MOVEABLE;
+
 	/* Set up the initial task struct.  */
 	nfs_ops->commit_setup(data, &msg, &task_setup_data.rpc_client);
 	trace_nfs_initiate_commit(data);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 157d2bd6b241..ea2f7e6b1b0b 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -287,4 +287,5 @@ struct nfs_server {
 #define NFS_CAP_XATTR		(1U << 28)
 #define NFS_CAP_READ_PLUS	(1U << 29)
 #define NFS_CAP_FS_LOCATIONS	(1U << 30)
+#define NFS_CAP_MOVEABLE	(1U << 31)
 #endif
-- 
2.27.0

