Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289D179B041
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjIKV6M (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244049AbjIKS5F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 14:57:05 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2141B6
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:56:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64f4ac604c2so25874286d6.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694458619; x=1695063419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJFAHGplLbWURCk//AHrAxo6w0nka4O2qa2RE6264FE=;
        b=h1/qfLbHwt83rFbuuzdp7VgKC7Q/z2X2rW7+bMRflx6K0W1k6Z90LKWhO1ZmKjhQ8t
         GiQEAy9PtKrYlayf5OEswwVX0ObIYwP/Gxm1i173Xewhvwsu2/PoJFh1WMu0eT1vU8OA
         8jiY9jCN80iZbvKOHN5h83uaeFqzigJRWk+HUC5pZzIoC8RZGNKtsce4jsw/U9dx7Cs2
         xyfzbDqz8zOtuUuD+FYjeTHPjk3Rs6K2Y2s1l0K1Uip+tu0fCSR8ikQR4QgkeZtDFAeu
         2xs0mUiIfXQ9NFDen2c8WExajmZKH4cNSHc6mwcOf3AxfA+4kJkk7yqMhsiAcAT5fXI6
         Sriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458619; x=1695063419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJFAHGplLbWURCk//AHrAxo6w0nka4O2qa2RE6264FE=;
        b=NcC7DraPb7w8X9s0PAq4z8hRZcX+KWjB1wyCIxqb5SM+5oO+y1fflTEz/bV70d9p5A
         syhecF5IGzxpWFfeZ1Jj9kJM+anFnD0GDU8TgFDP6UrapE6xsVBGcPgLYTl9NQBfMtkh
         PWNQ/9pSAqh75goW1YG32UBJdWIoOyzuGYIerdvVNfu/3PC+Ujoy6+UEj9lDDPQZRRZU
         9pjsO4ZcOJbfZV09zfvDr4/Hk8nJDVgUK0UgWVyf01vuOwia926ZEhCx2hBMz8isAU+2
         mHkGAfzrDAf6ncRoDAwXRScKBMUfJ8W/rvw2WEQFk9ZOkQ4RwnYzfeDpqhHIWHeMTNOy
         fpAg==
X-Gm-Message-State: AOJu0YwW8YWjOoIrEvcGzwHk01BDYLsNtAJqANaSoJRIgL2c+HlVVVpM
        lBzsa5uRRRWhVFNf3WhrXOtzl8swuQ==
X-Google-Smtp-Source: AGHT+IH5zNkAnVvOUQ5OewtqtmwgWYKBQS8YcBCvYSE8kD5QnDMvpe2aUSifGriciAYT/a2Ws4kcVw==
X-Received: by 2002:a0c:f189:0:b0:64f:3795:c10 with SMTP id m9-20020a0cf189000000b0064f37950c10mr9114264qvl.10.1694458618796;
        Mon, 11 Sep 2023 11:56:58 -0700 (PDT)
Received: from localhost.localdomain (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id e15-20020a0caa4f000000b006263a9e7c63sm3106068qvb.104.2023.09.11.11.56.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:56:58 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4/pnfs: Allow layoutget to return EAGAIN for softerr mounts
Date:   Mon, 11 Sep 2023 14:50:31 -0400
Message-ID: <20230911185031.11903-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911185031.11903-2-trond.myklebust@hammerspace.com>
References: <20230911185031.11903-1-trond.myklebust@hammerspace.com>
 <20230911185031.11903-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're using the 'softerr' mount option, we may want to allow
layoutget to return EAGAIN to allow knfsd server threads to return a
JUKEBOX/DELAY error to the client instead of busy waiting.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 18 ++++++++++--------
 fs/nfs/pnfs.c     |  8 ++++++--
 fs/nfs/pnfs.h     |  5 ++++-
 fs/nfs/write.c    |  2 ++
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 99c054a6c7b5..5deeaea8026e 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9651,6 +9651,9 @@ nfs4_layoutget_handle_exception(struct rpc_task *task,
 
 	nfs4_sequence_free_slot(&lgp->res.seq_res);
 
+	exception->state = NULL;
+	exception->stateid = NULL;
+
 	switch (nfs4err) {
 	case 0:
 		goto out;
@@ -9746,7 +9749,8 @@ static const struct rpc_call_ops nfs4_layoutget_call_ops = {
 };
 
 struct pnfs_layout_segment *
-nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
+nfs4_proc_layoutget(struct nfs4_layoutget *lgp,
+		    struct nfs4_exception *exception)
 {
 	struct inode *inode = lgp->args.inode;
 	struct nfs_server *server = NFS_SERVER(inode);
@@ -9766,13 +9770,10 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 			 RPC_TASK_MOVEABLE,
 	};
 	struct pnfs_layout_segment *lseg = NULL;
-	struct nfs4_exception exception = {
-		.inode = inode,
-		.timeout = *timeout,
-	};
 	int status = 0;
 
 	nfs4_init_sequence(&lgp->args.seq_args, &lgp->res.seq_res, 0, 0);
+	exception->retry = 0;
 
 	task = rpc_run_task(&task_setup_data);
 	if (IS_ERR(task))
@@ -9783,11 +9784,12 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 		goto out;
 
 	if (task->tk_status < 0) {
-		status = nfs4_layoutget_handle_exception(task, lgp, &exception);
-		*timeout = exception.timeout;
+		exception->retry = 1;
+		status = nfs4_layoutget_handle_exception(task, lgp, exception);
 	} else if (lgp->res.layoutp->len == 0) {
+		exception->retry = 1;
 		status = -EAGAIN;
-		*timeout = nfs4_update_delay(&exception.timeout);
+		nfs4_update_delay(&exception->timeout);
 	} else
 		lseg = pnfs_layout_process(lgp);
 out:
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 306cba0b9e69..63904a372b2f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1980,7 +1980,9 @@ pnfs_update_layout(struct inode *ino,
 	struct pnfs_layout_segment *lseg = NULL;
 	struct nfs4_layoutget *lgp;
 	nfs4_stateid stateid;
-	long timeout = 0;
+	struct nfs4_exception exception = {
+		.inode = ino,
+	};
 	unsigned long giveup = jiffies + (clp->cl_lease_time << 1);
 	bool first;
 
@@ -2144,7 +2146,7 @@ pnfs_update_layout(struct inode *ino,
 	lgp->lo = lo;
 	pnfs_get_layout_hdr(lo);
 
-	lseg = nfs4_proc_layoutget(lgp, &timeout);
+	lseg = nfs4_proc_layoutget(lgp, &exception);
 	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
 				 PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET);
 	nfs_layoutget_end(lo);
@@ -2171,6 +2173,8 @@ pnfs_update_layout(struct inode *ino,
 			goto out_put_layout_hdr;
 		}
 		if (lseg) {
+			if (!exception.retry)
+				goto out_put_layout_hdr;
 			if (first)
 				pnfs_clear_first_layoutget(lo);
 			trace_pnfs_update_layout(ino, pos, count,
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index d886c8226d8f..db57a85500ee 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -35,6 +35,7 @@
 #include <linux/nfs_page.h>
 #include <linux/workqueue.h>
 
+struct nfs4_exception;
 struct nfs4_opendata;
 
 enum {
@@ -245,7 +246,9 @@ extern size_t max_response_pages(struct nfs_server *server);
 extern int nfs4_proc_getdeviceinfo(struct nfs_server *server,
 				   struct pnfs_device *dev,
 				   const struct cred *cred);
-extern struct pnfs_layout_segment* nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout);
+extern struct pnfs_layout_segment *
+nfs4_proc_layoutget(struct nfs4_layoutget *lgp,
+		    struct nfs4_exception *exception);
 extern int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync);
 
 /* pnfs.c */
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8c1ee1a1a28f..59478a32e19f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -739,6 +739,8 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 					&pgio);
 		pgio.pg_error = 0;
 		nfs_pageio_complete(&pgio);
+		if (err == -EAGAIN && mntflags & NFS_MOUNT_SOFTERR)
+			break;
 	} while (err < 0 && !nfs_error_is_fatal(err));
 	nfs_io_completion_put(ioc);
 
-- 
2.41.0

