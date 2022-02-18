Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518E34BC216
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiBRVbN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:31:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbiBRVbM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:31:12 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E7D178958
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:55 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id f19so17278068qvb.6
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bWajgR1t6VC8HzDua3e7SEt0eKJ8om5RB415PTgRaaQ=;
        b=GG03ikNj+uRIKmdlBfUbJ2CCwJ2vMwjakXj/aqu9cvguC7BThzMR1pdf+7KUWQIpDq
         HMZEt0VUIg2YQKFXJJABfvWan9FJ7sPkXAhWQKhn8pI1n0AxiOL3s+9u9SUgi9L1oRSO
         UGPEKDux4eTc7u0sonJa8pON0PSsYujNyy7qx5xSW69KDyz+5zmvCL/m5Tak/CJdqJ5V
         WfrsKFUp2vK9JLsa++LH6YcUMPAPxKQb5NalREnhZDEBozoTxnT4QGwNC3rAb7vafSx9
         KW9ZL3knavDQDV6vWb78lnLh7E4+u/sdu5e4zEBGvAiqeOgCjEzzamaWlHMxpwk7R1Y+
         EuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWajgR1t6VC8HzDua3e7SEt0eKJ8om5RB415PTgRaaQ=;
        b=HA9RdkZnDYZtg97HMGP9JQtRnhfV1Nt/kaDp8LlgonYqCPuvIqvvOwxZOh766XjHDp
         uKL5sTBKldhdOKDUu6v08hpqIsqGoMebPzU/bDZ6cGr/Fnl44SmLlO/znXojtm2zFV8v
         QRh8UdQqN7oQk2la1WnBKD7BHORbKmfh5ofm4JZRxgm14Jj9sD3EvRmjLTfJUeNQlkWp
         5EiGTByZGy1E2pY6aW6vgHuvSyhIDOFgtN0i23EpcE0J1rILmU1IEyh6hcjcU0OrYh1H
         CHJ0An3GQjGK6tgdys9hfM4t+v0a/sZ4AGijtHq8eTITWKrROps7EhdbMnboIvboCBx8
         aHvQ==
X-Gm-Message-State: AOAM530E10xKbGf83syaUNVUjjUnGvynnKzXhzlzXe98g8990tafvvYU
        ooMEphydDBpbpMJoWs4eIbNXwVhqVw==
X-Google-Smtp-Source: ABdhPJwH+aMomGHgKEIHtTRwD2pxn1sojMlNBOATuTrttlrBLGP7PmWK718ekA+GONT+eP6ggy6Y8A==
X-Received: by 2002:a05:6214:5091:b0:42c:aa27:a206 with SMTP id kk17-20020a056214509100b0042caa27a206mr7396255qvb.18.1645219853937;
        Fri, 18 Feb 2022 13:30:53 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w22sm26928656qtk.7.2022.02.18.13.30.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:30:52 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 5/6] NFS: Don't ask for readdirplus unless it can help nfs_getattr()
Date:   Fri, 18 Feb 2022 16:24:23 -0500
Message-Id: <20220218212424.1840077-6-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218212424.1840077-5-trond.myklebust@hammerspace.com>
References: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-2-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-3-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-4-trond.myklebust@hammerspace.com>
 <20220218212424.1840077-5-trond.myklebust@hammerspace.com>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If attribute caching is turned off, then use of readdirplus is not going
to help stat() performance.
Readdirplus also doesn't help if a file is being written to, since we
will have to flush those writes in order to sync the mtime/ctime.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1bef81f5373a..9d2af9887715 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -782,24 +782,26 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 }
 EXPORT_SYMBOL_GPL(nfs_setattr_update_inode);
 
-static void nfs_readdirplus_parent_cache_miss(struct dentry *dentry)
+/*
+ * Don't request help from readdirplus if the file is being written to,
+ * or if attribute caching is turned off
+ */
+static bool nfs_getattr_readdirplus_enable(const struct inode *inode)
 {
-	struct dentry *parent;
+	return nfs_server_capable(inode, NFS_CAP_READDIRPLUS) &&
+	       !nfs_have_writebacks(inode) && NFS_MAXATTRTIMEO(inode) > 5 * HZ;
+}
 
-	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
-		return;
-	parent = dget_parent(dentry);
+static void nfs_readdirplus_parent_cache_miss(struct dentry *dentry)
+{
+	struct dentry *parent = dget_parent(dentry);
 	nfs_readdir_record_entry_cache_miss(d_inode(parent));
 	dput(parent);
 }
 
 static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 {
-	struct dentry *parent;
-
-	if (!nfs_server_capable(d_inode(dentry), NFS_CAP_READDIRPLUS))
-		return;
-	parent = dget_parent(dentry);
+	struct dentry *parent = dget_parent(dentry);
 	nfs_readdir_record_entry_cache_hit(d_inode(parent));
 	dput(parent);
 }
@@ -837,6 +839,7 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
 	bool do_update = false;
+	bool readdirplus_enabled = nfs_getattr_readdirplus_enable(inode);
 
 	trace_nfs_getattr_enter(inode);
 
@@ -845,7 +848,8 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 			STATX_INO | STATX_SIZE | STATX_BLOCKS;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
-		nfs_readdirplus_parent_cache_hit(path->dentry);
+		if (readdirplus_enabled)
+			nfs_readdirplus_parent_cache_hit(path->dentry);
 		goto out_no_revalidate;
 	}
 
@@ -895,15 +899,12 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
 
 	if (do_update) {
-		/* Update the attribute cache */
-		if (!(server->flags & NFS_MOUNT_NOAC))
+		if (readdirplus_enabled)
 			nfs_readdirplus_parent_cache_miss(path->dentry);
-		else
-			nfs_readdirplus_parent_cache_hit(path->dentry);
 		err = __nfs_revalidate_inode(server, inode);
 		if (err)
 			goto out;
-	} else
+	} else if (readdirplus_enabled)
 		nfs_readdirplus_parent_cache_hit(path->dentry);
 out_no_revalidate:
 	/* Only return attributes that were revalidated. */
-- 
2.35.1

