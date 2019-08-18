Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62944918C0
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Aug 2019 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfHRSVY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 18 Aug 2019 14:21:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33912 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfHRSVX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 18 Aug 2019 14:21:23 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so16113008ioa.1
        for <linux-nfs@vger.kernel.org>; Sun, 18 Aug 2019 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1NdoQIWSrvr93Mwv+v+9aRiMy/3h8ZEqxOLy5uUv10w=;
        b=gRoryPBWsj26lhLEs0WFXyjJbHUrIOTjg2yb/swqvXrg3t5anU/gRmYn63lgn4Qoyp
         NiBhlUTgoBAZthqcSq25YXvWS2BUyLWwN/gE+ohFW9OQhkVzuwI7fQAdBNrNelFq0Sar
         UudjYZ/6GwDo8kBam1BJ1HKEZMG1MElH7hl7yzFA2p18/bk2w5ETtyZiPcbm/AYqSCQx
         /rkX6yUnBybNYHgAgj9zIVnHWAGW2pI8XiEC7SrRcBUCFjp+h9nRH1yy95DbVSR9G7WL
         B4sroP31+4bUT0XUNKB5hDstGRgyDKjRvuhdrQxCUg9Rd8e8JZ8NINCOnv/TIDyYU3S4
         Jf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1NdoQIWSrvr93Mwv+v+9aRiMy/3h8ZEqxOLy5uUv10w=;
        b=jyZnS3oiOBQ4HYFE0C5ip5XnwxEyKH9j+CGL2v1WFvbnSuOpthgJMa0R6tCB96P/wG
         300xHlKRKUmciB/oNcNLmnd4X50C6GH3inwd3QMoyRhGQTeV8XbWN4aNFpB96yXsrdJr
         QIA+cMywiFZYqRZQK2qm1T4qWTbEQmd97w7j96o4ZcT5Zqt4tQdKjUSLo3dS3w4Ew4wm
         U3LB37MqwzSHECGwt2TboR2t70zTpOMrJ+uxeyBTTsuef1Puf5+KYzpWfQEuiIJSRbtf
         p8eJmo3e0DqGIxAju+bnBulHtT1OyW6oP1eF4rPI5jVWQVPZ5tPSRJB4erw4xXx/0WiH
         3Yvg==
X-Gm-Message-State: APjAAAU14MMWz7S4LIolrpA8CWMKWewHXkpPQtZKlxGPxigA3EoFPHsT
        F+K3j4HtFgWE39UFy4/c6Y4oOrA=
X-Google-Smtp-Source: APXvYqwwZadOt8ocdUfRChZm8ollrCIfHVKZEZDZutDDY0sD42xt8xzxELw4raGZAPystrS6qOpd8w==
X-Received: by 2002:a02:ce37:: with SMTP id v23mr7097498jar.46.1566152482749;
        Sun, 18 Aug 2019 11:21:22 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id n22sm10317844iob.37.2019.08.18.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:21:22 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/16] nfsd: convert nfs4_file->fi_fds array to use nfsd_files
Date:   Sun, 18 Aug 2019 14:18:52 -0400
Message-Id: <20190818181859.8458-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818181859.8458-9-trond.myklebust@hammerspace.com>
References: <20190818181859.8458-1-trond.myklebust@hammerspace.com>
 <20190818181859.8458-2-trond.myklebust@hammerspace.com>
 <20190818181859.8458-3-trond.myklebust@hammerspace.com>
 <20190818181859.8458-4-trond.myklebust@hammerspace.com>
 <20190818181859.8458-5-trond.myklebust@hammerspace.com>
 <20190818181859.8458-6-trond.myklebust@hammerspace.com>
 <20190818181859.8458-7-trond.myklebust@hammerspace.com>
 <20190818181859.8458-8-trond.myklebust@hammerspace.com>
 <20190818181859.8458-9-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/nfs4state.c | 23 ++++++++++++-----------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7857942c5ca6..3742a2a7b4da 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -50,6 +50,7 @@
 
 #include "netns.h"
 #include "pnfs.h"
+#include "filecache.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
 
@@ -433,7 +434,7 @@ static struct file *
 __nfs4_get_fd(struct nfs4_file *f, int oflag)
 {
 	if (f->fi_fds[oflag])
-		return get_file(f->fi_fds[oflag]);
+		return get_file(f->fi_fds[oflag]->nf_file);
 	return NULL;
 }
 
@@ -590,17 +591,17 @@ static void __nfs4_file_put_access(struct nfs4_file *fp, int oflag)
 	might_lock(&fp->fi_lock);
 
 	if (atomic_dec_and_lock(&fp->fi_access[oflag], &fp->fi_lock)) {
-		struct file *f1 = NULL;
-		struct file *f2 = NULL;
+		struct nfsd_file *f1 = NULL;
+		struct nfsd_file *f2 = NULL;
 
 		swap(f1, fp->fi_fds[oflag]);
 		if (atomic_read(&fp->fi_access[1 - oflag]) == 0)
 			swap(f2, fp->fi_fds[O_RDWR]);
 		spin_unlock(&fp->fi_lock);
 		if (f1)
-			fput(f1);
+			nfsd_file_put(f1);
 		if (f2)
-			fput(f2);
+			nfsd_file_put(f2);
 	}
 }
 
@@ -4651,7 +4652,7 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
 		struct nfsd4_open *open)
 {
-	struct file *filp = NULL;
+	struct nfsd_file *nf = NULL;
 	__be32 status;
 	int oflag = nfs4_access_to_omode(open->op_share_access);
 	int access = nfs4_access_to_access(open->op_share_access);
@@ -4687,18 +4688,18 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 
 	if (!fp->fi_fds[oflag]) {
 		spin_unlock(&fp->fi_lock);
-		status = nfsd_open(rqstp, cur_fh, S_IFREG, access, &filp);
+		status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
 		if (status)
 			goto out_put_access;
 		spin_lock(&fp->fi_lock);
 		if (!fp->fi_fds[oflag]) {
-			fp->fi_fds[oflag] = filp;
-			filp = NULL;
+			fp->fi_fds[oflag] = nf;
+			nf = NULL;
 		}
 	}
 	spin_unlock(&fp->fi_lock);
-	if (filp)
-		fput(filp);
+	if (nf)
+		nfsd_file_put(nf);
 
 	status = nfsd4_truncate(rqstp, cur_fh, open);
 	if (status)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 5dbd16946e8e..8196bfb74f12 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -506,7 +506,7 @@ struct nfs4_file {
 	};
 	struct list_head	fi_clnt_odstate;
 	/* One each for O_RDONLY, O_WRONLY, O_RDWR: */
-	struct file *		fi_fds[3];
+	struct nfsd_file	*fi_fds[3];
 	/*
 	 * Each open or lock stateid contributes 0-4 to the counts
 	 * below depending on which bits are set in st_access_bitmap:
-- 
2.21.0

