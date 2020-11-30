Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4FB2C9085
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgK3WEs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3WEs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:04:48 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36159C0617A7
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:29 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id n132so12508516qke.1
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHOAENSNXIvjYq9Tl7P3CdijvmITSoC+1Zpxg6ltwMA=;
        b=Y42+wxvFjhSWek3zq7LQvqr0l//jB621jsPyx188fedunt9y8hLMBnyhvXW5OAVbv5
         XJj1TzI8BTDOicAC+vDiZ3BtVavWeWZPDWcK1iWpNEk1VvJP5QjGIMujgokqLWnv9bsD
         1JqaEmxzKeKc1/MTTB6JV4SlXFAp8A24HiECzv9iZ6tgC/1EEAOPN5c7L06+oMZ3G9JN
         MsxL3XuCMZ8lMomFk8dkMqihOMQGWyfRzPx0875i2l6kHi2t/ZcWsUOBDY5WGeCTxrAD
         35SeLft/qP9oVRynuHnFXzLw6FD0PpwnLjOVLt2NX11eOjw9jJkPipsRf8wp6KGqFQMA
         1nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHOAENSNXIvjYq9Tl7P3CdijvmITSoC+1Zpxg6ltwMA=;
        b=IuGWT0bPXfQCH2ZeOVcE+9r/7Q15kdcnharacCOAVzcJMD2SHVarOebCUtPeDSkxwD
         9yhHhxcrBpT6xx0kFWXeFKsgQWf7vBLx+B1aynVNe0Ae6z2IM6UMXpe3FoYKEVXuhb1P
         NKmCV/Smp0YMCHaSkIpuzW/Rl0ic0wsGKRbW/4HbH42PO/Ie1MA3V4vbrhraDoIv7q+s
         mj0pD6W+KjiPBsBDgWE9K5Aoi+i/eLjfvP8bzVdY5f3UfTd4Qv0TecGvppJAW4ZpIB57
         0HO/qxwy/5bHZdhBZyntaGm5hpmYcqBH/oN6wHa6TY8KcUcXuSfnFTuVx5zklrKdgiIT
         2Bag==
X-Gm-Message-State: AOAM531LRdpoWuAPgSAfXZeEC+ZqiXylfCi5ktS0sohWPEQzSrEUvyN/
        s5qOhvKF9H6D/OP0VI/lAg==
X-Google-Smtp-Source: ABdhPJwajcc/Tj1ux/CpoCBgcFDGWq4K5eLsq2AdQqBVHC5x3VJ1MqGFnkyl6mqraRlRRivIk3+UKw==
X-Received: by 2002:a37:500a:: with SMTP id e10mr26008341qkb.60.1606773808357;
        Mon, 30 Nov 2020 14:03:28 -0800 (PST)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id q62sm17642886qkf.86.2020.11.30.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:03:27 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 6/6] nfsd: Set PF_LOCAL_THROTTLE on local filesystems only
Date:   Mon, 30 Nov 2020 17:03:19 -0500
Message-Id: <20201130220319.501064-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130220319.501064-6-trond.myklebust@hammerspace.com>
References: <20201130220319.501064-1-trond.myklebust@hammerspace.com>
 <20201130220319.501064-2-trond.myklebust@hammerspace.com>
 <20201130220319.501064-3-trond.myklebust@hammerspace.com>
 <20201130220319.501064-4-trond.myklebust@hammerspace.com>
 <20201130220319.501064-5-trond.myklebust@hammerspace.com>
 <20201130220319.501064-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Don't set PF_LOCAL_THROTTLE on remote filesystems like NFS, since they
aren't expected to ever be subject to double buffering.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/export.c          |  3 ++-
 fs/nfsd/vfs.c            | 13 +++++++++++--
 include/linux/exportfs.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 5428713af5fe..48b879cfe6e3 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -171,5 +171,6 @@ const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
-	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|EXPORT_OP_CLOSE_BEFORE_UNLINK,
+	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
+		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS,
 };
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 79cba942087e..04937e51de56 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -978,18 +978,25 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 				__be32 *verf)
 {
 	struct file		*file = nf->nf_file;
+	struct super_block	*sb = file_inode(file)->i_sb;
 	struct svc_export	*exp;
 	struct iov_iter		iter;
 	__be32			nfserr;
 	int			host_err;
 	int			use_wgather;
 	loff_t			pos = offset;
+	unsigned long		exp_op_flags = 0;
 	unsigned int		pflags = current->flags;
 	rwf_t			flags = 0;
+	bool			restore_flags = false;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
-	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
+	if (sb->s_export_op)
+		exp_op_flags = sb->s_export_op->flags;
+
+	if (test_bit(RQ_LOCAL, &rqstp->rq_flags) &&
+	    !(exp_op_flags & EXPORT_OP_REMOTE_FS)) {
 		/*
 		 * We want throttling in balance_dirty_pages()
 		 * and shrink_inactive_list() to only consider
@@ -998,6 +1005,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		 * the client's dirty pages or its congested queue.
 		 */
 		current->flags |= PF_LOCAL_THROTTLE;
+		restore_flags = true;
+	}
 
 	exp = fhp->fh_export;
 	use_wgather = (rqstp->rq_vers == 2) && EX_WGATHER(exp);
@@ -1049,7 +1058,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		trace_nfsd_write_err(rqstp, fhp, offset, host_err);
 		nfserr = nfserrno(host_err);
 	}
-	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
+	if (restore_flags)
 		current_restore_flags(pflags, PF_LOCAL_THROTTLE);
 	return nfserr;
 }
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 846df3c96730..d93e8a6737bb 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -216,6 +216,7 @@ struct export_operations {
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
+#define EXPORT_OP_REMOTE_FS		(0x8) /* Filesystem is remote */
 	unsigned long	flags;
 };
 
-- 
2.28.0

