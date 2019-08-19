Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89794E19
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Aug 2019 21:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfHST3G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 15:29:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39850 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfHST3F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 15:29:05 -0400
Received: by mail-io1-f67.google.com with SMTP id l7so6114266ioj.6
        for <linux-nfs@vger.kernel.org>; Mon, 19 Aug 2019 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94yXIfd25kA/1yPLVBoYzLZWboZ8NrD7pkHXxbAJPw0=;
        b=VBJ8rdETgIbSmEy6jgbdhSHXcErgY2AVmWuN3+hWqOn5Or0NwXJpcmX01/YvpG156P
         0zkvCB2ogkADNwu1QbBKRHf1NA1ayYZrfZrsdYLyHQvJnHi9U8GmhKMjzJAzWhUnSb1P
         Z6aiwudYJ+lLDGjmKFPvhNfP1nWQ56eLz2z2Wu7qJLdoCAVPPHPf7oOKoTbU75vMN+zn
         jJn3JpSWA8/IA3IdMHg+65rGREb6wluIJ1Wai7ipouFrbtazeqBnNdX1MPVALBAd82dJ
         CMNEfvekQaO2d9fIEVKZOTCfHW7DOwbrTq+/7buWuNHAUSNFyLfXA1nHK2tcnsMvmLm8
         5gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=94yXIfd25kA/1yPLVBoYzLZWboZ8NrD7pkHXxbAJPw0=;
        b=qNn1jTVRLNghtrVojj5dujMP3rYHv0UbUxJbbo8Q6X7ToEOs5SAruCuyUlNp0rfj3l
         3jR4p2l7HQKNuoDDc6nub5PMceDzbBaCNeUx3yggusNtacdM0dApkjxy4NGdpP5c7oYq
         U3cGP6xCfKsZXGTXyOqxA4TcSog5MovZbfD9uH+/seGXiGcGoDNUPLtwSK7ivcb2ZL/A
         DK5q5B9vLqwanI5ZvZw/h61HGmyG7Pw38N5c+Fl4rMZtlCfAk6NC3gIGhSxZp418sldh
         ZYkJfyXr/eDQlliwCIiyuFsnPtKgU5GrGTw6bN5c2s1TI53QYojeFBUVsAikTfmU9McS
         Zoiw==
X-Gm-Message-State: APjAAAVm5eXHjjIL7znetfyt7wJ6zE06GIwtQ9V/2wZigmZLttV6dtw3
        tbqT6VKnH3uBnNifcJ689qh4S+jwRbw=
X-Google-Smtp-Source: APXvYqzd8VIdIsjOEzbD95Fj4a0usI2Uvxstru56ULiZ28BzNEnPExS8uV4Lpi1GC71gZXErR297gg==
X-Received: by 2002:a5d:9c12:: with SMTP id 18mr27842762ioe.48.1566242945006;
        Mon, 19 Aug 2019 12:29:05 -0700 (PDT)
Received: from gouda.nowheycreamery.com (d28-23-121-75.dim.wideopenwest.com. [23.28.75.121])
        by smtp.gmail.com with ESMTPSA id v23sm16243957ioh.58.2019.08.19.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 12:29:04 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     Trond.Myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 3/6] NFS: Have _nfs4_proc_secinfo() call nfs4_call_sync_custom()
Date:   Mon, 19 Aug 2019 15:28:57 -0400
Message-Id: <20190819192900.19312-4-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
References: <20190819192900.19312-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We do this to set the RPC_TASK_NO_ROUND_ROBIN flag in the task_setup
structure

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs4proc.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 234312240f33..de2b3fd806ef 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7644,6 +7644,8 @@ int nfs4_proc_fsid_present(struct inode *inode, const struct cred *cred)
 static int _nfs4_proc_secinfo(struct inode *dir, const struct qstr *name, struct nfs4_secinfo_flavors *flavors, bool use_integrity)
 {
 	int status;
+	struct rpc_clnt *clnt = NFS_SERVER(dir)->client;
+	struct nfs_client *clp = NFS_SERVER(dir)->nfs_client;
 	struct nfs4_secinfo_arg args = {
 		.dir_fh = NFS_FH(dir),
 		.name   = name,
@@ -7656,26 +7658,37 @@ static int _nfs4_proc_secinfo(struct inode *dir, const struct qstr *name, struct
 		.rpc_argp = &args,
 		.rpc_resp = &res,
 	};
-	struct rpc_clnt *clnt = NFS_SERVER(dir)->client;
+	struct nfs4_call_sync_data data = {
+		.seq_server = NFS_SERVER(dir),
+		.seq_args = &args.seq_args,
+		.seq_res = &res.seq_res,
+	};
+	struct rpc_task_setup task_setup = {
+		.rpc_client = clnt,
+		.rpc_message = &msg,
+		.callback_ops = clp->cl_mvops->call_sync_ops,
+		.callback_data = &data,
+		.flags = RPC_TASK_NO_ROUND_ROBIN,
+	};
 	const struct cred *cred = NULL;
 
 	if (use_integrity) {
-		clnt = NFS_SERVER(dir)->nfs_client->cl_rpcclient;
-		cred = nfs4_get_clid_cred(NFS_SERVER(dir)->nfs_client);
+		clnt = clp->cl_rpcclient;
+		task_setup.rpc_client = clnt;
+
+		cred = nfs4_get_clid_cred(clp);
 		msg.rpc_cred = cred;
 	}
 
 	dprintk("NFS call  secinfo %s\n", name->name);
 
-	nfs4_state_protect(NFS_SERVER(dir)->nfs_client,
-		NFS_SP4_MACH_CRED_SECINFO, &clnt, &msg);
+	nfs4_state_protect(clp, NFS_SP4_MACH_CRED_SECINFO, &clnt, &msg);
+	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
+	status = nfs4_call_sync_custom(&task_setup);
 
-	status = nfs4_call_sync(clnt, NFS_SERVER(dir), &msg, &args.seq_args,
-				&res.seq_res, RPC_TASK_NO_ROUND_ROBIN);
 	dprintk("NFS reply  secinfo: %d\n", status);
 
 	put_cred(cred);
-
 	return status;
 }
 
-- 
2.22.1

