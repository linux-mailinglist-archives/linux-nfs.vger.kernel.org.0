Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605446294F
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2019 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391664AbfGHTYs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jul 2019 15:24:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34643 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391660AbfGHTYs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jul 2019 15:24:48 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so37945953iot.1
        for <linux-nfs@vger.kernel.org>; Mon, 08 Jul 2019 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5cemtBtX1hls1+MLsuRSuTCDoBbFIh1Cf7gu0TW+wAA=;
        b=mRdUDy2YawJEIVBoBodO1HH3a/w0W9iXP/2m0aQr1BYn10FxofLNqD84Xhwu0PEInt
         CO4WrvzCH1pHmt7765znPUdcGnWD83zcgbQB0C4SOoFtuK6j+kvdGPR/bQFGrLKZrEe3
         OUH7CnQkQOeRL+4X1dESTuE/MfoigLsLYKjqoJ7lA9qSjo70mebhuGAPDGbD2qvBDvR1
         MK2Zc96U+jTgdujJAZ3mVWesAB4/rn8emQ5QSmOoM4kMfTboTmbk6ks+zWoCZebYIg2B
         pQa8/H9++eSApcNFLUYaW1Kv9EccFq3TA48ROUq6UmILokqVWeOS9i7wLCiNZf/7rtyD
         Mcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5cemtBtX1hls1+MLsuRSuTCDoBbFIh1Cf7gu0TW+wAA=;
        b=mdWieFmOJi+o4o7iCGY6SaS77qSHT6aRmW7rR4XdELVBNURS+jeAJJzRvXJd6b1rrk
         i3cog13Oy38Fu//KhPTuImlDhQvpOW82ytan1AV0ZTZBxKfyIRLDcUaTdc/Zh+t1abyq
         S1nI0/Iywoa7Z7VKpQtNuXuwDr2jH79WbX/u2cAEWxlG7Mc4j8LCyzB9xO6tTGUkfkPX
         Ty8Cu1FD22GnFAbEsw/LZk/wggMeYPJB4uEGyWl6l7B06+BhzEPKpcTINdFn9Z4dYNTN
         KENG6HgIxtItAnwWaf2NGykjhiz4ITvPM1HK5H8Q89bYRlPcyEn3BdCNyig4vWh3i/kT
         6D3w==
X-Gm-Message-State: APjAAAXRzp5n2TVZUvMd825vcpexBgXkI6pDWr2zh6YxJ2NiH422Gfyi
        gLr8wpI6+KaZk2c1CTT6bDo=
X-Google-Smtp-Source: APXvYqw4sHNwsSV2XAQy1FnEUyXufAIBZB+HhUa+ebel1r6sgYKsF5ZBW5d+dvutVw4tYD+luNkPFQ==
X-Received: by 2002:a6b:da01:: with SMTP id x1mr20531336iob.216.1562613886585;
        Mon, 08 Jul 2019 12:24:46 -0700 (PDT)
Received: from Olgas-MBP-201.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id n17sm17026554iog.63.2019.07.08.12.24.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 12:24:46 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 04/12] NFS: inter ssc open
Date:   Mon,  8 Jul 2019 15:24:36 -0400
Message-Id: <20190708192444.12664-5-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
In-Reply-To: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
References: <20190708192444.12664-1-olga.kornievskaia@gmail.com>
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
index d75fea7ecf12..ff1cd600f07f 100644
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
 
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index b9825d02443e..aab4d48764a7 100644
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
@@ -282,6 +283,99 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
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
index 9bbd9bad5412..c898ce1bccc6 100644
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
@@ -1674,7 +1673,7 @@ static void nfs_state_clear_delegation(struct nfs4_state *state)
 	write_sequnlock(&state->seqlock);
 }
 
-static int update_open_stateid(struct nfs4_state *state,
+int update_open_stateid(struct nfs4_state *state,
 		const nfs4_stateid *open_stateid,
 		const nfs4_stateid *delegation,
 		fmode_t fmode)
@@ -3966,7 +3965,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 	return nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 }
 
-static int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
+int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 				struct nfs_fattr *fattr, struct nfs4_label *label,
 				struct inode *inode)
 {
-- 
2.18.1

