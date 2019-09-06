Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC97AC330
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Sep 2019 01:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393117AbfIFXgS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Sep 2019 19:36:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45009 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393111AbfIFXgS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Sep 2019 19:36:18 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so16574382iog.11
        for <linux-nfs@vger.kernel.org>; Fri, 06 Sep 2019 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ba2cOI9b7OHtLZYiEiJWYIpLpz5lKUtLlKZtbMe/9s0=;
        b=BG2GQve3HoV1Zqf7o0uN0hnb2XHxEtuBy5h9NJGdSYivFcDKzoF176fuGLMIUfFQR9
         8SSnFiLiyHxpT20aQ5fQH6UmsnMJ6asT650lQbpkNP2Ti+BxxvpaYo7Xf71frsaIefAY
         81M1Y6uBxIxyHQ8mpUetKRRYAR+ln5kUzin9BRBuKoJMH3vSvIJ60OsHqvz6vSMZ4ng4
         hSUbXkih+PcpPPOp+Lc9ZF1W7pzB9vH0RehpgqDKb/qiOOTCn+7+mujBQ8+FaZ2xTLtl
         vfv7C5MbZGlRHwI3t1V8jyfQmgGAbOhYLivMvMNzsLtImziwpirGgwNRTgzA+r/wmpWX
         ihrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ba2cOI9b7OHtLZYiEiJWYIpLpz5lKUtLlKZtbMe/9s0=;
        b=uR/F8zzxiUw2VbhUrUCstFqyhY3ioSd5D6hKsDtJeL9+yx/v8BK27VtaZin/ofllth
         aUC6w7ynUyc3zTZGl9DPtpriIanSN0vsG8wl+EsPa3+8UMUVhbNREXMxGMKLeo2XbMAp
         hHpYARY+E8xdqBp5mub06qImMFut9GDGNPRWzZ2kMbYMgmQ52TUnFHn+QRTgxbdohaIq
         jCmsOq4hrHZLjriBN/N08TwJMH2yqxcRvIBjzP+c9Oau7xLt2y/NkztjDV05THCgzmPF
         LyZVFlRfyTm7ZmP1GnwZIHcOWIHvLJZIg9C7N5nRwZfnyU/Y8ICQkx4OzwMXRem6jgYc
         qikA==
X-Gm-Message-State: APjAAAWilRG8Nam9S99KTHTfnBAX7A/MUZcYv419YMbniIhB5fimL6E0
        5NCZmPAWCpp5hpAbVtNr8x0=
X-Google-Smtp-Source: APXvYqxmMbeXME4GSkPi5Y1NQvV9rQZCYMqBiir1wNjj/kETIr9jaXsSWG7J7gSBmpd6O8XZvMVugA==
X-Received: by 2002:a6b:4404:: with SMTP id r4mr3807521ioa.159.1567812977303;
        Fri, 06 Sep 2019 16:36:17 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id r138sm10439360iod.59.2019.09.06.16.36.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:36:16 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 04/21] NFS: inter ssc open
Date:   Fri,  6 Sep 2019 19:35:54 -0400
Message-Id: <20190906233611.4031-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
References: <20190906233611.4031-1-olga.kornievskaia@gmail.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

NFSv4.2 inter server to server copy requires the destination server to
READ the data from the source server using the provided stateid and
file handle.

Given an NFSv4 stateid and filehandle from the COPY operaion, provide the
destination server with an NFS client function to create a struct file
suitable for the destiniation server to READ the data to be copied.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Andy Adamson <andros@netapp.com>
---
 fs/nfs/nfs4_fs.h  |  7 ++++
 fs/nfs/nfs4file.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c |  5 +--
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 8e590b424d75..5f279425ee77 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -311,6 +311,13 @@ extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 		const struct nfs_open_context *ctx,
 		const struct nfs_lock_context *l_ctx,
 		fmode_t fmode);
+extern int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
+			     struct nfs_fattr *fattr, struct nfs4_label *label,
+			     struct inode *inode);
+extern int update_open_stateid(struct nfs4_state *state,
+				const nfs4_stateid *open_stateid,
+				const nfs4_stateid *deleg_stateid,
+				fmode_t fmode);
 
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
 		struct nfs_fsinfo *fsinfo);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index b68b41be6d9f..1898262a2cb1 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/falloc.h>
 #include <linux/nfs_fs.h>
+#include <linux/file.h>
 #include "delegation.h"
 #include "internal.h"
 #include "iostat.h"
@@ -286,6 +287,99 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 out:
 	return ret < 0 ? ret : count;
 }
+
+static int read_name_gen = 1;
+#define SSC_READ_NAME_BODY "ssc_read_%d"
+
+struct file *
+nfs42_ssc_open(struct vfsmount *ss_mnt, struct nfs_fh *src_fh,
+		nfs4_stateid *stateid)
+{
+	struct nfs_fattr fattr;
+	struct file *filep, *res;
+	struct nfs_server *server;
+	struct inode *r_ino = NULL;
+	struct nfs_open_context *ctx;
+	struct nfs4_state_owner *sp;
+	char *read_name;
+	int len, status = 0;
+
+	server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
+
+	nfs_fattr_init(&fattr);
+
+	status = nfs4_proc_getattr(server, src_fh, &fattr, NULL, NULL);
+	if (status < 0) {
+		res = ERR_PTR(status);
+		goto out;
+	}
+
+	res = ERR_PTR(-ENOMEM);
+	len = strlen(SSC_READ_NAME_BODY) + 16;
+	read_name = kzalloc(len, GFP_NOFS);
+	if (read_name == NULL)
+		goto out;
+	snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
+
+	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, &fattr,
+			NULL);
+	if (IS_ERR(r_ino)) {
+		res = ERR_CAST(r_ino);
+		goto out;
+	}
+
+	filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
+				     r_ino->i_fop);
+	if (IS_ERR(filep)) {
+		res = ERR_CAST(filep);
+		goto out;
+	}
+	filep->f_mode |= FMODE_READ;
+
+	ctx = alloc_nfs_open_context(filep->f_path.dentry, filep->f_mode,
+					filep);
+	if (IS_ERR(ctx)) {
+		res = ERR_CAST(ctx);
+		goto out_filep;
+	}
+
+	res = ERR_PTR(-EINVAL);
+	sp = nfs4_get_state_owner(server, ctx->cred, GFP_KERNEL);
+	if (sp == NULL)
+		goto out_ctx;
+
+	ctx->state = nfs4_get_open_state(r_ino, sp);
+	if (ctx->state == NULL)
+		goto out_stateowner;
+
+	set_bit(NFS_OPEN_STATE, &ctx->state->flags);
+	memcpy(&ctx->state->open_stateid.other, &stateid->other,
+	       NFS4_STATEID_OTHER_SIZE);
+	update_open_stateid(ctx->state, stateid, NULL, filep->f_mode);
+
+	nfs_file_set_open_context(filep, ctx);
+	put_nfs_open_context(ctx);
+
+	file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
+	res = filep;
+out:
+	return res;
+out_stateowner:
+	nfs4_put_state_owner(sp);
+out_ctx:
+	put_nfs_open_context(ctx);
+out_filep:
+	fput(filep);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(nfs42_ssc_open);
+void nfs42_ssc_close(struct file *filep)
+{
+	struct nfs_open_context *ctx = nfs_file_open_context(filep);
+
+	ctx->state->flags = 0;
+}
+EXPORT_SYMBOL_GPL(nfs42_ssc_close);
 #endif /* CONFIG_NFS_V4_2 */
 
 const struct file_operations nfs4_file_operations = {
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5311def18dbb..7ea446bd6b2a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -91,7 +91,6 @@ struct nfs4_opendata;
 static int _nfs4_recover_proc_open(struct nfs4_opendata *data);
 static int nfs4_do_fsinfo(struct nfs_server *, struct nfs_fh *, struct nfs_fsinfo *);
 static void nfs_fixup_referral_attributes(struct nfs_fattr *fattr);
-static int nfs4_proc_getattr(struct nfs_server *, struct nfs_fh *, struct nfs_fattr *, struct nfs4_label *label, struct inode *inode);
 static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle, struct nfs_fattr *fattr, struct nfs4_label *label, struct inode *inode);
 static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 			    struct nfs_fattr *fattr, struct iattr *sattr,
@@ -1713,7 +1712,7 @@ static void nfs_state_clear_delegation(struct nfs4_state *state)
 	write_sequnlock(&state->seqlock);
 }
 
-static int update_open_stateid(struct nfs4_state *state,
+int update_open_stateid(struct nfs4_state *state,
 		const nfs4_stateid *open_stateid,
 		const nfs4_stateid *delegation,
 		fmode_t fmode)
@@ -4026,7 +4025,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	return nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 }
 
-static int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
+int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr, struct nfs4_label *label,
 				struct inode *inode)
 {
-- 
2.18.1

