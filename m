Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822D0131984
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgAFUlu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:41:50 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40148 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgAFUlu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:41:50 -0500
Received: by mail-yw1-f68.google.com with SMTP id i126so22445319ywe.7
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YtsKnU0XAhsrVWaWyf+R9Im78O/oMcqtNYjmB9f4I2s=;
        b=OxvKeq1JZ5QEb/S9YkeKYlFYGURyg9+9qVbUlk7vIGVXX5AU5+sVI5NqhpxlbHStiF
         Bc1OJeei2S/B0Rdk3V5KM4z9JRwJ47ZtlXPbVgKnnQpXEziglWs/TOFTsyudLM8fGZ6U
         kGjS0BJkimgBSIiuBt7iZKlEV2JTuIyNeHUj5CgxSni1ivcpAUfm0pzazX7PiArO6KHh
         k+rEu1wT2Hrid1dLEVQb/IeFe0YE2sOCY+afVrTs55t5MugE+v6gpV7Cl/oEec2VRrt4
         xNgD2GRyWcYGwDnHonT2js0/8mgB1dyc/H0KLDGUBpxTd523s50+I67E+0iNUUOuR5mS
         cpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YtsKnU0XAhsrVWaWyf+R9Im78O/oMcqtNYjmB9f4I2s=;
        b=Rcp0MnOlCzQxjg9EKizwhRVTaA0BberT3JT/dzZl4OUW0MZz88t/G/rKtbtDwBjALO
         wNomzWAzgsdJNTPkjN1IdSLMFecvGIiUVCxQP4XUgzz5AWF9M2Akwt10AYK5/oi347Hx
         GFqN8aPzjXMgDpHHSxZegIozwKywrFRGHpNSVICeVekdgtSu0qv8cfMUuQZ7lCBhe80X
         tFxW7T4yWQ7cgs0rIJoeF2NXhYnTlSq3A6/ar2xKAhFUW67WNSL33GWscGIWX5UmDvna
         Ra+PS5G9GIPpT2Tvb1/bZhAa8HURhNdx3/Dcc7cBJWtwz4VF6ETfDvLdCT303duOST9c
         Kaug==
X-Gm-Message-State: APjAAAWhSVV7oM5z58cQe7SMicDuGGWrgqyMro1mVXpB6miHzwDZ/zkx
        YXso6RqntG3Y1Ot2lPxQ3w==
X-Google-Smtp-Source: APXvYqzUMJy0ei7i1Ioyj6xLyBczOAMA8wSR/fBx+qjzNt4PQ9AiPn9E6kR8dxr1jDwxbPEYQaKt8A==
X-Received: by 2002:a81:6f07:: with SMTP id k7mr82482068ywc.395.1578343308712;
        Mon, 06 Jan 2020 12:41:48 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id 207sm28082405ywq.100.2020.01.06.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:41:48 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Add mount option 'softreval'
Date:   Mon,  6 Jan 2020 15:39:37 -0500
Message-Id: <20200106203937.785805-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106203937.785805-2-trond.myklebust@hammerspace.com>
References: <20200106203937.785805-1-trond.myklebust@hammerspace.com>
 <20200106203937.785805-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a mount option 'softreval' that allows attribute revalidation 'getattr'
calls to time out, and causes them to fall back to using the cached
attributes.
The use case for this option is for ensuring that we can still (slowly)
traverse paths and use cached information even when the server is down.
Once the server comes back up again, the getattr calls start succeeding,
and the caches will revalidate as usual.

The 'softreval' mount option is automatically enabled if you have
specified 'softerr'.  It can be turned off using the options
'nosoftreval', or 'hard'.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c            |  8 +++++++-
 fs/nfs/nfs3proc.c         |  7 ++++++-
 fs/nfs/nfs4proc.c         | 33 ++++++++++++++++++++++++++-------
 fs/nfs/proc.c             |  7 ++++++-
 fs/nfs/super.c            | 16 ++++++++++++++--
 include/linux/nfs_fs_sb.h |  1 +
 6 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b0b4b9f303fd..71dfc9d2fc3d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1156,7 +1156,13 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Lu) getattr failed, error=%d\n",
 			 inode->i_sb->s_id,
 			 (unsigned long long)NFS_FILEID(inode), status);
-		if (status == -ESTALE) {
+		switch (status) {
+		case -ETIMEDOUT:
+			/* A soft timeout occurred. Use cached information? */
+			if (server->flags & NFS_MOUNT_SOFTREVAL)
+				status = 0;
+			break;
+		case -ESTALE:
 			nfs_zap_caches(inode);
 			if (!S_ISDIR(inode->i_mode))
 				set_bit(NFS_INO_STALE, &NFS_I(inode)->flags);
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 9eb2f1a503ab..d401a9c2fe31 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -110,10 +110,15 @@ nfs3_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_resp	= fattr,
 	};
 	int	status;
+	unsigned short task_flags = 0;
+
+	/* Is this is an attribute revalidation, subject to softreval? */
+	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
+		task_flags |= RPC_TASK_TIMEOUT;
 
 	dprintk("NFS call  getattr\n");
 	nfs_fattr_init(fattr);
-	status = rpc_call_sync(server->client, &msg, 0);
+	status = rpc_call_sync(server->client, &msg, task_flags);
 	dprintk("NFS reply getattr: %d\n", status);
 	return status;
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 76d37161409a..eda02b821ea8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1097,11 +1097,12 @@ static int nfs4_call_sync_custom(struct rpc_task_setup *task_setup)
 	return ret;
 }
 
-static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
-				   struct nfs_server *server,
-				   struct rpc_message *msg,
-				   struct nfs4_sequence_args *args,
-				   struct nfs4_sequence_res *res)
+static int nfs4_do_call_sync(struct rpc_clnt *clnt,
+			     struct nfs_server *server,
+			     struct rpc_message *msg,
+			     struct nfs4_sequence_args *args,
+			     struct nfs4_sequence_res *res,
+			     unsigned short task_flags)
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_call_sync_data data = {
@@ -1113,12 +1114,23 @@ static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
 		.rpc_client = clnt,
 		.rpc_message = msg,
 		.callback_ops = clp->cl_mvops->call_sync_ops,
-		.callback_data = &data
+		.callback_data = &data,
+		.flags = task_flags,
 	};
 
 	return nfs4_call_sync_custom(&task_setup);
 }
 
+static int nfs4_call_sync_sequence(struct rpc_clnt *clnt,
+				   struct nfs_server *server,
+				   struct rpc_message *msg,
+				   struct nfs4_sequence_args *args,
+				   struct nfs4_sequence_res *res)
+{
+	return nfs4_do_call_sync(clnt, server, msg, args, res, 0);
+}
+
+
 int nfs4_call_sync(struct rpc_clnt *clnt,
 		   struct nfs_server *server,
 		   struct rpc_message *msg,
@@ -4064,11 +4076,18 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
+	unsigned short task_flags = 0;
+
+	/* Is this is an attribute revalidation, subject to softreval? */
+	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
+		task_flags |= RPC_TASK_TIMEOUT;
 
 	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode);
 
 	nfs_fattr_init(fattr);
-	return nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	return nfs4_do_call_sync(server->client, server, &msg,
+			&args.seq_args, &res.seq_res, task_flags);
 }
 
 int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 0f7288b94633..488349f25e0f 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -108,10 +108,15 @@ nfs_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_resp	= fattr,
 	};
 	int	status;
+	unsigned short task_flags = 0;
+
+	/* Is this is an attribute revalidation, subject to softreval? */
+	if (inode && (server->flags & NFS_MOUNT_SOFTREVAL))
+		task_flags |= RPC_TASK_TIMEOUT;
 
 	dprintk("NFS call  getattr\n");
 	nfs_fattr_init(fattr);
-	status = rpc_call_sync(server->client, &msg, 0);
+	status = rpc_call_sync(server->client, &msg, task_flags);
 	dprintk("NFS reply getattr: %d\n", status);
 	return status;
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 8d8d04bb9d64..928f22c76b43 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -82,6 +82,7 @@
 enum {
 	/* Mount options that take no arguments */
 	Opt_soft, Opt_softerr, Opt_hard,
+	Opt_softreval, Opt_nosoftreval,
 	Opt_posix, Opt_noposix,
 	Opt_cto, Opt_nocto,
 	Opt_ac, Opt_noac,
@@ -131,6 +132,8 @@ static const match_table_t nfs_mount_option_tokens = {
 	{ Opt_soft, "soft" },
 	{ Opt_softerr, "softerr" },
 	{ Opt_hard, "hard" },
+	{ Opt_softreval, "softreval" },
+	{ Opt_nosoftreval, "nosoftreval" },
 	{ Opt_deprecated, "intr" },
 	{ Opt_deprecated, "nointr" },
 	{ Opt_posix, "posix" },
@@ -635,6 +638,7 @@ static void nfs_show_mount_options(struct seq_file *m, struct nfs_server *nfss,
 	} nfs_info[] = {
 		{ NFS_MOUNT_SOFT, ",soft", "" },
 		{ NFS_MOUNT_SOFTERR, ",softerr", "" },
+		{ NFS_MOUNT_SOFTREVAL, ",softreval", "" },
 		{ NFS_MOUNT_POSIX, ",posix", "" },
 		{ NFS_MOUNT_NOCTO, ",nocto", "" },
 		{ NFS_MOUNT_NOAC, ",noac", "" },
@@ -1263,11 +1267,19 @@ static int nfs_parse_mount_options(char *raw,
 			mnt->flags &= ~NFS_MOUNT_SOFTERR;
 			break;
 		case Opt_softerr:
-			mnt->flags |= NFS_MOUNT_SOFTERR;
+			mnt->flags |= NFS_MOUNT_SOFTERR | NFS_MOUNT_SOFTREVAL;
 			mnt->flags &= ~NFS_MOUNT_SOFT;
 			break;
 		case Opt_hard:
-			mnt->flags &= ~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
+			mnt->flags &= ~(NFS_MOUNT_SOFT |
+					NFS_MOUNT_SOFTERR |
+					NFS_MOUNT_SOFTREVAL);
+			break;
+		case Opt_softreval:
+			mnt->flags |= NFS_MOUNT_SOFTREVAL;
+			break;
+		case Opt_nosoftreval:
+			mnt->flags &= ~NFS_MOUNT_SOFTREVAL;
 			break;
 		case Opt_posix:
 			mnt->flags |= NFS_MOUNT_POSIX;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index c176f705bf98..465fa98258a3 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -152,6 +152,7 @@ struct nfs_server {
 #define NFS_MOUNT_LOCAL_FLOCK		0x100000
 #define NFS_MOUNT_LOCAL_FCNTL		0x200000
 #define NFS_MOUNT_SOFTERR		0x400000
+#define NFS_MOUNT_SOFTREVAL		0x800000
 
 	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
-- 
2.24.1

